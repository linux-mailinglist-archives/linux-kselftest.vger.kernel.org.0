Return-Path: <linux-kselftest+bounces-21871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEFD9C5A6B
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 15:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020EA283688
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 14:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C536D1FF7A8;
	Tue, 12 Nov 2024 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEYX0a5H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A291FF616;
	Tue, 12 Nov 2024 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421871; cv=none; b=Glg7FuIo0up9wtj8nIpBWwsL4Lpl38x8Z6k/hd4GMfAiVxRI3U/cmDcvOkqTLQGX8b8clSTKJlZON8PRCVUDJJSuAZKWe1+hA2QqJNT2oc+DYgvUgLhY7LjjiHOGrq2ZY7N1CaAJZ9xlmO0cwOZDxYHctmUHFbyBIMKwfJbfxwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421871; c=relaxed/simple;
	bh=QuKHND7tir7vYIf3DuvFRxX9/peKyrYsQarMh74v+Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFqQZUhKv2Rtd4vRY3DjHOjUef/18BK9l+i76t4meKszCJm9F7+gQ80syKKHRlJTgD6dfRUJ00A9TyookybmePtitUK/xeJvV4e9hYrFpQHE0TOmM75uph6FToT7pict6i2Lz+xKDf9qh+iO/J2KeXx2/CKgBEB/ElhZwDY//30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEYX0a5H; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c7edf2872so53123685ad.1;
        Tue, 12 Nov 2024 06:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731421869; x=1732026669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrdG7au1cI4RDKEO1Vl6bQ93AO42POWQRQFMnAoaIHw=;
        b=BEYX0a5HkVCQ2R4UnuC56tTf/5h9L5CwS5/C86HIIiBCKm/QuwZrUHUY0mcMkGnOob
         Qiu7nzSFh2baFn3k8EeHayDUk/qW1nRGOt2qAXNZkJhFV9lRT2logGapRZfxA93evR6x
         B8t67ITvnX7Z1rg2VniUx71gQnlWmbzVyL1DqzsU5bHGaXUV8jSp1mtBIkB7JVrVG7a4
         dM9D2lEhARtJgbfIMpqiEn2GsyQ4icftwMGgrKUqeVnZYOa0smKDRyRnz697j+V73P9e
         yoxaW/tSADEIQDvMp1xdt1o1Hztb8YfPZrWj8TaxyGDCUTtR6V2kOlZGqOy4rTEJ21E+
         DZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731421869; x=1732026669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrdG7au1cI4RDKEO1Vl6bQ93AO42POWQRQFMnAoaIHw=;
        b=U1M89N6kP0aoHkeT+CJPuQRE61so1w+Wbn3M7rnJWP60EoxTdEX3vpb1NQYJPgaSSZ
         0zfsJM/SG4Y/WoU+xZLaDBFJ71pl2IjsVhAf5k+Jg3LMv4UyrAn3+Zz3ZQRbd7oWggPK
         W8RXBn5U3CjaW2liNbzjvjbXA2k4sxGYrHflA4PeWPdswoRHwD8sx4TY9zQg9oZP7IaT
         4GBayKObZp+AYrdtjQxokFKnoSLi/ORxUTv7NWw0XqZmYi+ApqDPd2wYDUiEBEyM1inh
         7JnhPuaYy0uZ2lz3VlcqQAz92lWRGTjOmARFjNNKJ4u8j0YLjYnh8ED7JoiqhO8O1LlU
         3IvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXS2i7EnsxK8WrD+BBANq11ZcGDPhqOcLl4wkoOYMprVpVnk09GTfCOP82cJZY8vIuYufxlYDQpME8YTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEKS3FJiXNY/L7u0tpxpwYAkCqKe/unWtDUDE23fkCnAlfQhUY
	3d0+On+bTiNRadmTz0cLyj1xCGUYj64mf+v+VcDHfFvO/84H1YZ4
X-Google-Smtp-Source: AGHT+IGarGWGe6XGO8mUhTSHrPuxdjqkFBenMlYRc1CVcNVhtAJHsCY2sZAsldNisO67jqgu0Vpzww==
X-Received: by 2002:a17:902:f691:b0:211:3295:ec7b with SMTP id d9443c01a7336-2118208a76cmr260030925ad.0.1731421869436;
        Tue, 12 Nov 2024 06:31:09 -0800 (PST)
Received: from localhost.localdomain ([27.7.112.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dde2e1sm93396515ad.76.2024.11.12.06.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 06:31:09 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v5 2/2] selftests: tmpfs: Add kselftest support to tmpfs
Date: Tue, 12 Nov 2024 20:00:56 +0530
Message-ID: <20241112143056.565122-3-cvam0000@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112143056.565122-1-cvam0000@gmail.com>
References: <20241112143056.565122-1-cvam0000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace direct error handling with 'ksft_test_result_*',
'ksft_exit_fail_msg' macros for better reporting.

Test logs:

Before change:
- Without root
 error: unshare, errno 1

- With root
 No, output

After change:
- Without root
TAP version 13
1..1
Bail out! Error : Need to run as root# Planned tests != run tests (1 != 0)
Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0

- With root
TAP version 13
1..1
ok 1 Test : Success
Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---
 .../selftests/tmpfs/bug-link-o-tmpfile.c      | 49 ++++++++++---------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
index f0b36e7a152e..c3a8c9c50c8a 100644
--- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
+++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
@@ -40,39 +40,42 @@ int main(void)
 
 	if (unshare(CLONE_NEWNS) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
-			fprintf(stderr, "error: unshare, errno %d\n", errno);
-			return 4;
+			ksft_test_result_skip("unshare() error: unshare, errno %d\n", errno);	
 		}
-		fprintf(stderr, "error: unshare, errno %d\n", errno);
-		return 1;
-	}
-	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
-		fprintf(stderr, "error: mount '/', errno %d\n", errno);
-		return 1;
-	}
+		else{
+			ksft_exit_fail_msg("unshare() error: unshare, errno %d\n", errno);
+		}
+	} 
+	
+	if (mount(NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) == -1) {
+		ksft_exit_fail_msg("mount() error: Root filesystem private mount: Fail %d\n", errno);
+	} 
+
 
 	/* Our heroes: 1 root inode, 1 O_TMPFILE inode, 1 permanent inode. */
 	if (mount(NULL, "/tmp", "tmpfs", 0, "nr_inodes=3") == -1) {
-		fprintf(stderr, "error: mount tmpfs, errno %d\n", errno);
-		return 1;
-	}
+		ksft_exit_fail_msg("mount() error: Mounting tmpfs on /tmp: Fail %d\n", errno);
+	} 
 
-	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
+	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
 	if (fd == -1) {
-		fprintf(stderr, "error: open 1, errno %d\n", errno);
-		return 1;
-	}
+		ksft_exit_fail_msg("openat() error: Open first temporary file: Fail %d\n", errno);
+	} 
+
 	if (linkat(fd, "", AT_FDCWD, "/tmp/1", AT_EMPTY_PATH) == -1) {
-		fprintf(stderr, "error: linkat, errno %d\n", errno);
-		return 1;
-	}
+		ksft_exit_fail_msg("linkat() error: Linking the temporary file: Fail %d\n", errno);
+		/* Ensure fd is closed on failure */
+		close(fd); 
+	} 
 	close(fd);
 
-	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
+
+	fd = openat(AT_FDCWD, "/tmp", O_WRONLY | O_TMPFILE, 0600);
 	if (fd == -1) {
-		fprintf(stderr, "error: open 2, errno %d\n", errno);
-		return 1;
-	}
+		ksft_exit_fail_msg("openat() error: Opening the second temporary file: Fail %d\n", errno);
+	} 
 
+    ksft_test_result_pass("Test : Success\n");
+	ksft_exit_pass();
 	return 0;
 }
-- 
2.45.2


