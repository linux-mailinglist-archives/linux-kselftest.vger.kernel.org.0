Return-Path: <linux-kselftest+bounces-32462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6445AAAB15D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 05:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5AF87AE784
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 03:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8EE3E9872;
	Tue,  6 May 2025 00:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJjfRM1B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276B727F75B;
	Mon,  5 May 2025 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485477; cv=none; b=hXt5i0I3GyjAh0Lut/gtVhluq8tSYXAkyCJgA6NgX0rLEapk0X6nPRWCygJUZVbsfpux7PooOIuxuljBnwTTA4U0W/QQtiH7PVuzPY9mF2OS93qEW9nCp86aRerllUe6l5M6GKWsjZ/U9+Mczvn6KIWhBzddb0kaE2aSu2lPmzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485477; c=relaxed/simple;
	bh=UPa1F9dwsbvJiKHvgySynll1Z9gNX1kqCn63W5cWNTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VvQdnvdcl6GYFtdkRfnhwML4O3GxoY/VbkR1CSgZaSW0Gj0IMepVrMze6HyYELt2KJHkDvICoAzxzghj6X1fqskoQg0kY28hG/HeBlI5H5jUsTYPy2a09MSNhrHx+jTjmJ/t0e8I1ezvFGznpIO3M7DxzJ4aRkxW6hn3rQ2yv2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJjfRM1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2CAC4CEE4;
	Mon,  5 May 2025 22:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485477;
	bh=UPa1F9dwsbvJiKHvgySynll1Z9gNX1kqCn63W5cWNTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJjfRM1BRESUq454zNpeUVHceyuGyFziKJuKUDIRvJuGNrghMhxlMWWqzA074QUQv
	 DsntemaiiN5kWZiS+bh2CJxxfEhioUqRCObbpeIYfM3aq1w24Dl2HmKDHCAUO29kEq
	 +u2wSPVE7A4DAwZ+GckNXNfW3Nlt2xK/Knmh6Fm3sKSplZmgydElP/ETS1E9gl53WA
	 nzoE6oCeuXmYTcQnyg9mBMT7DF4t+mDJ7m4sRtp5W2ghzM+OE/VD/TYBnd4sAkCUTw
	 677WtYhkVR/tUUHVoXrkFIvh603EZUNJPztpdnSMKPZ1lo5sUHgmis+xUB9SSyaQtx
	 nnZhhh1Jn3khg==
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
Subject: [PATCH AUTOSEL 6.12 334/486] kunit: tool: Use qboot on QEMU x86_64
Date: Mon,  5 May 2025 18:36:50 -0400
Message-Id: <20250505223922.2682012-334-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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


