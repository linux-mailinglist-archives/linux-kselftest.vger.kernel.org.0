Return-Path: <linux-kselftest+bounces-1966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3BD813C10
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 21:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3D4281E08
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 20:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671156DCE5;
	Thu, 14 Dec 2023 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0ZL9rv/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CDB1110;
	Thu, 14 Dec 2023 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3360ae1b937so4539170f8f.0;
        Thu, 14 Dec 2023 12:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702587220; x=1703192020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGYPk6/2LK4WB05DzAsE7gyIm4PhBFTb2r9q70jSsZY=;
        b=A0ZL9rv/TCR847tKdOwWmNhARHOfMMpq6rGJzc6Ztg6Rbz35D4sWCVgBdJZpELCNS0
         ObsEoLYfuR4D/VreB3pQzAdWGJMzilMYobk5dUmfSGZy43hIPCjhy6eb472CHUqwXt+o
         BvmfxfUUq7Hy2Sw05fYnF+ZD/7p7D9M+Z1BYupOEAtcOiKS5OivyJPTpkrcnOELQCoZJ
         +XZPrOq04IlWOskedEzJ+BP+zXd5WfM7yOgYNEhEIRZNvtItWo/SpYMy90o9fJ0a0rHY
         VPs8hPY1MVm2u1Np3wLYL5ZbAhlumXm8fvXpxChL2iI17iHcsfg5f4L8+uCnC8H+f+9M
         lEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702587220; x=1703192020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGYPk6/2LK4WB05DzAsE7gyIm4PhBFTb2r9q70jSsZY=;
        b=uj1rcEeJtCrFyRPgBjg6+wH2r1fOrR0UFkMhqXCSC5vzy2IvlTQfF5AOkl9D111gWz
         zgaduFGjIvQnM1seP6pNkw7c92fop/ULnHXM//vDDog8UYnTvLRVvD1eC0Nz05sucPFz
         3M4XQp2C0AEFajMQHjuElWKWF7yZbnJpOK/iS+YQpKODWOkesZ0CKSKQtP5v195UE8CU
         DnWIAP/J5pon3GI1UmyMpEwoGVVuFtPBeexWTqp4HX5Hy8wQdWR/VEY606trVaBBLgin
         wEHfIDXUzPYsQtQODPZ69V6Z6fB9I+K5gt87JeIorCW5d70mgVSjhP8+395wqxEYbnJG
         3wcQ==
X-Gm-Message-State: AOJu0YwJ4hZH9Csspx3FlckuvZ/SLNI4W0zjYWzcdNx9JFSRcX2odYVF
	PiFSVtLcNxVB5rXbJXKmxqEcskCCIyS1Puqlyrv1SRU5
X-Google-Smtp-Source: AGHT+IEn60KUK3G6CTwadCd0k9MiIqAGQ3rzBMDGyIiYKbZcEWgSu3gx0rWCz07xT2LLzY3YFYQ/rng7NW2Pl4nIbV8=
X-Received: by 2002:a5d:54cd:0:b0:336:495c:8b39 with SMTP id
 x13-20020a5d54cd000000b00336495c8b39mr817426wrv.137.1702587220078; Thu, 14
 Dec 2023 12:53:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <qiv464c4y43mo5rih5k6lgzkbpnj6wsrl52hrhgbxeqj45atun@szmqlmnccm52>
 <CAHsH6Gujycb9RBuRk7QHorLe0Q=Np_tb3uboQfp9KmJnegVXvw@mail.gmail.com>
 <fwadmdjjogp4ybfxfpwovnmnn36jigffopijsuqt4ly4vxqghm@ysqhd25mzylp>
 <fecc7tpmbnqxuxqqolm44ggyeomcr3piabsjkv3pgyzlhyonq6@iiaxf34erjzq>
 <CAP01T770poh_63vBC+Heb9ASJ9pDZd1wTDWAgm5KCYHK9GtE1g@mail.gmail.com>
 <yshbkwaiong7qq2rsgkpvvyvzefnwud5uywbea6ocfxxenzv6s@dn45gdaygaso>
 <CAHsH6Gu_c29Nc+cH-s3EeztwScL=A42wi_SuJD=WeYV0mtVxbA@mail.gmail.com>
 <CAP01T76ZtehyRidmnV5A0p3LCyjw6Q4sjRH6ZhczgGn1ap-x_g@mail.gmail.com>
 <CAP01T74dKxYKM1GfTUJZ+G4+CKbRU=JLGoNcG6b8PMYcqUyEzQ@mail.gmail.com>
 <idbmj3y65mi7isezhlq4lip54bbngoouv5hbai2xd7bqtv7dxy@qjcmln2ovmz2> <i6kxylvo5hcttmjmhpjrmwdaxe4bi6cggk32js72ivr7qelknc@qnjkmr3df3b5>
In-Reply-To: <i6kxylvo5hcttmjmhpjrmwdaxe4bi6cggk32js72ivr7qelknc@qnjkmr3df3b5>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Dec 2023 12:53:28 -0800
Message-ID: <CAADnVQL_=Hot71RV9dQ7FN6bm8TY3aMiouhAnQHUg3tmKtWStQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 9/9] bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eyal Birger <eyal.birger@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, antony.antony@secunet.com, 
	Yonghong Song <yonghong.song@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:24=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
>
> Looks like only x86 supports exceptions (looking at
> bpf_jit_supports_exceptions()).
>
> This causes selftests in this patchset to fail on !x86, which is
> unfortunate. We probably want to be running these tests on all the major
> archs, so I will drop the assertion patches from this patchset.
>
> But since they're generally useful and I've already written the
> selftests for it, I could put them up in another patchset? Or maybe not
> cuz you're gonna fix it later anyways. WDYT?

Yeah. don't use bpf_assert in generic tests yet.
Only tests that test bpf_assert should use it.

Pls send the ones you wrote separately, so they stay in email archives
and we can pick them up later.

