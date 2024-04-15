Return-Path: <linux-kselftest+bounces-7995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E47B8A567D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 17:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C8A1F216A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2326A7F465;
	Mon, 15 Apr 2024 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c7p6I8OG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0809478C78;
	Mon, 15 Apr 2024 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713195163; cv=none; b=WEo9P1+yxoQneVVww4QkyaEuoMu3tQnCvIz1MAM5eYUzmsmo1CUdawmewKHQzacavey9E2VR5KG/e5XdJikKvW9UafXr7TaSlvIWVHsET7hdEOE3QpFt8P8nuqC4HkQsfI+cf5P6hZnfSXjHtnpEeUiXk0kTwzlMJ7pUs6sFrcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713195163; c=relaxed/simple;
	bh=0pFnxBdv2Aw+FFWBe7jdyVdRMZ4i1+0Pu9uZ+7wnjz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pjrH24mKTVqO2PyA2gOjWAo9ugWxEKc+oXBC22FjR/QsP2muoBCrNVRSTgwh5p79KchRwfhLzT2nMcP0lBlVWdfZsmydbk//JLZv+vVtBRffqSS/bQlpuUHucQ/z6vyUNcqiQROoSR6wEC2WwVS1jDBQeCUyieM2UKF3YMW/pTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c7p6I8OG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713195159;
	bh=0pFnxBdv2Aw+FFWBe7jdyVdRMZ4i1+0Pu9uZ+7wnjz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c7p6I8OGVtjkOFs/1NKsBL6gVO0NvGXc7gi16HBlL/v5UpI0gZQZMmPOuPPSWlc9N
	 E7dn6PFZ0pkmgInPQkZcYOpmmyOxPC+yn1eWsBXvDwcmh9K+j2z3kdlSwRp+VdAAvE
	 eI3Asuas45xxr1VP+TXHf73nqR/kE788IK6Spy40iumI72p7iWzDvcfZb5pcvSwA+y
	 aIv38lb7FTuy42cZtmKFgOzOQBBk0jSPMzXFTOpRpO3P7oo9yV+AsMAUX+OZCR01rs
	 lfiiH7tL8pAs9qnL6+uPLeaRg8Pig4fVeccwUV0YNnO739YW3oEwlEWTxf/0BmEjrf
	 bl8kSmDK6WhXQ==
Received: from [192.168.42.226] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2E822378201A;
	Mon, 15 Apr 2024 15:32:38 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 15 Apr 2024 11:32:16 -0400
Subject: [PATCH 2/2] selftests: power_supply: Make it POSIX-compliant
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240415-supply-selftest-posix-sh-v1-2-328f008d698d@collabora.com>
References: <20240415-supply-selftest-posix-sh-v1-0-328f008d698d@collabora.com>
In-Reply-To: <20240415-supply-selftest-posix-sh-v1-0-328f008d698d@collabora.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, 
 Mike Looijmans <mike.looijmans@topic.nl>, kernel@collabora.com, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

There is one use of bash specific syntax in the script. Change it to the
equivalent POSIX syntax. This doesn't change functionality and allows
the test to be run on shells other than bash.

Reported-by: Mike Looijmans <mike.looijmans@topic.nl>
Closes: https://lore.kernel.org/all/efae4037-c22a-40be-8ba9-7c1c12ece042@topic.nl/
Fixes: 4a679c5afca0 ("selftests: Add test to verify power supply properties")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 tools/testing/selftests/power_supply/test_power_supply_properties.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/power_supply/test_power_supply_properties.sh b/tools/testing/selftests/power_supply/test_power_supply_properties.sh
index df272dfe1d2a..a66b1313ed88 100755
--- a/tools/testing/selftests/power_supply/test_power_supply_properties.sh
+++ b/tools/testing/selftests/power_supply/test_power_supply_properties.sh
@@ -23,7 +23,7 @@ count_tests() {
 	total_tests=0
 
 	for i in $SUPPLIES; do
-		total_tests=$(("$total_tests" + "$NUM_TESTS"))
+		total_tests=$((total_tests + NUM_TESTS))
 	done
 
 	echo "$total_tests"

-- 
2.44.0


