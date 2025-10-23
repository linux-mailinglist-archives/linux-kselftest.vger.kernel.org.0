Return-Path: <linux-kselftest+bounces-43888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D06AC01F96
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 17:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DAFDF349F1E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 15:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E6726059D;
	Thu, 23 Oct 2025 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiAvMPQJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D71D5AD4
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231911; cv=none; b=uzJTdb5hid+5V5b5M9oNPlJUWwRayLnY0I1+KftR608IFzJTPhssYwzJSAmhTGZSWjiXPoymSFMrkc+xoFmpRjKogFfYD9fvAjKs1bX6cFvnf3rhBGU9zOi4zzEcBa6EBY5ZTv10n8wwRbWpXhmrwPDaH66DjLG/SA710ZGvRtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231911; c=relaxed/simple;
	bh=GHxA3c0yV6CEoBK6kR7057V7T1cFgVLHP2eCafXealQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHXIDwutPi2TdXUBPRYIDEx6WXk2bUR87qZDF9yQbm0JPZI4tVc1AmoBTKtscJskW+rbWIdacMa75gEjwjLhuzx1YEWx5BvOwH9p2HwaZ06nfuKOMl37MkyUbX6dIHuGK8GPICH6/fg/kERr26/lUPI4fWITtH8tqhxOHWkf2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiAvMPQJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so1430340a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 08:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231908; x=1761836708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0g9O1UAQmliCyOFgls7R54UMarfOxqkSzanB1NMWGZc=;
        b=jiAvMPQJuR7LDPLTyiHpc2m4iCktUFwOmKaf1gcPTzWBXLzeT1hWBoBvhnogi3PpuO
         vr3sEEL0ky2AxUJjwXz+auFWXWEYaO1OEPtPPpLYakO1F1PIoQF7+jTcV3HDN5xrDpA8
         rlxGUeI2XdGi12tkGy5CA8Tz03zWq40HgUvpBLR8+iicShvlfEeXg/+DLUIHHF7AALod
         gpx7s3Cs0Gcpui0+gsj3ouObBfsZdsLypTxjbMJ9habdB4/mgiusY+b2x6YIekT1lKAj
         C1kJTgcW6g7qY2ty75nRKBuWDdOFSS21Wr0dO7DjKaddr5w+JYd/hsItOYO+Ed2Tp2h/
         uGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231908; x=1761836708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0g9O1UAQmliCyOFgls7R54UMarfOxqkSzanB1NMWGZc=;
        b=jfMv/B0ghDLdOhu845uZbGCyiR2HvWC9bbzOjZVDB24viCxHI6TXFBdF77DmoRKiKo
         2JM3eyzcozJfqdLSMfyxajI+eu+01zLs3mn6vbgMwnawG7ak3sEyl9B3Kqb/It0wJ+8w
         9Y+3Qjf2hUu9Ca/cU40ahM/o1oXD6ywjJxu4r4boys3CEHdR9nuv7vVWryNzq2BIxPGs
         iGGHJl0V3XK4FU2Kq+leGBdVosz01543KLqTTJkz6rOx49o27wH5g670Aeh32ZCZifon
         m4anmaexVuvm4Se73pLRsRI4MrH8XoRFFeZ8eID5yzR+TX0t5v57YaB91npUy1lWphQo
         o9PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK9F923cd+FF6iNDGcaj1b4LO75Qw/EoIgVIt1gNWBF7TQmGBDWaxbk+kKdkeV3FtFslvmfr6buPULVi7UD2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxslTjCgtaSjNnKNI75PjdJwdjMGcp4hOVhdC0kqh4qh1TpNuDg
	EmQoIGCYQ2dkCiPD93yuwSvxoz/jlQB4ON71x24/rGXEXxgptKf/oN66jPxEppfSOqD75lHMgaL
	ugF2DAY2UP2MsHlcq9hVXa58vMbAOG9c=
X-Gm-Gg: ASbGncuaqfURwpKpiWkCnT1bLbJWe+opilRImYAQa+4mVhqjGu5l6b1MhEqr4n5pvA3
	GPL85KXRN3ROGUbYfYw5Ls1WY/SzxiqkYKWC+4jYFRR4Hn3VDppQa2Lm0DvbBJREtbvv6GovNF5
	nguISrGAnoinKAYlDTkk03bSV3LG/vl/vBnI6cZledkPRiZY9cNd1wbDwb7DFcWdMLlQc47mz+t
	eftk04WhqY4PfM3/XLw1WfMRolCv09vS8Cia1/+/CrMje/vga5kl4tP68z2eeC1bbdoQ5N50514
	t6zlfMJuyRTZmG1MxctOzfxLjpfkUQ==
X-Google-Smtp-Source: AGHT+IHB8B5L3u8WbMDNbmjmms33DeNsuKSJCMufZx22juNs/gndSdpSi8DIUT2dxhoELBY0BdEhQ4H+/Q41jUC1tb8=
X-Received: by 2002:a05:6402:1810:b0:634:4d7a:4d94 with SMTP id
 4fb4d7f45d1cf-63c1f6d9335mr18957800a12.34.1761231907807; Thu, 23 Oct 2025
 08:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929115405.25695-2-sidharthseela@gmail.com>
 <486e0d6b-799e-4fec-9e6d-3ddfdd64418c@arm.com> <cb30af9e-c22b-485a-a83c-f395880cd799@linuxfoundation.org>
In-Reply-To: <cb30af9e-c22b-485a-a83c-f395880cd799@linuxfoundation.org>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Thu, 23 Oct 2025 20:34:55 +0530
X-Gm-Features: AS18NWA765vw_3LiOpRHjjahBitbX6N7WFYKyQWJzAW1GbNsAm0JUy1d7Tv4rWQ
Message-ID: <CAJE-K+D6ODXnMtS+pbQ-GpyTy8PLyycqK19P_EgnZzKbKwoOog@mail.gmail.com>
Subject: Re: [PATCH v1] selftests: cachestat: Fix warning on declaration under label
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Dev Jain <dev.jain@arm.com>, nphamcs@gmail.com, hannes@cmpxchg.org, 
	nathan@kernel.org, shuah@kernel.org, morbo@google.com, justinstitt@google.com, 
	nick.desaulniers+lkml@gmail.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Make sure to not use "---" in your commit logs. Everything after
> this line gets thrown away. I had to go fix it manually.
Sorry, I will make sure that doesn't happen again.

-- 
Thanks,
Sidharth Seela

