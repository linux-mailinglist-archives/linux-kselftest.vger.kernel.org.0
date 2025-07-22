Return-Path: <linux-kselftest+bounces-37797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A03B0D19A
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 08:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD8E37A23E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 06:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7231B28CF56;
	Tue, 22 Jul 2025 06:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUrC06TE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227928B4F3;
	Tue, 22 Jul 2025 06:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164216; cv=none; b=mos/PhCpsgyUFZ+Mo3BwAApBbstaBcUsdzy0qrGooCDsfENOrX90AvlE8Q71UFheu+nhm/079wycZuQ66bSRBSHSnUbgHU26iUXMvakNe5g0URPj3lLEqBo0FA3LDIu2Fg/tmO9Ks2yyVCnnaSR+QZ3VCE3yPyqh/bbDJcq4J/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164216; c=relaxed/simple;
	bh=D/8nQwpw1b4H3c6iBDsuwHR1cmui2Awzlsl6JSLf2cE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ced6ntYHPQgyskHXA74ccBskZiXIZgoZjmbc17e3enVdRaj3WyRy/uhXMhx9QuRsW7Li8/pC1b7yVIvY65GAdKtk6+06T2Irs1fJlpUPn7nzlZt6yXwZdf2196nEGwLcWz+dEYSWLbfKIbY0tSxCPzEjDGJgNLGBj3/hY0MPejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUrC06TE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922B8C4CEEB;
	Tue, 22 Jul 2025 06:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753164214;
	bh=D/8nQwpw1b4H3c6iBDsuwHR1cmui2Awzlsl6JSLf2cE=;
	h=From:To:Cc:Subject:Date:From;
	b=eUrC06TEQlGMy2kSlY2ON+CcOM15LY+UWEDecYscx6zBjbB1vWYLhf9hdZTosoff3
	 7z9uor+42noAHiZcLcXBcow+G6NmSlQm8Hs9CxzDrik6W9JSAlP7pazM/BegB3PuMR
	 LKNd+hgEWUY05EdZE9DgsFlZgUEKh8pa6BD2rYG54SF+lU7phQiDkexwSC0zfqDUIT
	 vFIF3Dh+4iSe+VGF2vdo3VWAcsLojbUdatKsj03CIS3GtDsnVK7z9uxpyT4iKg8bCx
	 Z1QW8FUIQT1v58OPndF/p9/SyXdf+W9NJ8tRoPJFQV9OotUz3PjFKjN+Ok3pxy5y3p
	 lzR1G/9jxqhFQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-stable] selftests/damon/sysfs.py: stop DAMON for dumping failures
Date: Mon, 21 Jul 2025 23:03:30 -0700
Message-Id: <20250722060330.56068-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4ece01897627 ("selftests/damon: add python and drgn-based DAMON
sysfs test") in mm-stable tree introduced sysfs.py that runs drgn for
dumping DAMON status.  When the DAMON status dumping fails for reasons
including drgn uninstalled environment, the test fails without stopping
DAMON.  Following DAMON selftests that assumes DAMON is not running when
they executed therefore fail.  Catch dumping failures and stop DAMON for
that case.

Fixes: 4ece01897627 ("selftests/damon: add python and drgn-based DAMON sysfs test") # mm-stable
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202507220707.9c5d6247-lkp@intel.com
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/damon/sysfs.py b/tools/testing/selftests/damon/sysfs.py
index 4ff99db0d247..dbf6613529bd 100755
--- a/tools/testing/selftests/damon/sysfs.py
+++ b/tools/testing/selftests/damon/sysfs.py
@@ -8,6 +8,10 @@ import subprocess
 import _damon_sysfs
 
 def dump_damon_status_dict(pid):
+    try:
+        subprocess.check_output(['which', 'drgn'], stderr=subprocess.DEVNULL)
+    except:
+        return None, 'drgn not found'
     file_dir = os.path.dirname(os.path.abspath(__file__))
     dump_script = os.path.join(file_dir, 'drgn_dump_damon_status.py')
     rc = subprocess.call(['drgn', dump_script, pid, 'damon_dump_output'],
@@ -31,6 +35,7 @@ def main():
     status, err = dump_damon_status_dict(kdamonds.kdamonds[0].pid)
     if err is not None:
         print(err)
+        kdamonds.stop()
         exit(1)
 
     if len(status['contexts']) != 1:

base-commit: 49c3f600a9088332b3c1a6db2dc6f3516f273609
-- 
2.39.5

