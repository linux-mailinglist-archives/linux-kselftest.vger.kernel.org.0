Return-Path: <linux-kselftest+bounces-23590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5438E9F7E1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 16:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CF7188A596
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 15:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CE4226530;
	Thu, 19 Dec 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biysIChR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ABD22577E
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622198; cv=none; b=ZP3ndpLYRjMcDL++KU5sSAXlIXxYMutoQUBnmsLvKflQMNc1pMgNH3hVejWM0ZfThr27lvL39el6PkDdPLPKBNaekdRl8QjljTWQGY+h2ixGkVRwYoDkNPvMVIfITmmZ223qb2SzVJTIV+o8oDwhnxQRzysW2R+tQlohf2fFeec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622198; c=relaxed/simple;
	bh=b9n0Nfj91k3h2Q0NrLnOiA5u+xyBUwsV4tN9YTKRxUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FyYWpYvT4dx54luZjzEdOJ8rAgU7FjgmWWvYeGBtMMK8WowuUCGMhd8OsJ6LiyMpnn8nluqN4hwruV5zTeZfGBLj7j9jfrwIzemm0yvyjAsDjaRteeDZmrk1Fel5KrjeM+XFhgiciRBtqtC0l/rvBKxtxoxLUHhxnMKxn3q0qng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biysIChR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2167141dfa1so8707185ad.1;
        Thu, 19 Dec 2024 07:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734622196; x=1735226996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNHzGCV835rfMgYwKPqKqPeLuQwNVSkguSfQpszEKyw=;
        b=biysIChRMKOfJZea6/BVGaZ9ABa6pBI6s6XyFl0tMYhmn4V408wlbrTDO8DMsN8rD4
         CsMvLj+ZxvsqAhAp3dyrSI1uHNrrtqzFjx+5YmbGks4dn37YPX1xy8svk4CH4YePn3AD
         DyCvjjZ7XfWhUX4O425HH2ujJnEpzCCJKaQORfcJBBMdRv5ws8PX8XDbjFR2JrGA1rF+
         zneb9+NeB7ty70XuxlWvYgMaor/zO+3e5ut176w0doXBWSmKQfXW3eM3V2JywNNFarPe
         Xu5Q0qr32dkPpRk7cfLoUTVu8iZwupUssefaEgtolMR38/13iU0NKuoz5GHCEOBuc6Fo
         bheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734622196; x=1735226996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNHzGCV835rfMgYwKPqKqPeLuQwNVSkguSfQpszEKyw=;
        b=qdCe1kC0sS9+0tEmhrY7F5c1VyPLZwcBJFgnSd4GJJmBrqb0gCq7CTKNHJaPvMTcOP
         fPOQwSXP1vipuu1Ktj+hgG0/MQCqniFZE7cKU+nCKvPGyWKPlrBeSMFPWXxGtBnPzBKW
         vYBpAW7n8wUNZPgH+bFnAAZjJ8ZP+v4RQaFMppcIxBmCi+CsGwnpHKmwO3EBBSNhEBv3
         EP19Rzvaabx9nMelu2TMYInJY9PEZAdZ7LwNn3NYza3RnJPF7/hMhVxV518h6zhv76bH
         hQTd5HeBqxtXa1OILM6gv2HPd6WAENYXvWzJh50bjO5e8eRPgfbvfWgJYND3jEaWQol4
         VqFw==
X-Forwarded-Encrypted: i=1; AJvYcCVRdRoCmIGpvRNJDenUPtPbKQjtaMRX1Ygyv1BeVJRdWWR8YRaNvcfWFemFTn1IV+elO+qqspPzGPf8uQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUG4kbmgKAUqOJa0BVmE7/2F1d8MuW0gNaS2e8t8l4LJL96Z9m
	KnoAZSuFSqO8vQldV+w8pBKu6XyNZtBz8yQ2ZVpWHSeyVXsThZIU
X-Gm-Gg: ASbGncsYifgI3YAVCdWsS9uKKwIFFInBbjUE3zbW8FfPUjacIHbOcZTca0j5ZgiXY18
	urwh7TcvO6nOWUtXOHSOOb/cAahqjv7nN5GcncXUW9Ew3gqiv73yLyEQM2tjN6BAAh+csqkJmN8
	K9SAHJcNn46/vdT45YZGr83phDUufcNzal2V+urutL1RZVYcLrypaF9i7uNR6JUERYCT5oHDswO
	U0vCi5RqE0MpNCiBDTg3+4Tnq6wAmuZMV1ahz7Tg0DaSnOm1Ohd3ny8CaupwTubmXTBkQ==
X-Google-Smtp-Source: AGHT+IEpwVVBuI9BCKUZdUTRjXPTws6M8mzd5hfzE01WjEWKFL3BWlNEjggiRaF4ocVF2+w6bn92tQ==
X-Received: by 2002:a17:902:d50c:b0:215:742e:5cff with SMTP id d9443c01a7336-219da6e74c9mr47734865ad.16.1734622195823;
        Thu, 19 Dec 2024 07:29:55 -0800 (PST)
Received: from 2abb50c-lcedt.nvidia.com ([203.200.25.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdeecsm13321755ad.123.2024.12.19.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 07:29:55 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	inux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v6 1/2] selftests: tmpfs: Add Test-skip if not run as root
Date: Thu, 19 Dec 2024 20:59:28 +0530
Message-Id: <20241219152929.4005003-2-cvam0000@gmail.com>
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


