Return-Path: <linux-kselftest+bounces-32448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 004D4AAA5B4
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 01:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E796461C24
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 23:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C6F3184BB;
	Mon,  5 May 2025 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue1m/YGn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690543184B4;
	Mon,  5 May 2025 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484268; cv=none; b=cURzYjlbTQNRIbHpbdbNXJ/CVCCj996I6NPCZhQMzYgB1RROU9hUPEw7jad7ifR1gGLtsEFGNzR9FjoucaXw6zZCVcf+ocXG9TJGh1Eeqgkx+6J+Z2WsR5PSYh+pgeoqYGGCgsfi5Aaged3vdOfzbubU9yVWhtbcGUNxEIsD5cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484268; c=relaxed/simple;
	bh=UPa1F9dwsbvJiKHvgySynll1Z9gNX1kqCn63W5cWNTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mzc6IYXbUC7TOucTUQ+RvxRUjbh4yoLtAqHsfrJ5yUPkYlOydjgRZXx0RbVD4ziYK3FMpyM522ncurcrO6FObgh1xxrgeStXEGvFrXhDGYILyLQ4WYy7lwPKz1OVJzOvQzjYOg78rgGVSYviimQ58TRevIBXBkiPKgkEy1V08MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue1m/YGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBFAC4CEE4;
	Mon,  5 May 2025 22:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484267;
	bh=UPa1F9dwsbvJiKHvgySynll1Z9gNX1kqCn63W5cWNTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ue1m/YGnHOWumHgQyFAA+zIqyfE916mQxmSvAsU8dOLkep0BB8ySqxpdQUQ6zpQ5i
	 GI7BoOjXUVPx7BVXbBZM9wMEA3/PbeNV8DRzF2CdPyj+bt5wW/opW2U9sWmFYDgqKf
	 AjXOtjo5Nag1/fBfspQE3Je2PsU2qBOBJk+Gz4qsh2n5Ql9f9ld6DQXyv2o2/DKb0o
	 9Mkxu14t/aj0iR6yT5al3T0HoRNWze7hhoWBs9DwJkjk4VeUkvrCUypg8Qa/p512jM
	 3j3cyCmxo2BhLRpOp7sHTYO8d+Z5SMymgbk0irXNVQWRvWcjObZVpOAOiRIXakNc1J
	 t6zRnHrZKIV3Q==
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
Subject: [PATCH AUTOSEL 6.14 423/642] kunit: tool: Use qboot on QEMU x86_64
Date: Mon,  5 May 2025 18:10:39 -0400
Message-Id: <20250505221419.2672473-423-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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


