Return-Path: <linux-kselftest+bounces-48643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B0BD0CA99
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 01:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 918F43059666
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 00:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9102C21CC59;
	Sat, 10 Jan 2026 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drbp8dz5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CABF218AC4;
	Sat, 10 Jan 2026 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768006300; cv=none; b=ukRVBE7UpQKEy4CZaoOzJ2Pm3QdFN67dJnH4MwS4OwR94gjrWbJk7zfiK01BmMT6e1qb4VqubggyvYJ+M0AcU/+Jma+lvI+3MfSoMuOPvwW6TeNCaAF0w12OX1KkzcCifFvcIhOs2qQ5tdGpAxBtX70FFdOKSu0z+fi6cngb9Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768006300; c=relaxed/simple;
	bh=nJUyKvhVZUMito7Sdsd+ObBCp6WzGvBfvVHNFlPeWrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIkVYPcPUNnEJnSXN4jmAM9szh1Vj+fuOxWUwT2lis0ID6s8kS2OSVdEcUh4dPhGmoVmotSBenEsERXD27MGf6O7LJwB+cAVC9NL/Cax3vMvCpHnrCfJMLOxrCSEH4tWbTQUJ1G+d4uyS5BQlIUbIU1chkjEuig7JPnvhpMDkd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drbp8dz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA37C4CEF1;
	Sat, 10 Jan 2026 00:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768006300;
	bh=nJUyKvhVZUMito7Sdsd+ObBCp6WzGvBfvVHNFlPeWrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=drbp8dz5VEEppfQImVtTdoWESncegfo36wJeNyjIdrtsFbc/hqtS1rjmuMhVcNdex
	 MGQtZldYkzanIQ15uBDEAmP8ghSC8EyCnTB+W+bnlfJcvuvaNYIzwr79FhoSve/L3p
	 9faaaCW4fe2Y/nmNoLARewIxS+DBgLZodht+a4EgCLvfpmCO+XZthzTshhgsku7riZ
	 A2gf7XRaxX7zMBrDpeWOsQwwml6ENSPTEdv4lwnNurxHdCKvuGhEGta3cafR9PD61w
	 cr4UJcY8SKsY9jb8QbnbnDgvZMFBfJpMVMirxarchwhPXd8xeYOZ60syJhA2oOWycH
	 Fr3m5YONyt3yw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 3/6] selftests: drv-net: gro: use cmd print
Date: Fri,  9 Jan 2026 16:51:18 -0800
Message-ID: <20260110005121.3561437-4-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110005121.3561437-1-kuba@kernel.org>
References: <20260110005121.3561437-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that cmd() can be printed directly remove the old formatting.

Before:

  # fragmented ip6 doesn't coalesce:
  # Expected {200 100 100 }, Total 3 packets
  # Received {200 100 }, Total 2 packets.
  # /root/ksft-net-drv/drivers/net/gro: incorrect number of packets

Now:

  # CMD: drivers/net/gro --ipv6 --dmac 9e:[...]
  #   EXIT: 1
  #   STDOUT: fragmented ip6 doesn't coalesce:
  #   STDERR: Expected {200 100 100 }, Total 3 packets
  #           Received {200 100 }, Total 2 packets.
  #           /root/ksft-net-drv/drivers/net/gro: incorrect number of packets

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/gro.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index ba83713bf7b5..4e0fb19d1527 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -142,8 +142,7 @@ from lib.py import ksft_variants
         if rx_proc.ret == 0:
             return
 
-        ksft_pr(rx_proc.stdout.strip().replace('\n', '\n# '))
-        ksft_pr(rx_proc.stderr.strip().replace('\n', '\n# '))
+        ksft_pr(rx_proc)
 
         if test_name == "large" and os.environ.get("KSFT_MACHINE_SLOW"):
             ksft_pr(f"Ignoring {protocol}/{test_name} failure due to slow environment")
-- 
2.52.0


