Return-Path: <linux-kselftest+bounces-14109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212ED93A933
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E27B22FA8
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3357A149002;
	Tue, 23 Jul 2024 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQk+CzTM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9431482E2;
	Tue, 23 Jul 2024 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773387; cv=none; b=GRkzfcMVH6B23VaPtWumkgKkBR3qxB1MsUa0uvvFdzZgRVlFj+CD4jc10g6u7F626sPaEdQosCEliYJ9t+bIPVG6tQ/zdLUWgvSltd1JJHy4Pbyaedd1d1XPZeOoxNzxaN5YG70QOR2qpzNCvAOIn+ERfkB/lKHlYsOO+npiALU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773387; c=relaxed/simple;
	bh=YBqZd6bqszPv1L2BqgxtBBlG+WaL56Es26tyx6TtL3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgKtJ+1YQJzAuK5uE99DBW6KiFAEfP++juwMkRCdFR626yeQciwqDb0GQrMSXg94hU/Lf2sRU+gr1EfkFmecSnRr+X3PcqajwHnAaigXiyyn1P7dY34D/fpmcQuyrmWWtelvbIUUK1/494fQirbO+0J7G6z422W3KjoDrlwHJe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQk+CzTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4113DC4AF15;
	Tue, 23 Jul 2024 22:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773386;
	bh=YBqZd6bqszPv1L2BqgxtBBlG+WaL56Es26tyx6TtL3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eQk+CzTM7Qr522xqMY9N7CAb4PyK2usQye6nLJMGuB4oq/koKJ4h9cQiirCeuw9O4
	 bYksXqn74TjF5oGYYYD92Ts8hKttp7/i87VP+/uOM4HDxq2RV380atq1xUmyGKHTNk
	 tJZlPWngT97gYfOD7JaInXDB4dx5m7oQVRWqMF7xxUM8iNXD0JpVtZM++34Y77OpbS
	 CrNKOcoLAOImAA423GvFi1X4pQ5DMu/VmoAD26ZZoTgDxBk3W+X71hqKF8oC7642yt
	 txL0scyPEWcc5c88jU5qCe/m69WX49OfORb8m8GDMTT/y47vtebDZu2o4OQeOpzV+U
	 CzPmAmgB019wg==
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
Subject: [PATCH bpf-next 07/15] selftests/bpf: AF_ALG support for make_sockaddr
Date: Wed, 24 Jul 2024 06:22:13 +0800
Message-ID: <50e333e776a5b33393bdf51d24053bf091784402.1721771340.git.tanggeliang@kylinos.cn>
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

This patch adds AF_ALG support for make_sockaddr(), uses sscanf()
to parse the given addr_str string to "salg_type" and "salg_name"
of struct sockaddr_alg.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index a6c158718267..8f39adbc2c16 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -17,6 +17,7 @@
 #include <linux/in.h>
 #include <linux/in6.h>
 #include <linux/limits.h>
+#include <linux/if_alg.h>
 
 #include "bpf_util.h"
 #include "network_helpers.h"
@@ -468,6 +469,20 @@ int make_sockaddr(int family, const char *addr_str, __u16 port,
 		if (len)
 			*len = sizeof(*sll);
 		return 0;
+	} else if (family == AF_ALG) {
+		struct sockaddr_alg *salg = (void *)addr;
+
+		memset(addr, 0, sizeof(*salg));
+		salg->salg_family = family;
+		if (addr_str &&
+		    sscanf(addr_str, "%s %s",
+			   salg->salg_type, salg->salg_name) == -1) {
+			log_err("AF_ALG sscanf(%s)", addr_str);
+			return -1;
+		}
+		if (len)
+			*len = sizeof(*salg);
+		return 0;
 	}
 	return -1;
 }
-- 
2.43.0


