Return-Path: <linux-kselftest+bounces-2701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBAC826558
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 18:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9B2281EA3
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 17:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CACA13AF8;
	Sun,  7 Jan 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="CC7OrlRv";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="B3r7gZEn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FEB13FE4;
	Sun,  7 Jan 2024 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id C9C556017E;
	Sun,  7 Jan 2024 18:39:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704649192; bh=KFUUL5Ps5QlFLt+OptyootqlNt7GeHExu0YP0itshxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CC7OrlRv3ITqji7BqIsy5iOBM1ku6V1jVKi0e7Lq7/7R9XlwYmJmobF01fXEZ+0YU
	 rv1a7lLiSo0+ptP6vHyAski+LgkwLxIoI/B1PfnvXGbSIbGzgmEAnTs/ibXds4d/VW
	 KhfPHHkmq10WPuhMkx5yjp0vJ85LCQsCKMzpJNdRItys4fhuaUFhz1wZjza81FFJ9C
	 6hBP2EQQv5ztI9Rf+Psk3XQm6Pl+BlU2PUimtNGxtd9z4iuvkdLj/lT2S5HnvSmRVm
	 P/ihxKY4Z0S45zDvzSr3D+67JJdXt+5kwtIcCBqoS+5Wvs4RVPmzT7mzCxMpfVjtzi
	 CgyCUeo2Dbx1w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VUVLCKoPm04N; Sun,  7 Jan 2024 18:39:50 +0100 (CET)
Received: from defiant.. (unknown [95.168.121.73])
	by domac.alu.hr (Postfix) with ESMTPSA id 3EF3860171;
	Sun,  7 Jan 2024 18:39:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704649190; bh=KFUUL5Ps5QlFLt+OptyootqlNt7GeHExu0YP0itshxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B3r7gZEnXuqYq50Ah0ov8lj5bEUVZyQnKCaI2LgGMJ9dvZzprGNgan9slwwQ6gQFl
	 3tMiyV4rE9JQs1n2tUjLoM3rLjv9FWIPhyb9qRD2m+g/a6s/Ho42y9ELv0Iy8V8TFI
	 472IpD1PfjU55yHXz9N18g9JKwWBS9SrRIYO8DRgLlgqfllWA9wvc3TyGp9KhEac16
	 GCQTVNcfxH9Amb8gQtTrmYFpCmWkmT6WTrvXX0WSnxvjw8C1YaUoANLoCWX2K7gs/E
	 XlmMAfAR1jO1jpKpToMfI8r/F1WonIITfdP1afMecOA2FL4boxQ22PyWLsuClfhFb0
	 f0n19pyhbXe7A==
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
Subject: [PATCH v2 3/4] kselftest/alsa - mixer-test: Fix the print format specifier warning
Date: Sun,  7 Jan 2024 18:37:06 +0100
Message-Id: <20240107173704.937824-4-mirsad.todorovac@alu.unizg.hr>
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
v1 -> v2:
 Changed the subject line as suggested to reflect the style of the subsystem.
 Changed format from %d to %u as suggested.

 tools/testing/selftests/alsa/mixer-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index df942149c6f6..1c04e5f638a0 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -347,7 +347,7 @@ static bool ctl_value_index_valid(struct ctl_data *ctl,
 		}
 
 		if (int_val >= snd_ctl_elem_info_get_items(ctl->info)) {
-			ksft_print_msg("%s.%d value %ld more than item count %ld\n",
+			ksft_print_msg("%s.%d value %ld more than item count %u\n",
 				       ctl->name, index, int_val,
 				       snd_ctl_elem_info_get_items(ctl->info));
 			return false;
-- 
2.40.1


