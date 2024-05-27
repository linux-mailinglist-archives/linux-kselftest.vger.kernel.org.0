Return-Path: <linux-kselftest+bounces-10717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EB58D0403
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 16:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555A61F211FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ED715F3FB;
	Mon, 27 May 2024 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sq0IUjuT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230831D524;
	Mon, 27 May 2024 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819446; cv=none; b=Pz5p1FaOmohKzVZx0jLaQYfiGiTqqxg4R1ejj2GDOeNT9md66BikONriZXcj22tY44DCAC3vVpEbcd9XLyOI+O4vudFgYPjhbXC+v9CwdaFbdJ7zsFHoc4hOvyKyrdGIDck3NmH4iTzSh0zdqHlig++xLmwjvBsTq0pJyzW5dAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819446; c=relaxed/simple;
	bh=ofy6pRdSaB7NKE45sK6v+o5Hf3JIC6r0r+ypQ/qr78E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FpJGW2CjdDuNmL5uUXk9mrrqGK7hr1oAdjdgXnICBx2TVrYIvr7TrpN65MO3SM4esnKzsNdOyOck7BpwALGFVMmdap3RG6sAvk8I231YxA/+y5ARELEbDi03Rf9Z0OmrRsxvbSdYWjlYBvUBsOahh7DwmqE96NCCmgePckRsEa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sq0IUjuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F860C2BBFC;
	Mon, 27 May 2024 14:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819446;
	bh=ofy6pRdSaB7NKE45sK6v+o5Hf3JIC6r0r+ypQ/qr78E=;
	h=From:To:Cc:Subject:Date:From;
	b=sq0IUjuTtLlxuNbZBgjz8LuGlfMNN64lXdCUBaySNfBgjPBiOHRAK2OgVlFRC0yA7
	 PPXONnvnuGBAsOOiRLKQtF47YmIr3O8Ore+sv96r2uML4gNtHu4tN3pPf9PCxXTGzW
	 g+neRMKaXCqQ/XynYjno91PnnjwTqNXv4NK8Kd6WnBuLDVqO11LrDLhu2Ob0bZGRKV
	 o/NLxH2QHcydiMPiWevAvz20Ct28nqajMpN7QTGroCc5CzqJCewJcVf8U/13363Y9B
	 VMrpA9wShTOBkldy3BVw+glADBX7nM9DXfUjRWV3zBc8nhd7fM/qmNGzurFCewZRyF
	 uqJKUx/OsoGnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 01/17] selftests/bpf: Prevent client connect before server bind in test_tc_tunnel.sh
Date: Mon, 27 May 2024 10:16:38 -0400
Message-ID: <20240527141712.3853988-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
Content-Transfer-Encoding: 8bit

From: "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>

[ Upstream commit f803bcf9208a2540acb4c32bdc3616673169f490 ]

In some systems, the netcat server can incur in delay to start listening.
When this happens, the test can randomly fail in various points.
This is an example error message:

   # ip gre none gso
   # encap 192.168.1.1 to 192.168.1.2, type gre, mac none len 2000
   # test basic connectivity
   # Ncat: Connection refused.

The issue stems from a race condition between the netcat client and server.
The test author had addressed this problem by implementing a sleep, which
I have removed in this patch.
This patch introduces a function capable of sleeping for up to two seconds.
However, it can terminate the waiting period early if the port is reported
to be listening.

Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20240314105911.213411-1-alessandro.carminati@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_tc_tunnel.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index 334bdfeab9403..365a2c7a89bad 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -72,7 +72,6 @@ cleanup() {
 server_listen() {
 	ip netns exec "${ns2}" nc "${netcat_opt}" -l "${port}" > "${outfile}" &
 	server_pid=$!
-	sleep 0.2
 }
 
 client_connect() {
@@ -93,6 +92,16 @@ verify_data() {
 	fi
 }
 
+wait_for_port() {
+	for i in $(seq 20); do
+		if ip netns exec "${ns2}" ss ${2:--4}OHntl | grep -q "$1"; then
+			return 0
+		fi
+		sleep 0.1
+	done
+	return 1
+}
+
 set -e
 
 # no arguments: automated test, run all
@@ -190,6 +199,7 @@ setup
 # basic communication works
 echo "test basic connectivity"
 server_listen
+wait_for_port ${port} ${netcat_opt}
 client_connect
 verify_data
 
@@ -201,6 +211,7 @@ ip netns exec "${ns1}" tc filter add dev veth1 egress \
 	section "encap_${tuntype}_${mac}"
 echo "test bpf encap without decap (expect failure)"
 server_listen
+wait_for_port ${port} ${netcat_opt}
 ! client_connect
 
 if [[ "$tuntype" =~ "udp" ]]; then
-- 
2.43.0


