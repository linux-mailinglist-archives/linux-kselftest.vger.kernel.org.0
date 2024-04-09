Return-Path: <linux-kselftest+bounces-7481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EA389D8C2
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 14:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F8E2831D7
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 12:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9900D12CD81;
	Tue,  9 Apr 2024 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UNuLPP5S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CyTwhFEo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F1512D1E7;
	Tue,  9 Apr 2024 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664167; cv=none; b=MmWC0fVy9J5N2cRPJj/6uIKJ1nkRdLtX0T1IJ9Yi3ifbsX6WfkXhgI+9F2/tW8a2+Hfot+TzGRRhyDM/wHpZBy3coPHGnlR/H6Dy1/iU/VzBBUfZCpHaV7bjc2ETFaQfHkpPGs5Eqc6b9EapzXDMG3CrjCnabVrIhXZq8czOimI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664167; c=relaxed/simple;
	bh=OSEZ/IJn1fMBgDMHSVQYwhSOUU5+Mc8UTTRDuJvngM4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dqyOC+uAkIi3h3gS1E9PULA32TutDirJoe4NNMQwKe3zbW4pMYzl6BDUPFCA3YB2pf7xeMHdT3co+Saq55lACmBVA6Noy1qBm3G8PqSFRjEuQ7LRCay2L0/U18x4KKiAmj7Q3sCJxrznvdqsGkBOIc9gDJ4Ju7uxpWhr5fH7hHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UNuLPP5S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CyTwhFEo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712664161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8NoF74+Dpoxqa48kWnxI0CEBaofoHHeQ96U8jZayGGY=;
	b=UNuLPP5SrIkQee7qfz1ZyYRNb3d2WR3QPojM6WUZB3XqsvAeRsfziV+c6gfUoWCLTAc6j5
	cb8UB5Ju1TSnxx+mDDxo8//mRkDg3Ou+HjilxSksmg4SUyhCkGADdMa4Ia63ZPLhZ0CJ5e
	60KCV3dcBKnDFSMb5ltGzZvZp2T6gYlhdGYQpbJikI2fpbCere63+gMUjQ7iYB+nb6gfy/
	Zi2cIzneMdqEgV0lV7YuxJ6Dqbn0g+ofkSddir1skWrWdfIDEtN10oDojrqJpJ94hiVzQH
	I6NGXeZtQzeMMbJC24agR34DgADXUD/yECpAE7ewmxx1ucJPdq13qlKmPAZ0hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712664161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8NoF74+Dpoxqa48kWnxI0CEBaofoHHeQ96U8jZayGGY=;
	b=CyTwhFEoeUdjhwP0bMFPIs9b+VK/snwqfq0q92W1RQ3TQBS8Nl3h9TRGLDVxlui91hbbnU
	TzjvW8K/YGS/vPBQ==
To: Oleg Nesterov <oleg@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, John Stultz <jstultz@google.com>,
 Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, "Eric W. Biederman"
 <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, Edward Liaw
 <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] selftests/timers/posix_timers: reimplement
 check_timer_distribution()
In-Reply-To: <20240409111051.GB29396@redhat.com>
References: <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx> <20240404145408.GD7153@redhat.com>
 <87le5t9f14.ffs@tglx> <20240406150950.GA3060@redhat.com>
 <20240406151057.GB3060@redhat.com>
 <CACT4Y+Ych4+pdpcTk=yWYUOJcceL5RYoE_B9djX_pwrgOcGmFA@mail.gmail.com>
 <20240408102639.GA25058@redhat.com> <20240408184957.GD25058@redhat.com>
 <87il0r7b4k.ffs@tglx> <20240409111051.GB29396@redhat.com>
Date: Tue, 09 Apr 2024 14:02:40 +0200
Message-ID: <877ch67nhb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 09 2024 at 13:10, Oleg Nesterov wrote:
> On 04/09, Thomas Gleixner wrote:
> It seems that this is because in your tree check_timer_distribution() does
>
> 	if (timer_delete(id)) {
> 		ksft_perror("Can't delete timer");
> 		return 0;
> 	}
>
> while in Linus's tree it returns -1 if timer_delete()
> fails. Nevermind.

Ooops.

>> +static bool check_kernel_version(unsigned int min_major, unsigned int min_minor)
>> +{
>> +	unsigned int major, minor;
>> +	struct utsname info;
>> +
>> +	uname(&info);
>> +	if (sscanf(info.release, "%u.%u.", &major, &minor) != 2)
>> +		ksft_exit_fail();
>> +	return major > min_major || (major == min_major && minor >= min_minor);
>> +}
>
> this looks useful regardless. Perhaps it should be moved into
> tools/testing/selftests/kselftest.h as ksft_ck_kernel_version() ?

Makes sense.

>> +static int check_timer_distribution(void)
>> +{
>> +	const char *errmsg;
>> +
>> +	if (!check_kernel_version(6, 3)) {
>> +		ksft_test_result_skip("check signal distribution (old kernel)\n");
>>  		return 0;
>
> ..
>
>> +	ksft_test_result(!ctd_failed, "check signal distribution\n");
>
> Perhaps
>
> 	if (!ctd_failed)
> 		ksft_test_result_pass("check signal distribution\n");
> 	else if (check_kernel_version(6, 3))
> 		ksft_test_result_fail("check signal distribution\n");
> 	else
> 		ksft_test_result_skip("check signal distribution (old kernel)\n");
>
> makes more sense?
>
> This way it can be used on the older kernels with bcb7ee79029d backported.

Indeed.

