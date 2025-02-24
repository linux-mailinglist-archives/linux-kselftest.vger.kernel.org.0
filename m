Return-Path: <linux-kselftest+bounces-27317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DFEA413AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 03:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A0D1891470
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 02:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ADF43AA4;
	Mon, 24 Feb 2025 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLQyKp7M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4793B2F4A;
	Mon, 24 Feb 2025 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740365434; cv=none; b=tT4WYHGQ1+rOpBnBzWk1FJ6qXM72r2rCCK/9hLSzlifOl4/JJxLpE9Itji5qC0zYU6UfXOyil2GEUIs7jIwnZzfCJEuKaFS5DZNByszHXBDLA+UBUhVHEmLUbBwgUBJTr914MzFbEsogfbSKjWM9Mp607bVKLat/7pdHTkEYKYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740365434; c=relaxed/simple;
	bh=z1DWA1Epp5W40h27XnYDxMfEShlTw/6m1B8Q5cJzGrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GkRS7HFWIkf3oWftF6nMouGnZCQITz01tjHSyPkfxwdtMiOLe+uiX5+f36v7PHGXBbyULT34I3GI5Lt6iYyTo5BLQeqKh/0qtbBdZNYB6w4KWSedaC3o2S9VPdcuKFSOeb+yT/m5jQzaEiT/c+5cwzVd/z3/SgWYkGeZkegYkCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLQyKp7M; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fcf3a69c3cso3105792a91.1;
        Sun, 23 Feb 2025 18:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740365432; x=1740970232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=otH5nZvB5TrQ708wLQhRsttQBeJzQP2CzcoNi99bQis=;
        b=bLQyKp7Mmisq+P36maBcvqnE8RY5Ktms+hZTzbP2+TxI2LvqpdwzF/xDQzQ7j7sNOQ
         M5NjEkgu493Qzh1RJkNM/EUUTwxVHLOABxHlPzdCPzRraUlncFSIJCOrlZ+Qqcar7nQL
         IMIA8Y0IIBimHRI0Yg527bKYiLAoAyhBOjfJ/Il3aFrDJeIeDSKxvyMd0C7+oN0NlzmB
         /w/RDle+v9bLNSN/ji2w2ee5rsBkThEz//U8uzE1F+F6GcuXxyvGX2bWpcAOKUEWgkXo
         NVsccz6deDnA8M9AQdCsFqlZkY8u1kQ+RjK9LZTaWc3lzJCHTQY+GCCG37Um6eNFS357
         FFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740365432; x=1740970232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=otH5nZvB5TrQ708wLQhRsttQBeJzQP2CzcoNi99bQis=;
        b=LEAZeH9toQonQ0+rDeHNKezKeWQEUNvjWZSx5fJGc1WjzR2e9CY2vpeU2GLsAp38ut
         xhOQpGVlEjaM+03g53sGgG089C6tOg81n6gIiNCDCxhwRgVseigv+rJzjSs3YDEtijvB
         /q+m0EucjyKZeOfW+tlSBMsqZwF3w4jIgVFEeS9RnFm2IkZ3cFYruYgA8l94ufJhwZQ/
         kKOTbox7qw/pIEca5nS+5ZFSv05TyV7bz/5RytLBXCsV/dY/93Fzv0MRdfyT15s/t43e
         J2SlraO21hnzU7wLFAcyX6vz50O6BD0P+ZV7Ik85AxvuflFWbiAvHfDoXRkVTW9x0YUI
         3e3A==
X-Forwarded-Encrypted: i=1; AJvYcCUwynsH/yvgUKwD5SXITar2VD2o2TmgtYw9uuoS3bFDLAWpTRP8BsdqTrp5cZ0wSqVO0FmdBBrWKi+r1mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YytvhNe011aQ4mArA9YjEVaCYbx5KPu3hd3NERQcQX+1T11Ruws
	SycLipUffahhQeUvaaHz8PcGo/Cl8PR4mfxQGN6V0fFZuJGiGl6H
X-Gm-Gg: ASbGncuN/6fNuS3DbkURDFSw3TTDDID1y1OEpeA+UCj5ascyXo33V+E7d468C4PVb7s
	phhsyYfymgZOmWQAbBGTFCDHzvio75g0YttdMysZIQbtOCnv15DLpm2+XdDjSuQsiQOr3WRPZUo
	FkGhCVtEsUqgmYv7Z7VkckjI6EieEJ6ZgmWWM8p8dkha0yPNrZGa8wd1eWfObNcJEvsQ1NVffDi
	gEy4DBYKGSnBW0Kq7hqV/HEO2g1xjjcYFns+HnsrZd6hjho+rbjVg5B6+c6GKx5rybcMlKQEqNG
	yToCRCHJHQv5LEkk9xtJh8FIp2/oLfJ9FVruCp2FKqNl5DlfI8c=
X-Google-Smtp-Source: AGHT+IH+0iHxG0Zp6sK72W9vgyWjLMgjQmHDx5OZ9tSidYY0Gl8jy8JhzfPYC1CZ7W/g1/OOgJwKKg==
X-Received: by 2002:a17:90b:2d4e:b0:2f2:a664:df19 with SMTP id 98e67ed59e1d1-2fce769a9ccmr21415382a91.7.1740365432446;
        Sun, 23 Feb 2025 18:50:32 -0800 (PST)
Received: from ritvikos.localdomain ([2405:201:5501:4115:f92a:daab:d63c:8241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55916c7sm170467625ad.243.2025.02.23.18.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 18:50:31 -0800 (PST)
Received: by ritvikos.localdomain (Postfix, from userid 1000)
	id D073BEE99E9; Mon, 24 Feb 2025 08:20:28 +0530 (IST)
From: Ritvik Gupta <ritvikfoss@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org
Subject: [PATCH] selftests/mount: Use 'const' for filename parameters
Date: Mon, 24 Feb 2025 08:20:28 +0530
Message-ID: <20250224025028.3407-1-ritvikfoss@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The filename parameter in write_file(), maybe_write_file(),
and vmaybe_write_file() is unmodified / read-only.
So, used 'const' to improve type safety.

Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>
---
 tools/testing/selftests/mount/unprivileged-remount-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
index d2917054fe3a..e80ac76261e7 100644
--- a/tools/testing/selftests/mount/unprivileged-remount-test.c
+++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
@@ -54,7 +54,7 @@ static void die(char *fmt, ...)
 	exit(EXIT_FAILURE);
 }
 
-static void vmaybe_write_file(bool enoent_ok, char *filename, char *fmt, va_list ap)
+static void vmaybe_write_file(bool enoent_ok, const char *filename, char *fmt, va_list ap)
 {
 	char buf[4096];
 	int fd;
@@ -92,7 +92,7 @@ static void vmaybe_write_file(bool enoent_ok, char *filename, char *fmt, va_list
 	}
 }
 
-static void maybe_write_file(char *filename, char *fmt, ...)
+static void maybe_write_file(const char *filename, char *fmt, ...)
 {
 	va_list ap;
 
@@ -102,7 +102,7 @@ static void maybe_write_file(char *filename, char *fmt, ...)
 
 }
 
-static void write_file(char *filename, char *fmt, ...)
+static void write_file(const char *filename, char *fmt, ...)
 {
 	va_list ap;
 
-- 
2.48.1


