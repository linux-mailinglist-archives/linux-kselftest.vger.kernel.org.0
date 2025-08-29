Return-Path: <linux-kselftest+bounces-40348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0D6B3C566
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 00:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322B17BE026
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 22:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F292FFDC7;
	Fri, 29 Aug 2025 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJjZrCdt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203562D6E6D
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507938; cv=none; b=syWaUhbPg5Qh9QhE/1VrcMo38JdxtwqqwKcrUElNBZC10HPBXWA6KlEYBoaFRUVCYIeMpfwNLlepz0dr5BfPIuYP0kgdtu7DCD/gEuxfGFKZuc2CwxQAxkkmieXBPa4B4Cjx3sPimnRXkq8jVWbKrX1rWHi3+VNVGh94rPjW3pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507938; c=relaxed/simple;
	bh=ojwcBl6rtg+6eqPfYuMD6prSTB6az/0FEjPvz1Tm9Kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aJIi66YeE6XkLDuz/gdNvT1JLWpWa5AH8NBlde4/EXA25lVPr2U1fKQcBaTxvDr4GRBMP5nVAvug9gkScmFbMZAFsB6Vn4Tg/VR3fJO6eYrfFqTWhRmcJ0F/NuCkqDxQCmyx+oRBcKHYlPR+llbXUTBdkfJz5Xwfn8f2U/n2Lis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wJjZrCdt; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4d48818a04so836675a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 15:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756507936; x=1757112736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hdTF7iMYwxPeRfeCg813VVngacX28QeHmpqDAe9jeLk=;
        b=wJjZrCdtvt6xKrXvVv+wXmTdVCl5qmVGqyolGluxsFja/VdIDkYpo57wzGpL5O823K
         z9UhmDoAAJ04GL9dd0yUzUqaSY1wKfc4qSnqgXacNvqizcVJQkWp9V+mQtlQa9Za7Mfa
         bqTDd75RXrx3ImT7WxHdyz08QKg0rSFT6AcaCJTsHuJKkrhBG8nHEnWrCrjx3UVJyeGO
         oPiluMMnt4E3mgy/kRJr2z+MHK4XwuTQO6JJPqiGMYmdGrqJoQOgFS8kcAGncjYZEgX0
         n++RJXj5fpmosACdnyYmMctjfgQcgwFDPALQ63NeAfPNkVr7Fc71u4udMSVm9CnZ0aks
         dp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756507936; x=1757112736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdTF7iMYwxPeRfeCg813VVngacX28QeHmpqDAe9jeLk=;
        b=WWw5HApeXdvKUTXOJYe1opKF27+T6/kAaYPT5/DFLPMwJ1rgBnILhjiKKdQxXImbWc
         F5ztDqaS2919LfTDTuxAeTZi647OtxpZQUNnKJmpxhOOrcUBOAIwg+feyjwYV7cv5Tdf
         rRlo6c25VfPjQyOmNIpDk5KtlGv2n5xtzSbUOFENSVtGDjADtfiqCHCsG0YnPaYUKtEs
         3mTB1sqIWV7tTQMfhGWQEuQlHJxeOdXlXx+nWoXvtbaplfi26oIBP2fm6mnDaNHbrAsF
         1gNDN6RTu3BXMkJpmY/WtwdT0prEwVJYK3T28L3vl5cV57uLaFDX6Qs1jFeLyc/BGxd6
         Wq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyN8/ZVeyl9mC4JmWxiw/C7MbFQ+t7HYIXShrHtFgW3kz52mqWmi3h4vbcJ7KqEuh/9kCSpbI6IemL9SQIwAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh6IW44JFOS080e7W4Li50YVe7EGTOEpJVaH2M/zF2dIfJHbxc
	qwuXK37h/NpMMp3pC5eXtB8RIyR4hyQcg1V8r4BnQiDYfbthFVezI4cALqB61+krtO7QZI9Rio3
	iF4Uw5A==
X-Google-Smtp-Source: AGHT+IGqGPzqRupaCDD94OvlRTyG4r6PPoBy1Hyx3kC9aFfjsgUlx9M9dFuidWWIK6RZB0lbxzY8RnfYgL4=
X-Received: from pgct9.prod.google.com ([2002:a05:6a02:5289:b0:b49:d928:2b07])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3ca3:b0:243:b06a:3d57
 with SMTP id adf61e73a8af0-243d6dd4daamr411430637.7.1756507936524; Fri, 29
 Aug 2025 15:52:16 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:52:15 -0700
In-Reply-To: <20250829142556.72577-2-aqibaf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829142556.72577-1-aqibaf@amazon.com> <20250829142556.72577-2-aqibaf@amazon.com>
Message-ID: <aLIvH06e1XDFz9lh@google.com>
Subject: Re: [PATCH 1/9] KVM: selftests: Add pidfd_open syscall number fallback
From: Sean Christopherson <seanjc@google.com>
To: Aqib Faruqui <aqibaf@amazon.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com
Content-Type: text/plain; charset="us-ascii"

Subject says KVM, but I don't see anything KVM related in here.  I don't think
any of the KVM selftests even use pidfd_open() directly.

On Fri, Aug 29, 2025, Aqib Faruqui wrote:
> The kselftest-harness uses pidfd_open() for test timeout handling, but
> non-glibc C library headers may not define this syscall number.
> 
> Add architecture-specific fallback definitions to pidfd.h, including
> support for Alpha (544) and other architectures (434). Update
> kselftest_harness.h to include pidfd.h for the syscall definitions.

This should probably be split into two patches:

  selftests: harness: Include pidfd.h to get syscall definitions from tools/

and

  selftests/pidfd: Add architecture-specific fallback definitions for pidfd_open

as there are two distinct changes here.  And kselftest_harness.h also tends to be
a finicky little bugger, isolating changes to that file is almost always a good
idea, no matter how trivial they might seem.

> Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
> ---
>  tools/testing/selftests/kselftest_harness.h | 1 +
>  tools/testing/selftests/pidfd/pidfd.h       | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 2925e47db..1dd3e5a1b 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -69,6 +69,7 @@
>  #include <unistd.h>
>  
>  #include "kselftest.h"
> +#include "pidfd/pidfd.h"
>  
>  #define TEST_TIMEOUT_DEFAULT 30
>  
> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> index f87993def..c373ff18e 100644
> --- a/tools/testing/selftests/pidfd/pidfd.h
> +++ b/tools/testing/selftests/pidfd/pidfd.h
> @@ -45,8 +45,12 @@
>  #endif
>  
>  #ifndef __NR_pidfd_open
> +#ifdef __alpha__
> +#define __NR_pidfd_open 544
> +#else
>  #define __NR_pidfd_open 434
>  #endif
> +#endif
>  
>  #ifndef __NR_pidfd_send_signal
>  #define __NR_pidfd_send_signal 424
> -- 
> 2.47.3
> 

