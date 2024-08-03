Return-Path: <linux-kselftest+bounces-14756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF42F94668D
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 02:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2D911C20F64
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 00:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADCB2914;
	Sat,  3 Aug 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIS4+0yM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69B46FB8;
	Sat,  3 Aug 2024 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722646234; cv=none; b=UCfD8GYVDz2UxbyTb6AmNEuS4/d+FRM10cJeaLQtKVwyfzJx77FZqMdtrK/Cesp2ZbPZDWTnZyI2tZuuEVWl2g9q4q7YPLkE0WD3g25Bt3UeB4x8iQ13r4UuVLge7ML6gBg7VtzbMEqEQuXmX/kTq+QUThUj7PxdSCvmXhvl2aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722646234; c=relaxed/simple;
	bh=TKgDbZppliFfj6siqWPyZeGhtXYn1QemkYs5GVnMb84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+Jg+/a5qHNIqcfT0m5pwBj04TbvZM+8JvZeNmO72A+ObGDxrcWhOksAL2twpHKnZeEFYDA70uuNABPLtu1zlPKq0U6rnXF93Y4F7HUUZobV69MPo4y+Th6iqSo52h73JeG7i7n+TVqwpdbKRMYdUiRqCTu5PIJaypLGSMgmJhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIS4+0yM; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7a18ba4143bso6353446a12.2;
        Fri, 02 Aug 2024 17:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722646231; x=1723251031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ii9TRHHbYfqeTNA8urSRUIghL0nSQM2uHrE3DtyGbx0=;
        b=gIS4+0yMBFCuAjHJ3eRIQJbXE2r1bJcdm0fw/E2hLHk7i826kNCGtJzgPWAncro34b
         Q8bcQYCW0d4U+kzsSDXl+V2v1jO5oVAtJ/dnT71q0Qy2nKcQY9oVkCWP9dSE80X6Q6sw
         TiIW5uBlVQ7118ugnHubpwm74MU3SbMX/HXzEKO32JHWYE1nXb+7sHlgP9F0gJPkSSp6
         89JAhLExygqGk1q2xsVEV58Gt79MKyC1BWo1nLk7OK9aJHFvbJXZ9uZiIePcB2w2bZNT
         xIkFtEGsp1m5MFfnrGJ/LZgZM/oh5xa8wXSyVaONsBVkOC9s/DfIgAXldxbFdufnV4mj
         Y+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722646231; x=1723251031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ii9TRHHbYfqeTNA8urSRUIghL0nSQM2uHrE3DtyGbx0=;
        b=vQbYMiomn6djMEwh+d+LedcncCYL6Xj0zT41UPEVTbZXGRpQ0TJyFxspUxOY7TC09u
         U3R3pVSivL/91eD/KKiC7eB0sj7v1DssjKMFqRJVWpog72c8dbZUxGl/8N+Rq0fTcq32
         +u6smKTDSWAvinvUBCf3ZB+wStvCyoaD55tLK0ZttoR8kC3ix0Gzs3dUf0XAVyz0CI3s
         Rl+iwP9iSSoWjyU4oMiujRTrxi9ao/NoIqsaLhUWEZCpU8NcCs9XirEFuxOid8k4RG3r
         e4Mq19p3Gu9UTVGunLphnhBDp/RgucG2/kQCpGKa/GPhn8ePBQn//lJ5QFBKtARN7Qmf
         nc3A==
X-Forwarded-Encrypted: i=1; AJvYcCVwzsVFVW0hUJwSO3wSjpna1pgQsH/xtr1tO3u1NZZ4abCAClQ1BO11dev8pQYGtHwq07U7+nme/D22qtRSgJa3UjBeI17XFV1M2ABy6l6vFqM3tf875JOhu9urcX5Lm2VRPdZkIOU3WGf7czhW9hFMCCk5Ln5vzSHSHpS8ob6m+E5CfMSX
X-Gm-Message-State: AOJu0Yx7Y/K74IsSQKBY3gZgLZ5lkoGxSk8YTl+29YcSjDtJTqM/HN40
	luwEOZo5Bhn4cwcrDXoyvDzv4TtqmX1VivTjsVf4u9vQVDIdB9pZQJDAxXqJ+11kmYD6vXfO4fc
	NrNVcNiKlyonobKuBALjjgn8LLRI=
X-Google-Smtp-Source: AGHT+IGS4mvqY8Wvdxe/ZNRlFzeeItVUD/tp7A8aKWLj/K9xpJDlvLtJUOmC2keDnxNAnMHO8RMvCbjb2AaWzLyNhxI=
X-Received: by 2002:a05:6a20:1596:b0:1c3:f4b6:6c0d with SMTP id
 adf61e73a8af0-1c6996aca7emr7300214637.52.1722646231208; Fri, 02 Aug 2024
 17:50:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802-tcp-ao-selftests-upd-6-12-v2-0-370c99358161@gmail.com> <20240802081823.67a27db3@kernel.org>
In-Reply-To: <20240802081823.67a27db3@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Sat, 3 Aug 2024 01:50:19 +0100
Message-ID: <CAJwJo6b1UHoCuyzy4UnLRu1W-GWx5jM2RhoddbzzuWXaEVG5yA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/7] net/selftests: TCP-AO selftests updates
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Fri, 2 Aug 2024 at 16:18, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 02 Aug 2024 10:23:24 +0100 Dmitry Safonov via B4 Relay wrote:
> > First 4 patches are more-or-less cleanups/preparations.
> >
> > Patch 5 was sent to me/contributed off-list by Mohammad, who wants 32-b=
it
> > kernels to run TCP-AO.
> >
> > Patch 6 is a workaround/fix for slow VMs. Albeit, I can't reproduce
> > the issue, but I hope it will fix netdev flakes for connect-deny-*
> > tests.
>
> Hm, could be a coincidence but we did hit:
>
> # not ok 55 # error 381[unsigned-md5.c:24] Failed to add a VRF: -17
> # not ok 56 # error 383[unsigned-md5.c:33] Failed to add a route to VRF: =
-22: Key was rejected by service
>
> https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/710001/4-unsign=
ed-md5-ipv6/stdout

Yeah, I think I've seen that previously on netdev as well, but quite rarely=
.
Let me take a look and see why adding a VRF table sometimes fails with EEXI=
ST.

> in the first run after this got queued. But the retry worked:
>
> https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/710001/4-unsign=
ed-md5-ipv6-retry/stdout
>
> =F0=9F=A4=B7=EF=B8=8F

[from another email]
> oooh another run, another (different) flake:
> https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/710181/11-key-m=
anagement-ipv4/stdout

Yeah, this is related to this very patch set.
Some more work clearly needed :-)

Thanks,
             Dmitry

