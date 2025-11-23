Return-Path: <linux-kselftest+bounces-46348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B196C7E001
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 12:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3E45D344849
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Nov 2025 11:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924BC2D593D;
	Sun, 23 Nov 2025 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CkJBynGW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mLDeGtcE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384B828B4E2;
	Sun, 23 Nov 2025 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763896709; cv=none; b=VaAH6UDmBC37JexwrxOoqYfBvWE2VkVURjJ0NoYV12yPkohVX2hEJcGwto0VwwBfLm+TBIMFo09pok7k26S6y5ouKWJ1dB/tuaRTUCHRlNQpBScMeqsrb8vC6+6srP2vU+3piko/m9zVtaVwUFxdlZTNyzfQZTNd7Ct9pUzxBSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763896709; c=relaxed/simple;
	bh=BtA8rCDyqdSX6xKFIIw2rFqZONqzippVVBtr+CBsuy8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oyH7i0XAoitCaTS7TagV9HsJUmO+oJVg23nqOXQBsA6WXolpvqdtG5B2MfAlFTPjScGQcjrb1Cl0zSEmgARDMXEnXWysoekueH0szAav/m5enhFI/u5GxxGyQDp2afexXR8jcqm1mjZJk7kYD10LslJ7JzuAbWWZsIraUghnzfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CkJBynGW; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mLDeGtcE; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dDmfK4fG3z9t74;
	Sun, 23 Nov 2025 12:18:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763896697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+y0O9fq4Z5XBWU3EmYrjzVlObvd6zfqXVNW+py4U72c=;
	b=CkJBynGW/D+dlDxwlXy/auxcXNrACqEwXITlH3WlCdYECmaoy4+WUWc/H1k+fwyO/rVQ/V
	jrl6AAvbQD6PjGPmrRkkkRUOMoAw6Ss63c7OMgZHb2l/QpF/BJ/DcH7mjXE92/j5EsWfY1
	+w5HW9RFuHUi8vqpw0UKfLNbKXGmp234wr6PxbC4A3SMOeA5bmI3o/G6KdtT+4VraEUIJQ
	DaLBWDEp34LdldsVxHgn7k8yxff7MV7iZrZ5yhajqnLJaMC3h25F3lveqV2yXsADGmRCrQ
	CZE+XwiOLeAopV1i/apxyiu2l8LRkxa2PlIYrJ7SI+EWIEHcnIUvsszjCFvOjQ==
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763896695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+y0O9fq4Z5XBWU3EmYrjzVlObvd6zfqXVNW+py4U72c=;
	b=mLDeGtcEH/Ihx6U0Qinp5OVCBpa3V5itBuGl8HHgijFENcMR5fsioNz48eeCl8x5EJ/6z6
	z56MIqKr/YSAklCGsEYGtt+H42B84f4SIUS9AGxVxszeR/Sw5jfqnFq9vrPnKaxx0CkD1L
	hmeE1HY93KLTXlH29xKwFX90TFMLCY93yOpR+Innc5drfG2kaawFtgBwok9O7UC7uZ36ha
	aSJDiWrhfJXrC/mCYnt0KfIo3yGGbkGDyjBubgp1YTGLX982V1ynvZyYAKyeNPEsRqC1p9
	JmN+BlYNs/bDLiwa1nivQIDuDcL8cDu33jrbaSmkakyM5tHvNP9/TLVrUJ9qrw==
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: linux-integrity@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maurice Hieronymus <mhi@mailbox.org>
Subject: [PATCH] selftests: tpm2: Fix ill defined assertions
Date: Sun, 23 Nov 2025 12:18:09 +0100
Message-ID: <20251123111809.24634-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ysc4ezr16c164mo1anqkucm4rupe3fma
X-MBO-RS-ID: db62f58e38074497985

Remove parentheses around assert statements in Python. With parentheses,
assert always evaluates to True, making the checks ineffective.

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 tools/testing/selftests/tpm2/tpm2.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tpm2/tpm2.py b/tools/testing/selftests/tpm2/tpm2.py
index bba8cb54548e..3d130c30bc7c 100644
--- a/tools/testing/selftests/tpm2/tpm2.py
+++ b/tools/testing/selftests/tpm2/tpm2.py
@@ -437,7 +437,7 @@ class Client:
 
     def extend_pcr(self, i, dig, bank_alg = TPM2_ALG_SHA1):
         ds = get_digest_size(bank_alg)
-        assert(ds == len(dig))
+        assert ds == len(dig)
 
         auth_cmd = AuthCommand()
 
@@ -589,7 +589,7 @@ class Client:
     def seal(self, parent_key, data, auth_value, policy_dig,
              name_alg = TPM2_ALG_SHA1):
         ds = get_digest_size(name_alg)
-        assert(not policy_dig or ds == len(policy_dig))
+        assert not policy_dig or ds == len(policy_dig)
 
         attributes = 0
         if not policy_dig:

base-commit: 821e6e2a328bb907d40f8d1141d8b6c079aa7340
-- 
2.50.1


