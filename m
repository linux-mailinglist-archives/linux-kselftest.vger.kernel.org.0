Return-Path: <linux-kselftest+bounces-28599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD05BA596E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 15:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E94B27A5F80
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 13:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1500022C32D;
	Mon, 10 Mar 2025 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9ZeIEGE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32AC22AE75;
	Mon, 10 Mar 2025 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615204; cv=none; b=l75vNyvfo4isDohRkQuZmBu1GDDsAOvFWfu7w6Sz17fbr+3uMZWxT2uYnCCrLSK2DnORLRD762uaKBDeIePXjUcwcRKULiT36vpLk1wQuxG7pQ/Tq3QFv4LFH6HITSdwTTELy+vVMFURaQ6o0hhMqL8ODmpQQaLgXiBOk1+Z3+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615204; c=relaxed/simple;
	bh=gSYZwMocisBf6GSf/MbV+duRQDs+uqL+YJ+GA5Dtolw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=he3bq1G2Fo3znCDbk+iWDMa0Mj6vAMmVjVPznhiHtRNrpAoniCArpcpS1Ts9Zwp7rnq395NrtB0BryeWNkefiAvHeFEUGqv6uBgjPZpbNxt6ECMF7v5M/YJYtfZtrknyKfJG0LGlkRoP/ciaDEsP3OfNPqj8WmcGbgqUStf9zfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9ZeIEGE; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c547932d2eso97045985a.0;
        Mon, 10 Mar 2025 07:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741615200; x=1742220000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lp0UIX9QunfnkdCGehvBsQtkasKoKtHRouU8cbcHLEg=;
        b=F9ZeIEGEdDBvpisow1OOdQqUY9KaC44buEjn7+vx0smFMy5q4RBbIm94a0kL7x2FAx
         yb1sJFOC2lNRxlZLKyRmko8leFVG1Bg0l6nqtX1LiU9MrSfVKWbC6stndsoyVsnQ77Cw
         s4Tm0ijU8L6aK4xZ7qaBIGQHUuu426YaOMDXeMe3IC2X7FRK29nXfzAV6C7x9jlcj5p7
         DoBx3Z+/lsA1Reml2mGjd1jDNRgQtfdYm51eGq9DaQOch0pVYY/TwI4k9/iJtkpO7kGw
         +/V/ZakNiVozhddezl+NpAZngB7xCnNSQrVHFiPcnqwxUUNslZK1zuDUX4/uadqlyUGD
         QEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741615200; x=1742220000;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lp0UIX9QunfnkdCGehvBsQtkasKoKtHRouU8cbcHLEg=;
        b=RYinOxLaqDcBjPI+YdBSq6iQUqjzkk8i1W82p7AoHFGJoKy9EFomfozdgcWk7PVGkT
         a8igwcIoWnJMptW5nM7jdkLI+IpjPvhi2Dat16l/TIQx+4F8D+SPjzkF5lmt/y5uVYJL
         u3uddfumKqc2WU7OmCPRceJKnVCUDOhM7HOxidLKSOasP0LDJd+MsKgF7xwFLsioFF14
         FSaBATL+ZkKS5JTgiBiqrfwJfyuei4baQ69nePN83kk9qMTNboVyJdLVR88oEc7rlcPB
         u0eEg4s7NMQovN6g//i/0p/zRGSOp5ee0xKHIW6iQM0bixmiSfG1jraZJustyk5NDAhQ
         DPAA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Pew2CJYolwtKqXnQbRmNYMs8RoOhXKk1eveNGbRPi+ph+hVQA+X+Eo7r8PVIshHK0Mgjs5Ob@vger.kernel.org, AJvYcCVJ21b300k8YCymeg+EpiuZf9EpvKizWfA9TpDHwLq2ufrHDSMwTjUJMpirNbpCWOn3HKma8+0P@vger.kernel.org, AJvYcCX3q8q6K5gN5UROTTLnKbqmUN2uwzp6gxKZ9neH34HWtplAc4ZFP9otloPcl4jlYgH+popnTOvsNqTS88ea@vger.kernel.org, AJvYcCXObE6o9xLDuD0Ka17CPLKiZ1+ih9DZqCXYY5/ANnYxH/tnqeKYAvVqQjvk90yLdmxRjQhuCmSo8G7xz6QlZgiS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv3AD0uqlZt5/WIy39qtdrWdpncYxX+0Lg21k7wo3G/7tYqSrH
	Y+skZN6y6eAjeAI3afJDiyoGEepWCGERARgEkI/1z24A9TBTtuCn
X-Gm-Gg: ASbGncsk1oOMlI2ExprfbmFvifqEtgQr6viLR/H4qZuoyNV2L7b4JbpsgcuYpcQR4wf
	SkoTNayPr+mzPuCNqviWJXLwCvo/B6R0sAuX0OWkoOukIrZfG7BWR2hMDf7eniBpbxjvJpfw//2
	kMvD76FE/oDaRPCl7P03OMo8i/cib+GI8NVZXq5LLA1VlLi9mlmJ91Bbbj6eLRYbreTMb8MnD+V
	sRvxKQbGBszk1dNrcGPG1LcO8KTz62dsNoYhItGEh52fOFOT+sGbLGEvpIRbg2j3mXpSM5M4d8/
	pGlVcZHTudiUqqPzM9OQF4DuwNOzlGHj0n6VyO+671tyyofOKcBVi8p4kMsRYbWIMQL1nML5cTF
	NyPmO0uYNVmpNgY3BnXh3kw==
X-Google-Smtp-Source: AGHT+IE04BxMTl/bSEdx8th/M++89nsJWl68HA1eP2iCKz4Yd9WxUR09v/+TtJRwQhum3K/hAKLuOw==
X-Received: by 2002:a05:620a:4386:b0:7c5:5791:1228 with SMTP id af79cd13be357-7c557911359mr308841385a.45.1741615199663;
        Mon, 10 Mar 2025 06:59:59 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c54984fb6bsm296003285a.67.2025.03.10.06.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 06:59:58 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:59:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
 kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 cgroups@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Luca Boccassi <bluca@debian.org>, 
 Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 =?UTF-8?B?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Message-ID: <67cef05e7f9c4_2462652947e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250309132821.103046-5-aleksandr.mikhalitsyn@canonical.com>
References: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
 <20250309132821.103046-5-aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH net-next 4/4] tools/testing/selftests/cgroup: add test for
 SO_PEERCGROUPID
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Mikhalitsyn wrote:
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Lennart Poettering <mzxreary@0pointer.de>
> Cc: Luca Boccassi <bluca@debian.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: "Michal Koutn=C3=BD" <mkoutny@suse.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> ---
>  tools/testing/selftests/cgroup/Makefile       |   2 +
>  .../selftests/cgroup/test_so_peercgroupid.c   | 308 ++++++++++++++++++=

>  2 files changed, 310 insertions(+)
>  create mode 100644 tools/testing/selftests/cgroup/test_so_peercgroupid=
.c
> =

> diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/se=
lftests/cgroup/Makefile
> index 1b897152bab6..a932ff068081 100644
> --- a/tools/testing/selftests/cgroup/Makefile
> +++ b/tools/testing/selftests/cgroup/Makefile
> @@ -16,6 +16,7 @@ TEST_GEN_PROGS +=3D test_kill
>  TEST_GEN_PROGS +=3D test_kmem
>  TEST_GEN_PROGS +=3D test_memcontrol
>  TEST_GEN_PROGS +=3D test_pids
> +TEST_GEN_PROGS +=3D test_so_peercgroupid
>  TEST_GEN_PROGS +=3D test_zswap

need to add to .gitignore

