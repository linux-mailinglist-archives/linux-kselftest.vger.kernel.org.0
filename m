Return-Path: <linux-kselftest+bounces-10609-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3D88CCC80
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 08:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC20283035
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 06:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8CD13C8F4;
	Thu, 23 May 2024 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5JTXCuk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DF013C8F2;
	Thu, 23 May 2024 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447058; cv=none; b=Oqse2sHhVocI1tJI0JXg8Z/1nbPSC2Mf/B/sSrOELFHPqZAmH3yV/FbIlGhiQcVUamVFOYMaFF5Cu2JXMM75o+qTiS/n2eW6d0Kw02WbiwEsCKDJO4X5o/pFdB4FRUtW7U6H25VndI8D6A4sRJzf9A546jXAPuEvjEXFM3Zz8s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447058; c=relaxed/simple;
	bh=icBCMYv8O7EZO08xGmk+z3plQf8DdXeJ7xlVNI+eUg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gItQKgnynlp8Pc5VQu6zCG/GE+aIUqPlEqI75RP+PTXTjHLMaLe7PkAQwiKOk2cAmzGtItrbKzmy9kKT486clcjwK52ERgzr8pijTH5UT3X5CmjdYWINUgpPaVL/5TGthwmMmOo9T4BM7fmivkF/QhmNXNmya4e5V9znHIIZy6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5JTXCuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EBBC3277B;
	Thu, 23 May 2024 06:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716447057;
	bh=icBCMYv8O7EZO08xGmk+z3plQf8DdXeJ7xlVNI+eUg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N5JTXCukGzZwBFu63kpWcjZa9lIhGnvdH6ee7TC/8LFPVu3JMRcm4UpWoJnKgyMK4
	 yftbDFVUcHAyDeREJwQM5CfdJmE07k9Glf+oqJ2Ckes9uKb22SFI/1ubktHfZQaGwY
	 HvSe+jCYWSMzbVdCVgiU85dmUDLWYX9LgaUEex7LaBd4hHOLqGvRSW4bCLDiXGPxo4
	 s3/SHicJCh/VpyqIO2bi+4QkH1kaXXLKHo+y4SEhZoogljXlhNVmBysbjNNIa/QM8i
	 YIbQvwtPSFi1bE54RNEQg58G87r3plgjNJ+Srtu6wUwJ1CYgfwc2+6d4q4fcJoNBnj
	 Lfiinq436IS8Q==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 6/8] selftests/bpf: Fix size of map_fd in test_sockmap
Date: Thu, 23 May 2024 14:50:02 +0800
Message-ID: <0972529ee01ebf8a8fd2b310bdec90831c94be77.1716446893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716446893.git.tanggeliang@kylinos.cn>
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The array size of map_fd[] is 9, not 8. This patch changes it as a more
general form: ARRAY_SIZE(map_fd).

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sockmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index e83ca0005721..3654babfac59 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1285,7 +1285,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 			bpf_link__detach(links[i]);
 	}
 
-	for (i = 0; i < 8; i++) {
+	for (i = 0; i < ARRAY_SIZE(map_fd); i++) {
 		key = next_key = 0;
 		bpf_map_update_elem(map_fd[i], &key, &zero, BPF_ANY);
 		while (bpf_map_get_next_key(map_fd[i], &key, &next_key) == 0) {
-- 
2.43.0


