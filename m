Return-Path: <linux-kselftest+bounces-16263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4AD95EF06
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 12:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA59C1F2493B
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 10:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2651155A43;
	Mon, 26 Aug 2024 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jlw6U/pY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345E714A4FB;
	Mon, 26 Aug 2024 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669517; cv=none; b=kJRNeoCUMCetavSbh7Lopb8LdoRHYgFmySRu9q0LvkTebJeyvODARNaHu8SoB/1YSfg0NNuoC71ObQWwmqGgmqAS/tB0xf0IsVhrG+S0iRsb/h6qmZxs7iTJGI+duPLDzDwl3woX/96xh/z5vnIQUaGmhZ1q6Arwy69O3G4Hi/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669517; c=relaxed/simple;
	bh=JQMuC8qs8TbeFgleINbhU4sKV6wErgSLk1InyBlgYDk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxbLYNbDzWdlfCU4VSWOzNYn5JQ3kutht+McM69JPm9/0efZHOIQANl0NOHHJ3b3eQ0lcBmFiDISaDdWTM5dG+AKLOwcBpTw2fhM+RFsqAFxIP8iZAZtr1zp86VOY8yqizJoHJTqm0lihCOLaHUjzJDNBgWHFtuI00m2CIIFJKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jlw6U/pY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d46f2816c0so3293172a91.2;
        Mon, 26 Aug 2024 03:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724669515; x=1725274315; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BEUxhxZg9fw7YEztoE73RzdwB/Yg7hcGcz/eB2SfUP4=;
        b=Jlw6U/pYObfMAAE9ThUOdtgbkMjbSbVrOLFFGyj7B8j1Vquuu7dwp69lS2WheNwSBD
         Ku3kr86LfcGdRA/syRXbn+M4hnO60lHWCpJzJtIvWN5bwTdCEvSe2bAHG5TzrZN0GZVj
         1ObijqChkN1OUII2aj6eS4H2g2z1jA2F+PuLCeLyHyulK8I5gvIlwgMGIFawNIuWjkLF
         uFIkq1nNbSqD2v0mzoVKBBykGIMLCfyKCN3HXycfiZvGwrAwzUkc+w7yTfmMbC1/WlWr
         Po/BJxrFp8yvB9rTbtENX8i43xVVCsRMwpewC5aWXMWK3mlsAC9h+EfoTeYP5ojaEVg9
         3+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724669515; x=1725274315;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BEUxhxZg9fw7YEztoE73RzdwB/Yg7hcGcz/eB2SfUP4=;
        b=QxnXppzjJBL1uY6JzV5KCYKiIhaNDz9Di3NIJFlu+myAfikt0Zf5JRxu9jebGbIXle
         zPX6Q8R3PMaILb8D/eJzdmD6y+LcgY4aLk2qt3G7osHsX6X8Vz7hAazO7bEJ+kRATCh9
         yBidX9pzVqDOouGyg8ICC8xS7m8dybZT6FXGek+FNBpWuk5s8p+WxBXcY6v9JT24LU6Z
         TrHHkdT+DeUNbwHYxTou5SwpCgajDZbFnhN9WuWkS/Yp0TeRd51+/kNvma283n0sNNy5
         9jhxgBAAcB5Pscp+kIakgFPcKlakac2LcY49jcMkPRR7I76NTS2e6CyLMv5UCtkCEsFW
         hizw==
X-Forwarded-Encrypted: i=1; AJvYcCVpb/ALo0v5Na19dk/HCtMHu9lpHL+688tYgSybOR8FK2pv1MoD1SAt8ksAQ5mwiy9SdnbJR/FnXuUexPaYHyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUpKlSleohBgUzA+YLClzkoU4hnXfuloJQkJyeAArXU3dBVKgl
	lA8/8jrAa2JIck7O9sPWpzbbscq4G+R6G6eBlaQOed5jvCDad5Jy85ZLXuzs
X-Google-Smtp-Source: AGHT+IFDXshyZ+GvqNZebAprSr3qfom1TGxQMTW4HKq4LaKZWz0s2NgDnKzPIIiJHqT5gm2u5zDi+Q==
X-Received: by 2002:a17:90a:88f:b0:2c9:96fc:ac52 with SMTP id 98e67ed59e1d1-2d646d4da53mr10403412a91.26.1724669515250;
        Mon, 26 Aug 2024 03:51:55 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb90c72dsm11736457a91.22.2024.08.26.03.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 03:51:54 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 26 Aug 2024 03:51:53 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v2 1/8] libbpf: Improve log message formatting
Message-ID: <ZsxeSYScsSHFtub5@kodidev-ubuntu>
References: <cover.1724313164.git.tony.ambardar@gmail.com>
 <884c0e57404f3ad15bb658bc55b7d16928069828.1724313164.git.tony.ambardar@gmail.com>
 <CAEf4BzbaZ8QpcEVQNU4+O-07eS6-BdQP9KXaJQysWt1uZPoXTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbaZ8QpcEVQNU4+O-07eS6-BdQP9KXaJQysWt1uZPoXTg@mail.gmail.com>

On Thu, Aug 22, 2024 at 04:36:13PM -0700, Andrii Nakryiko wrote:
> On Thu, Aug 22, 2024 at 2:24 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > From: Tony Ambardar <tony.ambardar@gmail.com>
> >
> > Fix missing newlines and extraneous terminal spaces in messages.
> >
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/lib/bpf/btf.c          | 7 ++++---
> >  tools/lib/bpf/btf_dump.c     | 2 +-
> >  tools/lib/bpf/btf_relocate.c | 2 +-
> >  tools/lib/bpf/libbpf.c       | 4 ++--
> >  tools/lib/bpf/relo_core.c    | 2 +-
> >  5 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 32c00db3b91b..cf4f7bd7ff5c 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -2940,7 +2940,8 @@ static int btf_ext_setup_info(struct btf_ext *btf_ext,
> >
> >         /* If no records, return failure now so .BTF.ext won't be used. */
> >         if (!info_left) {
> > -               pr_debug("%s section in .BTF.ext has no records", ext_sec->desc);
> > +               pr_debug("%s section in .BTF.ext has no records\n",
> > +                        ext_sec->desc);
> 
> if it fits in 100 characters, it stays in a single line, please don't touch that

OK, will do. Most of these are due to CI and local checkpatch, plus kernel
docs on style/submission guidelines. It can be hard to decide which
warnings/errors can be ignored and which apply, so it would be helpful at
least if the CI flavour of checkpatch aligned with guidance above. Not sure
what that involves, but sure that others besides me would benefit.

> 
> >                 return -EINVAL;
> >         }
> >
> > @@ -3028,7 +3029,7 @@ static int btf_ext_parse_hdr(__u8 *data, __u32 data_size)
> >
> >         if (data_size < offsetofend(struct btf_ext_header, hdr_len) ||
> >             data_size < hdr->hdr_len) {
> > -               pr_debug("BTF.ext header not found");
> > +               pr_debug("BTF.ext header not found\n");
> >                 return -EINVAL;
> >         }
> >
> > @@ -3290,7 +3291,7 @@ int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
> >
> >         d = btf_dedup_new(btf, opts);
> >         if (IS_ERR(d)) {
> > -               pr_debug("btf_dedup_new failed: %ld", PTR_ERR(d));
> > +               pr_debug("btf_dedup_new failed: %ld\n", PTR_ERR(d));
> >                 return libbpf_err(-EINVAL);
> >         }
> >
> > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > index 894860111ddb..25e7c44d9f95 100644
> > --- a/tools/lib/bpf/btf_dump.c
> > +++ b/tools/lib/bpf/btf_dump.c
> > @@ -1304,7 +1304,7 @@ static void btf_dump_emit_type_decl(struct btf_dump *d, __u32 id,
> >                          * chain, restore stack, emit warning, and try to
> >                          * proceed nevertheless
> >                          */
> > -                       pr_warn("not enough memory for decl stack:%d", err);
> > +                       pr_warn("not enough memory for decl stack:%d\n", err);
> 
> nit: add space after ':' while you are at it?

Right, done. Thanks!

> 
> >                         d->decl_stack_cnt = stack_start;
> >                         return;
> >                 }
> 
> [...]

