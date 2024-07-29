Return-Path: <linux-kselftest+bounces-14371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABE093F0F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 11:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDA91C21A70
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 09:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F5513E8B6;
	Mon, 29 Jul 2024 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK26g7xM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAFD13DDC0;
	Mon, 29 Jul 2024 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245082; cv=none; b=quc7vsnHxdljB1tpIKsSMA44PzK3KzdwhSiaRKD1Y4nqWJT5CDA9+NsMb9Q4XAerelDkkTTsY5PHdEMiU9AJeTmc2ga8cxGnNxvFg7KB0b116uMZx7zPuKMkoRTkSo69j1KEKZidyZqvjOzA9GYzVPqrz0xCQs7dJ5wt9LyduoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245082; c=relaxed/simple;
	bh=mqau6BYFCsnrLX9rIGpXbOOrld7xoidDlOUjA0t1Ii4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qCNGY2alNQXiN9hx4p8qUTv9XIFzpCbRsL47LfBQyaX9nZDLum1eMswgdbD72DCyxsEczniuExB8JD/vYj/9S7LahZb7jVYIsGuPpaw/AZ6GhgUvCqPlD5brA9upCeJPNoRRfMmaCuue5DJmk1SzP++TQW9Jj0Nrau+PDaEJRBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FK26g7xM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc66fc35f2so17230305ad.0;
        Mon, 29 Jul 2024 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722245080; x=1722849880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8u/O4Ht4iTO9/a3lv5vZK9Oe8/7dFCMI+nDwx91aig=;
        b=FK26g7xM+81OXxuZqO3u5GtlurkM0ZAi8XyiISmQmUt3r9+o5zIfc6tRzsVyuGZ4J9
         45x6jU5sTUeHhmljWWH8zSd3NaijZtRjvDH9y46xn4n2Ki+U/dTIIEmUtKzIeYnmoz+j
         T+Ln1aMpTZai0FjrqB9g8Y2stJA0dPt/ID32iVcoX7wJtDINWoaVnW0QqsjWOSOuyP6F
         60PrnDikIk9/WkhDUsUFkKm/BIKCGQ4+3VQsxuNVWT23Ra5rnNXi5KRhIanQfhM7IYwQ
         IGudlJ2HNALKCybwQHAOQvITfrYnsnHXePuUtvhRM0eB3yj0ISWBPPrZ+JZqHm+g2iXc
         CFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722245080; x=1722849880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8u/O4Ht4iTO9/a3lv5vZK9Oe8/7dFCMI+nDwx91aig=;
        b=A6fgWmrbLy3ZxPogJyz4UhoLM7A32wQrCgcXjL/api0wgdSgLwwRQv751pDJVzX0Nt
         9ehXvD3KHDSb1rrOrqWvTeMiMpA2ZBXNYFlUPF5EQlp7E5oVo4BtYHqzVuvePM+vRiB/
         cKkb7zsiyj85xiHafB4JJaSMRTTrfuLnuKpKFMkwXMIEaifUTct05KW6Ya6YalQ7aMBU
         8EGFZtudwfjiIjHQ0y+uW5bv3v2dTyS5synwAy3ZdwTAB4E5faTlmqbcotGLPMez4SxS
         +vzI9nSjhjy4ACOrQBkUwXy0i1fs2hHMrhhppFIQW/NJKN9+q1rUDwN3O8dQKXi+Gatm
         KB6w==
X-Forwarded-Encrypted: i=1; AJvYcCXgIx7HrTwtB3RV0DKuVyGEvmDcc8txesKz7qIaz3AxDsg4azyBf3mXvq1C4hhdPKcqnEhe8Ak2cvTEG0OWvE4vxfwvPpKoPbw9J7FtfObcrDXJCSbVFU25k/FlhYL6OeTGiVkoPkLG
X-Gm-Message-State: AOJu0Yx3HJ+7w+C4loOBLKKFwM9Yc/4tOuRnntni4JkooeKIgKZUTMY6
	kQc3bcf+drghDknfnsGKvnbCwEY4fZdA0+qQyFHV9HBnziKC5/rVlrEXjzql
X-Google-Smtp-Source: AGHT+IElBtnb9CIfRmzOh33uMoXdwdd5Cp0grdAW8W2Yt+zJ9cicqpZdnsTVmNNCgcFzUHdGv03QRg==
X-Received: by 2002:a17:903:40cb:b0:1fd:8f7b:1e88 with SMTP id d9443c01a7336-1ff04a4f98cmr95439365ad.12.1722245079478;
        Mon, 29 Jul 2024 02:24:39 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8c19dsm78119145ad.54.2024.07.29.02.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 02:24:39 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
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
Subject: [PATCH bpf-next v2 1/8] selftests/bpf: Use portable POSIX basename()
Date: Mon, 29 Jul 2024 02:24:17 -0700
Message-Id: <0fd3c9f3c605e6cba33504213c9df287817ade04.1722244708.git.tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722244708.git.tony.ambardar@gmail.com>
References: <cover.1721903630.git.tony.ambardar@gmail.com> <cover.1722244708.git.tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


