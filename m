Return-Path: <linux-kselftest+bounces-2105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6562C815DEA
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Dec 2023 09:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933A41C212DF
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Dec 2023 08:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6838F1859;
	Sun, 17 Dec 2023 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPHfFAp1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238821849;
	Sun, 17 Dec 2023 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cd8667c59eso485016a12.2;
        Sun, 17 Dec 2023 00:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702800034; x=1703404834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WMyHbtuF9x070zlYFlq5kNsBiUOhZsD2fvl4NV4fsLM=;
        b=gPHfFAp1XI8kMnHt0v5bcaU8zFYTvszoK63wUMjV9M65metworo/NENROVYeXMhaGb
         r0jFBKwwGXQ84hn04qf/ino7KlsjdHOduCHzkl2YHc9uJckAwiFv7TniCyPiUOTWEn09
         cCVeDqaPTO8MzYe9EZxOJPObPZ68lKaLvO7IDY2VHtMCTIJh01lqX8PSM0WrYI2a+xRj
         ck6iP0HiP3wydJE605EAGTsforKKNaPBKuF8vtCF/KgRi/TRcjuRZQ7ljPn7kONox3YV
         7EtI+Vv/vN09PxgmHMO96wCgD8WzX3SrQRtCsrG9Af1RrxHxfepfyB5lPM22ouygUTrT
         MFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702800034; x=1703404834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMyHbtuF9x070zlYFlq5kNsBiUOhZsD2fvl4NV4fsLM=;
        b=vC2vnxxPCppfYrMVZXtwwW2uPQFhZ/UXa/tv2MumSwQ8cxDGtMOYlB4nQ6I3o2uLLz
         UtgyAvXNDWLfC4c5HjS3mvUk0roPORbwir/y0Pp1Zn1sS3q/vqdSElJ6JbvKKHRrCVH8
         TA7aF7vmv/y0Yl0hEfnbD3B88Vfzji966L/wV6v7SIcPEIi5zoBAw1BA8f9mO/Rk+7Ww
         j9yY4mVGm7O/g/XujP9zkEXqXkxIOsrQgxa8+x4GA+glBUht1N3Kpd4xMnkq/bNWP4I5
         zq5+l5NGmeXe/Fghk4tq0dKg+HPLgL97T7IximGTXl3Oi6pL0/P9OouBckb7+iHZF3VM
         QQ/A==
X-Gm-Message-State: AOJu0YwFmWCzAQcAqKBHjDXM5AWzRGF2t+l3iFI2NDUVDN5vjw88glKs
	3+xbwcy227tHas8/A/R8gjCa8RTXXD8C5f06
X-Google-Smtp-Source: AGHT+IE8bPJ0WDJ5dY071qkIv1Hb7eWdGaRmiaLbbxHuMA6GH6jqt39mgAFLTszZuQoGrN5+Xs1glg==
X-Received: by 2002:a05:6a20:7fa0:b0:18f:97c:977e with SMTP id d32-20020a056a207fa000b0018f097c977emr20432258pzj.102.1702800034239;
        Sun, 17 Dec 2023 00:00:34 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3bca:b037:bb5b:1703:a617:d897])
        by smtp.gmail.com with ESMTPSA id pb7-20020a17090b3c0700b0028aea6c24bcsm4092397pjb.53.2023.12.17.00.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 00:00:33 -0800 (PST)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	shuah@kernel.org
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest: alsa: fixed a print formatting warning
Date: Sun, 17 Dec 2023 13:30:19 +0530
Message-Id: <20231217080019.1063476-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A statement used %d print formatter where %s should have
been used. The same has been fixed in this commit.

Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
 tools/testing/selftests/alsa/mixer-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 21e482b23f50..23df154fcdd7 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -138,7 +138,7 @@ static void find_controls(void)
 			err = snd_ctl_elem_info(card_data->handle,
 						ctl_data->info);
 			if (err < 0) {
-				ksft_print_msg("%s getting info for %d\n",
+				ksft_print_msg("%s getting info for %s\n",
 					       snd_strerror(err),
 					       ctl_data->name);
 			}
-- 
2.25.1


