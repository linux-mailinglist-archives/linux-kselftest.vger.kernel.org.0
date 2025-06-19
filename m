Return-Path: <linux-kselftest+bounces-35391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF30FAE0F22
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 23:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3BA5A0851
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 21:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3328246BA7;
	Thu, 19 Jun 2025 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+vadTH/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1276A2459E1;
	Thu, 19 Jun 2025 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370131; cv=none; b=mY7yud6q8vpWn7V5x9w224d9ak83cUaYikOSs2DmIpQkCIT8evSEdNFwNjFi8ju87dZBql6BjnqssscrFTLQySGs9UrKdSDLKUB94r9i+W3V8BApfJqnZanxJIlYnLDwnkOTtXwsPIsVkqb0y6syxaWaHnX5XY4NLBAgPPQ56i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370131; c=relaxed/simple;
	bh=MDMtof2zLPxb60iACJOTv0INsBgQz0UZ3E4EuWl02g0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8bC1N/YvBP6Uzm5drf4EX166WFKESTZHbfFo684J6fpNTTBYMvsbVLD63C5mvkdzxuNYhcv6H0/ASI34wq1UYrmvX0nbSU/rSBFuj0Ez/u9EFBDbFQs5RtZnFjPKmXyAscaH4mYZpPMo08qzeZcRbBodh9iSUpczjhw2IAY2zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+vadTH/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2363497cc4dso9448615ad.1;
        Thu, 19 Jun 2025 14:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750370129; x=1750974929; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v8ZME/OBMXRBz9TLaHW+wIbdfwUZa2EvpoVU8jKqzyo=;
        b=a+vadTH/R3946EMVUF8Cxt6eA6goDEesZkKHFFZBoz8QWjWzJnRaDVCs5MFz+1XcLO
         juXXXnezJIdpuCkUD7QfT6C8bUSr7nBiMos8j/OpbZ22Y+R65iptAum0WqB92qNy39Y7
         5iXONqy9xqg8+jtlt//1YNXkfprBLJv9S+SD7ZWdbL3ZiMyGd80iVZ1D1xF4gAmJZro/
         eTZv+7OveT8WsqVsUUODKXq6TBW0/UK/HxgxTWwkPg7s/ezz6PkB7GqrlRSImUo/P5nM
         VnenQGTFkzf8DLzsKTI84N9UDLnAz2WO8rcmdol5YcwGnS9mrQjVvrnTchWpQNzleXVV
         PZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750370129; x=1750974929;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8ZME/OBMXRBz9TLaHW+wIbdfwUZa2EvpoVU8jKqzyo=;
        b=MZ2o6RLrRcklV8taQ/dRfq9GRWn8Ta2b5EAboWy5pWHhAxxwGB9uGCOhzYuFlFBBvy
         njIyuoK001im7St0HSbGUBV68EQB8SD9GvKiLJYv73h5050/qmEz/nmgOd/Ix+XNV/+B
         fUMqvgLK2+QLleI7FtV+mw67EDpX/fkL98BoT9KFH7X+mf1gxBRl8LHpXHBg4+V+Hz/g
         gWV8WoKcH2NlMGTf5LPl9AURx/50m+dRNuyYFV0XoWZeP6TglwFuWY0cCuzkyM3QXaE2
         TtMAJtwsk5y4zfSRLCrhk1AAF+p/nUhTrrX2370E9Ug8MM6k+qiKeWiEFxYAHcXuDO1o
         WYnw==
X-Forwarded-Encrypted: i=1; AJvYcCUX0DKNNbkfh1izWxAtLYBkYpDo0REmcHZ5k6ncnTJ/glVSGLsKtuLllTg+aFdmbauClGxzshnhZbac5ZF2NGZC@vger.kernel.org, AJvYcCXR1MHJbHKqdcLXMgWSZGMrdC/EdMLfP7f1XYH2Mbuw7WcFqLVwC6FDe4epsZIdZ1AxE2o=@vger.kernel.org, AJvYcCXu6tBSbkkonN2S+Oq8pCPr/gApS8PE+Eb0J/qa5BdjtRRRudg7NrE60jQut/1tnpJpaMOpt0d5VOyzCy76@vger.kernel.org
X-Gm-Message-State: AOJu0YxBgzkdW9gkU79h16zwRPa08SW2HB4IyuthYGvwz1Yq2n1+pTIy
	Y+XhkYCfVzQ2v01FLB7VTthgQ+CzriGUuSE7mowAfGs2MSrNCi4ArkIb
X-Gm-Gg: ASbGncvXjU7JUo9UondKkbyqJV1pdtYqj63wPKX7pDC5+m0fX0rWKyiqstB45LvD6hQ
	3x4qaDTU+iC8m8AI7smVCOkikJ3wQSHMlaTJeBp4gpQvsS03DeOh/L2ZskRM4ZQyIpr1nwqHD9J
	f6PHXcc++6CaVyH6sqhtkDTTSykBAgsMA81wVTGTs/73VfhTaGUE6LJVLgQv7vBcdSuIrrPvofN
	opAU6VD5wKRgtYT0f5hH2Cnw+vJxPR63o1Fda9STttTKuIzIANbWRzwkmXLYNSI+Qy2gxwmIV1Z
	bHz8jOq8xx56lA0vq0SuPzixdEnY+o0YIEe7tzEghstTgV08X6qyfjqt6w==
X-Google-Smtp-Source: AGHT+IG2rcFkDZnfxA8AbezU0wE5k3NVrUZF2gDieAY2VbqDXC/B78wsCt7rKShawbOAmQaAWSzktw==
X-Received: by 2002:a17:902:fc4b:b0:234:9497:69e3 with SMTP id d9443c01a7336-237d9991a83mr4737985ad.25.1750370129184;
        Thu, 19 Jun 2025 14:55:29 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d869554asm2741295ad.191.2025.06.19.14.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 14:55:28 -0700 (PDT)
Message-ID: <04a5d2572ca2af1ec4dbc9cab5c61b1d0d9af0a9.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] selftests/bpf: Add testcases for BPF_ADD and
 BPF_SUB
From: Eduard Zingerman <eddyz87@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: ast@kernel.org, m.shachnai@rutgers.edu, srinivas.narayana@rutgers.edu, 
	santosh.nagarakatte@rutgers.edu, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko	
 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Matan Shachnai	
 <m.shachnai@gmail.com>, Luis Gerhorst <luis.gerhorst@fau.de>, Kumar
 Kartikeya Dwivedi	 <memxor@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-kselftest@vger.kernel.org
Date: Thu, 19 Jun 2025 14:55:26 -0700
In-Reply-To: <CAM=Ch05aDpkCZ7xF1Fs9SVrU8DFG7kofzRw4g4bkaUSdUsp3jQ@mail.gmail.com>
References: <20250617231733.181797-1-harishankar.vishwanathan@gmail.com>
	 <20250617231733.181797-3-harishankar.vishwanathan@gmail.com>
	 <5b3b620d04fc3bcf4286dc4bb8c6fd995df86a25.camel@gmail.com>
	 <CAM=Ch05aDpkCZ7xF1Fs9SVrU8DFG7kofzRw4g4bkaUSdUsp3jQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-19 at 17:13 -0400, Harishankar Vishwanathan wrote:
> On Wed, Jun 18, 2025 at 5:22=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Tue, 2025-06-17 at 19:17 -0400, Harishankar Vishwanathan wrote:
> > > The previous commit improves the precision in scalar(32)_min_max_add,
> > > and scalar(32)_min_max_sub. The improvement in precision occurs in
> > > cases when all outcomes overflow or underflow, respectively. This
> > > commit adds selftests that exercise those cases.
> > >=20
> > > Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
> > > Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
> > > Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gma=
il.com>
> > > ---
> >=20
> > Could you please also add test cases when one bound overflows while
> > another does not? Or these are covered by some other tests?
>=20
> Yes this is possible and I can add such test cases. These are not covered=
 by
> other tests as far as I can see.

Great, thank you.

> > > +SEC("socket")
> > > +__description("64-bit addition overflow, all outcomes overflow")
> > > +__success __log_level(2)
> > > +__msg("7: (0f) r5 +=3D r3 {{.*}} R5_w=3Dscalar(smin=3D0x800003d67e96=
0f7d,umin=3D0x551ee3d67e960f7d,umax=3D0xc0149fffffffffff,smin32=3D0xfe960f7=
d,umin32=3D0x7e960f7d,var_off=3D(0x3d67e960f7d; 0xfffffc298169f082))")
> >=20
> > Would it be possible to pick some more "human readable" constants here?
> > As-is it is hard to make sense what verifier actually computes.
> >=20
> > > +__retval(0)
> > > +__naked void add64_ovf(void)
> > > +{
> > > +     asm volatile (
> > > +     "call %[bpf_get_prandom_u32];"
> > > +     "r3 =3D r0;"
> > > +     "r4 =3D 0x950a43d67e960f7d ll;"
> > > +     "r3 |=3D r4;"
> > > +     "r5 =3D 0xc014a00000000000 ll;"
> > > +     "r5 +=3D r3;"
> > > +     "r0 =3D 0;"
> > > +     "exit"
> > > +     :
> > > +     : __imm(bpf_get_prandom_u32)
> > > +     : __clobber_all);
> > > +}
>=20
> It is possible to pick more human readable constants, but the precision g=
ains
> might not be as apparent. For instance, with the above (current) test cas=
e,
> the old scalar_min_max_add() produced
> [umin_value=3D0x3d67e960f7d, umax_value=3DU64_MAX],
> while the updated scalar_min_max_add() produces a much more
> precise [0x551ee3d67e960f7d, 0xc0149fffffffffff], a bound that has close =
to
> 2**63 fewer inhabitants.
>=20
> For the purposes of a test case, if human readability is more important
> than the demonstration of a large precision gain, I can prefer one that i=
s more
> readable, similar to the one shown in the commit message of v1 of the
> patch [1]:
>=20
> With the old scalar_min_max_add(), we get r3's bounds set to unbounded, i=
.e.,
> [0, U64_MAX] after instruction 6: (0f) r3 +=3D r3
>=20
> 0: R1=3Dctx() R10=3Dfp0
> 0: (18) r3 =3D 0x8000000000000000       ; R3_w=3D0x8000000000000000
> 2: (18) r4 =3D 0x0                      ; R4_w=3D0
> 4: (87) r4 =3D -r4                      ; R4_w=3Dscalar()
> 5: (4f) r3 |=3D r4                      ;
> R3_w=3Dscalar(smax=3D-1,umin=3D0x8000000000000000,var_off=3D(0x8000000000=
000000;
> 0x7fffffffffffffff)) R4_w=3Dscalar()
> 6: (0f) r3 +=3D r3                      ; R3_w=3Dscalar()
> 7: (b7) r0 =3D 1                        ; R0_w=3D1
> 8: (95) exit
>=20
> With the new scalar_min_max_add(), we get r3's bounds set to
> [0, 0xfffffffffffffffe], a bound that is more precise by having only 1 le=
ss
> inhabitant.
>=20
> ...
> 6: (0f) r3 +=3D r3                      ; R3_w=3Dscalar(umax=3D0xffffffff=
fffffffe)
> 7: (b7) r0 =3D 1                        ; R0_w=3D1
> 8: (95) exit
>=20
> Please advise which test cases to prefer. I will follow up with a v3.

Hm, I see, that's an interesting angle.
The problem is, if I do something silly changing the code and this
test fails I'd have a hard time understanding the expected output.
Therefore, I'd prefer something more obvious.

Maybe let's go with this:

  SEC("tc")
  __success
  __naked void test1(void)
  {
	asm volatile (
	"r3 =3D 0xa000000000000000 ll;"
	"r4 =3D 0x0;"
	"r4 =3D -r4;"
	"r3 |=3D r4;"
	"r3 +=3D r3;"
	"r0 =3D 1;"
	"exit;"
	:
	: __imm(bpf_get_prandom_u32)
	: __clobber_all);
  }

Here is verifier log comparison:

  master: 5: (0f) r3 +=3D r3     ; R3_w=3Dscalar()
  branch: 5: (0f) r3 +=3D r3     ; R3_w=3Dscalar(umin=3D0x4000000000000000,=
umax=3D0xfffffffffffffffe)

?

> [1]: https://lore.kernel.org/bpf/20250610221356.2663491-1-harishankar.vis=
hwanathan@gmail.com/
>=20
> [...]


