Return-Path: <linux-kselftest+bounces-19225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BCA994453
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 11:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05C87B213AF
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 09:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D3D15FD16;
	Tue,  8 Oct 2024 09:31:33 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC92178CDE;
	Tue,  8 Oct 2024 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379893; cv=none; b=S4lfWybvt5zehkfUh1+QC8lFA0mSJbUkO8jp209w/AtQxEm679kDnfi4ImGTdvRI9NuNTiQGjftV5WMTtG8Qsaemftjq+Vksnul+Td3G/9N1ZdJm74HaFP+aoR8pVEcBZweK+0j/2ol46YwCjxx4crBUqOcy3JhJNf5fectDszk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379893; c=relaxed/simple;
	bh=hB3RoqyCOXkdq0CTw/bAZqvS8ZisqK6n2N0uXXdFTns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UJF9yR9qPBsuQmDSEUGzFZnZDEkbnlxXPtfORMNYeAdmzAJvM/253XlNzPe51flqoYTNGR0aKmXECLUYut00utxNOmkkKLUG5iluMCRpHYZlbAXivtktfITOL2ohpdUlS2AMz/HxLomKn5Hz1FRZKoDL8VCvMWOkGlflpJSGnx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 145a79b2855811efa216b1d71e6e1362-20241008
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:772f6418-1f15-4df9-af9c-f661f62fdd48,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:8c76ffd2c683f21bbbff49623c3578f1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:1
	1|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 145a79b2855811efa216b1d71e6e1362-20241008
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <luyun@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 731839377; Tue, 08 Oct 2024 17:31:21 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 83E53B803C9E;
	Tue,  8 Oct 2024 17:31:21 +0800 (CST)
X-ns-mid: postfix-6704FBE9-429320306
Received: from localhost.localdomain (unknown [10.42.43.204])
	by node2.com.cn (NSMail) with ESMTPA id 0BB85B803C9B;
	Tue,  8 Oct 2024 09:31:20 +0000 (UTC)
From: Yun Lu <luyun@kylinos.cn>
To: jikos@kernel.org,
	bentiss@kernel.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftest: hid: add the missing tests directory
Date: Tue,  8 Oct 2024 17:31:20 +0800
Message-Id: <20241008093120.3081899-1-luyun@kylinos.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit 160c826b4dd0 ("selftest: hid: add missing run-hid-tools-tests.sh")
has added the run-hid-tools-tests.sh script for it to be installed, but
I forgot to add the tests directory together.

In fact, the run-hid-tools-tests.sh script uses the scripts in the tests
directory to run tests. The tests directory also needs to be added to be
installed.

Fixes: ffb85d5c9e80 ("selftests: hid: import hid-tools hid-core tests")
Cc: stable@vger.kernel.org
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 tools/testing/selftests/hid/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftes=
ts/hid/Makefile
index 38ae31bb07b5..662209f5fabc 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -18,6 +18,7 @@ TEST_PROGS +=3D hid-usb_crash.sh
 TEST_PROGS +=3D hid-wacom.sh
=20
 TEST_FILES :=3D run-hid-tools-tests.sh
+TEST_FILES +=3D tests
=20
 CXX ?=3D $(CROSS_COMPILE)g++
=20
--=20
2.27.0


