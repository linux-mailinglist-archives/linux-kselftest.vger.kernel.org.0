Return-Path: <linux-kselftest+bounces-39722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B8B32344
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE35E178D57
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 19:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E206F2D6612;
	Fri, 22 Aug 2025 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDQErY4P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43672D5C97;
	Fri, 22 Aug 2025 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892613; cv=none; b=GRUQSWq+sR6C7fN4rqO0Rh0Z1n5T30ifMoI5PBZr6oaxuXADxv5/G2YFzIM6z9ZrnrT/qUtwwOkFHPVAlizNPSccg3pFwH+y4DxcLF51yvBXAphnc+wt7TzcHTWIGDSfZKRwGG1S6zLgi1RyUhO4ZsJQ2cfut4Zqjxz9iHtzvEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892613; c=relaxed/simple;
	bh=KL9N4hH5JYplyP6vXIRSv7leMp7u9lx/sCTXKS9zSpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bVRIXNGTELjvPUFO9MpCG/piBRw4a9crPeblsMhF1l77sCnFdb/TMG3RDB0lkSRNxYCddmtNcSK4xwoAsuU7GIvjIFb6P8ZUtyM79UuwAUlXR9tZdZEluOYzmgNIQnNZdgAqdC29Ca5uU/sTVWxGOYZ1I3u3moiTyZLluviSxrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDQErY4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C5DC4CEED;
	Fri, 22 Aug 2025 19:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755892613;
	bh=KL9N4hH5JYplyP6vXIRSv7leMp7u9lx/sCTXKS9zSpo=;
	h=From:To:Cc:Subject:Date:From;
	b=LDQErY4PH7eD86pqi2nIic4k/iriQGa9FJIf9GnLOGuHWLQUHGeF78XC02baeaXen
	 1jScl5hTsVqyG42V85qIesjXL00L3xlisZFRu2JN0jkt6TZ9O/HFYmZfJ6mIWuH0Jz
	 8gjQbj+xZIWhZ2IqieJhoI+x6OUSo134ATw+eu1IpL6ZPsB0qTFosE8g0KsmCpLY8m
	 yc1FzY4/ktuJdW2SE9xksUIc7FVOZ9yt+3Je8+RwbT0g//UMXzwQQXQ1FaVxaUb47u
	 zErJSM2fDmJFX7iV/xEzgsQ+O8xzyOFE2NH+AwCUyibfqlSvWylgKNysCYCu5+LmA3
	 ShhxKTnwbM6Yg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] selftests: drv-net: xdp: make sure we're actually testing native XDP
Date: Fri, 22 Aug 2025 12:56:45 -0700
Message-ID: <20250822195645.1673390-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel tries to be helpful and attach the XDP program in generic
mode if the driver has no BPF ndo at all. Since the xdp.py tests
all have "native" in their names this can be quite confusing.
Force native / "drv" attachment. Note that netdevsim re-uses
the generic handler as its "native" handler, so we'll maintain
the test coverage of the generic mode that way. No need to test
both explicitly, I reckon.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/xdp.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index 35e9495cd506..08fea4230759 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -112,10 +112,10 @@ from lib.py import ip, bpftool, defer
     defer(ip, f"link set dev {cfg.remote_ifname} mtu 1500", host=cfg.remote)
 
     cmd(
-    f"ip link set dev {cfg.ifname} mtu {bpf_info.mtu} xdp obj {abs_path} sec {bpf_info.xdp_sec}",
+    f"ip link set dev {cfg.ifname} mtu {bpf_info.mtu} xdpdrv obj {abs_path} sec {bpf_info.xdp_sec}",
     shell=True
     )
-    defer(ip, f"link set dev {cfg.ifname} mtu 1500 xdp off")
+    defer(ip, f"link set dev {cfg.ifname} mtu 1500 xdpdrv off")
 
     xdp_info = ip(f"-d link show dev {cfg.ifname}", json=True)[0]
     prog_info["id"] = xdp_info["xdp"]["prog"]["id"]
-- 
2.50.1


