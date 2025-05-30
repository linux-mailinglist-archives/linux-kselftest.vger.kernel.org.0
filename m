Return-Path: <linux-kselftest+bounces-34060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F17DAC90CD
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 15:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E627A41A26
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 13:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498862248BD;
	Fri, 30 May 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svZNj/A1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CCA2222DA;
	Fri, 30 May 2025 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748613486; cv=none; b=UfDk8EUhkmjFYuETaOyB6Cn0B4/CcFc+NacJA78Vw3Ne/wD1CHjA2D/T9wrAnYxgRwR8XOx0xGoBjlM0FFOX1Qh0zBFcjZe4IqFESnSHfoUX3m+8fbEvuMS959+fmoYJSJENhX5tZ4ZyL20Ou4BGhshA/V8JWgayuT4GyEssaKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748613486; c=relaxed/simple;
	bh=Q6QhaPeaXwFOPHVO4uGQ/TJtWVxa9eihDKvl7iSuzvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Aa5SQcwop1Ow5C/Dm8WV+ph3VdVmR8RBg3XfvzvOduQmLFZI4i0sVthhWNGApJJXsQXoRpLu584xELWQ7emp0Q7QKkdFB1K2/4JsD1Tu6SBVxdprad5Hz/gi0Oy++flCy4VJ+6+kEBMJ5V/pVoZNmer+4LzPxKRRC8Dz0qMfU1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svZNj/A1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3503AC4CEEB;
	Fri, 30 May 2025 13:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748613484;
	bh=Q6QhaPeaXwFOPHVO4uGQ/TJtWVxa9eihDKvl7iSuzvA=;
	h=From:To:Cc:Subject:Date:From;
	b=svZNj/A16l/Ob0gOWo7b4jTgfSpX5tWpFqPp8aFWrMoH87rxQPwk7MQ4334+JWMzM
	 4UUtQkvW74XidLrggE3LJflm9zGeuKw/YGD9Qczd2x6b4fBjlYZHwmGvF1mgKkEF9e
	 O0iZNYMKgL9n6oFXgpTTIR/od5nHF2R7Zjr1LwNbYrIAHL8T5uQZ2YPcTPI+XQhjHi
	 Ogrg4fpXpbPBxnc0Z+qfMgjm84NiBzjhOwVZS8rtVt6xq3ZF42XoRG4PKsDujI2+Y4
	 YII+RTNPHC0D9cflwbj+74WA5rDTtT00o/x2WVkZuW9585jB9ArKs4hDDfCYB8XuPB
	 /4tyOZpGijqMw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com,
	broonie@kernel.org,
	rf@opensource.cirrus.com,
	mic@digikod.net,
	skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH net] Revert "kunit: configs: Enable CONFIG_INIT_STACK_ALL_PATTERN in all_tests"
Date: Fri, 30 May 2025 06:58:00 -0700
Message-ID: <20250530135800.13437-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit a571a9a1b120264e24b41eddf1ac5140131bfa84.

The commit in question breaks kunit for older compilers:

$ gcc --version
 gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5)

$ ./tools/testing/kunit/kunit.py run  --alltests --json --arch=x86_64
 Configuring KUnit Kernel ...
 Regenerating .config ...
 Populating config with:
 $ make ARCH=x86_64 O=.kunit olddefconfig
 ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
 This is probably due to unsatisfied dependencies.
 Missing: CONFIG_INIT_STACK_ALL_PATTERN=y

Link: https://lore.kernel.org/20250529083811.778bc31b@kernel.org
Fixes: a571a9a1b120 ("kunit: configs: Enable CONFIG_INIT_STACK_ALL_PATTERN in all_tests")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
I'd like to take this in via netdev since it fixes our CI.
We'll send it to Linus next week.

CC: brendan.higgins@linux.dev
CC: davidgow@google.com
CC: rmoar@google.com
CC: broonie@kernel.org
CC: rf@opensource.cirrus.com
CC: mic@digikod.net
CC: skhan@linuxfoundation.org
CC: linux-kselftest@vger.kernel.org
CC: kunit-dev@googlegroups.com
---
 tools/testing/kunit/configs/all_tests.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index 48b132cd9d2a..2f093048d985 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -10,7 +10,6 @@ CONFIG_KUNIT_EXAMPLE_TEST=y
 CONFIG_KUNIT_ALL_TESTS=y
 
 CONFIG_FORTIFY_SOURCE=y
-CONFIG_INIT_STACK_ALL_PATTERN=y
 
 CONFIG_IIO=y
 
-- 
2.49.0


