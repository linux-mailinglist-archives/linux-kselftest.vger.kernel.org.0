Return-Path: <linux-kselftest+bounces-30080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B646A7B056
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 23:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A963E16C710
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 21:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CE11FC7F6;
	Thu,  3 Apr 2025 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xsrbw6xG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D11FBC92;
	Thu,  3 Apr 2025 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743712400; cv=none; b=qCKI1tZtMe44YZtIm0bO6L891lQy3HKndeHMXeSXs8G1wjBXhHhfoLePxbrsxirrYHcbJLGK82M6nxn39pRhqnDTE4FVauzqsGFNDBZVexCFN1B5epCnN0Lng8QwffhCu7f5lYSVHx4Zhqfqz8Ce+ky015oaVyJkPYdgCYjxMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743712400; c=relaxed/simple;
	bh=ur2Tr6iw7X46fc/5bRLx6fdqJrE0cltK+bwwRImun+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhfru4zDfOd5SWG2pp6VwucLbV/d732+FGc7CQqoQKNCItS0aY4Ynk9ZrquULClzJ7yQT1Ur7GYRxDJMUMiDRV17Tuov1l3v034zS6mJ8+7+HGPGEop+QVeOIluWLx7ugAjauGa4pp6xAeg4rchdWlGbCwczf9HKNopHgDsnO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xsrbw6xG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39c0dfba946so872936f8f.3;
        Thu, 03 Apr 2025 13:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743712394; x=1744317194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ur2Tr6iw7X46fc/5bRLx6fdqJrE0cltK+bwwRImun+Q=;
        b=Xsrbw6xG7bVsUETNlq+guwyj3eAm52ekojJzJtG1G+pAZ6TKH5vkALzuOdJfNBbwgT
         5kMTuXuegNhqwuJvM82YktlzzAJQPhImlG4v5PATaw5CqNjNy1ODpBoa5lSVU3NZ1552
         C7x3dkHjlGmRlKbugohbsOpmzjigan8UtfbfB8ZDztRuciASptnMFmWypMw7dRxE32oT
         V2Tq130xpVAQkDeBlxiHvkeSrG+poKVFTkL12OIjinVcomDheVuu3VLXaaMF7K5+hho4
         7iZytZ1hG4EDwQhtguel18pEpwf+vEV7ZhvhyFBqST0taWF29HPJ+ncFhCmC8UALAyYP
         i2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743712394; x=1744317194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ur2Tr6iw7X46fc/5bRLx6fdqJrE0cltK+bwwRImun+Q=;
        b=frgZm2QN1GUaRK3YC6Y35Jz4Uhjni5FVE7CJb44w8zzk3jJX7EmkUiP+SnDSuylJiI
         gy7leYPm3W9++QisC/txU5KRrjbt8emV8Q9PctpQLtD9NfLUavxyCTXWNg5GQ93rhqVq
         GFVuxZBpdFACqf83NNB3vs5NPA3pQ0csLuD1Ro6hq6RHGoIWZMPNnexmyh3qICyjKpGR
         508QLqFygvU6xFVNypN5XilNKBFzmjJybgbKEkCxFqJdC35ez04qO2XzDz/bPwMaVmuD
         WAusa8/9FmiS536KP2v3ufhbdKwFMKzVXa0yBxefcFzNLiMAoaiDbRxXZQTiS1F6FaKd
         CtHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0ywAH/CC3T/ZZRpR82uwMF+EI7oi7lZrySzqx/H6FzKp3Dl//KQFMy8vALwxlPzxB+Rxd7g4AYwhrMtNNV99F@vger.kernel.org, AJvYcCW/ANmYUcZzh+twkVBWyA7Az83WrfLShLaZbBNbr+7I0ie4p/hKP69ir1BrEv+Tg+7NzC0FlJU6aZLOOTdg@vger.kernel.org, AJvYcCW22AT6kxVx4kWLnXrM5meXAMJmZ6GOC3iWlQplfo2CDTAj4xGIqgZvdN5MYd05zpPg+6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYcc0hVD5awcVGKTP8uI5ns6miSOoB2LUTDDsTF/t3+qm2pfZW
	Mz/QNcXd/SV3SGhQiXs7KUReMC83/XP9G3yqJnFN7chtqancJn0p4/noo7RSdLclkVXgm3SdcIu
	+81f150mxOXfedPKwVbBQc+bCG14=
X-Gm-Gg: ASbGncsLunP7AlLqyb1iziBuQ9JmbGe7g2a1OF7j9BxtQOq8INX48H6gvdnRHTdjYLw
	VeT43+b8gJ2sW1AjiKFC8OM/T04jCaYXmVbQpIBlwtnqz4yqwGVm7LLsx7tIIDTkJMTZxQmCqgH
	39oHL1SIDYnT2s8oNWTMzRVZEiS/vOS9CSskU46VRjEA==
X-Google-Smtp-Source: AGHT+IEu34HOnVSPLCEPZgUjMqgj5ikBMtgLqNQ7LH7V6Xsh1zQa1uWkmsD6Y8njY4+v2/UFK6c0Z5jpunIin/qN29o=
X-Received: by 2002:a05:6000:4284:b0:39b:ede7:8906 with SMTP id
 ffacd0b85a97d-39cb359572bmr610867f8f.19.1743712394400; Thu, 03 Apr 2025
 13:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313172127.1098195-1-luis.gerhorst@fau.de>
 <20250313175312.1120183-1-luis.gerhorst@fau.de> <20250313175312.1120183-2-luis.gerhorst@fau.de>
 <CAADnVQKL-NwxigMWM+U=n5ZXPG+xHYzSTEv0Rq8Y91m45eRJDw@mail.gmail.com> <87cyedie3w.fsf@fau.de>
In-Reply-To: <87cyedie3w.fsf@fau.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Apr 2025 13:33:01 -0700
X-Gm-Features: ATxdqUHPAFiAlWbRvEI6Dyb_uIy-F7VX7qdc8juRjqz8Jt6HEvin01eMZNJzsww
Message-ID: <CAADnVQKAFfOKWe+rdvaM=sKp229Kn14jj=K6+8oybw5m2Mh-RQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 11/11] bpf: Fall back to nospec for spec path verification
To: Luis Gerhorst <luis.gerhorst@fau.de>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Henriette Herzog <henriette.herzog@rub.de>, Cupertino Miranda <cupertino.miranda@oracle.com>, 
	Matan Shachnai <m.shachnai@gmail.com>, Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Daniel Xu <dxu@dxuuu.xyz>, bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	ppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, George Guo <guodongtai@kylinos.cn>, 
	WANG Xuerui <git@xen0n.name>, Tiezhu Yang <yangtiezhu@loongson.cn>, Maximilian Ott <ott@cs.fau.de>, 
	Milan Stephan <milan.stephan@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 2:06=E2=80=AFAM Luis Gerhorst <luis.gerhorst@fau.de=
> wrote:
>
> Thank you very much for having a look. Let me know whether the above
> resolves your concern.
>
> In any case, should I separate patches 1-3 into another series?

Sorry for the delay. lsfmm was followed by the busy merge window.

Please rebase and repost the patches with the detailed
explanation of how lfence works internally and it affects on
the algorithm.
I mistakenly thought that lfence is a load fence only.
That it forces all prior loads to complete, but not the other insns.
Since it's an absolute speculation barrier the algorithm appears sound.
My only remaining reservation is a heuristic in this patch.
If we don't do it, we wouldn't have to special case push_stack() too,
right?
Let's continue discussion in the new thread.

