Return-Path: <linux-kselftest+bounces-29515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF94A6AC76
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 18:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB8D7B0402
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 17:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CD7229B26;
	Thu, 20 Mar 2025 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArD4xhyG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FEF1953A1;
	Thu, 20 Mar 2025 17:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492981; cv=none; b=jOlPUGSyNzjAdJv2SchIirkRVYXsptkNALpAx8XRiABZR02d4OeeFHVvCw+zwh2A6kcevad9jqejva82lruaX1SvMaYiEMAyukEeX8MrluWSKESMfp+2lQfBRmUlFVADZS+ombFsLJL3jgDaQvuPiklNpzawNqVuqEN3AUHfRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492981; c=relaxed/simple;
	bh=xqyeSV4G9bEvGxh7+XLA1KQjiatdEWvQJJpEHF2K2MA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t1GiDzztLsMCBL1NaXak7SJBiOERf0x6DD5jrgYtXzHuDjXyanw3gSvJZptnRSCN0yOANzoUkHKf6fKicXQF8S/N2LFKIBnJNfmAxj+ptGXxsTSTzvb5d5cqn3+2+vsObpLQchlUiROMrRcvWZaVIkwuigzf+z8kwW1rVVDiVjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArD4xhyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BD1C4CEED;
	Thu, 20 Mar 2025 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742492981;
	bh=xqyeSV4G9bEvGxh7+XLA1KQjiatdEWvQJJpEHF2K2MA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ArD4xhyGTHStavD8A76PBgnwVf/b6DAeY0m4VNRVRdFa2EkzAIAMHc43M4ZQD+5BY
	 ZMtCAri6xcGzEOK83N3mMk1laPZkfieEaaiATEePwar2BgC4yeB1K2uiSiPwvegp//
	 cnr7pWshpDEfcnZfw8xTk7ys/WytKBhlSCoMFDv8CTJaSamT5F3gRiNm0nn2LQFzBV
	 l02C3ED582IYHSyzmbLmmvAr8kKgOzF7Zxh6z+2fnOHyRLfxTypyw4dw1bQC8wC40v
	 hFEQ6LEGweKDFQGvWU5y+V3NlfA2LGnuTBydGQHPj74m4SbMpaJGfS69g6G8l8YR73
	 G0Jv/4omDVUwg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 20 Mar 2025 18:48:44 +0100
Subject: [PATCH bpf-next/net v3 5/5] selftests/bpf: Drop cgroup_fd of
 run_mptcpify
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-5-9abd22c2a7fd@kernel.org>
References: <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-0-9abd22c2a7fd@kernel.org>
In-Reply-To: <20250320-bpf-next-net-mptcp-bpf_iter-subflows-v3-0-9abd22c2a7fd@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MJ4yUIHEjVx1dlHDaBDAevTBfGako1NrlTzaHOWEc8c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn3FUR0f5fhrsnGbmJRYV8FaWCHCgsF459EuDdS
 kPQ5IX7TrKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9xVEQAKCRD2t4JPQmmg
 c5QBEACswLflX88JxzwMso+MxP61b7Q6a3H/WnAWYTZ57E0J0zI1QCQ/a1gelBY+QrIxE+e21W6
 sRoVTuz7kmSMxpn8VyuIlP//CD8/LZyT5cPWpCz3bTE0MI3FgbtIms20l6xr0udoqRdDibB7Ta+
 b7y5yKaXlNHSjKbx2r6jpi0OTTgR9R6C0xxDXQpQ/ySa/XGNTq76b4PNRrZQ5haMJvpUwhgaFIO
 UBOA6AYV5VQmooN2+w7Q2G0PVu8HAEaXzsqu189ZfI4nGZHOFpi6BCXUqREM19DQ+SmvT5D3DGa
 duV7zJpICVUDUqFF3GpkRRapMYfUucegH9KbGxPKfiiH8VsaHol686/v37Yegjb70FQfK+8qyZd
 30y0INxl/pJUUtKyTYPqlZj8ZZZ43tUEDTLFIcSfE1GDJQCmiM71rDz40EYEm4HCx1/iiZeUBSV
 OtXwF/yeLXSZ1m0YMMRRt7vgS03MbzWDepEeJJJAdBXfH4Zj74M/8H6GMNci86d7G3KmX6I06pb
 YUr1XxoiIft85ld/JeYHCffzA1V+eBl+bG4JwJS8pb0oVo84dHOi1zcGp7D6P7ADFk7dLHQGXa9
 K3IIq97dFf30psO5+91vkGHWDhhGzBG6gJCHUk/AssJ0arGpkg2IsmYG648tsjWYnh6KlPM3Fk5
 I/sQEyhCmGnhefQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The parameter 'cgroup_fd' of run_mptcpify() is useless, drop it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v3:
   - New patch, simply to remove an unused parameter in the selftests.
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index f37574b5ef68d8f32f8002df317869dfdf1d4b2d..f519c452884e7b6088de24b6c2a9e646954fe0d8 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -272,7 +272,7 @@ static int verify_mptcpify(int server_fd, int client_fd)
 	return err;
 }
 
-static int run_mptcpify(int cgroup_fd)
+static int run_mptcpify(void)
 {
 	int server_fd, client_fd, err = 0;
 	struct mptcpify *mptcpify_skel;
@@ -325,7 +325,7 @@ static void test_mptcpify(void)
 	if (!ASSERT_OK_PTR(netns, "netns_new"))
 		goto fail;
 
-	ASSERT_OK(run_mptcpify(cgroup_fd), "run_mptcpify");
+	ASSERT_OK(run_mptcpify(), "run_mptcpify");
 
 fail:
 	netns_free(netns);

-- 
2.48.1


