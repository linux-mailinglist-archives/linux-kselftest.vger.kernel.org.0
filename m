Return-Path: <linux-kselftest+bounces-38094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F51B16F20
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 12:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CA216C634
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 10:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B25C221561;
	Thu, 31 Jul 2025 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="NvdMJhJV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9FE2745E;
	Thu, 31 Jul 2025 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753956229; cv=none; b=d1w1dayfr+PJlzsizUGz7n6/j/Lm33neqJp3hRcGys4sRoCCcB5Is0Urz8QvU21c96crfU+qqWPcdmB4I1Bu+gSxDTWsSCZhxMeO1J5MXi1kwDH2CzUZuWYaNprNF9kGmcFvpmedjYW3Tstnf9qTlATapo7q7nS1K7lKVM0JHoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753956229; c=relaxed/simple;
	bh=NYyUk0BfoxJSHgtRZxMOL66q4WnmVTwmsB+hSch+B8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OZ6ksSuPiMZXxPeSbpMTdfgx3J7w8uDERxkoAm2+qDaUNQuYLp1BYSDRMN6A2aq5OlCwvSDzcmuIAQwn9Y3icQTLL6H6AFw+fOWe0o/Lae0fIS2vLkasJ18550A2As9bQORxtrLxx653qWFQ7QWVNoQrv82uxIMB2QJNGOiRAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=NvdMJhJV; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1753956168;
	bh=rjKuTPuvn/0L3fRxtEWaPjXi65f2W4SFl25Z6EWsa9w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=NvdMJhJVEZA3BkeEmxiy/vk2Zgp+fln9XT34EfpZaKM4Pdfg0frx8ETWUMmX0Grfx
	 ecfRv0LsRvaNfh3/WZYXF2mD+LK4d1orTLnOCfSfiZgTRzNRYXGFuBuzoEYW74lgs6
	 AoLI9F8f6LtlJ1pyKaCeQMrjd7PfLWgnEZm0dxdc=
X-QQ-mid: zesmtpip3t1753956155ta94c3d12
X-QQ-Originating-IP: lFlTdFOtv/vQ4PDmfG4jxZM+QUOL3f0Kjketi0kav9A=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 31 Jul 2025 18:02:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11522875294285116563
EX-QQ-RecipientCnt: 11
From: WangYuli <wangyuli@uniontech.com>
To: broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shuah@kernel.org
Cc: linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com,
	WangYuli <wangyuli@uniontech.com>,
	Jun Zhan <zhanjun@uniontech.com>
Subject: [PATCH] selftests: ALSA: fix memory leak in utimer test
Date: Thu, 31 Jul 2025 18:02:22 +0800
Message-ID: <DE4D931FCF54F3DB+20250731100222.65748-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NE5ka7lUpzLLneh95ioFD3VaxWF0GXWLqZk+7lJBUb14pvtdzJD4jQRh
	IICcyN9E0JOU4TdGvLyLSj4L1faAxhmIW9znn9Ku96Y1fG1eICSyr1Xib7S0J+4R4uMnfNe
	KZ639Cz08d3etYugVyzXiNcULXnDE5+vXmoWaB0PQVNaowSxrWKL/mAAQX+NZLJdUxMIZxy
	pSAP86B5+005eh0LPVGNK+gTWCgpw4pOmuRgOO3/iTk+dEsojER+9zXvEHLJnNX7KUVdSCW
	WeEpVsA42HAV0ifEI7sFb+Qtq8Sjq8x54fNgn7eK0lf6Jo+EJVCI18DebFxhFWv9nufdPPK
	8M348hzx8vm5bRiiO/FAm14vKV5lGuIqNCTyn1r4dMcVWdfMhJbiZrD9yUHaPcbfTWQQ4GE
	BuJ/RV5WRVbp76R8+HWSX/ztqEftV94rBDxlTc9bJJJOhkVFZkqhN3kACYCaBcBTLMlD58D
	OqIKpU4k0Ul3J4yOKme5RZKDb2BR4A4Wbp0pqQfHvxxcoIJLE+cSS8whEkoSmX5K1OpjroA
	joZ+6tgvnmzCmsIDEVQ7ftrw2X0fRB6rDuJbc9g3jXR0i5OpxLQvRmuVO15D3ogzTm9Q3a6
	CUOVGks2C1gZevz/N4+rNHEz5OkiQ/xroD/IW9kkq466csGyFhkW7olkP6Fw+1YW41Tq/ci
	bnAti+UGUGIJhaw1TiFkri7ZtaSjF54xpkyQp9amDPvRdefvF490XheoNsM8WwWdUollyRa
	65cbxmjFfAHiP8ZEO0UO4L2LOSos3yFUSHxBqL9U+5lu4cw9zY8Zee4u972GCqJ4wyXmay0
	52fMUAR4EtQh/40exJdnGS/uT3U7ceZ3gDUCjUnHAfk6WcVno8xk83lTcuypFr9nt5bm5UM
	i0ZYlazgtE8N2b4WQdr+Wy0uEObxESXcjhv7nr9raTqyolcTegrKZRzAHI9zN0SmltUV03O
	+lUxr4N2R8t3/t3/jHuD6wgxNC0Kk7hqQmhvRtjBU7PmgJE0F9aD8SPuWYsc32ZFFfEMfUn
	ec07qMTVaeXEM69UCd2Zc50saWswRCQK4SCVl3Vd5hSRy0ght6
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Free the malloc'd buffer in TEST_F(timer_f, utimer) to prevent
memory leak.

Reported-by: Jun Zhan <zhanjun@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 tools/testing/selftests/alsa/utimer-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/alsa/utimer-test.c b/tools/testing/selftests/alsa/utimer-test.c
index 32ee3ce57721..37964f311a33 100644
--- a/tools/testing/selftests/alsa/utimer-test.c
+++ b/tools/testing/selftests/alsa/utimer-test.c
@@ -135,6 +135,7 @@ TEST_F(timer_f, utimer) {
 	pthread_join(ticking_thread, NULL);
 	ASSERT_EQ(total_ticks, TICKS_COUNT);
 	pclose(rfp);
+	free(buf);
 }
 
 TEST(wrong_timers_test) {
-- 
2.50.1


