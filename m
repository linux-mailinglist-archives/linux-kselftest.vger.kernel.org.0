Return-Path: <linux-kselftest+bounces-38031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6056BB13F8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jul 2025 18:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EA617138E
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jul 2025 16:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211FF2741A2;
	Mon, 28 Jul 2025 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctyGDkPu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BB51EA7C4;
	Mon, 28 Jul 2025 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718600; cv=none; b=mf8wD1IT8XDSIVDwXuZf6kNVaInPIT5lvpGW7DwmvJMsPjNboNuaSC25ulvSKGIR5DM75nVv2t04xRvBYVPcAvhr3rNL7q25Dpst3FMkdp68a5Vbk7mjlnpTPQrO79Te6+B8XkX7EZYUMRYB2ki1G6GzNDZplXcp5yEMCnXbKQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718600; c=relaxed/simple;
	bh=Vd04XinkrY9V6s58I+0wLyccYoaGwzVbLbsZih8Qz1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V4ZGN3xcwj6F8eYsVrPHb0NFtuLgsyWuE0ID8y9b8Ai/Fqyk66kMaBiNsbgB+q6vmbnacv0HAjOWXre8UKWmer9EtQxgxPl00WEScIJFQhKu9Hq4TS+YWA1OElxteqX9FU1ZaYnjDz3EIeqH+WxvKL015qGlPZ/JfcefwQdBBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctyGDkPu; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31ecd1f0e71so1595163a91.3;
        Mon, 28 Jul 2025 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753718597; x=1754323397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YUDQg3XmWX+OAIimODJTb+EgGGX3athOf1YMNT5RADU=;
        b=ctyGDkPurbiJyWka0eJN9M5jgIeBqz4DH5MBwXL//CsCPsgHroD+cRZx3oqmyYgKSY
         9brsSKYxOUqyK6cmWvu3litYuIUe0ubntRO+4X22KD6CRSq5retELiQMczX8wyRJ+MZK
         ELkI9IoofkThs3tHK0kmcaeb0HbHIhBWvPGKuikU1ERSnoska+icXPEg7lV4J41aBr/d
         fMu5ASIlc+yvmpB5kzjh34ncZSFuoYDewyqPdQFbLsb9E0bECh0eJuKFPYHLH1MAa4+t
         XeSKqCq1ufFQbiILPhE9MwS8ZA5JWc80+/wUucho9CBvucnKZf+7ojUVnKPMv1DwlKNR
         8ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753718597; x=1754323397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUDQg3XmWX+OAIimODJTb+EgGGX3athOf1YMNT5RADU=;
        b=clKg+/JT0hd9zKMPKpWnOMp/PdNNqiZxmcZEUCVpJVXPZqTRxMPxdDaOX5czSkSO0R
         QsLk1hHT4J4lrpLa3cF0gNHOsEcGMW749ZA1JohdzqBpjn1TeWD+qcCfgG7DstRDplT2
         TB2q4OfwKppNQ2gO7+puBF4cCa0oYaUA1urScxZkQP3bnoZ91q8X1UD2ekjmpHGkQBtP
         5RhDnz5Mtx/ejrPRwv2ZG7y5WCVZJbd9mWAEbaC89dvAEpH6SloOOH+7G8AuJSsreT31
         YkgogBMkt6a6IEbnEZTSFuLCfFLk22St2BvUzHcW6GuLK/p0iZ0ie9edg29uqDQSO14D
         FESQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6VHZUL+SGaIFFM20GdO4vX2VZuDutYvk19SnsDDLw4KlzE5VHckj2pLdXJrq59VDgEoT2OPsOTRwMcV0=@vger.kernel.org, AJvYcCVBx1QUqMziNpT+1f56iKTMP2YbUu1dTIp9OKet92AZ4XqMKEMlyhVLuTrjMVA7Rx1MRZYZxzBWjczSFWvf75IC@vger.kernel.org
X-Gm-Message-State: AOJu0YywZOmGkhlGc0ZaHyKRFJDgPDdlzLRcsVFwTaOcPz+r8Ll8XlWO
	qmqd0KCLl49VsjW4+o+29k3JWlNc/rsO/P6dVaeuqqzc/jJ41ZU+zjur
X-Gm-Gg: ASbGncsoa2FqYqnuV0rrCKD3gbiMaInqHWcUM9uQfM7aHMGmG4Xye02FrLAg9JhQyxM
	3RGVKAVtsRJjwG32Y5pDNod1eGtqNQpCvhl/FBuIUIJ60z+UUp7QBpYghe0S+l0c3QJIHwMN1v0
	VMoDPdIUANL0putn+dEJd/NdYirNTWIzsD9KgegLYSKKoYR3K6f37PEIIjXWlXGZREuWPJTJBCE
	Wt85cptBjDSFn07g1DlmZc+Kf5wdOWY874yDUTr0odm+7VJ70GJ2G7ltlgo2v6GND4VpCK9uNU6
	EjgeQgzPpvuf2jzmy2WyKFp8nf4VysWtUpwtp5g8asZeGTJGZb6lcMj+EH4OScdnv+LY2+7+OAl
	VYAY5JAHg0A/46nPLvkWNhFjinOLuUKO6WxF2sWl3TA==
X-Google-Smtp-Source: AGHT+IHaJeGJgN3n9xkUV3EFeBxZWRIywWMNHTWB2XQ49uze3qWPpkHUwhIPfszwfiIgoObUO/x9jQ==
X-Received: by 2002:a17:90b:3c0c:b0:315:cbe0:13b3 with SMTP id 98e67ed59e1d1-31e77a0a590mr16261994a91.7.1753718596566;
        Mon, 28 Jul 2025 09:03:16 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d021:481c:67c7:4b27:6088:74d5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31eb413d7basm4401098a91.16.2025.07.28.09.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 09:03:15 -0700 (PDT)
From: Vishal Parmar <vishistriker@gmail.com>
To: shuah@kernel.org
Cc: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	jstultz@google.com,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vishal Parmar <vishistriker@gmail.com>
Subject: [PATCH] selftests: timers: improve adjtick output readability
Date: Mon, 28 Jul 2025 21:33:04 +0530
Message-Id: <20250728160304.929942-1-vishistriker@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reformat the output of the `adjtick` test in tools/testing/selftests/timers/
to display results in a clean tabular format.

Previously, the output was printed in a free-form manner like this:

  Each iteration takes about 15 seconds
  Estimating tick (act: 9000 usec, -100000 ppm): 9000 usec, -100000 ppm [OK]

This format made it hard to visually compare values across iterations or parse
results in scripts.

The new output is aligned in a table with clearly labeled columns:

  Each iteration takes about 15 seconds
   ---------------------------------------------------------------
   | Requested (usec) | Expected (ppm) | Measured (ppm) | Result  |
   |------------------|----------------|----------------|---------|
   | 9000             | -100000        | -100001        | [ OK ]  |
   | 9250             | -75000         | -75000         | [ OK ]  |
   ...
   ---------------------------------------------------------------

This improves readability, consistency, and log usability for automated tooling.

Signed-off-by: Vishal Parmar <vishistriker@gmail.com>
---
 tools/testing/selftests/timers/adjtick.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/selftests/timers/adjtick.c
index 777d9494b683..b6b3de04d6ae 100644
--- a/tools/testing/selftests/timers/adjtick.c
+++ b/tools/testing/selftests/timers/adjtick.c
@@ -128,18 +128,18 @@ int check_tick_adj(long tickval)
 	sleep(1);
 
 	ppm = ((long long)tickval * MILLION)/systick - MILLION;
-	printf("Estimating tick (act: %ld usec, %lld ppm): ", tickval, ppm);
+	printf(" | %-16ld | %-14lld |", tickval, ppm);
 
 	eppm = get_ppm_drift();
-	printf("%lld usec, %lld ppm", systick + (systick * eppm / MILLION), eppm);
+	printf(" %-14lld |", eppm);
 	fflush(stdout);
 
 	tx1.modes = 0;
 	adjtimex(&tx1);
 
 	if (tx1.offset || tx1.freq || tx1.tick != tickval) {
-		printf("	[ERROR]\n");
-		printf("\tUnexpected adjtimex return values, make sure ntpd is not running.\n");
+		printf(" [ERROR]  |\n");
+		printf("   Unexpected adjtimex return values, make sure ntpd is not running.\n");
 		return -1;
 	}
 
@@ -153,10 +153,10 @@ int check_tick_adj(long tickval)
 	 * room for interruptions during the measurement.
 	 */
 	if (llabs(eppm - ppm) > 100) {
-		printf("	[FAILED]\n");
+		printf(" [FAILED]\n");
 		return -1;
 	}
-	printf("	[OK]\n");
+	printf(" [ OK ]  |\n");
 
 	return  0;
 }
@@ -175,7 +175,10 @@ int main(int argc, char **argv)
 		return -1;
 	}
 
-	printf("Each iteration takes about 15 seconds\n");
+	printf("\n Each iteration takes about 15 seconds\n");
+	printf(" ---------------------------------------------------------------\n");
+	printf(" | Requested (usec) | Expected (ppm) | Measured (ppm) | Result  |\n");
+	printf(" |------------------|----------------|----------------|---------|\n");
 
 	systick = sysconf(_SC_CLK_TCK);
 	systick = USEC_PER_SEC/sysconf(_SC_CLK_TCK);
@@ -188,6 +191,7 @@ int main(int argc, char **argv)
 			break;
 		}
 	}
+	printf(" ---------------------------------------------------------------\n");
 
 	/* Reset things to zero */
 	tx1.modes	 = ADJ_TICK;
-- 
2.39.5


