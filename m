Return-Path: <linux-kselftest+bounces-13060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D206F923EF8
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 15:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F6B7B282FB
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 13:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13C71B4C32;
	Tue,  2 Jul 2024 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0uzJE9j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE972AF16
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jul 2024 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926948; cv=none; b=AIYmTSG39NeaoU4AWGUrcE4E8sZ6SMHfYcU6rK6g1ap3AY76Xaxo4rzm81hneh30epoAwqpPxsUuZv0YFo6d2+AqShsSqLVePML1Kw7u0f/St702XRP+BR1sxIZPFNnb/NLdprBqADUtEEfyWoG1hQoVr4bfxJ2f0feOp9OdLyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926948; c=relaxed/simple;
	bh=vdM8sZkQ1/QCM3o5+eJ6BqO8/kIs8asupZPXbVvaeuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpQOIl1txBt2soyN/Y6zRxmxYPOq5U4GxJ+c9zEGBuyErR4o+R97rBZWQ7FQH5QMAX8Akz6zWA9+ZEJ5xD+OPFxpV5/U34ew3gAXWjQe7L1Hwk8YkkMk6wMojQ1vQBoYf3HP2o3/RHhTpOfvsUjg25NVrU8kDH7gWLFM23gne/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0uzJE9j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719926946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOWKcdh5zgVSTo5qmONcjJuIiMRK3wxQZInmWAhHTq4=;
	b=B0uzJE9jmem7SOmfRH0+z6esbJfuPxlxFq7E9h9M6zkyaFbr0sbN+E0q1UFkZVkUPb3x4N
	QtWtbtPsJ/koAF/Zlb8KP3wJekQ70SxQLW8VkSG5b5XkES1WGiCCr3JdMDr98u+GllMl2/
	tankKHikxigo8b6b5BLSyy9wpnR64oU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-B-vC6Z_XMeyxnPyy2CU6yg-1; Tue,
 02 Jul 2024 09:29:03 -0400
X-MC-Unique: B-vC6Z_XMeyxnPyy2CU6yg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2B901937222;
	Tue,  2 Jul 2024 13:28:49 +0000 (UTC)
Received: from RHTRH0061144.bos.redhat.com (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4A7019837F6;
	Tue,  2 Jul 2024 13:28:36 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Adri=C3=A1n=20Moreno?= <amorenoz@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 2/3] selftests: openvswitch: Attempt to autoload module.
Date: Tue,  2 Jul 2024 09:28:29 -0400
Message-ID: <20240702132830.213384-3-aconole@redhat.com>
In-Reply-To: <20240702132830.213384-1-aconole@redhat.com>
References: <20240702132830.213384-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Previously, the openvswitch.sh test suites would not attempt to autoload
the openvswitch module.  The idea was that a user who is manually running
tests might not even have the OVS module loaded or configured for their
own development.  However, if the kernel module is configured, and the
module can be autoloaded then we should just attempt to load it and run
the tests.  This is especially true in the CI environments, where the CI
tests should be able to rely on auto loading to get the test suite running.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 .../selftests/net/openvswitch/openvswitch.sh       | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 15bca0708717..0bd0425848d9 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -613,16 +613,20 @@ run_test() {
 	tname="$1"
 	tdesc="$2"
 
-	if ! lsmod | grep openvswitch >/dev/null 2>&1; then
-		stdbuf -o0 printf "TEST: %-60s  [NOMOD]\n" "${tdesc}"
-		return $ksft_skip
-	fi
-
 	if python3 ovs-dpctl.py -h 2>&1 | \
 	     grep -E "Need to (install|upgrade) the python" >/dev/null 2>&1; then
 		stdbuf -o0 printf "TEST: %-60s  [PYLIB]\n" "${tdesc}"
 		return $ksft_skip
 	fi
+
+	python3 ovs-dpctl.py show >/dev/null 2>&1 || \
+		echo "[DPCTL] show exception."
+
+	if ! lsmod | grep openvswitch >/dev/null 2>&1; then
+		stdbuf -o0 printf "TEST: %-60s  [NOMOD]\n" "${tdesc}"
+		return $ksft_skip
+	fi
+
 	printf "TEST: %-60s  [START]\n" "${tname}"
 
 	unset IFS
-- 
2.45.1


