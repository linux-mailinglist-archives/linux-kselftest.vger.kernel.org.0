Return-Path: <linux-kselftest+bounces-13723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AA3931372
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 13:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1187DB245AC
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 11:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F97818C169;
	Mon, 15 Jul 2024 11:49:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44BA18A94D;
	Mon, 15 Jul 2024 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044160; cv=none; b=TWJVQiQT0Qcsfa+G2TLviM980CXgQXVoJAnCVuav3zuR8YO3E6TY2t5hGiwqRgDPHw7mIhxodf/B5M5Blrw9k+m3NkS2MGzO5o0ScN5kiiliPf5BN7QR0N6lRAHsqKhDbrOSRjKKO9mZODyyLZ1I0giKJwo6xJN/fjNfrCusksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044160; c=relaxed/simple;
	bh=qJmsjRPoW+mkle8LhHZWhPZerwr2E1RtVJexJlKpSzc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sHff+hDbjCpVMzVFHv6Insl++/VOoys6SP7Ki1Ug/Tg3FjwbwajLw+PTyWV8aoANF4CwDfxHBd8uZkfJyoVXQCX2rrqnJGTVKt1c18lshN6pFsR7dlMBCwiM94F7tI/kXRRQk0R5t41PKmM8yKPILrkV68Eme7JIJ04M0jkDDe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85034DA7;
	Mon, 15 Jul 2024 04:49:36 -0700 (PDT)
Received: from [10.162.42.47] (e116581.arm.com [10.162.42.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECFE03F766;
	Mon, 15 Jul 2024 04:49:06 -0700 (PDT)
Message-ID: <09370b2d-2b52-4133-8e0d-83e66b801ff8@arm.com>
Date: Mon, 15 Jul 2024 17:19:03 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dev Jain <dev.jain@arm.com>
Subject: Re: [PATCH v4 2/2] selftests: Add a test mangling with uc_sigmask
To: Oleg Nesterov <oleg@redhat.com>
Cc: shuah@kernel.org, mingo@kernel.org, tglx@linutronix.de,
 mark.rutland@arm.com, ryan.roberts@arm.com, broonie@kernel.org,
 suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
 DeepakKumar.Mishra@arm.com, aneesh.kumar@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240627035215.1527279-1-dev.jain@arm.com>
 <20240627035215.1527279-3-dev.jain@arm.com>
 <20240630151808.GA13321@redhat.com>
Content-Language: en-US
In-Reply-To: <20240630151808.GA13321@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/30/24 20:48, Oleg Nesterov wrote:
> I see nothing wrong, but perhaps this test can be simplified?
> Feel free to ignore.
>
> Say,
>
> On 06/27, Dev Jain wrote:
>> +void handler_usr(int signo, siginfo_t *info, void *uc)
>> +{
>> +	int ret;
>> +
>> +	/*
>> +	 * Break out of infinite recursion caused by raise(SIGUSR1) invoked
>> +	 * from inside the handler
>> +	 */
>> +	++cnt;
>> +	if (cnt > 1)
>> +		return;
>> +
>> +	ksft_print_msg("In handler_usr\n");
>> +
>> +	/* SEGV blocked during handler execution, delivered on return */
>> +	if (raise(SIGSEGV))
>> +		ksft_exit_fail_perror("raise");
>> +
>> +	ksft_print_msg("SEGV bypassed successfully\n");
> You could simply do sigprocmask(SIG_SETMASK, NULL, &oldset) and check if
> SIGSEGV is blocked in oldset. SIG_SETMASK has no effect if newset == NULL.
>

IMHO, isn't raising the signal, and the process not terminating, a 
stricter test? I have already included your described approach in
the last testcase; so, the test includes both ways: raising the
signal -> process not terminating, and checking blockage with sigprocmask().

