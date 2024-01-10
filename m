Return-Path: <linux-kselftest+bounces-2808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E7882A08B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 19:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C6D2810B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 18:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975ED4D5AD;
	Wed, 10 Jan 2024 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oYZMg65v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301D4D58E
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jan 2024 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e490c2115so20505225e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jan 2024 10:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704912917; x=1705517717; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z0heHeyuUTmHqc6WZOFLnzwUnJCGatTB1E3vLULOVOM=;
        b=oYZMg65vLORI2HN8FquB/zRMRjARN0ARGVYxB3e80ex4K5uBVgFM3VzgGZUrhMpi63
         s+SuuLp8cgiTYydZDVBLOM06zx9t5ILJyDmc9g6+vqOUHUnfI0ywQlwbF6G1kvgm0aF+
         McmWpYN2aaD/XjRf2Go7saVHnP453W6CNoIZAKxVQm6uqM6iAP+jz3533nwIjhzCNjsZ
         vm1MUqw/V8ZYljHKiDwL82Qe90e/ZpmUXBDXFz4n/wVhvuvkEM0FLnpNPv+HIy5Vbznc
         I+0qAA1eanSzcSnFAtHH0OwH8LhFJEHjJj+bfuXCK2A93q0Dn52awyX2MZALPt7Thm4p
         zSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704912917; x=1705517717;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0heHeyuUTmHqc6WZOFLnzwUnJCGatTB1E3vLULOVOM=;
        b=OEFFhtZA4+luhpgyD8V1Ym0+lVCrcMesI8aDt35kz1FcUxP672e1pki77n3dizuSlV
         f3sRi9E8MqqTe+qvk7tyknAL0K0+jzNsPe9U4oFtlNy8UvD8FBU9bIbUAT+IMNFP0Nvk
         x114AOloBNujo/IPDpmbsIQtlQ4YKb2BhfF8b1VTO5kLlGszsL/AdoizNqP3LaAexKKE
         LLWOOuZSVBnSws7DoDoOhhGoRQ+25pPwiMzcSQ63z/K/cqc8xR0yPTCrzIMyuGStOmH2
         Ypq9+dWbpu+ulz/64ZUr3We3nlqG+uzicKLZh4PCRC8eb3qk1lEdD4OlVhVDTx0B9Tv5
         Ordg==
X-Gm-Message-State: AOJu0YxXPeo2qmv6svD5DWmEeTJqLulLiAKRA4gbAGIBkWwJvHT8LkBj
	//aJAOpVYSgNCGB0tSoSl7IQluv2Qs+KcQ==
X-Google-Smtp-Source: AGHT+IEM0jKMx5+uh5t8yJmIAPqGgdHDwnXaziqsLv2Sw+DeZd7EQHkXyVTKgZI6Sv2oN+2uILkifQ==
X-Received: by 2002:a05:600c:c86:b0:40e:3edf:1057 with SMTP id fj6-20020a05600c0c8600b0040e3edf1057mr315129wmb.0.1704912917773;
        Wed, 10 Jan 2024 10:55:17 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b0040e52f0e207sm690567wms.0.2024.01.10.10.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:55:17 -0800 (PST)
Date: Wed, 10 Jan 2024 21:55:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "davidgow@google.com" <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] kunit: device: Fix a NULL vs IS_ERR() check in init()
Message-ID: <dd938a86-38d9-4d62-abd0-1df80395fbbd@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The root_device_register() function does not return NULL, it returns
error pointers.  Fix the check to match.

Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 lib/kunit/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/device.c b/lib/kunit/device.c
index f5371287b375..074c6dd2e36a 100644
--- a/lib/kunit/device.c
+++ b/lib/kunit/device.c
@@ -45,8 +45,8 @@ int kunit_bus_init(void)
 	int error;
 
 	kunit_bus_device = root_device_register("kunit");
-	if (!kunit_bus_device)
-		return -ENOMEM;
+	if (IS_ERR(kunit_bus_device))
+		return PTR_ERR(kunit_bus_device);
 
 	error = bus_register(&kunit_bus_type);
 	if (error)
-- 
2.43.0


