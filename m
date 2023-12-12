Return-Path: <linux-kselftest+bounces-1645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 658A780E494
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 07:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E191F21EC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 06:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA26A15AFE;
	Tue, 12 Dec 2023 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0ktkwAIO"
X-Original-To: linux-kselftest@vger.kernel.org
X-Greylist: delayed 71897 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 22:59:21 PST
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAC3BF;
	Mon, 11 Dec 2023 22:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702364359;
	bh=F41feDTLD6EeSRJQf7rvDdapR+nQMsHfWA39oKGkLZw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=0ktkwAIOn1gHRVA2zhrHIyNM2u35YJz/y5vQZFlw6eFQbWsCHcaZo3qZv8LihEq9A
	 /2yEYGNfbCpbvzn+Xbw4ZGhQMZ1X0nrOOUs8UCu79FRTAltvEmzsIuA1U81di7r9xR
	 TykJ4WuqkOCCnrLjXiVqN9fr55Vd08Y8nZ3AGT9qpv9t/m3mQU/yeYvfxeEQ7nhPdT
	 7+nBysn+06H6syKxsX5U4s7iVIXYD756YTfSXuDtnEefCci0uNFoo7XTvTynasmLvR
	 wU1sBknUJ5aeFVg3DStDQhk/rznCeo5rihTztnZ0gB7AG7wjcZeaCycHBsf1lKUncw
	 3pGxxuqMbIbEg==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A2D7E37809D0;
	Tue, 12 Dec 2023 06:59:15 +0000 (UTC)
Message-ID: <54a02895-26e5-4113-84f4-3f04358f09e6@collabora.com>
Date: Tue, 12 Dec 2023 11:59:12 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Anders Roxell <anders.roxell@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Revert "selftests: error out if kernel header files are
 not yet built"
Content-Language: en-US
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
References: <20231209020144.244759-1-jhubbard@nvidia.com>
 <0b35fcbd-ce8c-4c12-9725-01f18ade9fc0@collabora.com>
 <cf4e9f8b-7d31-44d9-93fd-1677918b56f4@nvidia.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <cf4e9f8b-7d31-44d9-93fd-1677918b56f4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/23 12:00 AM, John Hubbard wrote:
> On 12/11/23 03:00, Muhammad Usama Anjum wrote:
>> On 12/9/23 7:01 AM, John Hubbard wrote:
>>> This reverts commit 9fc96c7c19df ("selftests: error out if kernel header
>>> files are not yet built").
>> I don't think whole of this commit needs to be reverted. Lets leave the
>> warning message as it is and just remove the condition to abort the
>> compilation.
>>
> 
> Hi Muhammad!
> 
> If we do decide that "make headers" or something like it is required,
> then yes, this patch should be changed from a revert, to a "warn instead
> of failing out" patch.
I support this is as most of the times when the latest headers aren't
installed in the system. Hence the build of all those kselftests would fail
which require the recently added macros. There is no workaround to build
those tests until `make headers` is done or the latest headers are
installed. The former is easier.

If we just turn this into warning, most people reporting issues with `make
headers` would go away. They will be able to build all those kselftest
which don't require latest headers. For example mincore kselftest gets
build without KHDR_INCLUDES. In case people want to build failing tests,
they should add #ifdefs to the tests and submit patches which is idea 4.

> 
> First, though, I'd like us to choose a design direction. The patch as
> written is intended to put us on a design that does not require "make
> headers" before building the selftests, because that approach would work
> for all the cases I've seen so far.
> 
> If we want something else, then David Hildenbrand has listed several
> ideas, and I've added a 4th one to the list, in [1].
> 
> 
> [1] https://lore.kernel.org/3eadd79c-c02a-495f-92c0-0315046ef59f@nvidia.com
> 
> 
> thanks,

-- 
BR,
Muhammad Usama Anjum

