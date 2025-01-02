Return-Path: <linux-kselftest+bounces-23819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBB49FF7C5
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 11:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8AA1882EBE
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 10:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9A01A23BE;
	Thu,  2 Jan 2025 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGxGsE+D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832CA38F82;
	Thu,  2 Jan 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735812313; cv=none; b=pc47VxmY5ZiVmNxBCM2TTWYHQDPA91C1b7BbetdzYbBLUXuOy+xSx2PmOAjL7cGezV7xC4QEFCNSpQP4fvVtSa5Ufd0ye8/pcnZKVQ0o/o6YUx5/pzqqPqrqgHZbiANc9j1OR8AQl94lEHVS3FWaBzReK0YT7GwzDYq7TOjLCOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735812313; c=relaxed/simple;
	bh=b9n0Nfj91k3h2Q0NrLnOiA5u+xyBUwsV4tN9YTKRxUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OYUv4e0Tsgl1GZYwaYnrIiKYWM/4qMNCgS3NTwUg2o7swrsE6LJbnQuljQBtwYP4OodE0tfe6X+xXuTBHICCPgcyhAnlcdcYJKNGBKwWjHcssawSzOb2bq9FfpO1noqFY3KU/tpQZH36ey/gCFt8Fe+naLXC57Gu6gk9tVRaQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGxGsE+D; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2166651f752so175959855ad.3;
        Thu, 02 Jan 2025 02:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735812312; x=1736417112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNHzGCV835rfMgYwKPqKqPeLuQwNVSkguSfQpszEKyw=;
        b=IGxGsE+DDfq7JMs4J/YcyXsEwULhjEhMLQV9ELeFWrZz3K6NcuLYs6s4QLH7z2LpeF
         LtPNSGPFgpJ3m5RzFjBUPlKW3Uef4fUaIOlduuYIpOgcoB3jD3uk/jD3S6SVKv+Mxrv7
         jCrz2W/yCosVi7QDlP6cpZdGdhJREUZCLt/OCHEotLgmAgnp3w+Wq55T0a7ySfvfv2Ba
         0A/Mob4h3Ebgl01OUnpHIl5uXPlAxZP5TQjDu9GcBGP28TFhC0T+nNowOggLNCjrVg0G
         ctmQ06CT2G33aqw/s0Xj5EN7XoAZoSVsLX6XGeOtyguVMWvFlQiKjHBuDU5tBf7h5gJe
         a+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735812312; x=1736417112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNHzGCV835rfMgYwKPqKqPeLuQwNVSkguSfQpszEKyw=;
        b=wTlDZqzfFoDVXi62O9NHwzXkeGzKeEud+hE0evfL6y3ZCb7oYpMjT09gOq9cV20lb2
         E/kgm56G+HKeufXyP5y0xJ4WiKiwpX+BH4t4OpBzvYD412SO4rcHcA+czzeDcBd9RD9Y
         DA+27bm5xFPjcHlkalZIj3d9UM+KP+kT6xp8JdBjBI6Wz39w1ZtTp7MJS+/aOc6xFbi0
         WELocWGVZTGw04uNN97w7cXFXm4llc4j65ICVenPfDwevVY1NrDhLHMGO8vBVqNfOSqm
         dVyGz170+li4n5SYWReiS48ayQylqDbnE2Ufyy0jA6utLSaROwxJV3h6GaZMwERVEKev
         Ntag==
X-Forwarded-Encrypted: i=1; AJvYcCVZbDdej3M/qfCgRHZIgjM2ApqxzZSFUrE/zE7MAeU99dy07ji4cvUS+VJTlxcUiKNwJ/k6RKKrJqreIcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGtYiiwHoDEMLxlNPWyp1bN2CrnIgV0EJ7MoeoxxQhmpSu0MF2
	ARG2QPxxf/vc1zqaEPsnKm2BmnOx/xJhc0kbXGHYKCmfteI35jdD
X-Gm-Gg: ASbGncs1Z4Z0WeEhKaxZCVYPCyarLBgP1A33oPAEM6j1CZbZ+FZSkxkkLUYnor7p5hg
	naJbakBGL5oldRAxyvsuYbYIGOWTke/TNAKj+YC+rxZLG+e8JzUGN9rDYUsIkYOu92IYSL/BusA
	iSPmfc+6dlBy44o5N/Ty+UtjelTg/unKtYnJavF8YViT0cf1FPgXgQwnkmNqTfF5i1JT46EOA3o
	7IFn7DJaL8kHk/Mj7MkiQ7ECcW8ukT1nm9DHIQNn+jQPExBxhYgAGvJ5Ulby7yw56lMVw==
X-Google-Smtp-Source: AGHT+IFldj1if8zVbTvd5PDfPXH25cCNHuSw/XOHV0+DzqhjVMup+QSPzaNNiyCG3KCag27u/etb6w==
X-Received: by 2002:a17:903:2285:b0:215:3661:747e with SMTP id d9443c01a7336-219e6e8bb0amr613483315ad.8.1735812311489;
        Thu, 02 Jan 2025 02:05:11 -0800 (PST)
Received: from 2abb50c-lcedt.nvidia.com ([203.200.25.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f7457sm219759945ad.201.2025.01.02.02.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 02:05:11 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v7 1/2] selftests: tmpfs: Add Test-skip if not run as root
Date: Thu,  2 Jan 2025 15:34:58 +0530
Message-Id: <20250102100459.1291426-2-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102100459.1291426-1-cvam0000@gmail.com>
References: <20250102100459.1291426-1-cvam0000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'ksft_exit_skip()', if  not run as root, with an appropriate
Warning.

Add 'ksft_print_header()' and 'ksft_set_plan()' to structure test
outputs more effectively.

Test logs:

Before Change:
- Without root
 error: unshare, errno 1

- With root
 No, output

After change:

- Without root
TAP version 13
1..1
ok 2 # SKIP This test needs root to run!
Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

- With root
TAP version 13
1..1

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---
 tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
index b5c3ddb90942..657b64857e82 100644
--- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
+++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
@@ -23,10 +23,22 @@
 #include <sys/mount.h>
 #include <unistd.h>
 
+#include "../kselftest.h"
+
 int main(void)
 {
 	int fd;
 
+	// Setting up kselftest framework
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	// Check if test is run as root
+	if (geteuid()) {
+		ksft_exit_skip("This test needs root to run!\n");
+		return 1;
+	}
+
 	if (unshare(CLONE_NEWNS) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
 			fprintf(stderr, "error: unshare, errno %d\n", errno);
-- 
2.34.1


