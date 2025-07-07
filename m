Return-Path: <linux-kselftest+bounces-36690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C2FAFB5F8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 16:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1DE3AC2B6
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 14:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E132D94BE;
	Mon,  7 Jul 2025 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X7JIP9j0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oLdQj7w6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357032D94AE;
	Mon,  7 Jul 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898227; cv=none; b=hEeE+dCTVWtUQ/WaluYcZweKg7O6Y96oPL1KaNfAfHYDu9D4TlBdjaafbJ94cKLG3lwgUa37PKYODBUjvaz22+ThmmrL1Et7A0AVi9eBQSurAVwWkHjRgSNeJqaNTeR424koTi6OxqCVdOneRQS3rXVCbznwWRKOVLjOgfUGDUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898227; c=relaxed/simple;
	bh=EayZOtBL90f6QFOcAGcEUumSQBoNWVZo7dcWx+htwY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7NGYxYd5eFALAfvcjfisB1oFKw47YztrMBCsKTnYHS4KJtYX1+q2Pn94gcl9B8l75uBGvdpo9xHUw1QpFijITGLsTO9g9UPcFrnAKDR+w8ug/DNZOGh3uH7+GtzwU2QGAol1kE1/xedkKPW/Sb6UuO40yegtJpt4q+XqbX2zyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X7JIP9j0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oLdQj7w6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751898224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ka2koAAO3+tROI+op1wD/ECrnjtB2oeDRijPzGbM22I=;
	b=X7JIP9j0JXEqr2WXcQj/pmMMbEfiYfpmt96lOlw37C9QQokGDo/1ev3o+Ez+XuczcyWBsA
	DIGjLHRpS1uD9Mu2xgF5Ue4yZuyRVB5BH4NcIua2JTZOO+LBZ71CiszJOwDJfJBQj589a8
	LGmPCHhOGdZ27FkkXQwqwfD5IEmA8ANVMOMZ5UT4f+fLtJ8xfZzur16mmUL6bgLpKgo8kc
	G3OxrdY37C5yRjOkacib3T0cDv12yG5qzJkDaVGVVNKVQSX+yh8r9oNYWzg3HoqIz7zW6l
	bKLuAFVMRTs93cAQ+QPdjF4+Z1898JFl6XaQTEjRiskKeWAx0IebDVTnx8/laQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751898224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ka2koAAO3+tROI+op1wD/ECrnjtB2oeDRijPzGbM22I=;
	b=oLdQj7w6rp2lEFRFkMh+ONSpzZtd5/N2PkjQgXRAbk1ek4rE7upMlj9n/6EtqgvuUbze/N
	UZEfKwD/mzFUeJBA==
Date: Mon, 07 Jul 2025 16:23:39 +0200
Subject: [PATCH 1/5] selftests: vDSO: vdso_test_abi: Use ksft_finished()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250707-vdso-tests-fixes-v1-1-545be9781b0c@linutronix.de>
References: <20250707-vdso-tests-fixes-v1-0-545be9781b0c@linutronix.de>
In-Reply-To: <20250707-vdso-tests-fixes-v1-0-545be9781b0c@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751898221; l=781;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=EayZOtBL90f6QFOcAGcEUumSQBoNWVZo7dcWx+htwY0=;
 b=4Fv5mHOXtXabazVRNfTKCITGj26jMVQ5H7pNwRmgfmbTrClLmSx5R9vQiztpknw+28XdHnegz
 MB1dH+1wXlEBZU+/Jv+LnTDb+A86dXXw0GcBGmsvqjebrNmVPU1CdSC
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The existing logic is just an open-coded ksft_finished().
Replace it with the real thing.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index a54424e2336f4597e67668052b62cd7d6c0531ff..63eafb5ac0bfa407a527343f4d587e5098454f1f 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -232,6 +232,5 @@ int main(int argc, char **argv)
 
 	vdso_test_time();
 
-	ksft_print_cnts();
-	return ksft_get_fail_cnt() == 0 ? KSFT_PASS : KSFT_FAIL;
+	ksft_finished();
 }

-- 
2.50.0


