Return-Path: <linux-kselftest+bounces-14216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A2493C009
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 12:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029E6281D03
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 10:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1530198E74;
	Thu, 25 Jul 2024 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2lL6Qwr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFA214D457;
	Thu, 25 Jul 2024 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903953; cv=none; b=dM3XfyWtsIhQUH7eevki37xRbe8IvtkA++9dlbWQ7jk2bdEX2chfO7SmSMuIV6b5+GpIYdNAWEp1NUHPzoKiu4uCbh9B0nrHSz9AQtU2KZq+LkY3u5e9UHZc/Cn+hC7JdkAFDJPq/z9x8amTw0BHIJs9NeQnCOyKEDLcQB9/hwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903953; c=relaxed/simple;
	bh=FhhULHJSRQRfqOkOSBVfyHqLgWbWh8s2Lych3idzotM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sv9W3hP8VorFMoxtCqSeEG083hqjqgSH2K2ekh829iOTqbX+uqXXZpFCrN8TOMz4PxrMEXjUjq/YzevM+mGO8MKj9N/ftqNZoIE0dKoP0rV5+qsiZvnuT45IsiO1wCjfOkqr6m/ehSe2O9oPGsdBpudOCV30YSaOOq2uh2XUqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2lL6Qwr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fd9e6189d5so6498795ad.3;
        Thu, 25 Jul 2024 03:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721903952; x=1722508752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ghp88PrF1o/2mzcoM7JfrRTyuYzOPJ40TUi0UK8SVqA=;
        b=d2lL6Qwrcr6Bu+xuhiByTGZ72SwEHoxl5hR4pzOlcimEGeovCxVFxc91TVhVeeazkd
         PEP0raLrCxaVm6G4OvggGAT22+hVbVXxoPsGcN+QXGUjqGjYI4W48+qdLlkDVy7t5qhh
         QaJ0EYWedLbVraBp3Hk7nByvJqGNl1MXs2m647dd81IZQ/ejzevpc4uulWUVnKfXJgRG
         Dktf/F8ZYO8r5tNqVO3ECX5hKyFDfAVggErKY3qVZ9bIeyJYxPpsT//+nWYnwdTgCYyB
         TUKuesq0eyo6SewdDhDIk0o1ZyvlzJGe7XIj66ganUujgdSy2XnJmub2qnPFDPQhxH6L
         1Lmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721903952; x=1722508752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ghp88PrF1o/2mzcoM7JfrRTyuYzOPJ40TUi0UK8SVqA=;
        b=iaKvdVqOLJkjzDS0iUEIQnpOs5xmSDWJZdeyZG/7Z/fmTH6pt8PEY3pEqk8Ua3Nrb7
         SCKHu7oG2dmOT/9pHtxyc+kQFXYJtaXeVsUXAzmqo002z94sl6Fy3qIOEnd90S7IF59e
         Qt85UJo9qbj38LrbJ9b0ECIsQR4BqCmy2nsCdpueP0JmBkuufKmpltSRx5l3XS/H08GF
         1IYgzNWBvJ4BhaTwhRvnfxFvRZtTSiSjcxz7q2RWDurM5IQ3E9AkRRXEY1g/hC4E3x0G
         LwLhbUeEjTThd3LDAgG62ucjIkWz6UgNF8RfG5ktr3qe/s5/SG3mnhbxGxtCVZ/EwYI5
         zk2g==
X-Forwarded-Encrypted: i=1; AJvYcCWwxknLXr8kCZ+s2ShnGLumdZdZ0ZV/M6gjEcRH7eZFyU27dqj22NPscOnnUEMaVNs6z85ZJL5mGelHLmkAfAkp7GyXBC2rWI1sfZf2Novngg/MFgK0ZXJ1X5Drhbs6TpNlQGrJnSqZ
X-Gm-Message-State: AOJu0Yzl192NToem0SqnfayoUtRd1QbSjw3vrqtQA+xD2PMgWtbmxLoB
	WpdOP/BBHGB/k5F81uTGxiriruhU/Cp0CNzsH+SvELl/KH+t56DB6o13KVYi
X-Google-Smtp-Source: AGHT+IHIy/VccFzu/PejmYfYrlXyVUe0mollB6ADsyNs+yD+o6XPQfOPVqoASrMH/7qtfhA6eLZ3Ww==
X-Received: by 2002:a17:903:228a:b0:1fd:6848:bc2d with SMTP id d9443c01a7336-1fed9257af7mr13548175ad.20.1721903951607;
        Thu, 25 Jul 2024 03:39:11 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f78491sm10991075ad.244.2024.07.25.03.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 03:39:11 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Yan Zhai <yan@cloudflare.com>
Subject: [PATCH bpf-next v1 1/8] selftests/bpf: Use portable POSIX basename()
Date: Thu, 25 Jul 2024 03:35:53 -0700
Message-Id: <570a059b3db60199028e0a36896be0f1b472b9cf.1721903630.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721903630.git.tony.ambardar@gmail.com>
References: <cover.1721903630.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

Use the POSIX version of basename() to allow compilation against non-gnu
libc (e.g. musl). Include <libgen.h> ahead of <string.h> to enable using
functions from the latter while preferring POSIX over GNU basename().

In veristat.c, rely on strdupa() to avoid basename() altering the passed
"const char" argument. This is not needed in xskxceiver.c since the arg
is mutable and the program exits immediately after usage.

Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c   | 8 +++++---
 tools/testing/selftests/bpf/xskxceiver.c | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index b2854238d4a0..11ec1190d582 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
 #define _GNU_SOURCE
 #include <argp.h>
+#include <libgen.h>
 #include <string.h>
 #include <stdlib.h>
 #include <sched.h>
@@ -988,8 +989,8 @@ static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const ch
 
 static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
 {
+	const char *base_filename = basename(strdupa(filename));
 	const char *prog_name = bpf_program__name(prog);
-	const char *base_filename = basename(filename);
 	char *buf;
 	int buf_sz, log_level;
 	struct verif_stats *stats;
@@ -1056,13 +1057,14 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 
 static int process_obj(const char *filename)
 {
+	const char *base_filename = basename(strdupa(filename));
 	struct bpf_object *obj = NULL, *tobj;
 	struct bpf_program *prog, *tprog, *lprog;
 	libbpf_print_fn_t old_libbpf_print_fn;
 	LIBBPF_OPTS(bpf_object_open_opts, opts);
 	int err = 0, prog_cnt = 0;
 
-	if (!should_process_file_prog(basename(filename), NULL)) {
+	if (!should_process_file_prog(base_filename, NULL)) {
 		if (env.verbose)
 			printf("Skipping '%s' due to filters...\n", filename);
 		env.files_skipped++;
@@ -1076,7 +1078,7 @@ static int process_obj(const char *filename)
 	}
 
 	if (!env.quiet && env.out_fmt == RESFMT_TABLE)
-		printf("Processing '%s'...\n", basename(filename));
+		printf("Processing '%s'...\n", base_filename);
 
 	old_libbpf_print_fn = libbpf_set_print(libbpf_print_fn);
 	obj = bpf_object__open_file(filename, &opts);
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 8144fd145237..92af633faea8 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -90,6 +90,7 @@
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <libgen.h>
 #include <string.h>
 #include <stddef.h>
 #include <sys/mman.h>
-- 
2.34.1


