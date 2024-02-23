Return-Path: <linux-kselftest+bounces-5380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAEA861E85
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 22:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F66E1C2415C
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 21:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6CF143C7B;
	Fri, 23 Feb 2024 21:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b="lqcI7ndp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from postout1.mail.lrz.de (postout1.mail.lrz.de [129.187.255.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2952813DBA8;
	Fri, 23 Feb 2024 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.187.255.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722489; cv=none; b=Ifnovl97S5zN7iEAInHuZA1VB2or+Xohwv25W5D+rJ5VWoI27PZ55OntWm6fzro4LbmUgKWDBE973UR5epFy4firpUnbWWS6o4rYqHSsfLK5KDX6y81qyL2NdabPWLUoKSn4R2lminnJR1AdW0kNhrWoBsCsaiaSBQOgVUlhnkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722489; c=relaxed/simple;
	bh=3KpG0dZ2XwIzgEmxU5O4a/+aCHGJPy0nYK74PrTcq4k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQMtU1EkkMBkZurAfINLznURvko8IN3DyuxFgMMXooedAmhRH+1zdUGLJCkoOc3RbJF1P3k6PSjJxl3LE6dr8HmM/WyQZnogUiFtQiHBOs+LLEeXWH8VRJzcT48XSYnELuHFJx4xQT6wp6fhwTsYy3cjs2FUx7C72MJMEw673dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de; spf=pass smtp.mailfrom=tum.de; dkim=pass (2048-bit key) header.d=tum.de header.i=@tum.de header.b=lqcI7ndp; arc=none smtp.client-ip=129.187.255.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tum.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tum.de
Received: from lxmhs51.srv.lrz.de (localhost [127.0.0.1])
	by postout1.mail.lrz.de (Postfix) with ESMTP id 4ThMzm6xYbzyV0;
	Fri, 23 Feb 2024 22:08:04 +0100 (CET)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
	reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:from:from:received:received; s=tu-postout21; t=
	1708722484; bh=3KpG0dZ2XwIzgEmxU5O4a/+aCHGJPy0nYK74PrTcq4k=; b=l
	qcI7ndpcpImO91fsKaGXkVs8bCQLaP8BEly4fKPXv6Y/Nw0fdKZStOkKpRs95lFS
	EeJ3Vvw6BM7RLTfV0ZFOUBWSK515nzHyPbof39cEivQoCNpfJhmlYBPx8pNt8Weo
	WUPnHljlkmqlGbi4bRQqx71A/93qpCVyVUwvIDch8CvK2KO9QkY+VzDsKfUq2bcK
	0evbzDTSRGy7Ze+U/t2kv0Vzee9NWkVFDtP+VRCXxXhyzx3AW4aZR2r4yelvbZ3L
	ZeEcFB8aD6+dNIrJKI1uJMYxjOnDik+pNCTIeFt3d18xeIFW1bhdhoJxLxKhdcJh
	Z2u/znYJWyQxLmY/+n1Rg==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs51.srv.lrz.de
X-Spam-Flag: NO
X-Spam-Score: -2.882
X-Spam-Level:
Received: from postout1.mail.lrz.de ([127.0.0.1])
	by lxmhs51.srv.lrz.de (lxmhs51.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
	with LMTP id 9idYgrUY4grQ; Fri, 23 Feb 2024 22:08:04 +0100 (CET)
Received: from sienna.fritz.box (ppp-93-104-78-78.dynamic.mnet-online.de [93.104.78.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by postout1.mail.lrz.de (Postfix) with ESMTPSA id 4ThMzl5qNlzyTg;
	Fri, 23 Feb 2024 22:08:03 +0100 (CET)
From: =?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Paul=20Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] kunit: tool: add 'mte=on' qemu arg on arm64
Date: Fri, 23 Feb 2024 21:07:58 +0000
Message-Id: <20240223210759.2431454-1-paul.heidekrueger@tum.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CABVgOS=n0rCS6ecAAh7BKkZbQQJu7ZHNrMJhkFGDqDG_n-U9bQ@mail.gmail.com>
References: <CABVgOS=n0rCS6ecAAh7BKkZbQQJu7ZHNrMJhkFGDqDG_n-U9bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Tests relying on the ARM Memory Tagging Extension (MTE) may crash when
the corresponding qemu option, which is available since qemu 6.2, is not
explicitly passed to kunit_tool via the command line.

To make life easier, enable MTE by default for kunit_tool's arm64
qemu config.

Link: https://lore.kernel.org/all/20240214124131.990872-1-paul.heidekrueger@tum.de/T/#u
Reviewed-by: David Gow <davidgow@google.com>
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


