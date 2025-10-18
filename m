Return-Path: <linux-kselftest+bounces-43506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED145BEDBBA
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 22:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74667407DD2
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 20:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B252DF14C;
	Sat, 18 Oct 2025 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tz4vjciH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF36A2DC32A;
	Sat, 18 Oct 2025 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760820293; cv=none; b=tHdMQEfA/d/aS3h58MJegir9uAnNYZa66+PrgtZ2KQpyrIGervHOnzypwqlivwtZcWgBvcM6RQgmNIT2jSMjqMblCmeB3HiaoRbCjXqZr9iNXNOJKW6HhfBFZGF7w0NO41Medr6evK059V1eGpjOVEC2Etlu9PRWG4aslzZhI1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760820293; c=relaxed/simple;
	bh=mizIUChAFsqpIHY6nU9Fx3Ot5p8OeQz4ge3WLnGs1IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WF2Jsdnf6hlSUDONhr2T0pWsCVoQBmxMyJiUEENMj0gLyVZ0Ra8UtqMeGDiuzOhMBnUbg/PIWEE89WPtulVHZgn/EcFRBrZ1D7aLybOnOjAgqH0nANsAH/rBcewc+MwHTpfvhw3CS3Zp7PbgqvRU3LC1uiu6YiUYJlc3NLR0mXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tz4vjciH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35164C116D0;
	Sat, 18 Oct 2025 20:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760820293;
	bh=mizIUChAFsqpIHY6nU9Fx3Ot5p8OeQz4ge3WLnGs1IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tz4vjciHPBEgfaX0+unXfY0pbZzsgdubL0xREO960MitKSNo2qjvSeprQbr0KDQDa
	 ppYb90xfdAuxt9ZFBXz7sY6oAPlkEXN3li/QaiuGOqm42LMPxif5zkfCYsy2oXMjqx
	 +Mlc0NS27oc3EM5T3Zr0Vp9JJRWo69rdYMo7RLYvBK1Av71FctMfjRe0jMvEphocwL
	 UETH5IWUq0i4A1qRLJsrHI6M47syyAaAsUjMQDTa+5V3Bl/PFFw2bEA1TgVxPI2LNv
	 JXvdJuDg+nAapHXSGEnkMYIaisS5+hoC20rx2jKjVlA9tnC+4J1wsx5vfD0aFl9rC1
	 xy0HB2Ep75THQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/4] selftests/damon/sysfs: add obsolete_target test
Date: Sat, 18 Oct 2025 13:44:45 -0700
Message-ID: <20251018204448.8906-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251018204448.8906-1-sj@kernel.org>
References: <20251018204448.8906-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new DAMON sysfs file for pin-point target removal, namely
obsolete_target, has been added.  Add a test for the functionality.  It
starts DAMON with three monitoring target processes, mark one in the
middle as obsolete, commit it, and confirm the internal DAMON status is
updated to remove the target in the middle.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 37 ++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index fd8d3698326e..b34aea0a6775 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -279,5 +279,42 @@ def main():
 
     kdamonds.stop()
 
+    # test obsolete_target.
+    proc1 = subprocess.Popen(['sh'], stdout=subprocess.PIPE,
+                             stderr=subprocess.PIPE)
+    proc2 = subprocess.Popen(['sh'], stdout=subprocess.PIPE,
+                             stderr=subprocess.PIPE)
+    proc3 = subprocess.Popen(['sh'], stdout=subprocess.PIPE,
+                             stderr=subprocess.PIPE)
+    kdamonds = _damon_sysfs.Kdamonds(
+            [_damon_sysfs.Kdamond(
+                contexts=[_damon_sysfs.DamonCtx(
+                    ops='vaddr',
+                    targets=[
+                        _damon_sysfs.DamonTarget(pid=proc1.pid),
+                        _damon_sysfs.DamonTarget(pid=proc2.pid),
+                        _damon_sysfs.DamonTarget(pid=proc3.pid),
+                        ],
+                    schemes=[_damon_sysfs.Damos()],
+                    )])])
+    err = kdamonds.start()
+    if err is not None:
+        print('kdamond start failed: %s' % err)
+        exit(1)
+    kdamonds.kdamonds[0].contexts[0].targets[1].obsolete = True
+    kdamonds.kdamonds[0].commit()
+
+    status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
+    if err is not None:
+        print(err)
+        kdamonds.stop()
+        exit(1)
+
+    del kdamonds.kdamonds[0].contexts[0].targets[1]
+
+    assert_ctxs_committed(kdamonds.kdamonds[0].contexts, status['contexts'])
+
+    kdamonds.stop()
+
 if __name__ == '__main__':
     main()
-- 
2.47.3

