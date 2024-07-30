Return-Path: <linux-kselftest+bounces-14469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB46A94116A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 14:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8231D1F245FE
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 12:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A54F1A0AEC;
	Tue, 30 Jul 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ue0KDVPQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB3199236;
	Tue, 30 Jul 2024 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722340777; cv=none; b=ARKDWxnUN7ASoAs78n/FtEvUqQtVa4FVUJHYxarOZ05cPEIctHtwi4IoQs23rSZd91dyT+Oz3aVLVuDoxI/Nkg084I0RZ8mgp8+FqjxMbBE7PmAQhstK4wMgqzL0Q0HsQRrixXDKcwA4luWAsZPCKgvbPc2B+yVFzMomk2VAKgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722340777; c=relaxed/simple;
	bh=blfpD6JycsdV+h4EONE6LESSi42nm2k7XWJCu8v4klA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MzUB+BmJpjvPa+VErDci8t3F34e7u6hg3fI5tDn99FheKekTMZEW3YjVaeNoy1bFc/NsGyiYp+9WIrs1M29L5p8aR2qL8dDaAOgpm29NZYDKUTGakMoHTDVZXRWL7os5jjsScr5cbuojVs7dCxMeWjXCJfAIwRgkGc1cyvpzVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ue0KDVPQ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4EDBF6000D;
	Tue, 30 Jul 2024 11:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722340768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q+FsiUGtRFMvWek86m/we3Ek0tw55BLWPkc+ISMCu+A=;
	b=Ue0KDVPQTjs5tuPtrRCcA1His6tLKVRjQ5Io7EserhQgUxZ4KuS2PObhpL/x2mCM1oPwCA
	lnmj8dW/JqRXQHS+CC3l7yOtI5uGQPAzQ/yXr87R2nMGLOKhtvYuKn3sRFc3fjLUgtA/7Q
	vEZhvT4DdS49xK6HOhyrcPGlEphNBWWCvL8hoTvb6H39OWPyHv844KZ/1nxVLJW32Tp5Lz
	+6iAMMzjDn7z/dMvlcAbpFL5vYgtValRUhvz9MhfD/O02SqGsOYLmrFTYxqoGCJl4EhXdh
	bT9SStYe20HOgcf92glxV/5X1lCAa+x+tl8Z3W6DkL+S5/mYEww9F5Ajg49+rg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Tue, 30 Jul 2024 13:59:13 +0200
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: add wrong type test to
 cgroup dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240730-convert_dev_cgroup-v3-3-93e573b74357@bootlin.com>
References: <20240730-convert_dev_cgroup-v3-0-93e573b74357@bootlin.com>
In-Reply-To: <20240730-convert_dev_cgroup-v3-0-93e573b74357@bootlin.com>
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
 Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org, 
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
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- reorganize subtests order

Changes in v2:
- change test name ("null" block device does not make sense)
- use updated subtest API for this new subtest
---
 tools/testing/selftests/bpf/prog_tests/cgroup_dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
index 62a2ca9a0b94..49c3d09ff259 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_dev.c
@@ -108,6 +108,9 @@ void test_cgroup_dev(void)
 	if (test__start_subtest("deny-write"))
 		test_write("/dev/zero", buf, TEST_BUFFER_SIZE, -EPERM);
 
+	if (test__start_subtest("deny-mknod-wrong-type"))
+		test_mknod("/dev/test_dev_cgroup_block", S_IFBLK, 1, 3, -EPERM);
+
 cleanup_progs:
 	dev_cgroup__destroy(skel);
 cleanup_cgroup:

-- 
2.45.2


