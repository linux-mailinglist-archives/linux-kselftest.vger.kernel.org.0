Return-Path: <linux-kselftest+bounces-23918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BD0A018B1
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 09:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9099161F2D
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 08:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760A514600C;
	Sun,  5 Jan 2025 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJMHvLGN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F64142E77;
	Sun,  5 Jan 2025 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736067191; cv=none; b=Vh+RgihQb/gSVkeGThmZIIWAwkq1PykMLR7MgaeG0uOoeRqcuraLAFksprdmK6bwGvxP5/0Xi8jP+fAVYD+sgAmg2H336O+EsPMg++Td3FK49yIe2FZR/i3SFj0Lms9m8iONBYPESu+ZWYwc16ORAnsTjpc+jm5HbXORUdyjvfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736067191; c=relaxed/simple;
	bh=s4V6gELYFq2H0+3BKECCYgr8QIKTR+BJHzdPQiY4Hak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GHevd3EgwrGVyr4vjubR5KZrld9Q12NMiHLd/62buDTS8dQ/kIo5YcAfGTsBDP6xnHZXtc1635x6ymqyqJISTZZCh9MSl06D6c0/FhEjxNjj0RZIaa4GYRt4K/9ofC3Ol9kg503j4Q/wHvBLuBXRPiUBwAlconI5c/lvai/NrL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJMHvLGN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ef748105deso14715167a91.1;
        Sun, 05 Jan 2025 00:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736067189; x=1736671989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9tA+KYAh7QOOV6Ci1AkT8SRBK9XGfE/c7SXJNqdqgk=;
        b=YJMHvLGNpZVBcZP/50b6fuUH07xIbuipYttTjRVgxktytKcf1SCwCrVm4i/vQhN6rs
         rSWgxwe01auco+Q4oXh1/2HeiHDeqjNp7YSOL/nVFH+GxZaRSDd3AONPDLEyGgn9oR/6
         Rs2mOrNPMYnr4KS//UTyFmmyylcc4fLSEmw75hFymrdG71yUD+oFmklarBh0HjIfRwGZ
         UiEOLMXWrNX/etsXe0x+GF6/5SwOfol6Izt9PGrxhd8inYdPJ1cB+B6Q4R2RV+eRSzjH
         waYEcp+53aMlndSDY2NUfXjj925qtG94zcWIrcYRlzPn4gKS5oGlT8rwlfy/KNuw6jcB
         XBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736067189; x=1736671989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9tA+KYAh7QOOV6Ci1AkT8SRBK9XGfE/c7SXJNqdqgk=;
        b=HXM/hY9jlZ1fCGjy3pK0LoUcgq7btgbq+qDqaZUy0NCxsMGr+a4cYHG7K4cT9UZhAh
         lF3pTRaPEXY3OaRgTVqWDO/G0G/vAc3Ec8DPg+0QdgXkelD7MpMUli2zmGBMpLkIiaFH
         A+4ybtzQkHNPMlGri2pBzsG9fU66gOS9qKJWuNcVYzDpe1Yjt5cSnpuDxXrE4LPqWCWN
         Jra6iwNSPoQ/MdSlgE/UtbfgnieuQcGiZX+9hM75Vc2t1pO7Y6ytwWI7kBBXIxysS/nL
         0eqIkNvIGJyKzPD56DHT5qyFDFh1d0a7gqwoWwmNjByL1RiJa9lBEkJfzi7+djPpZ/W7
         kkAw==
X-Forwarded-Encrypted: i=1; AJvYcCVNef2UH6wovL66SNhXwSq9s/XMEaI/tAYVjQ8cUPUu3mbIfIVjsLBdn6KH1UGUX/rlzCgvBfCtI4ppI3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCqerd1Nbqo90g40aSTRndPiMNzreWF/oXkihuuMQVBWifXvGY
	3Y/EGZnKICtIQwuM4eGubKkw+yg+zeygqpD2M+muCSzri6ktTZyTzdv+FQ==
X-Gm-Gg: ASbGncsrZWtHIHV7oy6oKNN6VhexdBUHt8UHxY5BEdMuOO6xGHU7EQYrFCD0aFz+8LZ
	TLlqObQIh/y+yEsOWBleKORu0d0NeFwGbvkUmWvh53trAkfq2KU0jj7RCjnVa7cQ+e0sTPWFOMh
	oi7Gb8cApbhExMN4Wauk7MrsQHXQZN3/nl0UoC0Rn9RosXX7nHO6mQ1XenBAvLePNLiUpltm+rz
	kb6pUN8ozWxZfRWO4nAiORWX06kqtezZBwJhGUFHORJ1I5rcT/p30zYk6VK2P3VnnCTHQ==
X-Google-Smtp-Source: AGHT+IEEgOgi8KxszekbcPE5UWEnDvB5svFstmq971I82+k/GMchGQS/PFfqNc9MTWlOHdaMO/oCPg==
X-Received: by 2002:a17:90a:da84:b0:2ee:863e:9fe8 with SMTP id 98e67ed59e1d1-2f452e38005mr77100906a91.18.1736067189164;
        Sun, 05 Jan 2025 00:53:09 -0800 (PST)
Received: from 2abb50c-lcedt.nvidia.com ([203.200.25.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962c53sm272600815ad.54.2025.01.05.00.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 00:53:08 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v8 2/2] selftests: tmpfs: Add kselftest support to tmpfs
Date: Sun,  5 Jan 2025 14:22:55 +0530
Message-Id: <20250105085255.124929-3-cvam0000@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250105085255.124929-1-cvam0000@gmail.com>
References: <20250105085255.124929-1-cvam0000@gmail.com>
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
 .../selftests/tmpfs/bug-link-o-tmpfile.c      | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
index 657b64857e82..02ecfe687dc2 100644
--- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
+++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
@@ -41,39 +41,38 @@ int main(void)
 
 	if (unshare(CLONE_NEWNS) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
-			fprintf(stderr, "error: unshare, errno %d\n", errno);
-			return 4;
+			ksft_exit_skip("unshare() error: unshare, errno %d\n", errno);
+		} else {
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
-
+	ksft_test_result_pass(" ");
+	ksft_exit_pass();
 	return 0;
 }
-- 
2.34.1


