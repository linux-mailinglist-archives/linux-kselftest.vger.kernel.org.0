Return-Path: <linux-kselftest+bounces-18544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4009893E6
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 10:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990CE1C210F2
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 08:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2362113D24C;
	Sun, 29 Sep 2024 08:55:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A954A0F;
	Sun, 29 Sep 2024 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727600149; cv=none; b=Ajrpu6LbvVS44oZ2TorknRzbdbA4rfZillnBE9rk7DITmctmY3o3YaF0xiYw0JTian24EC6+SP5J2ThEoRXihyMjjcz9sI+yFmu44a7x7/3AujxP16XJu5QvGSfPRbzDfVadtfFRHYW+BUEO5pCI+i/0dNyiD58gbdGOEybzii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727600149; c=relaxed/simple;
	bh=hgIL41XekUrpheEIxx8kga+/fiA1MkTSU39nA4z1k4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pihmR6rMHJ86rfFQvtgILkM6kV2nn8oOIJNXqjaoRnoKpP1poZfyxLZNIr1fMT4LCh7/d3OJ2VVYDTFC2aWYZYlodMi2zI0tb3TXB9m5mNX8QO2k4GtKXGvuDoZ8tEjKK7x97wybNcsDTaC6XnnvZHxRxZhldEmqE987L67Hqbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 994a7c7c7e4011efa216b1d71e6e1362-20240929
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:90f36ee4-61ae-4ecd-b89a-a6b6925d67e1,IP:0,U
	RL:0,TC:0,Content:43,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:68
X-CID-META: VersionHash:82c5f88,CLOUDID:d21530575f3cde40708adfc8d765e00e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:5,IP:nil,URL:11
	|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 994a7c7c7e4011efa216b1d71e6e1362-20240929
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <luyun@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1072278342; Sun, 29 Sep 2024 16:55:38 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 7F632B80758A;
	Sun, 29 Sep 2024 16:55:38 +0800 (CST)
X-ns-mid: postfix-66F9160A-398065142
Received: from localhost.localdomain (unknown [10.42.176.164])
	by node2.com.cn (NSMail) with ESMTPA id 05D53B80758A;
	Sun, 29 Sep 2024 08:55:37 +0000 (UTC)
From: Yun Lu <luyun@kylinos.cn>
To: jikos@kernel.org,
	bentiss@kernel.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftest: hid: add missing run-hid-tools-tests.sh
Date: Sun, 29 Sep 2024 16:55:49 +0800
Message-Id: <20240929085549.3528293-1-luyun@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The HID test cases actually run tests using the run-hid-tools-tests.sh
script. However, if installed with "make install", the run-hid-tools-test=
s.sh
script will not be copied over, resulting in the following error message.

  make -C tools/testing/selftests/ TARGETS=3Dhid install \
  	  INSTALL_PATH=3D$KSFT_INSTALL_PATH

  cd $KSFT_INSTALL_PATH
  ./run_kselftest.sh -c hid

selftests: hid: hid-core.sh
bash: ./run-hid-tools-tests.sh: No such file or directory

So add the run-hid-tools-tests.sh script to the TEST_FILES in the Makefil=
e.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 tools/testing/selftests/hid/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftes=
ts/hid/Makefile
index 72be55ac4bdf..38ae31bb07b5 100644
--- a/tools/testing/selftests/hid/Makefile
+++ b/tools/testing/selftests/hid/Makefile
@@ -17,6 +17,8 @@ TEST_PROGS +=3D hid-tablet.sh
 TEST_PROGS +=3D hid-usb_crash.sh
 TEST_PROGS +=3D hid-wacom.sh
=20
+TEST_FILES :=3D run-hid-tools-tests.sh
+
 CXX ?=3D $(CROSS_COMPILE)g++
=20
 HOSTPKG_CONFIG :=3D pkg-config
--=20
2.27.0


