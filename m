Return-Path: <linux-kselftest+bounces-22489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3A09D6ED2
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 13:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 995A5B21845
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 12:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E1A1AC44C;
	Sun, 24 Nov 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBayeVMt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE2C1DFE35;
	Sun, 24 Nov 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452141; cv=none; b=d18d5lH33TDnN4dfygD9V+PnXMlf7XYkpWcFOXXpaFmYWboGmLoBZMqXBUyLOXAdjvYSERkWkERn75Gj/brASYWoSo+Zu/Z4ToGgo+vw4x1tLP+T0AMfRpbxRb0TVmtxHotSYilpOypR4OOKhj3+2NmaBzvRH1/ppMvvWNOVcfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452141; c=relaxed/simple;
	bh=dStXZbOZ68pcA4OHVXBepn0T/jxDTGEotO0Yx2wAYpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQWA37CzSVe9u8wrrGlU9BeNxrH6UVl7Ggnz32kRuCrtRTXq9Lz88gXQ2s5yuQAUVbOu4d2+hxsD7Wf4hp0iF4JG+ci3b+HuV63dBfegtsfVwIbXgxbxi6Ws6Lz/+lk5jiNe6diw5O+l4zCak0cm0vNGR1RgXpyr/F/i9dVOviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBayeVMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37693C4CECC;
	Sun, 24 Nov 2024 12:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452141;
	bh=dStXZbOZ68pcA4OHVXBepn0T/jxDTGEotO0Yx2wAYpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bBayeVMtkjUiELPpvBOfDIG9iwsxIWqvX34DmIqw2KNGSht+uMdB9GySsdOqoHUsT
	 7xGopjCeK417X14P5jk6CC1tOoW9zyLN5k7vby4C8I8xsLsuchPe0OdZb/31aZyrJz
	 zaLHK09tBr2zzb8tuOBvIFVT1FW+6D6fcCsSXGtN8btgXL9oSTukcFV8qtLy70VFF+
	 jcfJKme/u5oPZPqYXRdrjkIZKgzEFvkVG8OapDORu/5rgxng9xUEWsXj+f+5K2bvOX
	 LVnaV8+I+rox3EQp3KTuYNlkJgvA1iHguvE9CwKxICOIP4c1oWdzkPUX69FvD/H89s
	 mToacOWdF+68w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	will@kernel.org,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 5/5] kselftest/arm64: Don't leak pipe fds in pac.exec_sign_all()
Date: Sun, 24 Nov 2024 07:42:04 -0500
Message-ID: <20241124124210.3337020-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124210.3337020-1-sashal@kernel.org>
References: <20241124124210.3337020-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
Content-Transfer-Encoding: 8bit

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 27141b690547da5650a420f26ec369ba142a9ebb ]

The PAC exec_sign_all() test spawns some child processes, creating pipes
to be stdin and stdout for the child. It cleans up most of the file
descriptors that are created as part of this but neglects to clean up the
parent end of the child stdin and stdout. Add the missing close() calls.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20241111-arm64-pac-test-collisions-v1-1-171875f37e44@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/arm64/pauth/pac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
index b743daa772f55..5a07b3958fbf2 100644
--- a/tools/testing/selftests/arm64/pauth/pac.c
+++ b/tools/testing/selftests/arm64/pauth/pac.c
@@ -182,6 +182,9 @@ int exec_sign_all(struct signatures *signed_vals, size_t val)
 		return -1;
 	}
 
+	close(new_stdin[1]);
+	close(new_stdout[0]);
+
 	return 0;
 }
 
-- 
2.43.0


