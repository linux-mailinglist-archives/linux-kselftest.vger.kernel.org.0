Return-Path: <linux-kselftest+bounces-35588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD51AE3358
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 03:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D9516EA17
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 01:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595F372624;
	Mon, 23 Jun 2025 01:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU/eD3/c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B743594E;
	Mon, 23 Jun 2025 01:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750642873; cv=none; b=LQgMXv8jU3vv5nJ7L2RK308KGLKSKGoQKowuPFOGNYRV05ea/pA7pXQyu+8Q2bLCoBbzICteJTl/kTIzJYYP0nTbzexy1pLnScQOZC2iralCrItW/3+Ds8RPr6fcf8V1/aCBHNWE16C/fjmT2Euo5907VrU7sR+hwmm70i4RZRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750642873; c=relaxed/simple;
	bh=GwUwxWdMp0XZ+wpJpAi6zlmRSeGSCHcbjbf16KjNBNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=auTA4TOBXTkZOy0ur21vwV2UKLI3vmZUCT+t+DbQ+6uS7S0mbmsdWYL0GYzXwGnxDJqr+ou40LoqYEHA8oxan28HUEWkawy4DIvhlAUR63twVWSbtAL0wZCGm3RTtwVkuWmjJPVdIyU6xGTTM8CpTl57pQzJkC2xvY7GL41vx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU/eD3/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9781C4CEF1;
	Mon, 23 Jun 2025 01:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750642872;
	bh=GwUwxWdMp0XZ+wpJpAi6zlmRSeGSCHcbjbf16KjNBNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jU/eD3/cUIQlnwfl7erFLn43vsy7aIdRMjlaKq2XYLgSa08Et+bcgYq7CM+siiln7
	 4XBHJ8X/yQghMW6PkHlkaIoW178oHbQ0gYW1LP1BK0kdWDbmnfGlsJlrMyd1o/GPhJ
	 mi90c2lbrGxzNsIRDZ298uftAUDb2vsmwr1wiDJ5lbqpB9ODn7tw7Z3nzDfiwMyTEy
	 z9uDm7u9Bb/bjhjpchxNg01OmGkbtL8IDEUfxWamKgvNq3ALxBs9uzsHipi11MjWYa
	 b+FXHpu9xFggh/eiaREN7F9M6XC+0e6RNRsglEXOHSeU4X0SEHyUpaYPhqVtsXiR4l
	 Us3bhpTDelC0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD028C7EE2E;
	Mon, 23 Jun 2025 01:41:12 +0000 (UTC)
From: Abhinav Saxena via B4 Relay <devnull+xandfury.gmail.com@kernel.org>
Date: Sun, 22 Jun 2025 19:41:08 -0600
Subject: [PATCH 2/2] selinux: add capability checks for TIOCSTI ioctl
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250622-toicsti-bug-v1-2-f374373b04b2@gmail.com>
References: <20250622-toicsti-bug-v1-0-f374373b04b2@gmail.com>
In-Reply-To: <20250622-toicsti-bug-v1-0-f374373b04b2@gmail.com>
To: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, selinux@vger.kernel.org, 
 Abhinav Saxena <xandfury@gmail.com>, kees@kernel.org, 
 linux-hardening@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750642871; l=1144;
 i=xandfury@gmail.com; s=20250614; h=from:subject:message-id;
 bh=9xfet8eJ550FD+VM4prV+To9hyXpve5cMIcZSM+Qk2A=;
 b=SQIsAKbA8SKDUapSB53NnqV1+vuTG67yN3OYPZcmhoo4CkyOtvXIDJQMRp85oqR4lSeRdKT33
 9NDAdlYpoPKANhU+NvIgbA2O4rLmWXT2mW9vzKhRmETKULSXGOPqSeK
X-Developer-Key: i=xandfury@gmail.com; a=ed25519;
 pk=YN6w7WNet8skqvMWxhG5BlAmtd1SQmo8If6Mofh4k44=
X-Endpoint-Received: by B4 Relay for xandfury@gmail.com/20250614 with
 auth_id=436
X-Original-From: Abhinav Saxena <xandfury@gmail.com>
Reply-To: xandfury@gmail.com

From: Abhinav Saxena <xandfury@gmail.com>

The TIOCSTI ioctl currently only checks the current process's
credentials, creating a TOCTOU vulnerability where an unprivileged
process can open a TTY fd and pass it to a privileged process via
SCM_RIGHTS.

Fix by requiring BOTH the file opener (file->f_cred) AND the current
process to have CAP_SYS_ADMIN. This prevents privilege escalation
while ensuring legitimate use cases continue to work.

Link: https://github.com/KSPP/linux/issues/156

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 security/selinux/hooks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 595ceb314aeb..a628551873ab 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3847,6 +3847,12 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 					    CAP_OPT_NONE, true);
 		break;
 
+	case TIOCSTI:
+		if (!file_ns_capable(file, &init_user_ns, CAP_SYS_ADMIN) ||
+		    !capable(CAP_SYS_ADMIN))
+			error = -EPERM;
+		break;
+
 	case FIOCLEX:
 	case FIONCLEX:
 		if (!selinux_policycap_ioctl_skip_cloexec())

-- 
2.43.0



