Return-Path: <linux-kselftest+bounces-13946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE482937E98
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 03:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5042824D4
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 01:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7AD137E;
	Sat, 20 Jul 2024 01:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzA4n+Tt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58952F5A;
	Sat, 20 Jul 2024 01:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721438637; cv=none; b=Y35iaOWKk5Y8THl/YLtGTjH9BnAqiehaLnAGSfJKK0pGuu6igosaO9bmCtPaILPBHMVC+HV5/15ouLkKFg/zJegUPsV8/h6blmPVZ66d2qyl5MKDnylfCDjKlgKF0gHc2zhKy0dAQ2OhTT0IgDR3G61d+3wDiOrYzM6fj2Ov4kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721438637; c=relaxed/simple;
	bh=YjsPGDJze/eRMGpRihYPVc7fmewxZ5JK7jHG4/QQCEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V0FU4JqRtR9oWdE9Jbxy9HhsAQlXKYbF7f+T2isLyGGRopZ5plbtw5wpEo5+YTzbtsUJrldbxXUfB4yCa0NDVP7F2wpaY4GX1fcUMKJJCY6DPIKztS55xlkKL8/G2IBJ2K/j+0PmuGXOdcBhHBLmt3bKL2czeT6KwoSpe7wkUoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzA4n+Tt; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70365f905b6so1543161a34.0;
        Fri, 19 Jul 2024 18:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721438635; x=1722043435; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZMLawc7nAUx/tOEFuGis/R56ccPrSCXPhyN/hwUyKbw=;
        b=fzA4n+TtlEw6/9hB730ILSSG5kPGQ1vdeNjNSPFd1jGylGi4DLbIwQ8HVljbR2Idp3
         ToC0MR934eX73pJzfG/ovlOV3Lpoa90txp48ItDWA9dRp0yygsc3Y8V91hG2R3EPq3KE
         sG71xVbDhNb1AEbEE3vT8COXtPDx8w3VXxe9vUqjDyT0qbgnQ1HZUfM29gtw5CbL/9GG
         oEGFTblzYF8XgIIq7smkKKMnqRzAOS4uwtE4vo6EE7BBjnwefcqK9KUGnLFvHwRYpim+
         CPxWhcuinOwoyhFVq7K5qtSiCwP8enwZRtDGZRYPkulxJr7g/mUPokFxSn8K9TuXPast
         MHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721438635; x=1722043435;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMLawc7nAUx/tOEFuGis/R56ccPrSCXPhyN/hwUyKbw=;
        b=RQjwG72AFHGg1/qe+PahS/a+ZcK+TJRK7rx7RRL1ilZYUwxweXAf9QxboORP3hYqok
         5hCndf6Pjxqr7imOfHZ3qjl3AgR777Nwx5rRnHCc08C2dvWyb5weTXd73DollNT1ZR78
         bWsCSz4bBLefaOPOOKvNOhgV8S4pco5UNgCVd4T5n9kFhiSU+k25fR+8t3E+igbOx+C0
         5wEoL8jjBmn2aOoIiiTxk02xXHJnsaBR3+vkBxjxAVlH0++4tkod6kv7iSxlJgwE4IH/
         sSWrExIik4Wj7X///5lSOVDOcILI8zHygZ+2RtN4uvvix0knHYhVTt9x0IwoRJNwtPtT
         De/g==
X-Forwarded-Encrypted: i=1; AJvYcCUW0JEmDN+5rKmg01E+fmWhL0ZH5lyqPWOtqBDSLIlF8QCNi4L4Eqrr6BTgrAyIV/jxNl42b51eUz3IA6r5u2j6J86r
X-Gm-Message-State: AOJu0YxJzay1b2cXy3/KiL8p16CuLSDFN6iGJ0YNhY4ELvt8TQNiBJL2
	iKg72ylLe0R/+B4GR50LnuV08cIQSgsIDtvD4RpUp7+X9KuEE1LQ
X-Google-Smtp-Source: AGHT+IHMFu02/uJ3R6VfR2Z0GxAYEbDPfHlf2MSQd4mQr70ATN40f9Xp6+ZCSXKIjOEH3giFSDgzNQ==
X-Received: by 2002:a05:6359:5a8d:b0:1a6:7af3:22ce with SMTP id e5c5f4694b2df-1acc5a77fa9mr157763555d.2.1721438634647;
        Fri, 19 Jul 2024 18:23:54 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7c57a58sm2402755a91.23.2024.07.19.18.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 18:23:54 -0700 (PDT)
Message-ID: <2393c8599178e164d210d6949a5534b56979660d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix wrong binary in Makefile
 log output
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tony Ambardar <tony.ambardar@gmail.com>, bpf@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>
Date: Fri, 19 Jul 2024 18:23:48 -0700
In-Reply-To: <20240719232159.2147210-1-tony.ambardar@gmail.com>
References: 
	<CAEf4BzarKiUZqNcq1E+6SaeG8oP5+SfSLLoTNKF3_+7MS6CtyQ@mail.gmail.com>
	 <20240719232159.2147210-1-tony.ambardar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-19 at 16:21 -0700, Tony Ambardar wrote:

[...]


>  define GCC_BPF_BUILD_RULE
> -	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
> -	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c=
 $1 -o $2
> +	$(call msg,GCC-BPF,$1,$3)
> +	$(Q)$(BPF_GCC) $4 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c=
 $2 -o $3
>  endef
> =20
>  SKEL_BLACKLIST :=3D btf__% test_pinning_invalid.c test_sk_assign.c
> @@ -534,7 +535,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
>  		     $(wildcard $(BPFDIR)/bpf_*.h)			\
>  		     $(wildcard $(BPFDIR)/*.bpf.h)			\
>  		     | $(TRUNNER_OUTPUT) $$(BPFOBJ)
> -	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
> +	$$(call $(TRUNNER_BPF_BUILD_RULE),$(TRUNNER_BINARY),$$<,$$@,	\

At first I found it quite confusing that we use TRUNNER_BINARY variable in =
this define,
but can't use it in the CLANG_BPF_BUILD_RULE and co.
However, it looks like this is because of the eval in the (eval (call ...))=
 pair,
used to invoke DEFINE_TEST_RUNNER_RULES.

Suggested patch works and is probably the simplest fix.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  					  $(TRUNNER_BPF_CFLAGS)         \
>  					  $$($$<-CFLAGS)		\
>  					  $$($$<-$2-CFLAGS))


