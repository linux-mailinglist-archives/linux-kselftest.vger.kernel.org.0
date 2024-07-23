Return-Path: <linux-kselftest+bounces-14045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0253C939967
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 07:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F7A0B2144C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 05:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1514113D511;
	Tue, 23 Jul 2024 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyTUeAP0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F63367;
	Tue, 23 Jul 2024 05:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721714150; cv=none; b=FIugZ+aONrq1ofJsG9M+tnUrv6vLvZ/wwPXe7Qm7UqaDrCPStXXkaclTG6vkAxYXuEm4IhyWMn4VoWYhsNYJONvzU41VlhgKGYU4Mf7XL9iujj4s1PuiUVpNAVMs5Ko0roUkV4LXQcT4HDuabr1uWofgAT00I7fiI0Ejgaxo/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721714150; c=relaxed/simple;
	bh=2ssllKaNronxEnB4vH8yEfLpTO61CTJZ1bgpHM3sayk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qu64fJcWfaRiTO5kepGLuA/9BOrgEeMsmoSDLTe14VCWtp64enUVSFwTUXFz9PhcEL4DU6dyv7mb5DhqHTNxjn8eZFHga8IjlZWYKfw9v+gTf0CQk7G6KLw71HXwKda/OQhTDPFXnzYFy22Ljg+YV4y/qQsBGc4VtoT4N6ef9LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyTUeAP0; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-79b530ba612so2696105a12.2;
        Mon, 22 Jul 2024 22:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721714148; x=1722318948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mRv7fxGm8wGDSLiyp9Dtkgu4XAwa13vX4fcz6gE0zE=;
        b=lyTUeAP0mjrC7uPOS9Oo5YL7WYizmqquF7omZ7wUETpo4fvJC+O3GQZBgo0mQhGdqS
         koJa/uNfS5v/hQv1nsYF6tV0ZiI0G0AJs9YdUcq10Tub+wUhGGgb7UJ46zaIaeVmxbgj
         nZM68bULxHtQvHOCqOJlLHeprEMpGKG77ApyqFqGAx1bPN5sLfOA+0Sb0JX8bxnaOMTw
         BN+j0iiJiKhyuI7qUj9G4KErkx3/72evoRjVPVipDiO80iLISmtAHKhQ/wxNY8An0YqY
         Oi4Qd4sQQ5w3Ckr3AQiV8H3+w17L42xwfn9lCogs1wbckT1Cf8jVYnSbe3aa4N8pkcaF
         4DCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721714148; x=1722318948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mRv7fxGm8wGDSLiyp9Dtkgu4XAwa13vX4fcz6gE0zE=;
        b=WuXO1OWoj9jazJWNwbjAbLlCAP6rc3IHERmWmoH91NV/yZz7YzhEDzMntmtqPeRk7I
         bjv3Yjjy3yErB3SExgYXUtiYIh4oOoEOcSOhTggTAHqNVILddSmC6U4O3RnkiR0h0W8n
         enjdnLcZn25HqlJ6Y15N5eZ5X1aHBePhjV3Ue3PVEr+XiurkuI1rPxurJBbvtJXyQZt9
         +QVgXHMGpAcQyQ2UOOlhMjtIbw49tHSj8XjBFBYxbts1YoWs7tWZVreyGi1g8XgD2CFU
         eEQvAQnP0iJTutQXkM2DtOuqGwZZBqK0fg7fQTaUyU6zLtQ/4jqJfFVCGhWbtGu5B0vm
         GXQw==
X-Forwarded-Encrypted: i=1; AJvYcCXkjjLexLX29naDHxYWSWRo7/QaiI5po/BCDb9HYfFw6m8rj3+oOUl4tCPp8a6NMEwheoHhbRJnbOwk8vfEL1qxcb+vknqOcJMoYmf3HNSZ
X-Gm-Message-State: AOJu0YxtUwol++rESWve9PVoQBtSFoWImjF5HBGI+t0qUdr9WmmU9NKQ
	+OqQgOL4h1JN3vxeLxC25AdDl3LBhOFF09/UsuRxiSTKWgtTzoZADA77RpqM
X-Google-Smtp-Source: AGHT+IG2S8c7/eMss/LSzkOz87mSAGlZD/oxADnlBRju4cY9AXwPSj4cmDsB7hN2rwmE7jCr3epcYw==
X-Received: by 2002:a05:6a20:72aa:b0:1c0:f080:ed51 with SMTP id adf61e73a8af0-1c42285defcmr9651578637.2.1721714147871;
        Mon, 22 Jul 2024 22:55:47 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f469df5sm65724685ad.254.2024.07.22.22.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:55:47 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Yucong Sun <sunyucong@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	David Vernet <void@manifault.com>,
	Carlos Neira <cneirabustos@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Petar Penkov <ppenkov@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Yan Zhai <yan@cloudflare.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next v1 08/19] selftests/bpf: Fix missing UINT_MAX definitions in benchmarks
Date: Mon, 22 Jul 2024 22:54:35 -0700
Message-Id: <8f64a9d9fcff40a7fca090a65a68a9b62a468e16.1721713597.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721713597.git.tony.ambardar@gmail.com>
References: <cover.1721713597.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include <limits.h> in 'bench.h' to provide a UINT_MAX definition and avoid
multiple compile errors against mips64el/musl-libc like:

  benchs/bench_local_storage.c: In function 'parse_arg':
  benchs/bench_local_storage.c:40:38: error: 'UINT_MAX' undeclared (first use in this function)
     40 |                 if (ret < 1 || ret > UINT_MAX) {
        |                                      ^~~~~~~~
  benchs/bench_local_storage.c:11:1: note: 'UINT_MAX' is defined in header '<limits.h>'; did you forget to '#include <limits.h>'?
     10 | #include <test_btf.h>
    +++ |+#include <limits.h>
     11 |

seen with bench_local_storage.c, bench_local_storage_rcu_tasks_trace.c, and
bench_bpf_hashmap_lookup.c.

Fixes: 73087489250d ("selftests/bpf: Add benchmark for local_storage get")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/bench.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index 68180d8f8558..005c401b3e22 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -10,6 +10,7 @@
 #include <math.h>
 #include <time.h>
 #include <sys/syscall.h>
+#include <limits.h>
 
 struct cpu_set {
 	bool *cpus;
-- 
2.34.1


