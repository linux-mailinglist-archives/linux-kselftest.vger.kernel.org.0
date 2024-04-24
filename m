Return-Path: <linux-kselftest+bounces-8819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB27E8B15F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 00:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283CF1C2120C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 22:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AF216192C;
	Wed, 24 Apr 2024 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XStIbT7A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB42D1607A2;
	Wed, 24 Apr 2024 22:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996891; cv=none; b=BVrd4whN7efM+3p5rxLtqFQkcHv98G2G14/JqS+t9pXeAILf6dgJ9iFaYQz979sToquzJu0xPNE1ChjU8uz+znamntiE2L/iXwaSeGktsORuJvYv7PlUSAu1+dTTgWZgDZHUCXSkyC6TtesR3Nw4wtBSWtGbMWdnaX1HTiKAssg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996891; c=relaxed/simple;
	bh=d133gvW+7UN3UO7wVGaiUVGARPF1yuYlLI+me49dJRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yrc7rMTO4YLLmCluOUI2jvf9SP88jvcqc+xE3IOkecCH4gho9ciNN7V7z2j7ied8YAwWAOvxydoChwduXkPslRBZyWHKrOh6gaMfkd/HOZhBVVnnc4Ck59ZxhsXg4Y1/YaLJkPgoVIqhN0lFor01mbZ6p31TSukElUzAfVtgfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XStIbT7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13380C2BD11;
	Wed, 24 Apr 2024 22:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713996891;
	bh=d133gvW+7UN3UO7wVGaiUVGARPF1yuYlLI+me49dJRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XStIbT7AVplOlW2HjbSHqNweFrj1bwHaXq6MFdQZzpbPlV0nRw7iWPdo9c+S9DOXe
	 AhTroAT6J8Ne6IOTvADR0zGzKBCX0cu1l8XXywMRw6eWooiXaya88UW8TD3swpRSML
	 dTtXuSOtYyCCpKcOB1BcXnQbszZR4sFP9KK9TRfj2yckHVgm8ToVZW95T2KNvmMU3l
	 n0/JHXkm5WeAyHR43/olCP2oOQPXnyYdAKHR+wiaTBT8KGODB6Y6T7+qVFCgG+9177
	 srXh633I/XZbnElc7LwXyvNQ7xmSOdZqi17OukreEaeR/3gECHqC2GQIFNSI/+NIk9
	 mX+urfg+zERqA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/4] selftests: drv-net: force pseudo-terminal allocation in ssh
Date: Wed, 24 Apr 2024 15:14:41 -0700
Message-ID: <20240424221444.4194069-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424221444.4194069-1-kuba@kernel.org>
References: <20240424221444.4194069-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is not yet needed, because we don't terminate remote background
commands. But once we do, if we run ssh without -t the ssh session
may close and the program may carry on happily running.

I have hit this problem experimenting with mausezahn, let's fix
it already to avoid someone else wasting time debugging it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/lib/py/remote_ssh.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py b/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
index 924addde19a3..294a4ed8284e 100644
--- a/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
+++ b/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
@@ -20,7 +20,7 @@ from lib.py import cmd
             self._tmpdir = None
 
     def cmd(self, comm):
-        return subprocess.Popen(["ssh", "-q", self.name, comm],
+        return subprocess.Popen(["ssh", "-t", "-q", self.name, comm],
                                 stdout=subprocess.PIPE, stderr=subprocess.PIPE)
 
     def _mktmp(self):
-- 
2.44.0


