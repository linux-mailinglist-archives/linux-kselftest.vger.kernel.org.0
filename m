Return-Path: <linux-kselftest+bounces-2702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3073B826560
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 18:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC00B212DA
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 17:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5963B13AF8;
	Sun,  7 Jan 2024 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="QG2FbZjD";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="eGGexq+Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC9713AE1;
	Sun,  7 Jan 2024 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id C488C6017E;
	Sun,  7 Jan 2024 18:40:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704649257; bh=frM8T6jNy/tqSSRy15Pifi8RjLUEJa3v5iv+TAtHhMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QG2FbZjDQ2ybQ8lsbeIs0/R8VoHzNTqfdZMQ2fxG9poOC+VAL4dlD9OqWPFspHGHA
	 KtmmoCr6AsQnjj26P9GjkaVV6bApNq7C7QZ8dpQ/QI9ZK2hNtpw8dgt8/Wpsn3ezdg
	 obxBBuw4asWuvAapwWD7TMnwO5QR2lPupQdAcpdX90aSxy91c+M8mTWB3NuycAvYnW
	 WiX5rz/NInGWZMjK+ZXcERGa4hhSP/5sljgdXP9/gkFNcMfxP6PpBcrZo+SsA2nSCV
	 2hq6AHYgEgtGeOqiODEXnST8ZHvv7P2fBgkr1JFIkaQq9JZGpzMeExTaS6JsecPeAW
	 fmI4OmWl5EMHA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eRrcdnHGKZ_g; Sun,  7 Jan 2024 18:40:55 +0100 (CET)
Received: from defiant.. (unknown [95.168.121.73])
	by domac.alu.hr (Postfix) with ESMTPSA id 08C8460171;
	Sun,  7 Jan 2024 18:40:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704649255; bh=frM8T6jNy/tqSSRy15Pifi8RjLUEJa3v5iv+TAtHhMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eGGexq+Z4UYqK7zyoyr1N5E9I/lPrWDSsDwFTvIUrVrjv59xnzf0uxH+yyeYLpv6L
	 LKnwuxNAFzTKcWbOXsPNXXcXY0958rCQM6CXOOoTxW3mfU8nJzEdolYfBu/5wohGHf
	 s5ZlPX/ILMrV0KznYBudziwzo6a11Fu/J5GB/e2WUuZsYBxtI4UtvqR/fV3gfbOybi
	 k3V/0QaR5vHLgyWRAvvoqXAeojDvESXNjxqqasJyzuZlkY6egk12YGfDEOaPuvvEoc
	 ZJiH4VUBAmV5HO4Eg8Y1tYCT0vbh1zf3iyUPh3+jmOVc5r6w7aFIbG56DKwYkt/y/i
	 a5/INL1L6imfA==
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
Subject: [PATCH v2 4/4] kselftest/alsa - conf: Stringify the printed errno in sysfs_get()
Date: Sun,  7 Jan 2024 18:37:08 +0100
Message-Id: <20240107173704.937824-5-mirsad.todorovac@alu.unizg.hr>
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
v1 -> v2:
 Changed the subject line as suggested to reflect the style of the subsystem.
 No change to the code.

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


