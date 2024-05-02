Return-Path: <linux-kselftest+bounces-9285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552848BA1F1
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 23:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11021283C54
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 21:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD28A1C8FC3;
	Thu,  2 May 2024 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Y6QJwMwP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48A1C2310;
	Thu,  2 May 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684201; cv=none; b=oQ7MLlDCUiTkG5sfRuAe43GyR5Stkol+LaiXLNirdoQLliNkr5PePjlEKC29v5uBrGUsfIjDUCgdiRoGHBXwqJiFIWl+acVaA3U1Z0utM0KBJyIvWdlyR1em1Wd+4ybYeFEuud9MmH3kgQQgbH7X2aKrR23WBsCu56cjig1AzmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684201; c=relaxed/simple;
	bh=KqEsjBjuhpsjwrbJBGS/A9dvVAlJ3/nK7tVCR3svPG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMWT/hwgTlD7J+cWFTfe89uOv+IYG+JkJaGo3HJL24rKG0HuhMxJdiVfBY/tA7a7ShbxtxEOB7MRXP6oCMF3p8Zd16XNRNZVfPCnm0eSkqnphNTsUW0NEnURiKSGmpVGLQ/2hTSrrhl7++eEcge/uwIQsQouHFLjg+0EIt3Z2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Y6QJwMwP; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VVmm03jwczL5X;
	Thu,  2 May 2024 23:09:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714684192;
	bh=KqEsjBjuhpsjwrbJBGS/A9dvVAlJ3/nK7tVCR3svPG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y6QJwMwPh4Vk1yiDX75N9NqUtxGjQbcqVDnJJwMC+pksry1GXyClOGQ3GYzXMUgZO
	 HgLgI1GKJocjJZMQo+kHGoQzfFTMTkDLfiAqNYUgFcIeKUQaZgU7TW8RfojFaD2C32
	 8h9VOq5brlKrfatEcHyD+/ITP9JwPb9ac502cs2c=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VVmlz3TX3zqTH;
	Thu,  2 May 2024 23:09:51 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 10/10] selftests/harness: Fix TEST_F()'s exit codes
Date: Thu,  2 May 2024 23:09:26 +0200
Message-ID: <20240502210926.145539-11-mic@digikod.net>
In-Reply-To: <20240502210926.145539-1-mic@digikod.net>
References: <20240502210926.145539-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Always forward grandchild's exit codes to its parent.  This fixes
KVM_ONE_VCPU_TEST().

Initial patch written by Sean Christopherson [1].

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Will Drewry <wad@chromium.org>
Link: https://lore.kernel.org/r/ZjPelW6-AbtYvslu@google.com [1]
Fixes: 0710a1a73fb4 ("selftests/harness: Merge TEST_F_FORK() into TEST_F()")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240502210926.145539-11-mic@digikod.net
---

Changes since v3:
* New patch mainly from Sean Christopherson.
---
 tools/testing/selftests/kselftest_harness.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index d3837a3a584e..77d4fac8d0c0 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -442,7 +442,7 @@ static inline pid_t clone3_vfork(void)
 				fixture_name##_setup(_metadata, self, variant->data); \
 				/* Let setup failure terminate early. */ \
 				if (_metadata->exit_code) \
-					_exit(0); \
+					_exit(_metadata->exit_code); \
 				_metadata->setup_completed = true; \
 				fixture_name##_##test_name(_metadata, self, variant->data); \
 			} else if (child < 0 || child != waitpid(child, &status, 0)) { \
@@ -454,7 +454,7 @@ static inline pid_t clone3_vfork(void)
 			if (_metadata->setup_completed && !fixture_name##_teardown_parent && \
 					__sync_bool_compare_and_swap(teardown, false, true)) \
 				fixture_name##_teardown(_metadata, self, variant->data); \
-			_exit(0); \
+			_exit(_metadata->exit_code); \
 		} \
 		if (_metadata->setup_completed && fixture_name##_teardown_parent && \
 				__sync_bool_compare_and_swap(teardown, false, true)) \
@@ -462,8 +462,10 @@ static inline pid_t clone3_vfork(void)
 		munmap(teardown, sizeof(*teardown)); \
 		if (self && fixture_name##_teardown_parent) \
 			munmap(self, sizeof(*self)); \
-		if (!WIFEXITED(status) && WIFSIGNALED(status)) \
-			/* Forward signal to __wait_for_test(). */ \
+		/* Forward exit codes and signals to __wait_for_test(). */ \
+		if (WIFEXITED(status)) \
+			_exit(_metadata->exit_code); \
+		if (WIFSIGNALED(status)) \
 			kill(getpid(), WTERMSIG(status)); \
 		__test_check_assert(_metadata); \
 	} \
-- 
2.45.0


