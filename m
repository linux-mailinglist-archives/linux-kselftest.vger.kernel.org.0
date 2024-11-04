Return-Path: <linux-kselftest+bounces-21361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF8C9BAD96
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 09:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967E71F223BD
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 08:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8909D198E81;
	Mon,  4 Nov 2024 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJ0D8lLF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D3417C234;
	Mon,  4 Nov 2024 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707439; cv=none; b=ioEImQf7qHAObWEnHDdbE5SJq6ZCRF1x5TEzZ73wA6pL0gYly+G/uEsZ60pnY8nedrdrodbFjc23qHI962LLsFSgThK+cme/RtWTNaERPLGF1KHLrROk962TZq3cK+aqFvKvzYnOjPjJdLHb0uPqv1+MgvMiYGRkeoWjBAthOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707439; c=relaxed/simple;
	bh=vD21bi/xfbh8YrBZS4dOxLbp4afjXJg/K6cly/jSHoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ahKhaPokgGyIy6UCZus3do4ys/E4SuWasj3S1DvK2zQpoqGQDQ8Qg0FHVtgCGweDVQ5OYs49V/iHZrfWjQBcXwqoJQBLQ7B1ji7O/Ep6w8Xtn8zf/REgWerEDjBKtsInhpfBbkNwtSYEtK73mhiZY6XV9y1hTTAuEi3Z+/7Vb6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJ0D8lLF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so3244906b3a.1;
        Mon, 04 Nov 2024 00:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730707437; x=1731312237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/vushZJLcOuGjhMYpOcLq2M2TFM8m4uAMKdzTip87p4=;
        b=OJ0D8lLFRHSVdvmXi8K68v4kI+dLw5Yx8eRpEN38XNFhlCvM1sAWmngXD09WR+AZGK
         RMaie12fhtbar0rxL/mWKz0GodJyGSf5j8axOsWg7EgQAOOLQcsgerMBQWmgBeBvSeYZ
         Eo6jcv6Wpi4BjskBk/uRml04S1aVP+TTGbzx38HK1Z/7PWmGb68CtXIrN+VD2z2woTmF
         BSHpsIHtAmvvU6hvc+nK46XGEXrhaKcHfLz4nMA7+ZDsWUE7qrm8kQziq4bdfofldDPs
         KS7RGkEA8P+h/tNu+/p6d11knQe7xIXkVxowG6cdfW/LaPHoB1r0hIkRuM5Lnk53MvM0
         G3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730707437; x=1731312237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vushZJLcOuGjhMYpOcLq2M2TFM8m4uAMKdzTip87p4=;
        b=jybQTdj7/9S1IkZ4l6kQi/kEnTirmHIdHJwGGuZdFdFdtTwbxRCtK2ry9JkXtvI/ol
         mWlY3X3X0LOTWGvEU/k0POY2uFMZVAsdY0UbpmKfmicj6Q2JSfzPWhMMckXiZOdYfqu1
         g8W7dgiBJH6JcS6xk1maQMbd/pvshTDlLz0q5wXlQfo/XDhvQSGqab/o42zNt7nXcdBT
         cAbFnDGHNOQy5zwlIfp8vqySoxkF9lWRoH9jfnXU+QZDTVFCAAUfijXUVfnyVQu5POYV
         nNFaYZzDQmPhGbzG7bJ+vzhpXS3C1HIjNPveICLt2DIzL2ZNoaS1Y1YakGXMPKjGBSh3
         iRKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIqRaPhisoYxgDcl6XpMcPwGE1Jlo3u7QF5Tvt1vDXWRP96A0mE7z+571TNyFUyHFGsxmRW/A1hvS8DPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz74yZjXlEqoAO2vK2WcxXbSBSdoRCxaifyVxBMHZ8R6b3H6ZYp
	1NRrAkdUNvRZkH49hVPsDTanqs1HGTYmImSIYmaWVROKqkYd4yMm
X-Google-Smtp-Source: AGHT+IEHeH8bDXvZVqQDbrwAgIcwCBgNYGJqeFJndUwb04C4KX3GwftHgud+P/XiE9UE/9XC3vw73g==
X-Received: by 2002:a05:6a00:8c9:b0:71e:410:4764 with SMTP id d2e1a72fcca58-720c98a3d19mr18936309b3a.8.1730707437156;
        Mon, 04 Nov 2024 00:03:57 -0800 (PST)
Received: from localhost.localdomain ([27.7.141.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c498esm7037041b3a.97.2024.11.04.00.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 00:03:56 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v4 1/2] selftests:tmpfs: Add Skip test if not run as root
Date: Mon,  4 Nov 2024 13:33:50 +0530
Message-ID: <20241104080350.163100-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Add skip test if  not run as root, with an
  appropriate Warning.

- Add 'ksft_print_header()' and 'ksft_set_plan()'
 to structure test outputs more effectively.

Test logs :

Before change:

- Without root
 error: unshare, errno 1

- With root
 No, output

After change:

- Without root
TAP version 13
1..1

- With root
TAP version 13
1..1

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---

Notes:

		Changes in v4 1/2: 
				- Start a patchset
				- Split patch into smaller pathes to make it easy to review.
		
		link to v3: https://lore.kernel.org/all/20241028185756.111832-1-cvam0000@gmail.com/

		Changes in v3:
				- Remove extra ksft_set_plan()
				- Remove function for unshare()
				- Fix the comment style

		link to v2: https://lore.kernel.org/all/20241026191621.2860376-1-cvam0000@gmail.com/

		Changes in v2:
				- Make the commit message more clear.

		link to v1: https://lore.kernel.org/all/20241024200228.1075840-1-cvam0000@gmail.com/T/#u



 tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
index b5c3ddb90942..cdab1e8c0392 100644
--- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
+++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
@@ -23,10 +23,23 @@
 #include <sys/mount.h>
 #include <unistd.h>
 
+#include "../kselftest.h"
+
 int main(void)
 {
 	int fd;
 
+	/* Setting up kselftest framework */
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	/* Check if test is run as root */
+	if (geteuid()) {
+		ksft_print_msg("Skip : Need to run as root");
+		exit(KSFT_SKIP);
+
+	}
+
 	if (unshare(CLONE_NEWNS) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
 			fprintf(stderr, "error: unshare, errno %d\n", errno);
-- 
2.45.2


