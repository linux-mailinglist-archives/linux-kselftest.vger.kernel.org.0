Return-Path: <linux-kselftest+bounces-14111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B4093A935
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F370F1C225EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41D3149012;
	Tue, 23 Jul 2024 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6DAk+Yj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322D1DDD6;
	Tue, 23 Jul 2024 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773395; cv=none; b=uDeiW6/75mlwShht3AqnVkzqkAeyyikHdiLT5SJ4UQVLYj+Za/4vOA7Xc66bP7xT/qiAu+NznyFFBcdP3Ook6g7h9U5gaerWFjgqvsfbOCw1fthn8y2ubh18TfHFkTT7iyFYAKpW+z6W/NUvjqpQRASC3EXpndi1X7MiqbKNgiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773395; c=relaxed/simple;
	bh=xQr7aSrfooBfu5skylei+sIq3p9y31kRyAxMfGrXLWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goahHxboEDdwxfEBkj5bzKHjec2oAEZTr8GWsMy2evmrFSma8KtQjoQoQfa/i4rk4K0Y/8ywuTsdDQqOcuIAEkiDl6i5sAWy3JEhHG0sJbjx2+u7Hu7f74SYXAMdG/UrK6fqEe6qkBOhgiyFhtW9T5Pkci7qXuXZendoHMHlhK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6DAk+Yj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFE3C4AF10;
	Tue, 23 Jul 2024 22:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773395;
	bh=xQr7aSrfooBfu5skylei+sIq3p9y31kRyAxMfGrXLWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L6DAk+YjXuhKF2RBaZQVesMJSg2HZw5XYB9KnqU2DUZUqdjUW3U6G/40NYJ/St8Lv
	 T7exNt7zD5fE7THzdu23M5tMgifA4vJmiwoybFgNeeinYRfp7Z6YSUyAIYCc8sfbZ9
	 u2qC2HR1pUnVpGi8Hsi8qjjjnPT8XD1u20tUHFx9UXKtR5gpZzyVjduSJmEqVYtxiJ
	 RqUOCpIdDOdTDgkgEOZufOW01F/xrbzE6KAmhKKsAd4yaybmQI+1Bl06XF3/7H+n+b
	 mgk/d9zUOmqogS2WUv9hibRtjL83rkb2KiJ1FZHN/N3aMU1rscipVbVsaghFT801ra
	 o2IbNybxlW4ww==
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
Subject: [PATCH bpf-next 09/15] selftests/bpf: Use start_server_str in crypto_sanity
Date: Wed, 24 Jul 2024 06:22:15 +0800
Message-ID: <11d7a17f7245e17d29c1001461af6260b62ea610.1721771340.git.tanggeliang@kylinos.cn>
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

This patch uses start_server_str() to start a AF_ALG server in test
crypto_sanity, since no listen is needed in this test, nolisten flag
of network_helper_opts is set.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/crypto_sanity.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
index b1a3a49a822a..9b7a26c79123 100644
--- a/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
+++ b/tools/testing/selftests/bpf/prog_tests/crypto_sanity.c
@@ -20,16 +20,12 @@ static int opfd = -1, tfmfd = -1;
 static const char algo[] = "ecb(aes)";
 static int init_afalg(void)
 {
-	struct sockaddr_alg sa = {
-		.salg_family = AF_ALG,
-		.salg_type = "skcipher",
-		.salg_name = "ecb(aes)"
+	struct network_helper_opts opts = {
+		.nolisten = true,
 	};
 
-	tfmfd = socket(AF_ALG, SOCK_SEQPACKET, 0);
-	if (tfmfd == -1)
-		return errno;
-	if (bind(tfmfd, (struct sockaddr *)&sa, sizeof(sa)) == -1)
+	tfmfd = start_server_str(AF_ALG, SOCK_SEQPACKET, "skcipher ecb(aes)", 0, &opts);
+	if (!ASSERT_OK_FD(tfmfd, "start_server_addr"))
 		return errno;
 	if (setsockopt(tfmfd, SOL_ALG, ALG_SET_KEY, crypto_key, 16) == -1)
 		return errno;
-- 
2.43.0


