Return-Path: <linux-kselftest+bounces-6150-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACBA8774E6
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Mar 2024 03:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA23DB20D06
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Mar 2024 02:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAD2EC5;
	Sun, 10 Mar 2024 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kMIRydFx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414235394
	for <linux-kselftest@vger.kernel.org>; Sun, 10 Mar 2024 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036339; cv=none; b=DFNr8G6h8kcGb/3fV92FXonG2AsN2RmmTPY0Ne3bkHb2fmKOYQZPJcoZFTt69FrMYEX/f5+K6rFsexMw517y22LAHZ9LX/XHfhyZNAkqD6pddbGGFTdNrgh/v0OuCUmi6636nXN2+2CIoyhvJQMARtTdSfqlYbcGy7XZ4I/u60s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036339; c=relaxed/simple;
	bh=D2uX+Mnk+6vztSUZd5hP00XWtGAz0CoTxvXAkzGNj1I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kAJ+vBJXxIkC9AtljqsX5vcI15/yVrPb8W6L3sK8jMSb/Xsn83lAo7mKo4Wyz+UuA7+QgcwF/glSUTzrazL2v+RTMjWy8AusJ32Lz4yM8nSK3LFJq8qwpzGRfE0wduIC8QrNIaStlkfldTRz2676R+cLi1gMNVsQp/sgUCUDnsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kMIRydFx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a2386e932so7272877b3.1
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Mar 2024 18:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710036336; x=1710641136; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7XIYLAkcLSrj5FLrGjKI8q+UW4mZzYyudvGuQ4/TZo=;
        b=kMIRydFxidKzY7BpYx9EUp/eSGgFea4GwwQrTWrZFWAG+5gWnMJU0Gbf6KDWEXRVbB
         yt7yTV4W7LoKxr4bwuLNicNelGV0VJdo8+Xxc3tr9qWqEormXicnooeGM+XBHP/F8Lpv
         MkZPbXBbSyvDxovJoSlKKkCQ8NeOEsoPsWWeQ/wCQOw3jDd+VazdaPjgJjjglqJ2YrqQ
         DzXZQwEmve8ZRYv9vrjP3ObWuuQVtRPblfKrVNINjUlnr0Z/lkXrGfycXXpfWJCveve2
         LkbG7/7/jskn+XiPH/2MRqGAtT1mcFiev5F2k5tRA7Uy3qUjHzrB0948Z1PAUaO33IXn
         CXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036336; x=1710641136;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7XIYLAkcLSrj5FLrGjKI8q+UW4mZzYyudvGuQ4/TZo=;
        b=vTMQBr5uNME6yyU02IZU4E06GLIMJAFSMAawOMwihJRUwT/fessxFxeMlqDp1zm4Dg
         Zjo+nDSeZ0CBMX+9YXpHpvhSxap25YqdsjffWeamRkWszI0RIQYhWKn0eUrWMFgXPwOU
         bAHQPkX76vzqjHO7y6V+oBya/EGvv7roaGvEWdoSzGJ+CRHVMsIE+nCFL8jjX3hvakC2
         2VJQxqFwopOTrdVzJj1Krhi74Cwbyte9izksWBn+WFa0Vz2fVvrBNx6N75De1qeVfLS/
         7rhf2P8Xonh4yaIhahC7tKjI4ljn8ICIncYuN2Pk/X5NSPq9qBYyra6pP6lcq6YoLUDh
         tP2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWFurnIxBJvA0at7mXQ9BemLIhOn5BBSNjm3G77UL7ZfdCXtkEMUjOmEZuElC6aca9Cz4k9vR8/RUM9/fZ2jEC6zmfg+Q1RnaE9C9Mdaze
X-Gm-Message-State: AOJu0YxK0ZsFPmZxkli9qU7xwCUIlGzskQ6Z1UoThGOk5bqSOPFpEuL+
	+SseXYyI7sMx/3GVbvWE/+qZfY3BIc+7zOmiUeK5yHLKtcHPrMmxOhj1Yp/MlDKeXPnJpfRU6Ix
	vwPorMA==
X-Google-Smtp-Source: AGHT+IHgDNWM+Z4QXgFMm7GizvEhHToqcLHuZHJtXyYeO1MzHp7huAG4ihDQbMUHqCDQpOBGjLQSGQDO0YZe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a63d:1b65:e810:3ad3])
 (user=irogers job=sendgmr) by 2002:a0d:d7cd:0:b0:608:72fe:b8a1 with SMTP id
 z196-20020a0dd7cd000000b0060872feb8a1mr953360ywd.4.1710036336387; Sat, 09 Mar
 2024 18:05:36 -0800 (PST)
Date: Sat,  9 Mar 2024 18:04:57 -0800
In-Reply-To: <20240310020509.647319-1-irogers@google.com>
Message-Id: <20240310020509.647319-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 02/13] libbpf: Make __printf define conditional
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

libbpf depends upon linux/err.h which has a linux/compiler.h
dependency. In the kernel includes, as opposed to the tools version,
linux/compiler.h includes linux/compiler_attributes.h which defines
__printf. As the libbpf.c __printf definition isn't guarded by an
ifndef, this leads to a duplicate definition compilation error when
trying to update the tools/include/linux/compiler.h. Fix this by
adding the missing ifndef.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/libbpf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index afd09571c482..2152360b4b18 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -66,7 +66,9 @@
  */
 #pragma GCC diagnostic ignored "-Wformat-nonliteral"
 
-#define __printf(a, b)	__attribute__((format(printf, a, b)))
+#ifndef __printf
+# define __printf(a, b)	__attribute__((format(printf, a, b)))
+#endif
 
 static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
 static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog);
-- 
2.44.0.278.ge034bb2e1d-goog


