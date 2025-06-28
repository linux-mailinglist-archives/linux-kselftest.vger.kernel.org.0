Return-Path: <linux-kselftest+bounces-36029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42537AEC5C3
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 10:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5754F7B0753
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 08:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB4621C9E3;
	Sat, 28 Jun 2025 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7tmBUqa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837B1194C96;
	Sat, 28 Jun 2025 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751098774; cv=none; b=gYXChT75bhL08l4GDbSyxuVDwiXdY7Vy+AuLJGNGHgWj4pj6wQqGUPGWD+99ydVspq7fMmWBtgVDG6b/CFc6r7O5chNjansDRWX6SLSEcc4cwKnwDr/atFM4Ha6Xq00Kp8V2KUyWb4E0tN8PGP8iyAZIGAFm/sfQ8aPX0JEUTJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751098774; c=relaxed/simple;
	bh=vGNfRkI1Ht/vZZSyNnRPELCivIfmFv4UkOlehvExCuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgXkcCMmywJglUiUMmclLrhhwMr9c5Pi8Jfb0rkS8UuLfT+pvkRWEkAAnDHVtmM5HOVJEqKIZHevCiw1gvE1jZK8mr+BiBNb+NPuAh4kL8vrgPcZTX20EixEQkHI/g0xQf6W0jBGOb4O7ZlohyxEoyMLV9obiUgAgzeUOKkvX8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7tmBUqa; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23649faf69fso2692125ad.0;
        Sat, 28 Jun 2025 01:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751098772; x=1751703572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSplCVftVr/wTrQpkKjU5PeSgpWAa37BgkpUhHExLMM=;
        b=B7tmBUqa3O4l0YcnzUMEGEzQ0D8bRU6iBmgiFteEZl3bXsTWJ5A2YmbfT105YyYz9+
         9RJVApGvzvzxmGxk5d+mHSpO/83rWr3QZBp9jCSm9wUtTceCVVdPJm0IRZWQ3OiGfvbx
         1jbfcwt3w9p8el73bZfydJsnYpYypl9pORgukM2ezLv/d6fgs3cZ9zZ7wW+0SHCHeESg
         lbMGp4wZJje45Ys8vq/K55tmKsffmR7MWyOnlN6fgYW+uwmovgM75d5FX4gMHnTXGo22
         Ht3/jAWKac+onYJXbrwHdVwBM4QPCzNUyr167LKmyX3cd/wa2cG7pYMTpMqSKyCE7Eaj
         ShBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751098772; x=1751703572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSplCVftVr/wTrQpkKjU5PeSgpWAa37BgkpUhHExLMM=;
        b=bM0hk41apXYeWjsvffAHtUvudBWKXqmid0iAC5rTeMzJjCoD43c29OTN4Hn801BKPm
         ddFltmrCOgAjc5KY1NhF4/tXvYVb0W8a1prTFCfdjFfnbms74qS71E1QDJ/mQWk3jbaZ
         tNMD62btVDWP4X0DA5QtaSD13YlvC5WUV7ZEj4EgglN9DsdCNmBburSTvvVokQ6hrLkI
         TdRZcNj3ySPyh7voAUSsS28KsJe8kBtrPW0Cu2IKh905aUG6yOewZS4u3sgIPq3cJk3S
         YPL5PRNoQ3aTOr3sOqyLoMYSVV+xuR0EbbLioM8WRYckZdOtYhanXn+hTj8QgQk/SiP/
         79xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPCUPoFXrujrClREqRmRoJ1FEAHD9HrlLruJIlFMBpCUcQj2XDj+sURzvPVh8qbIyJ0d9yp/uo0RmRea1veG9a@vger.kernel.org, AJvYcCX7+VrzaJKpeWYEvQt2kiGHPvBob90WQ1UbE3zyJcGryItjKep6Q0w3F5qwz2eGf+oxqz8zvVZi+sO7pzo=@vger.kernel.org, AJvYcCXzkv2BKVKuyubi+hX8gCPQWIFCSVcg9XSVSyiW0h4iGq6++XCff+7Nx/UwrE3t89sVZgR7jpmK@vger.kernel.org
X-Gm-Message-State: AOJu0YyhEfN4auJ8Qb5qNiGeINnjXphVek4BpU/BC8fbm2n8hgI0tTU4
	VJY5Up6js47Sl5gE3ejISl2rU8f17IsdkggcSuJCBw6jk9iu9GoGBCAX
X-Gm-Gg: ASbGncuJfHohy02uW1nlXf1S+q3NEBvgh9gpW69oNzVNHUxccWZ2T7cN0i6U8V6GcgO
	qu54apWNhJU43dcScjtjL4P8DhCQL+iA4BNMxRQVvik8g7pz62TFTDwHYEKbpAiWyQxnI1aGLll
	E85neUQrK5mboZzyyC2wCa85j2uAMbSCxXnkNvyZ/5SmSlasMlPDhQh0X4TDTF8RQLpHN8MWKEh
	/6R1Ew4aCVzf+fb3KZGPm0LbeeKWSFtb4dBCaqatnJZSnpXQ5+DZ6jUtltDlI4IopQ2K3S38vwU
	z1bPdGOlLj3G0fc42RnpgtNEirfUHtj6u8Bv/37gdeW+TCFdjT1r/hK/X6KpAbkDNTSUNRPkPNJ
	r+6fnHosz11BVDPnN3/dsxCySzFtt60mXebc/3D2Y3YdQ
X-Google-Smtp-Source: AGHT+IF6qXl72BIwujEzmJ3ZOgtwyVgnob0Ze3maCTk80T3RK4dcMIbcG7yRFp+0VlCYmQYS2Vp2IQ==
X-Received: by 2002:a17:903:3c23:b0:235:eb71:a37b with SMTP id d9443c01a7336-23ac48833dcmr91556825ad.46.1751098771715;
        Sat, 28 Jun 2025 01:19:31 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b78dcsm33566855ad.171.2025.06.28.01.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 01:19:31 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: horms@kernel.org
Cc: Malaya Kumar Rout <malayarout91@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: net: fix resource leak  in napi_id_helper.c
Date: Sat, 28 Jun 2025 13:49:16 +0530
Message-ID: <20250628081918.523857-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250626083512.GT1562@horms.kernel.org>
References: <20250626083512.GT1562@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resolve minor resource leaks reported by cppcheck in napi_id_helper.c

cppcheck output before this patch:
tools/testing/selftests/drivers/net/napi_id_helper.c:37:3: error: Resource leak: server [resourceLeak]
tools/testing/selftests/drivers/net/napi_id_helper.c:46:3: error: Resource leak: server [resourceLeak]
tools/testing/selftests/drivers/net/napi_id_helper.c:51:3: error: Resource leak: server [resourceLeak]
tools/testing/selftests/drivers/net/napi_id_helper.c:59:3: error: Resource leak: server [resourceLeak]
tools/testing/selftests/drivers/net/napi_id_helper.c:67:3: error: Resource leak: server [resourceLeak]
tools/testing/selftests/drivers/net/napi_id_helper.c:76:3: error: Resource leak: server [resourceLeak]

cppcheck output after this patch:
No resource leaks found

Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
---
 .../selftests/drivers/net/napi_id_helper.c    | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/napi_id_helper.c b/tools/testing/selftests/drivers/net/napi_id_helper.c
index eecd610c2109..47dd3291bd55 100644
--- a/tools/testing/selftests/drivers/net/napi_id_helper.c
+++ b/tools/testing/selftests/drivers/net/napi_id_helper.c
@@ -34,7 +34,7 @@ int main(int argc, char *argv[])
 
 	if (setsockopt(server, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt))) {
 		perror("setsockopt");
-		return 1;
+		goto failure;
 	}
 
 	address.sin_family = AF_INET;
@@ -43,12 +43,12 @@ int main(int argc, char *argv[])
 
 	if (bind(server, (struct sockaddr *)&address, sizeof(address)) < 0) {
 		perror("bind failed");
-		return 1;
+		goto failure;
 	}
 
 	if (listen(server, 1) < 0) {
 		perror("listen");
-		return 1;
+		goto failure;
 	}
 
 	ksft_ready();
@@ -56,7 +56,7 @@ int main(int argc, char *argv[])
 	client = accept(server, NULL, 0);
 	if (client < 0) {
 		perror("accept");
-		return 1;
+		goto failure;
 	}
 
 	optlen = sizeof(napi_id);
@@ -64,7 +64,7 @@ int main(int argc, char *argv[])
 			 &optlen);
 	if (ret != 0) {
 		perror("getsockopt");
-		return 1;
+		goto failure;
 	}
 
 	read(client, buf, 1024);
@@ -73,11 +73,18 @@ int main(int argc, char *argv[])
 
 	if (napi_id == 0) {
 		fprintf(stderr, "napi ID is 0\n");
-		return 1;
+		goto failure;
 	}
 
 	close(client);
 	close(server);
 
 	return 0;
+
+failure:
+	if (client >= 0)
+		close(client);
+	if (server >= 0)
+		close(server);
+	return 1;
 }
-- 
2.43.0


