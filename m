Return-Path: <linux-kselftest+bounces-2036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8CC814A79
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16954284FBE
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4025B3173E;
	Fri, 15 Dec 2023 14:28:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805183172E
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E751CC15;
	Fri, 15 Dec 2023 06:29:19 -0800 (PST)
Received: from [10.57.76.37] (unknown [10.57.76.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B82363F5A1;
	Fri, 15 Dec 2023 06:28:33 -0800 (PST)
Message-ID: <76abe3b9-3f66-4336-b09d-d5c137ff6582@arm.com>
Date: Fri, 15 Dec 2023 14:28:32 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/mm: Log run_vmtests.sh results in TAP format
Content-Language: en-GB
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Peter Xu <peterx@redhat.com>, Aishwarya TCV <Aishwarya.TCV@arm.com>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20231214162434.3580009-1-ryan.roberts@arm.com>
 <e2296501-e9c9-4bc6-88ba-1e43ea083d4a@sirena.org.uk>
 <71228821-cbd3-4a3c-9ed5-18f6d5ebcfc0@arm.com>
 <07193932-941d-46f6-b152-d6c5fe09b26b@sirena.org.uk>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <07193932-941d-46f6-b152-d6c5fe09b26b@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/12/2023 14:08, Mark Brown wrote:
> On Fri, Dec 15, 2023 at 01:58:45PM +0000, Ryan Roberts wrote:
>> On 15/12/2023 13:54, Mark Brown wrote:
> 
>>> What I did for ftrace which had a similar situation was make a wrapper
>>> script which invokes the test runner, make the test runner a
>>> TEST_PROGS_EXTENDED so it's not run by the kselftest infrastructure
>>> automatically and make the wrapper a normal TEST_PROGS.  Neither option
>>> is especially lovely.
> 
>> Yeah that's a good idea... I'll wait and see if anyone shouts that this has
>> broken something. If nothing is broken, I think it is better to just make TAP
>> the default rather than adding yet another wrapper.
> 
> I think it depends a bit how ergonomic the non-TAP output is for
> interactive use - TAP isn't amazing for humans so if there's something
> that's nicer it probably makes sense to keep that as the default.  For
> these tests I'm not sure it's particularly an issue.

I've kept all the existing "pretty" output and results summary as is, it just
gets a hash in front of it when TAP is enabled.

so this:

-----------------------
running ./hugepage-mmap
-----------------------
Returned address is 0xffff89e00000
First hex is 0
First hex is 3020100
[PASS]
SUMMARY: PASS=1 SKIP=0 FAIL=0

becomes this:

TAP version 13
# -----------------------
# running ./hugepage-mmap
# -----------------------
# Returned address is 0xffff89e00000
# First hex is 0
# First hex is 3020100
# [PASS]
ok 1 hugepage-mmap
# SUMMARY: PASS=1 SKIP=0 FAIL=0
1..1

If you think the latter is ofensive, then I can do the wrapping as you suggest.

