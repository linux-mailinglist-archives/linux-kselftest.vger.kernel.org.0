Return-Path: <linux-kselftest+bounces-36495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7C9AF85CA
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 04:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305875473BE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 02:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025871DBB13;
	Fri,  4 Jul 2025 02:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lYZKoGAj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847931FC3;
	Fri,  4 Jul 2025 02:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751597640; cv=none; b=GRFKp+jwcBbiKpFFkuUudueW6TnM7o3+ikyLA3/C5zm8iNfRKQ5z/XUpuMo9mjLjKxW8E1S575NQrVQ2780a7sYOjxiKSwO3u2YRJcIO7/YdJ9J4g95TPDHwscu/Un20CmbW1hM42z0/kcOjJXu2qxD9xqpEMRrqvjbIrJCH91M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751597640; c=relaxed/simple;
	bh=THX26/jXeFAoW2ksOlvzrvGU5g863BgeG42sCpCIRd0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NmD4G5RY56UvAW17uQH7zQmMIqCv2nLnbW9LJ1l80DOktKYz1k1KhfaQD0OdIyhCbZhVGQTQMwKDJVEd+Qr4z9JdwLaS9xf+1nCTCjxh/Sp2Q7ldlScUccicGL476xM3CGd28ncvgeLtB39NXlFd65h570l47CJT3kM3Zj4l9hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lYZKoGAj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=yZ+/4POeJ+yHT/+h9d2KsWJy9/hmIi0Y9xqqcxUt7NA=; b=lYZKoGAjIA8YcYimrooC4eIto6
	yak5x8tiy/5dKOdmpBS560TOTQWUHdLKm83CAe0U5xkYVlEBdOpL9R3QjQpLMNdPeg0VwTnNeuAmT
	BCLEUwnSwDAmoKySqQf3lta43duK9cv3NePg1QHC+4ykyte5HJ/0KnPEff9Hbcdc3vI6MYa74minu
	xRE+8vUNZ0Uj+RvFXEHxP5xnkS5A5rhElxQ1YeeNLo90tfvQrPSfogHv7pH+xX/35L3hBr7ysIAnP
	SuHrc4U6/njOEDycTiduitUhudaHmb6khWMKIvVdjtlv1RPpHbhVE6zp0mVAkK2ZSrPRVPKDLWSGd
	lNG2sh7A==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXWYj-0000000FKfH-3ZeZ;
	Fri, 04 Jul 2025 02:53:54 +0000
Message-ID: <2cc85345-3350-494d-beea-0fc568d162a7@infradead.org>
Date: Thu, 3 Jul 2025 19:53:47 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kunit: fix longest symbol length test
From: Randy Dunlap <rdunlap@infradead.org>
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>
Cc: rust-for-linux@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>,
 David Laight <david.laight.linux@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>, x86@kernel.org,
 linux-kbuild@vger.kernel.org
References: <20250514192416.12635-1-sergio.collado@gmail.com>
 <30b8e7c2-3a70-4728-b633-b24c99a8d025@infradead.org>
Content-Language: en-US
In-Reply-To: <30b8e7c2-3a70-4728-b633-b24c99a8d025@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/14/25 2:00 PM, Randy Dunlap wrote:
> 
> 
> On 5/14/25 12:24 PM, Sergio González Collado wrote:
>> The kunit test that checks the longests symbol length [1], has triggered
>> warnings in some pilelines when symbol prefixes are used [2][3]. The test
>> will to depend on !PREFIX_SYMBOLS and !CFI_CLANG as sujested in [4] and
>> on !GCOV_KERNEL.
>>
>> [1] https://lore.kernel.org/rust-for-linux/CABVgOSm=5Q0fM6neBhxSbOUHBgNzmwf2V22vsYC10YRBT=kN1g@mail.gmail.com/T/#t
>> [2] https://lore.kernel.org/all/20250328112156.2614513-1-arnd@kernel.org/T/#u
>> [3] https://lore.kernel.org/rust-for-linux/bbd03b37-c4d9-4a92-9be2-75aaf8c19815@infradead.org/T/#t
>> [4] https://lore.kernel.org/linux-kselftest/20250427200916.GA1661412@ax162/T/#t
>>
>> Reviewed-by: Rae Moar <rmoar@google.com>
>> Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
> 
> 
> Works for me. Thanks.
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> 
>> ---
>> v2 -> v3: added dependency on !GCOV_KERNEL (to avoid __gcov_ prefix)
>> ---
>> v1 -> v2: added dependency on !CFI_CLANG as suggested in [3], removed
>> 	CONFIG_ prefix
>> ---
>>  lib/Kconfig.debug                | 1 +
>>  lib/tests/longest_symbol_kunit.c | 3 +--
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index f9051ab610d5..e55c761eae20 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -2886,6 +2886,7 @@ config FORTIFY_KUNIT_TEST
>>  config LONGEST_SYM_KUNIT_TEST
>>  	tristate "Test the longest symbol possible" if !KUNIT_ALL_TESTS
>>  	depends on KUNIT && KPROBES
>> +	depends on !PREFIX_SYMBOLS && !CFI_CLANG && !GCOV_KERNEL
>>  	default KUNIT_ALL_TESTS
>>  	help
>>  	  Tests the longest symbol possible
>> diff --git a/lib/tests/longest_symbol_kunit.c b/lib/tests/longest_symbol_kunit.c
>> index e3c28ff1807f..9b4de3050ba7 100644
>> --- a/lib/tests/longest_symbol_kunit.c
>> +++ b/lib/tests/longest_symbol_kunit.c
>> @@ -3,8 +3,7 @@
>>   * Test the longest symbol length. Execute with:
>>   *  ./tools/testing/kunit/kunit.py run longest-symbol
>>   *  --arch=x86_64 --kconfig_add CONFIG_KPROBES=y --kconfig_add CONFIG_MODULES=y
>> - *  --kconfig_add CONFIG_RETPOLINE=n --kconfig_add CONFIG_CFI_CLANG=n
>> - *  --kconfig_add CONFIG_MITIGATION_RETPOLINE=n
>> + *  --kconfig_add CONFIG_CPU_MITIGATIONS=n --kconfig_add CONFIG_GCOV_KERNEL=n
>>   */
>>  
>>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>
>> base-commit: 1a80a098c606b285fb0a13aa992af4f86da1ff06
> 

Hi,

I'm still seeing this issue in linux-next 20250703.

Any merge plans for this patch?

Thanks.
-- 
~Randy


