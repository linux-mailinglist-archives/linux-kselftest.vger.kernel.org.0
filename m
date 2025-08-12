Return-Path: <linux-kselftest+bounces-38754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CA3B21CFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 07:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBB0683974
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 05:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE652DBF5E;
	Tue, 12 Aug 2025 05:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4kmQJnX4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3q2OxSex"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B7C29BD9A;
	Tue, 12 Aug 2025 05:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977159; cv=none; b=dVOcey6g82Kc2xZi37nZSkP55f5jm6WVr5/Kns1M8rYBotukjf9vLJ2xXzJ/ZbdsGoF98VO36gcjtbeLoI5j4KwXnkyTrp9ItguqLYmRbAYQhw5gE8/H8eJq+P1ofxSgQjo5DxasbOPf1fXOvi/9uYZeyAskRcPlDs4qImKI+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977159; c=relaxed/simple;
	bh=lMvy9mMPLigV58NneqZctebN68FvSQ2op4StQi+D6+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iwqxKON/pnY4TCFWKkZzQ5g1+l/DlJiYONECFfYUHdt5glBiqpNA3j5VWUkPVuHcfaf1CuzTxjWFiBA33o5WkZ64t9Ql2rUMwpLoAIZV9rokkAoLPX+2qxQ1wPOMdcwmsceQOIKzKo3lzgswDS+nt+fx0DiNi61Ykac0sKCrT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4kmQJnX4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3q2OxSex; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754977156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xp075UorUyCKambMQFG4NnP9kfsQ1yKOIo2P32aHiEE=;
	b=4kmQJnX4iqNnAk3etQNIjKPcZLG+lYQD5nwEnmMYeHCMTCensgl/YOrd6CqQGTTy5KZBnj
	E9R3dKxPQcU4zUQ2prbQFwI1GAI6ebXHE/k6v2w/AoO2MvXinaOcfVm00WZDi20jLYNULi
	YG5xlCdLdEu61WormRTZhklYw6qAdn51zEs1EpCRVmauVsjwf+MbDnjRrJ99kgvRPKPEog
	r7S2w0MwmKngIkGy5Xdur4hbgKh30YJOoisSn9Srn8GSwTzNG9NhP4khsUsrSBew2tlzwG
	wanl2iVjTRys1HXflbcjUZCu6a+g41dLWtA78SEVn0hTV0uCiyC7zVRN1/DsQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754977156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xp075UorUyCKambMQFG4NnP9kfsQ1yKOIo2P32aHiEE=;
	b=3q2OxSexCawFa7Rw+Zhbi7N0KnXGrG1uMWRJLNAGpOdnvX6V1Z2pq/MbgiOM1L3CPNPKo3
	6s43HKNMLxaMvZCQ==
Date: Tue, 12 Aug 2025 07:39:04 +0200
Subject: [PATCH v2 3/8] selftests: vDSO: vdso_test_abi: Use ksft_finished()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250812-vdso-tests-fixes-v2-3-90f499dd35f8@linutronix.de>
References: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
In-Reply-To: <20250812-vdso-tests-fixes-v2-0-90f499dd35f8@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754977153; l=781;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=lMvy9mMPLigV58NneqZctebN68FvSQ2op4StQi+D6+E=;
 b=cJTN0KcIPZ1MTyBCAO2az+bCeFUJejhDBlgM8cdz8Z7SLpkhqL+8E5kIR58vJieGjEaHgUZW7
 uCvEtrIVk5FDKyReBy+j1OisgxfQZ6Pg47LpE2feS/4Aro2K1sSbXIg
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The existing logic is just an open-coded ksft_finished().
Replace it with the real thing.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index 67cbfc56e4e1b0edce50d37ae145a054e304892a..b989167ec2472d1f8369e61f13e535b15545a6bb 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -231,6 +231,5 @@ int main(int argc, char **argv)
 
 	vdso_test_time();
 
-	ksft_print_cnts();
-	return ksft_get_fail_cnt() == 0 ? KSFT_PASS : KSFT_FAIL;
+	ksft_finished();
 }

-- 
2.50.1


