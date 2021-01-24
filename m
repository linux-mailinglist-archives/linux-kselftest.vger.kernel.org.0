Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D6D301F98
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Jan 2021 00:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbhAXXlR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Jan 2021 18:41:17 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:14642 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbhAXXlR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Jan 2021 18:41:17 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B600e05730000>; Sun, 24 Jan 2021 15:40:35 -0800
Received: from [10.2.52.243] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 24 Jan
 2021 23:40:29 +0000
Subject: Re: [PATCH v7 14/14] selftests/vm: test faulting in kernel, and
 verify pinnable pages
From:   John Hubbard <jhubbard@nvidia.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, <vbabka@suse.cz>, <mhocko@suse.com>,
        <david@redhat.com>, <osalvador@suse.de>,
        <dan.j.williams@intel.com>, <sashal@kernel.org>,
        <tyhicks@linux.microsoft.com>, <iamjoonsoo.kim@lge.com>,
        <mike.kravetz@oracle.com>, <rostedt@goodmis.org>,
        <mingo@redhat.com>, <jgg@ziepe.ca>, <peterz@infradead.org>,
        <mgorman@suse.de>, <willy@infradead.org>, <rientjes@google.com>,
        <linux-doc@vger.kernel.org>, <ira.weiny@intel.com>,
        <linux-kselftest@vger.kernel.org>
References: <20210122033748.924330-1-pasha.tatashin@soleen.com>
 <20210122033748.924330-15-pasha.tatashin@soleen.com>
 <532b1927-1b5d-83e8-f1f9-50cd5e72435f@nvidia.com>
Message-ID: <27b83f2b-19ae-ca9c-3bf4-4c975610c9de@nvidia.com>
Date:   Sun, 24 Jan 2021 15:40:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <532b1927-1b5d-83e8-f1f9-50cd5e72435f@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611531635; bh=XQkygBxScpEBU48fVqAKT3kv/XOnxlp9Av6ePwDWzF0=;
        h=Subject:From:To:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=JpsR9osUItkg8YBRzflqVwZXgcV5gn47CeJtsDWvz/KtkQDh51LykLqWxLoVfbbQM
         WSQPfeju4Hk2GzTi6nHT7Q20M1YcpnWAwCetFuDjM/GUZHiMrnZ5umMw8+f+j0mcRq
         lyQjEEp1UgTircf4W3OPAD6WiUgWEc6u16pMruHQqZ1UBg05KVpQoks1FvJJDmGZXI
         bo/URk/s0d/bNjtMPzRQwAc/Net7ZmMRiFEhT/X0idQ85xYfjvvV9LzHc33L3QaCVw
         WeQrTkGNeN5brJ94iVbwgWiX0VnyDkqikqtTNiILcXXkRGe1xCmPNry/FQBJwXPj5V
         Oh41PMqIUCe/A==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/24/21 3:18 PM, John Hubbard wrote:
> On 1/21/21 7:37 PM, Pavel Tatashin wrote:
>> When pages are pinned they can be faulted in userland and migrated, and
>> they can be faulted right in kernel without migration.
>>
>> In either case, the pinned pages must end-up being pinnable (not movable=
).
>>
>> Add a new test to gup_test, to help verify that the gup/pup
>> (get_user_pages() / pin_user_pages()) behavior with respect to pinnable
>> and movable pages is reasonable and correct. Specifically, provide a
>> way to:
>>
>> 1) Verify that only "pinnable" pages are pinned. This is checked
>> automatically for you.
>>
>> 2) Verify that gup/pup performance is reasonable. This requires
>> comparing benchmarks between doing gup/pup on pages that have been
>> pre-faulted in from user space, vs. doing gup/pup on pages that are not
>> faulted in until gup/pup time (via FOLL_TOUCH). This decision is
>> controlled with the new -z command line option.
>>
>> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>> ---
>> =C2=A0 mm/gup_test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++++
>> =C2=A0 tools/testing/selftests/vm/gup_test.c | 23 +++++++++++++++++++---=
-
>> =C2=A0 2 files changed, 25 insertions(+), 4 deletions(-)
>>
>=20
> This also looks good. I do see the WARN_ON_ONCE firing in
> internal_get_user_pages_fast(), when running with *only* the new -z
> option.
>=20
> I'll poke around the rest of the patchset and see if that is expected
> and normal, but either way the test code itself looks correct and seems

The warning that is firing in internal_get_user_pages_fast() is:

	if (WARN_ON_ONCE(gup_flags & ~(FOLL_WRITE | FOLL_LONGTERM |
				       FOLL_FORCE | FOLL_PIN | FOLL_GET |
				       FOLL_FAST_ONLY)))
		return -EINVAL;

...OK, so this is because "./gup_test -z" invokes get_user_pages_fast(),
which so far does not allow passing in FOLL_TOUCH. Probably because there
is nothing "fast" about touching and possibly faulting in pages. :)

So, again, the test code still looks correct, even though it's possible
to pass in options that run into things that are rejected by gup.c



thanks,
--=20
John Hubbard
NVIDIA
