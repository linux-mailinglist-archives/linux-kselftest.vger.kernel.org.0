Return-Path: <linux-kselftest+bounces-21496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4A69BD700
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A129E284041
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 20:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867B2215C7B;
	Tue,  5 Nov 2024 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJfJAFdg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E50215C51;
	Tue,  5 Nov 2024 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838411; cv=none; b=RBxP4AWmu4CFiKB87ErkNF447MGhFOE/ayB8Du3AjQR7raGxtdcatCdCY40c4Mvln8/5zZGFMqQ+U4OI3Bj9x0cy7LQzj1pbyN/Qooxgz1JQzm3aydNtcZZVOdpXwcNijzlXXzwEPQmRepKMJZNeY00MpJakEeDNOeTFj1LNn/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838411; c=relaxed/simple;
	bh=hTYIysBb73pQcGfbMlCjZoUnXhX3kUj3HocGQiRzBNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edQdum2RGBs407tmqC5H8PPzPFhp8uKSaQ2tzmF7bzpWNiNi8nehBFz5Cduc63eo4tqrtwNVjwhQ118J0rxB2DV9WNj03UDujbo/ZwkKdonGb5vJMCzLCzL3qluBvifKkd4zyheTr1C21liiJrmzJ/DuF8juZ8IJv3f8P9jEgkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJfJAFdg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cdb889222so57138005ad.3;
        Tue, 05 Nov 2024 12:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730838409; x=1731443209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XT3No7GRKZdPAGp3d2fZuE2pq7D1yoaPqndFuh7XbSc=;
        b=aJfJAFdguKgpqwyXE4QFi+IXkxp5rcM6v5Hpg5YNMgZKRIaKZ7hIt18BL/yh4CHvSC
         czpoKSTaAYHaZu9CgAJqAowkqrtIfyzFQL/TKBqTT2BuIXeK6nHqSc7kkPYHwE22AXql
         FF69mGBphsFnVkjHT+E6ComAZKnV7MNUsmpV63z+4lQD3ahkpAVWfaQv/qCit9gHJK37
         3MOb10ipq8eQJQ2x0EDr0RzAd+BrTziKlb/1B3fCFhGfBanBblg5AxWCyNHP/FCBrUWZ
         6MsLwGEY4FWm1xKgP4KaiIlJ/6c2R+HvvGBMoKWk3iQQ+HaSN7N89snGh+uy15KqfEtQ
         h58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730838409; x=1731443209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XT3No7GRKZdPAGp3d2fZuE2pq7D1yoaPqndFuh7XbSc=;
        b=tJY69n9fyWHHybRnHJw33lbU9k75/4aIejlNpLbBKJ2N5bw56cWtHuz8Eaccw4riLb
         Ulpu6SRzb94v/2QVz4VPwJoc1dy01lPPorZGg4XCS9QnkZ5GFObJ6xS8RpmjMtOkPxkJ
         dOipgmEQer7AmCWVyykBqZWV58Q5W6nk/FAOys6nBFlPTWFfbzxsdqILht+DyrGO37vR
         8upE2ylYR10A1VRwQgP7Hm0mG1Jf5tb97B61rAAwwyvKTZeuTAwRw1gVnH63Mxy2fnaM
         KXemfx9HdtXo/NQ6kxSR8WSrC3j+sQ+BWV1TTeNLmn+PppFQBbcMmxgI/7AtLXtQ6iFS
         iC0w==
X-Forwarded-Encrypted: i=1; AJvYcCW22/M+nSmSMDY1TTMPlm/47FMir6ZQBWqBO9IE8ZrON8KrycJbJeVATRX/zn1HVazLOiAF/ku02tYsv08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxeepBTEqUfyJ6uHmKS9Audn/7TR5FZiG/vU2PQtf4R5AR0FUo
	9Mzpo1ujOckok7Ba+uzgy1g2nKpN2PmDzKwnIC538bzf3Dn23C2uvHnIFV7xBCs=
X-Google-Smtp-Source: AGHT+IEwxHh0iEEsZU5B/rZ5kLIROF/Pb+NSxPOnyBg70usMGWg+EFVrM5CyKGQNf8tV2UwfzAWGoA==
X-Received: by 2002:a17:902:ecc3:b0:20c:ee48:94f3 with SMTP id d9443c01a7336-21103accfbbmr273363285ad.14.1730838409417;
        Tue, 05 Nov 2024 12:26:49 -0800 (PST)
Received: from localhost.localdomain ([27.7.141.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edc65sm82640665ad.10.2024.11.05.12.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 12:26:49 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH v4 1/2] selftests:tmpfs: Add Skip test if not run as root
Date: Wed,  6 Nov 2024 01:56:38 +0530
Message-ID: <20241105202639.1977356-2-cvam0000@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105202639.1977356-1-cvam0000@gmail.com>
References: <20241105202639.1977356-1-cvam0000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add skip test if  not run as root, with an appropriate Warning.

Add 'ksft_print_header()' and 'ksft_set_plan()' to structure test
outputs more effectively.

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

