Return-Path: <linux-kselftest+bounces-23591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC599F7E18
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68261160C56
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1174622652C;
	Thu, 19 Dec 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hzb6I0P+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822AD22577E
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622199; cv=none; b=j//FJnMWo8PLaMqtM9TxTu4SHNpIm+j5pl+6MMqIypnUF8tI8cwy9UK8njV/J6k/fMPVPrehY2VK14StB4JGZeQZijEBtrM3iIo+eX5Hd+UUYxwHucUa5neo5o1NGmsYUtaAq//uqQvz/Uwrr33UB8ReqdrOZzgnvXNWJ3aZiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622199; c=relaxed/simple;
	bh=PJqYGFNt05TORock+VYdl7VEbGCDqc5TL/6r/tpjgjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IrLSsIMPyqVhSK4U/IUKhEKAHhCwqS7MsqYMC8hD7v9g3g87eyNSfG4nkrcM8fk7r9YAAdzBVaOat32ZMsQ7tUmkkVmbV97AsF3Z5SzCiZTMuIsJipDVvOJLIE7SNSZys5eVVQjqUSZamkH36VnjqKOoDhaf0pOq/QpnwxRtqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hzb6I0P+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2165cb60719so9186075ad.0;
        Thu, 19 Dec 2024 07:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734622198; x=1735226998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eu3XtQQ6ce7q9PgOGjmPu3vT4CZ/SoRWSCa8YtiOWKs=;
        b=Hzb6I0P+u/+amqjy/pmPHGmmBSfkDRK8if/ypHK1Kq1K5ZhVANX/1gpKdO9m3av2V8
         96lBOg6vTU6Be4Rj72qqFzCxORe/Lpvp6wrxQjn9R7/ycPDkDtLhI+5ZGtI0jTfUc2tk
         CdSR2DkupcTGxzh2/+9yReg+AuC5YDZiSn+szuvBXRCkyUC2IH2XdBKmR2+FKPiIGtb9
         HQlAC3EKwDNXtPD1M9zPYnT7/5k3edh43G97S3D/GvsoAr7cQWt29AYTLxHhxm2+bVdX
         cF1DIE5gT0QZcbX2e1jLEBK0JLC1MqLXdSjbEoCV/hfjU5B+oO+vpAJr32xcYBtsZEY7
         YRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734622198; x=1735226998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eu3XtQQ6ce7q9PgOGjmPu3vT4CZ/SoRWSCa8YtiOWKs=;
        b=SaQvgRMyWPpOvNQPlibEmilyGhzwzxi6DyXdftBK0xzfQRrIQA8Cth9WLJvJBHILJq
         hOWBwcXvKHN36t/XGTOQFHAqIsEWXMRgdNXUikKdEXB1vFNre14Hi4Ddl5fgnSqzXcJ4
         S009P5dAofnZKqOGig6XJpSSn6mz3GFaoNhVlpMqzMJOiGcdS/ixt/v4qp+EWhGriCSn
         2bFf6c09LL79Wd09/6F2GuqWTnp8mBW5DtkFDGfAS7nK15CmeRYnnLqaIoPFfPwGpESb
         3/ChxX0ssyx3wRYnD6vzyoGdEUj5/IuKnLL6ucU7r6jrf3z3pRqeu3MxBiOG7xMnSncP
         GEiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNda+gIISVeHU60DOTBT2rvj7JDI6zZndzC5d2ud7QRO/iGRyvuLxsztksAYWiMflk+h6lT998ivF+UQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YznyJCbTAb6nKGMGOT+wxy2fG5DIrlBNYZtO8kHYUcVW7Sj4VDW
	0n8RBxs0GUUdHr0wk1/iof7xzlvi+otDfYzGbsRWO799Gxp2yqw5Tdl/Yg==
X-Gm-Gg: ASbGncvjkszCsxwXOqQbuEnepk4yfM5QguhZSep0V28VMDufSLo+2GFlAG9n6xcsuXV
	Xg2nCTC0NRkUlTpsKar2vCjhMOS8oOG6EAgTuzmSi8Mfxg9b2RYEtViID/HWzjAQfNM5bvbfbo9
	VLF14GvBxM+Fvej502pGvo1iEYY5rrJO7OMsXQmtKqK58TS8Lui6rT0KFv5xWGWHCYRle7nkIXI
	eBeK4W+53njS5L2JR30dL7CDnIuFdqYTRsunU11m6LHll+4kGgBenrVLfN0NTrRO9WV/A==
X-Google-Smtp-Source: AGHT+IEOoPiBLnp30O0LqR6AQZauFkJuQMZSl49d0NMqYgunTbZxdjm0pqm/A2MnNurZOdDViC+9xw==
X-Received: by 2002:a17:902:d508:b0:212:6187:6a76 with SMTP id d9443c01a7336-219d9626195mr51309925ad.14.1734622197733;
        Thu, 19 Dec 2024 07:29:57 -0800 (PST)
Received: from 2abb50c-lcedt.nvidia.com ([203.200.25.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdeecsm13321755ad.123.2024.12.19.07.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 07:29:57 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	inux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v6 2/2] selftests: tmpfs: Add kselftest support to tmpfs
Date: Thu, 19 Dec 2024 20:59:29 +0530
Message-Id: <20241219152929.4005003-3-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219152929.4005003-1-cvam0000@gmail.com>
References: <20241219152929.4005003-1-cvam0000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace direct error handling with 'ksft_test_result_*'
macros for better reporting.

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
ok 2 # SKIP This test needs root to run!
Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

- With root
TAP version 13
1..1
ok 1 Test : Success
Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---
 .../selftests/tmpfs/bug-link-o-tmpfile.c      | 29 ++++++++++---------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
index 657b64857e82..91b30a0ca365 100644
--- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
+++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
@@ -41,39 +41,40 @@ int main(void)
 
 	if (unshare(CLONE_NEWNS) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
-			fprintf(stderr, "error: unshare, errno %d\n", errno);
-			return 4;
+			ksft_test_result_skip("unshare() error: unshare, errno %d\n", errno);
+		}
+		else {
+			ksft_exit_fail_msg("unshare() error: unshare, errno %d\n", errno);
 		}
-		fprintf(stderr, "error: unshare, errno %d\n", errno);
-		return 1;
 	}
+
 	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
-		fprintf(stderr, "error: mount '/', errno %d\n", errno);
-		return 1;
+		ksft_exit_fail_msg("mount() error: Root filesystem private mount: Fail %d\n", errno);
 	}
 
 	/* Our heroes: 1 root inode, 1 O_TMPFILE inode, 1 permanent inode. */
 	if (mount(NULL, "/tmp", "tmpfs", 0, "nr_inodes=3") == -1) {
-		fprintf(stderr, "error: mount tmpfs, errno %d\n", errno);
-		return 1;
+		ksft_exit_fail_msg("mount() error: Mounting tmpfs on /tmp: Fail %d\n", errno);
 	}
 
 	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
 	if (fd == -1) {
-		fprintf(stderr, "error: open 1, errno %d\n", errno);
-		return 1;
+		ksft_exit_fail_msg("openat() error: Open first temporary file: Fail %d\n", errno);
 	}
+
 	if (linkat(fd, "", AT_FDCWD, "/tmp/1", AT_EMPTY_PATH) == -1) {
-		fprintf(stderr, "error: linkat, errno %d\n", errno);
-		return 1;
+		ksft_exit_fail_msg("linkat() error: Linking the temporary file: Fail %d\n", errno);
+		/* Ensure fd is closed on failure */
+		close(fd);
 	}
 	close(fd);
 
 	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_TMPFILE, 0600);
 	if (fd == -1) {
-		fprintf(stderr, "error: open 2, errno %d\n", errno);
-		return 1;
+		ksft_exit_fail_msg("openat() error: Opening the second temporary file: Fail %d\n", errno);
 	}
 
+	ksft_test_result_pass("Test : Success\n");
+	ksft_exit_pass();
 	return 0;
 }
-- 
2.34.1


