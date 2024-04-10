Return-Path: <linux-kselftest+bounces-7546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BABA89EC14
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3471C208E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 07:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFCF13CFA1;
	Wed, 10 Apr 2024 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBrbwd5o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E413C9D7;
	Wed, 10 Apr 2024 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734283; cv=none; b=Rj+zCnKJJ6RNTB3h0q/Rrq6OhjR3//XYV3pTpFe5pgUFd7BQpUmcoCpH28Jlo1TIiEWtq/oA11GjKivdph7l8fKFZ8KF5Y3sdMfGTTpsuLMD/VBwVRAY14MAAyM0bfrM2fwb3fhjLD1Yq86VtiXo5o6LCx7IDwU0HRc8FluOQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734283; c=relaxed/simple;
	bh=UMsJz02F0Aq81sLV0Yh1Banv8hIJKOdtNjKb5msmB68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nvGPAyfbE7PnKZX3T9lM8SK4N54jdrDVj6HyeLOeCMc9En1WWC/fqX2hvmnIHlqB8+fSeki38zms6if/lRdw2rGhE+63ztVQlcluqUGIFs0KARBri8p8ZfAQoCM2BCEkxJN7xm6OHrpoBlI0wLKPZ8OI6tGxLbxILvpU23UleQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBrbwd5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CE1C433F1;
	Wed, 10 Apr 2024 07:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712734282;
	bh=UMsJz02F0Aq81sLV0Yh1Banv8hIJKOdtNjKb5msmB68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oBrbwd5o8HWzeckdlCK1pQlFqykBqYI1by6d5/CcBAE0VPKkC6f5jUYeSNqOIlp1r
	 7Ju2XzQdMtsB2IrQgAV4flkMrsgw9C/lepxIACtI4k6nY8gZteHVS0QkhvvSpaSzl2
	 tAUo828ch0rk/gmikVY+ajs1bjPaa8dkwB5KTz9T3Ui3IcCmv9Gb3mniLfYX4JL6WA
	 /UI+AVTk1y3WNAnRSvx57Cnvc3FwEAR0oUdMiXtCKtQKoCAfpqnMFl1ylyRWqLxqic
	 7CLo+PNHK+07WIl3n94241pmcwQ3vPzK/7B0lbASidLyUQ5kz/M9w0YSH8JNY0QJ8a
	 ObTAHGCnredzQ==
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
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 14/14] selftests/bpf: Use connect_to_addr in test_tcp_check_syncookie
Date: Wed, 10 Apr 2024 15:29:47 +0800
Message-Id: <cc4227738b929413347473097be11509684e4e91.1712733999.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712733999.git.tanggeliang@kylinos.cn>
References: <cover.1712733999.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses public helper connect_to_addr() exported in
network_helpers.h instead of the local defined function connect_to_server()
in test_tcp_check_syncookie_user.c. This can avoid duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../bpf/test_tcp_check_syncookie_user.c       | 26 +------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
index e6ad4895d2b3..e678228b915f 100644
--- a/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
+++ b/tools/testing/selftests/bpf/test_tcp_check_syncookie_user.c
@@ -25,30 +25,6 @@ static int setsockopt_mode(int fd, int dual)
 	return setsockopt(fd, IPPROTO_IPV6, IPV6_V6ONLY, (char *)&mode, sizeof(mode));
 }
 
-static int connect_to_server(const struct sockaddr *addr, socklen_t len)
-{
-	int fd = -1;
-
-	fd = socket(addr->sa_family, SOCK_STREAM, 0);
-	if (fd == -1) {
-		log_err("Failed to create client socket");
-		goto out;
-	}
-
-	if (connect(fd, (const struct sockaddr *)addr, len) == -1) {
-		log_err("Fail to connect to server");
-		goto close_out;
-	}
-
-	goto out;
-
-close_out:
-	close(fd);
-	fd = -1;
-out:
-	return fd;
-}
-
 static int get_map_fd_by_prog_id(int prog_id, bool *xdp)
 {
 	struct bpf_prog_info info = {};
@@ -114,7 +90,7 @@ static int run_test(int server_fd, int results_fd, bool xdp,
 		goto err;
 	}
 
-	client = connect_to_server(addr, len);
+	client = connect_to_addr((struct sockaddr_storage *)addr, len, SOCK_STREAM);
 	if (client == -1)
 		goto err;
 
-- 
2.40.1


