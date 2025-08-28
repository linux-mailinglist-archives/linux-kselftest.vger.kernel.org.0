Return-Path: <linux-kselftest+bounces-40167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4D9B39B05
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 13:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1AE1C8077E
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 11:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E90C30DD19;
	Thu, 28 Aug 2025 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="odMWci1l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7E30C63E;
	Thu, 28 Aug 2025 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379260; cv=none; b=t76zQ/lJ0Q5BF1/OYJfgnRnoXo3a6mPC8IpHV+yKGpI4DdFrlKwbEMR5n5c99H64kHXS6Ta9YEDuONxgg3OXaUtWj0+Ao3R6RWmB5X4rQJmYNWD9NYNekwzo/w5YTMJ97XXKlpTbk6KKEWpr2FXz+3h4qc0F6ll+zFcDXgHtI5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379260; c=relaxed/simple;
	bh=9MlaewShrzwNP5cMPLBFY2qQOGWyYpp79Q4CAVUza28=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Aa8hCsjA2/scQtLRGEEAegtN/mJ8oq9mFD6m+/0BOHrWeLbrMW9kMjVV+ZO9h9+H2XAyLbtmsn2slcniP4ETS8GqT757GhGQvumL6cDskCNSSM8mAl2n1eZMTraITmiUh1oPfFhl1AedDGqGtGenFfF9VtIGgRoBNaBQYnTwEVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=odMWci1l; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756379253;
	bh=qD7BGCwe3Vj4PWN7gaUtbqxYjKU5h/fA619lif8uTXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=odMWci1le40l6GLxukmnrLgpv0Na3rAILjORerE5Vc1AR7d0XGm0FT01nyNnFxEz2
	 9d4CUf5D+VbYnWlDluCNb9iYMfiEr5pCiCkAQFjYY0210U0mjMs3YKLkpOwb6+kmAz
	 KLFmjohAWDsrRpCx3AIck26S35Fw4ToydjenlzV0=
Received: from NUC10 ([39.156.73.10])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 1DE1E2CC; Thu, 28 Aug 2025 19:07:30 +0800
X-QQ-mid: xmsmtpt1756379250tp0spbd2d
Message-ID: <tencent_69BD268FBA201219240B51661D5E96A8D80A@qq.com>
X-QQ-XMAILINFO: ONU4XJpmPbTTjImKSTC6xTA7H7jVJEd0lRBTzVo1XZqwVwwd97/OBptyCG372x
	 93pwtmzsxFr1LgxcKBfO+rwQMV9hGm9Ypde6Jy8fVfONCsER15JzNnzN5QxjC+BZ0WT+Esc98M2J
	 ZVGUpGBbQ49vxNdxxqbfHn9UM1jsySGxmF7Pod8JmKtE3D2djJerffcEcbEl6FzuNsWucc1pjCIJ
	 Vjk2uxrzQ5UyDZwiSdsd0n2WF2TuBs2L7zKd4PFF8JE2gd4lcRbt+u9O1Y4CcjKfbrb54F0I+v5d
	 DbaQybu0UFIzlHNfXywn+Ub9uk+kLToJlx5EApzH5ROVpOXBwYcNZXMSlXYBLdNzM40bvUICDwb/
	 gyg51eoeptXtRZSGK+hLXh8Iwb3L5U4tiUJT5uHnpBtHv0I3CE80ljQcjMXtCVR1fq8OiTSyYjPQ
	 JIW/I8KYfd/Io4nYW5Wa8M42zmFQQwjTFpORqmUrEqoLxIh1Prk4M5L7hgSM1FlhrQtffDbWPmXH
	 djc9P56dcMlFgy6zP0e2k0AuujVckUFeYu84de3SPI1RqRo1jk8BThm4yvi3nDIcPVS0EbCTXB+9
	 RVNww1RS++RK3tV/sgjMXxYwZSu5s0trABJjWadYAMZCzrVsryZrXl7uDZ8riNFVpIv9tJ1TKszm
	 7EdVYqmqMh8A24TV9W7e970YTKEE6oLKgkS4gcVw9deR7QbrMEIyksKICR/fQDT0KkCoZz1eOZf5
	 2qfY2C8zdrfJvxJk0jWLBm2uQQKsKkKff/NRhdrEH0LQJ+wgpgjfjUSabK09HbnErZPYllWpaNOr
	 7pG5ySRMRDc8hzZmT7XNldtcuib2RLqY0mF1oAQIS8IdwIwyjAUPEA3zOdBKIn2MjwdX4qaaLpxm
	 sQObb0SOBMxF+7BmSFg3DX6LhysFlOOEQpB8vYMbl+7LrZiY3GzGx6SH7j2eTSG0sczXbex54w2S
	 e4qNdFV7Ix+ukyyetYAiXAPT67BhqO4SjgJLw0ABRihOYnbgvmSH36CsYWG1h3F1Hiph77n9uhno
	 MrYA0+ukG/8svOhbEYz0cKlCDYGBI=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Rong Tao <rtoax@foxmail.com>
To: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	vmalik@redhat.com
Cc: Rong Tao <rongtao@cestc.cn>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH bpf-next v3 1/2] bpf/helpers: bpf_strnstr: Exact match length
Date: Thu, 28 Aug 2025 19:07:13 +0800
X-OQ-MSGID: <e37d08a0e813eed1bc82777e11f3335a0c7672e7.1756378974.git.rtoax@foxmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756378974.git.rtoax@foxmail.com>
References: <cover.1756378974.git.rtoax@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

strnstr should not treat the ending '\0' of s2 as a matching character,
otherwise the parameter 'len' will be meaningless, for example:

    1. bpf_strnstr("openat", "open", 4) = -ENOENT
    2. bpf_strnstr("openat", "open", 5) = 0

This patch makes (1) return 0, indicating a successful match.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 kernel/bpf/helpers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 401b4932cc49..ced7132980fe 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3672,10 +3672,12 @@ __bpf_kfunc int bpf_strnstr(const char *s1__ign, const char *s2__ign, size_t len
 
 	guard(pagefault)();
 	for (i = 0; i < XATTR_SIZE_MAX; i++) {
-		for (j = 0; i + j < len && j < XATTR_SIZE_MAX; j++) {
+		for (j = 0; i + j <= len && j < XATTR_SIZE_MAX; j++) {
 			__get_kernel_nofault(&c2, s2__ign + j, char, err_out);
 			if (c2 == '\0')
 				return i;
+			if (i + j == len)
+				break;
 			__get_kernel_nofault(&c1, s1__ign + j, char, err_out);
 			if (c1 == '\0')
 				return -ENOENT;
-- 
2.51.0


