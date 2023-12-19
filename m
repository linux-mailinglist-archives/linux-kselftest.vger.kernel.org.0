Return-Path: <linux-kselftest+bounces-2235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE92819076
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 20:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCE31C240DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 19:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D537638DEE;
	Tue, 19 Dec 2023 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZt4bysl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63BD3984A;
	Tue, 19 Dec 2023 19:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE9BC433C9;
	Tue, 19 Dec 2023 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703013367;
	bh=a5lFahzKlrRL4P7ohRe8Cfy1Uo6XmMsEJQeMU3iI95g=;
	h=From:Date:Subject:To:Cc:From;
	b=dZt4byslP6DiMXmFUkvkmN2tN2LG1JTx3kf8/ZxaAGV58MQrH87vV4FFsIuEkdwG/
	 QBP1lPcaV04KWu+/4vW2LPAN0wt6CBNa16t5MI9EQpGEM2Z47hy7Mi7spEQ00fJl2l
	 TmSbAnwlZlRLyOJeVvOYeGrllETJPJ+9dcvPRHwpe/r0QsgoHJWJqg5k1n3JTXJHkF
	 sTFS6HcaQrSq5Mjj4lTe5o4sH7F0DQiKk3M/8B9PsltouydwMbuEwnrhloi3w918WD
	 St34tQuc2iWHSS43xvri0odwAc3XGjIfzCWM1ZOTJi4zGoAsXwaBorC3T94WfmDVYC
	 byNH8zg74pTUw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 19 Dec 2023 19:15:54 +0000
Subject: [PATCH] selftests/seccomp: Try to fit runtime of benchmark into
 timeout
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-kselftest-seccomp-benchmark-timeout-v1-1-8515c73015b9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOnrgWUC/x3NQQ6CMBBG4auQWTsJrYrBqxgWtP2RCbaQTjUmh
 LvbuPw27+2kyAKle7NTxkdU1lRhTg35eUxPsIRqsq09G2t6dhdeFK+pQAsrvF/jxg7Jz3HMCxe
 JWN+F26vrOtyC7YOhGtsyJvn+R4/hOH7IZ21MeAAAAA==
To: Kees Cook <keescook@chromium.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=2084; i=broonie@kernel.org;
 h=from:subject:message-id; bh=a5lFahzKlrRL4P7ohRe8Cfy1Uo6XmMsEJQeMU3iI95g=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhtTG11/EZ7a+ml7nxS8qorxS8l3g48OT+ljn53Oq/24TiNu8
 mVOrk9GYhYGRi0FWTJFl7bOMVenhElvnP5r/CmYQKxPIFAYuTgGYSOF89n8qV+p16t4YOFSbCTtOfV
 wd6Ru63f63uqGZx5xbrpK1DcUHRQMUVkqYfipsW5d9q6Z0kvn687/3tKh+ZNUokFlhVyT+I6p1ZkKI
 sL8Ny7fMu05uE07c+fqlSXjL78AvAn2KF09K/OdluM3++d8lqx0BXl9YWXUY7602O6s3L2H5og3NRo
 xSk+7pGsoWFzvHyCxj6TK3a7NqSVhvqGmndWz+q9IAx8pNLWr+RpVbFh5lCoh5VlxkucM85Y51q9SV
 7GU2HAKL+iedNDm44ERJtYKgOU9ugJiN9dqzIdXth174TU1c39cd8KbanatiQueGsC0v46IbxCMCpH
 oXJsjq778fNKVM4rzF92972zkA
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
base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
change-id: 20231219-b4-kselftest-seccomp-benchmark-timeout-05b66e7d29d1

Best regards,
-- 
Mark Brown <broonie@kernel.org>


