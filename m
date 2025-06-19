Return-Path: <linux-kselftest+bounces-35388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD08AE0EDE
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 23:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0981BC4751
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 21:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BC125DAE1;
	Thu, 19 Jun 2025 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUl832LD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A9220686;
	Thu, 19 Jun 2025 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750367638; cv=none; b=KTrp8A28dvyEG5XtrEhWpGVZW/zrzsSsMc75OewRg3YjYsiKVGbyhDzYULwjSsZkahM0ILPLfzCf14efaKcAbVWKBWND2bhEv7TFsKK7yMXDtQtp+ilvCxSkH0qNmt2ngQ7I93s0lHiqtouXvkIBc1QkjXnAi1+5NYb6yFU+wN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750367638; c=relaxed/simple;
	bh=coKPhq4+2hLzHk2Vv74+S3aBbSgJT3Rpv9BsWDpud4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6W1/VfU1A9Lx6HV+r77W1xyqk7VXz2bRDZkZisdaqLoHo/7AHSubpvZZaO3o52Pf/pgUqCf4oPZPXVfkWvm/A1AtQ86nv/Upg5817iRAPLQPVokr4nEancFutc335J3CkzsexUwg5oJIezoMW7I5oe3+AXAqlTjHIfimPdCiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUl832LD; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5316a5e4c6cso380494e0c.1;
        Thu, 19 Jun 2025 14:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750367635; x=1750972435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IXOfDU+bla/iqbB8KlX3pd8vBetpC4ORWvQkQPMFNU=;
        b=MUl832LDG71go67T/5TCopj8W2uaXsIobIo3QW13MbuzIXr7GWTTyetpAQ1YeTpiRi
         Yk/JIVXM24LdDCGjgI65Uyr+F6AJe/0EfeIMqm0/2lB6+ohVdyjR1DjFrkea8y2EqG+3
         VFv/OIf5B1bJtYAW7rsypqeMe1f7bnFwpD5nqf8dMFT4XYiQrM2Ya1J2z2Zx407mFLxx
         N9WpKcfqmPqqoOX1JzJxSYOy2ATRGRb68mXzqEh1l0RwiY72W9yct2YS1e7sSq+etiGp
         1sDGRCXWRHRikI2nPKVlQDBWVXsQM6m6gthm0qL5wIwsFwnLIH2Je1wyud2i2TB6x29d
         PZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750367635; x=1750972435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/IXOfDU+bla/iqbB8KlX3pd8vBetpC4ORWvQkQPMFNU=;
        b=BcW28pj2uvjy6SIsL+Sofn8Xv6z5VUTE22BjE1BkJMKy1aC9gRCHprDIsghi4o77AU
         43V053Yo2QwVqVoqOiyox8kaf1xjyqQVBgrw34zqmb8UWJisUJprexGE8F5hHC36l6Yo
         sikc9e+jhyHWznO9WTbb2ygi9haa62RWPmOylyGLZxYCE0dBBlKNWdtZRz9/cFVCBWMo
         oZYGZtOuD6/VK3zsZq7iEK+3SqzKW6K+cacN+qS2gWgHQTgVzBkoAAgI0Ll/+6eFJhR9
         GPSErovJIvhEuwgzuuOYkkfRo4B1dFH82x6ALSd2YSudg6z/5Oeb8BMlZ3JoNAKlNOg9
         WO9g==
X-Forwarded-Encrypted: i=1; AJvYcCVaWyYjYoRnvNwnzCdpk6bHeS+CLMCh5ifKtzwHRny59HZUXSzyX1xH8xdWKtI/8FnNxMs=@vger.kernel.org, AJvYcCWzdsrXPDnGoIUgVnpCZW0udmii4ZFNZ+x6GjnHMHfO0qoDh5SFMtIPqBypKCfT1p/bz5GSfLyTLI0V97zRm0uJ@vger.kernel.org, AJvYcCXp3CgoDTgriGQR4WQ4v8vLN2/QxxETZAeXIe5kOonHLAaoaLN+0JFBjRd8BplzMVfRCWCjLO2ZXaOVTAnq@vger.kernel.org
X-Gm-Message-State: AOJu0YyP35OQfv/ohIyZ2K4/Lp+mm6O3iqukFPEWlSf48zsJfrTteNVN
	LmGB1hoWvx5c5REAvbDUnp4A6S+D/3VEs+4ccCjP7ORov5If2B20GZp92FKYNnMW8lbccVwLvpt
	ebE8F4KCN7WEj8RFaJwO2X6Ndt6Xiz5Q=
X-Gm-Gg: ASbGncuaSqzsM6V+9JXykqmxQzXtxW2j0kk1Oz7DltDg7Ka96y4oCY5gvTdvr97uRCu
	5o15N5UGFdBdIDFiIYhuAk8X4ToYZsXeaEEPbz87jds5wzTkt4HPni8cV1BoupyozMbLl9Areg6
	vLKkdoMnafKjR3erUo1fjiA0eGJuTFvm1ludL/vRnb2Bg/ZNewoUNxThCMtek8X+MZtXKdtPRBo
	eBxJmkjef7pI1mS
X-Google-Smtp-Source: AGHT+IGl0oUSKOpRmEhg+kx9sWrnrLDZfdXeYRWElnoTRLVTKG2/s36JBcvxB8foyh0sNRF54dkKSCz1NPQILNMLfaU=
X-Received: by 2002:a05:6102:3913:b0:4dd:b82d:e0de with SMTP id
 ada2fe7eead31-4e9c2f59589mr315371137.17.1750367635575; Thu, 19 Jun 2025
 14:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617231733.181797-1-harishankar.vishwanathan@gmail.com>
 <20250617231733.181797-3-harishankar.vishwanathan@gmail.com> <5b3b620d04fc3bcf4286dc4bb8c6fd995df86a25.camel@gmail.com>
In-Reply-To: <5b3b620d04fc3bcf4286dc4bb8c6fd995df86a25.camel@gmail.com>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Thu, 19 Jun 2025 17:13:44 -0400
X-Gm-Features: Ac12FXwH3RlUZr147tzxEGZzSM-Q9TBhDMdLnQfw2zufhATIdJ6J846D1omd9oI
Message-ID: <CAM=Ch05aDpkCZ7xF1Fs9SVrU8DFG7kofzRw4g4bkaUSdUsp3jQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selftests/bpf: Add testcases for BPF_ADD and BPF_SUB
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, m.shachnai@rutgers.edu, srinivas.narayana@rutgers.edu, 
	santosh.nagarakatte@rutgers.edu, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Matan Shachnai <m.shachnai@gmail.com>, 
	Luis Gerhorst <luis.gerhorst@fau.de>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 5:22=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2025-06-17 at 19:17 -0400, Harishankar Vishwanathan wrote:
> > The previous commit improves the precision in scalar(32)_min_max_add,
> > and scalar(32)_min_max_sub. The improvement in precision occurs in
> > cases when all outcomes overflow or underflow, respectively. This
> > commit adds selftests that exercise those cases.
> >
> > Co-developed-by: Matan Shachnai <m.shachnai@rutgers.edu>
> > Signed-off-by: Matan Shachnai <m.shachnai@rutgers.edu>
> > Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail=
.com>
> > ---
>
> Could you please also add test cases when one bound overflows while
> another does not? Or these are covered by some other tests?

Yes this is possible and I can add such test cases. These are not covered b=
y
other tests as far as I can see.

[...]

> > +SEC("socket")
> > +__description("64-bit addition overflow, all outcomes overflow")
> > +__success __log_level(2)
> > +__msg("7: (0f) r5 +=3D r3 {{.*}} R5_w=3Dscalar(smin=3D0x800003d67e960f=
7d,umin=3D0x551ee3d67e960f7d,umax=3D0xc0149fffffffffff,smin32=3D0xfe960f7d,=
umin32=3D0x7e960f7d,var_off=3D(0x3d67e960f7d; 0xfffffc298169f082))")
>
> Would it be possible to pick some more "human readable" constants here?
> As-is it is hard to make sense what verifier actually computes.
>
> > +__retval(0)
> > +__naked void add64_ovf(void)
> > +{
> > +     asm volatile (
> > +     "call %[bpf_get_prandom_u32];"
> > +     "r3 =3D r0;"
> > +     "r4 =3D 0x950a43d67e960f7d ll;"
> > +     "r3 |=3D r4;"
> > +     "r5 =3D 0xc014a00000000000 ll;"
> > +     "r5 +=3D r3;"
> > +     "r0 =3D 0;"
> > +     "exit"
> > +     :
> > +     : __imm(bpf_get_prandom_u32)
> > +     : __clobber_all);
> > +}

It is possible to pick more human readable constants, but the precision gai=
ns
might not be as apparent. For instance, with the above (current) test case,
the old scalar_min_max_add() produced
[umin_value=3D0x3d67e960f7d, umax_value=3DU64_MAX],
while the updated scalar_min_max_add() produces a much more
precise [0x551ee3d67e960f7d, 0xc0149fffffffffff], a bound that has close to
2**63 fewer inhabitants.

For the purposes of a test case, if human readability is more important
than the demonstration of a large precision gain, I can prefer one that is =
more
readable, similar to the one shown in the commit message of v1 of the
patch [1]:

With the old scalar_min_max_add(), we get r3's bounds set to unbounded, i.e=
.,
[0, U64_MAX] after instruction 6: (0f) r3 +=3D r3

0: R1=3Dctx() R10=3Dfp0
0: (18) r3 =3D 0x8000000000000000       ; R3_w=3D0x8000000000000000
2: (18) r4 =3D 0x0                      ; R4_w=3D0
4: (87) r4 =3D -r4                      ; R4_w=3Dscalar()
5: (4f) r3 |=3D r4                      ;
R3_w=3Dscalar(smax=3D-1,umin=3D0x8000000000000000,var_off=3D(0x800000000000=
0000;
0x7fffffffffffffff)) R4_w=3Dscalar()
6: (0f) r3 +=3D r3                      ; R3_w=3Dscalar()
7: (b7) r0 =3D 1                        ; R0_w=3D1
8: (95) exit

With the new scalar_min_max_add(), we get r3's bounds set to
[0, 0xfffffffffffffffe], a bound that is more precise by having only 1 less
inhabitant.

...
6: (0f) r3 +=3D r3                      ; R3_w=3Dscalar(umax=3D0xffffffffff=
fffffe)
7: (b7) r0 =3D 1                        ; R0_w=3D1
8: (95) exit

Please advise which test cases to prefer. I will follow up with a v3.

[1]: https://lore.kernel.org/bpf/20250610221356.2663491-1-harishankar.vishw=
anathan@gmail.com/

[...]

