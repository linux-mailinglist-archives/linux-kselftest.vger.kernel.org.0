Return-Path: <linux-kselftest+bounces-48805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB15ED15F0D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 01:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FAF1306704A
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 00:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B981DF75D;
	Tue, 13 Jan 2026 00:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh2UTF/s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658319C540;
	Tue, 13 Jan 2026 00:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768262871; cv=none; b=bSCDaw+ZPBB7YgGzSoKaO4SC5AcEEWE4ft0pLPUtbaha68ETF5ueL6Vaq7iGAD0dcS/F6hS3j01PRtpU4RmMfvndYgPWSe8uvC1uuUWEDYALa34q5miG+0e1oGEoLr0+OFtkrrMaVenMp+BE5JD/DDBdJnDPXuq+uJECzJS+RTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768262871; c=relaxed/simple;
	bh=gEb54MfQLok1AaVPXIabDGRMNEVrb2hBFPA4n2SmHxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ak31wG6Ek19HNycS1twHaOfrjvtIzwDuI+Mp45eR1oRVbYja14ErBsSmIULtNvT/sJ2Hld7rzK6D8rFGUC3YPTB3oZNGQLYDfWjKA1FxXUn01R32nAMQ5+yVbv2YQWbXtFwbScNBzyaw051o3Far/4svfHoa0famfVPrILdCSBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh2UTF/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1F4C19425;
	Tue, 13 Jan 2026 00:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768262868;
	bh=gEb54MfQLok1AaVPXIabDGRMNEVrb2hBFPA4n2SmHxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uh2UTF/sSKw+3pT9ZTASol+zzT7eU0Igvd7h0xOi5WjKh5iOHX7o7I2ivO7+AROyE
	 vPaNml2TwOTog2NVYdFwu43zao5ehczhGkPOh4RHhAH5M5TDN/BP+4Vyx7KR9vN1Nk
	 KvNoyO6fyx1VPqbRxy7OMYTR9PeB7w4Twj/XDLFk7n5vjC61uEOaEb8+ffWVMKVr/e
	 Ej8hu1FQAAz/8SIz+QnHcHBPx+3gPuRR9RzM+NlBzctZ+/Pn9cRVSgcJrWuobRXM0w
	 2LhF1rCHxO10Fyv4YNGsVKNnMzlhBW+egE7ld9RHvrFq7MfqcaB4zg/sU8ikGAW+RZ
	 9y2YN4sM36p5w==
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
Subject: [PATCH net-next v3 3/6] selftests: drv-net: gro: use cmd print
Date: Mon, 12 Jan 2026 16:07:37 -0800
Message-ID: <20260113000740.255360-4-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113000740.255360-1-kuba@kernel.org>
References: <20260113000740.255360-1-kuba@kernel.org>
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

Reviewed-by: Petr Machata <petrm@nvidia.com>
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


