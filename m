Return-Path: <linux-kselftest+bounces-8663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC3D8ADF99
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3FC01C21605
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 08:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CD74EB24;
	Tue, 23 Apr 2024 08:21:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A272B9CA;
	Tue, 23 Apr 2024 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713860479; cv=none; b=F5m312cHtZBEe9vewIsdiVlP4U0yINNoZ2SgICQ1XAC6sb6HnP2J+24gWv9YCMb4jzRJg5jxq0PL3D6hwT9HCJd5rXQRLMSCQbg7Zf03YgSm6YWA9gPspInbzne8BLjlIgQ3DPKOJspPb342nqnHOFvObooORmYDFE+8vShtgfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713860479; c=relaxed/simple;
	bh=XR0D7pBSJ8zL0ehkLgrKl/VftX9RMVYquoldIGOgs6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OE4zhJ/Dkvi4aZR667EbDTSJ+tRNQtU1bF+EyQa0KlkBWMgIF0dBnVS9bXugLGiCVESg1iLTEjiXtmxK/G9DcEc/56rWUoCcANSoYe7nzekBEgPyo7ErWkvwAZN3Y4tb4k8UNbj9pOqJn5e53tJ8MMbSgmtb6Y6lr8fndrZ0EnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6ff26ee8014a11ef9305a59a3cc225df-20240423
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:654bd083-8eba-4279-a533-ecdf506ed35a,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:11
X-CID-INFO: VERSION:1.1.37,REQID:654bd083-8eba-4279-a533-ecdf506ed35a,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:11
X-CID-META: VersionHash:6f543d0,CLOUDID:45b6fc79502f8c3e69b1d2ea634563f1,BulkI
	D:240423162111G3G0W0VE,BulkQuantity:0,Recheck:0,SF:66|38|24|72|19|43|74|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 6ff26ee8014a11ef9305a59a3cc225df-20240423
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1541249360; Tue, 23 Apr 2024 16:21:08 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 9FB1BE000EB9;
	Tue, 23 Apr 2024 16:21:08 +0800 (CST)
X-ns-mid: postfix-66276F74-448055614
Received: from kernel.. (unknown [10.42.12.206])
	by mail.kylinos.cn (NSMail) with ESMTPA id ACA8DE000EB9;
	Tue, 23 Apr 2024 16:21:06 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: kunwu.chan@hotmail.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] kselftest: arm64: Add a null pointer check
Date: Tue, 23 Apr 2024 16:21:02 +0800
Message-Id: <20240423082102.2018886-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a 'malloc' call, which can be unsuccessful.
This patch will add the malloc failure checking
to avoid possible null dereference and give more information
about test fail reasons.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 tools/testing/selftests/arm64/tags/tags_test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/arm64/tags/tags_test.c b/tools/testi=
ng/selftests/arm64/tags/tags_test.c
index 5701163460ef..955f87c1170d 100644
--- a/tools/testing/selftests/arm64/tags/tags_test.c
+++ b/tools/testing/selftests/arm64/tags/tags_test.c
@@ -6,6 +6,7 @@
 #include <stdint.h>
 #include <sys/prctl.h>
 #include <sys/utsname.h>
+#include "../../kselftest.h"
=20
 #define SHIFT_TAG(tag)		((uint64_t)(tag) << 56)
 #define SET_TAG(ptr, tag)	(((uint64_t)(ptr) & ~SHIFT_TAG(0xff)) | \
@@ -21,6 +22,9 @@ int main(void)
 	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) =3D=3D=
 0)
 		tbi_enabled =3D 1;
 	ptr =3D (struct utsname *)malloc(sizeof(*ptr));
+	if (!ptr)
+		ksft_exit_fail_msg("Failed to allocate utsname buffer\n");
+
 	if (tbi_enabled)
 		tag =3D 0x42;
 	ptr =3D (struct utsname *)SET_TAG(ptr, tag);
--=20
2.40.1


