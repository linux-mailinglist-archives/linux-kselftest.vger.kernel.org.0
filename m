Return-Path: <linux-kselftest+bounces-4474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAF284FD7C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 21:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81BE91C21DDA
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 20:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E21C86ADE;
	Fri,  9 Feb 2024 20:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VILm83tG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EF954F86;
	Fri,  9 Feb 2024 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510177; cv=none; b=uPNr2QT5DPY9VkDnN05Fh5nnER0fmhx6rjXkJlJJxITslw9SabCwpnv3ISoyFn7Lu90sFv04KCLUQuBviL1VX4v/QYoFAVrHidm4R1I9rJZnsqezdKF1MdiPR/olSe5t/WC2QN8Xolc6PfrrFYnSTbpyr8GXLnVJotA7T3u/bwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510177; c=relaxed/simple;
	bh=Vww2Jj+v4Z8QiE6rCC7eLelQulPvEW9AU9xCOOc5Lhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ed0kCbAEaC4u4EveY17jW4UP8t/1CYvK1IwqbCwIihpfKvI4U5/YTLofNR1xgtTm6I9C8M8QbimGJkk8YpcMjq+0Jq4CkY2Zc09DJcbXoHG8lYSFNM5/whnzTE3qcfu3WEXBguR/vuji7OtaPnZsJt2jQqEaZESaXZTgLrzh2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VILm83tG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C39C433F1;
	Fri,  9 Feb 2024 20:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707510176;
	bh=Vww2Jj+v4Z8QiE6rCC7eLelQulPvEW9AU9xCOOc5Lhs=;
	h=From:Date:Subject:To:Cc:From;
	b=VILm83tG07I926TyXMoIq7o0EQH9hCwIgF/fp3XDX/JF2nr46v6yuLxuldO2ZvcOf
	 J6asXPk7Hjegdp1jJKAfaQEIKcLZslgCR/ryNI6E7g0jEVFlKAJD2rWG3IgemaA/8F
	 mx7RMzb0uFJ2MAtL2G/3/E5SfWXBJdYMwmm8v0Iu1wPIvbeN715hiH2iYUgrkISg7k
	 5AGJaT8k/lEanSJTYbIDHggvVcGWVlXEz/7st9y41Yt3P39MtWP1cXUZ71Y2PuyP+I
	 sYfSY9Y0NEPSCIB0UkkqCV+WLfSCugyPjwoF89e8dy+My11N9jc31x6Dx+K5ZCxB+b
	 zUcMIgipFn2uw==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 09 Feb 2024 20:21:52 +0000
Subject: [PATCH] selftests/mm: Don't needlessly use sudo to obtain root in
 run_vmtests.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-kselftest-mm-check-deps-v1-1-19b09b151522@kernel.org>
X-B4-Tracking: v=1; b=H4sIAF+JxmUC/x3MSwqAMAxF0a1IxgZqUVC3Ig6kfdXgl0ZEEPduc
 XgG9z6kiAKlNnso4hKVfUso8ozcNGwjWHwyWWNLY03Ds2IJJ/TkdWU3wc3scSibYqhthSrAl5T
 qIyLI/Z+7/n0/aEhrBmkAAAA=
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Ryan Roberts <Ryan.Roberts@arm.com>, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Vww2Jj+v4Z8QiE6rCC7eLelQulPvEW9AU9xCOOc5Lhs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlxomdxcmkOMP7U5xLlUuVTjCBZ0WrLPGtq+XfL
 3p9ITNu54yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZcaJnQAKCRAk1otyXVSH
 0KH6B/9ApTHhrLOmnmotvLBAK11wu+cHt8ITHTFopBl8aopyk+Y7JyvT+YhnNUxRO8FrGN1labO
 8apCpf/+yNMZD9meVzb92MkvfZjyXC3UqaEMva5dlT8adWtGeGBNHQoMen/OJiPm5Xz7taVADj4
 itQgs/XjjLYGzZmj6hyA2ch15zqZgAs+uJZpX8nKXXuUkIjEkJFk0c6u5/0FGaHr7QBTFSJUsaG
 mPOH/CqmlDEUQQrtYxc+sKfUxMz+Czj7XmSZ3Fspo8k7CeQv6J8DpHklaV5Cv3SAK8taXiSx/eN
 xsEwQvOvjckH5GCqTeVhp6LVYowJlSr/2TnH+q3oWhqlcsoJ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When opening yama/ptrace_scope we unconditionally use sudo to ensure we
are running as root, resulting in failures if running in a minimal root
filesystem where sudo is not installed. Since automated test systems will
typically just run all of kselftest as root (and many kselftests rely on
this for full functionality) add a check to see if we're already root and
only invoke sudo if not.

Since I am unclear what the intended effect of the command being run is I
have not added any error handling for the case where we fail to obtain
root.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/run_vmtests.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index fe140a9f4f9d..c8ca830dba93 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -248,6 +248,17 @@ run_test() {
 
 echo "TAP version 13" | tap_output
 
+HAVE_ROOT=0
+if [ "$(id -u)" = "0" ]; then
+	AS_ROOT=
+	HAVE_ROOT=1
+elif [ "$(command -v sudo)" != "" ]; then
+	AS_ROOT=sudo
+	HAVE_ROOT=1
+else
+	echo # WARNING: Unable to run as root
+fi
+
 CATEGORY="hugetlb" run_test ./hugepage-mmap
 
 shmmax=$(cat /proc/sys/kernel/shmmax)
@@ -363,7 +374,8 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
 # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
 CATEGORY="madv_populate" run_test ./madv_populate
 
-(echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
+# FIXME: What if we can't get root?
+(echo 0 | ${AS_ROOT} tee /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
 CATEGORY="memfd_secret" run_test ./memfd_secret
 
 # KSM KSM_MERGE_TIME_HUGE_PAGES test with size of 100

---
base-commit: 445a555e0623387fa9b94e68e61681717e70200a
change-id: 20240209-kselftest-mm-check-deps-01a825e5fed4

Best regards,
-- 
Mark Brown <broonie@kernel.org>


