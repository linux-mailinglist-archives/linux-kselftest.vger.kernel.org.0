Return-Path: <linux-kselftest+bounces-2691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B57438264A2
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 16:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60F02B21821
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474F8134CE;
	Sun,  7 Jan 2024 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="K3lWZT7r";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="meAJJHVy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B42413AC3;
	Sun,  7 Jan 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id DEFE66017E;
	Sun,  7 Jan 2024 16:13:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704640432; bh=UQMDbuI7hDMHLOqvTe8W5mN0lKSzuLSjkDfcH/BL+qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3lWZT7rZ6eExSqrlRb5/4PAZEvJ247D6e+xfyE0PxOrhpbTxH6oIhWbl1ttTX0ju
	 MoHcbTVcFsY5DBRpHX0uxbOwi8IP3Hw4yscS7qJjqvpGlJk+O9abvYc3X/HJWkjzjm
	 KrSzZ1X2sMjvi3FJ22yCZldnDWFybzHI+Db2wYLRCkTw89Uc/gk1U89G0Y9JxJg0wU
	 QRAfZQ7a3l2NP/0IWuWqt3DbU4WtWBPtwe1nPnsw6ODpPbTh02xElHSbMfx5VjtiXE
	 CoPbglB82xk/Sn3mQBoAIK0i2s/VeOpKnJmVutL0V/yYI0jL4wwmoZb4qq3FfpBa2w
	 sCKiZbt8lJX1Q==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dMbbvhzBhNU3; Sun,  7 Jan 2024 16:13:50 +0100 (CET)
Received: from defiant.. (unknown [95.168.121.73])
	by domac.alu.hr (Postfix) with ESMTPSA id 602D260171;
	Sun,  7 Jan 2024 16:13:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704640430; bh=UQMDbuI7hDMHLOqvTe8W5mN0lKSzuLSjkDfcH/BL+qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=meAJJHVyehXP/Ai4sQQqf/VyhWjBz5BIXpTzSZSF3fWKo/kNZr0+DnJl2e8j/IGTX
	 i0im6A6Ei0kJEo5mjJX/+NPEQpngRDA+pPEOWk4UeVGZ+DAbnZFtU6ldSr3uhqNb4m
	 h8sGZoV7P46MrBZmyRIAIC5OKg6r10dFo9JUU6E9pHtK7gdJ0p1sJoyJ6kV5Aa9z10
	 1/UGt9v6OESKZ0Q3ysFHApeR/xKCP6XQGOm8uH0DgvZLNqXQVEJZl0P4sOxRPcY8XK
	 eoK1jhk0zqd+v47UOPpkgn2VpcWgpHwzSX05fLISGJ8rucweNPzW6SvjVO9fxIR0nP
	 UqMjgRPwA9yFA==
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
Subject: [PATCH v1 3/4] ksellftest: alsa: Fix the printf format specifier to unsigned int
Date: Sun,  7 Jan 2024 16:12:20 +0100
Message-Id: <20240107151218.933806-4-mirsad.todorovac@alu.unizg.hr>
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

GCC 13.2.0 compiler issued the following warning:

mixer-test.c:350:80: warning: format ‘%ld’ expects argument of type ‘long int’, \
			      but argument 5 has type ‘unsigned int’ [-Wformat=]
  350 |                         ksft_print_msg("%s.%d value %ld more than item count %ld\n",
      |                                                                              ~~^
      |                                                                                |
      |                                                                                long int
      |                                                                              %d
  351 |                                        ctl->name, index, int_val,
  352 |                                        snd_ctl_elem_info_get_items(ctl->info));
      |                                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                        |
      |                                        unsigned int

Fixing the format specifier in call to ksft_print_msg() according to the
compiler suggestion silences the warning.

Fixes: 10f2f194663af ("kselftest: alsa: Validate values read from enumerations")
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
index df942149c6f6..e3708cc52db7 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -347,7 +347,7 @@ static bool ctl_value_index_valid(struct ctl_data *ctl,
 		}
 
 		if (int_val >= snd_ctl_elem_info_get_items(ctl->info)) {
-			ksft_print_msg("%s.%d value %ld more than item count %ld\n",
+			ksft_print_msg("%s.%d value %ld more than item count %d\n",
 				       ctl->name, index, int_val,
 				       snd_ctl_elem_info_get_items(ctl->info));
 			return false;
-- 
2.40.1


