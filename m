Return-Path: <linux-kselftest+bounces-27946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A878A4A50E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 22:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A2B189BAFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 21:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA06D1D7E4F;
	Fri, 28 Feb 2025 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAJ8VCOy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA31D14FF;
	Fri, 28 Feb 2025 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740778198; cv=none; b=d0QcjR3FJuYds71APuUqJpYA6N3aG1jcYL4VRDoXI8QHxoh4OyWpI9MG9/iNyLiX0FTobFLy9DeVHvSVfzYjAbvtDebSVcQtxH3ZgFgfVbgkmHRe8WEkvkXAgPaVwUAcrAoBvud1XeJSnugR5Yke3NCfsI+ZuiZmdgprfC3BRMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740778198; c=relaxed/simple;
	bh=QVacNK0VfwGfBYgf6+cNqR3ILRAT0XnGeT1FfHRn84k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qgj1VCl7WwyGvEohNHX2Qb9/Wf9sNcfukLiPWCrxWotmewo2IVzmgA9jDDFtlt7vS/lCwX3Upk42wiIJxFKd5onBVU5699gcLrquKozOrsdMB4hu1gfN/FARKV9WPw/nejOoV5r5RhRWZ0lU52b79aSKmNcnFcQHq2kgLX0BcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAJ8VCOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE96BC4CED6;
	Fri, 28 Feb 2025 21:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740778198;
	bh=QVacNK0VfwGfBYgf6+cNqR3ILRAT0XnGeT1FfHRn84k=;
	h=From:To:Cc:Subject:Date:From;
	b=aAJ8VCOyUqwNiUR6QKk6vYa+tjp//zDE0SD/net1P0oW0eEO1XbheBAk9JdFw+OHc
	 yjNCrn8aqYQytRUlVL/WJH/gCZqHL4jb9HpDCvOkez8ihgwtgXw0REuJsfJ25Hcbqe
	 Djs46as1MR+TVNH4s5KiEBXo5IialDP/YCDX6J0u8aVz8QdidEyfK15I7XtMe27T6L
	 8NZFyCt0J/DlHRMI8YSc0Jl6aS+W77ddq/gaCWy095QByGHjUxMAx5kK4mmdgPu/82
	 67eKu0bq0YON0Ed3NUNvXmY06yCgwQV8RYIUf8DFR/+ceO2PKiYaW0hUHllD3WfwL8
	 0eCsS8C+oMLew==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] selftests: drv-net: use env.rpath in the HDS test
Date: Fri, 28 Feb 2025 13:29:55 -0800
Message-ID: <20250228212956.25399-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 29b036be1b0b ("selftests: drv-net: test XDP, HDS auto and
the ioctl path") added a new test case in the net tree, now that
this code has made its way to net-next convert it to use the env.rpath()
helper instead of manually computing the relative path.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/hds.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hds.py b/tools/testing/selftests/drivers/net/hds.py
index 873f5219e41d..7cc74faed743 100755
--- a/tools/testing/selftests/drivers/net/hds.py
+++ b/tools/testing/selftests/drivers/net/hds.py
@@ -20,8 +20,7 @@ from lib.py import defer, ethtool, ip
 
 
 def _xdp_onoff(cfg):
-    test_dir = os.path.dirname(os.path.realpath(__file__))
-    prog = test_dir + "/../../net/lib/xdp_dummy.bpf.o"
+    prog = cfg.rpath("../../net/lib/xdp_dummy.bpf.o")
     ip("link set dev %s xdp obj %s sec xdp" %
        (cfg.ifname, prog))
     ip("link set dev %s xdp off" % cfg.ifname)
-- 
2.48.1


