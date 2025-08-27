Return-Path: <linux-kselftest+bounces-40050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4DBB3810A
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 13:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA4E17F868
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 11:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC2934F49C;
	Wed, 27 Aug 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="OSrxPNgG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E111B34DCCA
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294068; cv=none; b=W6L5KjZB2h8jVRaCatVnRuEi5tNPJdJZynTQ00gBQqdjT5U0TP6V2dxbgpBZrEBco8AfjNPFeAX90zRPKhRjLazuXYuwQ5RlrstOFOz6uq/8srnqwPV0VaVGX2lXdYKrh4zX4uSUfgDHTbUkYK+gv6fvbn6VbEXNKzweQebRGi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294068; c=relaxed/simple;
	bh=PEuf/FgXr765VP9UAfvrHJzwAyD+rhSs/Wdo94CtjkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfbJeCqjBxFCpe5M3Y2TUZTsyMSZ3rCdjDw3izvo/ee3CCteGMynqrTMnxtqqKxHtA1NnsSErKmONPpWhDC9Kt2m68ocLqwdwp10EWJHXuaGnbw0p4pnyTBiVDINkPitNIJdCf+k+Tfl4nIgsC8KMhT5zGK4EmtblUzg6TfSO64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=OSrxPNgG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2460757107bso61900995ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1756294066; x=1756898866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/jwl81pdw1HxKkspLwWnkr4Y7z1K3MHPBPRksjOD1I=;
        b=OSrxPNgGxg8l44X3ItDwAs+TY67c2ohn8Mbi/RQeI/end+03TLXnm6SFfjItTEl+FF
         0hpVv8R2KJn+jTNFOKqLDdbtapZdMavS90sXIRn6w1/9Aj5aP9qq8Pnt8k+vNrJOhJ6H
         QKLTcYBYfuoxqVAL/5UNuAymJNsRn+ZRWZTg33iHF8UJJeuIBGd+h46V815Q2g4M97mI
         WVuXZzowdEhGeX5xG+T0JgzmGl/bG1Xw4Eif1WYbRosASwgqoDmcdbbOFeBQUuv5y4Yw
         swkWOSiA/0DdvwKxUnM+AVXbbVwgWC1rhDhJ3E5+ZMiB7wUIHHTUfzZpdDZHbBNfKvfW
         o9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294066; x=1756898866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/jwl81pdw1HxKkspLwWnkr4Y7z1K3MHPBPRksjOD1I=;
        b=ckgW8OjIeNKyl3Gu/tg3fRobTElZM/OiEYiESYegl+BqhlcBujGwSaWS8RbZcKvAC9
         tNt4QIzwXhfpczAmiHckEdZnvVI1YEovd4LcM9SmGZLmijIolNTyon2lsIwlyKtrmwBy
         BWauqcAD9ns4uhN/zH+ph7/lMgh6CC+t+TCxfEVjtG78BhtHi3JVWjATcV2JzYRLn8Wl
         p24Coga4qiWbhKZ9PP7oWmFepCCOEccw2h+EAS/FJPyOzoWqleYO1/XSHswGXB7pKUfF
         Zt+IwdRZ2tpf27k3ARrQ2Vwf+TflYrgrUvLS7FeoVxsgA08/5hhcK2PZ7bIGX0+Y3uxQ
         JNzw==
X-Forwarded-Encrypted: i=1; AJvYcCUqGHOrLdqNpqjqVzmwGpmPW+UC1Sxj2ppaPKTNx97jwHqHLSMqD2hp8BN46iSIYF6c/nH55o1zLUmOwZNt7d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMGedJeNrQEpfdg73t1iheDAODK2p3lcnFoiuiIPnA8jLq+P+0
	mtS5pNCveWbkfOBfdVZ6mb4eapO5aKT4KG9+YK4Y8mQV/AsFPDkCinUzKathv1QL4sGiz4rIHU7
	RbTAuM0C1yZ2+DPszhmcO4/wHthV0O6otGbLo4tAYfw==
X-Gm-Gg: ASbGnctM80dEJmVkCqsj9XLLXhxwUgw2n6chMy+hqOFcUKpSpQk602VytmvEcyxDrfI
	401PE55uM2ckGxP/nGIKnzEWjIx9kKwMMqFsX+u+YQh2ThoBYHuZc4qV2DxcvaVBAIRlj1QwJrK
	o7DWvjBL7WHBBIN/8RXLcvl1QnEG/t1W7ebmZQ3wqV7Jj3TeCYK447z7xkFiYVu8tH5zP3T85a+
	3pAeJsoLHVQHpi4zGe4idQ=
X-Google-Smtp-Source: AGHT+IFzKBVLIyX32GRylpiH9ADpqFb0pk9OE/yfaJMr8XyWxnfkKtislE3eyuYu47aWVxFR3WGpR9F0jtF9zhU4jlA=
X-Received: by 2002:a17:902:c404:b0:246:464d:1194 with SMTP id
 d9443c01a7336-246464d13f7mr308106115ad.2.1756294066093; Wed, 27 Aug 2025
 04:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826131158.171530-1-matt@readmodwrite.com> <CAADnVQ+=bYcR6whXxEPst4a4n1eKeDXp4tO8Q2wEx_6GbwqMFg@mail.gmail.com>
In-Reply-To: <CAADnVQ+=bYcR6whXxEPst4a4n1eKeDXp4tO8Q2wEx_6GbwqMFg@mail.gmail.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Wed, 27 Aug 2025 12:27:34 +0100
X-Gm-Features: Ac12FXwG-oggcOGL4Q0g3dkKRhaG6nPFoY2p3ZGwYD8mjM7xk1b9ejCDM747Znc
Message-ID: <CAENh_SQo2-28P-QnN2Jga_dq_3qc451RS0Wc1UQuvxqvK+NM6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] selftests/bpf: Add LPM trie microbenchmarks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 12:50=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 26, 2025 at 6:12=E2=80=AFAM Matt Fleming <matt@readmodwrite.c=
om> wrote:
> >
> > +static int baseline(__u32 index, __u32 *unused)
> > +{
> > +       struct trie_key key;
> > +       __s64 blackbox;
> > +
> > +       generate_key(&key);
> > +       /* Avoid compiler optimizing out the modulo */
> > +       barrier_var(blackbox);
> > +       blackbox =3D READ_ONCE(key.data);
>
> Overall looks good, but gcc-bpf found an actual issue.

Thanks. I'll submit a v5 with a fix shortly.

