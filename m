Return-Path: <linux-kselftest+bounces-3470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CF283B0DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 19:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD7F284429
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 18:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077C012AAC0;
	Wed, 24 Jan 2024 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="A6uOWj6U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD31128366
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120394; cv=none; b=CV+qotf4dtESoGg943e818d2gVIB9+msfSIoKA/GCVNyPD0BfUHvNmpqDKp8qTtgDhlM59Dq4lPxdRdToDJf/5mx7WFcpIY4VV1sazbYme+34TfGZqpNP0seGh1stU5+eXUaTya0oJs+EnJXFBuYzB9HlraBsFjcQGQzH9/pV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120394; c=relaxed/simple;
	bh=hNio0nD1Jw8dvozmdpvI20LoAzPAeMst7QlmZwbRnt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e+OWZeEIOMl0UprPDJpYmQHRdgq9apgcyEvhKPV+S0+5PyyjEGrwsLvxinwtACji3Jr0Mf3j4SCIe/O2BKoLGbaICHmSUh3FFDz7dMlOfQPi5M1Z4DSocYzn5J4p1eoTv9moXCrKJVJ6lxdklA/bQYBcLqyynguPgCYeqM+JyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=A6uOWj6U; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d74dce86f7so30085025ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 10:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706120393; x=1706725193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0aWr6I4AG0v1dbSwbiagBcAQfQgpKpYJbEuHRWpjLo=;
        b=A6uOWj6U5i0UoGPJvTGMcPcmXCZI6zkYgsoKdbAHiuiTvzfajgBqeN+jR5JR3bAM3c
         1eRkxhjW7eYIPECldiIMdbIHuRCdYq8jifwXitoNyolPSZScqpbx7Kw6JF1bArNMM2Nh
         gblauNJbQVz+taZ2UMHLRSxOvZ7i29bJ7sjQwJhiW3yABALVVKGPaMkoYbG9KiQNklHy
         8B7S9qkhZCnZX5DhODs6sMPgCx+0y/K+yInIwVTFjE+0U9hZFdWvlIDYrLzjhJpp0D4f
         KFU2CSls28+iTC4CrLvXaaRqytnWyzqrhCcxoNYAEUYqv4WCb/vywAAGSh62/03MnFIF
         g7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120393; x=1706725193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0aWr6I4AG0v1dbSwbiagBcAQfQgpKpYJbEuHRWpjLo=;
        b=iQ8RJzuc6zalroVsZKLKFiobqJxEegrxgJnXJ3+4i1HF8BiNazaDE2t1BrDC5DnH++
         66k6VDBjeZh9M+f0yI+pRdoLEToWRp4IKf7/fb+ipZbFN2OjKvdS1kfV2yO1ycbCZctu
         jV8g0mH+FITOuk1uz6tr4Yk+jXcEb5KeCJl75Qk2iZxuwlT1Wfrbv1p+/II77HlIAW9A
         6w7Cv1FWKrXeyMrEEp9E2qRcXpjk+qn8tav+Wcgj/zuRkddOk6uwjvv8ZtcBSI7PkoGx
         rTMxzgs2WBJWwoJ5FNL+rg/V3uqtej5cYbNsVig3ubY6ldzdVrrfeMx4GSWNEskKj4wA
         SGXw==
X-Gm-Message-State: AOJu0Ywqq8vAmlxtxiXx/rnZJWVrn09CWpiEfB7pXZwe8Q31hJ+JsRDJ
	2A98QtceBLtsduQQccLFNzJ9rr5+UKrMWuGHa1fjanBRgAlqu3kFpB8ZcG6cpA==
X-Google-Smtp-Source: AGHT+IGFJE4RbbGr5WYcVqee/dmkBr8WSFOLXJPlnoWSCitf6cV2tXPONn5YpfcnHAoHwd2vVHCnXQ==
X-Received: by 2002:a17:903:1c5:b0:1d5:e4d6:1e07 with SMTP id e5-20020a17090301c500b001d5e4d61e07mr1570669plh.33.1706120392870;
        Wed, 24 Jan 2024 10:19:52 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id kd4-20020a17090313c400b001d74ce2ae23sm5577084plb.290.2024.01.24.10.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:19:52 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	kuba@kernel.org,
	vladimir.oltean@nxp.com,
	dcaratti@redhat.com,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v2 1/5] selftests: tc-testing: add missing netfilter config
Date: Wed, 24 Jan 2024 15:19:29 -0300
Message-Id: <20240124181933.75724-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240124181933.75724-1-pctammela@mojatatu.com>
References: <20240124181933.75724-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a default config + tc-testing config build, tdc will miss
all the netfilter related tests because it's missing:
   CONFIG_NETFILTER=y

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index c60acba951c2..db176fe7d0c3 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -8,6 +8,7 @@ CONFIG_VETH=y
 #
 # Core Netfilter Configuration
 #
+CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_MARK=y
-- 
2.40.1


