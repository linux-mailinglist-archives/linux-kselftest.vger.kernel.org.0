Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBB7E0CAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2019 21:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbfJVTjz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Oct 2019 15:39:55 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17879 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbfJVTjz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Oct 2019 15:39:55 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5daf5b0f0000>; Tue, 22 Oct 2019 12:39:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 22 Oct 2019 12:39:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 22 Oct 2019 12:39:54 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Oct
 2019 19:39:54 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Oct
 2019 19:39:54 +0000
Subject: Re: [PATCH 1/1] mm/gup_benchmark: fix MAP_HUGETLB case
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
References: <20191021212435.398153-1-jhubbard@nvidia.com>
 <20191021212435.398153-2-jhubbard@nvidia.com>
 <20191022171452.GA5169@redhat.com>
 <1095fd94-1c0b-de61-7ceb-c963e29575b6@nvidia.com>
 <20191022185701.GD5169@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <8892a2be-029b-f8c5-d984-8ff3b5c490ed@nvidia.com>
Date:   Tue, 22 Oct 2019 12:39:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191022185701.GD5169@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571773200; bh=jrcZHAK9zVkbPgVj696iaVt9GqABGaAKpUMnJt5s7Tc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=NmTjl+M7BdHBbGWaUdezIvlms4YyVw8Z70Zje1eNrvVSe5N+sv1MAp4JtDh8EifNZ
         Vm482atmstuayF8bjbl4efoOzjH5oTbIgwVdy8p0/789BbfVyztasVhg8SKkZnchII
         AxhlPdr8PVKrQW+Bxnlr2ttP+eXEyVHcLbrjxrQz6+LToszk0OuHPVAxRb4p2d8FO3
         Sb0p5RPEY7+o6HbIdgz7esc3wsEZZXejRS8+tbTqQwW9pdx7EYMErcHhKrsuCYTook
         hzIl4sse2U0rqWoBdkh/4aptwS2nqS6QOcnl11DtgRZkclTmDa/lpuiIVYFtSU0Kv6
         RdDm6WCYhFlSA==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/22/19 11:57 AM, Jerome Glisse wrote:
> On Tue, Oct 22, 2019 at 11:41:57AM -0700, John Hubbard wrote:
>> On 10/22/19 10:14 AM, Jerome Glisse wrote:
>>> On Mon, Oct 21, 2019 at 02:24:35PM -0700, John Hubbard wrote:
>>>> The MAP_HUGETLB ("-H" option) of gup_benchmark fails:
>> ...
> So i was misslead by the file descriptor, passing a file descriptor and
> asking for anonymous always bugs me. But yeah the _linux_ kernel is happy
> to ignore the file argument if you set the anonymous flag. I guess the
> rules of passing -1 for fd when anonymous is just engrave in my brain.
>=20

Yeah, I definitely get that. In fact, I initially considered further changi=
ng=20
the test code so as to pass -1 for fd in this case, but because it's pure=20
Linux-only test code, it didn't really seem worth the (small) additional
change.

> Also i thought that the file was an argument of the test and thus that
> for huge you needed to pass a hugetlbfs' file.
>=20
> Anyway my mistake, you are right, you can pass a file and ask for anonymo=
us
> and hugetlb at the same time.
>=20
> Reviewed-by: J=E9r=F4me Glisse <jglisse@redhat.com>
>=20

Thanks for the review!=20

Admin note: this already went into mmotm, so I'm hoping Andrew will notice =
this
email and add the Reviewed-by tag, please?

thanks,

John Hubbard
NVIDIA
