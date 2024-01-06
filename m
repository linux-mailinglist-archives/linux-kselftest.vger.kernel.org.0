Return-Path: <linux-kselftest+bounces-2683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 548BB8261AF
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jan 2024 22:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4651F21E02
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jan 2024 21:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA613F514;
	Sat,  6 Jan 2024 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="io8SxOGU";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="wiG91a4O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E07F9C2;
	Sat,  6 Jan 2024 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 1BF036017E;
	Sat,  6 Jan 2024 22:22:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704576138; bh=HEghdAHf2OKYHZqGEPG2Q6QZWWANdcfdstEIe037x7Y=;
	h=Date:From:Subject:To:Cc:From;
	b=io8SxOGUCiMm6CxLIoDDO1c8jF0PaeopV2fNsqrx4fyShU60orB7FQYAzI67Tklu5
	 rP9OconP2IY+XKiKCHpujk8YoMEYnxjrGLDk/Gi5WGaWXivbUl+qF9UwzeI2SQh/JN
	 LvySEXgKAF8ktYfPRK2dXp/sRoeV6/yRx+4TOTeln8EZfIT+b2Ld9KF5mMSPk1xY9U
	 Mdgc/ncsPeDjNKEyheTqekjkSWx4Zz95mVMzFXDXjimEphCZx99xRFhdmGBS9X01lB
	 Dn0APyqZ3BKDFRGtCBgi6UAhJinweevMDB7W37KPr7nyUkpYkaJtRBrm1ymoHo6jK0
	 JWGQ4xWh8GfMQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cIT5aPRSWNP9; Sat,  6 Jan 2024 22:22:15 +0100 (CET)
Received: from [192.168.92.51] (unknown [95.168.116.36])
	by domac.alu.hr (Postfix) with ESMTPSA id 4623F60171;
	Sat,  6 Jan 2024 22:22:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704576135; bh=HEghdAHf2OKYHZqGEPG2Q6QZWWANdcfdstEIe037x7Y=;
	h=Date:From:Subject:To:Cc:From;
	b=wiG91a4O1YSbVh1kJaOISQh8b5bRvI3j6zYRL5qSNUMgUrBTpsNqqNuoHvedlAHzd
	 hSvdoq1Vv42xtP7PFRC8nkHLWOvySbYOa5VPOOPZTn9A5l52kdJf+ndPmE0wRTIlB0
	 sKJBH2N02e52x9rHgkuZZEHA1U5KNdMETwg+4NbDRSNPKyxAZBvoLLshmIC65Ic23W
	 JN1uafLN2sZK5k61oQ+shmyLxoyQ4o1vmh83upRZgsDypAMxnMxfEx2mRELkybx16u
	 DokFl5yYHe0YOtQbR9Mzih3NywomTeAQ2Itct0oDhhudLDYsCiQytROdeZT/OWMZQS
	 FrUap4rmPcZLg==
Message-ID: <36c37fba-fb1f-4e7e-bc92-c75b426ea72c@alu.unizg.hr>
Date: Sat, 6 Jan 2024 22:22:14 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, hr
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [BUG] selftests: alsa: conf.c: wrong parm passed to printf [FIXED]
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, all,

There is a minor omission in selftests/alsa/conf.c, returning errno where there is
strerror(errno) passed in the sibling calls to printf().

The bug was apparently introduced with the commit aba51cd0949ae
("selftests: alsa - add PCM test").

As a diff speaks like a thousand words, the fix is simple:

Regards,
Mirsad

----- cut -----
diff --git a/tools/testing/selftests/alsa/conf.c b/tools/testing/selftests/alsa/conf.c
index 00925eb8d9f4..89e3656a042d 100644
--- a/tools/testing/selftests/alsa/conf.c
+++ b/tools/testing/selftests/alsa/conf.c
@@ -179,7 +179,7 @@ static char *sysfs_get(const char *sysfs_root, const char *id)
        close(fd);
        if (len < 0)
                ksft_exit_fail_msg("sysfs: unable to read value '%s': %s\n",
-                                  path, errno);
+                                  path, strerror(errno));
        while (len > 0 && path[len-1] == '\n')
                len--;
        path[len] = '\0';


-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"

