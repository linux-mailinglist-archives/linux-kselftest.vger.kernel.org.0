Return-Path: <linux-kselftest+bounces-21533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 797A79BED5A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 14:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B4AB248DE
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 13:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184CC1F942D;
	Wed,  6 Nov 2024 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="gv0tLdHm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E171F941B
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Nov 2024 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898307; cv=none; b=tHgN80jwZgXm07U11P5FoFX4MohE6RzKnV9atpXITb7gDJMLyvOIXFCDhhobZQuQ5lqevCbYdDmemBU1Fbk31Qn9MohEwKB1sFkuLBnOFatFBmE8zNpMr7gW8jBMolP8QYypAoice2qzAe916xYre2FvtGMH25LHYMwAn/dEPn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898307; c=relaxed/simple;
	bh=IUyLura+YDqAklyADUCc9Yv1q4Dxr8XAwILHeqDSIAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUrCkRD81Qlk+75S6iN+tu+lwuq9ktCyq+3kw2Vkn6TgIavd8OORjP9llbmq3dhchFC9VzDlsN0SxLN4B1Jp8UYr2zjXW8+3r81uEkXQtpPpGO5u0G/snXHjtDdTNRCdpOSS97npowjgkpfTBArfPr2kK/eHaAtaAG/1ZmTbA6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=gv0tLdHm; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730898301;
	bh=oEc126lVY8sqIE1oH16a792a7OULOP+M/PDQo12uYUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gv0tLdHmaT1OUnl5g29n/lmsztFYL6Ahesi8b1OCqc/hJCdJfcgjAqq9YLLHKz5tE
	 xxgbn/XzFFzoOn6LSlR/QanbTPNciiKYobOhET/slcyYTUU4WLNrWoKLLf4u6UNOTe
	 GIo+YeSG9PRB7DzKfW8wngDpLuZzdu0TCPpvRAuMFGy4gq1xjd7IEzNPeO8QYJEGD6
	 SHIUV3n6UCi6LwX+YM9VayQRJHa2Ggz+cNdq9iun0PF3kHWM6D66br9j2AU6XZ5F2V
	 Tk26su/1wqcD0h9Oz0i1NPVJMQDWNqv5IN89hxrTcLgq/lzvb7Bga72UCKuAm7Yv2+
	 rNlhTB+cGU/cA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xk55n2LJmz4xc7;
	Thu,  7 Nov 2024 00:05:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kselftest@vger.kernel.org>
Subject: [PATCH 5/5] selftests/powerpc: Detect taint change in mitigation patching test
Date: Thu,  7 Nov 2024 00:04:53 +1100
Message-ID: <20241106130453.1741013-5-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106130453.1741013-1-mpe@ellerman.id.au>
References: <20241106130453.1741013-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the mitigation patching test errors out if the kernel is
tainted prior to the test running.

That causes the test to fail unnecessarily if some other test has caused
the kernel to be tainted, or if a proprietary or force module is loaded
for example.

Instead just warn if the kernel is tainted to begin with, and only
report a change in the taint state as an error in the test.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 .../selftests/powerpc/security/mitigation-patching.sh     | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/powerpc/security/mitigation-patching.sh b/tools/testing/selftests/powerpc/security/mitigation-patching.sh
index f43aa4b77fba..9a4612e2e953 100755
--- a/tools/testing/selftests/powerpc/security/mitigation-patching.sh
+++ b/tools/testing/selftests/powerpc/security/mitigation-patching.sh
@@ -36,8 +36,7 @@ fi
 
 tainted=$(cat /proc/sys/kernel/tainted)
 if [[ "$tainted" -ne 0 ]]; then
-    echo "Error: kernel already tainted!" >&2
-    exit 1
+    echo "Warning: kernel already tainted! ($tainted)" >&2
 fi
 
 mitigations="barrier_nospec stf_barrier count_cache_flush rfi_flush entry_flush uaccess_flush"
@@ -68,9 +67,10 @@ fi
 echo "Waiting for timeout ..."
 wait
 
+orig_tainted=$tainted
 tainted=$(cat /proc/sys/kernel/tainted)
-if [[ "$tainted" -ne 0 ]]; then
-    echo "Error: kernel became tainted!" >&2
+if [[ "$tainted" != "$orig_tainted" ]]; then
+    echo "Error: kernel newly tainted, before ($orig_tainted) after ($tainted)" >&2
     exit 1
 fi
 
-- 
2.47.0


