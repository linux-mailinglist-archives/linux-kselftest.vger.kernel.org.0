Return-Path: <linux-kselftest+bounces-39143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DB2B28B37
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 08:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252E33BC573
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 06:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3406521CC68;
	Sat, 16 Aug 2025 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4G8DuLn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863171F460B;
	Sat, 16 Aug 2025 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755327324; cv=none; b=LK1a4F2yKYCKoLhBSXXHtXPfB3cr4DMg+R3qKL0Gv+3CNqo0ibk/Mu1heL2GXqD2sWYG3VElKsrwDNnmpf3N0PZor74aM6eqDe67Le4Fjbm/qRtcirae9iyBGnwgry+hF7e8uYTwM5Ol/nDITpA89Uy68yAHV7KZhvzY5tAwFo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755327324; c=relaxed/simple;
	bh=kKwgkc0MRKj5QVDGF/mEkvIhrzP3GNMCanq7BG9BeW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LgpUxf0pPvuxfWkt9SBIN+TRcfIYfk/kA37KR2JiS3+8qO4XQ8oe0zY3EuSWxVUiRSSjESTo+qAuDpSiZMROdpoTjBk1pslzCpR1K3CWmYvk53kRjQp1Dh9s0Wj99vog4xNq7P2EW3h3FO+MKCPAdxGLR3Flw/rbIMndQEC/GIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4G8DuLn; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32326e20aeeso493124a91.2;
        Fri, 15 Aug 2025 23:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755327322; x=1755932122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pQENfQjnK0kpW7+ecWx4mPicYJuAqMw36HO0ldP2nh8=;
        b=A4G8DuLnzMwTpFwdv40brKMBRSg7HltCKFBizbVzbaO2TpLzHrb0peeI0PqtiG8phi
         aWlOYNVO7LPwIlf6QQPJRBeJtXSEEM8SGbm5xzWobwsInB3NeusBDYiBb4LUgs7TkSeg
         o1BuSu64/c5PSp0pbIPy5gqww6pPWQcfQ9xTbuuA0heAj91eQU0TfIrWFmONxSpDf/uo
         b4+Kpkbi3XL156NK0rYVzzSyn1L56N8myc5Flecog18I3Obf+5+ePqgKC/J2eVQggcvS
         4ABF/RQF4uHsJ3u8oIZaqoW1UeTFAwrHQgr9QswwQD6TkMlpvddcxaArpEtedZI/NkH2
         Y/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755327322; x=1755932122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQENfQjnK0kpW7+ecWx4mPicYJuAqMw36HO0ldP2nh8=;
        b=wmowU+GH+l7Xf0o+88CTrpFyloH22SuMfQ6b2SFxy0PjCA0UNhbDN8py1MLoAkWlSU
         aCGG4jl3VvGn7ekOBRrpHraSaJMXhXdQ4y81prVr335OmugS1ZXX5PhyhTrJ46lPWIlC
         l3aXfeFJx7oOQyHw2sK+DyN78mF2QUHOb30viyNBL8zSmFeRwN5vdhUCXtfjd8dYT2T9
         s3eqnuSmM98Oi8UmOQBvdej+KnuGYDq9zftG7X0mpgCzEEkDSVQ074iz4mWkhRucWgx7
         UJl3U2ctrt9zs+6/+rmsFIM/VIhpNG3SDQYgjzw49GkIDICSXTOwRyQEEjpALWD82Lnn
         gusA==
X-Forwarded-Encrypted: i=1; AJvYcCUbPF+t1U8XsZCbp5+39qQ8OLrn2Zx+7m9gx2P0a7OS8MAYLUr00yZ+ybkMNSwKzYXqBMrNhZylEz9z9dTuffQ9@vger.kernel.org, AJvYcCVXZFfPIJpCjHSJvBnYjNELc207bDPnzpH6RfCvN0t+grYHN+VhcBdg0Qcn62tYJpfK3W0KdFn3/FVt0sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTxPciS/stRgqGr8iHCbgFna/n8T1opgyvhBteR+M6px0sTGXm
	Nkp1rGC2EKwjEtzxjEU2zTewmnr59oEQBq98s1Ne9XdYXrQOX9O/51gGu4v+IS7o
X-Gm-Gg: ASbGncvDWI3jnwUHMQmwBO8CACkVrGu73x8Z4k2eJLOhYgGXjpasoIWq7KIzMI0UJlH
	3rATBiNzuwhz/CvGjJN+3fpKeBzMtiBF4W7i+NsRtC19kgI321kvEjYqnPXdFuXSDEhcLWdsCBA
	Cob9YMTtOj9IM9hZQDJixWUK9bF4gdACW74dMeJzCYF8uMvg8yQDiPJt/TuyuP2k4bxHI242QJx
	/tF6gECHwI3zBYVQYZKx+yldtz5I/WPIMfxyEswHv7yKcdzMFSdG1uzce0ZAgWqLiBmbGdMJGL+
	v4voZ+2Re8JWob2a00ZAprb1yI6zkQb/RR5ygbuJYgNSd2EaNgQUkoxI7vMV/Ggwj8qX6TS8c8c
	n+AP4hlKus1NaRMmbIE4W6D2bkDdpkg==
X-Google-Smtp-Source: AGHT+IEi3On6DUaLL3HGRjuBdB8IwYTEvydR5f4BGORycAYvDCRl8am9GWB0dz2TJVzDRvHLvw74vQ==
X-Received: by 2002:a17:90b:1c8b:b0:321:c5eb:1da4 with SMTP id 98e67ed59e1d1-32341df94f7mr3768725a91.1.1755327321682;
        Fri, 15 Aug 2025 23:55:21 -0700 (PDT)
Received: from ranganath.. ([2406:7400:98:2b0c:4503:9234:5f04:b2f9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d5a8f7asm2965664a12.12.2025.08.15.23.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 23:55:21 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: shuah@kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ranganath V N <vnranganath.20@gmail.com>
Subject: [PATCH] selftests: firmware: removing errors and warnings from checkpatch.pl
Date: Sat, 16 Aug 2025 12:25:10 +0530
Message-ID: <20250816065511.10713-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removing the scripts/checkpatch.pl errors and warnings from the file.

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
 tools/testing/selftests/firmware/fw_namespace.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_namespace.c b/tools/testing/selftests/firmware/fw_namespace.c
index 04757dc7e546..5fcc3fed0036 100644
--- a/tools/testing/selftests/firmware/fw_namespace.c
+++ b/tools/testing/selftests/firmware/fw_namespace.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Test triggering of loading of firmware from different mount
  * namespaces. Expect firmware to be always loaded from the mount
- * namespace of PID 1. */
+ * namespace of PID 1
+ */
 #define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
@@ -17,7 +18,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 
-static char *fw_path = NULL;
+static char *fw_path;
 
 static void die(char *fmt, ...)
 {
@@ -86,9 +87,8 @@ static bool test_fw_in_ns(const char *fw_name, const char *sys_path, bool block_
 			die("waited for %d got %d\n",
 				child, pid);
 		}
-		if (!WIFEXITED(status)) {
+		if (!WIFEXITED(status))
 			die("child did not terminate cleanly\n");
-		}
 		if (block_fw_in_parent_ns)
 			umount("/lib/firmware");
 		return WEXITSTATUS(status) == EXIT_SUCCESS;
@@ -116,11 +116,13 @@ int main(int argc, char **argv)
 {
 	const char *fw_name = "test-firmware.bin";
 	char *sys_path;
+
 	if (argc != 2)
 		die("usage: %s sys_path\n", argv[0]);
 
 	/* Mount tmpfs to /lib/firmware so we don't have to assume
-	   that it is writable for us.*/
+	 * that it is writable for us.
+	 */
 	if (mount("test", "/lib/firmware", "tmpfs", 0, NULL) == -1)
 		die("mounting tmpfs to /lib/firmware failed\n");
 
-- 
2.43.0


