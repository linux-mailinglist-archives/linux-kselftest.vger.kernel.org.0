Return-Path: <linux-kselftest+bounces-32456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF3BAAAF71
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 05:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506C24A57D6
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 03:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35C73C10D8;
	Mon,  5 May 2025 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azLKdfLk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DCD2F10C7;
	Mon,  5 May 2025 23:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486706; cv=none; b=rnCrWA/GbdAaq7jP+/JFNsGakIU0ckcV2+mD6Yv92TK9ejYLwZQdnd9WFiEZPD8ZWGgasocG8nryDsLb5U2fCBX7Fxa1bKmv46xZbspLi8cY/DOaxhJ3u5ErCr99htz1eWXpFy0sWgOnXIB7/+77lOWVS2pi5yFgVw5wfUfgAms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486706; c=relaxed/simple;
	bh=UPa1F9dwsbvJiKHvgySynll1Z9gNX1kqCn63W5cWNTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R5js/EOaqT8qjNW+DoIzJlXHUEoeUPgu2UIdPiZSp6ZT4MguioflwCpojEaG7Sp8OL0hfo9h9RHhWrIbkWXdtYMcF2kwfyissrlN25Ed1hj93QfNVXvrtHuiQfdybg0LvmMLdGbcTc4cRuZD6fmrdQ/sQ83gR8bRDdhKahfZIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azLKdfLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299A1C4CEED;
	Mon,  5 May 2025 23:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486705;
	bh=UPa1F9dwsbvJiKHvgySynll1Z9gNX1kqCn63W5cWNTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azLKdfLk9J7ORLTggBuMDcEU127BMj/y5a0+x1dZJHHWYBCvq3i0BJ/dsAT/bgnaE
	 SBMwC4wm+WrekgvSxmLqSer4UX4LykAHcxSh/t7nVPyKpSDeYTR5gTxn74V8sFJDKm
	 /OWhJzozXdOh4ohru2J+fXDc8FeF1kpJ6DVRXQrYeHsOUjBGVZxSSbwmKNjyQtQspC
	 671DKcoyDvY92s346Xafepl0I3CsZ6eZqcQJ3X6eVP1t+dX0A7A1aDIlIMY2G760CJ
	 clPwPcXIqclR2Oyt03tCcINQaE3Ubs86WaE+zYUVATo6Jw9abIQLLO6EHQAUaPvw5Z
	 LTZYyZRO31rZw==
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
Subject: [PATCH AUTOSEL 6.1 162/212] kunit: tool: Use qboot on QEMU x86_64
Date: Mon,  5 May 2025 19:05:34 -0400
Message-Id: <20250505230624.2692522-162-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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


