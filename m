Return-Path: <linux-kselftest+bounces-8747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6738AFE2B
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 04:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E1D1C223DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 02:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CC812B72;
	Wed, 24 Apr 2024 02:05:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88FE1D54B;
	Wed, 24 Apr 2024 02:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713924323; cv=none; b=USKLLOHdN633SlgTpDDkF3jqrsm6LokVtRK6NWruKoW2FB3bSEisLqAbHecHOMYrtZLb49Vdbu8t3Ug1cRlLCgTBEovb63KI3zlnJbJ3cnx7o91BhQfaiEpCP8DdgQ8+B+z2vdbMICJdusJxa0DSxK6lO7TQ/x0oH5NzMytFTZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713924323; c=relaxed/simple;
	bh=bwn4NKPDjBjaNuo3yEiLyY1cpnHyL8Uv30pKNbsM170=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GBfluh9oMVOfsOd09Z76ead5oFPOhjsx42gQD8tqT+Ashtj4VCs6geH8VZzcDnnPhJgzLbfUz1PJ/arj+fbsZoubcu0s3ZmtJc7z6TOHVyPEcL2uLsmw1JBlEz8/s8tY0iQ8kjVoE9CXQBEP/033jDJUJTSPnpXHh6MVWi1QU3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 161efcb601df11ef9305a59a3cc225df-20240424
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:669ee238-3864-44f8-91ba-1556b251d4d0,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:1
X-CID-INFO: VERSION:1.1.37,REQID:669ee238-3864-44f8-91ba-1556b251d4d0,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6f543d0,CLOUDID:ae00a2f80363ef3acd4c7fc3192d941f,BulkI
	D:240424100515AGH5VMPW,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|43|74|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 161efcb601df11ef9305a59a3cc225df-20240424
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1332634441; Wed, 24 Apr 2024 10:05:13 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 8A546E000EB9;
	Wed, 24 Apr 2024 10:05:12 +0800 (CST)
X-ns-mid: postfix-662868D8-327764374
Received: from kernel.. (unknown [10.42.12.206])
	by mail.kylinos.cn (NSMail) with ESMTPA id 3B3DCE000EBB;
	Wed, 24 Apr 2024 10:05:11 +0800 (CST)
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
Subject: [PATCH bpf-next 4/4] selftests/bpf: Add a null pointer check for the serial_test_tp_attach_query
Date: Wed, 24 Apr 2024 10:04:44 +0800
Message-Id: <20240424020444.2375773-5-chentao@kylinos.cn>
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
 tools/testing/selftests/bpf/prog_tests/tp_attach_query.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/t=
ools/testing/selftests/bpf/prog_tests/tp_attach_query.c
index 655d69f0ff0b..302b25408a53 100644
--- a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
+++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
@@ -39,6 +39,9 @@ void serial_test_tp_attach_query(void)
 	attr.wakeup_events =3D 1;
=20
 	query =3D malloc(sizeof(*query) + sizeof(__u32) * num_progs);
+	if (CHECK(!query, "malloc()", "error:%s\n", strerror(errno)))
+		return;
+
 	for (i =3D 0; i < num_progs; i++) {
 		err =3D bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj[i],
 				    &prog_fd[i]);
--=20
2.40.1


