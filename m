Return-Path: <linux-kselftest+bounces-8746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F33D8AFE28
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 04:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239701F236AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 02:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97521D53C;
	Wed, 24 Apr 2024 02:05:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE111A29A;
	Wed, 24 Apr 2024 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713924320; cv=none; b=RkgaVpEsES4o24+0xorzCALROqNRZHrg1VQHm2OlnARjmAUkHGIVAdW+SiuoDkBejnZOkOkkvpKVj/yOObr9CKjaYPtMJ4qkkGJZo3j9iWTAkPvVE+8+24yjw/cxWoWjhnQikUKWtdcY4wOCOOoqHPIR5o3OgTzZ5mFLUt6fzww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713924320; c=relaxed/simple;
	bh=ACgsItn8OBoe+YbzAGxCaUt5pzTAl9TfLFs6OvA0SL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VOV0CTSpDf4saBKlWJQFw2qQDcFdlLN/tA1R9dfaZZLUAscFqTYrHK3utHpt2nmem8ZLKPi1NalUvBH84spwzGlFLH6r51fqE1xUKmovOj00zIz5jL0+3aQ01ycPVNDQh/GeBYEHx3lG7QJ/IJthtr3Xzw0EjnVqwLR1poNPgDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 15347db201df11ef9305a59a3cc225df-20240424
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:85785f5e-63af-4590-bb1f-d09fd9974604,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:1
X-CID-INFO: VERSION:1.1.37,REQID:85785f5e-63af-4590-bb1f-d09fd9974604,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6f543d0,CLOUDID:4620fbdcf84b357a5ff4bb413a22bc27,BulkI
	D:240424100512622X49TE,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|43|74|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 15347db201df11ef9305a59a3cc225df-20240424
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1552464066; Wed, 24 Apr 2024 10:05:11 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 2FF86E000EB9;
	Wed, 24 Apr 2024 10:05:11 +0800 (CST)
X-ns-mid: postfix-662868D6-985344373
Received: from kernel.. (unknown [10.42.12.206])
	by mail.kylinos.cn (NSMail) with ESMTPA id E134CE000EBB;
	Wed, 24 Apr 2024 10:05:09 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	kunwu.chan@hotmail.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH bpf-next 3/4] selftests/bpf: Add a null pointer check for the load_btf_spec
Date: Wed, 24 Apr 2024 10:04:43 +0800
Message-Id: <20240424020444.2375773-4-chentao@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240424020444.2375773-1-chentao@kylinos.cn>
References: <20240424020444.2375773-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a 'malloc' call, which can be unsuccessful.
Add the malloc failure checking to avoid possible null
dereference.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 tools/testing/selftests/bpf/test_verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/=
selftests/bpf/test_verifier.c
index df04bda1c927..9c80b2943418 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -762,6 +762,8 @@ static int load_btf_spec(__u32 *types, int types_len,
 	);
=20
 	raw_btf =3D malloc(sizeof(hdr) + types_len + strings_len);
+	if (!raw_btf)
+		return -ENOMEM;
=20
 	ptr =3D raw_btf;
 	memcpy(ptr, &hdr, sizeof(hdr));
--=20
2.40.1


