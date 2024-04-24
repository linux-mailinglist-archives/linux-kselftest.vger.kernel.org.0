Return-Path: <linux-kselftest+bounces-8743-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BD68AFE1F
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 04:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0A31C223AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 02:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1557DC8E1;
	Wed, 24 Apr 2024 02:05:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E981410949;
	Wed, 24 Apr 2024 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713924314; cv=none; b=pXTAjZDynhKRGSlInLS4FLU5m9vqZC7rDBFXXSm1RUniiQE8rhPh+UgdIQM2gaz6Wj23jgEWdJ+gvqiV01gBX7ZAytTXKzfdKZmZBExVspAP81FYE4P4M9FXP7TSIRZ9ww7BEBWdNmHjhH8SScFEAUxt4zlVXmI+5iKysDCqh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713924314; c=relaxed/simple;
	bh=HWk8bqCdTGq7ZzisQUJNedTQZAIFaoGPjyc75hwVvYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iGNKkyCnV37pGNymRQLlCDchLFmpzLLMWQGgn+ruqJeMKI8a7sFpt0pWDI3xBL4evUZrCLObocUqcpwHKRqYd61vWCfKHKUkdVF6u2yG4tL++XMejpmPIQLWbLWzkj/p35QMC71rtxHOKURDRxjmwkq8kiFGIp387hNi8tQYpRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0f80427a01df11ef9305a59a3cc225df-20240424
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:2c4376e7-2f56-446f-833e-1014fa3265d8,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:26
X-CID-INFO: VERSION:1.1.37,REQID:2c4376e7-2f56-446f-833e-1014fa3265d8,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:26
X-CID-META: VersionHash:6f543d0,CLOUDID:56ed42b85a0116404f01b644cf177da6,BulkI
	D:2404241005035YT5FWLN,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|43|74|10
	2,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 0f80427a01df11ef9305a59a3cc225df-20240424
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1560946763; Wed, 24 Apr 2024 10:05:02 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id AC35EE000EB9;
	Wed, 24 Apr 2024 10:05:01 +0800 (CST)
X-ns-mid: postfix-662868CD-387033370
Received: from kernel.. (unknown [10.42.12.206])
	by mail.kylinos.cn (NSMail) with ESMTPA id EE493E000EB9;
	Wed, 24 Apr 2024 10:04:57 +0800 (CST)
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
Subject: [PATCH bpf-next 0/4] Add some 'malloc' failure checks
Date: Wed, 24 Apr 2024 10:04:40 +0800
Message-Id: <20240424020444.2375773-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The "malloc" call may not be successful.Add the malloc=20
failure checking to avoid possible null dereference.

Kunwu Chan (4):
  selftests/bpf: Add some null pointer checks
  selftests/bpf/sockopt: Add a null pointer check for the run_test
  selftests/bpf: Add a null pointer check for the load_btf_spec
  selftests/bpf: Add a null pointer check for the
    serial_test_tp_attach_query

 tools/testing/selftests/bpf/prog_tests/sockopt.c         | 6 ++++++
 tools/testing/selftests/bpf/prog_tests/tp_attach_query.c | 3 +++
 tools/testing/selftests/bpf/test_progs.c                 | 7 +++++++
 tools/testing/selftests/bpf/test_verifier.c              | 2 ++
 4 files changed, 18 insertions(+)

--=20
2.40.1


