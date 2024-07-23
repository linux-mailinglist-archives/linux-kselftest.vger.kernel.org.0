Return-Path: <linux-kselftest+bounces-14029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA6A93974C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 02:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DB9EB21791
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 00:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C15017E;
	Tue, 23 Jul 2024 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNRYgwoA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23F7F;
	Tue, 23 Jul 2024 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721693063; cv=none; b=drHt6/RCVk6N8AMBrWRltmKfha1BYWG6QcgSvqyFcBKwGKvrFwMsvPLxAXIqIXZBjg8CnJWf3G+q2Bpes5MkI7eitYQDpg+AaMDpI7GyZebtYYRk7jvmWopziEJgzZh1QaF/7IwdwREqqUV42fDjxLtdKI4/XuRz7IFhwv6jzFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721693063; c=relaxed/simple;
	bh=VvRxWkZDKba1ZQzK0XhCPOea3laGnp4jZ03MeHhgXgM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAOzP3h3YMRIMIt/WV9Sk7wKTWiuTI8Jn3PpZDKpuPEEiI8SS0smLOGe4N+vPO0aa78aDe+5YMcPY/jwk3ehGHwtLrnwc9d5KjDrGPinxwKRZNM+Q4F4kKUVewnBk/+HJPm9CIW213p91pgo08eHxCJS/q2+VPLAlVwuXb91pVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNRYgwoA; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7fb93b2e2a3so207044939f.1;
        Mon, 22 Jul 2024 17:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721693061; x=1722297861; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pblNY37B3GkIzZ/iXPjQUQTaEGaFlChZVStll9RVqMc=;
        b=bNRYgwoA0r8o1Ey5OVfftgQtG6D2FyirFC7kNvHSs+vuYkn5blZH1x9/0m018W906s
         y0mwV49qV/MkgustP4+gnz/8ZxX4LyKe6rMbbEJCZR6wQfz2o+Fgx6PgymdCWSflB0hV
         9KnSOiTdOxLYGpfYQzgCY74JXhUNaS1BgSz9EcI1OPplbcCHswbmKOZAXPpQi56qPQ1R
         ZqJfj9K8qsYfODB2VUWPO7GCWmFgOeIguSZxfzfAq1Nl+d/KKQi5CMpZH6MQAEMhzfit
         07vKeyQbZ3ETPunA1+Qq2tXcvQooB6Ww8XsplFAo8JbIbgxDeOzDpKGbNOgGewHmfYJA
         YxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721693061; x=1722297861;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pblNY37B3GkIzZ/iXPjQUQTaEGaFlChZVStll9RVqMc=;
        b=PVXRvaPRB+//axuaUIlRqXV8BBn+JSWkAf3dfz4oj0Y4AKZ9GX1Ti3aWj50m39If8/
         RMho0iDcftJFyPn0mGPDOOshxByeuqGhgIw6Y+Oz9ECU3c1/bLb3PyYPBSYxHbCg6MJd
         m+E+vRYwBwlsadzvvtal+EdKN6nbW1EmOOwL3FEMAiyUbah69KijtsyNuwFbs1TrBPPN
         ccJK7jBsC7GrzYLWgiHeIO0dS9GpyTKxQu+7b8nlqWqyDX7059tKd/1NgM3N7ZtM06uy
         FuTxzc0McXg+UNe3d/TG/+lvifUKSpO/9U3TU8iY/ljSMTKZiuj4pRNluzlI/1Aa9vZN
         TOuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdrda5E30UKLWOyytS3aD8y5xH2LBeAyg0ZANzt0uEJjBlnkHmDGP1NHIl39cM40USLEfn6W3kZ/JntFuhHweosoJfEEssepjpcQ8bYdox
X-Gm-Message-State: AOJu0YwC424HGGKIaukMKaEUHrFBWiBHJ/hGlcWRb96IKm5pDsOD3A22
	sZvbRYdmX5h8OXHQTS8t07XWaPIrhrRuf9KUgy5kHjgNftz/mpI+
X-Google-Smtp-Source: AGHT+IEQFCLq6iXcdk+TXUvTT3O9QmVVYwAwFHaJhOpdBGgRnhvI4hqoKELlk0TsQtqlH6VJKDx22w==
X-Received: by 2002:a05:6602:1490:b0:7f9:f363:2d44 with SMTP id ca18e2360f4ac-81b3580f60fmr1070578239f.16.1721693060671;
        Mon, 22 Jul 2024 17:04:20 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2ee1440fsm1760938b3a.135.2024.07.22.17.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 17:04:20 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 22 Jul 2024 17:04:18 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Fix error linking
 uprobe_multi on mips
Message-ID: <Zp7zgvhrt2/5LpbI@kodidev-ubuntu>
References: <cover.1721541467.git.tony.ambardar@gmail.com>
 <7eeb1a1a9910b30782adba9eb5cc47c6ce075223.1721541467.git.tony.ambardar@gmail.com>
 <CAEf4BzY0rt56Zu2J2FOkzB1WuXtjDMgLuApqsKWnxnzbBQ1eKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY0rt56Zu2J2FOkzB1WuXtjDMgLuApqsKWnxnzbBQ1eKA@mail.gmail.com>

On Mon, Jul 22, 2024 at 02:22:53PM -0700, Andrii Nakryiko wrote:
> On Sun, Jul 21, 2024 at 12:51 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:

[...]

> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -784,9 +784,12 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
> >         $(call msg,BINARY,,$@)
> >         $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
> >
> > +# Linking uprobe_multi can fail due to relocation overflows on mips.
> > +uprobe_multi.c-CFLAGS := $(if $(filter mips, $(ARCH)),-mxgot)
> > +
> >  $(OUTPUT)/uprobe_multi: uprobe_multi.c
> >         $(call msg,BINARY,,$@)
> > -       $(Q)$(CC) $(CFLAGS) -O0 $(LDFLAGS) $^ $(LDLIBS) -o $@
> > +       $(Q)$(CC) $(CFLAGS) $($<-CFLAGS) -O0 $(LDFLAGS) $^ $(LDLIBS) -o $@
> 
> this $($<-CFLAGS) approach is fragile, non-obvious and will break. But
> there is also no need for this, see:
> 
> $(OUTPUT)/bench: LDLIBS += -lm
> 
> make allows to override envvars on a per-target basis, so all you
> should need is:
> 
> 
> $(OUTPUT)/uprobe_multi: CFLAGS += $(if $(filter mips, $(ARCH)),-mxgot)
> $(OUTPUT)/uprobe_multi: uprobe_multi.c
>    ... the rest is the same with no change whatsoever ...
> 

Great suggestion, thanks for pointing that out! I'll update and send v2.

> >
> >  EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)                      \
> >         prog_tests/tests.h map_tests/tests.h verifier/tests.h           \
> > --
> > 2.34.1
> >

