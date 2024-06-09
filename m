Return-Path: <linux-kselftest+bounces-11510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73963901634
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jun 2024 15:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3121C20AF5
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Jun 2024 13:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4818F3FB8B;
	Sun,  9 Jun 2024 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiZMaXM/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB181D69E;
	Sun,  9 Jun 2024 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717939296; cv=none; b=HYfj9/XlLBCmFd67X6SU8YZA9MPD/+68F9tYgJgUpM1LXbi0btlhAiTQldYYlve+9XpLjDS0iVzRjEBZ4xCY2yzPBcAe9lC8IewRVWq0suptrQvvZ8+RnowBsECc4FA3qNeB+/6MgJnW1sl+Nx60EPoOoa+Ka+LbvBY8J9qSqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717939296; c=relaxed/simple;
	bh=9pn9W8B7uNfw0jbZo+jlaNOaWeedhFMhqvK+JM4rNFU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fYGmH5VkeBDic/BNqs95jmthpGv+eAF/pxsymzxGpmVBhu9Wvnci4qKwpixds5v2mbBXzGNKUzg4zBGWI2cmZ8zmFru+etwCQfJA7KO8ry6Oucqe4g9J0BEtbFi4bIvDOXyxa5uKRUEfbg7QA8z95HfaLx75IxUnU4RWhwe/XH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiZMaXM/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f44b5b9de6so28737335ad.3;
        Sun, 09 Jun 2024 06:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717939294; x=1718544094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy8nW4eF/FXEr1hbXhu1qJIvLH5QkU3nseaSanuQg7o=;
        b=kiZMaXM/6yr9dNJnIOOvga5Z1OdcI1jZX1W5tnK51KrwXswULAySQR3brfB0Au15k4
         0227asYnQqZQ5OMPfc4hx0XmdGPklK9g+7ARukmu1Zi+XXwpC7UOH4o0h0mZeyNWTOBm
         CkK8nh0ryKZMFapzaEgciac8qZR5IHPnyL/yJ3xyYMOFEq6/EwbQnBhers6GxVP2wuWx
         xR4orSFJTAr4SiclM48lglsim+6RwJqoWe/YtHdIYujyYwob2wan++PTKfsQRZ4kzoUG
         MhUfbNUINfW+vtvGergBSzF01tkIpWxOW6SKX99i+0Gaiu7rrW2Ojj8z5Gu+Q++4rTCX
         dBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717939294; x=1718544094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hy8nW4eF/FXEr1hbXhu1qJIvLH5QkU3nseaSanuQg7o=;
        b=dYmUPuajqb2B8MboK43oL+QRZzya5KRT1NALvrHKX6LDVa183iUp8WahcI0/RVYA9r
         WkqeImWYjPzJk9EfqsLCujdjR6yuvwtyGNi2+VCzxvTjhDHAzVAmPaipd+tlbgIK2eTq
         pfL3YurvcwnD2E/IOtv1bSnIadDmZDo4LHScGpCoDp+MGCMbhEIORESKNSmWP6ebYsVc
         cSvmt+CGW3nHolaWj5224fRt+uZkQ0H/+U80oJDjMUGwKEu9wFUlYaWANm2OnWyf8jCV
         YEUuhw3kowwKx097pos3s9t7V2YiwHoPFym4U4MwXgva/AuY2PkPL0G+pFpvilkbEtvG
         Zm9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWw7DCvsCVPP1+PDXywAuTJfJOMIA/2dOCQJNS4crYm1iY1XX6iaDSYwUAraj4QtkKQZY6+BgbsWRiB/pUGVIC/n/URYMxeHKh1L8HV4Pb6GGSPOmMR9ahqy1lk9ZZ+ToONyP4u3vZXOgHBGQpulS2s5Zc7Mf5A8Gth95u/wjzQ1pUNufs1
X-Gm-Message-State: AOJu0YwXDUzjQFo5C1DFQI61ace+R9bLPcmBv3F03+b3OnB+/NXxcX3A
	zgpk9b9GzWd0hvzHPMkphYjvyF1OQQWZa52+9Xh+yDK+sdRmS7LUFa6ko2ry
X-Google-Smtp-Source: AGHT+IHfBquKPyzCjJaUZAs94NGY7Yw0e4VVijtTRkCgc02OKqITjVsCc+IKK/5QUnlXzGbopMoC3g==
X-Received: by 2002:a17:902:ecc8:b0:1f6:f82d:a8c2 with SMTP id d9443c01a7336-1f6f82dab9dmr30255705ad.31.1717939294180;
        Sun, 09 Jun 2024 06:21:34 -0700 (PDT)
Received: from dev0.. ([49.43.162.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e071esm64820625ad.201.2024.06.09.06.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 06:21:33 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com
Subject: [PATCH v2] sefltests: net: Add on/off checks for network interface non fixed features
Date: Sun,  9 Jun 2024 13:21:24 +0000
Message-Id: <20240609132124.51683-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses the TODO (add non fixed feature on/off check).
I have tested it manually on my system and made changes as suggested in v1

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---

PATCH v1:
https://lore.kernel.org/all/20240606212714.27472-1-jain.abhinav177@gmail.com/

Changes since v1:
 - Removed the addition of tail command as it was not required after
   below change
 - Used read to parse the temp features file rather than using for loop
   and took out awk/grep/sed from v1
---
 tools/testing/selftests/net/netdevice.sh | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/netdevice.sh b/tools/testing/selftests/net/netdevice.sh
index e3afcb424710..196b7f985db4 100755
--- a/tools/testing/selftests/net/netdevice.sh
+++ b/tools/testing/selftests/net/netdevice.sh
@@ -124,7 +124,27 @@ kci_netdev_ethtool()
 		return 1
 	fi
 	echo "PASS: $netdev: ethtool list features"
-	#TODO for each non fixed features, try to turn them on/off
+
+	while read -r FEATURE VALUE FIXED; do
+		[ "$FEATURE" != "Features" ] || continue # Skip "Features" line
+		[ "$FIXED" != "[fixed]" ] || continue # Skip fixed features
+		feature = "${FEATURE%:*}"
+
+		ethtool --offload "$netdev" "$feature" off
+		if [ $? -eq 0 ]; then
+			echo "PASS: $netdev: Turned off feature: $feature"
+		else
+			echo "FAIL: $netdev: Failed to turn off feature: $feature"
+		fi
+
+		ethtool --offload "$netdev" "$feature" on
+		if [ $? -eq 0 ]; then
+			echo "PASS: $netdev: Turned on feature: $feature"
+		else
+			echo "FAIL: $netdev: Failed to turn on feature: $feature"
+		fi
+	done < "$TMP_ETHTOOL_FEATURES"
+
 	rm "$TMP_ETHTOOL_FEATURES"
 
 	kci_netdev_ethtool_test 74 'dump' "ethtool -d $netdev"
-- 
2.34.1


