Return-Path: <linux-kselftest+bounces-11757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64C39050A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 12:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0D1284D4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 10:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71E616F0DA;
	Wed, 12 Jun 2024 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lDAW1UK9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7B016F0CB;
	Wed, 12 Jun 2024 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718189115; cv=none; b=NpqfOPooyNKHi3+UMQQoLpACH7GE8H7Y2myQWdOTfmQTUbb3JFFkkx7D+67Ia4fYHGppl46rPrp12ehFPvh14qH5QBxE+5uu1teiwinSjenUJP00H5q884bzXaYs4pLMFQya4AY4C1RbGcqvOJVcRwdsrP+lOUEykAWWbazlzmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718189115; c=relaxed/simple;
	bh=7KBVdtrVyLAPbuJcgaNyt4TEuscLxt+vNyICK4BFFWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nctv1X3jIiqvC45B3WmRazPPCW1LAMYA4NQDQ7Dpu/avfaLSbxHDHg5dYqBbabI8totoKav4LtJuWtO/6QKGn25EAqwbjFiOYRlCaj+VBTRM+NKuqAxHUNFiiUn42Ucl8MqMuARY+ETZa/lfBmfuySnkNby7x71r3tWvRQBDsio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lDAW1UK9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718189112;
	bh=7KBVdtrVyLAPbuJcgaNyt4TEuscLxt+vNyICK4BFFWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lDAW1UK9XSiFTbaMyIXs26KjiQuqRgfPtZ/wTBP71dndmPiobFX8h1+7AapHudFWk
	 QAPwCnqFlPi6oveoy7HtuXlkzqvP9GKETMnypvHWy4Gcp5sGw51CCdckMFeXrVZpMq
	 OLii7gHCAr66NsdX0P/nWn+gKMUivLj10TEwrtsTy6FNSoO+tNW+6JtR+P4DW3/GAf
	 PNCgvi5n6HbSAT7yRo6CiPsw6zSqUP/vEOPjZRauihDRDhyjXCNffHAV5xsTtrb/Zk
	 VawiM6otyI0AD3R/Sc/6xZaKjz/hDEXPjyvn+X1rWIpBHkRXNFyZgfrCj1xjQGYqXW
	 +KsMgg+TxZoGA==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E35EF378219A;
	Wed, 12 Jun 2024 10:45:09 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Anup Patel <anup@brainfault.org>,
	Sean Christopherson <seanjc@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kernel@collabora.com,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests: kvm: replace exit() with ksft_exit_fail_msg()
Date: Wed, 12 Jun 2024 15:44:54 +0500
Message-Id: <20240612104500.425012-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240612104500.425012-1-usama.anjum@collabora.com>
References: <20240612104500.425012-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The KSFT_FAIL, exit code must be used instead of exit(254). The 254 code
here seems like anciant relic. Its even better if we use
ksft_exit_fail_msg() which will print out "Bail out" meaning the test
exited without completing. This string is TAP protocol specific.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/kvm/lib/assert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
index 33651f5b3a7fd..db648a7ac429b 100644
--- a/tools/testing/selftests/kvm/lib/assert.c
+++ b/tools/testing/selftests/kvm/lib/assert.c
@@ -87,7 +87,7 @@ test_assert(bool exp, const char *exp_str,
 
 		if (errno == EACCES)
 			ksft_exit_skip("Access denied - Exiting\n");
-		exit(254);
+		ksft_exit_fail_msg("\n");
 	}
 
 	return;
-- 
2.39.2


