Return-Path: <linux-kselftest+bounces-36126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61532AEE6E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 20:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987423E0470
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 18:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578372E6130;
	Mon, 30 Jun 2025 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtcmrmQb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63DE28DB67;
	Mon, 30 Jun 2025 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751308592; cv=none; b=YkegyEnAC+4L+cfwTXdXnlYU5/gf/BbDDiwtorXnJaLoejqP6o6tdIctyOIbCEEXkeon0ndhM7n6v5NhIhW/W16l4zFra27dT3fkDRbRhBxKKmWaRjbwu1SskpHrWiSgzuE+3YvD2m87pTF8Q0PUjk93mekrKsgVGJ25fYNz/FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751308592; c=relaxed/simple;
	bh=5CGAuaHckqx/eNjnkLbHA3Vo6lu6wNyLq3v61h7I4hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZdjMS1nZ7MPaiTSjhtxuac6LeWI5xjVZslCpxVrfWa61aEIa7Vi9Z7CrMzNdSCn5yZW/grfuHhKDRGOPY1yNOlEZbJs0bUqgPGclgjYQ528wSczDRwIp2nSRWCSq7bgbpc6YouG2FMT03PRrcjLStd/eF8eTCuMvq1r5d9phHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtcmrmQb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23508d30142so30933315ad.0;
        Mon, 30 Jun 2025 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751308590; x=1751913390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biWLBiH8zreqRPHmI3WiQocvMTd6+R4XuwJA5na6cOU=;
        b=gtcmrmQbqnPuvd0jQi12yg9V+ncs25M/ki2TzqlOnheSRDxBDjjZvWJqr97mUZAUd/
         PXNgDiW36xN7PH+/7BqxA9kxYOLxj6jjMKPvu6fbrsvMmrzxAORffE8zo2kaPtX3hMqL
         wK1S6q5GXJ3+2WlLbgbDQQJ8V7vNjUfCn7JwzSZBh2W6OzQVt8ZKeFk+iUvyGaqhNcPK
         aVQzYSaB8A47anKyv6D0sHOOz5djTzLr/y4FWFl9CPiNjl1uIHpHFmwX2M3i++yeD/m3
         3JuAliKFYgLoTASbsU+wDTaJakweXux5Q8GYbcc7VGBmB28UuqXQHlYMjwAFxE3Hgsaa
         zG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751308590; x=1751913390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biWLBiH8zreqRPHmI3WiQocvMTd6+R4XuwJA5na6cOU=;
        b=axri/rrJP899TWMqJJixrxhHlasBkKjBqRu+n/9aEElwax2u6eaFBe0dFn6Cvx/8bE
         R45CMbgZ+JzjzG9DuQv4IOmj9HweSpCrOKzacWI/Mh2f41CEUVnLjYeshoyPqNnn81eA
         4cn1aE9lKWKjKGQ0c0J0tMbenGzN5TP4hVWZm8jTeqS+phiLqSEllZVXxDPdDa+AGOOC
         HPUSq4gAwVdhELUFEXkIUNUZBt06Hpe8jsSLh3+PGH5L6EdFTS+6ETXj2nGJNPIm3nGJ
         hedpaNZfz1JPsX8uy68Kl+5xyIL9Zz3j4jlbsAZmzDpf69yq5OioOG97OuPFLkZdXdrl
         GgFg==
X-Forwarded-Encrypted: i=1; AJvYcCU90WYXMtcQg4/SfhIfgmERTJ5ltCnJ2rAdT+MUaidOaAnHOZ2QgQC4nRiLpKtC7LaZDd72zuYB/5tSuQE=@vger.kernel.org, AJvYcCVZEFiiUppWCFUjHHkpmElwE2V2zvNRve29fSkElxV5cLyAhr1nleUNWqaytjMWI/D9ifJIdN/8@vger.kernel.org, AJvYcCXaRx6sSDn1PjH7xjlreqgpdirX3spfA8dPgIUzAXn4aAq2b2PkINI7prXbv3tJEqDA7OFbUVr59YqoEgKWkUGl@vger.kernel.org
X-Gm-Message-State: AOJu0YyXL+7KZ8PQKQt3hur/GQABrB1318ntxvnWDkPR5O8NDE/p9kDl
	CcAbUpp2jf/WfGYSwF7LR3wmJqAYTQDaqMBgf79KJa/LIgP79Cr4Ohu/
X-Gm-Gg: ASbGncu6WAYWB+ODEaEsDmddgUStl2PjvoSm8RRvgp2BdMGBZN2muMwYeqUTqpcVX8M
	lZVGkvzjbohlknE2t5an4wphG/vwzygVcToeOoG4JMupxTjl1WIMt2Txs+UBebLNAVwpoQmDbth
	nkFNF1K7ymPls0XyDGed/XYQGPzbmnIugrryEVl3Q5Dd2fbNDtHTtYcqtXhGIEDNBWv2JuJk7bS
	KoDQXprS8rpUUTxaIedwodiA7eZIFfO/1DbE76bU+/66SeKgPw0UENcxvausOEfWMv8mJbhNJNG
	jK+LjAFeXYETWuIpW6uaN9kZTbeqOPQi1N0t11Ywa1sN7tVBlBpOs6uvjjtEDi+JKEXgq2f1R1J
	VlOz1+TK5dA1MmC6PfuWxiQTfrSczk9ET8Q==
X-Google-Smtp-Source: AGHT+IGG+JD+4jJa0l57hBVjJA/4baaPokV5plbyfQtScN34gGySrND6hRXlSSbUb8qDQYLT4HHYsA==
X-Received: by 2002:a17:902:e54a:b0:235:e942:cb9c with SMTP id d9443c01a7336-23ac381b1aamr261600055ad.5.1751308590075;
        Mon, 30 Jun 2025 11:36:30 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39c0b8sm92008485ad.138.2025.06.30.11.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:36:29 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: edumazet@google.com
Cc: Malaya Kumar Rout <malayarout91@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] selftests: net: fix resource leak  in napi_id_helper.c
Date: Tue,  1 Jul 2025 00:06:16 +0530
Message-ID: <20250630183619.566259-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAE2+fR_eG=eY+N9nE=Eh6Lip4nwWir2dRQq8Z-adOme3JNe06Q@mail.gmail.com>
References: <CAE2+fR_eG=eY+N9nE=Eh6Lip4nwWir2dRQq8Z-adOme3JNe06Q@mail.gmail.com>
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
 .../selftests/drivers/net/napi_id_helper.c    | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/napi_id_helper.c b/tools/testing/selftests/drivers/net/napi_id_helper.c
index eecd610c2109..5581d04e180f 100644
--- a/tools/testing/selftests/drivers/net/napi_id_helper.c
+++ b/tools/testing/selftests/drivers/net/napi_id_helper.c
@@ -18,8 +18,8 @@ int main(int argc, char *argv[])
 	socklen_t optlen;
 	char buf[1024];
 	int opt = 1;
-	int server;
-	int client;
+	int server = -1;
+	int client = -1;
 	int ret;
 
 	server = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
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


