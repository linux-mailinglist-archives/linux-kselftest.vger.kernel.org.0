Return-Path: <linux-kselftest+bounces-6158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA0C877512
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Mar 2024 03:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED001C2095B
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Mar 2024 02:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBBB3A1BE;
	Sun, 10 Mar 2024 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LlVbaPzg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CD39847
	for <linux-kselftest@vger.kernel.org>; Sun, 10 Mar 2024 02:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036360; cv=none; b=XPlBuTbPq4q3+R8X/aKhh8IUnkH4n1QtCmr80g6RPpAw9Bcrk3QwlAh3Nt2KN1gPR2R7l5wMOct73iUK6bu67kopMHaKsjrvdc4bLC1H4p5GqvFNHDvUNqdbr1xdoUQC5H7h3Mq/f4yDHIUbxwF5eHI4cAwCwKXAwIZvtPZ5PFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036360; c=relaxed/simple;
	bh=ZWL6CpbSDkoHT9bHTSvzN2HvMNxtU4EmDh1g2wTW1tQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JzUPnJSWF5wGOZQxQc1qOK/8XnjIc0a1UQRM0SZ6UJ3OKQ96WBBIbzbi2l3olKwZltCpNQWatqGFrzzfit1uFjuHhlf1DSD7uYd5zbdzJcncGfClAwqNk2P93l4LRUcY8QU+JwD7x3ADw7MUvTnH6gpYqITP2CFYoOgonQp65z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LlVbaPzg; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so2361889276.2
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Mar 2024 18:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710036357; x=1710641157; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcbTXn+GZg98Vv/BPAp4vRUPCLHW4NXMPZPsnrVHKvg=;
        b=LlVbaPzg3SZLzeFq+0upg5FmL3naDuQtNeVRRATjaVIr2Ao293gZStjMay0I88luJb
         REZWEdtqNVjNwvVaG85n0qI61sVPKbW71X5dQN4+gbn7LnuOkPQsUhzejb/2OF2y6b13
         G7KKYmjBXkkujaU+hIErFoa0+02M3n4FD+uhgeaOZtQVLT4NjD4xAK1VcIR7DWWwdFP6
         tOqhUI//yL8wD8dNPA6Q9gXmA5Xkc+LXyrE2mrZ+3M9kQm0LEN8W70xqqiVI/uaArFXI
         h5jGKEiwZOhtgM4DmUMMXktvWALZTepJakcPvqdRTTHbDTMQ1+lUtXQXtOkyznvsVOIl
         07/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036357; x=1710641157;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcbTXn+GZg98Vv/BPAp4vRUPCLHW4NXMPZPsnrVHKvg=;
        b=rugF8bPnzFXGdTs1+W+CAdw8cRCRblfPfaTuNbxlkt4lHp7JJ3AWv24msCHPcso6gl
         HOOmK53nPpNsseCu0c0+SUvf3qIKwi73UJ6JWIP8bCYoYZFBZbJZiqIRlxb/WpYpDnJ/
         JAzhbtvJXKyHVEytcf6Y6NWDv23DawQVIXzvxo73n7mreOQQS6zN+eRiHkI0MD2I+wEq
         QVR9GRD667V+y9y+BxZkisdaicsWk3zOpYrTYu8wbxMGl2uY2s7EXzJNvLKLzyAN/j5x
         r8KROimmDdrErrso0kgMZ9nDBCja1abUau3Jjdoc8huxL0SU4JSerC5V7gwMw42GazjR
         RY5A==
X-Forwarded-Encrypted: i=1; AJvYcCXv00noWxQfDTyLqJRfiDRCUsQCMCqXcJ9l++tzph626ZXH7Ts6G/yRHeyE9HmPbNGk1rJoYzSNR9P2tvLuNG30Nk2kSr1LaFSCllAWQl+I
X-Gm-Message-State: AOJu0YyMj1QpcoAdSJ705lpzkCv8GN6uveb6X2Eirl23OlUZYkwoR5iM
	8ttCfkhlptX6w6GhmAGalQhLzmqLn5CyPnsh81ZsE8JaAlT99L6NZ45w7Wh6IDlqYalUQ26m5YS
	LvcC7TA==
X-Google-Smtp-Source: AGHT+IFh+Pg/vPJRzp3HY0EtlqFR8c7TCYxcMdD2zR5o/IcNrp2JWb8OldTiph3/7rY2TpwrRD4D5cJe7AWq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a63d:1b65:e810:3ad3])
 (user=irogers job=sendgmr) by 2002:a05:6902:b06:b0:dc6:b982:cfa2 with SMTP id
 ch6-20020a0569020b0600b00dc6b982cfa2mr183760ybb.8.1710036356770; Sat, 09 Mar
 2024 18:05:56 -0800 (PST)
Date: Sat,  9 Mar 2024 18:05:05 -0800
In-Reply-To: <20240310020509.647319-1-irogers@google.com>
Message-Id: <20240310020509.647319-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240310020509.647319-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 10/13] asm-generic: Avoid transitive dependency for unaligned.h
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

unaligned.h uses types from linux/types.h such as u64, but doesn't
directly import linux/types.h. This can cause breakages when the
declarations of the types is reliant on a transitive dependency and
the dependencies change. Add the missing header file to avoid this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/asm-generic/unaligned.h       | 2 ++
 tools/include/asm-generic/unaligned.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index a84c64e5f11e..0cbe118e25db 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_GENERIC_UNALIGNED_H
 #define __ASM_GENERIC_UNALIGNED_H
 
+#include <linux/types.h>
+
 /*
  * This is the most generic implementation of unaligned accesses
  * and should work almost anywhere.
diff --git a/tools/include/asm-generic/unaligned.h b/tools/include/asm-generic/unaligned.h
index cdd2fd078027..768cafe6702e 100644
--- a/tools/include/asm-generic/unaligned.h
+++ b/tools/include/asm-generic/unaligned.h
@@ -2,6 +2,8 @@
 #ifndef __ASM_GENERIC_UNALIGNED_H
 #define __ASM_GENERIC_UNALIGNED_H
 
+#include <linux/types.h>
+
 /*
  * This is the most generic implementation of unaligned accesses
  * and should work almost anywhere.
-- 
2.44.0.278.ge034bb2e1d-goog


