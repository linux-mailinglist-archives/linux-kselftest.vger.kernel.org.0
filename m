Return-Path: <linux-kselftest+bounces-46665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D410C900DF
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 20:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2770C3ACE00
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 19:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5763054D7;
	Thu, 27 Nov 2025 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifN0VKW5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EB12DC79D;
	Thu, 27 Nov 2025 19:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764272758; cv=none; b=IZwPLm6cVU0mUtqF1D+JSTPMjS48mma0ABqejV4S/7NDgfNBwbKrt36yWqjN0KNJZvlqmvkVqtrSliZF4e6zOn+Y0oHjaeur4xl235+KYr9sFJp3FCAK9fwbkwsl7o1xyDerQ2LbImzDapPCEjdLjHuUFuhNVpl2RSh/RRqpI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764272758; c=relaxed/simple;
	bh=YMYsojn8iBqtGgh2B2V/yKnhSFqYIeJykYpEuf3UJDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMKtjOz+3B/KY8widppqIaugG8CbjLSt01kIGuCieAwtz+UJ7btdK3zX6f/7DE2nBKcoItWoDLH4QZRzn2xh0GZy/vDUlUgTnKlTvlzOefOMqgGAvk0ghR1hh3I0aVDWAisqfoczfz417qE8fCN5MTXmUY6yFkvgB52sO9L3ZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifN0VKW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9342AC4CEF8;
	Thu, 27 Nov 2025 19:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764272758;
	bh=YMYsojn8iBqtGgh2B2V/yKnhSFqYIeJykYpEuf3UJDU=;
	h=From:To:Cc:Subject:Date:From;
	b=ifN0VKW5G0FLFiN3JjZPNF8aNt7E/KkMVkiQVKyDLmaG//RElJD17Nkmu6ADvbo0m
	 akDvxkBq/HM3F/nKmW4VNM36PGao7MDt/8ODK4JijAJ6nEC0nJdLrLRyG/85qZipXG
	 gkSkogb8OojzU2GGnKrlbyH6spPA5xrb0xvbqPN9EUf0qXiXfwKA6wLIuLZKGm8nNB
	 dyBpM6fbLovKkVdZIKYo3hTuW/mLpra6wrW3fB+ltDJ7EnhpAgOWjvOq1meruH5UyD
	 AlULWaeecoq0dmtfgBKtuDex276QRWo2GUc06I/4PgPl8T6GM7b5LLLXHc8oR1GKrs
	 tZ3buXvxXaNSQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net: add a hint about MACAddressPolicy=persistent
Date: Thu, 27 Nov 2025 11:45:56 -0800
Message-ID: <20251127194556.2409574-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New NIPA installation had been reporting a few flaky tests.
arp_ndisc_evict_nocarrier is most flaky of them all.
I suspect that the flakiness is due to udev swapping the MAC
addresses on the interfaces. Extend the message in
arp_ndisc_evict_nocarrier to hint at this potential issue.
Having the neigh get fail right after ping is rather unusual,
unless udev changes the MAC addr causing a flush in the meantime.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/arp_ndisc_evict_nocarrier.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/arp_ndisc_evict_nocarrier.sh b/tools/testing/selftests/net/arp_ndisc_evict_nocarrier.sh
index 92eb880c52f2..00758f00efbf 100755
--- a/tools/testing/selftests/net/arp_ndisc_evict_nocarrier.sh
+++ b/tools/testing/selftests/net/arp_ndisc_evict_nocarrier.sh
@@ -75,7 +75,7 @@ setup_v4() {
     ip neigh get $V4_ADDR1 dev veth0 >/dev/null 2>&1
     if [ $? -ne 0 ]; then
         cleanup_v4
-        echo "failed"
+        echo "failed; is the system using MACAddressPolicy=persistent ?"
         exit 1
     fi
 
-- 
2.51.1


