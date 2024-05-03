Return-Path: <linux-kselftest+bounces-9365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0152E8BAB4C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 13:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B081C28561A
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 11:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC59815686C;
	Fri,  3 May 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="v6T8rKzp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB71155310
	for <linux-kselftest@vger.kernel.org>; Fri,  3 May 2024 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733927; cv=none; b=Mn5ktszTratnhaF6DT70M1J88S163ZL5P3dsGxzrv++5G8GQcJTsdCeioiPElz4jIdfaLO63NIXdSAu1ff4JRyDIbK8hZ4UmmlfWqoI97vw/94X+1s/w4U+zOlQh9YZLKdLFj4IQlsnCfbQ+zyeIBxbv/Ck7FT4igSYwB44onVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733927; c=relaxed/simple;
	bh=1L5PPLpNTzXpbKkNGS4y+eTSJHkTUDhusf1GwO2k4hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVIP1g+72uDMha4NPhZNXnm8mKizcEcvYKGoH3VGob6SwJ8DDteNAgKB+sRL9Do3Ra+Pmry4Q/tNq+pr/sSE2DGMd5wBilVicyl+HdvJWGEjnWtGuAzj48GKR1cB9q334n5W/Ct/eQ6MbSK+Ago7LszFRVh9JmlDOrjr8OwrwSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=v6T8rKzp; arc=none smtp.client-ip=84.16.66.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VW78G56DxzBk6;
	Fri,  3 May 2024 12:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714733918;
	bh=1L5PPLpNTzXpbKkNGS4y+eTSJHkTUDhusf1GwO2k4hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v6T8rKzpboKz4tC0UZH35bSt6WfIQeZkvc17Jm8vjjuiCz9bHb/JwZHP5K51pXp7v
	 c4UgxyP3chVd6l8CTz2RWkRPtw/G1rVmTqLpzqm5LSPFJ8PmyJC5JxRolu4MRzNRZn
	 ALOj4v07MgEp7cm/Wz95DkEAwsaI5Afz08jVidIo=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VW78G0lhNzV4C;
	Fri,  3 May 2024 12:58:38 +0200 (CEST)
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
	netdev@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v5 07/10] selftests/pidfd: Fix wrong expectation
Date: Fri,  3 May 2024 12:58:17 +0200
Message-ID: <20240503105820.300927-8-mic@digikod.net>
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

Replace a wrong EXPECT_GT(self->child_pid_exited, 0) with EXPECT_GE(),
which will be actually tested on the parent and child sides with a
following commit.

Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240503105820.300927-8-mic@digikod.net
---

Changes since v1:
* Extract change from a bigger patch (suggested by Kees).
---
 tools/testing/selftests/pidfd/pidfd_setns_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 6e2f2cd400ca..47746b0c6acd 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -158,7 +158,7 @@ FIXTURE_SETUP(current_nsset)
 	/* Create task that exits right away. */
 	self->child_pid_exited = create_child(&self->child_pidfd_exited,
 					      CLONE_NEWUSER | CLONE_NEWNET);
-	EXPECT_GT(self->child_pid_exited, 0);
+	EXPECT_GE(self->child_pid_exited, 0);
 
 	if (self->child_pid_exited == 0)
 		_exit(EXIT_SUCCESS);
-- 
2.45.0


