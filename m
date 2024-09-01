Return-Path: <linux-kselftest+bounces-16903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A1B967532
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 08:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F236A1F21663
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 06:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153AC3F9F9;
	Sun,  1 Sep 2024 06:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlgbX1dk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA9F2F28;
	Sun,  1 Sep 2024 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725170672; cv=none; b=hmpD2bJLB4HZrP8u4ysWfxsO5eGmL6gWhdWskOFC1ehSwqSc8VC04bgEEgnabMdvEjrnGq136x7JB1oZenOXReCzc2aSybZrrcD9k+ELrFxmH90NScMZ7GRGjvupSJvmAbJUQ/O0sGqe1Kj+A9IWXoKoZE6D6dEbQvpcoLLyeCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725170672; c=relaxed/simple;
	bh=tkE8cUpRalP3ZxWiBRvUFbQKVNvtHihMNEkXyRisTZc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWlVocOSWifeAQ+XmT4ZqHtkKSBKXlkcjgXdplG8tEA4sq8PFe10so2RVWG4cC+iVks52FRgmIb8CZVgtq78+zsnggGL1Zknkod/v9J+qasli4itO3qijsirvI8zixkk8aGSHUqZyI1vTvP34ucP59l6b6pSgId4txtFZk8MkEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlgbX1dk; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5dca997d29eso1938533eaf.0;
        Sat, 31 Aug 2024 23:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725170669; x=1725775469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FVTgD8hpg393/j8nAO6Q/HVJF4liVE9uHk31iLhpXVo=;
        b=NlgbX1dkrx9jP276oKfT/B+gv3af/wIF+uRr/KUaO6/z/Lox2p6BhNh1nW7yK91+qx
         hR6Sxel245f14gGV4h3Szom+CZ9rsPLTsMqOHZldx6QpM58H6WuRr+nCo6qHv47/Rp6x
         HChrRq3XS4n9pPU+KGlwrbVQR1gWvrGuVWwGRQoKyN/f/dqmN9ytQk+yGwKxaZvVujPl
         nXXFfboH2UVT4IhcjBThjR1O3u8CNadCoBqGKHKfD2cYNG7LFXt1GraZOffKVRgkCbBA
         zwz0Pdpxc7lpp3zus5bYMDl5OGwH778tTfDODNyXcU7ehic7ke95ZTV9037bxru1d060
         MbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725170669; x=1725775469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVTgD8hpg393/j8nAO6Q/HVJF4liVE9uHk31iLhpXVo=;
        b=aRWYih8oqRUp1ASAH+u1l4ysMOtm/vgu66FwyZZxxPNzF7z8sZZYO1/MZB1uGBXODZ
         PcHN/R6qytgxn6TwrG7WoyoioAOIcuxx5iwuToOJSnMxxIOMoun8LVD+4THelqedQkef
         b7b6myIwy+TeS1fGEuuCOMD4nYPcE6WTitbkjkkZ+tHuheXNrLMldjKdz65SuXpaQZ5m
         V80bFPu0pgx+vGsIhmnVtOQn2p3usQob3Tx2TrsYInukrnHx6flPQG965zCndj/UPoET
         4i6jTVE6lqC5pDUzKniUsQGY8v8jCRhhfO72dpSpU+3ZdXUugeheKqBOpqZJIhifRnj0
         elQw==
X-Forwarded-Encrypted: i=1; AJvYcCVuDVguHW17FZjC8Q9Sx+ssWcmcS47WnBJ4SNPs53B+wH0rlUIO62gSItSQRvQli7sAdMFp7aqZGAs7R3TesU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydDZ4kW4e4pBLw0/rDwepeYb275xj1TA5hsddl3V8PZiu3RijB
	e2lDsI3jpTJ2oUJYwNF9JSfbc2jY6vjAHsSnpGIZVDaHbV7a/NXQ
X-Google-Smtp-Source: AGHT+IG3GXvQrStymauWzFub5mVeezSBe+ZL8x6cfgTlah3+Cdd5nlY+shzUxB/bUh136uzVSf61jQ==
X-Received: by 2002:a05:6870:e38f:b0:260:fd20:a880 with SMTP id 586e51a60fabf-277c824a4a1mr4444290fac.42.1725170669544;
        Sat, 31 Aug 2024 23:04:29 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e569ecc8sm5128665b3a.140.2024.08.31.23.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 23:04:29 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Sat, 31 Aug 2024 23:04:26 -0700
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
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
Subject: Re: [PATCH bpf-next v4 5/8] libbpf: Support opening bpf objects of
 either endianness
Message-ID: <ZtQD6iTZHyoxolCQ@kodidev-ubuntu>
References: <cover.1724976539.git.tony.ambardar@gmail.com>
 <a12e83308e11b15501aa3b9e927bc94139418ce3.1724976539.git.tony.ambardar@gmail.com>
 <a0f0d8c8d15a9f1b59802037fdcfb39777b05f27.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f0d8c8d15a9f1b59802037fdcfb39777b05f27.camel@gmail.com>

On Fri, Aug 30, 2024 at 06:16:25PM -0700, Eduard Zingerman wrote:
> On Fri, 2024-08-30 at 00:29 -0700, Tony Ambardar wrote:
> 
> [...]
> 
> > @@ -940,6 +942,21 @@ bpf_object__add_programs(struct bpf_object *obj, Elf_Data *sec_data,
> >  	return 0;
> >  }
> >  
> > +static void bpf_object_bswap_progs(struct bpf_object *obj)
> > +{
> > +	struct bpf_program *prog = obj->programs;
> > +	struct bpf_insn *insn;
> > +	int p, i;
> > +
> > +	for (p = 0; p < obj->nr_programs; p++, prog++) {
> > +		insn = prog->insns;
> > +		for (i = 0; i < prog->insns_cnt; i++, insn++)
> > +			bpf_insn_bswap(insn);
> > +		pr_debug("prog '%s': converted %zu insns to native byte order\n",
> > +			 prog->name, prog->insns_cnt);
> 
> Nit: pr_debug already printed available programs at this point,
>      maybe move this call outside of both loops?
> 

Good point. Will update to summarize # of programs converted instead.

> > +	}
> > +}
> > +
> >  static const struct btf_member *
> >  find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
> >  {
> 
> [...]
> 

