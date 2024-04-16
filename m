Return-Path: <linux-kselftest+bounces-8178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE7A8A6FC1
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7548281A41
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A93A130AE5;
	Tue, 16 Apr 2024 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="q5ie51gk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0B5130AC3;
	Tue, 16 Apr 2024 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281293; cv=none; b=p+e7MuREy9qy5CpONC9GC5jADqTjYcuWEY+7CjOFgJH6q8Ghn5xyxF6c20hd1FUFToolkUmg//SertpBPfykTiqH+BVsRTLxkugrmmDEFqxppMw4qRALl3q6kj3vuxASQ9RyrKvrngelhn5H/03Idc8CyjBkO2VdpnQ6VtIKxRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281293; c=relaxed/simple;
	bh=NGtY+NfH5eSYN/zT1SdxCb+w6K6ZM2eMh40eWe83mAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UeOjExUZr1VyALm6iAmEvPbL/sguWk/x+fY3dqQ5OLuDeHrjVoN9ITUc6lI3WSNNDMOU6XCPnamf4LCWF1IFPJbv730KzCfbNpbFe+CE4qg3FvmqYA2mElPA0b9VYPYk+QkE/XVzc4fJ7tuvxBAQ2Dd6clFQ/gaH8oXA4XY3W4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=q5ie51gk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713281290;
	bh=NGtY+NfH5eSYN/zT1SdxCb+w6K6ZM2eMh40eWe83mAw=;
	h=From:To:Cc:Subject:Date:From;
	b=q5ie51gkGiYUIkIH7VFgHFaGbHNjJNJ4bmSL6eUqT6OilkJU0r80xLkLOQ+sgdSV0
	 bwIQNhl/g6vndbJtGrPydob0tNnkA6xAM+8ACZBUs5mMSG8yaQV95MIjCBLOIkR2gg
	 I/9NAhQzY+7q7rPZFUWjTlggR6pWcc98f+TN+0wZLphdL6WXtrt1zCZVeugwK1qOxc
	 3Xpae/6sqP1L8jRvh5so3zjTJ485iyp9ij+YUZ+gXP3SuxfjGRCfFMXB5SklzTKl3M
	 GNBjmU4IlCAcr7USdFHByfH9ALNfEMvvs/KD3ajrd16vPRwg362veCUjo1c8wJbjld
	 KqR92gMgfFgsQ==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B359B37804B2;
	Tue, 16 Apr 2024 15:28:03 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>
Cc: kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2] selftests: exec: make binaries position independent
Date: Tue, 16 Apr 2024 20:28:29 +0500
Message-Id: <20240416152831.3199999-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The -static overrides the -pie and binaries aren't position independent
anymore. Use -static-pie instead which would produce a static and
position independent binary. This has been caught by clang's warnings:

  clang: warning: argument unused during compilation: '-pie'
  [-Wunused-command-line-argument]

Tested with both gcc and clang after this change.

Fixes: 4d1cd3b2c5c1 ("tools/testing/selftests/exec: fix link error")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Remove unneeded comment
---
 tools/testing/selftests/exec/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index fb4472ddffd81..3c79ec9bf780f 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -29,8 +29,8 @@ $(OUTPUT)/execveat.denatured: $(OUTPUT)/execveat
 	cp $< $@
 	chmod -x $@
 $(OUTPUT)/load_address_4096: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000 -pie -static $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000 -static-pie $< -o $@
 $(OUTPUT)/load_address_2097152: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x200000 -pie -static $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x200000 -static-pie $< -o $@
 $(OUTPUT)/load_address_16777216: load_address.c
-	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000000 -pie -static $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) -Wl,-z,max-page-size=0x1000000 -static-pie $< -o $@
-- 
2.39.2


