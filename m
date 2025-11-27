Return-Path: <linux-kselftest+bounces-46601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EC0C8CC0C
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 04:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C102534B90D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 03:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B6627EFF1;
	Thu, 27 Nov 2025 03:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlIo8GQ9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09731225416
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764214358; cv=none; b=Ujo//cQV8O3hoEdEq2VPoKl5yx6flr2PSFoT13g6qD8Fw+cz5oyablo5u4bGJjnggyDrp8Ccpi/cbKvlgjUt+e20mqrm1KP0SexTnwh3qGHNh3Y7jn1yzIJSVvH+q0vnyQ0h5PJnGrD2VHD2oYC+ZW0W9tjr+L83/qXD3x2fZJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764214358; c=relaxed/simple;
	bh=RQCpusYkNqhCf/oYYjKg0UCyKstePjWLCBpBHzMw+HE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iRdfWmNifPpFkzEOBg5H3C1/weIqE8VL1U3zHDul55v/rb2ZrTrWoMCInJJ1+ca2fEQU5EEhioY/zhVnNFaZJnTs+Rl7bCQDW6Peta+O+KmrH/V0biYjmf+FGAmmN6zqH5M1cn2v2x6/+0XAg2PqF7B8PJIYgOqKrpnU5gegwyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlIo8GQ9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297e239baecso11339095ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 19:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764214356; x=1764819156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJ1M2Xvyt40lCnxw+Gw/ePOJPKhvduaiNO9FIO7qjnU=;
        b=LlIo8GQ9uSpY9NADk+QQzCwoZaYP4NSDSKnPuWLT64jl6DEmdM4YF8+Th05fLk25M8
         YpUchykrGAUNuaUoIIV6qKZJT3YBI93UQ3jXoDNcFTWsLjU3TT6vVNXZfEpm4tKqmmwH
         TAPUtdJ9oPeZEmnPZxtCaUvnu5lf0vDD61bW4umE0iT7KbAmMbZb805lzNla1Zq4jATE
         wxYO4WC4H4WnxjVwXfqtjMWmpUXvf3oh6IBeWBB2VjoEtG++YtVVAyGTw92d19gzLAct
         Dg1rGZpoDTfjZq8CiS18sksGAeDDHnWZHP0K39iN9NH0YeJ8BoAVW7Yq+NPrlO6xDxiv
         6myQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764214356; x=1764819156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJ1M2Xvyt40lCnxw+Gw/ePOJPKhvduaiNO9FIO7qjnU=;
        b=Ms+LEBRdfOOTV0DKky/0RD3aGSdEd0Ah4EVZHw214LBCNFj5XYRq+lR9Vuu48kpr+F
         X4tQpRyZ0CqcO6U+JPmJxZvJuvzeVvRBmdpyIVv7WGyuPbHkBk9/OM67johdO663+enZ
         TqJalbplQ6zE7VCeYuLlTuM55o/ibYrl0FcRnn0sJdKeSZ+H/zsLRTuXeRGBCAt/xNsJ
         dmuFCJgtJkCJ3jg9bsdimSjgcfO/c7mpLNgf4jCTsHiCzULRoDWTiO9tlaJ4kvy3F5Sp
         aWvSzT6bKA/op2sW8pAQAtaFxlX0QrWP3ZFkSGCNr5pI6NzyVYHBvgYfsqF9n/vigPiU
         wBRg==
X-Forwarded-Encrypted: i=1; AJvYcCUR3NmZBrwa5BaAWhoktVkjiOHoMdo9GgqpKxFdok0WRe4aFmqlilr38sUxc9F8ghQUCkBSpZkXMOTALgXOA3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRSBhQ1TRZlFmrdAkA7B2pEL4zdnJuqB6jEGSsTF6KiKgaoU41
	0/Xk2k1JBKelsFhnrAtZDdJwuCn2IA5X5brfuwcDQRq0B0YfBVMZUu0=
X-Gm-Gg: ASbGncsTreXa3pb1oL+kjYBzDBSQ4gxtifVuTdsgv7d/8W0uV+ofmBALef26dsmYaNj
	NoG3wmnOZYZUS5N5aaYr2Ebp5raLLI4HqMQB1cTDUQw37n5q1QUSHF+G3pwJcUprzmLYWDdfz3N
	UpTSAhQ8gVPYA1m1n0GelDyKVItE4/Clz9DE976eOHArePSgoZBt3MDcNdKQ9x/YxBs3kP/fnDB
	/h9yyuTj8OTlh7JsrfRdPPqCN3jYX7e39sQwB7MVfGnln24W6UtQkJwzSt5muTyZhZq82u5mfkY
	eBv2r2ZJt1SbaA+4vIYjaRsPoRnr8b9XgijST3+TuoZJqe/eJuuaN2rCaYzpJDteFN5kzWlgLiY
	vHs8NBunsGf37YYxSHrlqnseACSP87c8dSSmkivFow09QvB88q16ncar2G3enXUQLBNl4qBiBPZ
	554+d/YzO7TS8ZyWQot8Mh5XSzISE2q97F8xMZBj0j/pmcnGE=
X-Google-Smtp-Source: AGHT+IG3jNbvnvpK7iPmyHhKwaYo2yFYrQWYJT24DmT6DQObpycLY0SOpYePrSAPkXpirXgXx1ENyg==
X-Received: by 2002:a17:903:2f45:b0:296:5ebe:8fa with SMTP id d9443c01a7336-29b5e3b8731mr255928125ad.23.1764214356167;
        Wed, 26 Nov 2025 19:32:36 -0800 (PST)
Received: from samee-VMware-Virtual-Platform.. ([2402:e280:3d9e:537:5870:9b57:1a0b:b0e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb276a7sm644295ad.48.2025.11.26.19.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 19:32:35 -0800 (PST)
From: Sameeksha Sankpal <sameekshasankpal@gmail.com>
To: kees@kernel.org
Cc: luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Sameeksha Sankpal <sameekshasankpal@gmail.com>
Subject: [PATCH] [PATCH v4] selftests/seccomp: Fix indentation and rebase error logging patch
Date: Thu, 27 Nov 2025 09:01:54 +0530
Message-ID: <20251127033154.12290-1-sameekshasankpal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4:
 - Resending v3 after reviewer feedback (Shuah Khan).
 - No code changes.
 - Fixes email formatting and broken threading in earlier versions.

v3:
 - Rebased against upstream seccomp tree.
 - Fixed indentation to use tabs instead of spaces.
 - Used scripts/checkpatch.pl to fix warnings.
 - Removed blank line before Signed-off-by.

v2:
 - Used TH_LOG instead of printf for error logging.
 - Moved variable declaration to the top of the function.
 - Applied review suggestions from Kees Cook.

v1:
 - Initial patch to improve error logging in get_proc_stat().

Suggested-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sameeksha Sankpal <sameekshasankpal@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 61acbd45ffaa..dbd7e705a2af 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4508,9 +4508,14 @@ static char get_proc_stat(struct __test_metadata *_metadata, pid_t pid)
 	char proc_path[100] = {0};
 	char status;
 	char *line;
+	int rc;
 
 	snprintf(proc_path, sizeof(proc_path), "/proc/%d/stat", pid);
 	ASSERT_EQ(get_nth(_metadata, proc_path, 3, &line), 1);
+	rc = get_nth(_metadata, proc_path, 3, &line);
+	ASSERT_EQ(rc, 1) {
+		TH_LOG("user_notification_fifo: failed to read stat for PID %d (rc=%d)", pid, rc);
+	}
 
 	status = *line;
 	free(line);
-- 
2.43.0


