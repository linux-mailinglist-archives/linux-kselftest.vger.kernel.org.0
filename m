Return-Path: <linux-kselftest+bounces-7357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDA089AF70
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 10:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7268B207A6
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Apr 2024 08:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B952E1876;
	Sun,  7 Apr 2024 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="kRJ0Uw0u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876AD14A8F
	for <linux-kselftest@vger.kernel.org>; Sun,  7 Apr 2024 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477404; cv=none; b=R6jSfMd0tRAMhLu2mIY7t6WsPs1A+Ry0oZlwQmdV0CaQrWGPSe1ffC9LqMgqkrn35cCNUAC6sxAGPZtdSo/XbLlJuWtOvV+zGXtRQFEauT0nLpsh6xM2E1Ezh9Rs9oQgzQHpB37UE54M8ZTMBx+1xdygcHv88i3dujuAKIaUKWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477404; c=relaxed/simple;
	bh=VBnMmaY/jSdSTkC4TB/mxJq/6u5SVhMScG2xHkwOpHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JymZGH4sgPD9a5OriJXsgi0cKlwJdlz2L1K/ZPVrRsh2iko4D7IReFbupSEInIJmvnQKCJOjAZsyZiW7r5nK03FpYwe4uWRdI5mqpDwKc48keBVWcHQo2gR6+U0uiUXBT9D9aWMesWocXWflKtB6nxkTqHtT5q3Nj852qtOq9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=kRJ0Uw0u; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 08F9A3F231
	for <linux-kselftest@vger.kernel.org>; Sun,  7 Apr 2024 08:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712477395;
	bh=MRAOR6NXs+WDh7P3Pk4nsf9IHt46kV2t0C6KeL8Xd0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=kRJ0Uw0u6uzC0GNue0afmq/wg+Ngdj9pUFHlWctEyoLdMWVZIpw0gymzbRum5lRoU
	 hTyr9GBm7sGstGp/T+hAK8RBaOybrSodWtpeES5ghbYZzKAMiCRjatb44a0RiL9cLD
	 pLY8g1/UplkOCoV9UGX1Vju0GMqGn/BLYPcOi5nVok1rLA9n0mb8uQmcyGkYozcklu
	 fbH/TY4ZB8WlUNyOT/Qe9BabOnYOCTQsyfE+PSX65pKXENyyO8oCSppX9ybOABbZvi
	 jPZciZpIXH7veMjp3LhLiOiQIEyGQE/tmiviAWBVfV4nS1hd9SNxOIJd3BCGXeP8ZT
	 953qCDspOKmIg==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343d1d16d9fso1453172f8f.1
        for <linux-kselftest@vger.kernel.org>; Sun, 07 Apr 2024 01:09:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712477394; x=1713082194;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRAOR6NXs+WDh7P3Pk4nsf9IHt46kV2t0C6KeL8Xd0c=;
        b=c0Gw+9XG0f0qC4/OizndpG/xI2zwdMj27yhUVkauJwnCq352jntUWoxKffnDL8jH+S
         WEXIrPrs3vshBt9zdec0r4RRkGzmwGhFv58QKL3jYLGz7rcPVlSLYk0kbbXYAwBvm2aD
         RSzOMlIL8R6Jgr6VdCh/DO1tSCj29msblQgiDNJ915eDpJg3DPsn16lNCQleD51skhxc
         5NDaurFro5Y27FomsDKB2waMLoBgX9/iZaUgGfDhT7hf0t/Kn4bG61JDuCRYWc5rCg7d
         gerfsZ2SpzohHfZ3a7upEF7fLXJQS3e3FiykPSGAFc5XZSKT7g+9D/GTlUP29kBJdaAP
         p+GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfoMkdyGo7iL7/0Wv/kMhlg/BmbIM20t1rIfQ+S+cMeVVvlj/YGjXuLsuCuccDHbWP0q5kOd3Vw08yqxB5kEd0JHf3JXnGa5gIyy22IC6m
X-Gm-Message-State: AOJu0YyteDuL9UeaP8S7s7UiP4AkroSBQYyYZEHZ/6oCKdSmcr5TB6We
	8rVc+Zb0ivpy6UmaTCqo4ardcdm359CXGzHUmIaBKzHL5UJ2+sy1JcDuSjNDaH0rDZ4c6CjA5UM
	OUFfbDX7HNMCMSVwDu6+GLXBEXJf03vW8+jVWj5UYyaKRRGu0G4mPc1HaqTcf/SGyPYKX6RuqsF
	S/3f1ilA==
X-Received: by 2002:adf:fed1:0:b0:343:a183:4218 with SMTP id q17-20020adffed1000000b00343a1834218mr4431414wrs.52.1712477394383;
        Sun, 07 Apr 2024 01:09:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7O+B0XCMESRc4pHeuqRzfZFND+/CmarJwhrJTwar81zScxLL0MtBoOtKhKPuUzsu2gsRPkA==
X-Received: by 2002:adf:fed1:0:b0:343:a183:4218 with SMTP id q17-20020adffed1000000b00343a1834218mr4431370wrs.52.1712477393487;
        Sun, 07 Apr 2024 01:09:53 -0700 (PDT)
Received: from localhost (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id q13-20020a056000136d00b00343e3023fbasm5866411wrz.34.2024.04.07.01.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 01:09:52 -0700 (PDT)
Date: Sun, 7 Apr 2024 10:09:47 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] selftests/bpf: Add tests for ring__consume_n and
 ring_buffer__consume_n
Message-ID: <ZhJUy6nWFOFi8oT_@gpd>
References: <20240406092005.92399-1-andrea.righi@canonical.com>
 <20240406092005.92399-5-andrea.righi@canonical.com>
 <CAEf4BzanzbBaVgP7Qu8v4jnfsWt+9vJqB6D9G7NjE5QL+3iKXQ@mail.gmail.com>
 <CAEf4BzaR4zqUpDmj44KNLdpJ=Tpa97GrvzuzVNO5nM6b7oWd1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaR4zqUpDmj44KNLdpJ=Tpa97GrvzuzVNO5nM6b7oWd1w@mail.gmail.com>

On Sat, Apr 06, 2024 at 10:52:10AM -0700, Andrii Nakryiko wrote:
> On Sat, Apr 6, 2024 at 10:39 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Apr 6, 2024 at 2:20 AM Andrea Righi <andrea.righi@canonical.com> wrote:
> > >
> > > Add tests for new API ring__consume_n() and ring_buffer__consume_n().
> > >
> > > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > > ---
> > >  tools/testing/selftests/bpf/prog_tests/ringbuf.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> > > index 48c5695b7abf..33aba7684ab9 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> > > @@ -304,10 +304,18 @@ static void ringbuf_subtest(void)
> > >         err = ring_buffer__consume(ringbuf);
> > >         CHECK(err < 0, "rb_consume", "failed: %d\b", err);
> > >
> > > +       /* try to consume up to one item */
> > > +       err = ring_buffer__consume_n(ringbuf, 1);
> > > +       CHECK(err < 0 || err > 1, "rb_consume_n", "failed: %d\b", err);
> > > +
> > >         /* also consume using ring__consume to make sure it works the same */
> > >         err = ring__consume(ring);
> > >         ASSERT_GE(err, 0, "ring_consume");
> > >
> > > +       /* try to consume up to one item */
> > > +       err = ring__consume_n(ring, 1);
> > > +       CHECK(err < 0 || err > 1, "ring_consume_n", "failed: %d\b", err);
> > > +
> >
> > Did you actually run this test? There is ring_buffer__consume() and
> > ring__consume() calls right before your added calls, so consume_n will
> > return zero.
> >
> > I dropped this broken patch. Please send a proper test as a follow up.
> 
> Sorry, technically, it's not broken, it just doesn't test much (CHECK
> conditions confused me, I didn't realize you allow zero initially). We
> will never consume anything and the result will be zero, which isn't
> very meaningful.
> 
> "Interesting" test would set up things so that we have >1 item in
> ringbuf and we consume exactly one at a time, because that's the new
> logic you added.
> 
> I think it will be simpler to add a dedicated and simpler ringbuf test
> for this, where you can specify how many items to submit, and then do
> a bunch of consume/consume_n invocations, checking exact results.
> 
> Plus, please don't add new CHECK() uses, use ASSERT_XXX() ones instead.
> 
> I've applied first three patches because they look correct and it's
> good to setup libbpf 1.5 dev cycle, but please do follow up with a
> better test. Thanks.

Yeah, sorry, I tried to add a minimal test to the existing one, but I
agree that it not very meaningful.

I already have a better dedicated test case for this
(https://github.com/arighi/ebpf-maps/blob/libbpf-consume-n/src/main.c#L118),
I just need to integrate it in the kselftest properly (and maybe
pre-generate more than N records in the ring buffer, so that we can
better test if the limit works as expected).

I'll send another patch to add a proper test case.

Thanks for applying the other patches!
-Andrea

> 
> >
> > >         /* 3 rounds, 2 samples each */
> > >         cnt = atomic_xchg(&sample_cnt, 0);
> > >         CHECK(cnt != 6, "cnt", "exp %d samples, got %d\n", 6, cnt);
> > > --
> > > 2.43.0
> > >

