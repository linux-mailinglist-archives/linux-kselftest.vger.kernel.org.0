Return-Path: <linux-kselftest+bounces-12960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5460091C9FE
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 03:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121932837F9
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 01:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFB3184F;
	Sat, 29 Jun 2024 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcQAzv4n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA39E386;
	Sat, 29 Jun 2024 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719624061; cv=none; b=JSgpMtutvwAsyDJidg40iYyXAqYZM5tfDWgOBAo6HkWTQ29f76WLpPSTzfEozI2gddCVap437k15AW6IejNRVkqiTCFahE7EigUz4Y/uHbFdoSZeCX2YprRC2IS8K8H3RJTbidlmq5/EUa+V2eJwaq6YgVbDcDBEPWzwLvqahqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719624061; c=relaxed/simple;
	bh=JAWAcKR7zBXRC50szWd1XFpZsq7hHNsF3ZdFSJ3411U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWt0E9QQ+GNuACtIPksweyi/yzvzaewBYLeanPwxJGadmaDfJP8Lf/ew5xAyA/FKsVSGAHf3kc9Y4n485+VA5lFVKSzGSjvKYbLeUYBveFRbKAz4/QVODg3BjJ/Z0iYH7pH7RMpcPk6x/3fpCIRkwhXdPZolT1F9cdaqhj/2VLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcQAzv4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3B4C32786;
	Sat, 29 Jun 2024 01:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719624060;
	bh=JAWAcKR7zBXRC50szWd1XFpZsq7hHNsF3ZdFSJ3411U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcQAzv4n1Oh7Qn5PN7+HGDuFWQDvkSKauCfeePpnkbWXa+fKsxJuEM9wjW1A0S/jF
	 M96R1XQc7tZ7IVXlHOqX5Uu4Zj545HTNkWKPm1OkvfOrmjeO+HKsFBGFpl7qL0M0NY
	 ybCEsLrPfPRz2cbykXLomp5wjDqSw9T4h/SQj+9QJ3P+RGjOth7zJnlG4k6rQJ3IKX
	 HGPAqmE6M42R1p4zIwfxN1nKW76igg5knKAysnZK7cybem9T+CgFf1/9MNavCB16P0
	 tls/c2RNhBouLRfLHL/1JYs7wuWoqYQeSquWH08Drx1jKfHVd1+hvUgRbfcue4oZzU
	 hLujwwyIwllXg==
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
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v6 5/9] selftests/bpf: Close fd in error path in drop_on_reuseport
Date: Sat, 29 Jun 2024 09:20:15 +0800
Message-ID: <0b2faacc0001a4d5e1f2f44816c986ebacbb5f11.1719623708.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719623708.git.tanggeliang@kylinos.cn>
References: <cover.1719623708.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Server 1 fd should be closed in the error path when update_lookup_map()
fails. This patch fixes it by goto "close_srv1" instead of "detach"
lable in that case.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 597d0467a926..de2466547efe 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -994,7 +994,7 @@ static void drop_on_reuseport(const struct test *t)
 
 	err = update_lookup_map(t->sock_map, SERVER_A, server1);
 	if (err)
-		goto detach;
+		goto close_srv1;
 
 	/* second server on destination address we should never reach */
 	server2 = make_server(t->sotype, t->connect_to.ip, t->connect_to.port,
-- 
2.43.0


