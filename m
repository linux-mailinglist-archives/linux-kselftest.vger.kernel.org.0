Return-Path: <linux-kselftest+bounces-28370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6E4A542CF
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 07:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2B716BCC4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 06:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F373C19D090;
	Thu,  6 Mar 2025 06:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="cGqsCgJ0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BA419882F;
	Thu,  6 Mar 2025 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741242691; cv=none; b=KTXlsfAq3NFu3yk0TT1knsTtaQ/01y+VFDlV/Ip1//tOmyzNfWWL1BcA0tbzwoxwUJLTtkSTfE05rRfr7eNSdhQmTWsy59/W9swyj2ngVpi9yiPpk2SiR2FR0dxTWDopuxlsbQioBBXgQwil7grqHes4LdkMEf1iCzHD8CK/Nb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741242691; c=relaxed/simple;
	bh=ru0yOM3azaebE5Y1U1SpcUqyVYne8Lt/4X1VvUoX//c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMKkPCn8sJD1wdvuYTOLoRoph/SGuEuZcTV/D/zyIWrWM42zH50JSbuqdyRWXd0hkuk7kuGLDMCfUFWUE4/ZXYOmWmSWqBD0eqbKAKEIm56NvRtl8GCT32254GgC/JVFRUzwen5aG8ij80jjZZJdjZKbOtbE6DkJ6snjvS+lieE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=cGqsCgJ0; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Message-ID: <f3bde84d-b53e-4b81-b995-3b81d614b789@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1741242686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bblUkYK5rTVes/OOwKXM7H10R1JrlrPcUhP5Wq4e/a4=;
	b=cGqsCgJ05RfBl8CUHOvSxMvx0U4R/sCtc1iKSgkqKMnU3rRPu7bKNSBxMf27yiTAmAL0ll
	BXHMH9QeIZEnpKdBieyhWzOgdDigRbRj4p6+Uddozp9Gfz7PrlQV4SVEtULETnw2b5k39W
	kVMUcADcB1l5sgDny6PMFFZEMCAl6HoURzD1W5YOxrQYuqnndzs96u/Z9iu7aDYXYwCczc
	r/uAiZ4ssjiMHJhP27jjIpyRZzP2xo+KYWm4ebGYZcI495r51Teq9xBl+mowyOLRsziGdL
	yT2l4g3ZFf9PxWELid/G3tbQZfgNMWelyLLXFPHfNJs3p49WYyy8mnzTqPmjyg==
Date: Thu, 6 Mar 2025 07:31:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests: riscv: fix v_exec_initval_nolibc.c
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250305-fix-v_exec_initval_nolibc-v1-1-b87b60e43002@iencinas.com>
 <Z8jG1ViOUbw79cEN@ghost>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
Autocrypt: addr=ignacio@iencinas.com; keydata=
 xjMEZgaZEBYJKwYBBAHaRw8BAQdAYZxeXU5yoeLYkQpvN+eE3wmAF4V0JUzIlpm/DqiSeBnN
 LElnbmFjaW8gRW5jaW5hcyBSdWJpbyA8aWduYWNpb0BpZW5jaW5hcy5jb20+wo8EExYIADcW
 IQSXV5vKYfM26lUMmYnH3J3Ka8TsNgUCZgaZEAUJBaOagAIbAwQLCQgHBRUICQoLBRYCAwEA
 AAoJEMfcncprxOw21F4BAJe+mYh3sIdSvydyDdDXLFqtVkzrFB8PVNSU9eZpvM0mAP9996LA
 N0gyY7Obnc3y59r9jOElOn/5fz5mOEU3nE5lCc44BGYGmRESCisGAQQBl1UBBQEBB0CVC5o6
 qnsTzmmtKY1UWa/GJE53dV/3UPJpZu42p/F0OAMBCAfCfgQYFggAJhYhBJdXm8ph8zbqVQyZ
 icfcncprxOw2BQJmBpkRBQkFo5qAAhsMAAoJEMfcncprxOw2N8ABAPcrkHouJPn2N8HcsL4S
 SVgqxNLVOpsMX9kAYgIMqM0WAQCA40v0iYH1q7QHa2IfgkrBzX2ZLdXdwoxfUr8EY5vtAg==
In-Reply-To: <Z8jG1ViOUbw79cEN@ghost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/3/25 22:49, Charlie Jenkins wrote:
> On Wed, Mar 05, 2025 at 05:39:28PM +0100, Ignacio Encinas wrote:
>> Vector registers are zero initialized by the kernel. Stop accepting
>> "all ones" as a clean value.
>>
>> Note that this was not working as expected given that
>> 	value == 0xff
>> can be assumed to be always false by the compiler as value's range is
>> [-128, 127]. Both GCC (-Wtype-limits) and clang
>> (-Wtautological-constant-out-of-range-compare) warn about this.
> 
> This check was included because the "dirty" value is an implementation
> detail that I believe is not strongly defined in the ABI. Since linux
> does always set this value to zero (currently) we can safely remove this
> check. 

Thanks for the review. Just after sending the patch I noticed it should
also remove some code that becomes useless after this change: 
_prev_value_ and _first_ variables were only needed because two "clean" 
values were supported.

I'll send a v2 tomorrow. I'm guessing keeping your "Reviewed-by" and
"Tested-by" is the appropriate thing to do as the changes are very
simple. Let me know if that's not the case.

Thanks again!

