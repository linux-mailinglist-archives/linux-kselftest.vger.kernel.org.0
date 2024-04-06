Return-Path: <linux-kselftest+bounces-7338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6C689AC92
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 19:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FEC21C20D22
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 17:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B8E45946;
	Sat,  6 Apr 2024 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5GUAPOu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A56E2C6A3;
	Sat,  6 Apr 2024 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712425944; cv=none; b=bgaNxc5PTtJ3+K2dDXiH/XLUYWob0b3gYDhmt1PvtWI8ZLVdpsU5hTb2xKPfWjfeBd1FgGEzKuLXmN2xWIxk3wBY0UcyMbdJ4QhMzMQNmNWEyqB+NAsoqc4x1ZOgw7p9S8iF/syzR7llc6dV81iZhziOM1n9qYlc4RNFy6x6LSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712425944; c=relaxed/simple;
	bh=W1xM/VSq2gneNYv2HVIv3G7mZh2o+62kNHhirdLTjpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBejpA67ZILmhvK/93WHIhh73LL4Uio8RpyXiYwp7yJg+Zzc75U8nrNTAgJxVZzGaFcTwTFzHabxHbq/n3pDDfYCOO9jBOyw8j8DFm6jFqbT3yalLFTl9VknIX2t86WAWGDHcibbWV08wZTd2n8bmG3PO85WGBSKrpfA0VHT3/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5GUAPOu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a2d0ca3c92so2049570a91.0;
        Sat, 06 Apr 2024 10:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712425942; x=1713030742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUm6wSMdLtwbZEYnU3hX6d8qHWQDsgW5Ca+Fql7mgtY=;
        b=b5GUAPOuk1hZBuHho8Ks+l7HSdF54vaXVS2ggJGlWLm+h9rsBY6tQa7XFkxPZrR4HD
         jvxE7oFfRmupEss4lxaGPRbldukGph7S3xflsYjlrkK6wHTTbVYFwJ4FKf4yy5S7HyT0
         RrA/r3x/OM4d5XjKIcucM/+ScQ0gXppEK3r4hr8as82ANU4hfna9jgV5joYVck7aJv1o
         E6FTElPMRWExtkkoXSACTHj9JbB99kFHyR/ncAwv+QfEYZQDIgLKlbgDDeBKmfwQ+GHi
         jN8MSTPP6XzhHDRgiI7o4z9bDX+yuAp90Jql+7WRDcHfwh2hn656llPBBwRMMUasIisw
         fykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712425942; x=1713030742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUm6wSMdLtwbZEYnU3hX6d8qHWQDsgW5Ca+Fql7mgtY=;
        b=vCm420MBS8dMMZ4nHbTlFNjmndRxxJRUOkXKTANEzhWGCYSo+EGIMhsXRhXH10h78T
         xCG39zKJLa1i6xrCeK4JF2gJYctGd27jvvyRJTKF0TDARsUl/COsHp2CaFN2aIm8UC48
         PCSXIDKf+xy4IhhnfyORbRwngUMBKjAxiYro1gBwT/BqRo/iAJZT5vQTMvcHL9t18mAu
         /8FkW8NsMvBU/pCUQoFihgmxz/mtlIv6eoIFYfbeOBm32NrE1x3JZjhGDxD3rqP2LHlr
         Ddth+7mnSOB8L6aiGfK/eApPQjTLzZcic495JiEf4qIdohvQws3dfgdAr4qDyE9zZYtd
         1lMg==
X-Forwarded-Encrypted: i=1; AJvYcCXL8k0AdoXCBbOFQ+lJCPbYtADJECijqmcEXl3pR17eY1R98gVTXeGVKUFSOy59RR7WnD3t+ORCyDoQM/9RQ1Hy3jnJB5S6vbGuZla3X4vXjrAUtm7Thm+3BabJKe09GRQAcJFVU/EJMQ9tLIGIPlVG7exzXMIYl87KTf8oWMgFAOZ8
X-Gm-Message-State: AOJu0YyFs3Opc1ww8/Kc+OFpRM8m/0HVkzF8eDdtddV71y3BPuaDJth7
	fNSxjBXN8tE899eMYyqQteEzYJNoiN5+Y9SeV4Idltr+KQkT/5WiBNG8GYClERNpLFoBSLxrYDi
	Msa1DyiXK2zbBNnTZ8mpIahaArYk=
X-Google-Smtp-Source: AGHT+IFZ+QlX4Y7Y65CxHv1F2RI37IWS4OebcNQfki3nPpFR6yLwxVA+w1LiYk8BpT1sKGfu/7pgRgzfR+PQ7VW/bk0=
X-Received: by 2002:a17:90b:fcd:b0:2a2:f16a:670e with SMTP id
 gd13-20020a17090b0fcd00b002a2f16a670emr7407664pjb.23.1712425942606; Sat, 06
 Apr 2024 10:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406092005.92399-1-andrea.righi@canonical.com>
 <20240406092005.92399-5-andrea.righi@canonical.com> <CAEf4BzanzbBaVgP7Qu8v4jnfsWt+9vJqB6D9G7NjE5QL+3iKXQ@mail.gmail.com>
In-Reply-To: <CAEf4BzanzbBaVgP7Qu8v4jnfsWt+9vJqB6D9G7NjE5QL+3iKXQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 6 Apr 2024 10:52:10 -0700
Message-ID: <CAEf4BzaR4zqUpDmj44KNLdpJ=Tpa97GrvzuzVNO5nM6b7oWd1w@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] selftests/bpf: Add tests for ring__consume_n and ring_buffer__consume_n
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 10:39=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Apr 6, 2024 at 2:20=E2=80=AFAM Andrea Righi <andrea.righi@canonic=
al.com> wrote:
> >
> > Add tests for new API ring__consume_n() and ring_buffer__consume_n().
> >
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/ringbuf.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/t=
esting/selftests/bpf/prog_tests/ringbuf.c
> > index 48c5695b7abf..33aba7684ab9 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> > @@ -304,10 +304,18 @@ static void ringbuf_subtest(void)
> >         err =3D ring_buffer__consume(ringbuf);
> >         CHECK(err < 0, "rb_consume", "failed: %d\b", err);
> >
> > +       /* try to consume up to one item */
> > +       err =3D ring_buffer__consume_n(ringbuf, 1);
> > +       CHECK(err < 0 || err > 1, "rb_consume_n", "failed: %d\b", err);
> > +
> >         /* also consume using ring__consume to make sure it works the s=
ame */
> >         err =3D ring__consume(ring);
> >         ASSERT_GE(err, 0, "ring_consume");
> >
> > +       /* try to consume up to one item */
> > +       err =3D ring__consume_n(ring, 1);
> > +       CHECK(err < 0 || err > 1, "ring_consume_n", "failed: %d\b", err=
);
> > +
>
> Did you actually run this test? There is ring_buffer__consume() and
> ring__consume() calls right before your added calls, so consume_n will
> return zero.
>
> I dropped this broken patch. Please send a proper test as a follow up.

Sorry, technically, it's not broken, it just doesn't test much (CHECK
conditions confused me, I didn't realize you allow zero initially). We
will never consume anything and the result will be zero, which isn't
very meaningful.

"Interesting" test would set up things so that we have >1 item in
ringbuf and we consume exactly one at a time, because that's the new
logic you added.

I think it will be simpler to add a dedicated and simpler ringbuf test
for this, where you can specify how many items to submit, and then do
a bunch of consume/consume_n invocations, checking exact results.

Plus, please don't add new CHECK() uses, use ASSERT_XXX() ones instead.

I've applied first three patches because they look correct and it's
good to setup libbpf 1.5 dev cycle, but please do follow up with a
better test. Thanks.

>
> >         /* 3 rounds, 2 samples each */
> >         cnt =3D atomic_xchg(&sample_cnt, 0);
> >         CHECK(cnt !=3D 6, "cnt", "exp %d samples, got %d\n", 6, cnt);
> > --
> > 2.43.0
> >

