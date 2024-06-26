Return-Path: <linux-kselftest+bounces-12779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E50B917B50
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 10:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D451F2336C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC78167DB7;
	Wed, 26 Jun 2024 08:49:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED7E166310;
	Wed, 26 Jun 2024 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391747; cv=none; b=uhCQSxFstm82PcQ4ic04ssmjiN5Cemr5Ry4ArKqNNx8SvACJT6Bc+v5byOzO3szLEPgxv9Hh1oZ1KfD8uSnFbENKMWrHXDynrn/NyWA9CNb2aHD/wph+U7md+pYKu+0C2pDv4c3Ujyq3J4lREtui7yD8BB+Ylz1hkyaV8RE38gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391747; c=relaxed/simple;
	bh=1ODE0XKaeMtnd8mzTknDOkALaTc8RLBP04scttwZkuE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XxmX0PQKyp9WCMvxPeFne0F6B1i5DvFfNAT7eyfeLFdHyhoeyfAHEPleqtlltm6pcJMftXW8kQt6Uv1w04NSR3FEOmIb24MqEqB8oMYPdrj1j4E90Xrqzg76o5cmtKR0oGEB+k9dWMuijXo2trNLpKG8crBk8n5Q5sZ3O/giZy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1667bd5fd0ad-819a2;
	Wed, 26 Jun 2024 16:49:01 +0800 (CST)
X-RM-TRANSID:2ee1667bd5fd0ad-819a2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9667bd5fc2b7-a3e8b;
	Wed, 26 Jun 2024 16:49:01 +0800 (CST)
X-RM-TRANSID:2ee9667bd5fc2b7-a3e8b
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: perex@perex.cz
Cc: tiwai@suse.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-sound@vger.kernel.org,
	broonie@kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] selftests/alsa:Fix printf format string in pcm-test.c
Date: Wed, 26 Jun 2024 01:48:59 -0700
Message-Id: <20240626084859.4350-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

Inside of test_pcm_time() arguments are printed via printf
but '%d' is used to print @flags (of type unsigned int).
Use '%u' instead, just like we do everywhere else.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/alsa/pcm-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index de664dedb541..914efcdce1ec 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -383,7 +383,7 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 		goto __close;
 	}
 	if (rrate != rate) {
-		snprintf(msg, sizeof(msg), "rate mismatch %ld != %d", rate, rrate);
+		snprintf(msg, sizeof(msg), "rate mismatch %ld != %u", rate, rrate);
 		goto __close;
 	}
 	rperiod_size = period_size;
-- 
2.17.1




