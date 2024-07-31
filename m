Return-Path: <linux-kselftest+bounces-14512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A37194270B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 08:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D6828474A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 06:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A909E16EB51;
	Wed, 31 Jul 2024 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FrtfgSzD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDED16D4CC;
	Wed, 31 Jul 2024 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407866; cv=none; b=YYjzKyAylTRnGuhnbVR4oL5Nb3zHvcDLk85NEHGfDu6550LiW6ZJMPyGEoXDjbmCfUlZecypKHA3vi4bk7MCx3Haoj77aNdDQCalLsVkZtBAPfd4M1xLP88Txcjt/iTPlx+YtHGeRicycfUNpGByCximhXXaY1shvpVYkP1r2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407866; c=relaxed/simple;
	bh=oGqGN98+teCVsumZkvZBF5tx4Nr+UtAmKTXVPhiWj54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pBdrNJZ6tOqdQbBxaeryFxUA24PeujiB2D0N4VLgiDrj7ufU23CKydacHgJBOyQg5kuirjliDOMunZwW/yxUgJ0HU8r4ve6/e76Zlupq3orT8qY2BCEaE3Sfwd+B2OSnbhLfeatOJMzy6OJfzpqbyAaCqV+xHLNsJMx8vC0FeXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FrtfgSzD; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7EC5CC0007;
	Wed, 31 Jul 2024 06:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722407857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ev28OYDmUbsqAmB9uXzO3SMs9tRUOMJ/SmpgfsPedY0=;
	b=FrtfgSzDzROgnSCe5sqP+VOBka5ja4MtGX7QdGkij6m/CyVc9Gvj6HKYkwn+/4fztGNqsA
	5QZ7O3Qb7wLskPuNvocvt3mpM5hu05HooADIUN7A8fpkjMS4qodoZVghWK6VxAk5cWRqLi
	qVRnjfCcGo1iHJlXGJaERNe9WF5QUQ6jh1L/8Qaby4N9X7Z+X75bX9+RXCQjlufXM06UEI
	a8K38/dPiJ/igPMfomMbSaowXiMq2cH14MpMzzYohqDBvaGttp90KTC/RRPhOBEzAsithu
	Xza3iyMGa81OoBMO4byeoZGrpYZO7Zv1zclRtuYAct09rQ0am5/lgm9SzDO9Fw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 31 Jul 2024 08:37:27 +0200
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: add wrong type test to
 cgroup dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240731-convert_dev_cgroup-v4-3-849425d90de6@bootlin.com>
References: <20240731-convert_dev_cgroup-v4-0-849425d90de6@bootlin.com>
In-Reply-To: <20240731-convert_dev_cgroup-v4-0-849425d90de6@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alan Maguire <alan.maguire@oracle.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: alexis.lothore@bootlin.com

Current cgroup_dev test mostly tests that device operation is accepted or
refused base on passed major/minor (and so, any operation performed during
test involves only char device)

Add a small subtest ensuring that the device type passed to bpf program
allows it to take decisions as well.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v4:
- update parameters to test both ret and errno

Changes in v3:
- reorganize subtests order

Changes in v2:
- change test name ("null" block device does not make sense)
- use updated subtest API for this new subtest
---
 tools/testing/selftests/bpf/prog_tests/cgroup_dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
index 8661e145ba84..5ab7547e38c0 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
@@ -114,6 +114,10 @@ void test_cgroup_dev(void)
 	if (test__start_subtest("deny-write"))
 		test_write("/dev/zero", buf, TEST_BUFFER_SIZE, -1, EPERM);
 
+	if (test__start_subtest("deny-mknod-wrong-type"))
+		test_mknod("/dev/test_dev_cgroup_block", S_IFBLK, 1, 3, -1,
+			   EPERM);
+
 cleanup_progs:
 	dev_cgroup__destroy(skel);
 cleanup_cgroup:

-- 
2.45.2


