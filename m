Return-Path: <linux-kselftest+bounces-22178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 109639D12B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 15:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2447B252FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2024 14:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7776919C54B;
	Mon, 18 Nov 2024 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CZAEuHg6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BD3196C67;
	Mon, 18 Nov 2024 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731938839; cv=none; b=MpklfGCSbhOS2SMKd0IQ+DbxveeaOtZKRNrWnHyiZuaXKWyLfouXZPhXf/LbNTD4zg7ng/Z1cbszu9cIiKsQ1cnjsTZHxTQ6FhSCMoeWJSC4Xr8GOIQAuWourPqGt5Uq7Y0qRQRSdRjVHEsXIY4WCRDvJ9+kWgPhk5zzxB+tZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731938839; c=relaxed/simple;
	bh=x6vfhzdgog0R2D4+u+nvAJH8rjr4e04bhFPsdcpjJes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pk901zD4e+bCrQScvMG87Ag9u0hKFmDZ5OvyAPsucXHDVj36g/cTLlgox19MKOFEsV1a8gXr5+Bq+doAGm0W2GkqZRBLL7FGSpjVzorUQaGXizfFjw0HG5BLHkI9srYpZJMbhL9I8agQMFxhJj3DwpODmO5xNVyX5cMjCMhhhYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CZAEuHg6; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=/HM2i
	Hvf97NP3FjbIWxYEj7KCm2FhZwT0bdFWr+gBXM=; b=CZAEuHg6h5CSgjZJour9Y
	0/lqNyj6NTL0t2n3wxRYgbO/MoTXAzZF/0NLDb168RuRVTTUCdX6XoJ7DTRL6Mcl
	eQ1uFFPgDs8We8QiF22WNp3BDtkCpYZHnQDJxk7wtccZtOxjYUyclAbUCTIOOG2+
	QU6Vy14R6THb48miR9Kino=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3_+X0STtnMoCsDw--.3348S2;
	Mon, 18 Nov 2024 22:06:50 +0800 (CST)
From: Jiayuan Chen <mrpre@163.com>
To: skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org
Cc: song@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	martin.lau@linux.dev,
	andrii@kernel.org,
	ast@kernel.org,
	kpsingh@kernel.org,
	jolsa@kernel.org,
	Jiayuan Chen <mrpre@163.com>
Subject: [PATCH kselftest] fix single bpf test
Date: Mon, 18 Nov 2024 22:06:08 +0800
Message-ID: <20241118140608.53524-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgD3_+X0STtnMoCsDw--.3348S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF4rtr4rGF4rZr4DGw1Dtrb_yoW5WFykpa
	48Jwn8Kr1kKFWUtryrJ3WUXry8Wr4v9392vF18ZrWUZw15JFZ7Xw4IkFZ5Aa47WrZ5Z3y5
	Za4IgF17ua9rAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piX_-PUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWxmbp2c7QysO+wABs+

Currently, when testing a certain target in selftests, executing the
command 'make TARGETS=XX -C tools/testing/selftests' succeeds for non-BPF,
but a similar command fails for BPF:
'''
make TARGETS=bpf -C tools/testing/selftests

make: Entering directory '/linux-kselftest/tools/testing/selftests'
make: *** [Makefile:197: all] Error 1
make: Leaving directory '/linux-kselftest/tools/testing/selftests'
'''

The reason is that the previous commit:
commit 7a6eb7c34a78 ("selftests: Skip BPF seftests by default")
led to the default filtering of bpf in TARGETS which make TARGETS empty.
That commit also mentioned that building BPF tests requires external
commands to run. This caused target like 'bpf' or 'sched_ext' defined
in SKIP_TARGETS to need an additional specification of SKIP_TARGETS as
empty to avoid skipping it, for example:
'''
make TARGETS=bpf SKIP_TARGETS="" -C tools/testing/selftests
'''

If special steps are required to execute certain test, it is extremely
unfair. We need a fairer way to treat different test targets.

This commit provider a way: If a user has specified a single TARGETS,
it indicates an expectation to run the specified target, and thus the
object should not be skipped.

Another way is to change TARGETS to DEFAULT_TARGETS in the Makefile and
then check if the user specified TARGETS and decide whether filter or not,
though this approach requires too many modifications.
Signed-off-by: Jiayuan Chen <mrpre@163.com>
---
 tools/testing/selftests/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 363d031a16f7..d76c1781ec09 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -116,7 +116,7 @@ TARGETS += vDSO
 TARGETS += mm
 TARGETS += x86
 TARGETS += zram
-#Please keep the TARGETS list alphabetically sorted
+# Please keep the TARGETS list alphabetically sorted
 # Run "make quicktest=1 run_tests" or
 # "make quicktest=1 kselftest" from top level Makefile
 
@@ -132,12 +132,15 @@ endif
 
 # User can optionally provide a TARGETS skiplist. By default we skip
 # targets using BPF since it has cutting edge build time dependencies
-# which require more effort to install.
+# If user provide custom TARGETS, we just ignore SKIP_TARGETS so that
+# user can easy to test single target which defined in SKIP_TARGETS
 SKIP_TARGETS ?= bpf sched_ext
 ifneq ($(SKIP_TARGETS),)
+ifneq ($(words $(TARGETS)), 1)
 	TMP := $(filter-out $(SKIP_TARGETS), $(TARGETS))
 	override TARGETS := $(TMP)
 endif
+endif
 
 # User can set FORCE_TARGETS to 1 to require all targets to be successfully
 # built; make will fail if any of the targets cannot be built. If

base-commit: 67b6d342fb6d5abfbeb71e0f23141b9b96cf7bb1
-- 
2.43.5


