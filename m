Return-Path: <linux-kselftest+bounces-2700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6648826556
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 18:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E87F281E5A
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 17:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA81B13AF1;
	Sun,  7 Jan 2024 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="rdfO6Ikq";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="M7moKdXN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A813FE1;
	Sun,  7 Jan 2024 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 3321E6017F;
	Sun,  7 Jan 2024 18:38:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704649129; bh=1/zuAT1xloxmRYetvIowBnxOA2NzXWwHHC8Xz+UI6Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rdfO6IkqmYtUf2f9UjhS+QE4ejabMAdfcDzvyH9vkInf5Tk/mFar7LXQmxDzoL1DA
	 WDZgzNhBxG9PCle/9jsOtC5rtR7a7nKWdrzPfKEV8ir5sImTap62Qr7U0VgQX3KXXA
	 1wR1bkZgPbLRuNl1wBfG5uS/mciNpu0UdO0kT6Chrc5nUoJVZxTZspSmspZJNrdspo
	 RyN8gl5Tkjnt4qrfx/xaWzK/YSn8CzpCga1leXmw5zsVk7KywbCNcjr4FhkAe2Wc3K
	 ncH/nCFLpNUlG7fwsaWe9Cyn5qQ3vuMMjuoacnwT0FYw4I/QuTL8xGf3Z4b1Bk9k00
	 d6Bq1wnWjayBQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SD-uOkXnCArC; Sun,  7 Jan 2024 18:38:47 +0100 (CET)
Received: from defiant.. (unknown [95.168.121.73])
	by domac.alu.hr (Postfix) with ESMTPSA id AB13360171;
	Sun,  7 Jan 2024 18:38:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704649127; bh=1/zuAT1xloxmRYetvIowBnxOA2NzXWwHHC8Xz+UI6Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7moKdXNOCVMJ4+XjVAs1QGJ5uwyEFfbfqlDMdkofHwJUNbjoXsOm7Ea2cg0PpsoX
	 GRgM43w0Upd343GOEULZ3SjjL4Vf+Lp//iQieHDnKFxJ65yyqu50TIC4/164uEcii9
	 DK0GrHewuYXipLJwypTS72Fv/DqBhJfgBouP6cAkwmIQkVW9uLjnr0dWdpDCcybBSt
	 dtt/Qo0a3hy0xnzkL9tEy4EhaW7l3wlaav/3YAoXoJOShq+iKs7jeKitE/sriCex6g
	 z18/bxjMZYmUUTZmCogo5bF3e6hpsa2jY2NcPcuDoiRMEuZfOcxaOjZ4PuevJY0ZYi
	 YEdkNGEITk/JQ==
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
Subject: [PATCH v2 2/4] kselftest/alsa - mixer-test: Fix the print format specifier warning
Date: Sun,  7 Jan 2024 18:37:04 +0100
Message-Id: <20240107173704.937824-3-mirsad.todorovac@alu.unizg.hr>
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

The GCC 13.2.0 compiler issued the following warning:

mixer-test.c: In function ‘ctl_value_index_valid’:
mixer-test.c:322:79: warning: format ‘%lld’ expects argument of type ‘long long int’, \
			      but argument 5 has type ‘long int’ [-Wformat=]
  322 |                         ksft_print_msg("%s.%d value %lld more than maximum %lld\n",
      |                                                                            ~~~^
      |                                                                               |
      |                                                                               long long int
      |                                                                            %ld
  323 |                                        ctl->name, index, int64_val,
  324 |                                        snd_ctl_elem_info_get_max(ctl->info));
      |                                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                        |
      |                                        long int

Fixing the format specifier as advised by the compiler suggestion removes the
warning.

Fixes: 3f48b137d88e7 ("kselftest: alsa: Factor out check that values meet constraints")
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
index 208c2170c074..df942149c6f6 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -319,7 +319,7 @@ static bool ctl_value_index_valid(struct ctl_data *ctl,
 		}
 
 		if (int64_val > snd_ctl_elem_info_get_max64(ctl->info)) {
-			ksft_print_msg("%s.%d value %lld more than maximum %lld\n",
+			ksft_print_msg("%s.%d value %lld more than maximum %ld\n",
 				       ctl->name, index, int64_val,
 				       snd_ctl_elem_info_get_max(ctl->info));
 			return false;
-- 
2.40.1


