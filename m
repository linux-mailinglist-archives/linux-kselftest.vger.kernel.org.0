Return-Path: <linux-kselftest+bounces-3899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EF5844AB7
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 23:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4AAD1C2627C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C373A26E;
	Wed, 31 Jan 2024 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aImREWYd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA9C3A1AB;
	Wed, 31 Jan 2024 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738691; cv=none; b=pNXlYhkL8lSrPA37GJV+YJBRW+VZytUp9bRXIaet+XAjy9U/JfCIDA/pRHQAtDZRFAK5JUlL3354Yy2QyPqPY/PX7Q7jnFVxIqYd6Mr73o/r6Z5IUQkJTakG8JWVRG8Mi6g6oSCiZLmHcL4y12HnXjPnIrrIIbLI7m2nYDaLsNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738691; c=relaxed/simple;
	bh=ppHfbf9qGqvGLoKdV8hXyPGwjYwRrEFpDWQkMI0RS/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dtw8PWEM+51yc0XbFsaKWHAq9uUiJww6S7wBZMknu88v1LnNnGfh1LdbO12XSPjyAOZKwsL5XrHcjeF7rCeoLoFFYO9Rig6vh5MrHbapXXwaA09680V3Fv6kqgeIGax5w8KVgxndDyymK3hdSHMK9o1e7F67X5QhLjwoESLA37Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aImREWYd; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706738688;
	bh=ppHfbf9qGqvGLoKdV8hXyPGwjYwRrEFpDWQkMI0RS/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aImREWYd/iXeOoZvTIRwYZeAqDtmwpg/dRn+p8kBsTwKT64NB3moS/b79jXi+cQk0
	 OdwQdJSEUFX2MM/USzRpnkw0t/RuShOOIXmakPI4qPqpKoWdTaZoE6/4CtafaRHFds
	 rDSVbWoooMZh6WkqbM1zNYHFdp6xQ18iHXRZ/8JbYm2z4ojCx8EVme7V7DVhjEfQKZ
	 hN6N0n6o0/mOSe+kcEtrV6WHEawuozYdrwKH8HGFQy+uFjfgt0t1AN+nsAZkY4kZ6+
	 dh+0KsYRaB7vOeb0DoV/NZpri1Qj28qt3AaRlaRH6zzx6FTe9Ew8DfYtc391cMMBcI
	 +pt66XoatbaYw==
Received: from [192.168.1.211] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2961C3782074;
	Wed, 31 Jan 2024 22:04:47 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 31 Jan 2024 17:02:42 -0500
Subject: [PATCH 3/4] selftests: ktap_helpers: Add a helper to abort the
 test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240131-ktap-sh-helpers-extend-v1-3-98ffb468712c@collabora.com>
References: <20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com>
In-Reply-To: <20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com>
To: Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Laura Nao <laura.nao@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.12.4

Similar to the C counterpart, add a helper function to abort the
remainder of the test.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 tools/testing/selftests/kselftest/ktap_helpers.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kselftest/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
index 29107924f5c2..87f93c6900c5 100644
--- a/tools/testing/selftests/kselftest/ktap_helpers.sh
+++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
@@ -87,6 +87,13 @@ ktap_test_result() {
 	fi
 }
 
+ktap_exit_fail_msg() {
+	echo "Bail out! " $@
+	ktap_print_totals
+
+	exit "$KSFT_FAIL"
+}
+
 ktap_print_totals() {
 	echo "# Totals: pass:$KTAP_CNT_PASS fail:$KTAP_CNT_FAIL xfail:0 xpass:0 skip:$KTAP_CNT_SKIP error:0"
 }

-- 
2.43.0


