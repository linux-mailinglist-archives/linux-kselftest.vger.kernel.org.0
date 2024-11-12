Return-Path: <linux-kselftest+bounces-21870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 765239C5A66
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 15:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5B21F21D4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189DF1FF604;
	Tue, 12 Nov 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrjT6ebZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842081FEFA1;
	Tue, 12 Nov 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421869; cv=none; b=G0LrLgFti9/7RAjaqzVGnDGrYAFxJmDBbsNyYpCV5IpjNtdBBGkVMcCnzgT4SYYA1AgXJj+y6OTsF6ntqsxrzwCqrp14NTbWq7+F/c5PIDoLsOF42Eks2O759lX3v9hd9RAo/yrdZaraGQi5HHLw4Zc6G8iojSUiNTky1t3EGOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421869; c=relaxed/simple;
	bh=Jz7Gc9xqlX6vkm4IfWXYDAWPL87bhR5nBYoOGF+0Qyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/j5p8zGIbI2zyFxib1PyOfHr6iSCXlM4I+rvKeuWV60ccQSxLuSPF0yg3s+1kqcc6jQUBlH6ABa10wSVK0sr+7Z7U3zMVnJZRtpZdnT41J/q3NEIJ5rmU/GGX1ygaC/LSm5xXAOUDBomySM2awOwg6KwXxARwUKxDNic137XeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrjT6ebZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20e576dbc42so60897065ad.0;
        Tue, 12 Nov 2024 06:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731421867; x=1732026667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSmUWnIditomQFa9OuSXm7+7nlcya8Klzu1aHSbJnMA=;
        b=NrjT6ebZg3I/pPQgFu6669VYXKa0xgmFSiPBoX5XApg6/kFUUT/qrQAgfKkabJ1rRD
         pfeVTvabfcJqJNw3Dam6n8OxWC9ZImhIFe5EdAZ0YPt60XZeEF7o+TtHzApwBQ9gJKmd
         kwxTPzzGJVsZZro4c1Rh/TBhVJTRy7DPL4gqw2qmFkVxBnnPeGta6oAB6FHYp7yTfXN/
         ++w1i5hhVsyWzhbDq/95hz8KVIHF6mditktxfRNxzJ85Em5/83nPqmEtRu7BvzZpcmJm
         BlwiNnqoPdOixrfukzJc7A7QXRH6ewn2/ujku/CM52ev5WtJJro84ZM3mGV/MCpL2ckz
         U6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731421867; x=1732026667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSmUWnIditomQFa9OuSXm7+7nlcya8Klzu1aHSbJnMA=;
        b=wJ9xALPh1Waszt6PZCCG3YUigJcm/gcS0nla3pMtjjSNpZ+C63OiHIk0+DHbbeSqCe
         i9cOICMGmbLQxkRlEkCXFof53rTudnWBHuEZH7tqYSYvIUjtB21egGEBtsANeejRIQVG
         7DPjo6hQayJKi8b1BpfZQhtvKhVxB9lVoeKYkGofva8XNMdmSJdOPRr/i6OBUf6IRKZ3
         02DG3HLtzkQYSTf0+Lky9lFoMDifpg0LG9mCNzer3PFr7ioxATzlUV3jr04ha6RLyoSO
         L9Fs5P/XLiT4DEhjZ40vlfr3+vbYgYnTO7EIbcmSal5JI6oaQcuYKzipkGMzifOdnVuI
         nXvg==
X-Forwarded-Encrypted: i=1; AJvYcCXmy4OXrVM/wr962JmcYC+N+zSmLkbypqOkv7OfspFshoTTd0BZLILXp0NyJgD3jwvxNvvIq+C85rEEUq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUtpSdvuF6tDjVtn7S3xIP1NS/fj8zMfIppqedh1XTMorWlAQ5
	jEXOD4iY8/1ncCELMgHa/rUWKhCLWgqW7JPswgKVul9QnasV8bsuPVk+rdKe
X-Google-Smtp-Source: AGHT+IG6B8nSBlrwCpBYn7c4e5mS/bnM4YIqM5VaNNk1Qn2rHtD6Kyh0uPj7vkaDFLnaESHj0AkDrQ==
X-Received: by 2002:a17:902:c40a:b0:20b:a6f5:2768 with SMTP id d9443c01a7336-211834dfb85mr244484995ad.10.1731421866741;
        Tue, 12 Nov 2024 06:31:06 -0800 (PST)
Received: from localhost.localdomain ([27.7.112.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dde2e1sm93396515ad.76.2024.11.12.06.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 06:31:06 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v5 1/2] selftests: tmpfs: Add Test-fail if not run as root
Date: Tue, 12 Nov 2024 20:00:55 +0530
Message-ID: <20241112143056.565122-2-cvam0000@gmail.com>
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

Add 'ksft_exit_fail_msg()', if  not run as root, with an appropriate
Warning.

Add 'ksft_print_header()' and 'ksft_set_plan()' to structure test
outputs more effectively.

Test logs:

Before Change:
- Without root
 error: unshare, errno 1

- With root
 No, output

After Change:
- Without root
TAP version 13
1..1
Bail out! Error : Need to run as root# Planned tests != run tests (1 != 0)

- With root
TAP version 13
1..1

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---
 tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
index b5c3ddb90942..f0b36e7a152e 100644
--- a/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
+++ b/tools/testing/selftests/tmpfs/bug-link-o-tmpfile.c
@@ -23,10 +23,21 @@
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
+		ksft_exit_fail_msg("Error : Need to run as root");
+	}
+
 	if (unshare(CLONE_NEWNS) == -1) {
 		if (errno == ENOSYS || errno == EPERM) {
 			fprintf(stderr, "error: unshare, errno %d\n", errno);
-- 
2.45.2


