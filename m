Return-Path: <linux-kselftest+bounces-28417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF62A552A2
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 18:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C84618822F3
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 17:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796BC25A633;
	Thu,  6 Mar 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIN6gJSl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50141204C27;
	Thu,  6 Mar 2025 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281124; cv=none; b=LYEQSF0ikElqTOkwt8pyc+rtg+F7yOlffLKU7JHmo+OyxWxi9HZbI33DEBAJU91J6Ydy5KzDMnlXBlwfI6xJYxX34Pirzm1W3fCz1TNpT5YmMs2J+H1RI0uUb7ZGWdQQQ0Q/1WDKKLbiDBLl9X2wNQeVqANJ4nk2MTTQrJm/+Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281124; c=relaxed/simple;
	bh=0DHTwPG1prK5tVFv6X39ziG+G8/unYmRdaj84lGeqk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r9y+pLmONZe460/ppo2XyVNvBGZy+LHzkzCUl8jV0jK8IkrGV1JvW+rx+Vmr7t8kGGgi1/8DwZw4ai+Nnmcci8xu2g9ZpGAc8n3QIBmK+vc1l0TqMgRR4jh06cFtFnSsHI8B5/hQjOp8VycNHEjZJdgrdHPJgcTWreOe29hL+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIN6gJSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED2BC4CEE0;
	Thu,  6 Mar 2025 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741281123;
	bh=0DHTwPG1prK5tVFv6X39ziG+G8/unYmRdaj84lGeqk0=;
	h=From:To:Cc:Subject:Date:From;
	b=EIN6gJSlYv4BGPwNmkQoj2/1l2lLao9fZ5JfakacKDWlGk61DyAZ7+QDRwtkrVBq6
	 fvVwVMTRfFCMBVqHxyIAHgeueXsI6nBCKcLB0I5ewMua/r+nthMtI6sCvxEoZ89gQ1
	 5vLx1DEwI81DJW5Uy8eNi2QNsfqDHSYrEA+Mt8MlA1Oexpme57OUOygCKL8yKa6BOg
	 oF89fTeW5uiqUasemslucxQNQq2Bcr7Mp2Qthmo623W2q+zFf7Ili27Q3GGmakAkkh
	 mft5nNm7XaSNfxqpKHkcIUeHYIYIurypszitN0AZAFFKrGcXG/Iojmgeua6pK9OZ2N
	 m37uTpxYm5zXQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/2] selftests: drv-net: add path helper for net/lib
Date: Thu,  6 Mar 2025 09:11:57 -0800
Message-ID: <20250306171158.1836674-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looks like a lot of users of recently added env.rpath() actually
want to access stuff under net/lib. Add another helper.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hds.py        | 2 +-
 tools/testing/selftests/drivers/net/hw/csum.py    | 2 +-
 tools/testing/selftests/drivers/net/lib/py/env.py | 7 +++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
index 7cc74faed743..def44c10349a 100755
--- a/tools/testing/selftests/drivers/net/hds.py
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -20,7 +20,7 @@ from lib.py import defer, ethtool, ip
 
 
 def _xdp_onoff(cfg):
-    prog = cfg.rpath("../../net/lib/xdp_dummy.bpf.o")
+    prog = cfg.lpath("xdp_dummy.bpf.o")
     ip("link set dev %s xdp obj %s sec xdp" %
        (cfg.ifname, prog))
     ip("link set dev %s xdp off" % cfg.ifname)
diff --git a/tools/testing/selftests/drivers/net/hw/csum.py b/tools/testing/selftests/drivers/net/hw/csum.py
index 701aca1361e0..49ec98aef579 100755
--- a/tools/testing/selftests/drivers/net/hw/csum.py
+++ b/tools/testing/selftests/drivers/net/hw/csum.py
@@ -88,7 +88,7 @@ from lib.py import bkg, cmd, wait_port_listen
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
         check_nic_features(cfg)
 
-        cfg.bin_local = cfg.rpath("../../../net/lib/csum")
+        cfg.bin_local = cfg.lpath("csum")
         cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
         cases = []
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index fd4d674e6c72..2a1f8bd0ec19 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -30,6 +30,13 @@ from .remote import Remote
         src_dir = Path(self.src_path).parent.resolve()
         return (src_dir / path).as_posix()
 
+    def lpath(self, path):
+        """
+        Similar to rpath, but for files in net/lib TARGET.
+        """
+        lib_dir = (Path(__file__).parent / "../../../../net/lib").resolve()
+        return (lib_dir / path).as_posix()
+
     def _load_env_file(self):
         env = os.environ.copy()
 
-- 
2.48.1


