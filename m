Return-Path: <linux-kselftest+bounces-6552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F155A88B2A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 22:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A53ABB42F6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 17:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5024E1BC58;
	Mon, 25 Mar 2024 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNXhFr/K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9EB1BC44;
	Mon, 25 Mar 2024 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385887; cv=none; b=NDQQCHQe9kJ+Z1xA4MFxRo/P0Gf+hEdrSDKQeveyGthmmzDd94waZWjQR6k8J96tqxgfe0X6eihCJz44ZH9UM1aRGXrYqa+aOFsDiYhparpVJt0ukrd1y4zdKpDeXZ8zrw22ccvRE+ruAHAN+z3fbyWjG+pL0gf35GJSgCAv1iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385887; c=relaxed/simple;
	bh=ZAryErzyk7PMlbgaOGZnTHSqGVoOVC7abOx7wbdyHYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VvMGfsSUg+uR/YD7zFVvAzz5DWp+eTSJnOuaZgmZYTPEx6i77DriE1qE35NGr2U3Jum/sWOaN0YvAViXbImWS2Vihf8V6aPtCcBiiJf+eb3QNgjid/U53ancVbdlvmLOK0ZzUXDZ3LfmjaDGfMBWgTfVQbE4fklW1CuxhvnZ9OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNXhFr/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C102C433C7;
	Mon, 25 Mar 2024 16:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711385886;
	bh=ZAryErzyk7PMlbgaOGZnTHSqGVoOVC7abOx7wbdyHYk=;
	h=From:Date:Subject:To:Cc:From;
	b=PNXhFr/Kd9TYsTjZWDnjGcqz/ip6e2clJkyTaqaFrlcXtni1bEs1evRrE4P0LnwGN
	 3dJDE2mEWNcUd9oosQKd9HH74qhd/Gy4dG+Ym9//3rhmHnfP/08YGhxr3XsGpVLCKi
	 sCOPvDbFe1EqCb5YqBH9sTnQOykoP2fRfumFfevxcTfabvINyYxVmoeTx93YAJ+Ow8
	 OyuwryJVjuM7vtkAID6XTcfQvVcWR1E7B6uHh4aE0X2xYMRAcjacnmgmRFlgVffJgk
	 w8mIRuCaMFxCw0G3NsOSr7DNVq9h8vGobBc7zTR+YujIfUDUG0MznK5FdimspfWfwq
	 TnWf3NKzk5ilg==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 25 Mar 2024 16:57:59 +0000
Subject: [PATCH v2] selftests/seccomp: Try to fit runtime of benchmark into
 timeout
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-b4-kselftest-seccomp-benchmark-timeout-v2-1-77292da87966@kernel.org>
X-B4-Tracking: v=1; b=H4sIABatAWYC/5XNQQ6CMBCF4auYrh3DFAviynsYFrQM0AAt6VSiI
 dzdyg1c/m/xvk0wBUss7qdNBFotW+9SyPNJmKFxPYFtUwuZyRwlVqCvMDJNXSSOwGSMnxfQ5Mw
 wN2GEaGfyrwiZ0kVBZSurFkU6WwJ19n1Azzr1YDn68DncFX/r38SKgHBTqEyZZ6h09RgpOJouP
 vSi3vf9C9xeAYndAAAA
To: Kees Cook <keescook@chromium.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2248; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZAryErzyk7PMlbgaOGZnTHSqGVoOVC7abOx7wbdyHYk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmAa0c41Us7y3vmjq+yevSugFrr+F8JGTp2NgSOMo3
 mukgYeKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZgGtHAAKCRAk1otyXVSH0NelB/
 9ZZ+nA7IcEJiexh0qlIc9llBO+GzpQt1ko5fTu93j763r9S4tk9Bm6GwTS2L4xduEGshqmBnzV/SZ9
 cqHvcfdkXP7hw3FPtthAlvDUX6jhxlp111GHME7nNDMTzKHjb9rsHeR3OEiAbZsQeXkYy6GlI+d8+1
 izH9bZ7Ar3KX8ukdfe03D/1VFwlVT1+fWSto9Jq6twCCJChX4gEHDMC/LnWQJSRosjE8j2w56OuAGN
 L4LE1AmfijtN6Ih4jsz9LkYc3lTC0UZ00S0X/ngATk6YmqbjmyY7nUk15IJlbhiLC7Z5sIigthCdG+
 Gnln8HgXwdGBvaU5dUdXIU1R7YIGmU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The seccomp benchmark runs five scenarios, one calibration run with no
seccomp filters enabled then four further runs each adding a filter. The
calibration run times itself for 15s and then each additional run executes
for the same number of times.

Currently the seccomp tests, including the benchmark, run with an extended
120s timeout but this is not sufficient to robustly run the tests on a lot
of platforms. Sample timings from some recent runs:

   Platform          Run 1  Run 2  Run 3  Run 4
   ---------         -----  -----  -----  -----
   PowerEdge R200    16.6s  16.6s  31.6s  37.4s
   BBB (arm)         20.4s  20.4s  54.5s
   Synquacer (arm64) 20.7s  23.7s  40.3s

The x86 runs from the PowerEdge are quite marginal and routinely fail, for
the successful run reported here the timed portions of the run are at
117.2s leaving less than 3s of margin which is frequently breached. The
added overhead of adding filters on the other platforms is such that there
is no prospect of their runs fitting into the 120s timeout, especially
on 32 bit arm where there is no BPF JIT.

While we could lower the time we calibrate for I'm also already seeing the
currently completing runs reporting issues with the per filter overheads
not matching expectations:

Let's instead raise the timeout to 180s which is only a 50% increase on the
current timeout which is itself not *too* large given that there's only two
tests in this suite.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v2:
- Rebase onto v6.9-rc1.
- Link to v1: https://lore.kernel.org/r/20231219-b4-kselftest-seccomp-benchmark-timeout-v1-1-8515c73015b9@kernel.org
---
 tools/testing/selftests/seccomp/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/settings b/tools/testing/selftests/seccomp/settings
index 6091b45d226b..a953c96aa16e 100644
--- a/tools/testing/selftests/seccomp/settings
+++ b/tools/testing/selftests/seccomp/settings
@@ -1 +1 @@
-timeout=120
+timeout=180

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20231219-b4-kselftest-seccomp-benchmark-timeout-05b66e7d29d1

Best regards,
-- 
Mark Brown <broonie@kernel.org>


