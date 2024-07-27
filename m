Return-Path: <linux-kselftest+bounces-14289-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7B693DD1E
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 05:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E281F241B0
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 03:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B961878;
	Sat, 27 Jul 2024 03:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbbXRb6O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE015BB;
	Sat, 27 Jul 2024 03:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722051293; cv=none; b=EbECB8I6VzoYNDE3mKqWVmf0X/Bm95rmLvswYabJNJ+IslwpTnplr3kFsMMSCVGI9DcmHxjOFQASqymE0q5zNP2QlhsEIkFmWEd7JnM5nAflo2fqXMYjYoe5BUiRLYZJQqo/0gulDnUhmlwpkmXcxrOeIJa5NzQSEHIo3F+pmqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722051293; c=relaxed/simple;
	bh=yaDJdeq/hqaYjATvvvDDIvhTLkEIsJ9rLBCq1itV/8k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qyEipMG0n0GgmWMfdwoVmMV0rPBTMWqZWTrQswFjIvINg1QCIadzzDFF+v7VYz9WumqI+wukDmCZs5N+qCHswU3pftPxGFLxIhLLA61+O2REMX1Aca0DA5/TdMs/ZqaezaxNdgZJTfqdUWNHy2CTcKdLL7Bs/8nblPagfMqv+bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbbXRb6O; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d4071e9b93so1050628eaf.2;
        Fri, 26 Jul 2024 20:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722051291; x=1722656091; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUY2D6aIOhI+i59kEpaPmqdG9/yA6sTt0ktfeY1jnsA=;
        b=kbbXRb6OJtR+nhd+tUorqKyrU4DEQ9qMhAb5X57l4Fc+ED7lcVy9BSGwYG2Sda5CyK
         MRKekFDAD9EjuvFchetUYsm2zBdvPu9Js5uPzxto4AJwaWhJeY90b23kmAASY8yl/3Qf
         JdKC4BTVNlIdZX02BkkZcDPI0q9oENvAKSGSRpZ1MglaNUFfhLaKXYWifVeAeNhbrwSE
         h7j3mrOeOpxjQXDNUGEMXsPNu10yWL69fAbqNch2gQ5aPUPEoaDjb+O19TsURiFv3Kxq
         IJvCiG+CkoZYxRttnbrevkOD8tamNl4FgW8iTiV3+PoORV6CxiTOkevEfkFXZjbFiqkl
         VFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722051291; x=1722656091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUY2D6aIOhI+i59kEpaPmqdG9/yA6sTt0ktfeY1jnsA=;
        b=ECya3fDivpkfymEZDZ5bVHbAXaZSjCrBLNegTyck2yh2oMQEM4owYsnFv3wM0SBSiQ
         S04F86bZNusoeaczsPuDOFufIleNCNdo9JSkA6YgFScUK1SV3XemjrB8F380auFmXu1u
         SBmHeMnAr0R9QvqQrK8HBi9RCFFRtlFRWrKw9dByixhAbvl5UfVIOg5L9IHeTT018fHC
         HvRZlpd5UgiWG13IomBaWFsgfwXRICeZ4aljcvcdVlN0N8cNBL61kwk8Quvx3a06f/0k
         VX07C4hZjxsW0E4zSFX6+83YxKtS4sZQwEyHg65cDjZbzk8I60TNma7uf+/3jvVz5MRa
         0PrA==
X-Forwarded-Encrypted: i=1; AJvYcCUZGmsNZfcAjypUKvYQN0xWViHZytuqPcFS4dKw8nZyuYoD+xi4kU4T2m/B5/yV/btZ2+7pic8BkeuhcVl6uksfyOcFB0CUbaczbLKxvvgAxYJkFYMWq21ap72/8lOkei9YI5WtU+2c
X-Gm-Message-State: AOJu0YzcO1ikTfxd0bN3alACuTNjXZxNElDw+YCbm5b2JtM6Hni5L0/4
	4JnD2ds2GUkfqSBDMF3Th7cSlvQiTS0RYp0e7rLDq16Y3Ah56alL
X-Google-Smtp-Source: AGHT+IFpl9ckg/yLErKtgalQwPuaJJ4cU5wCNODkAx0umK+ml8T7MahWXSRw6tiE+/8b+GTmc+WQQA==
X-Received: by 2002:a05:6870:213:b0:261:1f7d:cf6e with SMTP id 586e51a60fabf-267d4f336ddmr2171873fac.41.1722051291494;
        Fri, 26 Jul 2024 20:34:51 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead874af9sm3502700b3a.170.2024.07.26.20.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 20:34:50 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Fri, 26 Jul 2024 20:34:48 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Yan Zhai <yan@cloudflare.com>
Subject: Re: [PATCH bpf-next v1 2/8] selftests/bpf: Fix arg parsing in
 veristat, test_progs
Message-ID: <ZqRq2MB/axSchiQP@kodidev-ubuntu>
References: <cover.1721903630.git.tony.ambardar@gmail.com>
 <b488b997e1b966f6d35a2767da738fc9a44023a8.1721903630.git.tony.ambardar@gmail.com>
 <CAEf4Bzbb3hPzKN2-wEg24JNMaJsUDiwpx9=xjvOK7TnAaSk4wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbb3hPzKN2-wEg24JNMaJsUDiwpx9=xjvOK7TnAaSk4wQ@mail.gmail.com>

On Thu, Jul 25, 2024 at 01:09:24PM -0700, Andrii Nakryiko wrote:
> On Thu, Jul 25, 2024 at 3:39 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >

...

> > --- a/tools/testing/selftests/bpf/testing_helpers.c
> > +++ b/tools/testing/selftests/bpf/testing_helpers.c
> > @@ -227,7 +227,7 @@ int parse_test_list(const char *s,
> >         if (!input)
> >                 return -ENOMEM;
> >
> > -       while ((test_spec = strtok_r(state ? NULL : input, ",", &state))) {
> > +       for (test_spec = strtok_r(input, ",", &state); test_spec; test_spec = strtok_r(NULL, ",", &state)) {
> 
> oh, this is so long and verbose, let's just add a counter and use that
> to determine whether to pass NULL or input, ok?
> 

...

> > -       while ((next = strtok_r(state ? NULL : input, ",", &state))) {
> > +       for (next = strtok_r(input, ",", &state); next; next = strtok_r(NULL, ",", &state)) {
> 
> ditto, let's not duplicate strtok_r() calls
> 

Sounds good. I'll update for v2 and thanks for the suggestion.

...

