Return-Path: <linux-kselftest+bounces-844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 765757FE31D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 23:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D20F1F20D48
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 22:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B163B1B0;
	Wed, 29 Nov 2023 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="e3Wfw5lx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF373173E
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 14:24:49 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfafe3d46bso3270245ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Nov 2023 14:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701296689; x=1701901489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nkjwf60hOQWmCO9wJUuBcwdkxaN20yzfTfsYdyEt6b4=;
        b=e3Wfw5lx9+Z9mcTqPC5ur7+2t/bdm86ClSLUqmv+rk8LfKhOhwEuXIEDWF3bOKv4al
         whUn1CL7QXRq0j1D4cehIZgvLWZcC60Z89YOB1W5pb2C1Nv99rNHuhAKjD2b48TT+Vsq
         5qRojGKwmk4HnimwS1hMK8+vkW6oR1xaJ67S07dAw0sG8HPSdPy0t3H4z4LKUa1l3Zo4
         nw/O6lDOLtrZgx/WH/ogv1Syr6o6CcZFx2IAXughjfXwPnXt5RnXkKeojgdQS780jsK9
         DcOolm3f23uG1ARO26NqSMr6Afof+mk717R8elQDLl8+uMmOdQsXXAAHaVwbtinHJsfQ
         +pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701296689; x=1701901489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nkjwf60hOQWmCO9wJUuBcwdkxaN20yzfTfsYdyEt6b4=;
        b=mx6vz8+rEK1c0Ue0UkmLe1kAicIlGidu08GfuAJSqZHZh9ay05nuez6tqjtfgJaekg
         B68nTyZus6+CpdfD24srRTmQeoBCt8kfxin0qSaDtAfdqg4euXG0jFA8DQZEdbAzurjh
         roTssgDFgRtPYJXwr3nociISLKeUd1/206V5Os9qTqx72uzxSMyHv7rjTlyuM6AfEx+n
         Byq+GXZfuifrBssgq/OZEWhABOgo7tKevyw+TriOAGRIbj2r2mG1EHXigKzcuc8Mju0U
         4bYAmq1rshG22m3eDCv/qfmyluKuB6qx8xF9CYARrQxnphk8wjeUuk5MyJQ+7WxdK/TM
         YAUA==
X-Gm-Message-State: AOJu0YxQGixgYIejs1So66RDMhR4n/pN1IKn0GQPr5YkQ5i4Wsxty48r
	MTgchVRqq1a46Izd/dpnQq9IXQ==
X-Google-Smtp-Source: AGHT+IGpZNbjdUjvjMHf2+Bo0Y2uskqFlYzxCP56cmcZoiUvM/fR6Dh5tXuBNfRJ7dEB7q25WMWekA==
X-Received: by 2002:a17:902:e54b:b0:1ce:6589:d1c0 with SMTP id n11-20020a170902e54b00b001ce6589d1c0mr25126311plf.46.1701296689128;
        Wed, 29 Nov 2023 14:24:49 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001cfb971edf2sm8663697plg.13.2023.11.29.14.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 14:24:48 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	linux-kselftest@vger.kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 1/4] selftests: tc-testing: remove spurious nsPlugin usage
Date: Wed, 29 Nov 2023 19:24:21 -0300
Message-Id: <20231129222424.910148-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129222424.910148-1-pctammela@mojatatu.com>
References: <20231129222424.910148-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests using DEV2 should not be run in a dedicated net namespace,
and in parallel, as this device cannot be shared.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../selftests/tc-testing/tc-tests/filters/tests.json        | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/tests.json b/tools/testing/selftests/tc-testing/tc-tests/filters/tests.json
index 361235ad574b..4598f1d330fe 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/tests.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/tests.json
@@ -48,9 +48,6 @@
             "filter",
             "flower"
         ],
-        "plugins": {
-                "requires": "nsPlugin"
-        },
         "setup": [
             "$TC qdisc add dev $DEV2 ingress",
             "./tdc_batch.py $DEV2 $BATCH_FILE --share_action -n 1000000"
@@ -72,9 +69,6 @@
             "filter",
             "flower"
         ],
-        "plugins": {
-                "requires": "nsPlugin"
-        },
         "setup": [
             "$TC qdisc add dev $DEV2 ingress",
             "$TC filter add dev $DEV2 protocol ip prio 1 ingress flower dst_mac e4:11:22:11:4a:51 src_mac e4:11:22:11:4a:50 ip_proto tcp src_ip 1.1.1.1 dst_ip 2.2.2.2 action drop"
-- 
2.40.1


