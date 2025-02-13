Return-Path: <linux-kselftest+bounces-26588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1652EA34F7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 21:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2CF16A07A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 20:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A71266B44;
	Thu, 13 Feb 2025 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hhOt+KBE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4043624A046
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479043; cv=none; b=OFlatUu/NvzTzcAw09w0ZTeQTzTZ+0jiTP3DEl7LNqzecqRQtO6e/Z2vtLkax0hFev0mjfHFcm3a4eTqfjjWyZKlpgpWYn5rquX9D7jftvrrM3ol681TyVg+brG9GYQnamaNcyLkvrx6Crgsd6j+SfoBMoBohzdQa7qMbjnvbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479043; c=relaxed/simple;
	bh=VN2RuvBjkoJAPPb6ivIEGmI81z5fd0DOiMYmSzn4jFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXgsZ1r8wO+L6W6WrWqIc9LEtMvrQDmEIeQMWeTym1rU71hEv/tRAzJDYLDHLbkq6Azvc0ATQJDPY06X/ObgozTy5vPvkT5/3RxB+qWQCUorUH65a2HaqGi/X6yZaCixdbGGuToGvDx/m3MCosDNZVdnPGNmOXKov0QNClDby08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hhOt+KBE; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fb3a611afdso7982947b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Feb 2025 12:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739479039; x=1740083839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VtL2Aljq7K18Ol8pwG2GMa8SAGuvgfRhHbhoMvrHKnE=;
        b=hhOt+KBEg2QW8NduLPuray1Ii0hdOmoy0Oj5MZHePIWozygVuAPCROoKE6BRIPXmzQ
         FcjE7qq4QZm18CP2gXSp/sghgp1SzPeZBF5At1X1l7NWsF4RTOqCpui5ymsW1n/ONZ8v
         rSHubc67FRtZQTmNlRPrCQjac3qFvB3j8idDYa1w0L76VCoqHiY+TyCxwzjWwnn8OyWS
         csx/DEoW5qQ/AecU2rnkNbCMj+MjCrxocf1hiWIR32b59sgvY5bPcVbXCJPixXiGcNb6
         cvQuE2qBtf8h6REBEF6T13UwCScFaGGNQrEpsXoi50MXzsOvVqUCoolW8Qakeef6eqR+
         Gfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739479039; x=1740083839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtL2Aljq7K18Ol8pwG2GMa8SAGuvgfRhHbhoMvrHKnE=;
        b=rZEAiwrUNSGGQnJPLGBvpE7hIx+8u01k8kW23Q6ADxah953K5tlfYTibUWZbzD/WV9
         oJ+uuQWG+aBE2HbScnzEnQM4llDtkKuR6IJo53fIDFIZMM4SBvBSrzyss/yGntJOGUce
         1M1/XsTWFmDyXeMhGX2Im57XlnDghS5siZ0pBeoP6pAvIW8vszjtGAGsICR6AmrSuvDn
         WkotyRpv+13KyNFpUZ3caDZkaZerjc2qDVqNb25tsRJkXK0mzvfe5hJII/rbKspVD/LU
         kl3NQrVOcpPNxwMxLwpOWn8CI6wmp6eDBO7mUCPBbfdbQTaVC5gMc/+mnD2T+kw9dtg+
         QU3g==
X-Forwarded-Encrypted: i=1; AJvYcCX13vnFa81HfG6k8xzsuQ9Zs8nM7bgXcveBS+drXdp1I3w1drSsJMUYF7izYmcRQWa7VaDXMtDxKUhq3HKZ8oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNTSzZEl1bVUeBSzoerLewEKmO9PZxfMNxhhS2QG47UncmP6v
	CZ/X+tGTmYS0tcnL5QFPA64p6+KkqPQ7Y3HPKI9EtbqgYnpHiXhhixa85EoOiLE=
X-Gm-Gg: ASbGncucjeINN0Vbv2wb2TnT3q9PTcb81/85s3JiLdCjthBde0PWjw7uw1vjjFNS/4W
	GTZwd8wu8LgQ7pG02OgOeVIwUxGin2y+UXydRgdDhOOS/mvRUMl+6bmmtZ/GMsfAEDyBQ/7OJp7
	UZ7z7cTnUMrUBR7mr+afqpwq7dksbEhnpqKX/NMoWRXuBaY1g0itxxlHIPYBiqXlM0wuuqIEHyY
	m4bGyPrDBhi057ty8QsmtKOU5iEUlPvg0EA3Ei+2nqRaxHwvWG7PaqsU/yzeCFQFRAQct7zRp5t
	T9s=
X-Google-Smtp-Source: AGHT+IGMfdT8//izHzzVCxCUXm2NF65zwvxCB97iREjU4n/ssdZBJJcyfbQ0HsHUfaMDbqW4yx+Sxw==
X-Received: by 2002:a05:690c:6181:b0:6fb:1f78:d9ee with SMTP id 00721157ae682-6fb32c7ff5emr48326527b3.15.1739479039148;
        Thu, 13 Feb 2025 12:37:19 -0800 (PST)
Received: from ghost ([50.146.0.9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb3619bd74sm4583557b3.75.2025.02.13.12.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 12:37:18 -0800 (PST)
Date: Thu, 13 Feb 2025 12:37:16 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools: Remove redundant quiet setup
Message-ID: <Z65X_KimLfbE0DG2@ghost>
References: <20250210-quiet_tools-v2-0-b2f18cbf72af@rivosinc.com>
 <20250210-quiet_tools-v2-2-b2f18cbf72af@rivosinc.com>
 <21f98687-f715-449c-86f0-c095ea499450@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21f98687-f715-449c-86f0-c095ea499450@kernel.org>

On Tue, Feb 11, 2025 at 12:00:49AM +0000, Quentin Monnet wrote:
> 2025-02-10 10:34 UTC-0800 ~ Charlie Jenkins <charlie@rivosinc.com>
> > Q is exported from Makefile.include so it is not necessary to manually
> > set it.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  tools/arch/arm64/tools/Makefile           |  6 ------
> >  tools/bpf/Makefile                        |  6 ------
> >  tools/bpf/bpftool/Documentation/Makefile  |  6 ------
> >  tools/bpf/bpftool/Makefile                |  6 ------
> >  tools/bpf/resolve_btfids/Makefile         |  2 --
> >  tools/bpf/runqslower/Makefile             |  5 +----
> >  tools/lib/bpf/Makefile                    | 13 -------------
> >  tools/lib/perf/Makefile                   | 13 -------------
> >  tools/lib/thermal/Makefile                | 13 -------------
> >  tools/objtool/Makefile                    |  6 ------
> >  tools/testing/selftests/bpf/Makefile.docs |  6 ------
> >  tools/testing/selftests/hid/Makefile      |  2 --
> >  tools/thermal/lib/Makefile                | 13 -------------
> >  tools/tracing/latency/Makefile            |  6 ------
> >  tools/tracing/rtla/Makefile               |  6 ------
> >  tools/verification/rv/Makefile            |  6 ------
> >  16 files changed, 1 insertion(+), 114 deletions(-)
> > 
> 
> 
> [...]
> 
> 
> > diff --git a/tools/bpf/bpftool/Documentation/Makefile b/tools/bpf/bpftool/Documentation/Makefile
> > index 4315652678b9f2e27e48b7815f3b9ddc70a57165..bf843f328812e10dd65a73f355f74e6825ad95b9 100644
> > --- a/tools/bpf/bpftool/Documentation/Makefile
> > +++ b/tools/bpf/bpftool/Documentation/Makefile
> > @@ -5,12 +5,6 @@ INSTALL ?= install
> >  RM ?= rm -f
> >  RMDIR ?= rmdir --ignore-fail-on-non-empty
> >  
> > -ifeq ($(V),1)
> > -  Q =
> > -else
> > -  Q = @
> > -endif
> > -
> >  prefix ?= /usr/local
> >  mandir ?= $(prefix)/man
> >  man8dir = $(mandir)/man8
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index dd9f3ec842017f1dd24054bf3a0986d546811dc4..6ea4823b770cbbe7fd9eb7da79956cc1dae1f204 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -7,12 +7,6 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
> >  srctree := $(patsubst %/,%,$(dir $(srctree)))
> >  endif
> >  
> > -ifeq ($(V),1)
> > -  Q =
> > -else
> > -  Q = @
> > -endif
> > -
> >  BPF_DIR = $(srctree)/tools/lib/bpf
> >  
> >  ifneq ($(OUTPUT),)
> 
> 
> This is OK from bpftool's side, the GitHub mirror has a Makefile.include
> included from both main and doc Makefiles, and where I can move this
> definition.

I am glad to hear. Thank you for helping me unify this infrastructure!

- Charlie

> 
> Acked-by: Quentin Monnet <qmo@kernel.org>
> 
> Thanks

