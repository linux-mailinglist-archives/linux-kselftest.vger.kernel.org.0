Return-Path: <linux-kselftest+bounces-8659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 632568ADE58
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 09:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6D8AB20D5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 07:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD8B4778C;
	Tue, 23 Apr 2024 07:37:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6B147772;
	Tue, 23 Apr 2024 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713857861; cv=none; b=af8QeoZcAuyjtIw2DzBipd8qpGG3A6lfxLCKw910ns5I5Qzss5b0O3+TLE/bwYsT3Kh7xFcw4qWF8hhO93bOMTU0sjlMCLstcx9Vr/eWotGIYJFMJc7knMdVcnXhvcOV9pn+bqsL2sTPA9kM3JYBYLxAVmj++5eJJGe9HsXpIR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713857861; c=relaxed/simple;
	bh=xy1GcLvjBjJXjiL/7OVsqPvJYIeiFhB5hYNxFZjPnY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pqEKpSmAlKaJ/XubgGfmlnNnuR7nVe6/5ar98xjpV1EpaCnFozP71RWjZEtJ9dxyDD8KOe/W/qOHFyJ9ai03TbWikwSNh3qF60roJriXjscmqBMgs2zl/Ad4vMHIejp/sFlGuXUz4zTiEXDhNuc0bklql2dbYjSqJ4aLyvV2bJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 54a3e73a014411ef9305a59a3cc225df-20240423
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:5c1badbe-41c9-45d4-b027-0d1082d0c4ae,IP:20,
	URL:0,TC:0,Content:-5,EDM:-30,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-14
X-CID-INFO: VERSION:1.1.37,REQID:5c1badbe-41c9-45d4-b027-0d1082d0c4ae,IP:20,UR
	L:0,TC:0,Content:-5,EDM:-30,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-14
X-CID-META: VersionHash:6f543d0,CLOUDID:78bbcd68642dc5561833052310f5a086,BulkI
	D:240423153729G2ISWZO1,BulkQuantity:0,Recheck:0,SF:43|74|66|38|24|72|19|10
	2,TC:nil,Content:0,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 54a3e73a014411ef9305a59a3cc225df-20240423
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 942058463; Tue, 23 Apr 2024 15:37:26 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id D5712E000EB9;
	Tue, 23 Apr 2024 15:37:25 +0800 (CST)
X-ns-mid: postfix-66276535-657266450
Received: from kernel.. (unknown [10.42.12.206])
	by mail.kylinos.cn (NSMail) with ESMTPA id 235EEE000EB9;
	Tue, 23 Apr 2024 15:37:25 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: kunwu.chan@hotmail.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] KVM: selftests: Add 'malloc' failure check in config_name
Date: Tue, 23 Apr 2024 15:37:21 +0800
Message-Id: <20240423073721.2001016-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a 'malloc' call in config_name function, which can
be unsuccessful. This patch will add the malloc failure checking
to avoid possible null dereference and give more information
about test fail reasons.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 tools/testing/selftests/kvm/get-reg-list.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/get-reg-list.c b/tools/testing/s=
elftests/kvm/get-reg-list.c
index 91f05f78e824..22398696ffd6 100644
--- a/tools/testing/selftests/kvm/get-reg-list.c
+++ b/tools/testing/selftests/kvm/get-reg-list.c
@@ -66,6 +66,7 @@ static const char *config_name(struct vcpu_reg_list *c)
 		len +=3D strlen(s->name) + 1;
=20
 	c->name =3D malloc(len);
+	TEST_ASSERT(c->name, "-ENOMEM when allocating config name");
=20
 	len =3D 0;
 	for_each_sublist(c, s) {
--=20
2.40.1


