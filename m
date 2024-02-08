Return-Path: <linux-kselftest+bounces-4348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A284B84E439
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 16:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC06AB21159
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DA27CF0E;
	Thu,  8 Feb 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhtU+GRq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF977B3EA
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Feb 2024 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407152; cv=none; b=XU8Qu9x+yM2vxSD9VYDlDkGeByfSMh9rQLxvOoiXpqY46FBLEcaDpbHuyP9Nw8QCGgKy3s+epZ+v+04frYAsPQNRRf94ulzJ8QVkwz4zxHhZoX9mIYkinBOT8lsyvoUETU5Deby5y5Z/WP6he61UxXGlPvjkhtTpW/3HvRmUWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407152; c=relaxed/simple;
	bh=+HJYZ8oqHC3FdNT1e4ehv7w01FCjmZKJPFhODlJSz5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cc8gOr3KUh4FsATiaMLD4Yn4kzxk0cI8Qu5CrXT7+rR2VHA+Nipehw1iXKff6co7XtfZU6QrG3Jmmo0cO8gfc0TyLgPtSwfyOT5yox7Nhwu2704zL8nWUyOLZ9vIS7rEQXQ3+wPLkN/vbXbR8u/TQ89sbJIUJ76JAP41jwqhESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhtU+GRq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707407149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PkIkmm1xiMrNbNoPpK4ngd8OZ7yo/e1nfxvctzpMBYM=;
	b=FhtU+GRq8HXNydI7p1V5CPlsyT99Vetz2KaWtPJCZm6X8DdrtSunPp+U23YzPdMD0do2NM
	+ungf4UHNSY1WqUFsZvRbH1TW/+jctbG92JWRk/TT0F1vm2HPXHXRHfi5j5KEs0HZE8afN
	EVy2lq0t9vod0ycmh2XdmPcxl8aAA+4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-rKduAvwiNq-EryYzdOdk5A-1; Thu, 08 Feb 2024 10:45:45 -0500
X-MC-Unique: rKduAvwiNq-EryYzdOdk5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B474885A588;
	Thu,  8 Feb 2024 15:45:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.247])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 30D6D2166B31;
	Thu,  8 Feb 2024 15:45:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: wait for receiver startup in so_txtime.sh
Date: Thu,  8 Feb 2024 16:45:34 +0100
Message-ID: <53a7e56424756ef35434bc15a90b256bcf724651.1707407012.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The mentioned test is failing in slow environments:

  # SO_TXTIME ipv4 clock monotonic
  # ./so_txtime: recv: timeout: Resource temporarily unavailable
  not ok 1 selftests: net: so_txtime.sh # exit=1

The receiver is started in background and the sender could end-up
transmitting the packet before the receiver is ready, so that the
later recv times out.

Address the issue explcitly waiting for the socket being bound to
the relevant port.

Fixes: af5136f95045 ("selftests/net: SO_TXTIME with ETF and FQ")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Note that to really cope with slow env the mentioned self-tests also
need net-next commit c41dfb0dfbec ("selftests/net: ignore timing
errors in so_txtime if KSFT_MACHINE_SLOW"), so this could be applied to
net-next, too
---
 tools/testing/selftests/net/so_txtime.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/so_txtime.sh b/tools/testing/selftests/net/so_txtime.sh
index 3f06f4d286a9..ade0e5755099 100755
--- a/tools/testing/selftests/net/so_txtime.sh
+++ b/tools/testing/selftests/net/so_txtime.sh
@@ -5,6 +5,8 @@
 
 set -e
 
+source net_helper.sh
+
 readonly DEV="veth0"
 readonly BIN="./so_txtime"
 
@@ -51,13 +53,16 @@ do_test() {
 	local readonly CLOCK="$2"
 	local readonly TXARGS="$3"
 	local readonly RXARGS="$4"
+	local PROTO
 
 	if [[ "${IP}" == "4" ]]; then
 		local readonly SADDR="${SADDR4}"
 		local readonly DADDR="${DADDR4}"
+		PROTO=udp
 	elif [[ "${IP}" == "6" ]]; then
 		local readonly SADDR="${SADDR6}"
 		local readonly DADDR="${DADDR6}"
+		PROTO=udp6
 	else
 		echo "Invalid IP version ${IP}"
 		exit 1
@@ -65,6 +70,7 @@ do_test() {
 
 	local readonly START="$(date +%s%N --date="+ 0.1 seconds")"
 	ip netns exec "${NS2}" "${BIN}" -"${IP}" -c "${CLOCK}" -t "${START}" -S "${SADDR}" -D "${DADDR}" "${RXARGS}" -r &
+	wait_local_port_listen "${NS2}" 8000 "${PROTO}"
 	ip netns exec "${NS1}" "${BIN}" -"${IP}" -c "${CLOCK}" -t "${START}" -S "${SADDR}" -D "${DADDR}" "${TXARGS}"
 	wait "$!"
 }
-- 
2.43.0


