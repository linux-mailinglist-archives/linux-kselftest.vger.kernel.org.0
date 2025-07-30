Return-Path: <linux-kselftest+bounces-38087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6A5B166E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 21:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270851AA7CE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 19:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1F72DC358;
	Wed, 30 Jul 2025 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJJ28TET"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745FD2D613;
	Wed, 30 Jul 2025 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903686; cv=none; b=GWCX0gBic+7CWcdGZ9WaqP+U5mYoBfbOk6ugPHVplxl0x9cVu8GGLGuOZf1KRRDAO4F2IefQ/w5Mh0egnBoCAewlCAzGPZniEhLLnSbhC5xJqesynYS/xSO5MDQG/tbrntCSfSBGjKqLpTcu7AdTiZJdV6G8PzHLLBXBFtZAj7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903686; c=relaxed/simple;
	bh=iR5+uRBldWlcUKs+VpB/kO7cqjcEx28y65V3BAPL9OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cwi97akjuO9YJVmi2np6zU5YRJM9S0vcDylpv+6RHRkj9fACW8c8QOYJ6yNJF56hWa4PxEMGv8JjSPh0dS6h9GQ9kguarvNnpJTt5A2eAxffTwnWMMeb2YtASZeHhiPZIDBsA1FOvH08NhDTcY6WSo9Phl8WsUFhcE5GnpkObkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJJ28TET; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7642db47111so25048b3a.2;
        Wed, 30 Jul 2025 12:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753903685; x=1754508485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNG8DXgwAP/5jPmamkbii8OoUAG4/pKAFcQJx/eZgY4=;
        b=PJJ28TET2+ELm1+IQYYLu4d3W+N5vZyUJcVKjVIMIKNPPbp8iBbTE7XX7TAdVbYbr/
         yPd+YTspjZ9nZNt9LKi2NxQV1/h2On2vdwbaCuY1T/LckY6t7ihymULBrLj7CmtYU746
         qHZlbTSLU+cgaptPlRlzldYYUINBQhfXmQHvmM12PLl/4Gfq3+VftbXkMkBTcnSuEFny
         PmYm2O0uURs5+BCg8++w2aCd7R3ST/fIvWNPwO6wvY/UqI1TBy8NksSOKApeLbli91IV
         dMACS7c3RjUsXKL1Fh/F0Epf1ca/Fyn49V+Ye3x7eAmpm3jWZPH1CJvb0HC/OdchdtGJ
         44Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753903685; x=1754508485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNG8DXgwAP/5jPmamkbii8OoUAG4/pKAFcQJx/eZgY4=;
        b=FHFvT31zK1MorsMckVsQIKshCETUvg87f66L9ImtPqP24A98+GeuDH2OTNUeJcG77u
         O/r1y4Z1W5/Fe55Pj0LzlqzCYoYBX+AdIlamtXEzfTPbPCWrlu48QiqGme60MYjGTyU/
         aQhmQF4WEgdf4O1f4arz8nbiNgsYNySacfGoyLv1CThpteLThFD1eqnXbLpBu164WQ6R
         WvoPDZJobYi9UqvzLMCU1uCRb82TPkmAXlThFwX/MdAYh2PoqU1MQqY6Aj0L4TKaIt0a
         0uB2Dpcslrr38xBJ1SmeFoctCx4/H0dceqVpRUosc8VTSTq6vbQPhnLO9RjnOQOugz6H
         MVKA==
X-Forwarded-Encrypted: i=1; AJvYcCWmWaIjmxQVbb9gZmsBX987jkP5CCFMwYsEhbyfrzL2l5H+1YP9AcD9dojUFYW9yzH7BU9pUzWvB276uJQ=@vger.kernel.org, AJvYcCXVUO58Ht2I1hWM1SucWmkA7f0m4O6nRhnP4eQWLmv+eZZ0BLyerN+qleQCcREpUgLLSzIpxgvCle+qYps9vlNT@vger.kernel.org
X-Gm-Message-State: AOJu0YxfMGUFDBNARAsdcdh1RQj0h9P/RwMrP6yPu5Kh/E/NfiNX6XQ7
	ZeVai4iP5Z2cF+zCzOfXzaZAPRUYFznLtdsZ6Ebe4mSDuMp8+Yvj/K3O
X-Gm-Gg: ASbGncvxnytXQu+I4FqCirwSvhwbdduVeR+15FAYijkhLHGH8yqEoPA12eiMWqWkNK2
	Rv7IexKS7kw5yr4DS/DiHEYE2Su4u2VYTeepzN+iN0FqsgvfrDPHxhruOI+W9yH9tJoz2eTfPiD
	GfXHiohADdwTXF74upk5zJnrWs+s7ecLBUdZP8/7A8guMmvPdrNvG8nJJOERs/Q0sbYHRQovE39
	6eWyHLrpISLeBPkS5vyFvXu9VCKlQt6Ghkq5rJ8qdfRGSUglKPwc5XtSSwy+VXTcPqCnE/jPR10
	niTcLFLjBkmxmtcaMbGwivx+VikE61+N3qIpkGCePmKWIf/rprH3YHngknjoFeD7nt7kznGQd3x
	DoYhtVb2lI3Czy0KGK+hnsu6m0PUCIg==
X-Google-Smtp-Source: AGHT+IEoZQqMr5MaOBTYKOEj+gA/zIED+BbftxKTZgXXgkW3/liGpeyXixM9xrSxleeRxCUjjW4w6A==
X-Received: by 2002:a05:6a21:9185:b0:231:242:2596 with SMTP id adf61e73a8af0-23dc0e90f22mr2890425637.5.1753903684654;
        Wed, 30 Jul 2025 12:28:04 -0700 (PDT)
Received: from ranganath.. ([2406:7400:98:2557:8eec:789f:9109:20e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bb007b77asm1256508b3a.48.2025.07.30.12.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:28:04 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: shuah@kernel.org,
	jlayton@kernel.org,
	brauner@kernel.org,
	broonie@kernel.org
Cc: skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Ranganath V N <vnranganath.20@gmail.com>
Subject: [PATCH] selftests/filesystems: Fix build warning on anon_inode_test
Date: Thu, 31 Jul 2025 00:57:47 +0530
Message-ID: <20250730192748.39517-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang warning null passed where non-null argument is expected.

anon_inode_test.c:45:19: warning: argument 3 null where non-null expected [-Wnonnull]
   45 |         ASSERT_LT(execveat(fd_context, "", NULL, NULL, AT_EMPTY_PATH), 0);
      |                   ^~~~~~~~

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
 tools/testing/selftests/filesystems/anon_inode_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
index 73e0a4d4fb2f..f796dad679db 100644
--- a/tools/testing/selftests/filesystems/anon_inode_test.c
+++ b/tools/testing/selftests/filesystems/anon_inode_test.c
@@ -38,11 +38,13 @@ TEST(anon_inode_no_chmod)
 TEST(anon_inode_no_exec)
 {
 	int fd_context;
+	static char *argv[] = { NULL };
+	static char *envp[] = { NULL };
 
 	fd_context = sys_fsopen("tmpfs", 0);
 	ASSERT_GE(fd_context, 0);
 
-	ASSERT_LT(execveat(fd_context, "", NULL, NULL, AT_EMPTY_PATH), 0);
+	ASSERT_LT(execveat(fd_context, "", argv, envp, AT_EMPTY_PATH), 0);
 	ASSERT_EQ(errno, EACCES);
 
 	EXPECT_EQ(close(fd_context), 0);
-- 
2.43.0


