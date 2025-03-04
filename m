Return-Path: <linux-kselftest+bounces-28252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8B9A4F180
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 00:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A42E87A2634
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 23:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487AB1DDC14;
	Tue,  4 Mar 2025 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1orTscP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B20CBA2E;
	Tue,  4 Mar 2025 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741131129; cv=none; b=UAzrrEpbfrFsMHvx+88F1nERZQ4O4fljPa5w+9ela8gAmyV2PEUmwGVznUJpFhuBdUpAEnIT6RQQBq3s+JqDS+b36PxA6naYA91ivnVFPgnwX7STGPQy1hhHQBqTO4UzbaAu3PTOcFm8FGhL3nPTS3Qc1KDMDfVp71oskSO8oWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741131129; c=relaxed/simple;
	bh=2L+W7R4afieu7abrJdxxW7zV3XUTwESqGFo1uWZeXB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQtt20ZQP4AzthQEzIcxEVYHzR9WCKjAWbS2aIZjMjejUB/z1n/Le2+ExnC7hbp7uzEQsM47tWYbhPQF82SNb/V/JqZi7NRCGshEOxPzhBPym9wydBCkqD8TjXvYlPzX4Tfj5kt8/b2YCmBkgyjlx2OZzKG/zJHj7BplVLNEO1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1orTscP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9A1C4CEE5;
	Tue,  4 Mar 2025 23:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741131128;
	bh=2L+W7R4afieu7abrJdxxW7zV3XUTwESqGFo1uWZeXB4=;
	h=From:To:Cc:Subject:Date:From;
	b=D1orTscPmAyJ/ihrAmbOChoMutR1paDJzuKxnfb0IIV2hrLpKWmL1W+fDoFw1pxNK
	 XQvIzOmaB/ebi9kn1ljP1wh1jrK7eWJFM8h3NRkTVcFYhfCfQs+rq8xG+ALvYTaqB9
	 KrYjzSJbXtUSshrwKWXSKpf4mP1l6Jj9IiupwEWCHQ5x1x3JfmXm4itg8MmDKWKELq
	 lHjXgmXDlLtVXwf0GOLnIk31e3YdW4ybYZOwhfG8CtctEcFWnlLbk/RBzXDQuSigr+
	 fihT9IgS9xhTcl1Za/NGzeZQCbC31miFKIeqqEc6WwhYkn8Pyy7nGC6dd2co302sWP
	 cWjb6xw5qk4ug==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 1/2] selftests: net: fix error message in bpf_offload
Date: Tue,  4 Mar 2025 15:32:03 -0800
Message-ID: <20250304233204.1139251-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We hit a following exception on timeout, nmaps is never set:

    Test bpftool bound info reporting (own ns)...
    Traceback (most recent call last):
      File "/home/virtme/testing-1/tools/testing/selftests/net/./bpf_offload.py", line 1128, in <module>
        check_dev_info(False, "")
      File "/home/virtme/testing-1/tools/testing/selftests/net/./bpf_offload.py", line 583, in check_dev_info
        maps = bpftool_map_list_wait(expected=2, ns=ns)
      File "/home/virtme/testing-1/tools/testing/selftests/net/./bpf_offload.py", line 215, in bpftool_map_list_wait
        raise Exception("Time out waiting for map counts to stabilize want %d, have %d" % (expected, nmaps))
    NameError: name 'nmaps' is not defined

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
CC: bpf@vger.kernel.org
---
 tools/testing/selftests/net/bpf_offload.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/bpf_offload.py b/tools/testing/selftests/net/bpf_offload.py
index fd0d959914e4..4a9be8c49561 100755
--- a/tools/testing/selftests/net/bpf_offload.py
+++ b/tools/testing/selftests/net/bpf_offload.py
@@ -207,9 +207,11 @@ netns = [] # net namespaces to be removed
     raise Exception("Time out waiting for program counts to stabilize want %d, have %d" % (expected, nprogs))
 
 def bpftool_map_list_wait(expected=0, n_retry=20, ns=""):
+    nmaps = None
     for i in range(n_retry):
         maps = bpftool_map_list(ns=ns)
-        if len(maps) == expected:
+        nmaps = len(maps)
+        if nmaps == expected:
             return maps
         time.sleep(0.05)
     raise Exception("Time out waiting for map counts to stabilize want %d, have %d" % (expected, nmaps))
-- 
2.48.1


