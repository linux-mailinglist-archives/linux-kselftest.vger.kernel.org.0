Return-Path: <linux-kselftest+bounces-18462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A5C9883E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 14:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4458C1C20DA1
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 12:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E40418A94D;
	Fri, 27 Sep 2024 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5ErNlsW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16040189537;
	Fri, 27 Sep 2024 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438764; cv=none; b=YpSHL8txOUpCZomzh10/QXNn0EnUrCNnGCRTsQE4yzeUagxxbqlLiioPWfxjMD+TuiKgjMOFZGbnzazpx3t1IhWE2/Z/5JXcpZRtmBBbwT3izGQIA8JC7VYIQbmK++JbLyiXa2Pmli9hxXkqUmUPL09EJWD7y1/dyeXRMysfe6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438764; c=relaxed/simple;
	bh=Ro1is9ituWCILmRI/iTvFxrjUUl4erP+F7EFHL8Hbd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CD+D9jIkr5zMdEnRxutfYLTXiOzLhI/JiCci8cZsmtvPKDNWFCJ7jeXmLDbFsDISg91fcCrpaHXFIY//ahJokaJDc8xMRR79P1vDSflJ/IvEm2wRzw7beR63KNHzi9PeEHZZnISPOIU7+EG9PZv3rMx0m4e5EKAFYCWB1pAZ/Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5ErNlsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE4BC4CEC6;
	Fri, 27 Sep 2024 12:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727438763;
	bh=Ro1is9ituWCILmRI/iTvFxrjUUl4erP+F7EFHL8Hbd8=;
	h=From:Date:Subject:To:Cc:From;
	b=u5ErNlsWqyq8YPjvWhh6Yz/geC/q+U8w5UNUAd6QD0Tn6mpx5gTqGQGjB6K2tKjoM
	 M6sLgyvlg/9lsq5NP3jNhHhygAR71m5nbDzdaXiCtb1sewaSca1sYjGQi5QGGT2ppq
	 S/zziJheeLurS47XkLtOtLJOdueQv/EP29RLqDKHmPEBhGtnsTxAKFh2v7/UGwic2h
	 SsidhobC8eg9w0gOEP5fd9o9gLngrQMOPdqxAUWjTn6LluKWAcHjiKWlvFpv6txzPX
	 K9ENd+Y1w2tCC1QSu+vWJnghUyhDWoPOmT43unmUws743vUTsTPRqH/mg5oaCIpot6
	 voE1emdB4x6jA==
From: Simon Horman <horms@kernel.org>
Date: Fri, 27 Sep 2024 13:05:47 +0100
Subject: [PATCH bpf-next] selftests, bpf: Skip MPLS test_tc_tunnel tests if
 MPLS is unavailable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240927-mpls-skip-v1-1-1bc38abf917e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJqf9mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSyNz3dyCnGLd4uzMAl2LZDNLQ2NDUwPTlBQloPqCotS0zAqwWdFKSQV
 punmpFSVKsbW1AH2gT/5lAAAA
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.0

If MPLS is not available in the kernel then skip MPLS tests.

This avoids the test failing in situations where the test is not
supported by the underlying kernel.

In the case where all tests are run, just skip over the MPLS tests
without altering the exit code of the overall test run - there
is only one exit code in this scenario.

In the case where a single test is run, exit with KSFT_SKIP (4).

In both cases log an informative message.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 tools/testing/selftests/bpf/test_tc_tunnel.sh | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index 7989ec608454..71cddabc4ade 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -102,6 +102,20 @@ wait_for_port() {
 	return 1
 }
 
+skip_mac() {
+	if [ "$1" = "mpls" ]; then
+		modprobe mpls_iptunnel || true
+		modprobe mpls_gso || true
+
+		if [ ! -e /proc/sys/net/mpls/platform_labels ]; then
+			echo -e "skip:    mpls tunnel not supported by kernel\n"
+			return # true
+		fi
+	fi
+
+	false
+}
+
 set -e
 
 # no arguments: automated test, run all
@@ -125,6 +139,8 @@ if [[ "$#" -eq "0" ]]; then
 	$0 ipv6 ip6vxlan eth 2000
 
 	for mac in none mpls eth ; do
+		! skip_mac "$mac" || continue
+
 		echo "ip gre $mac"
 		$0 ipv4 gre $mac 100
 
@@ -193,6 +209,10 @@ readonly tuntype=$2
 readonly mac=$3
 readonly datalen=$4
 
+if skip_mac "$mac"; then
+	exit 4 # KSFT_SKIP=4
+fi
+
 echo "encap ${addr1} to ${addr2}, type ${tuntype}, mac ${mac} len ${datalen}"
 
 trap cleanup EXIT
@@ -278,8 +298,6 @@ elif [[ "$tuntype" =~ (gre|vxlan) && "$mac" == "eth" ]]; then
 		  awk '/ether/ { print $2 }')
 	ip netns exec "${ns2}" ip link set testtun0 address $ethaddr
 elif [[ "$mac" == "mpls" ]]; then
-	modprobe mpls_iptunnel ||true
-	modprobe mpls_gso ||true
 	ip netns exec "${ns2}" sysctl -qw net.mpls.platform_labels=65536
 	ip netns exec "${ns2}" ip -f mpls route add 1000 dev lo
 	ip netns exec "${ns2}" ip link set lo up


