Return-Path: <linux-kselftest+bounces-2034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0941D8149D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 14:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B275B1F213B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 13:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71A92E65C;
	Fri, 15 Dec 2023 13:58:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59D02E40A
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 352BDC15;
	Fri, 15 Dec 2023 05:59:34 -0800 (PST)
Received: from [10.57.76.37] (unknown [10.57.76.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DC223F5A1;
	Fri, 15 Dec 2023 05:58:47 -0800 (PST)
Message-ID: <71228821-cbd3-4a3c-9ed5-18f6d5ebcfc0@arm.com>
Date: Fri, 15 Dec 2023 13:58:45 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/mm: Log run_vmtests.sh results in TAP format
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Peter Xu <peterx@redhat.com>, Aishwarya TCV <Aishwarya.TCV@arm.com>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20231214162434.3580009-1-ryan.roberts@arm.com>
 <e2296501-e9c9-4bc6-88ba-1e43ea083d4a@sirena.org.uk>
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <e2296501-e9c9-4bc6-88ba-1e43ea083d4a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/12/2023 13:54, Mark Brown wrote:
> On Thu, Dec 14, 2023 at 04:24:34PM +0000, Ryan Roberts wrote:
>> When running tests on a CI system (e.g. LAVA) it is useful to output
>> test results in TAP format so that the CI can parse the fine-grained
>> results to show regressions. Many of the mm selftest binaries already
>> output using the TAP format. And the kselftests runner
>> (run_kselftest.sh) also uses the format. CI systems such as LAVA can
>> already handle nested TAP reports. However, with the mm selftests we
>> have 3 levels of nesting (run_kselftest.sh -> run_vmtests.sh ->
>> individual test binaries) and the middle level did not previously
>> support TAP, which breaks the parser.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

Thanks!

> 
>> Let's fix that by teaching run_vmtests.sh to output using the TAP
>> format. Ideally this would be opt-in via a command line argument to
>> avoid the possibility of breaking anyone's existing scripts that might
>> scrape the output. However, it is not possible to pass arguments to
>> tests invoked via run_kselftest.sh. So I've implemented an opt-out
>> option (-n), which will revert to the existing output format.
> 
> What I did for ftrace which had a similar situation was make a wrapper
> script which invokes the test runner, make the test runner a
> TEST_PROGS_EXTENDED so it's not run by the kselftest infrastructure
> automatically and make the wrapper a normal TEST_PROGS.  Neither option
> is especially lovely.

Yeah that's a good idea... I'll wait and see if anyone shouts that this has
broken something. If nothing is broken, I think it is better to just make TAP
the default rather than adding yet another wrapper.

