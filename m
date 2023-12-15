Return-Path: <linux-kselftest+bounces-2074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6A5814C70
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 17:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B179285B56
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2273DBA5;
	Fri, 15 Dec 2023 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djrQj6zk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866333DBA3;
	Fri, 15 Dec 2023 16:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF7EC433C7;
	Fri, 15 Dec 2023 16:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702656290;
	bh=b2qibfhtaIVxT4ecOksI8qttwHiTICgitByIyJ3pq9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=djrQj6zk2JGwpNC82lJx6g5E7NLozuGj2Q2KIGygvZslHuoAhMW1NU8Fh9D/FJAjL
	 CMRql2tcn7+gIhfij0dB1mAEJn9aLNEm+BwOfB4OOVOWa+qswjIx68w7nJvatI/lW8
	 s4LrSN/FWaCXMOMyGL/Z8VCRs0LtBUOoMFBRkckhQUUyPundahX4kkSr5n+dlR1Pbz
	 QTGCQBgfqA1/famJ2GjchDfZO2PcCrbKqimkH8G0SVN6XKB9aRO5OZSKaMxygetbL4
	 vUsuwTffPI/xawJMOWhiDYeRVTfBOTWuPcg8vfgl7IPJY9BxvetP8i4dSqXwjst7G5
	 tT92F7xTBTVbg==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Fri, 15 Dec 2023 17:04:24 +0100
Subject: [PATCH net 1/4] selftests: mptcp: join: fix subflow_send_ack
 lookup
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-upstream-net-20231215-mptcp-misc-fixes-v1-1-91d20266d525@kernel.org>
References: <20231215-upstream-net-20231215-mptcp-misc-fixes-v1-0-91d20266d525@kernel.org>
In-Reply-To: <20231215-upstream-net-20231215-mptcp-misc-fixes-v1-0-91d20266d525@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Benjamin Hesmans <benjamin.hesmans@tessares.net>, 
 Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3042; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4/C0UGMyEKrvP+rHTWk5Iw2oMPY5jJScDwNFrAmbq0A=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlfHkbz/qYV/d7mOv4cNUF2I8C5IkF9TpD3mteD
 R+Oo88pcBaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZXx5GwAKCRD2t4JPQmmg
 c10+EADunBQlaexJGqXaIYwFQ3kLj0+wR46Q578yCJyFIXiQgIOf38/tgpbpg+E2RI+5RtvOqIm
 sXlvuW30f0i4T21Sw1uz46iD20cWXe70AkBgIzzZe95RDZNOB4TtmTiCCXjjhFTVj0rSKZntjSJ
 JEMtnp4hiH6VlQDLt+cL0IYJZVxcFTmFeMrCZ/pSGamqAvOsUHk0TbI9Q44NtW7A40j07x8Iz47
 bz6uNRIO32ozEna3eSXTLURRjn1HUy/eU4NzPyhUJjR7SiCdFGDnP1YYH0tQsJEeU4j2v3Jwi4r
 3JG7AkSi2x5ig9nG9E/qW15GaEamP+7Y/Yl6CPV5zMVFxJ5BAluVcIzIpFIu1ilidrkBh+XgEVq
 wribJ7dhmSLS7efV0pqCzm/ldvXyLytjC7yzQI+uB8ESpJwQSFUcohnROEehuzX05UPR+knApQN
 7lMFRkhV4DcwwvXGxt0747AhX1epfheJL4zslKcSy6F+L2ksstpxxzNcf/5Zb2qXeWCCcY7rTAU
 3s+7DNfHqRAS2Sva7+qphnO5VyhMdLid4kz6IB36+Nbvjhc2bxIBkifE6DWqwxggZIvhAfAy5qd
 mReqeZh6qRbRoW1QIRuZhyomNibWyWeK1/0OXI5Kzzqsk2e1sASJDcY2SchnN/YoH2N9H6b2Lxz
 AJKbLBIuauX/zpQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <geliang.tang@linux.dev>

MPC backups tests will skip unexpected sometimes (For example, when
compiling kernel with an older version of gcc, such as gcc-8), since
static functions like mptcp_subflow_send_ack also be listed in
/proc/kallsyms, with a 't' in front of it, not 'T' ('T' is for a global
function):

 > grep "mptcp_subflow_send_ack" /proc/kallsyms

 0000000000000000 T __pfx___mptcp_subflow_send_ack
 0000000000000000 T __mptcp_subflow_send_ack
 0000000000000000 t __pfx_mptcp_subflow_send_ack
 0000000000000000 t mptcp_subflow_send_ack

In this case, mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"
will be false, MPC backups tests will skip. This is not what we expected.

The correct logic here should be: if mptcp_subflow_send_ack is not a
global function in /proc/kallsyms, do these MPC backups tests. So a 'T'
must be added in front of mptcp_subflow_send_ack.

Fixes: 632978f0a961 ("selftests: mptcp: join: skip MPC backups tests if not supported")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3c94f2f194d6..24a57b3ae215 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2776,7 +2776,7 @@ backup_tests()
 	fi
 
 	if reset "mpc backup" &&
-	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
+	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
@@ -2785,7 +2785,7 @@ backup_tests()
 	fi
 
 	if reset "mpc backup both sides" &&
-	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
+	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		speed=slow \
@@ -2795,7 +2795,7 @@ backup_tests()
 	fi
 
 	if reset "mpc switch to backup" &&
-	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
+	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		sflags=backup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
@@ -2804,7 +2804,7 @@ backup_tests()
 	fi
 
 	if reset "mpc switch to backup both sides" &&
-	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
+	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		sflags=backup speed=slow \

-- 
2.40.1


