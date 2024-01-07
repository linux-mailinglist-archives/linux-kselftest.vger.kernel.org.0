Return-Path: <linux-kselftest+bounces-2696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8E58264FF
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 17:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C491F22C44
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC13713AC2;
	Sun,  7 Jan 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="Shbq+oJk";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="inMs222D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118A13AD5;
	Sun,  7 Jan 2024 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id B30526017E;
	Sun,  7 Jan 2024 17:13:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704644003; bh=Sqyazqf+I3sxa6oIV+CQ1c1xogqVDFsZgo/HDXl6h4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Shbq+oJkdaYUMvteotVpTwXoPWBX2425VrlSyVaXaPgd9BsPuyfMBcbuzGbsQPA7p
	 +neXvvTTtcZgF3N1V8zS0E0IEzclj8cWRwhgGwbNpBFrurnMhAmBMGkgN23gtq2iHJ
	 W5/JykWzH71tMr3vqiLc2g1jWefONlnnoBQQTukXIR2gqmWM17HlVbz2Tmzzw4GPHw
	 dHn3P6/BRwN25FiKq6IS+bHd1kaKN8kyA2PP2/Qnl9JY3O+gLTwJMxK7SREbVacFRa
	 n9YBGZM3GLnQZ2/A0AIHHqcl6+VW+1NR0t+4paiQ3/6wDz7SWwvUZdaQTAyAgxYC7E
	 fsevD64XuOPDw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id paAB-XWW8jKS; Sun,  7 Jan 2024 17:13:21 +0100 (CET)
Received: from defiant.. (unknown [95.168.121.73])
	by domac.alu.hr (Postfix) with ESMTPSA id 15F2A60171;
	Sun,  7 Jan 2024 17:13:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704644001; bh=Sqyazqf+I3sxa6oIV+CQ1c1xogqVDFsZgo/HDXl6h4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=inMs222DImzyXeTwjDLg1WKq+EdlfWqipP5C3iQDhW9vmioZ9aonARAmYUnc9tB3b
	 l6L6DzDmTlKqjmTJoyvzoDNNGo1vqSRuL9UcZ6qUN3npw4MAkKiKFgb42oMf1L9Q4l
	 HzP4tBL2arZMG7ThOM8uDUsTVdiYubx4PRFtTlvY/yeP69bExH7MEjz02tEugHXzf8
	 +w48AkBrZx2qszw+bFCCCc46tnVdcRPJW6I3yMAJNwq4/TdNf3K7HlT1ziCaP2s7w8
	 Qm2XRiJU8/Vy/xLbIFSJexX03sO28x7VzBn+evRR9M3cf4KqhmWQFWFjnUyxyxgixp
	 DHWZD3s6ljz8w==
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [PATCH v1 4/4] selftests: alsa: Fix the exit error message parameter in sysfs_get()
Date: Sun,  7 Jan 2024 17:07:48 +0100
Message-Id: <20240107160747.934470-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240107151218.933806-1-mirsad.todorovac@alu.unizg.hr>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC 13.2.0 reported the warning of the print format specifier:

conf.c: In function ‘sysfs_get’:
conf.c:181:72: warning: format ‘%s’ expects argument of type ‘char *’, \
			but argument 3 has type ‘int’ [-Wformat=]
  181 |                 ksft_exit_fail_msg("sysfs: unable to read value '%s': %s\n",
      |                                                                       ~^
      |                                                                        |
      |                                                                        char *
      |                                                                       %d

The fix passes strerror(errno) as it was intended, like in the sibling error
exit message.

Fixes: aba51cd0949ae ("selftests: alsa - add PCM test")
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-sound@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
---
 tools/testing/selftests/alsa/conf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/conf.c b/tools/testing/selftests/alsa/conf.c
index 00925eb8d9f4..89e3656a042d 100644
--- a/tools/testing/selftests/alsa/conf.c
+++ b/tools/testing/selftests/alsa/conf.c
@@ -179,7 +179,7 @@ static char *sysfs_get(const char *sysfs_root, const char *id)
 	close(fd);
 	if (len < 0)
 		ksft_exit_fail_msg("sysfs: unable to read value '%s': %s\n",
-				   path, errno);
+				   path, strerror(errno));
 	while (len > 0 && path[len-1] == '\n')
 		len--;
 	path[len] = '\0';
-- 
2.40.1


