Return-Path: <linux-kselftest+bounces-14217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089A793C00D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 12:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2D91C219B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 10:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452C81990BA;
	Thu, 25 Jul 2024 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juWPshJA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F8F14D457;
	Thu, 25 Jul 2024 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903959; cv=none; b=iVff/yybWXGUr/fW8zR1oGWRLW+UB7Hvz67f65T9eGD178Bb6nF/2SExkk2XgP26Q4wr3QHCCZ0syDIy8u9qDvPgHMlxR4Xu3wgMN25oz7j5MLbnedAi3FABrZRWAC2s7tDH+uzRAN/sXkiIZ13l4DWkUYUB3CXZl331xkn76hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903959; c=relaxed/simple;
	bh=spduKz3MG08ysTbjR+T3/W9hmuI0dpTQAjF2pWukz6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BkmJyF1MmDQbHLLHH0Fcc45E+ohjeqrO8TAJkmfhp0unC7KBx1MCQOezT498CtF5p2Df6JHSYH8eZ3EklBEWBr62XP6wQK7+fzwjzW2dgOjYj+exwch7MRdk87ZkG4PnYeyxfQ18UB2VeTsHP3NUtHBQ6ZjTN5HQ8u0DrRurZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juWPshJA; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7a0b2924e52so510127a12.2;
        Thu, 25 Jul 2024 03:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721903956; x=1722508756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWKiNJXsPoK3DXrf/1mQJ65mXagc2GxO27bBCQyvS1E=;
        b=juWPshJApTno6/8/owTwwkzziBNyuzCjvFSWtWyonHoDqBwwyABR2FHW3L3HLqz1xE
         zzhQcvxz+Ydi//SOWhsGdUUnnpH1JilRzULk2G4JR7DvRvB8kMt7s2gbxqZTBSOIY8FO
         0pwxra3UTpzR+oULlX/6S+Y0S7KMN4xRMSvkZV//rMe6g72LXcuA5FQGOTCDrvgAwz46
         gVhytqw55CC573a5iQgg4nq2gipvxxrewaZhsvZtxd/FcKKuqZ9l2iArsdrexOgyqrzE
         g1aZ6nbj/dBFqln1UdYwLY9VEY1FxjdpdYvpVShlKu7SRB0cfw+JmuvejcjNMySFb/IX
         ZYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721903956; x=1722508756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWKiNJXsPoK3DXrf/1mQJ65mXagc2GxO27bBCQyvS1E=;
        b=YtyioW1aaGrbMPNjZdSPQ79xVAOZbqcZ0cCpIboG1ozaup80WM8Sz8G5d0tPCBr3NE
         sySUqKgOEx594FhHBmVKmvRUViV7ZEspFe/7pNRjjCx3CEXL/uAMOia/Gg4QCUIqfzVK
         P1QDsq88YsoIoD5uUh7cHn4gOOmqB8WoC57s7gNjVXBqGJw5gtlDjuqlP8ikfHlwYyNB
         Bawdm+UT/ptUna+GytbX2FWqFvnvhIp+RmPOpcizo0NUqMbJsQ4WT9fOgUglX+e7ncNf
         B7gHlb7Bj236wbSwFn/Xdd4dVWP5DEYayJ+AYk9diCOgovgsf/6xs66f3AKQR59NB4hH
         FfIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT4lCTQD6UXlCVZbUeteOJ22fFMtrX9J0Z+3qCSaAD7zwhvyBcxGhWO4V2xBEAUE6X5pqIy73cCBiyVj4FpFPKwyqmZXPYu/BneDzP6vQcTAuMuiBwC/hu50LXIFkfP8EzGZwlp41j
X-Gm-Message-State: AOJu0YyG+So+CIEjNwI4HOTspfcE4r3Jz5OWcpJOSmMDWBPbar3EkvJ9
	fYYammfC31ql0pU/Q5eXW53tVV31j141TF5gUImlX2QuVFj1S7p28Ki19zxQ
X-Google-Smtp-Source: AGHT+IHPgjFCpbUHKZfZG8MIHeQRMA2ox/NTTKbs4wYPznMHuq5r+zlurWLe2r2hANNpk7Ca03CVYQ==
X-Received: by 2002:a05:6a20:3d87:b0:1c2:8cf4:7656 with SMTP id adf61e73a8af0-1c4727aad6dmr3324941637.10.1721903956411;
        Thu, 25 Jul 2024 03:39:16 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f78491sm10991075ad.244.2024.07.25.03.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 03:39:16 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 2/8] selftests/bpf: Fix arg parsing in veristat, test_progs
Date: Thu, 25 Jul 2024 03:35:54 -0700
Message-Id: <b488b997e1b966f6d35a2767da738fc9a44023a8.1721903630.git.tony.ambardar@gmail.com>
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

Current code parses arguments with strtok_r() using a construct like

    char *state = NULL;
    while ((next = strtok_r(state ? NULL : input, ",", &state))) {
        ...
    }

where logic assumes the 'state' var can distinguish between first and
subsequent strtok_r() calls, and adjusts parameters accordingly. However,
'state' is strictly internal context for strtok_r() and no such assumptions
are supported in the man page. Moreover, the exact behaviour of 'state'
depends on the libc implementation, making the above code fragile.

Indeed, invoking "./test_progs -t <test_name>" on mips64el/musl will hang,
with the above code in an infinite loop.

Similarly, we see strange behaviour running 'veristat' on mips64el/musl:

    $ ./veristat -e file,prog,verdict,insns -C two-ok add-failure
    Can't specify more than 9 stats

Rewrite code using a 'for' loop without logic dependent on var 'state', the
same approach already used in cgroup_helpers.c.

Fixes: 61ddff373ffa ("selftests/bpf: Improve by-name subtest selection logic in prog_tests")
Fixes: 394169b079b5 ("selftests/bpf: add comparison mode to veristat")
Fixes: c8bc5e050976 ("selftests/bpf: Add veristat tool for mass-verifying BPF object files")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/testing/selftests/bpf/testing_helpers.c | 2 +-
 tools/testing/selftests/bpf/veristat.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index ac7c66f4fc7b..2a73b72feb18 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -227,7 +227,7 @@ int parse_test_list(const char *s,
 	if (!input)
 		return -ENOMEM;
 
-	while ((test_spec = strtok_r(state ? NULL : input, ",", &state))) {
+	for (test_spec = strtok_r(input, ",", &state); test_spec; test_spec = strtok_r(NULL, ",", &state)) {
 		err = insert_test(set, test_spec, is_glob_pattern);
 		if (err)
 			break;
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 11ec1190d582..6808679827ac 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -791,7 +791,7 @@ static int parse_stats(const char *stats_str, struct stat_specs *specs)
 	if (!input)
 		return -ENOMEM;
 
-	while ((next = strtok_r(state ? NULL : input, ",", &state))) {
+	for (next = strtok_r(input, ",", &state); next; next = strtok_r(NULL, ",", &state)) {
 		err = parse_stat(next, specs);
 		if (err) {
 			free(input);
@@ -1513,7 +1513,7 @@ static int parse_stats_csv(const char *filename, struct stat_specs *specs,
 			*stat_cntp += 1;
 		}
 
-		while ((next = strtok_r(state ? NULL : input, ",\n", &state))) {
+		for (next = strtok_r(input, ",\n", &state); next; next = strtok_r(NULL, ",\n", &state)) {
 			if (header) {
 				/* for the first line, set up spec stats */
 				err = parse_stat(next, specs);
-- 
2.34.1


