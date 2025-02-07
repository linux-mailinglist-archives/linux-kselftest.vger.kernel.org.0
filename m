Return-Path: <linux-kselftest+bounces-26024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5671FA2CBA3
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBE8188600C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 18:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8B51B4153;
	Fri,  7 Feb 2025 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozhpCKSM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FA31ABEC5;
	Fri,  7 Feb 2025 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953703; cv=none; b=bdGnRp+FW/tVq18ZN1kHCSfPTfuUh1G5tZNq67SYAfci8d/Sshp7Y2L8RTsp3/7rC1Ok1Dkto9kloz5oZREdh9DGRlcT4CV35YRqyZ5rlukpzYPP3nbl7QeLRR1lY3AcCU2KNYXVNhiBS20TJNAvY1VVQZEuQizAJVTKumlt90w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953703; c=relaxed/simple;
	bh=uVEl4T3KcMSW5xOCdxbkUhNrrPWbNFo+ziho0Yt4p0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEzcM1Drc4mF1q9UAl/eLtFglfRXu1WhYC2NOBizFabX2x7wVp6VHG2uZjmhmTAnwkRr3QCfuWbueHtGiyoeDgH++H+PNrxiHAdpKzQLSPApMU0zdFRh0JFKtrUeUcTwT7SIEHKQfM7AePPwdr9iQ2Gox8SZ5HoP7ATiciG3cLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozhpCKSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD42C4CEDF;
	Fri,  7 Feb 2025 18:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738953702;
	bh=uVEl4T3KcMSW5xOCdxbkUhNrrPWbNFo+ziho0Yt4p0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozhpCKSMH+lhp5bndlaWMElSJeYdKpHcO1iksgxaCadiRV9Y8sUkeQCW3thLwCYfo
	 SWrmNrL2SIuSd1OsEobkGF18invXt4MO2rnxS304TJDyV8gW9A/PbUqjyPJL6gutmF
	 Mhd47/Qb8u5g/cTuf8MTvos3RlXT59wiBjyxoxyI7PMhCL6E58lwxvGHQrZjk3zTgI
	 sRrQdu/N+D3IkWe8M3yHuCL8S/Yij5ewNBaZg+/P+LN9BbfwIseEPKJvLFHm8wuRFU
	 YPOays9w+Fgum0k7ofyzgBNx6OJNglWl37m6G3GIl16KTeDcGohZt111AiRB3QUOgI
	 NyRNTLLJUBJGg==
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
Subject: [PATCH net-next 2/2] selftests: drv-net: add helper for path resolution
Date: Fri,  7 Feb 2025 10:41:40 -0800
Message-ID: <20250207184140.1730466-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207184140.1730466-1-kuba@kernel.org>
References: <20250207184140.1730466-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refering to C binaries from Python code is going to be a common
need. Add a helper to convert from path in relation to the test.
Meaning, if the test is in the same directory as the binary, the
call would be simply: cfg.rpath("binary").

The helper name "rpath" is not great. I can't think of a better
name that would be accurate yet concise.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hw/csum.py    |  2 +-
 tools/testing/selftests/drivers/net/lib/py/env.py | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/csum.py b/tools/testing/selftests/drivers/net/hw/csum.py
index cb40497faee4..cd477f3440ca 100755
--- a/tools/testing/selftests/drivers/net/hw/csum.py
+++ b/tools/testing/selftests/drivers/net/hw/csum.py
@@ -100,7 +100,7 @@ from lib.py import bkg, cmd, wait_port_listen
     with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
         check_nic_features(cfg)
 
-        cfg.bin_local = path.abspath(path.dirname(__file__) + "/../../../net/lib/csum")
+        cfg.bin_local = cfg.rpath("../../../net/lib/csum")
         cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
         cases = []
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 2f17880e411d..886b4904613c 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -18,6 +18,18 @@ from .remote import Remote
         self.src_path = src_path
         self.env = self._load_env_file()
 
+    def rpath(self, path):
+        """
+        Get an absolute path to a file based on a path relative to the directory
+        containing the test which constructed env.
+
+        For example, if the test.py is in the same directory as
+        a binary (built from helper.c), the test can use env.rpath("helper")
+        to get the absolute path to the binary
+        """
+        src_dir = Path(self.src_path).parent.resolve()
+        return (src_dir / path).as_posix()
+
     def _load_env_file(self):
         env = os.environ.copy()
 
-- 
2.48.1


