Return-Path: <linux-kselftest+bounces-9364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169538BAB48
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 13:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA8B284FA1
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 11:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE325153BE3;
	Fri,  3 May 2024 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="u3RuLMfl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B328154435
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733926; cv=none; b=htBH7vPgTgSLxcwsKcFA1u0J1RTGEMuHBlezGNEpPqdrR4nyztru2VdhmFCYBUtw3PegZ1DQk2s3jZIctiUMrOhppwSqGH3COIpzsAetWEQ35+ETZDihx85QjfxhqLOBD8dyVbM3LpUh3sYXGeJxM4who6rwuJzcn+GWm1JshA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733926; c=relaxed/simple;
	bh=6KlePIHjh/F0rwXAtm5wVQtdAF3T8pKIS+NqlOPteLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBdqep40lAploL35aUTXVAXMhusUzT9xtQaJrwL4eqyGMGop6XYFppmA0vjYb4taoHHiorgro/Cq29c2Yf2nc0Z5SMalH0ucfpOvpMajc01moI1Xti42Y+ZRfHnSNSdWWWd5iTBbQa+sVpiGRzvSOKjSDeh/3HLX11bKv4Rmw5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=u3RuLMfl; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VW78K3mspzPNb;
	Fri,  3 May 2024 12:58:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714733921;
	bh=6KlePIHjh/F0rwXAtm5wVQtdAF3T8pKIS+NqlOPteLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u3RuLMfl4d1/sSvej3lawnt1ZSVCPWY173dYy3g+BPuBi1ca1seVVKZQZLqJkarRz
	 6+jU6Ziqro+AbKmWEmsQXDb568J8msUDsipuKT9lYi4rnfiszNhVgoCWJ/nRvihgVV
	 mYl8W7ehIrR5vqTyCRlD1YXcTfAWnOA2WFMuGocg=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VW78K0CSSz111K;
	Fri,  3 May 2024 12:58:41 +0200 (CEST)
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
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 10/10] selftests/harness: Handle TEST_F()'s explicit exit codes
Date: Fri,  3 May 2024 12:58:20 +0200
Message-ID: <20240503105820.300927-11-mic@digikod.net>
In-Reply-To: <20240503105820.300927-1-mic@digikod.net>
References: <20240503105820.300927-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

If TEST_F() explicitly calls exit(code) with code different than 0, then
_metadata->exit_code is set to this code (e.g. KVM_ONE_VCPU_TEST()).  We
need to keep in mind that _metadata->exit_code can be KSFT_SKIP while
the process exit code is 0.

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
Link: https://lore.kernel.org/r/20240503105820.300927-11-mic@digikod.net
---

Changes since v4:
* Check abort status when the grandchild exited.
* Keep the _exit(0) calls because _metadata->exit_code is always
  checked.
* Only set _metadata->exit_code to WEXITSTATUS() if it is not zero.

Changes since v3:
* New patch mainly from Sean Christopherson.
---
 tools/testing/selftests/kselftest_harness.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index eb25f7c11949..7612bf09c5f8 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -462,9 +462,13 @@ static inline pid_t clone3_vfork(void)
 		munmap(teardown, sizeof(*teardown)); \
 		if (self && fixture_name##_teardown_parent) \
 			munmap(self, sizeof(*self)); \
-		if (!WIFEXITED(status) && WIFSIGNALED(status)) \
+		if (WIFEXITED(status)) { \
+			if (WEXITSTATUS(status)) \
+				_metadata->exit_code = WEXITSTATUS(status); \
+		} else if (WIFSIGNALED(status)) { \
 			/* Forward signal to __wait_for_test(). */ \
 			kill(getpid(), WTERMSIG(status)); \
+		} \
 		__test_check_assert(_metadata); \
 	} \
 	static void __attribute__((constructor)) \
-- 
2.45.0


