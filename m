Return-Path: <linux-kselftest+bounces-15929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C490F95A6F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 23:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F561C229B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA2A17965E;
	Wed, 21 Aug 2024 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I30YXryW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E733713A3E8;
	Wed, 21 Aug 2024 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276683; cv=none; b=KcjFy24bbvfKbOGCy9cb4Ie5ZY/v0sq6WIFdyw1+zvknpHCLhCsmh0V9jaAR8FL+xVmuwEgz6zh+TpY/VfhLBhrF08eyxSJhREZHey6GGSVcgKUSv7RFIYAcAis6AkMKu533T1qwYWIFtTUScVRKU8MEsqrsfhZCC+rNWRTCsXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276683; c=relaxed/simple;
	bh=c5Cc7xVRDAu0e78vBBLsWi4hEbQ6IL85wMQbkWCm6qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBbdT4QjjVGCSVdP9xcOo1uuRA7SDt52U8i7Vhu6+lDILaoC6VTj/Y62rkDlaIGY88JVC/LU2lr4DM5oTLNFjZDyParjKaj5kGBJhXW6pQ+VBAWMTeEqHckaNaPZtRkNiV+XswAYWqDtGLQN/WdmoU/AOWpdl6vKYSwMpUMOJ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I30YXryW; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d439572aeaso93538a91.1;
        Wed, 21 Aug 2024 14:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724276681; x=1724881481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JUETRfax8sjt9qjrrTeS5cgr6hmWsh2u4gE8+Q0j9eE=;
        b=I30YXryWfAJjuSCoQcNueqqUTl68VV1x/60W32OoKiXu/O4/nJ8IRqHchego6V1Urs
         qCRmNIF5zefpfNOZ/Q4eznt9f5jupeJ2YDSI/BboeehI+IopNSX00V4GeYPACwj2GG+Y
         Mf3vC62Ob4uV+qwSPSkKb3b8OeeYgYl61cfWqkAnvXoLZs5V9GmdZvY1fL6Y1Adh2Ei6
         5OCnz5fF1H7EOB9/c4i8lQkMZRzDkBAhlLnmhCUBJEkH1Fl0bq8neHaq6SArlfp/KF74
         hGsBCZxusgP0NkF1U7rnfsKzQ/qXRVcsFSAJDBax71s+ngzdZDicarkMa7oawMdlQ92P
         3Khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724276681; x=1724881481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUETRfax8sjt9qjrrTeS5cgr6hmWsh2u4gE8+Q0j9eE=;
        b=Dp70z2UUcZjPFTATyf1ViOWKJtEeAxjgZz55umbUJJY6vkeCui7g8SM3SOlx1pjmYm
         +V32Vck33ZaxjfCgkbFUvhdqIKLptKlkh9vpLvFts3u87kPC1DKg6V3tyEPGFhJrBQOX
         gLK0Q8LQPb6LuuQntQk6kmJMCS9UurTS0geg5R8p9i51ZsQfgrgCwE/HOSvjdSBk7fcU
         3mmEl0EWVbJRD2phMHnhlQQ2xRIQwGQBY7qcys8Lr2jJfcr7TdshPx/4TG5ALJI/HWRV
         wMgXazE8yudg7O+1OpYquoJJx5nX5fCFcE5g0oBfGd0n5sSQ+a1PdfRYm/T7iiq22hh+
         JFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCbT36oA5Wo7i4s8qvbZ8YKaRtcCvE+K6ivu9xIqmfn/8jU3rq9lJRS+Q6ZZNOx5o2xqTb13C+@vger.kernel.org, AJvYcCVfH8WbLrNiU/zqRi8Nb8x9pCKmaFqK7ysVhr4L7hUOfx2uu3E+Wd3lPiIuKpDgqi8RP2VRayHObaB88Mo=@vger.kernel.org, AJvYcCWvlOPMrKf9541T+QE5dtK8QFkQzhkgqe4Q+1jwqG6fQqYBPorxiq5DKMcKccVkv3mLj6X+InuFEdaPZ10lYp2M@vger.kernel.org
X-Gm-Message-State: AOJu0YzkyewWUh5DhA3hUElz6YU+H6mAohOC1zVVIpQ8m28/V1TDneVo
	PLIm6AgdClQDzNGGUJRePC78QVBwaxu0gFKpxBowaNWcRgDtr85QQ+wBHjGPrZOPVwYmqOJVWSL
	bmYw3XHYvkFP67YvE9YMLMjyPHYqu5sji
X-Google-Smtp-Source: AGHT+IFBeiMnAG1bzaXlNSAsbhQSBmunae+tWtpSL2/8ZuK0e+bId+IVwlqeuZpJWwaQ8h3hPdMGRKbG2yJFhGrroj4=
X-Received: by 2002:a17:90a:55ca:b0:2cb:5829:a491 with SMTP id
 98e67ed59e1d1-2d60aa4a2a2mr1329320a91.20.1724276681225; Wed, 21 Aug 2024
 14:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
 <20240815-tcp-ao-selftests-upd-6-12-v3-4-7bd2e22bb81c@gmail.com> <20240821191133.GG2164@kernel.org>
In-Reply-To: <20240821191133.GG2164@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 21 Aug 2024 22:44:30 +0100
Message-ID: <CAJwJo6Yj_Zqwg9Z7sJvj8UZE6z7gAq+Y0p0K5Oz8s+CYMwzFow@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/8] selftests/net: Open /proc/thread-self in open_netns()
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Aug 2024 at 20:11, Simon Horman <horms@kernel.org> wrote:
>
> On Thu, Aug 15, 2024 at 10:32:29PM +0100, Dmitry Safonov via B4 Relay wrote:
> > From: Dmitry Safonov <0x7f454c46@gmail.com>
> >
> > It turns to be that open_netns() is called rarely from the child-thread
> > and more often from parent-thread. Yet, on initialization of kconfig
> > checks, either of threads may reach kconfig_lock mutex first.
> > VRF-related checks do create a temprary ksft-check VRF in
>
> nit: temporary
>
>      Flagged by checkpatch.pl --codespell

A-ha, b4 has this b4.prep-perpatch-check-cmd git setting:
https://github.com/mricon/b4/blob/37811c93f50e70f325e45107a9a20ffc69f2f6dc/src/b4/ez.py#L1667C20-L1667C43

Going to set it and hopefully, it will help avoid spellings/typos in
future, thanks!

-- 
             Dmitry

