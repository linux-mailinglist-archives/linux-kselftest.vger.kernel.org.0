Return-Path: <linux-kselftest+bounces-24643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60269A13A52
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 14:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47651889F5C
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 13:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748EF1D90AE;
	Thu, 16 Jan 2025 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSek0pWF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54751DE8A8;
	Thu, 16 Jan 2025 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737032430; cv=none; b=cm6rb5uE/IoyNeEfoHmTtpkDPSMzPl9O0qt5urMFAlAgo/bRZ6r0ooYqwgMdO/CEyVzK3HF9Ayo/9XVDdNI8zxwUvcTOy5TjWTV0Irjzb8T7JfPApQsDuAbhrfu8t6ChOfgqHGOplV04NW8w/jasi8DrlFOH2rkTgBipVH4DMYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737032430; c=relaxed/simple;
	bh=5UMbsUR3uezYmQkND+aHznqfBtOMq7AAaSselEbiyO4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sAeYEoHhYG9alPfLOesvLaYnvPJD1qLM/meyFtaMRK/adlG3GRb807pEh/F2izuzjlq6TIFhe+8Uw+eEJ/k7p9N872dQ//DwmRYFBE3boykZOUC3ZbMoTD8Yr4obby5nBcuOHe+2s01K/iuHYCU1bgSQS1ObvbuO8BUFMxFYojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSek0pWF; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dccccd429eso9353606d6.3;
        Thu, 16 Jan 2025 05:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737032426; x=1737637226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDAPDENh5j906Y6hu4L3U4UaJRAPYR+j5H8J3pj7FYA=;
        b=gSek0pWFkEfaTr016Dq1ujsSUja4isxB39o5jWFN6j1cvNbDMyagmK9HcBwrg2eUpf
         GC5Vc+iHLJRAMg6vdoNjVyMXqakUzvNo+Ez6lZO4QhTdG7XbnEekgSqgogvHRrfa7qxt
         TbDWUvoxppd+W0sXVSw/WToCnEyD9ugSsI2TbE9m3ZBX5lc9VxV98oTtK+IHFsM5k3Mg
         26PUBQVhT0Izq5juB46W4ZWiTebPvv+67sZYqifOSNlDe+keOmDppHgLeVE43jGOHEMX
         4rGJmKV/F9rXMmI2H2Eed8uWflGp1iU4Kbns5bKj9Wd85fTULcuoXW+NDK7Q30H9OutZ
         4ihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737032426; x=1737637226;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jDAPDENh5j906Y6hu4L3U4UaJRAPYR+j5H8J3pj7FYA=;
        b=FxQka/YC+veYbEBwGwnfCqOZk/DTcbNxt0RIO+q+G2rxqJ5h48dowPvDPEMc18JxCW
         amV1gZ3Uxtn9xLqbQPRbXpxUcPm+29xZJcfhDmLMXRAp3/rQybCjz2A2E+QK/WV04WzB
         p+YBGIr1PfXgpfdVAbbj+hlBta626HMNJAD/8otVCnatQhKq/DLXYf8jByY2POZ2x8+E
         1+iFZ35J29FdF1CtxZxKyweFoMz4jFoWeMb5IMwbyqEr/fp2buPipDDftKOYStuM9Prh
         LcYNqTK88YiZfr/xNruqErTpQTqusQNYLx1IUyZuATJ04MZ4/lT88Q7Ykx/ekIFtFOTn
         davg==
X-Forwarded-Encrypted: i=1; AJvYcCU648T0rYKJWgZbL7MNRsBGm74YKb2Ae/SYa5chCratXwVGbYYqfsmEH8YOkyCR/QuDRtCoGTSa49wFYSXEo3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwKRMZ8hIFjNyHzeJnjzxGxPa5rcpo9xhiU4OEaD/GcFnBYZrC
	SkCQvtWARrRd+ElwVm1SA1u3zSwBWkGyTFT9mXcpr+PbZPXcN8lD
X-Gm-Gg: ASbGncuGCh5AP2zQiJgC701UBMtFFZOnYoWT0a0RFdHISk523Bxq0n+JuyHRPWVsK/E
	jRoyrlztCiyhtVV085wsJAq4W6MMacsUApfUCCXTzS2qneoJWb9Fr/J7ENdiiOkNrjdX5SqBbLs
	tFafV0yPbo+1lSX7llFRCHiiA43D87MSWAoEg1cY6G6P2WpiSuNmgu1NGV6m6Wh4x3H8hCBY6nl
	ErzJkj+B7yCm1kK3NVCc0F0Oi1ZW3JJjrP6cN5bezyDuK1QBIKvg0MDS8nu9UAc6Ud8STgd7JmB
	JsuRHkB3wEjIrqum8fLo8o3vchBW
X-Google-Smtp-Source: AGHT+IEqZd3YsXVTaJNqnc8P4/zUTq4aoOBXPiUTSi9FbqN1NFo0pmvC7/XQPrTVzPToXMZLDOx0Ag==
X-Received: by 2002:a05:6214:19c5:b0:6d8:8256:41d4 with SMTP id 6a1803df08f44-6df9b1f00c4mr578711256d6.19.1737032426489;
        Thu, 16 Jan 2025 05:00:26 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad8add1bsm76930666d6.49.2025.01.16.05.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 05:00:25 -0800 (PST)
Date: Thu, 16 Jan 2025 08:00:24 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com
Message-ID: <678902e8e7bd1_3710bc29490@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250116020105.931338-1-kuba@kernel.org>
References: <20250116020105.931338-1-kuba@kernel.org>
Subject: Re: [PATCH net-next] selftests: net: give up on the cmsg_time
 accuracy on slow machines
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Commit b9d5f5711dd8 ("selftests: net: increase the delay for relative
> cmsg_time.sh test") widened the accepted value range 8x but we still
> see flakes (at a rate of around 7%).
> 
> Return XFAIL for the most timing sensitive test on slow machines.
> 
> Before:
> 
>   # ./cmsg_time.sh
>     Case UDPv4  - TXTIME rel returned '8074us - 7397us < 4000', expected 'OK'
>   FAIL - 1/36 cases failed
> 
> After:
> 
>   # ./cmsg_time.sh
>     Case UDPv4  - TXTIME rel returned '1123us - 941us < 500', expected 'OK' (XFAIL)
>     Case UDPv6  - TXTIME rel returned '1227us - 776us < 500', expected 'OK' (XFAIL)
>   OK
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

