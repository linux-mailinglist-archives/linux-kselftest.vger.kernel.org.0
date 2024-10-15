Return-Path: <linux-kselftest+bounces-19719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C294199E298
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 11:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECAF1F20F8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 09:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B913918991C;
	Tue, 15 Oct 2024 09:15:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01F418035;
	Tue, 15 Oct 2024 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983740; cv=none; b=ci1c0gjetrWNqpqw5yD+CfU6JdQ2vGLgddC4TCbbbjWjgya8SznyX6neTY9Zx8TkkeF8p6b+ogSY6/QqfT9qbZk84fH/KD6B1VLO4U8/UlCukopTEkiR8ldT2an7U2MjMBlHlKfWGPP3VbJQqv31x9ME/U5mrjQ+0L9IH24hky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983740; c=relaxed/simple;
	bh=CrfC+DKGXR7kRcsLQbFWSymUPaJylAZTT2Uka196tWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ioDC7ZjgAB+B5H1P/eZsIeUa3L9vqsRe3ATJrDgqMFAw4eHKBSP8Q0ppGw+zb4RllTmgyR07MBClHgUL6H5RrDloSZnfTWOycN9DjpK4jEf5mb2U1PxkBT0aiKMhTHmmoJCQt9ZIKRI/0W3RHo4wSORLmR0DDTPXwBnnry0XtNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 014c91068ad611efa216b1d71e6e1362-20241015
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:5ee77643-f18f-4553-a220-202d0346f11b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:9781bf6be741a4c27f4ab9224d50864e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:1
	1|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 014c91068ad611efa216b1d71e6e1362-20241015
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <luyun@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 199891051; Tue, 15 Oct 2024 17:15:22 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id EE8BFB8001A5;
	Tue, 15 Oct 2024 17:15:21 +0800 (CST)
X-ns-mid: postfix-670E32A9-8658841082
Received: from localhost.localdomain (unknown [10.42.43.204])
	by node2.com.cn (NSMail) with ESMTPA id 7A95EB8001A5;
	Tue, 15 Oct 2024 09:15:21 +0000 (UTC)
From: Yun Lu <luyun@kylinos.cn>
To: jikos@kernel.org,
	bentiss@kernel.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftest: hid: add the missing tests directory
Date: Tue, 15 Oct 2024 17:15:20 +0800
Message-Id: <20241015091520.2431150-1-luyun@kylinos.cn>
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

If running the test case without the tests directory,  will results in
the following error message:

    make -C tools/testing/selftests/ TARGETS=3Dhid install \
	    INSTALL_PATH=3D$KSFT_INSTALL_PATH
    cd $KSFT_INSTALL_PATH
    ./run_kselftest.sh -t hid:hid-core.sh

  /usr/lib/python3.11/site-packages/_pytest/config/__init__.py:331: Plugg=
yTeardownRaisedWarning: A plugin raised an exception during an old-style =
hookwrapper teardown.
  Plugin: helpconfig, Hook: pytest_cmdline_parse
  UsageError: usage: __main__.py [options] [file_or_dir] [file_or_dir] [.=
..]
  __main__.py: error: unrecognized arguments: --udevd
    inifile: None
    rootdir: /root/linux/kselftest_install/hid

In fact, the run-hid-tools-tests.sh script uses the scripts in the tests
directory to run tests. The tests directory also needs to be added to be
installed.

v2: add the error message

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


