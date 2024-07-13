Return-Path: <linux-kselftest+bounces-13703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5339302E0
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jul 2024 02:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3421F22509
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Jul 2024 00:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A7B79DC;
	Sat, 13 Jul 2024 00:59:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CFB4C8E;
	Sat, 13 Jul 2024 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720832349; cv=none; b=mZXZH+pZ+HzEsfoHtVwK75BkRGyFhLfa52JuVg9OdDJTC7Rs6itLwrHTT8AGsGrhXIDbaDCJu8jWAQrrW3YYt1F6B9cO7v/JOCDr4yMGTcbaSpgSAwU5BfhaLdIwp7GlpALiK7lfn37c/v1tRFMr3NYLJNxUaBKtzAVOQsLLPeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720832349; c=relaxed/simple;
	bh=DtrdLYqQvUWp1rATRcfHif/KLyAI+NavdKK3cI0d2b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0d68sBwPaLOh0jtZ+BTpxSS8LZahoiGPDp69jEIT+Mniafa6qOY32Gq87wetXlenBLxDdvusp+52CvflEVgiZb7iMWw8RmlTCabaI+PqIUplLsQldd6nk5NRscAQ+Dj6QAyX+k2H0X3xrw+1IMYl8OuPs/zN2TPDe9eiV+CwrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb70169c23so23734205ad.1;
        Fri, 12 Jul 2024 17:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720832346; x=1721437146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fObagCVLV5QOrGNzDLRDEtxOlEZx/xK9uTPhQmSYFR4=;
        b=QqIW7+1IRVmXr3x7vvGI0WfGusEeQuVPmJNuBDASTR3nA/rE71lJKZXX/TqG79lbJA
         ZveFE9dqbhSfWBNsehrZz00N3oLVKWOrIsXr5DHWwpu2PALoRkva0D4fLyhHn7yToX77
         n1hqqYhAbxx+EX6mLuRh8u9l/Pp75wv1INmz/ETkgxGQ02MmGd1jknO0dP3rT9DseOgW
         0wxSE6qtsQ6AO0lz7JOByoJe31Gh8+jeDycV4VlC48IoeK+7EJIL6S7nrY+s5rvftRTV
         TNwF3iipZojmOpfHzNqcOAr1WLDqtfF7AgNjrKCv+tSLYp9/QAmsuHM710wj/+Vl18Uf
         TeMA==
X-Forwarded-Encrypted: i=1; AJvYcCVHMcpHERhAJfaWGRPh4ijdu1ukSRgkbr8XdMYSCaeiqPh3Uvf13P8i8Hl+3RayTtgNatkQ+gvL6N+XRuhk2A5U+x/pzapQP7zRoxlu/cDUQWscnN3+uHQNTiVVsmullGFVLJGWFDYJAQoeIjUkn5ynNf8BxnXbvQ3Qy2tRWjHFFTpp+KgkBcx3oFgC4TTUa0xzVoob0u3UTrT/isrcugBKmXM0
X-Gm-Message-State: AOJu0Ywmij0ppMrpxojtvR7j79GvGxo4ceLKGG2KjY0BWB/ANfmCERyr
	x+LVvvAhhTTjI/rwgtCDfbQVOI/dJsbDsMzoklviNml2jTb8NoE=
X-Google-Smtp-Source: AGHT+IHpMYHwlurRaTSXBZOLGL6393z+3iM2RhBoT8I/MqjietVUrz25qYNqvkz4lN15p4xWujmI4A==
X-Received: by 2002:a17:902:e9cd:b0:1fb:9e80:b4fe with SMTP id d9443c01a7336-1fbb6d35ecfmr82888385ad.39.1720832346401;
        Fri, 12 Jul 2024 17:59:06 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6ffc8sm522855ad.35.2024.07.12.17.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 17:59:05 -0700 (PDT)
Date: Fri, 12 Jul 2024 17:59:05 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: make24@iscas.ac.cn, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Sowmini Varadhan <sowmini.varadhan@oracle.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH] selftests/bpf:fix a resource leak in main()
Message-ID: <ZpHRWRWXGewydZfe@mini-arch>
References: <20240711071018.2197252-1-make24@iscas.ac.cn>
 <c341e275-4fac-4aaa-8117-55b654c5c006@web.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c341e275-4fac-4aaa-8117-55b654c5c006@web.de>

On 07/12, Markus Elfring wrote:
> > The requested resources should be closed before return in main(), otherwise
> > resource leak will occur. Add a check of cg_fd before close().
> >
> > Fixes: 435f90a338ae ("selftests/bpf: add a test case for sock_ops perf-event notification")
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> 
> Please reconsider such information once more.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc7#n398
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/researcher-guidelines.rst?h=v6.10-rc7#n5
> 
> 
> How many source code analysis tools should be able to point out that the return value
> from the call of a function like pthread_create() should get more development attention
> (also for discussed test functions)?
> https://elixir.bootlin.com/linux/v6.10-rc7/source/tools/testing/selftests/bpf/test_tcpnotify_user.c#L122
> 
> See also:
> * https://cwe.mitre.org/data/definitions/252.html
> 
> * https://wiki.sei.cmu.edu/confluence/display/c/POS54-C.+Detect+and+handle+POSIX+library+errors

We are talking about testing binaries here. We don't have infinite
amount of time to polish them. If you really want to help, look at
the flakes on the bpf dashboard and help us weed them out.

