Return-Path: <linux-kselftest+bounces-6154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DAF8774FB
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Mar 2024 03:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE341F21203
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Mar 2024 02:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4C316FF56;
	Sun, 10 Mar 2024 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yr9lT8nT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C584420DCB
	for <linux-kselftest@vger.kernel.org>; Sun, 10 Mar 2024 02:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036349; cv=none; b=SNKJCn09H/KWhdr/pvGzFl6KYIdNrjCuPm4ktlQCxfLHpp3FpeuFcDFTO78Bnw1dkVs1ihTk+vX4KDVzUghucyWw5uVEZeJpH5W3K54P862E/PTP0iWDu9xJ7yjIdOvRo8BGyFyDw8VPWsDP1WUNJ4ieivVVqrFz0Ja8lmEKGhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036349; c=relaxed/simple;
	bh=I32YjdeuPxEte3yHw53IzkVFz3QD1fvyYmVpmCiJgX0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=VRc4M+7Kod025CgGoUX7XMokkTzKErvlZgJUz5IDdx60A1Yz9gMW9HcPVBWrfw6NtuxB2BEWtS77BghFlR7p/9kHBsVxy8nj/MjkE43NDg0f6WrDfe0EfSTrtH79MusVQrs1lJailoIvxYkgJVJ/GqyZTnh24hRLGN4j6Kr9OZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yr9lT8nT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0151f194so40238107b3.1
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Mar 2024 18:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710036347; x=1710641147; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JkunXUX2uPJsD4ImBjWANLyZP2gzb7/4b4n3BxJNzzE=;
        b=Yr9lT8nT4flnIbHVDVMM+eBJx6uxDD/x6Fei9lIsf/OFxtudgFe5niqUap4uxkpmBJ
         NdJg6H1zNWCcD+72LOjZyUPUYgcVeP6w8WMugyXDr4b6oTkA/Iir4ST2hIa0guzAV7Di
         JY5SoHkpo/cZJ9cCV7lAC0cNRnzMCkU392Aqcvc7xZcZK7VPBPKFdVVKmnYOthlQCSO9
         WQ6FT71i5pWYRIZs+7dcRVFoi8M3V9OPRagie2AfLoCJA/cwPgtG81ZAikEInxUZxsXR
         qU3zkxlUA28IzlB9dIDnjTEzcj4r3SwT9eZWH4JbhP+r25Jo7fUwPInmb4wEpoFDObPw
         ZvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036347; x=1710641147;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JkunXUX2uPJsD4ImBjWANLyZP2gzb7/4b4n3BxJNzzE=;
        b=OUBwiHWQXu9kzMicR6I68KT8ZtNzZOB/trMOdGr+jvqkXNeNmxf9aR5ct+r2rUMHBi
         1JGwovxNhbFIei0/Xv86l0GSxvpvCOlgwQBsHy9oMrEt45c69lktWud8t22JYk4ICQGU
         xmRtoTuALR2v5A2k3Gu6Oc2/Bqul54dNs92eT0LSZulJcd0X8K4QFJJfwUkIStUL9vWV
         oWv6ruC3ezoqLKCxrQ+DtSQyOcRlGuh7cuZRvfFsZdoLKL375ohJQ81jfBKzgfzxGlbK
         xyyAu36oQGWFdJElxV/bNrZSv2WuE5C1U4o603+/k1/oMlY6E08RT73kql8H2RqM1Tap
         a40Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2MOEfuwWaGPibkt1wTtR4vDoS7qFYCRLgBGyEHZldW0JSr5xlkqoT6TTp6ATqmI9m0zeDa3mBjSXOhBdJX2EFd2DF1JwZhssLoc6MHhrx
X-Gm-Message-State: AOJu0Yxx3dFHDXFMk3FMHNT5okoH/T94+q/jeNqidOtdHMCS8RnlWsLw
	ynBgHClo3O0jeMOMkTT1DE96VIKr3eN5LgZztaut4NGxwPuK4YxI7SYoJE3Y5n6KgcAgEKIaJCO
	vSjPDUQ==
X-Google-Smtp-Source: AGHT+IHC63LoVrlmn41wG0ObqneUHLqshrWIHBHCNg+aleXCyzso595+j1kkp1p9OAmoHd0xeF3N4e9YCjv3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a63d:1b65:e810:3ad3])
 (user=irogers job=sendgmr) by 2002:a81:83d1:0:b0:609:f088:cf9c with SMTP id
 t200-20020a8183d1000000b00609f088cf9cmr962327ywf.1.1710036346612; Sat, 09 Mar
 2024 18:05:46 -0800 (PST)
Date: Sat,  9 Mar 2024 18:05:01 -0800
In-Reply-To: <20240310020509.647319-1-irogers@google.com>
Message-Id: <20240310020509.647319-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 06/13] perf debug: Add missing linux/types.h include
From: Ian Rogers <irogers@google.com>
To: Arnd Bergmann <arnd@arndb.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, 
	David Laight <David.Laight@ACULAB.COM>, "Michael S. Tsirkin" <mst@redhat.com>, Shunsuke Mie <mie@igel.co.jp>, 
	Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>, 
	James Clark <james.clark@arm.com>, Nick Forrington <nick.forrington@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, German Gomez <german.gomez@arm.com>, Rob Herring <robh@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Sean Christopherson <seanjc@google.com>, 
	Anup Patel <anup@brainfault.org>, Fuad Tabba <tabba@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Peter Xu <peterx@redhat.com>, 
	Vishal Annapurve <vannapurve@google.com>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

u64 is used in this header for eprintf_time and so linux/types.h is
necessary. Add to avoid compilation errors that aren't currently seen
due to transitive dependencies.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/debug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/debug.h b/tools/perf/util/debug.h
index 35a7a5ae762e..4160e633311d 100644
--- a/tools/perf/util/debug.h
+++ b/tools/perf/util/debug.h
@@ -7,6 +7,7 @@
 #include <stdbool.h>
 #include <stdio.h>
 #include <linux/compiler.h>
+#include <linux/types.h>
 
 extern int verbose;
 extern int debug_kmaps;
-- 
2.44.0.278.ge034bb2e1d-goog


