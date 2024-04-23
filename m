Return-Path: <linux-kselftest+bounces-8660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497DB8ADE66
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 09:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1EB1F22F5C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 07:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4234778B;
	Tue, 23 Apr 2024 07:40:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99AF1C698;
	Tue, 23 Apr 2024 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858006; cv=none; b=at++G8ZtfWYIqBY1JMys4xwmJleRpoHH3flAeRyW68LcWcGmiWokvZr7U3czgt6cd+IKofopS/vhcGqK3E5On+uKAC2imC9ed8DytHd9RyhS+5m2TLQ8yOOPRLpK1QMREjNDzPZbCKChhEKNa2xaGgzM6eSYARgJrbej5f4eIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858006; c=relaxed/simple;
	bh=rzVx5hdb3cC6FEK7gSAmvqgG85mYrv1Qkhiqvdrcdss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uf+uxSFgwx8IEwfrMi/zr74dfghyIPB9CaxcS2E1t54J5JXx+9x3uKlF1dwGC9zEU/30MJ+JZ1QyD6KcfYE5Jr/HDl3Sy88+7N0SPOrOAbAinavFDFZktjwspoRAdYyX1xREhhGKtYpB1cgyR3wQZU0/wJdEJQeEJvRjp7xGvbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ad145562014411ef9305a59a3cc225df-20240423
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:4bbdda0c-e953-4a54-846d-42af89c4638d,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:21
X-CID-INFO: VERSION:1.1.37,REQID:4bbdda0c-e953-4a54-846d-42af89c4638d,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:21
X-CID-META: VersionHash:6f543d0,CLOUDID:e2988424b0684b401761229020e6ac5d,BulkI
	D:240423153956Q8FATKAV,BulkQuantity:0,Recheck:0,SF:66|38|24|72|19|43|74|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: ad145562014411ef9305a59a3cc225df-20240423
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 748802077; Tue, 23 Apr 2024 15:39:54 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 3B691E000EB9;
	Tue, 23 Apr 2024 15:39:54 +0800 (CST)
X-ns-mid: postfix-662765CA-41198460
Received: from kernel.. (unknown [10.42.12.206])
	by mail.kylinos.cn (NSMail) with ESMTPA id 95C90E000EB9;
	Tue, 23 Apr 2024 15:39:53 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: seanjc@google.com,
	kunwu.chan@hotmail.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] KVM: selftests: Add 'malloc' failure check in test_vmx_nested_state
Date: Tue, 23 Apr 2024 15:39:52 +0800
Message-Id: <20240423073952.2001989-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a 'malloc' call in test_vmx_nested_state function, which can
be unsuccessful. This patch will add the malloc failure checking
to avoid possible null dereference and give more information
about test fail reasons.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test=
.c b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
index 67a62a5a8895..18afc2000a74 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
@@ -91,6 +91,7 @@ void test_vmx_nested_state(struct kvm_vcpu *vcpu)
 	const int state_sz =3D sizeof(struct kvm_nested_state) + getpagesize();
 	struct kvm_nested_state *state =3D
 		(struct kvm_nested_state *)malloc(state_sz);
+	TEST_ASSERT(state, "-ENOMEM when allocating kvm state");
=20
 	/* The format must be set to 0. 0 for VMX, 1 for SVM. */
 	set_default_vmx_state(state, state_sz);
--=20
2.40.1


