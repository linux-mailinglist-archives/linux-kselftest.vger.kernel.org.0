Return-Path: <linux-kselftest+bounces-32469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C97AAB6E1
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 07:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3AE175788
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 05:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60067228CAD;
	Tue,  6 May 2025 00:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0GgqCMj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFBC281375;
	Mon,  5 May 2025 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486210; cv=none; b=tJTCkDbwjdWA2Sa9sULPmLkxEYaL3nXm4pEwea4J/iTjKbhbUfrtpILjtokP4SJ/6Riyb7uTaUijHycUr1PpHUJpOu64qgVzwZQaC25pdnFHyMk2dmq9r+/O61jiNH2J2LRfErqg8IVJeCjG99r7bD/DrUACrm2oHm2CLvO7hgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486210; c=relaxed/simple;
	bh=UPa1F9dwsbvJiKHvgySynll1Z9gNX1kqCn63W5cWNTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TwNLdP/dviexggH7zrK+AYgpwGhUeWV1OFjJqubSN+4xsgL7VWNKpE1HH+tF7gkbMfzsFSQ0UH5YjgnJVNEjhi7ZSlTyvybZEqjoF3l2XQODqd9FPmcVvSbYSPdQZiQxcwFNNWV1otKq70K3MgaeHFiOnp5vo7lh6ILDj0kb0zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0GgqCMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB9CC4CEED;
	Mon,  5 May 2025 23:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486209;
	bh=UPa1F9dwsbvJiKHvgySynll1Z9gNX1kqCn63W5cWNTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0GgqCMjUORhEqojg4EHhgHLSJl8W5UMIczZyRx4a+fsEXNoJ6c4/OtlqUlOtd8K5
	 1TKfKtgpcE7ss3AHnpYY0TzRAjFoRoOlVl7U48OHKRuqLSHnVRYVjDwyQ2TD7I424I
	 04xFduPo3RyzJpSgLme1Y0JAJsgpeVSgRObSmeZ64QC6xNNsJyZ4UrA+wFNa8XCAUH
	 5SmADyMg/gqk27xHuglmaWOJZxN/imD93b/qxvvc9EhWsPZgD6vYbPLABMNYCW5xq/
	 uAeAcIgTGgFvrGKvFe+IL/jKEJqVp7aJzKUgafZ0yPmFi+NNooj5Ht1EM/Dn9bTjjb
	 7PI0I8fKq5pTA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brendan Jackman <jackmanb@google.com>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	brendan.higgins@linux.dev,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH AUTOSEL 6.6 207/294] kunit: tool: Use qboot on QEMU x86_64
Date: Mon,  5 May 2025 18:55:07 -0400
Message-Id: <20250505225634.2688578-207-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Brendan Jackman <jackmanb@google.com>

[ Upstream commit 08fafac4c9f289a9d9a22d838921e4b3eb22c664 ]

As noted in [0], SeaBIOS (QEMU default) makes a mess of the terminal,
qboot does not.

It turns out this is actually useful with kunit.py, since the user is
exposed to this issue if they set --raw_output=all.

qboot is also faster than SeaBIOS, but it's is marginal for this
usecase.

[0] https://lore.kernel.org/all/CA+i-1C0wYb-gZ8Mwh3WSVpbk-LF-Uo+njVbASJPe1WXDURoV7A@mail.gmail.com/

Both SeaBIOS and qboot are x86-specific.

Link: https://lore.kernel.org/r/20250124-kunit-qboot-v1-1-815e4d4c6f7c@google.com
Signed-off-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/kunit/qemu_configs/x86_64.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/qemu_configs/x86_64.py b/tools/testing/kunit/qemu_configs/x86_64.py
index dc79490768630..4a6bf4e048f5b 100644
--- a/tools/testing/kunit/qemu_configs/x86_64.py
+++ b/tools/testing/kunit/qemu_configs/x86_64.py
@@ -7,4 +7,6 @@ CONFIG_SERIAL_8250_CONSOLE=y''',
 			   qemu_arch='x86_64',
 			   kernel_path='arch/x86/boot/bzImage',
 			   kernel_command_line='console=ttyS0',
-			   extra_qemu_params=[])
+			   # qboot is faster than SeaBIOS and doesn't mess up
+			   # the terminal.
+			   extra_qemu_params=['-bios', 'qboot.rom'])
-- 
2.39.5


