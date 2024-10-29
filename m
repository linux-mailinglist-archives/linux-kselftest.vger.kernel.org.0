Return-Path: <linux-kselftest+bounces-20915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9079B454B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 10:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 493AAB212B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 09:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A6D20402D;
	Tue, 29 Oct 2024 09:07:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28242038D6;
	Tue, 29 Oct 2024 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192876; cv=none; b=WWtHm1H1aUCwyvQdM4VuwPGyfWVDJQkcN1KlA1GxG1F7/bnvEqnvh41h4dQVB3ccHOx+brcNRJLMQxOV6mSubE6Vd8EqH2GM5DhSZq55RjTJ45E/cpR/LIruwoSE2Gvk9qNMkR0+ojPvuQJE62gbN7ZRab8CpPwBBzHhNtdwCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192876; c=relaxed/simple;
	bh=M/C1cujMBoGsYQ+whXWiOHF+dXGjNS+U8F/EhMSfB74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fUHwonNS3jgKCS14HyP1P/mRGi823nEmwr7R5TVZWuEybdy00/zbtLrgJqMnD8CmUPHLgDBDh4zVcmlzQkQVP5/lX+RjURhMkO7A2yTDw5/WaU1xRND72RnIz6Z3+I6V0YNcDX594r4KXH0/9Y0SgQm4NgPNnN1ATFvspwaNN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 440c4a8695d511efa216b1d71e6e1362-20241029
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:54c2b0f6-89e5-443c-bac1-b75c49d9f6d9,IP:0,U
	RL:0,TC:0,Content:37,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:7
X-CID-META: VersionHash:82c5f88,CLOUDID:e5403f415e945219ad716e641d1b49f4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:2,IP:nil,URL:11
	|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SP
	R:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 440c4a8695d511efa216b1d71e6e1362-20241029
Received: from node2.com.cn [(10.44.16.197)] by mailgw.kylinos.cn
	(envelope-from <luyun@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2125861745; Tue, 29 Oct 2024 17:07:47 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 39D7CB807587;
	Tue, 29 Oct 2024 17:07:47 +0800 (CST)
X-ns-mid: postfix-6720A5E3-1226771029
Received: from localhost.localdomain (unknown [10.42.43.204])
	by node2.com.cn (NSMail) with ESMTPA id CB2A5B807587;
	Tue, 29 Oct 2024 09:07:46 +0000 (UTC)
From: Yun Lu <luyun@kylinos.cn>
To: jikos@kernel.org,
	bentiss@kernel.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftest/hid: increase timeout to 10 min
Date: Tue, 29 Oct 2024 17:07:46 +0800
Message-Id: <20241029090746.179108-1-luyun@kylinos.cn>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If running hid testcases with command "./run_kselftest.sh -c hid",
the following tests will take longer than the kselftest framework
timeout (now 200 seconds) to run and thus got terminated with TIMEOUT
error:

  hid-multitouch.sh - took about 6min41s
  hid-tablet.sh - took about 6min30s

Increase the timeout setting to 10 minutes to allow them have a chance
to finish.

Cc: stable@vger.kernel.org
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 tools/testing/selftests/hid/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/settings b/tools/testing/selftes=
ts/hid/settings
index b3cbfc521b10..dff0d947f9c2 100644
--- a/tools/testing/selftests/hid/settings
+++ b/tools/testing/selftests/hid/settings
@@ -1,3 +1,3 @@
 # HID tests can be long, so give a little bit more time
 # to them
-timeout=3D200
+timeout=3D600
--=20
2.27.0


