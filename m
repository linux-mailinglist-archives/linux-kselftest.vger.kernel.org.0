Return-Path: <linux-kselftest+bounces-15933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BDE95A79B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 00:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E486E1C229AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 22:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90601779BD;
	Wed, 21 Aug 2024 22:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0Ai9K+q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DBD170A2E;
	Wed, 21 Aug 2024 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724278062; cv=none; b=AIM1R0k/PJaU/hVnLW9QUQtDqK3bapzui8AiZFzLH7j6+JPR/dmEp73U7rYirXwiUFkvvjd8wdWwtiqNCr4kwc87cL9GstWG1/LTklR9Ufb0P/JuA6vIKaf/zy9ZZUBit0aHyY8peKKo8egCgphrnQbVA0cIAIdvWiNyViB1NaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724278062; c=relaxed/simple;
	bh=oKy04C+dcngOFBUyhRcRl2GEyUv5QIXqzGF1zfvynOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqX0xZsryeVUTwUFK1wkVgCakWtsU9KVIqtIYg8FCa5Pn7akmLNI1AahSqr7yTLLt3QTV3UMXGQ5WnuyivFSPd403Ai5mI9FBUA/q3v6PzKVcKx3LQluCa6sadbc693vC6BPXw26F3ooqYVjZOkJP8H5c4AdfU9WxVxyKzbVCFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0Ai9K+q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-429ec9f2155so827635e9.2;
        Wed, 21 Aug 2024 15:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724278059; x=1724882859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNNeTQGZqzDUNm3UJkRrDHxPTwVrMNbOn6wlIJHXkiA=;
        b=l0Ai9K+q4/WmWj/TJNSCZjqWIwP50S/PKOvOcV2K6l2MGFuHgvWJJkhYwsb2uUD7Pc
         3JbP6usDN27muMy00DklRxC/QRZ76z/x5mJ9vNV8UwxIOSlwVZ2tROFOJdKRLgBym/8b
         2fl//LqbKL3fXCDmZmj8FeMUgeJhbWXlXqNmRt9nYCOKI7JQidMCVnWnoVx9c9SRSof9
         5Yf7Zf4ibLphbr6M7RNBM2pnaps+q/qBij5JZchD7ExaZPrJoMkcoC2lHXjjPnqGVKTP
         Mv3x0opPevLHmPOOGYFlTdxsxnH//Vo7xmJTso9mo3VgneE+wFHI9Nbbkxq9VI9uRycB
         k/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724278059; x=1724882859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNNeTQGZqzDUNm3UJkRrDHxPTwVrMNbOn6wlIJHXkiA=;
        b=C5MVpk33J2dOi1Il2mGTnNQ+OHTN5I9zQqNcivppIrzrPmbLXJvk8r/4lGyZsAWKhv
         ioaS5gktucJfSTdrhWQKENASJqXwsuIML5qNWG/tNSuxF2b6BFKTOkmBo5xDncqsjCFW
         GB91BOoRFjEwRcfrn/lXEV2eM1etAfFTAj9lt3HC5rfXI4fbzQ9E+WpVwF2lwRCxHJnq
         E0TnCxU4x66MA3TGQm56XCbDtiBGGXrPlTV1QVjyFGP0GCcYjWxuPJL1dlPFVKw4h9eI
         hK1CH7prayvekGHE/x/WoRdtFEt34gj6eggZalad3ZXxeFmboo20z4WyjaEVDfcX+jHv
         NViA==
X-Forwarded-Encrypted: i=1; AJvYcCVISmbgNK175PyySSR6SCvCsw7hS4y2KRSvJQyspdUJb3vXOIxhmuM0//Sa0IoPiAGoWsn2vkZk5j/PzIRM@vger.kernel.org, AJvYcCXA+piV7PuZRd4IEOX5DXkjD8RnCNA+ImSxL6KpQjGtu8TU94S6PPXV7tASeFXF4SxJCA8wi74KaJ5bIeraDd90@vger.kernel.org, AJvYcCXMeUpInEi6unga13PEFaC/BjDh6IOP4XXvvt8mAEuASEjEN88i+hKJkklqpGPkzy8G3Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym0sQl5C9OcsBA6vZUlgdzMjiP7GXEA3OEoibsdY2lywHVD5uL
	n7vYGmY5qQj1j5nixfR0Xazhz6Q56OXICuX+jpuokhYlLAgBe639NvoQwKV2IybcrXkfb2HmeYg
	l03+3CbrKpcJ0Sx5pXzEd2t0shYQ=
X-Google-Smtp-Source: AGHT+IEUWEpPcfSUb0wNVH9crhyXPTop8DvlSYSWpMyhqYlhL6VCVZxNCkPpVQaubr9ZyyCaf0n2QTQG6JOZa0AmSoI=
X-Received: by 2002:a05:600c:4f50:b0:427:abed:3608 with SMTP id
 5b1f17b1804b1-42abf04881fmr25278935e9.5.1724278058840; Wed, 21 Aug 2024
 15:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820023447.29002-1-hao.ge@linux.dev> <02dd26b5-16a0-4732-80e4-c7bf183e965a@linux.dev>
 <58f57d70-a787-4012-8763-cc6eb642ef8a@stanley.mountain>
In-Reply-To: <58f57d70-a787-4012-8763-cc6eb642ef8a@stanley.mountain>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Aug 2024 15:07:27 -0700
Message-ID: <CAADnVQ+iTrTmbMcjt7fR7uTS=1tFcjv=z2CY6fO-4=kkM4YSMw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix incorrect parameters in NULL pointer checking
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yonghong Song <yonghong.song@linux.dev>, Hao Ge <hao.ge@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 2:50=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Wed, Aug 21, 2024 at 02:03:17PM -0700, Yonghong Song wrote:
> >
> > On 8/19/24 7:34 PM, Hao Ge wrote:
> > > From: Hao Ge <gehao@kylinos.cn>
> > >
> > > Smatch reported the following warning:
> > >      ./tools/testing/selftests/bpf/testing_helpers.c:455 get_xlated_p=
rogram()
> > >      warn: variable dereferenced before check 'buf' (see line 454)
> > >
> > > It seems correct,so let's modify it based on it's suggestion.
> > >
> > > Actually,commit b23ed4d74c4d ("selftests/bpf: Fix invalid pointer
> > > check in get_xlated_program()") fixed an issue in the test_verifier.c
> > > once,but it was reverted this time.
> > >
> > > Let's solve this issue with the minimal changes possible.
> > >
> > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Closes: https://lore.kernel.org/all/1eb3732f-605a-479d-ba64-cd14250cb=
f91@stanley.mountain/
> > > Fixes: b4b7a4099b8c ("selftests/bpf: Factor out get_xlated_program() =
helper")
> > > Signed-off-by: Hao Ge <gehao@kylinos.cn>
> >
> > In the future, please change subject '[PATCH] ...' to '[PATCH bpf-next]=
 ...'
> > so CI can properly test it.
>
> It feels like there should be a technical solution to this.  The CI syste=
m is
> something on AWS and it's too expensive to just check every patch that's =
sent to
> the bpf list?  My understanding is that there are only two bpf trees.
>
>         if [ "$FIXES_HASH" =3D=3D "" ] ; then
>                 TREE=3Dnext
>         elif git merge-base --is-ancestor $FIXES_HASH origin/master ; the=
n
>                 TREE=3Dlinus
>         else
>                 TREE=3Dnext
>         fi
>
> These days the zero day bot people are checking around a thousand git tre=
es.
> They pull emails off the various lists and apply them to the right places=
.  It's
> a doable thing.

Dan,

Various people pointed out that you need to use the proper subject in
the patches.
You clearly knew that rule and yet you ignored it,
and worse still you keep coming up with these excuses.
Don't be surprised that people who are supposed to review your patches
will take a long time to reply or "forget" about them as you "forget"
about patch submission rules.

