Return-Path: <linux-kselftest+bounces-38451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3339BB1D4B1
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 11:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84003A3D6D
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 09:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4276E221FC4;
	Thu,  7 Aug 2025 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c05AShnw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D21400C;
	Thu,  7 Aug 2025 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754558892; cv=none; b=s44PJqTpqjjPd0aHEFqfn1zIDPBbuRryu83MIXi3lb1/vvQPuwR9DR4TwdrmFSr3NQadff9cj1PbOWtXaW3SFFJKsjsj4tc0V0PsK0Ye76kdhQJOB9Ry3i43JVyH+Nrp1hvm6W1GDjDRU1o6PfDwYkV88hhIiWBV2Bom9n3qaPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754558892; c=relaxed/simple;
	bh=Yl5x0Nwg2DhAn2nbN0TQj9k3Qhmh9DLffzUJV0AnZT0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EH3oUL9HiYFc7ygILAjYLotOBdqKTGVf8Gw6HvXTOuo7u0Oln25rM/N9e40DwsnLEsMMfoKc34xXzRQt7ezUsgBnAIO/iCvbtQ4IfqVyJgNx6ugg65xg/3xKWQnvY6vLKemvJIKKuPJmBr4APgbAP8iekZJUmTeGgfBZHcpTGyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c05AShnw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae9c2754a00so154613566b.2;
        Thu, 07 Aug 2025 02:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754558888; x=1755163688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uCS58Sug0FEcTzFQ9KU19iod2XYp/UwC4MrLuOBM+qY=;
        b=c05AShnwpUFXfRF01GDpFvInPXBStESeRMYV2EfgnysLWewiJQA4QIUP/6u+jSfffj
         +BV+G9pKs1hdUtfwIJZ1LlB3IbMo00sPFr1yY3BvoFUTY2tnaCiqKsHrk2qyYQuXH8Ow
         RB3gOdPsIgteKUrQJB/R2i9paAiyoEcrf9VcQSaEASNXMimNxPR90mdShEcaHWvXx8Ex
         X+RmgIiYBqgUi1ucByj6vOkt0pdQFpzUdfJRCK6AXMqX8q5d0ZjKCjU5QnZAQ7cfBPCL
         mxq43E2+ECoLKVouRhJ/Xq9ShdrRrMQBY/HElv9eVvui3FQMRMOReVg7CVlnpcVVeumz
         KiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754558888; x=1755163688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCS58Sug0FEcTzFQ9KU19iod2XYp/UwC4MrLuOBM+qY=;
        b=pL2SLuF17B8982fhrm6UCeJNRD18ULcGoHmflgvpn30BxAialOhGp1b15hs0Xi0Wtg
         GGzPzpime2RmG68IicTL/6rfJejRV68EkxzCyLh1+sqpRFb5+YcYo0LKFD7JRDjzzKha
         ilK1UcZ7jQaRn/rQaTNqg+jTP+QpWh+ZD4egG47WPjjZ20JawwRUtpn6Oya/JbdfxDdq
         sQsTB2fTVW9nHJNXGSVCI2uI9MU70FfTpz05WJv+EQGvw9gW93BV+MBVFX++KI1mKkmY
         MeYtaRPzT3YQAFeuilpGaqmdd+Xgg8WRZQv90zRseru1JHzHgfd0gTxn/r2/g+Rxolbe
         WJ5A==
X-Forwarded-Encrypted: i=1; AJvYcCU1u/TOnsqibwgvT2zd7xdIL6dBjZVPZnZ14YtBlic14lQaebz8/aPpS1z8Xru3Yd77D23+9H7Cdh0GdHUentbs@vger.kernel.org, AJvYcCVCXHyiCiJg8ceELgf4MaVG/J4pu/n4En566DLycoKC1rjiLqrokcEWQWHgLElKInzW9d0=@vger.kernel.org, AJvYcCVfizZucq4ZF5/RfbjrXhv5DGRcgJD8kP1tw/jW+3/0JQFEAt8PofVh2evMavl9unusq0r52hTc6JCis2QK@vger.kernel.org
X-Gm-Message-State: AOJu0YwhGQmP964tUJEJqQCdrux/5W8Fxag+XlyL0tFFhBGEEybESTTm
	HkdJswQVPQ+1KB+weR/0bdxltJRn1gpK0n6ZvK57My7dcwFUvRd/JRFq
X-Gm-Gg: ASbGncsoi3IGuhLj33qq2Xh9bd5+2NeMT6RIWxQ5PaoEHaWJ28fEN8Iqw1sT6LNk+t7
	SOWn9JIXFjDhgqANoih6vx/GsCMf7oAGSia6OY/sDAsn3iNoRxPdTqav2WD7FxJ5bxFJykGmLRo
	6Pz8U6W+dtiKb2VzMadia2k6kIP7wcAEvzV0pknZrNrS5vd1in3QzZTm5jOdp+h2yIJfnkiRFx6
	Q/ajfggACuAmPJp/7YkD9pqUkRzC46yka7UJTny2nbx/33mSI+2+NVRb5lj06hufrnVee1hzV6s
	6DqFpw55zGbSzga7y33zxpIvXsUOuPGLfxDPYZZg3qKauWLIzz6c9QjTIO92Xbf/+ozNqvbnZN8
	Re8O6Mzko
X-Google-Smtp-Source: AGHT+IHmLsGb/acbO5xIQF3vjzibLDgF5Z0N88FYm1WOJGw2qm8TL38U7kcaSCPcx4JEnPkZIjiZEQ==
X-Received: by 2002:a17:907:94d6:b0:af2:5229:bd74 with SMTP id a640c23a62f3a-af990344c44mr499202266b.26.1754558887632;
        Thu, 07 Aug 2025 02:28:07 -0700 (PDT)
Received: from krava ([173.38.220.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af928c84154sm1187605866b.84.2025.08.07.02.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 02:28:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 7 Aug 2025 11:28:05 +0200
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiawei Zhao <phoenix500526@163.com>, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] selftests/bpf: Force -O2 for USDT selftests to
 cover SIB handling logic
Message-ID: <aJRxpUrUJwn0lyOY@krava>
References: <20250806092458.111972-1-phoenix500526@163.com>
 <20250806092458.111972-3-phoenix500526@163.com>
 <f5d8d886-1de3-4521-917a-e98b645b987e@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5d8d886-1de3-4521-917a-e98b645b987e@linux.dev>

On Wed, Aug 06, 2025 at 11:17:34AM -0700, Yonghong Song wrote:

SNIP

> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index 910d8d6402ef..68cf6a9cf05f 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -759,6 +759,14 @@ TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
> >   TRUNNER_BPF_CFLAGS :=
> >   $(eval $(call DEFINE_TEST_RUNNER,test_maps))
> > +# Use -O2 optimization to generate SIB addressing usdt argument spec
> > +# Only apply on x86 architecture where SIB addressing is relevant
> > +ifeq ($(ARCH), x86)
> > +$(OUTPUT)/usdt_o2.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
> > +$(OUTPUT)/cpuv4/usdt_o2.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
> > +$(OUTPUT)/no_alu32/usdt_o2.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
> > +endif
> 
> I tried your selftest with gcc14 and llvm20 in my environment. See below:
> 
> llvm20:
> Displaying notes found in: .note.stapsdt
>   Owner                Data size        Description
>   stapsdt              0x0000002f       NT_STAPSDT (SystemTap probe descriptors)
>     Provider: test
>     Name: usdt1
>     Location: 0x00000000000003ac, Base: 0x0000000000000000, Semaphore: 0x0000000000000000
>     Arguments: 8@-64(%rbp)
> 
> gcc14:
> Displaying notes found in: .note.stapsdt
>   Owner                Data size        Description
>   stapsdt              0x00000034       NT_STAPSDT (SystemTap probe descriptors)
>     Provider: test
>     Name: usdt1
>     Location: 0x0000000000000334, Base: 0x0000000000000000, Semaphore: 0x0000000000000000
>     Arguments: 8@array(,%rax,8)
> 
> llvm20 and gcc14 generate different usdt patterns. '8@-64(%rbp)' already supports so
> with SIB support, the test should pass CI, I think.

I see the same with gcc 15 and clang 20

    Arguments: 8@array(,%rax,8)


jirka

