Return-Path: <linux-kselftest+bounces-10723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB968D046A
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 16:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FA22839C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2024 14:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E554715A86E;
	Mon, 27 May 2024 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL50qa14"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E0A15A864;
	Mon, 27 May 2024 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819555; cv=none; b=TQzlKzHZUbYmcvyz6i1Nb+YYb6/T1gj71uYOyQTuai4afIbcBLska83SlNn7Mwd9DnmhbDuUQxd981Gc+QMNGlbP8bMeTdmLOPpSB9yPJPPhwD5fEOsAan6BwfzFNyyQqKbawrTXJBhRFtrpUQ38Z8EOFy98aVt0wYcJaKcwXdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819555; c=relaxed/simple;
	bh=egnv+4LYG9kf+MAFhOdp1ZtsU4oJCToVCs7HH+OYNpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CryFlQd4Gr7Cn5kcbc/ZS+5U3tAMEP3VMWqNHJZ/sFXo6aaAxIwIJg1MO/VyUe16T1NDZctwyFjmO52PYd/43TJuYkhMc7FIp9Ou0qCdxz+4SmPJZKHluIGy4gtaNXehRh3cV5dwfU/oC5gwAeW+ie2kJHZp8fAwwTmtvw/82Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OL50qa14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DD4C2BBFC;
	Mon, 27 May 2024 14:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716819555;
	bh=egnv+4LYG9kf+MAFhOdp1ZtsU4oJCToVCs7HH+OYNpM=;
	h=From:To:Cc:Subject:Date:From;
	b=OL50qa14jD5ELMb+9YhlvKLL8fCfjswo2MK8mY5N4MAEzrX9W3xJjUfogIUl3GRpu
	 SgQjFIk7RrzXFMuYhYx65CahDK0/UNVJhckTMqBVxhJKZtmSqGSrD/8FlsLXhgXqpj
	 0svsQlqSz6yqD8EwqocSQBlwtwxKEfpFMOGioup/TW5rTsrWPSYMiVecoJgdIUVui8
	 1ugdlndI0pyXHEGXnaebxW/6md3RfeeA4rRUOoY8c8DzUe6EyR7Ygj274He5JtjJxe
	 j6k7S8FvDXm6dVr47lTGHNx5AXX6xWYgMY/7EP3067coUc6V5NxASPPekDpbaDkiyO
	 aZzszCB8dp9Pw==
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
Subject: [PATCH AUTOSEL 5.10 01/13] selftests/bpf: Prevent client connect before server bind in test_tc_tunnel.sh
Date: Mon, 27 May 2024 10:18:38 -0400
Message-ID: <20240527141901.3854691-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
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
index 7c76b841b17bb..21bde60c95230 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -71,7 +71,6 @@ cleanup() {
 server_listen() {
 	ip netns exec "${ns2}" nc "${netcat_opt}" -l -p "${port}" > "${outfile}" &
 	server_pid=$!
-	sleep 0.2
 }
 
 client_connect() {
@@ -92,6 +91,16 @@ verify_data() {
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
@@ -183,6 +192,7 @@ setup
 # basic communication works
 echo "test basic connectivity"
 server_listen
+wait_for_port ${port} ${netcat_opt}
 client_connect
 verify_data
 
@@ -194,6 +204,7 @@ ip netns exec "${ns1}" tc filter add dev veth1 egress \
 	section "encap_${tuntype}_${mac}"
 echo "test bpf encap without decap (expect failure)"
 server_listen
+wait_for_port ${port} ${netcat_opt}
 ! client_connect
 
 if [[ "$tuntype" =~ "udp" ]]; then
-- 
2.43.0


