Return-Path: <linux-kselftest+bounces-8745-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 637A48AFE25
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 04:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189A91F23C14
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 02:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC688125C9;
	Wed, 24 Apr 2024 02:05:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4510949;
	Wed, 24 Apr 2024 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713924319; cv=none; b=XpVk5zoEUc472TLZ5EaPpeqcDn9wuSEeMvU4mZy3WjgQT0n9NJ+4GXNqB3jcvCUwWPTU6E3BLrPXF1RONOhTfCVnRjoadIOlyzLaySNtjh8KKzyTfgQxxVXjubptevQYsZXHbvDkwD3CGlyRSAuOY13VIiSC8v94hKu3XcGoe3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713924319; c=relaxed/simple;
	bh=9+4lZvu5vWzgsP23GS2HmJn+dGqfZr3DPqpn22bQwec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C3ZVr7XqtC0kh3LIqEyKHeoztGjBGGIxwcawolJ9lxxNDVo4WviP5jHWeuZBBo/blMjkyXHiqeN6uWwyWYREqLPKG9nS5DYicPkY1TA7+bK2PXCpo5apd0fOsEIgrY4CWne1LKFwQnYYygDTioFDfDMY+ejI/4eK5mzege/r0JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 14626d5e01df11ef9305a59a3cc225df-20240424
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:00bb5884-1e70-46a1-ac51-60fb1aa7f575,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:1
X-CID-INFO: VERSION:1.1.37,REQID:00bb5884-1e70-46a1-ac51-60fb1aa7f575,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6f543d0,CLOUDID:5d12c84477d2f1f51e1f0934456e5441,BulkI
	D:240424100512R7PQ4BJ4,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|43|74|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 14626d5e01df11ef9305a59a3cc225df-20240424
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1064384468; Wed, 24 Apr 2024 10:05:10 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id D700AE000EB9;
	Wed, 24 Apr 2024 10:05:09 +0800 (CST)
X-ns-mid: postfix-662868D5-666104372
Received: from kernel.. (unknown [10.42.12.206])
	by mail.kylinos.cn (NSMail) with ESMTPA id 4F068E000EBB;
	Wed, 24 Apr 2024 10:05:08 +0800 (CST)
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
Subject: [PATCH bpf-next 2/4] selftests/bpf/sockopt: Add a null pointer check for the run_test
Date: Wed, 24 Apr 2024 10:04:42 +0800
Message-Id: <20240424020444.2375773-3-chentao@kylinos.cn>
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
dereference and give more information
about test fail reasons.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/sockopt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt.c b/tools/tes=
ting/selftests/bpf/prog_tests/sockopt.c
index 5a4491d4edfe..bde63e1f74dc 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt.c
@@ -1100,6 +1100,12 @@ static int run_test(int cgroup_fd, struct sockopt_=
test *test, bool use_io_uring)
 		}
=20
 		optval =3D malloc(test->get_optlen);
+		if (!optval) {
+			log_err("Failed to allocate memory");
+			ret =3D -1;
+			goto close_sock_fd;
+		}
+
 		memset(optval, 0, test->get_optlen);
 		socklen_t optlen =3D test->get_optlen;
 		socklen_t expected_get_optlen =3D test->get_optlen_ret ?:
--=20
2.40.1


