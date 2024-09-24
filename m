Return-Path: <linux-kselftest+bounces-18332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7187984F38
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 01:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2484B1C230DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 23:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9254A189BA7;
	Tue, 24 Sep 2024 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C1s8JMVQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64BF186E57
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222378; cv=none; b=XFx06KevEr93+09iw+to+Aj4jdphGYeWF0JaENepEGixU5XNITAGcKtMzSsXDZWVGJ0D1clYTA271xwdyFYwLscrp+NGmjUhhfMJkd32X7KkUlyawQbDsOrRXoqGRHGHicrWDARwAM1fDm0eeB1Pg+Gp6zLY5LpZZ7s6GpcnzF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222378; c=relaxed/simple;
	bh=NPBhGsZGXeHhMhqBrOs0lKj/hQr4Of+6SHrSbODGWf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WsMfV/gS9x3rRatNE4ejDvZMDssZTzAU44WsytSvEyhkUjCcEBXj01oB9ea8m1RqKAQ6w1jcR1JOMiUyT1FFGn6XN10d39qDcUV/O8AFZWmEgEbTBSiE4SGr4h+Oj07JHnsJeuMDRcD9aqXqP9GcvAdcgtUAnWB6ZLbRxTLrrXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C1s8JMVQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c5b9d2195eso4668598a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Sep 2024 16:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727222375; x=1727827175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kI/ysPTxQWzKUDDa2gWjdjf1UvW+7XakeF8GyEGFOL4=;
        b=C1s8JMVQK72Or/DSqyLJddljAAr1GPC6xpU4g8GQH/zuuTw+Uq1U/eIevT0wvc8bnk
         CnPH1pzbq8lNTEQn09jeX1oOwydIX6kHmQkF2/Bret20o2Qf2ylxjJryk4GRCgfCvaL/
         USsz5xUSIkRUIDnLV9HwohaOM09bNWGy1Trtooh6tmrVkk5/fLoGz5OXxkbOy2DhpFLs
         H3C4gPzmg9THz/thIC7obNyinBGQ4hKMgwA4d1NceBGAR4Z46JErp0keHP/FMBVsRr8a
         oi5ld/RnpkgbXM9ATBYvVU3ep3o5jjeXOPBSIxyAWBdvc3jzjNC/+AcVchpCZ0p984e2
         D/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727222375; x=1727827175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kI/ysPTxQWzKUDDa2gWjdjf1UvW+7XakeF8GyEGFOL4=;
        b=CsScbG/v5En2sH9r5c7o6qYiF8REOxcrVUIuZivsUyffLfaNSQWDwL8vkwBM3ne1E+
         LKCV/crp1b2AfZffHEZRrNFPXGXDhdbiHCYVMcnf44ft1L4C4AmAD+hkImCNMHrcs4es
         nNogxKXJWc8/slzGfPJ0XF8r7DtUxFl/uOmPMhbd2wrQo1FEQg+SgLAmJIv+1PpJDd3W
         0mVL8kuK3ASnkxL+nfQRh0MnYU97Hj33W0H9QswIBoiwWzunw5EFAjbMsiuP/WqaAlRR
         xeDL1HLB+tqIqMTtwFoj8VFyEKOoD8Qrwa7ZeEplWN2yObk2jbOVG9hrYLRmEhAmWSeI
         9Ekw==
X-Forwarded-Encrypted: i=1; AJvYcCUTFeKuYepvZStILoIM10B9QeyMB/6hzdw5PVvMYj+8EfOK2DYwCcIuR3InZcb2Y43U47gkNRWfFdVHAW6FjYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YytbRhYXyQBWJmCv/GAkVlytut9kFSevbVa6OLf8vh2cTalLmIA
	sZ4tktkyy+yf/BdkSIuuaDmZ0TKnfR1gP2Hq2TyagJBg+toH+rtxA0DcyIf7DIeMpbKlEdQBD8+
	O4QCraWJNksDfSTv2rhngq7k9yfnDG7jqwvo=
X-Google-Smtp-Source: AGHT+IEFAG3wub9OvDEOs3FiLz5OFqv+WsMgtvScIRg52xRzRH+AwJSsf6BAU1gkGTOMfniTFrgvm8bolZPFDbB+GIQ=
X-Received: by 2002:a17:907:7d9f:b0:a77:b01b:f949 with SMTP id
 a640c23a62f3a-a93a03e3726mr75990466b.35.1727222374772; Tue, 24 Sep 2024
 16:59:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727191485.git.skhan@linuxfoundation.org> <f797bc704d8eb03234a3447c77fa7b704339f89a.1727191485.git.skhan@linuxfoundation.org>
In-Reply-To: <f797bc704d8eb03234a3447c77fa7b704339f89a.1727191485.git.skhan@linuxfoundation.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 24 Sep 2024 16:59:22 -0700
Message-ID: <CANDhNCpsEQL+S8gadXMjvbE-6r8c6owzz+_DhN6JAVqQ8Hg=_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: timers: Remove local NSEC_PER_SEC and
 USEC_PER_SEC defines
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: tglx@linutronix.de, sboyd@kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 8:57=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> Remove local NSEC_PER_SEC and USEC_PER_SEC defines. Pick them up from
> include/vdso/time64.h. This requires -I $(top_srcdir) to the timers
> Makefile to include the include/vdso/time64.h.
>
> posix_timers test names the defines NSECS_PER_SEC and USECS_PER_SEC.
> Include the include/vdso/time64.h and change NSECS_PER_SEC and
> USECS_PER_SEC references to NSEC_PER_SEC and USEC_PER_SEC respectively.

Nit: You got the last bit switched there. This patch changes local
NSEC_PER_SEC to the upstream defined NSECS_PER_SEC.

Overall no objection from me. I've always pushed to have the tests be
mostly self-contained so they can be built outside of the kernel
source, but at this point the current kselftest.h dependencies means
it already takes some work, so this isn't introducing an undue
hardship.

Other then the nit,
  Acked-by: John Stultz <jstultz@google.com>

> diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/sel=
ftests/timers/adjtick.c
> index 205b76a4abb4..cb9a30f54662 100644
> --- a/tools/testing/selftests/timers/adjtick.c
> +++ b/tools/testing/selftests/timers/adjtick.c
> @@ -22,14 +22,12 @@
>  #include <sys/time.h>
>  #include <sys/timex.h>
>  #include <time.h>
> +#include <include/vdso/time64.h>
>
>  #include "../kselftest.h"
>
>  #define CLOCK_MONOTONIC_RAW    4

I suspect CLOCK_MONOTONIC_RAW (and the other clockid definitions)
could be similarly removed here as well in a future patch?

thanks
-john

