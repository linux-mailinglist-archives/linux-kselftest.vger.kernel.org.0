Return-Path: <linux-kselftest+bounces-18487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B966C9887E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 17:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7402823C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 15:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E918E1C172B;
	Fri, 27 Sep 2024 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl9AEbr4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01C81C0DFA;
	Fri, 27 Sep 2024 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449503; cv=none; b=WxAiA+AtYTuO8rYV71iRqQJHt/yqOcOhleSUisdI636MWy+Z95S0IuOhXBSNC59F91lCdPke4ZxVjFE5B7xBO4oVZKGpy4n7djoPEs36GrR2tiq2q5Z3gakcFxJ43s7HoWur9V6K+JPQEt9bfqyo6lwFJqqri910v+Yj3+fmCRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449503; c=relaxed/simple;
	bh=BunAHAAoavTgc1wu3JQ83XiIUOvlOcYFewLPtffYXt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mqh1pYuBuwaKCvO93R3awYBZ8zEO6yd7W22O/x3/+RjYv7Danl5wQq+KeXxwobw4GM0RsBW5UTi2/grMLqvTZwGGxa3rR4JBqd3WeoEJugECDHJpgzov16YbLc221zqdUh/dGf9kDL/QxbJEvQvPuJqPDiE2qJ+bkPqvctGmn+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl9AEbr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B133BC4CEC4;
	Fri, 27 Sep 2024 15:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727449503;
	bh=BunAHAAoavTgc1wu3JQ83XiIUOvlOcYFewLPtffYXt4=;
	h=From:To:Cc:Subject:Date:From;
	b=Tl9AEbr4gol4+1UAVflKLxncYDSmBauqs6lHOMcF7kDNJxOfivsc6p+W6NrzaKyaY
	 ZRdt727YydB9V+B2+sLSShocywD9jcmlb9y//dlZ1z14SP02gqR3+1vzrJ58iltbJz
	 PBjxwpzYVYAPs/jaqLBCAJGyuV4XDO/pqaFi8ILHLTDX0XPS6/4/arfUnDaaSQLqLl
	 kxUM8fgsU+jSkV0s/laCqweslUjiQbVfowDPjOE99oepDdeRI1vvFZ20FD6bD6EsRs
	 G/hhvYg94ueu9uxrBr5wJi2pvV6B4AlpURCAnA4YrjJe6aJOQoVdYMtQFFbNH1sk5M
	 wdnxBuDXkxZ6g==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Adrian Reber <areber@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: clone3: Avoid fragile struct poking
Date: Fri, 27 Sep 2024 17:04:53 +0200
Message-ID: <20240927150455.360843-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

The struct libcap in the selftest, and the what libcap is actually
using doesn't match, so the test fail. Libcap internals have changed,
but the selftest hasn't.

Fix by avoid poking the libcap internals.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 .../clone3/clone3_cap_checkpoint_restore.c      | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index 31b56d625655..9e6ee8c5316e 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -89,14 +89,9 @@ static int test_clone3_set_tid(struct __test_metadata *_metadata,
 	return ret;
 }
 
-struct libcap {
-	struct __user_cap_header_struct hdr;
-	struct __user_cap_data_struct data[2];
-};
-
 static int set_capability(void)
 {
-	cap_value_t cap_values[] = { CAP_SETUID, CAP_SETGID };
+	cap_value_t cap_values[] = { CAP_SETUID, CAP_SETGID, CAP_CHECKPOINT_RESTORE };
 	struct libcap *cap;
 	int ret = -1;
 	cap_t caps;
@@ -113,14 +108,8 @@ static int set_capability(void)
 		goto out;
 	}
 
-	cap_set_flag(caps, CAP_EFFECTIVE, 2, cap_values, CAP_SET);
-	cap_set_flag(caps, CAP_PERMITTED, 2, cap_values, CAP_SET);
-
-	cap = (struct libcap *) caps;
-
-	/* 40 -> CAP_CHECKPOINT_RESTORE */
-	cap->data[1].effective |= 1 << (40 - 32);
-	cap->data[1].permitted |= 1 << (40 - 32);
+	cap_set_flag(caps, CAP_EFFECTIVE, 3, cap_values, CAP_SET);
+	cap_set_flag(caps, CAP_PERMITTED, 3, cap_values, CAP_SET);
 
 	if (cap_set_proc(caps)) {
 		perror("cap_set_proc");

base-commit: 075dbe9f6e3c21596c5245826a4ee1f1c1676eb8
-- 
2.43.0


