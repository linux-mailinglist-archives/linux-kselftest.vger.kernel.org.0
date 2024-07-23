Return-Path: <linux-kselftest+bounces-14112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA1593A938
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27EB7B22089
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1491494A3;
	Tue, 23 Jul 2024 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNduFsIm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CA91DDD6;
	Tue, 23 Jul 2024 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773399; cv=none; b=MRpmFndEQn/xaDhfJhUXUSmECPPPOv+1z1RpDgEqfC6TROpDBqMHYzsqCGSQNt7Y4/CvnfdzdNLI6EkA5m1APN0PjiuZihSCgAkPZpg22t4mIIyY5EVS8oXzoN8WrL5RFo/Peimlt7L+JSgLweGVQ+/0oDtRJLfOY7P7ZSCxjOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773399; c=relaxed/simple;
	bh=4RgzlUO1ELpjhyL1Q4t07Sw3sMou1DtPvptQrfqDGKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNlFwWM720gi2PYRIdhBK4PXvgWo7biLZ6Ts/PgR97tp8lQucu07TVVYBSS2Cyz2Dspgdo3BJz+LjYarTjFbj1BsFLkh2jn1eeLSgV1kyNHkG2RGLp5cssbBiCYAt6UKXmye/40zuBAhtonXAmzBahY0YwgAqJ/Ln90MKuTtIAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNduFsIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1041CC4AF14;
	Tue, 23 Jul 2024 22:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773399;
	bh=4RgzlUO1ELpjhyL1Q4t07Sw3sMou1DtPvptQrfqDGKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fNduFsImGJp2OKknBzpaaEwfdYy2iTK1tt2thM9HPAGTp93XKDDNYo9RmbdMZr+aC
	 dZiZ0WcRM1DIhG0c6E3MRlVue4K3racvkNn6VpKuIZZTs5F/qfZgwlDYMKJ0tAg0G4
	 PlaczmwZpOdU7QDVUJLLkwcgwRsr34BRAcV+MnmOggqCfEzMeOaju+1imLxIHvh4xY
	 dZKxkOwMIHKC2ZV5TYfV6LVfaxbj2EdaKBXQO/AsranHW9nEjIwAvZVLvTcozBji76
	 dOODZXbuVsyWE8BPJAt0XTNYhNT1D6S3A0+ysIe7FeoI4ND5vGtYmXrbLju8G75/2W
	 rdGNC/w0fcQrg==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 10/15] selftests/bpf: AF_VSOCK support for make_sockaddr
Date: Wed, 24 Jul 2024 06:22:16 +0800
Message-ID: <cb705cbc3a0ba5d8b4d92b4cf30187075894e81b.1721771340.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721771340.git.tanggeliang@kylinos.cn>
References: <cover.1721771340.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds AF_VSOCK support for make_sockaddr(), uses atoi()
to convert the given addr_str string to an integer id and sets it to
"svm_cid". Set "svm_port" as VMADDR_PORT_ANY if the value of port is
zero.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index f140a76d3d7f..8b06b0bf66ae 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -18,6 +18,7 @@
 #include <linux/in6.h>
 #include <linux/limits.h>
 #include <linux/if_alg.h>
+#include <linux/vm_sockets.h>
 
 #include "bpf_util.h"
 #include "network_helpers.h"
@@ -486,6 +487,16 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 		if (len)
 			*len = sizeof(*salg);
 		return 0;
+	} else if (family == AF_VSOCK) {
+		struct sockaddr_vm *svm = (void *)addr;
+
+		memset(addr, 0, sizeof(*svm));
+		svm->svm_family = family;
+		svm->svm_port = port ?: VMADDR_PORT_ANY;
+		svm->svm_cid = addr_str ? atoi(addr_str) : 0;
+		if (len)
+			*len = sizeof(*svm);
+		return 0;
 	}
 	return -1;
 }
-- 
2.43.0


