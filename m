Return-Path: <linux-kselftest+bounces-12499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F81913441
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 15:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B031A284A80
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jun 2024 13:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8909216F0FE;
	Sat, 22 Jun 2024 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTY7OC1C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8651E14D6EE;
	Sat, 22 Jun 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719064064; cv=none; b=De8r4bqfQxy8MoE7zr/+8w8aySIRaYY5zlyEvwt0FP8a4WKYxLqNid64Bucarl6tl4HHN9hIrvScHaHbVY9AmH5ZDj94foQnbyjib+YQzSB+AZ3R69r3OUrLu00jOyNW3VmBBMfUurTsZKc/0Wsl5CkOHdOnilCqJBdm4DDqzmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719064064; c=relaxed/simple;
	bh=s58+WXTPKUxQQp7M6mqTfc8CNEirwEPL/XeRNbil2Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGVgwUmUdOoTDQusKK4HDdImDHjlUou3g7ZnBPIMOgNpbzZS7uvd0af3vOm/kgxPHbENF2F/qHAVcB8W0hb0ekWBCwp7ylFR5soWFfLI/G21O19O44ya7oUtBcSn3gyZjr0gdkM0Ye8c0G1KhvfPG0zAdr/ixtpvXJyyfj99qDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTY7OC1C; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7eec09cc7f6so115872939f.0;
        Sat, 22 Jun 2024 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719064061; x=1719668861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohspEI3o4kejsF4uHtq93ZO3T1O8uAizbgOfutjyYx0=;
        b=DTY7OC1C+EYJZ5SVB2fa5G3Z9Fbg96OErzp1JbhzSrsB8RmHwOWCGrsMZ62wGf9LB7
         Z+TVmrxchr55wSXdlJ4sYbDVW4jeoT95K1KIc8RiZG9mkmu6vOW6VXwA8A7kV5YF4yVo
         Fe6Av1Y+W1wThms1o0NK0zfb/7vcXA8T3iyIGNErkkdqspd6+YSuQrF06SuxBC12f+jI
         Zqt9+L1t8waS5rkJo94Z5aL8fsKJcSGp0sdomnWwwfMw0exlqEKtUFQZyeyyzqiNDvA9
         WjFopEHSQyVmU5X4QahbW2IK8H71Rq09hFz132j7BtRUY+kXKM8cfFcwI9H0NxhAhBUS
         l8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719064061; x=1719668861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohspEI3o4kejsF4uHtq93ZO3T1O8uAizbgOfutjyYx0=;
        b=rl3UGmWB1rfYHraz3EeqxyFbThar+M0alwCHH5900Bu/HuFydlSdkQqwU3h2tKfQsr
         sJLjTXmtRK6QrtEXVRNT219O01++nWxuh3hvGERAEQrIzx5F+kqjdz3C9fnAtnpLgWSA
         13MSEANhZvNR4IJ5qXUHbBh8Y+roKNDOg/dQkrrI2A7ta4TdPqJazDYoQybQStJ6ZEit
         FlAj3PiTHjbP7y90VHgTGBVtSUg/IKinoOxvtOiq/H19nIzxO5zRywIg3p0GiCpLwTFD
         wUJZ5kD0PtCI7UY8WLZ+LXiJgemITUk+MQu09klgeCI13gnQnNzyPoN94uCTWxEV81dZ
         flJw==
X-Forwarded-Encrypted: i=1; AJvYcCWhvLt0vS4t8oyw8igfknuYaGbW7bey5NZobVt1WJ/T3HyndcNq/M+8htmQ7vfjMkJNREd2Q1GJ0sXAYpIdStTyMkRP74CaKaWGnRh+U0w7OUZIjII9vzdPSqoUIKn7U7r6OM8TTtlRPD1tvNSyf1NlbYA9mLeIVuqE/iIIbR8h+Mf7R7RXCVjlYXbuLvE0
X-Gm-Message-State: AOJu0YyJSl8l6KhAhas1Gcd20M9f6nV1lMa2ct9opjHAbXEnhLVfWl5C
	iaxMHi4TgxPYzBGzQmAd2dftl2AkP60JmDxZ1yH9vl6t8FbDKnqz
X-Google-Smtp-Source: AGHT+IH4uWoLEo6kKHTWJi/1CLEGx6QFTJt0e4D+3Pjq7hTY4ZPl7W5p1qFvi7fKwiHIqfl3kIcMFQ==
X-Received: by 2002:a05:6602:6d83:b0:7eb:b025:648d with SMTP id ca18e2360f4ac-7f3a13eb9camr99502539f.10.1719064061444;
        Sat, 22 Jun 2024 06:47:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651085a5bsm3088880b3a.44.2024.06.22.06.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 06:47:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 22 Jun 2024 06:47:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kees Cook <kees@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, David Gow <davidgow@google.com>,
	Vitor Massaru Iha <vitor@massaru.org>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kunit: test: Add vm_mmap() allocation resource
 manager
Message-ID: <d32df98c-fd3c-466b-bc8f-47cec1c7bebf@roeck-us.net>
References: <20240612195412.make.760-kees@kernel.org>
 <20240612195921.2685842-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612195921.2685842-1-kees@kernel.org>

Hi,

On Wed, Jun 12, 2024 at 12:59:18PM -0700, Kees Cook wrote:
> For tests that need to allocate using vm_mmap() (e.g. usercopy and
> execve), provide the interface to have the allocation tracked by KUnit
> itself. This requires bringing up a placeholder userspace mm.
> 
> This combines my earlier attempt at this with Mark Rutland's version[1].
> 
> Normally alloc_mm() and arch_pick_mmap_layout() aren't exported for
> modules, so export these only for KUnit testing.
> 
> Link: https://lore.kernel.org/lkml/20230321122514.1743889-2-mark.rutland@arm.com/ [1]

FWIW, not sure I understand what the above link has to do with this patch.

> Co-developed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Kees Cook <kees@kernel.org>

This patch results in a build failure for nommu_kc705_defconfig if kunit tests
are also enabled.

ERROR: modpost: vmlinux: local symbol 'arch_pick_mmap_layout' was exported

If CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT=n, CONFIG_MMU=n, and
CONFIG_KUNIT=y, arch_pick_mmap_layout is exported. However, if
CONFIG_MMU=n, it is declared as static inline function.

Guenter

---
bisect log:

# bad: [b992b79ca8bc336fa8e2c80990b5af80ed8f36fd] Add linux-next specific files for 20240620
# good: [6ba59ff4227927d3a8530fc2973b80e94b54d58f] Linux 6.10-rc4
git bisect start 'HEAD' 'v6.10-rc4'
# good: [c02e717c5a89654b244fec58bb5cda32770966b5] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good c02e717c5a89654b244fec58bb5cda32770966b5
# good: [29e7d78253b7ebf4b76fcf6d95e227d0b0c57dc0] Merge branch 'msm-next' of https://gitlab.freedesktop.org/drm/msm.git
git bisect good 29e7d78253b7ebf4b76fcf6d95e227d0b0c57dc0
# good: [bf8fd0d956bfcbf4fd6ff063366374c4bf87d806] Merge branch 'non-rcu/next' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
git bisect good bf8fd0d956bfcbf4fd6ff063366374c4bf87d806
# good: [1110f16317b1e0742521eaef5613eb1eb17f55ca] Merge branch 'icc-next' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git
git bisect good 1110f16317b1e0742521eaef5613eb1eb17f55ca
# good: [63f3716198e5644713748d83e6a6df3b4a6a3b10] Merge branch 'gpio/for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
git bisect good 63f3716198e5644713748d83e6a6df3b4a6a3b10
# bad: [91b48d9adafddb242264ba19c0bae6e23f71b18a] Merge branch 'kunit' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
git bisect bad 91b48d9adafddb242264ba19c0bae6e23f71b18a
# good: [9b401f4a7170125365160c9af267a41ff6b39001] pinctrl: ti: ti-iodelay: fix possible memory leak when pinctrl_enable() fails
git bisect good 9b401f4a7170125365160c9af267a41ff6b39001
# good: [1963f932d368f18185466979cc0bc89414d798e7] Merge branch 'pwm/for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git
git bisect good 1963f932d368f18185466979cc0bc89414d798e7
# good: [f91869accbe23a2bb08712b7262fa61eab716d42] selftests/resctrl: Simplify bandwidth report type handling
git bisect good f91869accbe23a2bb08712b7262fa61eab716d42
# good: [cbf284291604e818424f45dbdf6a8a705b5480ad] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
git bisect good cbf284291604e818424f45dbdf6a8a705b5480ad
# good: [a5217468214c228b89da37291de604cd756914ab] kunit: add missing MODULE_DESCRIPTION() macros to core modules
git bisect good a5217468214c228b89da37291de604cd756914ab
# bad: [51104c19d8570eb23208e08eac0e9ae09ced1c15] kunit: test: Add vm_mmap() allocation resource manager
git bisect bad 51104c19d8570eb23208e08eac0e9ae09ced1c15
# good: [425ae3ab5a1fa744a00680f059cf1accaaaecb28] list: test: add the missing MODULE_DESCRIPTION() macro
git bisect good 425ae3ab5a1fa744a00680f059cf1accaaaecb28
# first bad commit: [51104c19d8570eb23208e08eac0e9ae09ced1c15] kunit: test: Add vm_mmap() allocation resource manager

