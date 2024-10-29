Return-Path: <linux-kselftest+bounces-20897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141109B42CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 08:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E954F283756
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 07:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E5E2022C3;
	Tue, 29 Oct 2024 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="asdMjP+d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFEC200BB7
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730185665; cv=none; b=ohE3MawJUyCamP8F6mzFPJP5lIouePU7z7LO1TKRWQucO/6qhK54Qrpy2lwEExIkMNEnm/KZB2c+0JquKb9sv01s69AbJt6VUbUvdwmiZkGIPTQIClW9cQhqrj/maJO6KDGRoiA1tE1kA5pueqmNyRWY0iWP9waqSIYYM3Divuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730185665; c=relaxed/simple;
	bh=EEb+kKGLMFTOed/ZJekAfz4fNoruU/EOrzZUzGH7rZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XmVViwOa/to5QJ/Iw1s9KmXW7tcAOx32O+7jaMyl80cWpfFSPCPB6AprZyFKKOmdJg8vNdTs4l6o6lrOrnOKuqwizvBVJZIHQNHcXyJjdBr5sTbCBlOrA94IgKbQHA+Pl4VdLznntZwCqIE12LGkcuBrdsbwPY/JFw06/9OkFRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=asdMjP+d; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72061bfec2dso2416566b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 00:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730185663; x=1730790463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3LwOkK51J1qKg7fZLWgkyiHN2F87OIJYv8lDQl9A1I8=;
        b=asdMjP+dxKsqiOAqSXQytCI1lwhha4x/fwA+QdAer/nigo7K4YXd91TA3kO3/xicq5
         HBxH10SQAEVKzmtHKp3ZDBYsPlC1ERPe04mQfRTC8nUwELmBBeS7WoMvIjF0cyk7ltD9
         GmTsuSReAjEQArLg74A6gea472qQOU/8F0njc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730185663; x=1730790463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LwOkK51J1qKg7fZLWgkyiHN2F87OIJYv8lDQl9A1I8=;
        b=jVI2vbR/tDq0KT2CxFpVI7WIxXc6mNVmxRdNjfw5rmCS1t2VkiQYQFPM8c/ZrE7NO0
         cih0orZvtAd0YSKjAqShVpOayzkJ/ixQU0dWlFVES8GSjVYt/yCM1A5VHMlNAM4W/0P/
         Jf90ORHXfXr7EQGJyWA7XgfvKrc+UktKbIVioBh9h0tqQIyHY+OQbHGX5oHLgUZnWHvs
         QOeTqokrriQAT260JTytu9LDRGPbEuIylnevfSOGzvbCUL/u0sJCWhAH0TJrFckW4sc5
         uzyLBOtXPDcRDK7D/xmfpbu8J1Pr4JLGzC7oJRmVqlrgXK0APlxNjrcUJUibVi1bCzQk
         +Fuw==
X-Forwarded-Encrypted: i=1; AJvYcCVs1AVo0A8yOCjLD0bReM9X7Dps1ZUxighiM3A29mO/VR42n6s2zsOVpgL9KrIiK5G/IPSt5iQYMFERjAH9wRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5DYphyViqtKClPw9iWMjDf33+QdbowwJqmYVJN4ompi/1Qoke
	2kID+vjiUSE3ruYg0lR7P9ptuY6T6GiYtLqeq2h2tOOn2guaxkXA9jTiDaz99Kg=
X-Google-Smtp-Source: AGHT+IH7Om6t65rTWfQdOHHI8ZyNaY/R8b922xoiQkPeSHDzDTyzsZ8P6Smuo6x7KpBAAmFGZPaO/Q==
X-Received: by 2002:a05:6a00:1747:b0:71e:f83:5c00 with SMTP id d2e1a72fcca58-72062f6121cmr16513115b3a.2.1730185662633;
        Tue, 29 Oct 2024 00:07:42 -0700 (PDT)
Received: from [10.200.3.216] (fs96f9c361.tkyc007.ap.nuro.jp. [150.249.195.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8a4780esm6919837a12.86.2024.10.29.00.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 00:07:42 -0700 (PDT)
Message-ID: <cfa882bf-a8dd-4b0a-98ea-4551a10df466@linuxfoundation.org>
Date: Tue, 29 Oct 2024 01:07:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] [PATCH v6 0/2] Add test to distinguish between thread's
 signal mask and ucontext_t
To: Dev Jain <dev.jain@arm.com>, shuah@kernel.org, oleg@redhat.com
Cc: mingo@kernel.org, tglx@linutronix.de, bp@alien8.de,
 dave.hansen@linux.intel.com, mark.rutland@arm.com, ryan.roberts@arm.com,
 broonie@kernel.org, suzuki.poulose@arm.com, Anshuman.Khandual@arm.com,
 DeepakKumar.Mishra@arm.com, aneesh.kumar@kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 sj@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241009051424.333380-1-dev.jain@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241009051424.333380-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 23:14, Dev Jain wrote:
> This patch series is motivated by the following observation:
> 
> Raise a signal, jump to signal handler. The ucontext_t structure dumped
> by kernel to userspace has a uc_sigmask field having the mask of blocked
> signals. If you run a fresh minimalistic program doing this, this field
> is empty, even if you block some signals while registering the handler
> with sigaction().
> 
> Here is what the man-pages have to say:
> 
> sigaction(2): "sa_mask specifies a mask of signals which should be blocked
> (i.e., added to the signal mask of the thread in which the signal handler
> is invoked) during execution of the signal handler. In addition, the
> signal which triggered the handler will be blocked, unless the SA_NODEFER
> flag is used."
> 
> signal(7): Under "Execution of signal handlers", (1.3) implies:
> 
> "The thread's current signal mask is accessible via the ucontext_t
> object that is pointed to by the third argument of the signal handler."
> 
> But, (1.4) states:
> 
> "Any signals specified in act->sa_mask when registering the handler with
> sigprocmask(2) are added to the thread's signal mask.  The signal being
> delivered is also added to the signal mask, unless SA_NODEFER was
> specified when registering the handler.  These signals are thus blocked
> while the handler executes."
> 
> There clearly is no distinction being made in the man pages between
> "Thread's signal mask" and ucontext_t; this logically should imply
> that a signal blocked by populating struct sigaction should be visible
> in ucontext_t.
> 
> Here is what the kernel code does (for Aarch64):
> 
> do_signal() -> handle_signal() -> sigmask_to_save(), which returns
> &current->blocked, is passed to setup_rt_frame() -> setup_sigframe() ->
> __copy_to_user(). Hence, &current->blocked is copied to ucontext_t
> exposed to userspace. Returning back to handle_signal(),
> signal_setup_done() -> signal_delivered() -> sigorsets() and
> set_current_blocked() are responsible for using information from
> struct ksignal ksig, which was populated through the sigaction()
> system call in kernel/signal.c:
> copy_from_user(&new_sa.sa, act, sizeof(new_sa.sa)),
> to update &current->blocked; hence, the set of blocked signals for the
> current thread is updated AFTER the kernel dumps ucontext_t to
> userspace.
> 
> Assuming that the above is indeed the intended behaviour, because it
> semantically makes sense, since the signals blocked using sigaction()
> remain blocked only till the execution of the handler, and not in the
> context present before jumping to the handler (but nothing can be
> confirmed from the man-pages), the series introduces a test for
> mangling with uc_sigmask. I will send a separate series to fix the
> man-pages.
> 
> The proposed selftest has been tested out on Aarch32, Aarch64 and x86_64.
> 
> v5->v6:
>   - Drop renaming of sas.c
>   - Include the explanation from the cover letter in the changelog
>     for the second patch

These two patches have been languishing for sometime - hence I applied these
two patches to linux-kselftest next for Linux 6.13-rc1

thanks,
-- Shuah


