Return-Path: <linux-kselftest+bounces-2690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D0E8264A0
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 16:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E4E281ECC
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 15:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D2E134AE;
	Sun,  7 Jan 2024 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="f0cwrRRu";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="ZDvf/uO9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEF313AD2;
	Sun,  7 Jan 2024 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 6506B6017E;
	Sun,  7 Jan 2024 16:13:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704640422; bh=tV5d4KMryDA2jbxoJ8ukdvDSFSPVJmRQYS2/DbGCtsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0cwrRRuK2wXA6OfJaJc7dYOMFFU6DB5DsDKlnOShlBrqwlnKGkGYf4kg/PmHxc7Z
	 kbsY8Q7iWkrVyyO+azHanJk87KsEp53YiUjmSQxAVJH4qyzbE7etBBLPUKBF6h3FNv
	 7Y3gQAWXL7DVUKv9nrUYQ6LZpc4vPhi7jaAxOMVgVtbDVcTEI8qgHaS2i+3hBs7YKa
	 +kYv1rw6AldYOBkb4c72VagJSZpdKKKizJssfSM/YaKc+RdsALhXJ63he40k1RrN/X
	 NF7ApBut5FcMs3fx8/Qhv2N2uA6hWVkmVrtzHX3OVvWhKaM8yFIIuhxvLYfE1u6b1R
	 YB3tRVP0laDoA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9HvpUSw8gkaQ; Sun,  7 Jan 2024 16:13:40 +0100 (CET)
Received: from defiant.. (unknown [95.168.121.73])
	by domac.alu.hr (Postfix) with ESMTPSA id EAD9560171;
	Sun,  7 Jan 2024 16:13:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704640420; bh=tV5d4KMryDA2jbxoJ8ukdvDSFSPVJmRQYS2/DbGCtsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZDvf/uO9vYfwm5JGMaF2/dGCtCSeDY/kdVhrKSDj4ZepIY2ONCMmpTg+LqKNEUjpH
	 R54yDpz0OzVHN7A7+oFXk0IR9yhUBtV020o2dqkzMeU9A+kFqhqCelVeWxGg1DDTcn
	 M/gm6SzWhc1E0FX7o7drTE4j292G2BQyAIKipGdrnR6UjjDaK3kTqpDcqo7C61GuzE
	 ewUI0D0VP312veICLXbnUAU/NlQCNKNuQodVvXVTM7L/+sgy0n1pYhDkebriRa8N9H
	 9akLxUg/zptD93ShWT8x0if4WEKSTrDQ3eIQbgeJo1KOmovE26PJwM0MDBQa/9EjQ4
	 Q5kAXnQ5Vg3Pw==
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
Subject: [PATCH v1 2/4] kselftest: alsa: Fix the printf format specifier in call to ksft_print_msg()
Date: Sun,  7 Jan 2024 16:12:18 +0100
Message-Id: <20240107151218.933806-3-mirsad.todorovac@alu.unizg.hr>
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
---
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


