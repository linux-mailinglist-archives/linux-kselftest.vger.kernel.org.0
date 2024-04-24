Return-Path: <linux-kselftest+bounces-8744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D69D8AFE22
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 04:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBFD1F23357
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 02:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A204101F2;
	Wed, 24 Apr 2024 02:05:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AB814A85;
	Wed, 24 Apr 2024 02:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713924317; cv=none; b=qBZf3RxAUns2q5lcukJmfhkOALZ0aHIeLcGuP6x+z8vTmZDVSf2db7zAftlq6ZFLpR/3YDRgcSTxh6sm1LoUkOFYBDxoNfUuRF6cx0xHe55f+HbwL8GUZYPPUJSQnePJuLpgJ9gmxw/D23Va/6frImTUlQct1sdmdrw7nJ2hx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713924317; c=relaxed/simple;
	bh=Qe4fEgUEo3+K/fSX70/eljtbReR8vF46tYGBSXlXNfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TW60bW4f9B2obhQ7k30FcP73oFrtyUujqv8sANezR/wQoioRmltFKyj8026f3AxiJ5hWiZr9B/dZ9Uuj2sTehAHEQmlx63jqju6FG5QtVwleSw7lyEzylOGar5Lc59QB5Ryp1ZNJhr9vabEz82Evv18isfvrMZhPpWRGcnpDqGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 136d7d4401df11ef9305a59a3cc225df-20240424
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:ebc7a3ea-3fa6-4c1c-b0d1-8099f7a2579d,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:26
X-CID-INFO: VERSION:1.1.37,REQID:ebc7a3ea-3fa6-4c1c-b0d1-8099f7a2579d,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:26
X-CID-META: VersionHash:6f543d0,CLOUDID:d2eee06c9caf1db563cfda8d4a13907c,BulkI
	D:240424100509SL2PSHQB,BulkQuantity:0,Recheck:0,SF:19|43|74|66|38|24|17|10
	2,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 136d7d4401df11ef9305a59a3cc225df-20240424
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1546720597; Wed, 24 Apr 2024 10:05:08 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 44F9FE000EB9;
	Wed, 24 Apr 2024 10:05:08 +0800 (CST)
X-ns-mid: postfix-662868D4-48137371
Received: from kernel.. (unknown [10.42.12.206])
	by mail.kylinos.cn (NSMail) with ESMTPA id EBFF1E000EB9;
	Wed, 24 Apr 2024 10:05:06 +0800 (CST)
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
Subject: [PATCH bpf-next 1/4] selftests/bpf: Add some null pointer checks
Date: Wed, 24 Apr 2024 10:04:41 +0800
Message-Id: <20240424020444.2375773-2-chentao@kylinos.cn>
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
This patch will add the malloc failure checking
to avoid possible null dereference.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 tools/testing/selftests/bpf/test_progs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 89ff704e9dad..ecc3ddeceeeb 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -582,6 +582,11 @@ int compare_stack_ips(int smap_fd, int amap_fd, int =
stack_trace_len)
=20
 	val_buf1 =3D malloc(stack_trace_len);
 	val_buf2 =3D malloc(stack_trace_len);
+	if (!val_buf1 || !val_buf2) {
+		err =3D -ENOMEM;
+		goto out;
+	}
+
 	cur_key_p =3D NULL;
 	next_key_p =3D &key;
 	while (bpf_map_get_next_key(smap_fd, cur_key_p, next_key_p) =3D=3D 0) {
@@ -1197,6 +1202,8 @@ static int dispatch_thread_send_subtests(int sock_f=
d, struct test_state *state)
 	int subtest_num =3D state->subtest_num;
=20
 	state->subtest_states =3D malloc(subtest_num * sizeof(*subtest_state));
+	if (!state->subtest_states)
+		return -ENOMEM;
=20
 	for (int i =3D 0; i < subtest_num; i++) {
 		subtest_state =3D &state->subtest_states[i];
--=20
2.40.1


