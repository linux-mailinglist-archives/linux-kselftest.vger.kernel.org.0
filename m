Return-Path: <linux-kselftest+bounces-36748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9A4AFC736
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 11:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461181BC3362
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 09:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6235D263F4E;
	Tue,  8 Jul 2025 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xecoq2Er"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3E717555
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Jul 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967587; cv=none; b=Bh0bdCS0JZnkeVqiOBeForIYBos9unr6wFMqfEGG/pOTIZ+YLkLg0gfZ25syXrCoBVbbjZlb6Ta2IYMBrmOTCuqtxh8cJGTsuxO1l67ofy/qS5XA7zb3UYe7ANDa4c+E8bTUS79tIo6QQgENZn2jaCgWzB0vM2L4WuBWrZFnIiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967587; c=relaxed/simple;
	bh=w0YOPULSSxvyU5kdaBpMpPOCESPVNkbbxq18LHihViE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfIdDX5rMxekMQoRLdl20lRaW/KL8yrXuSwR3r5J2hlJcBtbv5yo6KLD0ElB6ilbAKmEX+PecEUG2h6NmNALHZJLMQiP6Up7G6bQy96uWQRM7EHW1jsHh6Nku017tGXXT8MSo81/wouN79TBMtz0MFKGGEiG9EUuKgUK90/xvFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xecoq2Er; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso3098013f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Jul 2025 02:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751967582; x=1752572382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qVAMgZjiytlKTltSVRaWqREvVS7taIwAdxD4AMeAYLU=;
        b=Xecoq2ErBjmAYAGXuu+q/W1cz/PJD2QVwP090PJI1V2MJ+3aoM78ovIruXcmVMmhTx
         IXq5nahKH5S/qMlutsXt1hkuhfdoNiuXypDVlJ803whyQ6SrGqDDWVzkRe+9rsUbpakp
         8n6q3lhePAuk/88CBsgFEOFKLzWwQqMo0ioiY7beYlb1PCfE8t6S2k3kGuGR6st7xo4+
         vBaB91xI/lXWRDTutiomCLwhzdk0Y7/PCKDG3MwzWMikksiVeZZIXmnc4T4C6zfx66MP
         omkpn4CzmRkjOnOxhgfj7ZgQYj8/HhDRKI6Tn0zuVVWkOEEe5/rkc3Na0gyUhjUvVbj7
         ZMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751967582; x=1752572382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qVAMgZjiytlKTltSVRaWqREvVS7taIwAdxD4AMeAYLU=;
        b=Jj8nVHwBPQyBFN0TuIKp6CS2VeyeG8MBg8Su0rXQE/wDz5kXeKtBKcdTV3NbzhD6B0
         4TIkOscki3EFzOaADbZY7uE7FAgQl2olsy8BodXCGSj8lNWBFqqCn/VNK6Ndhr+Uk+bX
         63Jpt5meoHLxhJNQIePmgUZMunc3OUoc7tPIOnDtXRJEQuX8GE7pBJwKK41Rm/G1WmBC
         69BV243Gj+g2ZcAqK/9fB3vFpbdOVOeASeWehzTulqh8WVudqgQndXQ4TRnzlDpjgfnN
         6idR6LPGN236PeO+I8rQt5TMMHs9N2axYxpz5FSsjvfqiKbpSoL0lG/wsLx3W7HkjKEn
         3KTA==
X-Forwarded-Encrypted: i=1; AJvYcCWFZAf7QiLFfmIBv/QUYiXd/Y0cqg8UWvjBcfK/2bEM0Mp+m4ARUGOJCspW5gcxDhbF6lwiWWjleOV9a0pWyb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytPDyiaq2suMP3SK65deyuKEgppXDaiUeSO5ueZA9UDNeiBHgD
	0M78g6BhxMKDxURvCg3ogjBMw89gLPoxBj3NJAygRxeMVOej/6nLF0ZLMlEIj6EXJb4=
X-Gm-Gg: ASbGncvdP/Z/m4ucAQpZm1aYjkd5AJuyeTqjFFx0iLIZPasxW6pXMhRdDTi+q8sTI8z
	dNPxAgnOyRnByOgksf8RNKo9E+qyH1D2bSG5X7ARR6yGiAKBl3eg+V4+NVn8XEHkBpjg+ZVmBTr
	KbX7KtD5N5kFDPfMjLsCvvxIzYygLTpTAPwf9K6B3IRyU7J6VZ1GR2STzjT/ZLRufEwuvr8cKqu
	d8dPnPPKkRN4RzlUOdEziikjwjB1ntCaFUWiyCSGTxwPo0CLufJNiwnMTC7xqiM1+jPhOQQfJLH
	Lbm8qvUnIQjmo0TgFI45hE14T6ibieuJtDpdPt3lXiT6mqPUTV4GvChsNL0d2tH62Q==
X-Google-Smtp-Source: AGHT+IE8YM/OZ8CV631FC3za9fedEJqw2j98fUm8X6Ex7BoBBdzx8ToTsk4PmU9Yt2992ZZiuntlAg==
X-Received: by 2002:a5d:5f90:0:b0:3aa:caea:aa7f with SMTP id ffacd0b85a97d-3b497042696mr11914245f8f.56.1751967582242;
        Tue, 08 Jul 2025 02:39:42 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285c919sm12569553f8f.92.2025.07.08.02.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 02:39:42 -0700 (PDT)
Message-ID: <9e5669e5-fc7e-4297-b12f-ceb9dcf36d91@suse.com>
Date: Tue, 8 Jul 2025 11:39:41 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] module: make structure definitions always visible
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20250612-kunit-ifdef-modules-v1-0-fdccd42dcff8@linutronix.de>
 <20250612-kunit-ifdef-modules-v1-2-fdccd42dcff8@linutronix.de>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250612-kunit-ifdef-modules-v1-2-fdccd42dcff8@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 4:53 PM, Thomas Weißschuh wrote:
> To write code that works with both CONFIG_MODULES=y and CONFIG_MODULES=n
> it is convenient to use "if (IS_ENABLED(CONFIG_MODULES))" over raw #ifdef.
> The code will still fully typechecked but the unreachable parts are
> discarded by the compiler. This prevents accidental breakage when a certain
> kconfig combination was not specifically tested by the developer.
> This pattern is already supported to some extend by module.h defining
> empty stub functions if CONFIG_MODULES=n.
> However some users of module.h work on the structured defined by module.h.
> 
> Therefore these structure definitions need to be visible, too.
> 
> Many structure members are still gated by specific configuration settings.
> The assumption for those is that the code using them will be gated behind
> the same configuration setting anyways.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  include/linux/module.h | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 52f7b0487a2733c56e2531a434887e56e1bf45b2..7f783e71636542b99db3dd869a9387d14992df45 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -302,17 +302,6 @@ static typeof(name) __mod_device_table__##type##__##name		\
>  
>  struct notifier_block;
>  
> -#ifdef CONFIG_MODULES
> -
> -extern int modules_disabled; /* for sysctl */
> -/* Get/put a kernel symbol (calls must be symmetric) */
> -void *__symbol_get(const char *symbol);
> -void *__symbol_get_gpl(const char *symbol);
> -#define symbol_get(x)	({ \
> -	static const char __notrim[] \
> -		__used __section(".no_trim_symbol") = __stringify(x); \
> -	(typeof(&x))(__symbol_get(__stringify(x))); })
> -
>  enum module_state {
>  	MODULE_STATE_LIVE,	/* Normal state. */
>  	MODULE_STATE_COMING,	/* Full formed, running module_init. */
> @@ -598,6 +587,18 @@ struct module {
>  	struct _ddebug_info dyndbg_info;
>  #endif
>  } ____cacheline_aligned __randomize_layout;
> +
> +#ifdef CONFIG_MODULES
> +
> +extern int modules_disabled; /* for sysctl */
> +/* Get/put a kernel symbol (calls must be symmetric) */
> +void *__symbol_get(const char *symbol);
> +void *__symbol_get_gpl(const char *symbol);
> +#define symbol_get(x)	({ \
> +	static const char __notrim[] \
> +		__used __section(".no_trim_symbol") = __stringify(x); \
> +	(typeof(&x))(__symbol_get(__stringify(x))); })
> +
>  #ifndef MODULE_ARCH_INIT
>  #define MODULE_ARCH_INIT {}
>  #endif
> 

Nit: I suggest keeping MODULE_ARCH_INIT in its current position,
immediately after the 'struct module' declaration, because the macro is
directly tied to that structure.

-- 
Thanks,
Petr

