Return-Path: <linux-kselftest+bounces-15111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AA594DD19
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 15:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179761F218FA
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 13:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC7715855E;
	Sat, 10 Aug 2024 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADaQnhbZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE371BDC3;
	Sat, 10 Aug 2024 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723297255; cv=none; b=iPsq0tIk+VDWNBgeN3jMtcPhMdpKurFi4qGGjj8rbqinzHnVtysG/yRBYnBfWaGrXSwx+JhnaGEVkoaJNUPbtX1+cMFwjxfOkWFUDfwol/KF9+wJHNPsLgkwD2pjkIBf8AlrMtUtb20vWBdaM5Cx/72dMoeRMtvFwYzMJo3/emU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723297255; c=relaxed/simple;
	bh=yk6ttasny1J3D+op+8fgV2T+Fh2Yvs3JM1p6vFBrwlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jdLIomwOcDvVXO6uK098nScUZTTOdR9m4lXt5jSwP4Xhaas4IcOsPne8cZEiQPx+xtChQHQTAvN6x6hIASSSMpNsLWv1Nb+J+AnBKcTDzIepv2UX1PaT7rLcOxEaCjeswIpTjBOSUkghV81zW/bQ8lSorpJeFJ/JDQgFupew0EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADaQnhbZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d18112b60so1908225b3a.1;
        Sat, 10 Aug 2024 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723297253; x=1723902053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oIwwAjy5Iz20UJn73Se6d+ha7KOTaOATTHUNr1x8I38=;
        b=ADaQnhbZf2Ib6vTmnYs/lkz6d1pvb0OLH7G5xpd5y6F12RrIX3LLhBQ1pvEsw97aBK
         TjFSvw6S+gP/Iol5Ft1BUeZ/XxuZVhX8jdr+KI7Zzs+zJgUwUfYCDKFT0P0eG1qLDZ4G
         OY3zzcSg1oIDHCCxXwavjP0rMxCnfSaSB5DZ9/pNtlbNbtjpUZDuOUiGRkhvSwQj/Eaj
         6cNs06IZN8Vb7H/nGs6NTM4UhUOkyUt5aGvvADVxOCd3h2/nvJk3orrXdsaYOtkiF3jr
         4quiWOyPeFZCV6mjc6dfmx5+wFLSZmOY+1yO5h4ZTsMtQcPi6+TfKql3y/bAbzpKz4Gw
         iyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723297253; x=1723902053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oIwwAjy5Iz20UJn73Se6d+ha7KOTaOATTHUNr1x8I38=;
        b=r3tPp+o6G7RKBAZKeGiumJS8b+M3nEC5CgF1rm6Zc3VA7cOTiwa/xno7610o9LDIqk
         gOjb1VCxjVZZyjEMK/vAUvAiEZ7djUvIgav9a/Y3EJqRD+jICbRvn1XHZ/M5esOy+vnd
         z+3jQKvlu4VzueMyS/Rx0/AIrcNNp12tCfCs2/dyIeg5/zUjqbApXAOyID0aPOZE4CZJ
         5Tdg9fiJZJetiZAJAtF7zisgUv4iVfbGvUfwHn79pFmDZwMlpvLk1iW0in/lD9Gax28R
         Pn78/FDWd/LJM4AbV0t0Ky30h+4CaYQWZ5yAHt8S9Wjy7Y7gR7TdLheK11ZHHbaBkL/3
         OGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZOQk7yiupHuOeDVqa8TGT8aUy2q+2AvtXwd1AZBuEf1YN40/VnvuY+DPpLtEqNM0PJSdy4WvNMU8nM263q1o86pYacE6X7Wa5TlaLMpMC9exkuKcd1s4JfTeKlWC0zFq8ZiddTWROJhOAfLpJkZeGzHUggXJ9pRUYJwZE7/P9oRU+8dY2
X-Gm-Message-State: AOJu0YwSC5JcBJosx7zjmqJie+9TWL346471Lk36SEl8fjqLKj67IoQc
	exo5ar2J7LJsUeh2kkB/yfz4CVJZw9HDT/kXx0rMJHPc98ChKDWS
X-Google-Smtp-Source: AGHT+IExiQpL1Cb+/WY8LHKl3DRJ5Z7MF/uPfBQEGpgIhL4Ls4ntCAM3NIr2gJJXh53Pk+wScMSBKw==
X-Received: by 2002:aa7:8d53:0:b0:705:d6ad:2495 with SMTP id d2e1a72fcca58-710cc90db8cmr12742395b3a.12.1723297252805;
        Sat, 10 Aug 2024 06:40:52 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:43ae:d83d:a773:c8db])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58c7e49sm1294474b3a.93.2024.08.10.06.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 06:40:52 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH net] selftest: af_unix: Fix kselftest compilation warnings
Date: Sat, 10 Aug 2024 19:10:37 +0530
Message-Id: <20240810134037.669765-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add proper type cast (char *) to the buffer being passed to TH_LOG
macro in __recvpair function.

This change fixes the below warnings during test compilation:

```
In file included from msg_oob.c:14:
msg_oob.c: In function ‘__recvpair’:

../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument
of type ‘char *’,but argument 6 has type ‘const void *’ [-Wformat=]

../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
msg_oob.c:235:17: note: in expansion of macro ‘TH_LOG’

../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument
of type ‘char *’,but argument 6 has type ‘const void *’ [-Wformat=]

../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
msg_oob.c:259:25: note: in expansion of macro ‘TH_LOG’
```

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 tools/testing/selftests/net/af_unix/msg_oob.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 16d0c172eaeb..66d76ab38251 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -232,7 +232,8 @@ static void __recvpair(struct __test_metadata *_metadata,
 
 	if (ret[0] != expected_len || recv_errno[0] != expected_errno) {
 		TH_LOG("AF_UNIX :%s", ret[0] < 0 ? strerror(recv_errno[0]) : recv_buf[0]);
-		TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
+		TH_LOG("Expected:%s",
+				expected_errno ? strerror(expected_errno) : (char *)expected_buf);
 
 		ASSERT_EQ(ret[0], expected_len);
 		ASSERT_EQ(recv_errno[0], expected_errno);
@@ -256,7 +257,8 @@ static void __recvpair(struct __test_metadata *_metadata,
 		cmp = strncmp(expected_buf, recv_buf[0], expected_len);
 		if (cmp) {
 			TH_LOG("AF_UNIX :%s", ret[0] < 0 ? strerror(recv_errno[0]) : recv_buf[0]);
-			TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
+			TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno)
+					: (char *)expected_buf);
 
 			ASSERT_EQ(cmp, 0);
 		}
-- 
2.34.1


