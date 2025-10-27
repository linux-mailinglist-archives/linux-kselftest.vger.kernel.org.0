Return-Path: <linux-kselftest+bounces-44089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBD7C0CED7
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 11:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4C4C4F0297
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 10:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC0F2F5A37;
	Mon, 27 Oct 2025 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZzmW5z4H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEEB22424E;
	Mon, 27 Oct 2025 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761560406; cv=none; b=uVAJKjG2iat3vebtjuxuNsOcQd7AnUZInFZmmZs1XP1D2JieHKBoBzPkE+w6ZGebNIpi7hkLTYpu2y2f6F6TaHr+wzafrG/5ktTPVeIlh1ExTniAFhMATGDy5Gw5pnBjnCdhbKcUT18SJ26J08jqmoHAtkohYrwELtQ/BEAfqOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761560406; c=relaxed/simple;
	bh=+RKvzDmt0Q1uLzUachi8BYSnc2ITFmHUfx22gc9qmZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouqNr+sceprsn/E8caFJGpS6IAjSqofc+8oUTGdF12OZj4LjjAIqSzY/8ncvc5ogg+kUoKL+8tCqdK3U8ZB8LDxbH+6FsxqnJXO0Mj8mw/A9zTH5ni7eyiPMumcihMyTZOoPRnup65DCeLQG0JWB4HqSKSKxUZixpc+rl28jflI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZzmW5z4H; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from Nerpa.home (2.general.phlin.uk.vpn [10.172.194.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B109042AFF;
	Mon, 27 Oct 2025 09:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1761559048;
	bh=lqt8/ZZGBb7asywG0Q0MskjIZofOfjZFSBYGrUMsxAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=ZzmW5z4HGSMBocWbErJGn++r6bcvBniGbCrvhgRZ2r+EJtRsv697lf6QUH+iegidx
	 5QwhFnvcULyqhBiQh0KybLZhXRNqOcmmAYD84caiBiR4RnZbsC/2LPUGNXHa+8O6eI
	 N2fmI8KNTfPZ+filSfrTGCh9AHSru9sgoB86AnMpRhYr4WL/4qvOUaBoPu2N88hg/s
	 OGKKXUIlgpuIlC0HTmtXr0d9z7kqOkoDi2O7FqtQue3TP4j1TrMxK1AAbam2wNKDC8
	 Pbg9XXX1wpWff8iYh9D4xUM2CQa+sS3luTMWi+sGgDTNRYZV8yUAbLuPSeHidQKvWT
	 qNoQaMrkSG07D4qcRu2Lf9vkN8b52ntyB6exOR1YkZIxfx+2Uf6tEGNKWWlNRboP8L
	 M2aPvnGoUyEEnoPRDRapE/wcJ2gXR9UkAOy1NU77XAwEZj4YasxBYYmpJHS5Tau4tF
	 uthgLXQzfcHF/3nDS2VAJfvo/i3gPxZmbyN9qeyNEI6dCiBdaGG0CFe9ttWSunU+k8
	 6ukCb8ch/QeM15YsPe1BufrXeGG87VpP6muwmWLR7JiZ5EWhiTBTATcFZ9oy7ZESL8
	 wCJcG+P7SjgUoyozcheaPwA8OYeQb17W76w92HwRhziQioJefIJjTxqxN3f0WfUmPo
	 ZkfAEVtFWmaz/nEURJzheyRQ=
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: po-hsu.lin@canonical.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	edoardo.canepa@canonical.com
Subject: [PATCH 1/1] selftests: net: use BASH for bareudp testing
Date: Mon, 27 Oct 2025 17:57:10 +0800
Message-ID: <20251027095710.2036108-2-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251027095710.2036108-1-po-hsu.lin@canonical.com>
References: <20251027095710.2036108-1-po-hsu.lin@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bareudp.sh, this script uses /bin/sh and it will load another lib.sh
BASH script at the very beginning.

But on some operating systems like Ubuntu, /bin/sh is actually pointed to
DASH, thus it will try to run BASH commands with DASH and consequently
leads to syntax issues:
  # ./bareudp.sh: 4: ./lib.sh: Bad substitution
  # ./bareudp.sh: 5: ./lib.sh: source: not found
  # ./bareudp.sh: 24: ./lib.sh: Syntax error: "(" unexpected

Fix this by explicitly using BASH for bareudp.sh. This fixes test
execution failures on systems where /bin/sh is not BASH.

Reported-by: Edoardo Canepa <edoardo.canepa@canonical.com>
Link: https://bugs.launchpad.net/bugs/2129812
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/bareudp.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/bareudp.sh b/tools/testing/selftests/net/bareudp.sh
index 4046131e7888..d9e5b967f815 100755
--- a/tools/testing/selftests/net/bareudp.sh
+++ b/tools/testing/selftests/net/bareudp.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 # Test various bareudp tunnel configurations.
-- 
2.34.1


