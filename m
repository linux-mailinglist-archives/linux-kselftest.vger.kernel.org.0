Return-Path: <linux-kselftest+bounces-2689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE06882649E
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 16:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493001F21817
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 15:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C82134A7;
	Sun,  7 Jan 2024 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="YRB3Faw+";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="edSH/fKF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112F413AC7;
	Sun,  7 Jan 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 421FD6017E;
	Sun,  7 Jan 2024 16:13:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704640407; bh=oa+XGhT/ayVSmnqOJ4svklRVu6puchkWx2tSViCPAS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRB3Faw+O6GsNsP6bB2nDodpQKpY1uC9U4AxmEHJO9t0R5Ep6SVnURkWB251g+1Hf
	 Al/yM8dv9PiC96K1K9ILE+EnFoq1pPLdCdMPJ5ViaNB3Mj6snPUuGVNy9S5k+N3s23
	 fXQV41x+4KPybN41jAX8QeyINETviRwqzDh/a7AmBbSdwkzfcCGdWzU3YY2DXEoFIE
	 GQy0arEo1DlOaxaCB0cpZEA49KdgxyfCYJDplTYzV03eeXzgBi8/K7BqJeOpXILIpn
	 zVeorPGixB9ZTBBb5s0wB/kKKhQXaXfmXXhGbfNO8kJNV+4XGuyfuDLSVgy+/4lQtc
	 rTRVxnLPN+g4g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uMOS7E8uQ4Pl; Sun,  7 Jan 2024 16:13:25 +0100 (CET)
Received: from defiant.. (unknown [95.168.121.73])
	by domac.alu.hr (Postfix) with ESMTPSA id 9574560171;
	Sun,  7 Jan 2024 16:13:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704640405; bh=oa+XGhT/ayVSmnqOJ4svklRVu6puchkWx2tSViCPAS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=edSH/fKF0D8WIDroa8qVX5azrRTOjjWl1kBs7rt2G6X+pKfVHIQ7w7zGBEJijsIVD
	 wHw0QCqxUmGkNlCAw5khVasse7f3s89/4IIfmAU08fK/LMfAe0bBaxlf/FJWQYa3dq
	 hOI3J+I/lW4syt2cs4f/xKMwnPsCkUp5Myfto3iu4gp5OPfZ/L1+M8Rngtp9YDsQcR
	 OgtgFzkkJbtf/xOk+KouvMyl1GHy9VmLgXdlZoPurzrGi2F4M/pF0WBwfzGLFzk41s
	 TDAui9Bjh/tP9QTojInacxl/mjowI5bROC81EtBeBZS9wSD2ri+fXEb3N3JSwQ0dqh
	 TJRyIYPbCHjpw==
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH v1 1/4] kselftest: alsa: fix the number of parameters to ksft_exit_fail_msg()
Date: Sun,  7 Jan 2024 16:12:16 +0100
Message-Id: <20240107151218.933806-2-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240107151218.933806-1-mirsad.todorovac@alu.unizg.hr>
References: <20240107151218.933806-1-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix the number of arguments to error reporting function in the test program
as reported  in the GCC 13.2.0 warning:

mixer-test.c: In function ‘find_controls’:
mixer-test.c:169:44: warning: too many arguments for format [-Wformat-extra-args]
  169 |                         ksft_exit_fail_msg("snd_ctl_poll_descriptors() failed for %d\n",
      |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The number of arguments in call to ksft_exit_fail_msg() doesn't correspond
to the format specifiers, so this is adjusted to mimic the sibling calls
to the error function.

Fixes: b1446bda56456 ("kselftest: alsa: Check for event generation when we write to controls")
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-sound@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/alsa/mixer-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 23df154fcdd7..208c2170c074 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -166,7 +166,7 @@ static void find_controls(void)
 		err = snd_ctl_poll_descriptors(card_data->handle,
 					       &card_data->pollfd, 1);
 		if (err != 1) {
-			ksft_exit_fail_msg("snd_ctl_poll_descriptors() failed for %d\n",
+			ksft_exit_fail_msg("snd_ctl_poll_descriptors() failed for card %d: %d\n",
 				       card, err);
 		}
 
-- 
2.40.1


