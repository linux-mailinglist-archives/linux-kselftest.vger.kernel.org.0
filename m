Return-Path: <linux-kselftest+bounces-14232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D62E93C35A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 15:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F43283149
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 13:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E924119B5BE;
	Thu, 25 Jul 2024 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ECZ/GG7+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039EC19B3D6;
	Thu, 25 Jul 2024 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915555; cv=none; b=D4dyQcYuggnf1SDnGZ6qCmdzvqgVyD0BxN56UKS3iimxWeL0ikl7eYbENTMwnORTcooKL09VrF31RmxKAi3A7hJnaPyUpS+HHQGoVbJue9H/3Eb9Xw4NW3L/dSOXbxLLR4nDn9t72eb3SWDvigsH4ERybtVFeJJgg2lBrjFWQh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915555; c=relaxed/simple;
	bh=bFng46TywWA1qcwiXCQr+6wwB4FqtiDuuvEwXl3opRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mTi8NJU2XMIZJP54G9+bo5WHGFscfVVBoAeLaLoPRNSDrve4KDxICe8kNbiZZvecSupxtwY7zg8KIdMspONjZ7Aucd0PzrrVfcuAmj3nK1wX9Enfn9+JTxfZKw5VDiYkXGTtBkvg8Lqy4HkCAo3rDIxgh5dSjgHX5ZVyqOf+grU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ECZ/GG7+; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9FAE520005;
	Thu, 25 Jul 2024 13:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721915551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnKLsdQUhtO0HXqkcJaopxOibAnUmKmSBAHLuOVe3/0=;
	b=ECZ/GG7+ex4qJKBrkUY4liyV/BpXMZEb220ZTcJLE/nzrhxldtuy/jWn1N1ITqpPPFYdQW
	bmxizjkgopXFxjYsw9CcaTLRMYywE0tLfGdYTYwBLiVIlMxuNQMNhlPxYgV158jduSwHz7
	E6FS4eAdv3si0sI6B7eilC9po2N3mrSYF8VJs6A6SAD0rJBM/seaZDYyj8kYiQzPonlro0
	5qEG/1qakf2M5tkA3zGXFejlVVxa9a5hqpsecJ1cru+nkM/Qopjvo/WzpXiKLia5LMat9w
	AUoeUs2sH4IDZuxTZHF9qVRdGABVebwvwOvIEy3ILKqgN9RQFqffs9+rbGRoTg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 25 Jul 2024 15:51:09 +0200
Subject: [PATCH 1/3] selftests/bpf: do not disable /dev/null device access
 in cgroup dev test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240725-convert_dev_cgroup-v1-1-2c8cbd487c44@bootlin.com>
References: <20240725-convert_dev_cgroup-v1-0-2c8cbd487c44@bootlin.com>
In-Reply-To: <20240725-convert_dev_cgroup-v1-0-2c8cbd487c44@bootlin.com>
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

test_dev_cgroup currently loads a small bpf program allowing any access on
urandom and zero devices, disabling access to any other device. It makes
migrating this test to test_progs impossible, since this one manipulates
extensively /dev/null.

Allow /dev/null manipulation in dev_cgroup program to make its usage in
test_progs framework possible. Update test_dev_cgroup.c as well to match
this change while it has not been removed.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/progs/dev_cgroup.c |  4 ++--
 tools/testing/selftests/bpf/test_dev_cgroup.c  | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/dev_cgroup.c b/tools/testing/selftests/bpf/progs/dev_cgroup.c
index 79b54a4fa244..c1dfbd2b56fc 100644
--- a/tools/testing/selftests/bpf/progs/dev_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/dev_cgroup.c
@@ -41,14 +41,14 @@ int bpf_prog1(struct bpf_cgroup_dev_ctx *ctx)
 	bpf_trace_printk(fmt, sizeof(fmt), ctx->major, ctx->minor);
 #endif
 
-	/* Allow access to /dev/zero and /dev/random.
+	/* Allow access to /dev/null and /dev/urandom.
 	 * Forbid everything else.
 	 */
 	if (ctx->major != 1 || type != BPF_DEVCG_DEV_CHAR)
 		return 0;
 
 	switch (ctx->minor) {
-	case 5: /* 1:5 /dev/zero */
+	case 3: /* 1:3 /dev/null */
 	case 9: /* 1:9 /dev/urandom */
 		return 1;
 	}
diff --git a/tools/testing/selftests/bpf/test_dev_cgroup.c b/tools/testing/selftests/bpf/test_dev_cgroup.c
index adeaf63cb6fa..33f544f0005a 100644
--- a/tools/testing/selftests/bpf/test_dev_cgroup.c
+++ b/tools/testing/selftests/bpf/test_dev_cgroup.c
@@ -54,25 +54,25 @@ int main(int argc, char **argv)
 		goto err;
 	}
 
-	/* All operations with /dev/zero and and /dev/urandom are allowed,
+	/* All operations with /dev/null and /dev/urandom are allowed,
 	 * everything else is forbidden.
 	 */
-	assert(system("rm -f /tmp/test_dev_cgroup_null") == 0);
-	assert(system("mknod /tmp/test_dev_cgroup_null c 1 3"));
-	assert(system("rm -f /tmp/test_dev_cgroup_null") == 0);
-
-	/* /dev/zero is whitelisted */
 	assert(system("rm -f /tmp/test_dev_cgroup_zero") == 0);
-	assert(system("mknod /tmp/test_dev_cgroup_zero c 1 5") == 0);
+	assert(system("mknod /tmp/test_dev_cgroup_zero c 1 5"));
 	assert(system("rm -f /tmp/test_dev_cgroup_zero") == 0);
 
-	assert(system("dd if=/dev/urandom of=/dev/zero count=64") == 0);
+	/* /dev/null is whitelisted */
+	assert(system("rm -f /tmp/test_dev_cgroup_null") == 0);
+	assert(system("mknod /tmp/test_dev_cgroup_null c 1 3") == 0);
+	assert(system("rm -f /tmp/test_dev_cgroup_null") == 0);
+
+	assert(system("dd if=/dev/urandom of=/dev/null count=64") == 0);
 
 	/* src is allowed, target is forbidden */
 	assert(system("dd if=/dev/urandom of=/dev/full count=64"));
 
 	/* src is forbidden, target is allowed */
-	assert(system("dd if=/dev/random of=/dev/zero count=64"));
+	assert(system("dd if=/dev/random of=/dev/null count=64"));
 
 	error = 0;
 	printf("test_dev_cgroup:PASS\n");

-- 
2.45.2


