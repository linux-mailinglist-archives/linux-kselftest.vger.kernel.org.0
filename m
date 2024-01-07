Return-Path: <linux-kselftest+bounces-2699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F8D826554
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 18:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8593B212F3
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 17:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D0113AEF;
	Sun,  7 Jan 2024 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="ridtSFfI";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="ampHmhh5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6758A13AD5;
	Sun,  7 Jan 2024 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 99BAD6017E;
	Sun,  7 Jan 2024 18:38:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704649108; bh=BIuDQXGfrKfQlcsSLLqPe3CMzmxB2CaH61qBgoQlgJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ridtSFfI/dZjdsN7u0mSF1vSHBkcuKxGTs18lgPIbEejWIu7r0KCgnJBv4DoAFP95
	 uAyM7X0BLF4uLd9P0aDhu6+b3x+NqV6OpJCd971YuaqQGq2O3t3y0Rqp5eYHm/O0Do
	 QLgUrtNf+0F4TwNuV8rLjxKXW5K96d9uuHxS7Tl3JGjsJ630GSc2OtoRrbmMC+Abp+
	 7iIOZOaoEC2IdCWmHBcPpNw6cqkOPjXoLbMSMQByI/cvwdAcg98i8OctxdeJzI+mTR
	 ElMSJ4j+0Q8yNmDGlTzp5fN9xhndie/+wrjdLpThewePU4f6xe2TkcQqQS9FDF2cG1
	 ZWoQKQK0ioDWg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KNdyY3a6zrtl; Sun,  7 Jan 2024 18:38:26 +0100 (CET)
Received: from defiant.. (unknown [95.168.121.73])
	by domac.alu.hr (Postfix) with ESMTPSA id 2907B60171;
	Sun,  7 Jan 2024 18:38:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704649106; bh=BIuDQXGfrKfQlcsSLLqPe3CMzmxB2CaH61qBgoQlgJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ampHmhh5lx8L51zbAZ/CQdmqphuDF7HcUxWe1/v+dqvb0Q9cbnK80e+hmAblmGmDP
	 zu2O5etiNPJPCrAZlva5qpMqbpNuS4mXXZrWNYXL4OBR8vbnTms5+VTHT4W/13Mm0r
	 Ugx4x1oQ9KsieL813jaRApjXCbMKu+qzN5vggZ3xZfwafgeb9SJw17cenl+Zvz1LcT
	 rgqs8VZUY4zN+/YKF/a0HRUr0Z9mRHbkpAEy2+CCUNhbNcTlb0kkGc/ftVgYRpJm39
	 tFOFSirkZ2ch8mdyaVq2m4mL79Lpzgg6kSFQrRz5Z1qtXY3cHazJuJhFQ7vgJ0S2kR
	 tj9E/a9zT97mw==
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
Subject: [PATCH v2 1/4] kselftest/alsa - mixer-test: fix the number of parameters to ksft_exit_fail_msg()
Date: Sun,  7 Jan 2024 18:37:02 +0100
Message-Id: <20240107173704.937824-2-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240107173704.937824-1-mirsad.todorovac@alu.unizg.hr>
References: <20240107173704.937824-1-mirsad.todorovac@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Minor fix in the number of arguments to error reporting function in the
test program as reported by GCC 13.2.0 warning.

mixer-test.c: In function ‘find_controls’:
mixer-test.c:169:44: warning: too many arguments for format [-Wformat-extra-args]
  169 |                         ksft_exit_fail_msg("snd_ctl_poll_descriptors() failed for %d\n",
      |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The number of arguments in call to ksft_exit_fail_msg() doesn't correspond
to the format specifiers, so this is adjusted resembling the sibling calls
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
Acked-by: Mark Brown <broonie@kernel.org>
---
v1 -> v2:
 Changed the subject line as suggested to reflect the style of the subsystem.
 No change to the reviewed code.

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


