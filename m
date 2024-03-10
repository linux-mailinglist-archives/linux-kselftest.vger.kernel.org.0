Return-Path: <linux-kselftest+bounces-6152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6BB8774F1
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Mar 2024 03:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881D4281415
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Mar 2024 02:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20D1FC0F;
	Sun, 10 Mar 2024 02:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDFA5/1S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2884F9FF
	for <linux-kselftest@vger.kernel.org>; Sun, 10 Mar 2024 02:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036344; cv=none; b=Uehs1j1n2PxqewZacdS3/9mnh/x6XQ0vwglwskyEzMuGmsCTDfi+Jdv10D3C3/UCsmqG2hMoKy2FwpdQF74K2N35fpHnLPk0lildP8xw7/jnvXEVrWhSISsquCavUPwVcFBJVEmEFOamUHkmO+cfkun08CnB9I883YnVmNvemgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036344; c=relaxed/simple;
	bh=xr9hx9bRTXredcOnZvT9aTZmO8EItvyRPuWwawu0cX0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Y0LCT7BFOxOZR5P/oa97ZVbmu1c4kh79XFExGeE+JRtJYkZIAxlhp11qv8N5OqDXi2DsODkgyexK75WJ+4qPDRhR8mc5CqnWHydLW16af0O72XeVULDTy9+ifoKYso8DX/eaCteYfJ/Hz6xzuVc4cv8HAmhozkG/AaeMB24reb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GDFA5/1S; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0151f194so40237227b3.1
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Mar 2024 18:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710036342; x=1710641142; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4OaMyUQu371uaOuekdLYCxktVf9TU0U4kdxUUW/XeAo=;
        b=GDFA5/1SAcDvh5wHDztVT4fdrpGGN0qq+wpmeK16nZfyhHocB7oKXyTmzVAjzmV6VQ
         5efsx7rWgkIJt9XTz3UTXv0jUKjDM44630OfMOWCL+/MX2eTAFoiJOGBI13uUTGVPtTz
         NDN+lhd3oRLxtTVbRD4XZr/lLDtewndKru+9BgwwM7FlnwBteO5LxseGlOoFtQxEBNkx
         mrP9DMhE3682KLijmsAxz1fyTIHq0zDD5ZT8yJohRFnrcvMiz/QlvnRqfLRzwk5Rj2yS
         7y4iNFQSZiHWgNU0RM9VoGK+Gh9T6Fkg3yOEDCSxbtF+obf/+2LqKuC/0FUrQ6sd1l60
         veaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036342; x=1710641142;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OaMyUQu371uaOuekdLYCxktVf9TU0U4kdxUUW/XeAo=;
        b=MwjIs26Khqr3jr5tjIquSqPPgUQm2cBbvGWCLKobNjkfhBErTjEFtnaTm08woY8r6v
         P1RmPRY4fV8nxR9aMN1AEYF72yF6eh/n8Ph8phfXqycXZ82wjqrODW2xLKiNk7QGkD8F
         mBd00cFh1311Pe9H3y9RmQtB+ySFBYxzF9NcK8RXmM/L3mdWWm7i4wZHuEn1VJR2t5kP
         0m2i5oQ80PR8CYIiLVIBBP98Mzvg4Zo1iiNi+4WfLDaWnNDd4SSlB5NoMM27maEKv8cD
         umpSBBA1ngFSx6nXnQrOivEWvAkpDEseuvDS0ZKFTIRzdMDtkUTnkeFX9XnLGAdbhON3
         jBWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjKsIftbK0BuxBN97s1YD6+hyzkfW8jG73droLHD6Ng1ec2sj5Hw9vGghtSDmzArbVHnZnY0RG/DQZVfDBLtH7ye9S6tk4/wEZtTGygn8R
X-Gm-Message-State: AOJu0YzeEAHucrxP7zXFBr1I/Knmqy7TV9zxEdPHi7qBhLfHaLOiCXeX
	TBXQgm8nMfSHdr44LE8GZbalV+rAVpl62qVUgOCG3ZZQadAXwfHEc7fXoUP6XBcEJdqFB4guqCu
	0qcEfqw==
X-Google-Smtp-Source: AGHT+IGxAKGLHfU5lr4cLxfntoHY/lII821Bv6GcWrrnRg5nZbXZHQCblMErp4nOuwdOu0LpnsGeX3qwWfLp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a63d:1b65:e810:3ad3])
 (user=irogers job=sendgmr) by 2002:a05:6902:1889:b0:dc6:dfc6:4207 with SMTP
 id cj9-20020a056902188900b00dc6dfc64207mr903918ybb.10.1710036341778; Sat, 09
 Mar 2024 18:05:41 -0800 (PST)
Date: Sat,  9 Mar 2024 18:04:59 -0800
In-Reply-To: <20240310020509.647319-1-irogers@google.com>
Message-Id: <20240310020509.647319-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 04/13] perf expr: Add missing stdbool.h include
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

bool is used in this header and so stdbool.h is necessary. Add to
avoid compilation errors that aren't currently seen due to transitive
dependencies.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index c0cec29ddc29..d4166b3eb654 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -2,6 +2,8 @@
 #ifndef PARSE_CTX_H
 #define PARSE_CTX_H 1
 
+#include <stdbool.h>
+
 struct hashmap;
 struct metric_ref;
 
-- 
2.44.0.278.ge034bb2e1d-goog


