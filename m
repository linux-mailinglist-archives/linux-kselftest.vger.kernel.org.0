Return-Path: <linux-kselftest+bounces-46177-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B95BC7736C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 05:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7CC535D8C2
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 04:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5790C2E22AA;
	Fri, 21 Nov 2025 04:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egL/E86Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFEB2E0925;
	Fri, 21 Nov 2025 04:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763697791; cv=none; b=tqRPGPbvzq5t7wBDovP1eDrKFaSGrDOVUWBB3CtkAblt9MJefWLN7OXsFrwkidku/GZavan8K/1wS9OFb2D7RIUX7oLq/6Rlh5vylC1ScSezq4z4ICeS0eR/uRoJFjPBRfuMUQCOyvl0/2aKjwkRBCAD+Sdyp9VHcYaFSYqNmwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763697791; c=relaxed/simple;
	bh=GwFC3YImlF6fpsi21/Ka4HXW8DM01e+VBiDSeP+7V6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHPKpzShpVOB2CevlFPDNRHZGy9FNykC2L8dIvdAP85MUZvfNTgE8NQ17/obDy83JIHdavIj94+quzJT5T0ZNfSXnrtfHuTqMaPmRev624xNNa4uaEvey6GRebDcFJfFLc+sIHZh+jxlOdhCX3jiTj8D853LDna9fVhew4ab9Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egL/E86Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE142C19422;
	Fri, 21 Nov 2025 04:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763697790;
	bh=GwFC3YImlF6fpsi21/Ka4HXW8DM01e+VBiDSeP+7V6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=egL/E86Zkzjo576lWAqoE9QD+L7s6rwbUCOBGiW9pZ4diSzDiN4FTNxBvbMlOAHSg
	 FtUOUTSm5nVqehMf1TX7BrE7cgWZfAId3WCq3JzgPCX4bJdp1PQFQYQW9uux9ETG4f
	 CuRabB+501Uj5iB9gz2WjoGX4yocxzFVsoSl+/SaFWSLp7C6mfeH/Utr4rD7LkotFO
	 ScmW8+JtP6Eq+zGaV8IgEjjafjSixhVENwM6Usgl0e4U0r7wx44i9cXNuwMMt/PMqk
	 iiDXHS0PN1NKQZghYbg5xzt30TbILVnSdw0AOwKCX6vq2qiRCEbVtQYLyLZ45K4g0G
	 57IZ68Ao3iQRA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	dw@davidwei.uk,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/5] selftests: hw-net: toeplitz: make sure NICs have pure Toeplitz configured
Date: Thu, 20 Nov 2025 20:02:56 -0800
Message-ID: <20251121040259.3647749-3-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251121040259.3647749-1-kuba@kernel.org>
References: <20251121040259.3647749-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that the NIC under test is configured for pure Toeplitz
hashing, and no input key transform (no symmetric hashing).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/toeplitz.py      | 29 ++++++++++++-------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.py b/tools/testing/selftests/drivers/net/hw/toeplitz.py
index 9019a8c1ff62..642a5cc385b6 100755
--- a/tools/testing/selftests/drivers/net/hw/toeplitz.py
+++ b/tools/testing/selftests/drivers/net/hw/toeplitz.py
@@ -17,6 +17,9 @@ from lib.py import cmd, bkg, rand_port, defer
 from lib.py import ksft_in
 from lib.py import ksft_variants, KsftNamedVariant, KsftSkipEx, KsftFailEx
 
+# "define" for the ID of the Toeplitz hash function
+ETH_RSS_HASH_TOP = 1
+
 
 def _check_rps_and_rfs_not_configured(cfg):
     """Verify that RPS is not already configured."""
@@ -34,16 +37,6 @@ from lib.py import ksft_variants, KsftNamedVariant, KsftSkipEx, KsftFailEx
             raise KsftSkipEx(f"RFS already configured {rfs_file}: {val}")
 
 
-def _get_rss_key(cfg):
-    """
-    Read the RSS key from the device.
-    Return a string in the traditional %02x:%02x:%02x:.. format.
-    """
-
-    rss = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
-    return ':'.join(f'{b:02x}' for b in rss["hkey"])
-
-
 def _get_cpu_for_irq(irq):
     with open(f"/proc/irq/{irq}/smp_affinity_list", "r",
               encoding="utf-8") as fp:
@@ -153,8 +146,22 @@ from lib.py import ksft_variants, KsftNamedVariant, KsftSkipEx, KsftFailEx
     # Check that rxhash is enabled
     ksft_in("receive-hashing: on", cmd(f"ethtool -k {cfg.ifname}").stdout)
 
+    rss = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+    # Make sure NIC is configured to use Toeplitz hash, and no key xfrm.
+    if rss.get('hfunc') != ETH_RSS_HASH_TOP or rss.get('input-xfrm'):
+        cfg.ethnl.rss_set({"header": {"dev-index": cfg.ifindex},
+                           "hfunc": ETH_RSS_HASH_TOP,
+                           "input-xfrm": {}})
+        defer(cfg.ethnl.rss_set, {"header": {"dev-index": cfg.ifindex},
+                                  "hfunc": rss.get('hfunc'),
+                                  "input-xfrm": rss.get('input-xfrm', {})
+                                  })
+        # Refresh in case changing hfunc changes things.
+        rss = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+
+    key = ':'.join(f'{b:02x}' for b in rss["hkey"])
+
     port = rand_port(socket.SOCK_DGRAM)
-    key = _get_rss_key(cfg)
 
     toeplitz_path = cfg.test_dir / "toeplitz"
     rx_cmd = [
-- 
2.51.1


