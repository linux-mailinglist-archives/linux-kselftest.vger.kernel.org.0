Return-Path: <linux-kselftest+bounces-4632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B107B85496F
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 13:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9D21F243B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 12:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36329524C9;
	Wed, 14 Feb 2024 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b="jCkm6hBA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [129.187.255.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0BD22626;
	Wed, 14 Feb 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914515; cv=none; b=EB4fT8dWtBcFCQq0rE2IpwulrcBlCAVZQib9JhRCVORlbycp6MsYFznlApvvVLSyAkiVRRxbmyUcu9kMiLT02gj7YH40koTRrKX7V3SFQzQGRIeprdxjJ31Sne08VOKMK5nVbOUhqAG/Mhyf03Jx/Vjt3CLRat7i/0gHuYUowf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914515; c=relaxed/simple;
	bh=+EUUACJwNj0bXAgQ+8GQThIgivD8jBsEM0i2kqiLRwY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=l+qDiNajiaMVY37ftQj5F5MrRJmIsK+IraIF36ruIKKRaBdCygNs9bb0bsHOuiEiTjz4nmTB39Y3BufMj66ItJmhE+ivrjjQ45cCjs9/R5LGvanm3wUbNAH4Q2no4qNSqGM460gc4yTlabW19OzEUoE//qWEy//h7sz/UtR0Etk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de; spf=pass smtp.mailfrom=tum.de; dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b=jCkm6hBA; arc=none smtp.client-ip=129.187.255.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
	by postout2.mail.lrz.de (Postfix) with ESMTP id 4TZd9b6ncSzyQl;
	Wed, 14 Feb 2024 13:41:39 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
	reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=tu-postout21; t=1707914499; bh=+EUUACJwNj0
	bXAgQ+8GQThIgivD8jBsEM0i2kqiLRwY=; b=jCkm6hBAGikTb7WTBbUgWqzy6+n
	MsU6lh8LMf1BCN9aH1xVbcH/sFPSBiQop0SsmjtM5kaa2KtqVuTdQzaH7+UKcBti
	UYgXAEs4yn6t7PtVqE2DyL3Hgeb95O9WASOIqeH2sCluXDjHGV8cZcFS0OtaYEfR
	1QuI+8UfinrKRCbac2fhqtE98tV5zC7cfRETITUmcBNzMAybCcT5jpH+I7Ayh1y9
	igQsXtpwQh8aZtD2t8f+HkIyROc7yn9VCgnG+2pxhSxBJ76t4Kj15khxwPxVcS5q
	fzBll2eylnTAsjnBgn/r5Hy0qk1jkQARZ0Ngh0PqocArdBiY0+/v+KRAVjA==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.885
X-Spam-Level:
Received: from postout2.mail.lrz.de ([127.0.0.1])
	by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
	with LMTP id RoFk6-aGmlmz; Wed, 14 Feb 2024 13:41:39 +0100 (CET)
Received: from sienna.fritz.box (ppp-93-104-85-184.dynamic.mnet-online.de [93.104.85.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4TZd9Z5vmmzyRs;
	Wed, 14 Feb 2024 13:41:38 +0100 (CET)
From: =?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>,
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC] kunit: tool: add 'mte=on' qemu arg on arm64
Date: Wed, 14 Feb 2024 12:41:30 +0000
Message-Id: <20240214124131.990872-1-paul.heidekrueger@tum.de>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

I was running some KASan tests with kunit.py recently and noticed that
when KASan is run in hw tags mode, we manually have to add the required
`mte=on` option to kunit_tool's qemu invocation, as the tests will
otherwise crash.

To make life easier, I was looking into ways for kunit.py to recognise
when MTE support was required and set the option automatically.

All solutions I could come up with for having kunit_tool conditionally
pass `mte=on` to qemu, either entailed duplicate code or required
parsing of kernel's config file again. I was working under the
assumption that only after configuring the kernel we would know whether
the 'mte=on' option was necessary, as CONFIG_ARM64_MTE is not visible
before.

Only afterwads did I realise that the qemu arm64 config that kunit_tool
falls back on, uses the `virt` machine, which supports MTE in any case.
So, could it be as easy as just adding the `mte=on` option to
kunit_tool's arm64 config? Would this be a welcome addition? 

What do you think? 

Many thanks,
Paul

Signed-off-by: Paul Heidekrüger <paul.heidekrueger@tum.de>
---
 tools/testing/kunit/qemu_configs/arm64.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/qemu_configs/arm64.py b/tools/testing/kunit/qemu_configs/arm64.py
index d3ff27024755..a525f7e1093b 100644
--- a/tools/testing/kunit/qemu_configs/arm64.py
+++ b/tools/testing/kunit/qemu_configs/arm64.py
@@ -9,4 +9,4 @@ CONFIG_SERIAL_AMBA_PL011_CONSOLE=y''',
 			   qemu_arch='aarch64',
 			   kernel_path='arch/arm64/boot/Image.gz',
 			   kernel_command_line='console=ttyAMA0',
-			   extra_qemu_params=['-machine', 'virt', '-cpu', 'max,pauth-impdef=on'])
+			   extra_qemu_params=['-machine', 'virt,mte=on', '-cpu', 'max,pauth-impdef=on'])
-- 
2.40.1


