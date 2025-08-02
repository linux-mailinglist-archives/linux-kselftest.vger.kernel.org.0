Return-Path: <linux-kselftest+bounces-38197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 702CDB18A07
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 03:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E432AA3A69
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 01:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027059443;
	Sat,  2 Aug 2025 01:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWh3/53r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38835A48;
	Sat,  2 Aug 2025 01:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754097021; cv=none; b=TTv5+87ivfgDxaeWMm0Bvpls6b6ZlWBeHHqKxfRA5AKWbFg0hX5WSYsWQSr7Ok43Bg7eG6feFF8dBSQBvi+Jfbs2taleb1397v+FHK+jKJgL8R8wB3w1vyQXwKuEbhFstp46Ys1uGd76oIvCdsJ3l8CRyGURXA1Eh0aHULuxTS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754097021; c=relaxed/simple;
	bh=nl6c4321NAKXX86GD7ps3OZQddqSonNEhTulv87fzzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUBXPHFPRAJ378xAIuTCaXC1h66FF79RMs29i/H/8u7/6dbNegk/ojKF3SOK4h/rjRlIoZL0GdPmkUbXSzRfiXUdc40EBnMi7GSGGtNSSLBu1luBTgsaJ/FGH7lA7R2kQzJgrkdepZKk0nT0LwK/xgVaooG+Jke7Ughl5g/CrSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWh3/53r; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4589b3e3820so26790535e9.3;
        Fri, 01 Aug 2025 18:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754097018; x=1754701818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UmDeR2LiWPErRTtoBmri3CE2DBkF02ITaXjMtjgCX0=;
        b=mWh3/53r4vuNQZ/2y98O7/OPuR7yey4BQ+PtkeL3XmorkIuNY33kRvx+G2sFjkfTEB
         xSftsyIn/aWdm8gnsw6a4itFUlj3ZYS4KnY1gb1qOtx4d0iwh1rw1DyRgO9+YWkJ+nIf
         qESPkkbFNd2rtBU7sn1/5nS5DgFk9QZEuPaGZRNhlCmwWmpSh4CkfBtvsPIJCDE5OWEq
         EPJZWExGIk4TYRU/VoqgCyKJ5N35jE3QgVVJdHUPodGQGtMIKvlyCideb8EwZvLn7vY3
         vtYs7WMkOWfDWK98K/xjYEjDGOPJpgn6vOSi1YDXTNHO95DCaO6+Bb9dCQHfo/mLuZxe
         boiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754097018; x=1754701818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UmDeR2LiWPErRTtoBmri3CE2DBkF02ITaXjMtjgCX0=;
        b=e7rgZL/GgubzFG8avbUQS6BaixD1t713i6aEe8EX5fgZWRSnQdnx3kMjV+8/zAgAf9
         hQzZxlacUOaNnBURUmxLpiIbD+cC1gIUpewyIP4Ys/CK78wvG32//QJPnRMqKkQPeRsS
         LvQzUCNy8mA8wXkTL+/PoXDWcpuPgJc9czIJJd8sHbIADJSWkAwbom4kt34Y/O4nWfEg
         ym5mc0zumvgCBTGnMV+IXpU/oc+vrnQWOCFRaHaNoVvOTWP/ZEAtugZOVrsPHwpN4LiQ
         Qh3cIRBqHNhHsZxmkgMLPYmvP+JzJ4JM04dcmzPybZ0Q+2zXhUXOBjuqA5U54/JN8P2M
         MfWw==
X-Forwarded-Encrypted: i=1; AJvYcCUPZeB7HwQC7By5hAc6C/BC2Y76ZFOYC+EtbFiSLlTx+8yEYxWp7/fbqmOE8fvE6jjeSYISnJUAqpK2Zow=@vger.kernel.org, AJvYcCXO0sW8FUTWgLJdwSCQ7aVRoX9s4nSou/gAR9RO4nMXU0mXm1DmBCKiJUkLvyi2ZkbcclblNV9CmtJE5EQ5VuO3@vger.kernel.org
X-Gm-Message-State: AOJu0YyEhXCSszcH8nTNYBFmqm7NxwO3D4TPav+K3xtPfV8Am2bvw4U2
	7YV9XPM8ysGik0lvC9GM+j8TON5RkKYI7MiAaPhB2PFf0ypz2K/GsCYWt8kfDxe/2WpIxzoIDZI
	5ctAC2UUJhbBnGXxnRoyqlwLMO1He91A=
X-Gm-Gg: ASbGnctPtTb1S2kiWM7Ld89o5XEaOs+bfPK+Rz6tXBxmiFKn05IXsINd7gjSLr1XSZE
	PBZWM4xuI98x1iBGAOuw92qOj2O6jxYJk/MnfvXV1hgenfvxfHiJeutgb1lZSvcFtCAE0CzXJHm
	2cf+RmGaDG2ybN/47BJBYmKonUQDgNAxYBvexJ2NqrpHyNCZDV3aP5N6ehNvmBJr21iJPoMZuim
	XvHsV0i5eFqRr+PWIfrp4PX+CbmnYhnGAlD
X-Google-Smtp-Source: AGHT+IHZvq/EhUufr5BA+LW3v8lbbDX76c/9s3iMTywwTb731Fkv6v3wzApUPrir+O780isCCB1t2MY8v0ONeQtUTpw=
X-Received: by 2002:a05:6000:40ce:b0:3b7:9589:1fd1 with SMTP id
 ffacd0b85a97d-3b8d94c5820mr1274187f8f.44.1754097018283; Fri, 01 Aug 2025
 18:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801161531.816845-1-phoenix500526@163.com> <20250801161531.816845-2-phoenix500526@163.com>
In-Reply-To: <20250801161531.816845-2-phoenix500526@163.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Aug 2025 18:10:07 -0700
X-Gm-Features: Ac12FXx05DYYV4X1PxpLaLu85h4KWTcQ71kqdK8KN7JVSKkCCw3U78t-vFv2ors
Message-ID: <CAADnVQKNGHGuu0GQR=HSCwvV9tm2dS6noKMcou=OEVp6T43NhQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] libbpf: fix USDT SIB argument handling causing
 unrecognized register error
To: Jiawei Zhao <phoenix500526@163.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yonghong.song@linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 9:16=E2=80=AFAM Jiawei Zhao <phoenix500526@163.com> =
wrote:
>
> From: Jiawei Zhao <Phoenix500526@163.com>
>
> On x86-64, USDT arguments can be specified using Scale-Index-Base (SIB)
> addressing, e.g. "1@-96(%rbp,%rax,8)". The current USDT implementation
> in libbpf cannot parse this format, causing `bpf_program__attach_usdt()`
> to fail with -ENOENT (unrecognized register).
>
> This patch fixes this by implementing the necessary changes:
> - add correct handling for SIB-addressed arguments in `bpf_usdt_arg`.
> - add adaptive support to `__bpf_usdt_arg_type` and
> `__bpf_usdt_arg_spec` to represent SIB addressing parameters.
>
> Signed-off-by: Jiawei Zhao <Phoenix500526@163.com>
> ---
>  tools/lib/bpf/usdt.bpf.h                      | 33 +++++++++++++-
>  tools/lib/bpf/usdt.c                          | 43 ++++++++++++++++---
>  tools/testing/selftests/bpf/Makefile          |  5 +++
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 18 +++++---
>  4 files changed, 86 insertions(+), 13 deletions(-)

You didn't cc bpf@vger. It cannot land this way.
Pls respin and split libbpf vs selftest into separate patches.

--
pw-bot: cr

