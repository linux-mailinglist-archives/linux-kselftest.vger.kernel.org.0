Return-Path: <linux-kselftest+bounces-33745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE50AC31DE
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 May 2025 01:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FC937AB23C
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 May 2025 23:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764461EA7E1;
	Sat, 24 May 2025 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geRwXK3l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC561459F7;
	Sat, 24 May 2025 23:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748130716; cv=none; b=D6ZcVP8jGi8Y4QBCXOwcbB9bsM4f5Cr/ppHEkOkPyMPBnueBivnH7q6iLcEJuCpe8YBk4AgL47DL1u/nD3i5m8vt+wIret119OffOqEoilAo2marYvTYZCp0TikhM2A5ysvycYrW3T/opDEeT6IIiYQujQoPWjXB2lNPUZis1tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748130716; c=relaxed/simple;
	bh=inv8KaaFc84F6JuDmwPOSqpQLRVQndyXV1UdIu5Oix4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEXSKNE5vDFeHov/mcaPM/jtKm49i+IgL/cFKosBWjCCzc4NauU6//VVPsB5/zgDnpl9/+4ST64PGs1sVI5wj4UWcmYpvmmJm10xnHxn/5bQzm/VrzTH4ZUuKvyAim7FPYtOGt49/Cukt57erQs2I+veTXJsHHzDW2A2Mu3sbic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geRwXK3l; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70cb3121db1so8722277b3.3;
        Sat, 24 May 2025 16:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748130714; x=1748735514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inv8KaaFc84F6JuDmwPOSqpQLRVQndyXV1UdIu5Oix4=;
        b=geRwXK3lgjExjga2Q4aFhXy4XFTFWe7+e2pu8ctVeUO10rlf1pUoly0SxQzbtmCj5e
         GU0GHBTLxcF/iUczg0yKVJ/ThKEjoNfowxmuFRxdNdV8OdDqztMFKUu8m1rkPPF60cu7
         4Aab7OQjjB2rr3f+Wl/k1xHDmoBJY3esMD01YdppIw0vGerRY5FDQa/CCn1ynRG3hwES
         02nqUU28FSyFVyJGUVPxSCRewk0w91z00BKS9wpCbQSaCIuUJLf8Uz0lxeVGMHXISEzp
         2AkqmsVSp3EdpagF+YRo5YSDiLxTPdS+/3rDZvO1e0H+674JJd52iJXXc4aDOA6Zg+hG
         vOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748130714; x=1748735514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=inv8KaaFc84F6JuDmwPOSqpQLRVQndyXV1UdIu5Oix4=;
        b=uz1laxPHyxjKWSNw9F4UIYC4Q5BM/MdkmRzUSsgAQy7AZG3p5zDn3oDrrP7X2eprLF
         SybnmGOW5voTo9nPOW+JS/L0wDp10KQGUAZjF7JJPVqMw7mWTwI+Yx48m8UC222nOs+b
         DpTwqnDNAe0Aj7AacVjunA3PlQOs0sZMDLLyd8iCrIA9Hp6EXbZyOBH0v8yM8rUfyTrM
         oR52c8ITwXGs+RbTH1p6WHcNks50wuzHa0Szx2XWr6P62d0Zmyws8AvxFtw9nVId3YP+
         /TlrClbINYuYTKpRmBwh56IfP2O8Ahs3Ns/dxg9MeIIL95DGYppfE58EQRfQe1Mg0WGb
         k/Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWhuT6nspqHhJXD3gx1K4TBeOE69FKFKSsgRqpSzZGUzAnyyI5PY3zvD5MwInRjtZVqnkce8ZW9hnUPhcMam9EZ@vger.kernel.org, AJvYcCXUrI14nEsvd6XehT2xV74p+i+BiWkMYRcGQTI6zXalnrL1QjGbwy0r2T8HLlLRjyVzsd7n3UcKj+Ro6Z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrwOar6Wru86pK4BKIfTm1POKpO82Iia5Q2+gBSJ4CFQudvKxC
	uvAmiy0F0dsCgs/YtRw+GeuAylla1r0jBUz/vX0BubG0Aa9B//7Ga6herYl+2Hqiw9TyFxodjLr
	G1NdDkd3pkV8oJ1IVTnIUMREFbex0HEvUmQ==
X-Gm-Gg: ASbGncuZcrSqOfisOy/KH22YiWd0g18IqwpghvPtgFdHEwqQrTiYMsnfC8J+DVlOg1R
	hpAImM/U+Ys0Dm73T401T6sErXlvF/n85eNreeU4WOqQogNd4SUGw9FCL1LimYfHcLZm61GqZnE
	tE8GBV/K/3OZQZp/qSShsA72sCIrlMonB+jet9u4FP+RXukehj1yOwHERfis/lWp9zonY=
X-Google-Smtp-Source: AGHT+IHtT+6FtZi323BKbe02Tg28onDiUmd3DdzFaN3HimawQ+poIuje0XgcyrWxHdb/qLxjJzBW5cLB9cK+ZHFYRUE=
X-Received: by 2002:a05:690c:6a0f:b0:6fd:318b:9acf with SMTP id
 00721157ae682-70e2dabf9edmr31362287b3.38.1748130713661; Sat, 24 May 2025
 16:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aC_yu6Ll2E-3qRHj@brak3r-Ubuntu> <d86594f5-c6d0-4692-b1ec-41d76f947b7e@linuxfoundation.org>
In-Reply-To: <d86594f5-c6d0-4692-b1ec-41d76f947b7e@linuxfoundation.org>
From: Rujra Bhatt <braker.noob.kernel@gmail.com>
Date: Sun, 25 May 2025 05:21:42 +0530
X-Gm-Features: AX0GCFuCN754TTjc3XI9nZ-fSJL9rV3x8ViK6rj5OfiHnmyRtmFMbWwDC1xCGDM
Message-ID: <CAG+54DajW=1cKGaHDg84RextOvB1FQtSJU8VwrWYNfuoHBigKA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: timers: valid-adjtimex: fix coding style issues
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Respected Shuah,


On Fri, May 23, 2025 at 10:38=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.=
org> wrote:
>
> On 5/22/25 21:59, Rujra Bhatt wrote:
> >
> > This patch corrects minor coding style issues to comply with the Linux =
kernel coding style:
> >
> > - Align closing parentheses to match opening ones in printf statements.
> > - Break long lines to keep them within the 100-column limit.
> >
> > These changes address warnings reported by checkpatch.pl and do not
> > affect functionality.
> >
> > changes in v2 :
> > - Resubmitted the patch with a properly formatted commit message,
> > following patch submission guidelines, as suggested by Shuah Khan.
> >
> > Signed-off-by: Rujra Bhatt <braker.noob.kernel@gmail.com>
>
> Sorry - I didn't realize these are all coding style related
> printf - I am no longer concerned about the length of print
> statements.
>
> It is too much churn with little benefit.
>

Thank you for the feedback , also understanding your perspective.
For future contributions, I will focus on more substantive changes,
unless stylistic
fixes are explicitly requested.

thank you,
regards,
Rujra Bhatt

