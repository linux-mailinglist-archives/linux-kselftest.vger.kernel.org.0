Return-Path: <linux-kselftest+bounces-7525-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6A189EA8A
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 08:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D05EB22F19
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 06:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F6036B00;
	Wed, 10 Apr 2024 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDWUu3zu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8828A2206C;
	Wed, 10 Apr 2024 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729646; cv=none; b=NXYNmFWyfc90TMrVgd5TwSItTYijjT1N1NP62aGmv6wsN839a4IrMvaN4ZoC8el3eTPyngiMWaXaYRA3RxCz9dYSXhkj/YYrv05I9WWtLVpXKbgCmMr9dTE7p0npKPAn1CoJ2+kPT728kj2CdCRXMRgQ7e4McIM+wJW0dVOCSS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729646; c=relaxed/simple;
	bh=bDa3Vcz6I4Pm6HBOcI4duaKWHOWwh5YyRDPmIvGlPB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YGqciXWVDpkcAtmMvrnSmZ/yOftMuq6LplP3pT/XUV+qWwRtPPolxoIsITrh53ZwHRkBr3L9V1l00h4fxAtRHHzelt4Wf6gCco0tBOj509egAkyQtqCdi1GBnzKZwBCowvioUKjMsfKqcd6YeLWsXN6pHflCpZ6/g8PotTn4U38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDWUu3zu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCBBC43399;
	Wed, 10 Apr 2024 06:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712729646;
	bh=bDa3Vcz6I4Pm6HBOcI4duaKWHOWwh5YyRDPmIvGlPB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kDWUu3zu/P9veaO8fBdmD4bNQ1ncUzrnVcixhzEkRH+8cgVQvI9eZgYuy5yR3nf0x
	 d+cCq7Ov9hb5SY1/deaf4y2oJ9pemdVdhVqmCEzNbeQpZgqabhs3TnNTpIBX/BnrLd
	 yXsqLiAVGN7opF10Ks1OxWxU6polwoIJmNcjxlLTYyiMkYUSDztfVp4TsZcz67RE1e
	 +zzO8XHDXUn2A35FdF+1o2nswHmAgaSbt5wd3kHeFAZ4RmRN6Hdyh+YrP9Pi9pwPsN
	 iQMkPMCpX4jLbnEldqT2IWplTJ3/NO86GWJfauMwu/lTalAZBE/AOSJ4g4fFpBTZa5
	 TsJK1EUo4EC9g==
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
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Support nonblock for send_recv_data
Date: Wed, 10 Apr 2024 14:13:31 +0800
Message-Id: <9cd358958245f8ec87c4f553779aa4243f967a2f.1712729342.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712729342.git.tanggeliang@kylinos.cn>
References: <cover.1712729342.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Some tests, such as the MPTCP bpf tests, require send_recv_data helper
to run in nonblock mode.

This patch adds nonblock support for send_recv_data(). Check if it is
currently in nonblock mode, and if so, ignore EWOULDBLOCK to continue
sending and receiving.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 137cd18ef3f2..ca16ef2b648e 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -555,6 +555,7 @@ struct send_recv_arg {
 static void *send_recv_server(void *arg)
 {
 	struct send_recv_arg *a = (struct send_recv_arg *)arg;
+	int flags = fcntl(a->fd, F_GETFL);
 	ssize_t nr_sent = 0, bytes = 0;
 	char batch[1500];
 	int err = 0, fd;
@@ -578,6 +579,8 @@ static void *send_recv_server(void *arg)
 		if (nr_sent == -1 && errno == EINTR)
 			continue;
 		if (nr_sent == -1) {
+			if (flags & O_NONBLOCK && errno == EWOULDBLOCK)
+				continue;
 			err = -errno;
 			break;
 		}
@@ -599,6 +602,7 @@ static void *send_recv_server(void *arg)
 
 int send_recv_data(int lfd, int fd, uint32_t total_bytes)
 {
+	int flags = fcntl(lfd, F_GETFL);
 	ssize_t nr_recv = 0, bytes = 0;
 	struct send_recv_arg arg = {
 		.fd	= lfd,
@@ -622,8 +626,11 @@ int send_recv_data(int lfd, int fd, uint32_t total_bytes)
 			       MIN(total_bytes - bytes, sizeof(batch)), 0);
 		if (nr_recv == -1 && errno == EINTR)
 			continue;
-		if (nr_recv == -1)
+		if (nr_recv == -1) {
+			if (flags & O_NONBLOCK && errno == EWOULDBLOCK)
+				continue;
 			break;
+		}
 		bytes += nr_recv;
 	}
 
-- 
2.40.1


