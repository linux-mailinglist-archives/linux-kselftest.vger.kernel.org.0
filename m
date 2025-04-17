Return-Path: <linux-kselftest+bounces-31027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C89BA91130
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 03:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306D916089D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 01:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E28185935;
	Thu, 17 Apr 2025 01:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vSuxi/dE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0871CB9F0
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 01:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744853592; cv=none; b=PkwtUvu2NOnElqlVS+xt09ozoZojdkgIokEhf/aFRcNyRHXTaAD4qYcMPHG1olLFyKbdSXXcs9EVOo3szDhtzkbzwPb4/7OJfOBidgB7LHNOX+RcPQk5vcWpajBn64NfwQPRNhZW/tdA58urJ7vxsYXoWSoc9jAVIkMyVhGGKZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744853592; c=relaxed/simple;
	bh=iC38gdoHa0iB1zJg2rOXQF/27QGDkW0uzWiTqqa4j3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AU543kNER2D7V8sFv1J8GvUgCS4b8nIze5kbMgwiE+clQIRm3pryXxqZPkTgkMOWdTDsDPHHtyBDYH+tlBNPM3nGueT6F5+dAeMvF6TcMEZq3A+oBfFJoN2KouIOJ/ZL5W5sKZbO9+X89Ddwfy+OjiLP7aMGpBAps2bYdKtVG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vSuxi/dE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-301e05b90caso192691a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 18:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744853590; x=1745458390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZCFxUxzlk1WaRej7yGOb8bWsdrrxKB0c/PerPrAolw=;
        b=vSuxi/dEclKZP/Uw2HlGkujTqUsjwtcgulp4TI8gVBA0qXXl3BYAdL9Mz5dTEo/a4+
         2+LBJF+x26DlKumHooL/iPouP2w27utGceCOFB3ta5FwokuRCNsESkJP7Q1ROiuMqX83
         tmO6dYZ4OglgM9ncvu30Un7+EnAziLaQ0Rars=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744853590; x=1745458390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZCFxUxzlk1WaRej7yGOb8bWsdrrxKB0c/PerPrAolw=;
        b=gKN5yKT4+U7oL7kGGYI8KPG3mCNfjeL4a09rDlWKnHg9EmpRCXEXESaHEUULxu8y7F
         adb3tqN+JlZ0TtBm6xph8HiQqmJ3n4MAAmcL80kHTzaXBrXbDD/ELr5MU+azo924I54O
         nmkxyragYbsJ6YS+84w+wmIC2yDjVVJCNkpyvHa74nJeHVBJ9dEcUoQS8giZ7CGlLbwY
         Lfz3TyjekByHzwvt1TjMgT4t0ZBtajga3jb//3R/I86fkH0LCT4GFejW0BObYaXoAQqj
         XnvjGeskB8PP1//i4+mbknheZqwXWzyn2lf5fSwhaPQHKgMJwM1wPtzNDZuV5J4wYMcm
         RyYA==
X-Forwarded-Encrypted: i=1; AJvYcCWuL6L3CqxQvE57sHKWBw5N291d3DMYrvpRT3oeY2VcX7dJI9I+uE4ESTObfEj9mtFNeSZDMqjJCSYHsJ5ivP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWg1zl+Apz3mNZAGzE2LAd+YE70gRyUAlP1lFC/3KoXR9ETUyQ
	E+iBsrd3bGpE5zCf9mkfh/vQxsomxC/hVAaFDmOlNB6VznAMdtCtOT/nG0Tc1Zk=
X-Gm-Gg: ASbGncuRpDp26aEEa2AhuJDLOp9DA7/hI4WhJNvynhxa5U0j/yaccCF9o4fPsgroMxa
	UHgeoLJdxLKQyP757VH6wgnI8USMa4QG/Hz0K457cd2wtrpA3LI2oWiolbbBXZ1FN3rx80a+yVm
	niixL2Mz9iJPbrugz/sJN0GRQGkn+N8TleYM9p7b64GFRe18KIx6wVLqZ7W/f98SXZzuHxEmEQr
	SxJbBnemNzlFa/k/WMs69YFaY6YKbVUnuey/CilbjOoHL3hdil3nNQLGk2Vnm7EF+ffihY5La2v
	Dbsv29GqIOZDSoU22tXf45aAZxDr8RPs0jelltCCFz4OgTxL
X-Google-Smtp-Source: AGHT+IFURUTFYkzHYQIncz+BfKUAREfkEb0hfHFXyfz2gYFuInISIzikqK/QQxnSU1SXGYMuPoyaZA==
X-Received: by 2002:a17:90b:2f4e:b0:2ff:6167:e92d with SMTP id 98e67ed59e1d1-30864173b39mr5158528a91.32.1744853589813;
        Wed, 16 Apr 2025 18:33:09 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef11c7sm21349505ad.37.2025.04.16.18.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 18:33:09 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: [PATCH net-next v2 2/4] selftests: drv-net: Factor out ksft C helpers
Date: Thu, 17 Apr 2025 01:32:40 +0000
Message-ID: <20250417013301.39228-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417013301.39228-1-jdamato@fastly.com>
References: <20250417013301.39228-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor ksft C helpers to a header so they can be used by other C-based
tests.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 tools/testing/selftests/drivers/net/ksft.h    | 56 +++++++++++++++++++
 .../selftests/drivers/net/xdp_helper.c        | 49 +---------------
 2 files changed, 58 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/ksft.h

diff --git a/tools/testing/selftests/drivers/net/ksft.h b/tools/testing/selftests/drivers/net/ksft.h
new file mode 100644
index 000000000000..3fd084006a16
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/ksft.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(__KSFT_H__)
+#define __KSFT_H__
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+static void ksft_ready(void)
+{
+	const char msg[7] = "ready\n";
+	char *env_str;
+	int fd;
+
+	env_str = getenv("KSFT_READY_FD");
+	if (env_str) {
+		fd = atoi(env_str);
+		if (!fd) {
+			fprintf(stderr, "invalid KSFT_READY_FD = '%s'\n",
+				env_str);
+			return;
+		}
+	} else {
+		fd = STDOUT_FILENO;
+	}
+
+	write(fd, msg, sizeof(msg));
+	if (fd != STDOUT_FILENO)
+		close(fd);
+}
+
+static void ksft_wait(void)
+{
+	char *env_str;
+	char byte;
+	int fd;
+
+	env_str = getenv("KSFT_WAIT_FD");
+	if (env_str) {
+		fd = atoi(env_str);
+		if (!fd) {
+			fprintf(stderr, "invalid KSFT_WAIT_FD = '%s'\n",
+				env_str);
+			return;
+		}
+	} else {
+		/* Not running in KSFT env, wait for input from STDIN instead */
+		fd = STDIN_FILENO;
+	}
+
+	read(fd, &byte, sizeof(byte));
+	if (fd != STDIN_FILENO)
+		close(fd);
+}
+
+#endif
diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/drivers/net/xdp_helper.c
index aeed25914104..d5bb8ac33efa 100644
--- a/tools/testing/selftests/drivers/net/xdp_helper.c
+++ b/tools/testing/selftests/drivers/net/xdp_helper.c
@@ -11,56 +11,11 @@
 #include <net/if.h>
 #include <inttypes.h>
 
+#include "ksft.h"
+
 #define UMEM_SZ (1U << 16)
 #define NUM_DESC (UMEM_SZ / 2048)
 
-/* Move this to a common header when reused! */
-static void ksft_ready(void)
-{
-	const char msg[7] = "ready\n";
-	char *env_str;
-	int fd;
-
-	env_str = getenv("KSFT_READY_FD");
-	if (env_str) {
-		fd = atoi(env_str);
-		if (!fd) {
-			fprintf(stderr, "invalid KSFT_READY_FD = '%s'\n",
-				env_str);
-			return;
-		}
-	} else {
-		fd = STDOUT_FILENO;
-	}
-
-	write(fd, msg, sizeof(msg));
-	if (fd != STDOUT_FILENO)
-		close(fd);
-}
-
-static void ksft_wait(void)
-{
-	char *env_str;
-	char byte;
-	int fd;
-
-	env_str = getenv("KSFT_WAIT_FD");
-	if (env_str) {
-		fd = atoi(env_str);
-		if (!fd) {
-			fprintf(stderr, "invalid KSFT_WAIT_FD = '%s'\n",
-				env_str);
-			return;
-		}
-	} else {
-		/* Not running in KSFT env, wait for input from STDIN instead */
-		fd = STDIN_FILENO;
-	}
-
-	read(fd, &byte, sizeof(byte));
-	if (fd != STDIN_FILENO)
-		close(fd);
-}
 
 /* this is a simple helper program that creates an XDP socket and does the
  * minimum necessary to get bind() to succeed.
-- 
2.43.0


