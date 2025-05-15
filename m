Return-Path: <linux-kselftest+bounces-33019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD76AB7CE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 07:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A762317B21C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 05:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC76518A6B0;
	Thu, 15 May 2025 05:19:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4E191;
	Thu, 15 May 2025 05:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747286343; cv=none; b=Uvp7ZxqQm96E8DUvzv+O48r7jiTPcxMXXAvlFsb4nEUAE/EfV0patcpGSw4CBbPIjfu3bpjbuCBlvUGqj/gCDqixfOEtkcHCa+sjIFbbDHjTTtx9d/gwZRt36eHyNCvoDDxpnQ8QWXXcz2ORNEC8xe+XgfycVw14R2IJjrHgzKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747286343; c=relaxed/simple;
	bh=erT2m2RCe594SyWJieK4gDZ7RUm81EIuXqR66BWQTUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i7DmbkRM65O23UYp+gSqoKe/421QxP7GDeYqRqLvURqTepJS1ZAQiQL0ySCkBxftU6DLONllT08O2B6C+GPfl5r1Qcr3HuNBZe8TWBtZy8KKPrK6vcVKfINzTG/kYWhwAiUqm99lGdzcBXrLsIht50L8n1PLgElPeiZhgD1nMrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 17f4e4cc314c11f0b29709d653e92f7d-20250515
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:534e0269-6ed7-48c9-b996-40d776c005f9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:b3f768056e03a57390a9c96ad151fc53,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 17f4e4cc314c11f0b29709d653e92f7d-20250515
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 641998143; Thu, 15 May 2025 13:18:53 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 91A3E16003841;
	Thu, 15 May 2025 13:18:53 +0800 (CST)
X-ns-mid: postfix-6825793D-31509332
Received: from localhost.localdomain (unknown [10.42.12.96])
	by node4.com.cn (NSMail) with ESMTPA id E7A3416003840;
	Thu, 15 May 2025 05:18:52 +0000 (UTC)
From: tanze <tanze@kylinos.cn>
To: catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tanze <tanze@kylinos.cn>
Subject: [PATCH] kselftest/arm64: Set default OUTPUT path when undefined
Date: Thu, 15 May 2025 13:18:39 +0800
Message-Id: <20250515051839.3409658-1-tanze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When running 'make' in tools/testing/selftests/arm64/ without explicitly
setting the OUTPUT variable, the build system will creates test
directories (e.g., /bti) in the root filesystem due to OUTPUT defaulting
to an empty string. This causes unintended pollution of the root director=
y.

This patch adds proper handling for the OUTPUT variable: Sets OUTPUT
to the current directory (.) if not specified

Signed-off-by: tanze <tanze@kylinos.cn>
---
 tools/testing/selftests/arm64/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selft=
ests/arm64/Makefile
index 22029e60eff3..c4c72ee2ef55 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -21,6 +21,8 @@ CFLAGS +=3D $(KHDR_INCLUDES)
=20
 CFLAGS +=3D -I$(top_srcdir)/tools/include
=20
+OUTPUT ?=3D $(CURDIR)
+
 export CFLAGS
 export top_srcdir
=20
--=20
2.25.1


