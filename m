Return-Path: <linux-kselftest+bounces-33860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 692A1AC5084
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 16:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D6E162F0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 14:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA81E2777F2;
	Tue, 27 May 2025 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIP/LMfp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211A7275864;
	Tue, 27 May 2025 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354855; cv=none; b=Sd0WxT/k0ujRfqk08IFC588gANlpTc1M9FBC5tOFIIKVGhykjBZTdPV+1XMQewMe25MbDC81xqixLuArJ9LBSPXA+JX0m0/73b3/zIZZEsO7T//KidTtBzAeaPkKyEkgMu3lfsPjt0yUztEJt3NL65ZGOeO6nG8ZBL8UD4HXKcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354855; c=relaxed/simple;
	bh=iV+5TQFLMdpDIjSDs6o0Yi6BOun9sKQbdLa23G/sI5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+wZHOaw43PAiTkAnLkWgpNLOFKfdZbagSI48VBsu2ulkM+iGyITc7/oHnCCqTEQ+PTwm+f/jeClKIgKnzKHeRD5BvtWG04QkSAYme4ZlSYAITsgQ3XIyw5ORKkTDdFl+idgYwEI/8LK56MsYEw1m2TE0wJJcD9wi+AXEJIXkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIP/LMfp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-442f4d40152so4427095e9.2;
        Tue, 27 May 2025 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748354852; x=1748959652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KpK0x0wXhOnGFBSWU3ce03ScwCxpFS8ONVx7+umFELU=;
        b=bIP/LMfpID4BL8IKDRlHYw2ivFF8XBQYjNA1HvS0j9158/trgWoa5OZoFgpgJUUTn3
         GKHeJBVpXhXuh7BPPWLnkLJkG3R7GjUBaaTA1XK6/L24KxfZyDzsp1Yz1U2G+9CSUUx4
         bxhbGkqaPovGg/wV71H+unx3YxgHeiJQhcso54PCPvqP2WcPRHzjaNMq0QgpblnGHhtY
         kR9akhDhDSRbNUmRfpb4OFP36zOgRxmBHEJ48hW9wZlxTvx0sQTevtvtLdm6qT4Af9PH
         bxeNV7z0xz9EYPvi7JekiKsikvh1XnAgm2RZqBoJ8mnT6A4YjAD4Rv3ayJH8SmTXKwgk
         9Udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748354852; x=1748959652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpK0x0wXhOnGFBSWU3ce03ScwCxpFS8ONVx7+umFELU=;
        b=fL47q8XdSLJfO0KU1WZAq1Soq69LaT4789lG0BVIN/0TRdm9zVy9RPqU7A2/wnyFWB
         JLyGx5qc9ftWxa6RDWsps7Nkb7vBZVF0jcDK81I2LzsLim3zFzZqwGqKr7/XaTbI4aoW
         iVqGeF8mDhQdqs41jFSXgBhXKZQMqu/fE/LDEIXsmBrfHCZOkQgA6K9GJb+bJubcu7ul
         nx7gyt+Y4wWQz6q5nrhZe5q4j9UDumVx1VIr2VPU6Fg63UNoP1asICJJK2Pt9DBRpBqP
         CLpDMUJaLTo4O2S7DkhkN7kda9LhiTqnwnecAZPUNDWrbbaMakxchh1sF/WGDk1hK/Ro
         FzNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTQWgJmaAjIKRjgGK7OUtjVBRaabHrC087HfJwLzSrvXTOt8OmSm8oiJIDuGOdWmtNTEBRxivjltQNuCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyev8eSF/b7mAEYBqCh/R9RLSkeM6s9lHOowrexte8s7TyeqrDS
	OSwwYYCYlb/aPp1WoyYudB38tTByH+Z/VvmCWs0yshZEtnM23WqsLNMx
X-Gm-Gg: ASbGncvNSGZIavMNBIzK1Gm58RDm9xS1r2+P0Ebla7Ln1oJadJfLc9LkjAHu62Yi87z
	yPiMhjAtXJyj87wHP5m6HrimYPYr0L3yF0FEy9++UlRW0Ak2EnhMV9aZSUReqAlYPEyG5Lz8XCU
	w4PqVqrl+ZOohO3KIxAIdfCmSA1APEGNBdd/BFWdEm13/aW4ddfzAEdAg/QA/CT9J1cHuJedQXq
	y0mOKmEslCmzNwCWeM9IOjdlN1mfKD+pC79hH3bHJRmm87kDxzka78JvR72YSm2XHW3Gh9na3IG
	hBCc+Uta7t+Z5oZ+rMU/IPrIYKFeXtyl//7Rs2mAm/zQ1Y0d6GHMkWLo0TJ9a7TcTjc8+/6mW1r
	ywSEZ+yCsDEzvKQ==
X-Google-Smtp-Source: AGHT+IF5wR0JTE7yne3C1fjsCZJEquPOk+vzdCS7cS6ql1aWdP7U83LYFb0zWYD9Fq2nGsaFp64KIQ==
X-Received: by 2002:a05:600c:510a:b0:441:d244:1463 with SMTP id 5b1f17b1804b1-44c8f355466mr46368625e9.0.1748354851830;
        Tue, 27 May 2025 07:07:31 -0700 (PDT)
Received: from localhost.localdomain ([156.208.106.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29548sm284630675e9.4.2025.05.27.07.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 07:07:31 -0700 (PDT)
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
To: shuah@kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Subject: [PATCH v2] selftests: acct: fix grammar and clarify output messages - Fixed email case mismatch in Signed-off-by
Date: Tue, 27 May 2025 17:07:27 +0300
Message-Id: <20250527140727.16910-1-abdelrahmanfekry375@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e2ad679c-7c68-44c1-b4fb-20b3d02a7c35@linuxfoundation.org>
References: <e2ad679c-7c68-44c1-b4fb-20b3d02a7c35@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, i already sent version 2 as a new thread 2 days ago
but found out that i should also send as reply to
the original thread so here it is.

v2 changes:
- Fixed email case mismatch in Signed-off-by

This patch improves the clarity and grammar of output messages
in the acct() selftest. Minor changes were made to
user-facing strings and comments to make them easier to understand
and more consistent with the kselftest style.

Changes include:
- Fixing grammar in printed messages and comments.
- Rewording error and success outputs for clarity and professionalism.
- Making the "root check" message more direct.

These updates improve readability without affecting test logic or behavior.

Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
---
 tools/testing/selftests/acct/acct_syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
index 87c044fb9293..2c120a527574 100644
--- a/tools/testing/selftests/acct/acct_syscall.c
+++ b/tools/testing/selftests/acct/acct_syscall.c
@@ -22,9 +22,9 @@ int main(void)
 	ksft_print_header();
 	ksft_set_plan(1);
 
-	// Check if test is run a root
+	// Check if test is run as root
 	if (geteuid()) {
-		ksft_exit_skip("This test needs root to run!\n");
+		ksft_exit_skip("This test must be run as root!\n");
 		return 1;
 	}
 
@@ -52,7 +52,7 @@ int main(void)
 	child_pid = fork();
 
 	if (child_pid < 0) {
-		ksft_test_result_error("Creating a child process to log failed\n");
+		ksft_test_result_error("Failed to create child process for logging\n");
 		acct(NULL);
 		return 1;
 	} else if (child_pid > 0) {
-- 
2.25.1


