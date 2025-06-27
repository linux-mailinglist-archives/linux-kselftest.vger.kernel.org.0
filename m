Return-Path: <linux-kselftest+bounces-35984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B94AEBE1F
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 19:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B393E1C22D31
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C41F2EBDE5;
	Fri, 27 Jun 2025 17:03:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8382EB5A3;
	Fri, 27 Jun 2025 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043815; cv=none; b=CuBw0jG5JwtBbYZs65qwS+6kcpJbN7njQAqYkPgjnTEBDN3SLP2fdq7WFxJwznTKupzFadV4a2wRBKxTjE9mtXaoT/76DKeJ0X+V5MpPL8WTtZlKn4nEHSEYtzgtlpRO0aw0XQELOrMTwFu9gdXbZvg1Xpp8v+fmO4Hj+za+l60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043815; c=relaxed/simple;
	bh=5e7Gu2hSYoF78NHOOQ4u3fblm9IpAmXxrCi48b0pb34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RGUnb3eIfcoR5inYV0dA0HynXGLY+jVUfxjsK5NaVUjp7bYqDcuxRTZ7MgqSjybrzMzB92wTKfvG8AxBQRUnIOG++D8W+7gUijB8su6t/409D9Fq9NM35AFQSJLbFidlCTcOZNkyxNahD3JZma6pYILhBBHxJBKniUuISXy4VyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so88339a12.1;
        Fri, 27 Jun 2025 10:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751043812; x=1751648612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gaqp+BTPfvuWnqLQlzPe4IbE5DQFSHBJTK+OlPf0tvE=;
        b=C8VRk8MzP7fAvjb3f8uZbzOOZMgQQVH7iuwhbACM3PcmM1ENmiPxopXJGA62uiC4gj
         pXfrD6U9tyRofxZ23zfyurLICFDB55h1gD/v9Y4rBKEWLU0SAySEy3WX6QoZyjPjm8s2
         kkbx3QbfTf+Sd/7Q7/Q5XzsdPt5/Cp32mppQ+xjandwGlABJ2efh+KbjlMq04jJj7r9x
         dAfzN7N6Ja2vYRMgT8y3XArS0QurGWjjVo3HIhHXePyidEGVjf+b+iMIyjUsCWpo7NE+
         qAefcoPNuVZJCCBH0jsATitn9ijZMPSwwV+bXPvXZFCbnI46IsDk/bKB5Q6KTeAi9ts4
         nLmg==
X-Forwarded-Encrypted: i=1; AJvYcCUPKKxtc7xKewAWYSNyvlhJSLlX2kHr/1zKlm0xnXu8KRlEIFF8x/JSncPwFjzM1ybPGsQk1OD3@vger.kernel.org, AJvYcCViAculXkI9T/k5NjOQccE4JrH+RVNqolpDoA2U7hckefyvC2I1+46Hu9Ugu6RrxyShNK6TOlrr/SISLTvaZsYi@vger.kernel.org, AJvYcCWnZTs4Te0FPTw8lfjoBG4PRHTF4qIkyYX/T/++O6VTaoi2sk5POIa4BnErY0AmQXJelUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxl4Oe4CqFRttRsZd7TK2nMQcnJewD41h4hWP7/blxHVkx6gXd
	/HJmGcbp2WQXcXWFGjFuEPwt/wXHr+Yj5mLLCjI2WZUu5dFSxIcs92h0
X-Gm-Gg: ASbGncvk7kb02s6fK6ny4Bt+dSIalxYs4NRu3riCNnsfe+F/tYm0NCErnguauAIzdFT
	X6PXVeOOuVkDBVGNCucen0T8zmneiSmuSTfYnBK5CCzJquK+sFzuwpVssh0wqQQNmS2i525uGzu
	a399YoZS6J6bVCZkkcRm18Dyvo3/Z7rcnVmAXIb35q5x3NMnPWuE6ifFcun4/Di4RIBmG+n/46O
	w408oYngAOVFnRhhqHafnfo5vMuwQaW8/HaP+I1YiFv7M7SwwNtLxpA7TbbM3QRu6WJBLFSvBBV
	uBRau94Wemht7wiFg9APPEUptHl53mn97VYyrhdiBRC/WIrVBxdT
X-Google-Smtp-Source: AGHT+IGcpd2RBzfznvsMkkE7dTrxjGkTpCXn9DI4b+VvJ+kG+66wytl7b3Z+kpXzv/bAyZ8RG0Y81w==
X-Received: by 2002:a17:907:fd16:b0:ae3:51ac:12b5 with SMTP id a640c23a62f3a-ae351ac18c6mr337729966b.46.1751043811989;
        Fri, 27 Jun 2025 10:03:31 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bc08sm153290666b.131.2025.06.27.10.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:03:31 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 27 Jun 2025 10:03:10 -0700
Subject: [PATCH net-next v3 2/3] selftests: drv-net: Strip '@' prefix from
 bpftrace map keys
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-netpoll_test-v3-2-575bd200c8a9@debian.org>
References: <20250627-netpoll_test-v3-0-575bd200c8a9@debian.org>
In-Reply-To: <20250627-netpoll_test-v3-0-575bd200c8a9@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 ast@kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053; i=leitao@debian.org;
 h=from:subject:message-id; bh=5e7Gu2hSYoF78NHOOQ4u3fblm9IpAmXxrCi48b0pb34=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoXs7fB7F/EbtkQdJXy/APfEtmfP4ZgyvryZszh
 OmJjBPnZ4mJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaF7O3wAKCRA1o5Of/Hh3
 bSA6D/sEXSVWe/YK7PWbCg95iQPABEp2H/M+G0OAizbLnRbhL6xd69mj74nWCGK8Iw/7D/s1K9g
 GiFQzBJx5CIrQ68veRrYdTIj6CAmOChrfLMHnjS6bE1Ykh5rDD2zf83B3qoYPBuwqOq9iscqspE
 dj/zboUo8Zu4ymundsLqNwYpV9W5fwRmnuYQ7pBkwW3MPQajgJzVD4UzmL72CaSBSX1VV/ETz+b
 jKg8mWKGlEdJQk4ZcrY8MpFP6Fprq/QeQ6teeDHMZ0QUDETmXnS3Rj0dc52InG9e7FrO44qtDtu
 oDG0OH0hL/aYT6M1Mlxi3mYOLzSAamrTh+BBKIUTi9VPQnbuT/Lyi/LXWir8icatTzcPJlASUKg
 34nmMeMHOkjuHFAbqaDIb3eXLGIhiXfF80eaktqTFW9w8Ynm3/WzoGfApzOxg9Tj6o56t/3T/Mi
 UKg8dyprhLOnfBOOElyjiMELHHQ5phICIohV/2Jgo7j515FCwmC+mCdx58QmC7CUvpvuIIJT2bq
 ixspnSpu6prvmwG9yR1sOZLw4Itg638Qt85y7B5HpOY9RR5qSPizcbitBkMSLuRk0fUkQ8g0Cvh
 X1aiz7aqjZbSFH4coWaag7VU6c++hgdlVNq/fNdKfqFhl8THnngRohPsPqq5Uoc9RKMIxDFTQ8s
 6ksD7pvEE8uCTmA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The '@' prefix in bpftrace map keys is specific to bpftrace and can be
safely removed when processing results. This patch modifies the bpftrace
utility to strip the '@' from map keys before storing them in the result
dictionary, making the keys more consistent with Python conventions.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 760ccf6fccccc..33c23a928ed1d 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -213,6 +213,8 @@ def bpftrace(expr, json=None, ns=None, host=None, timeout=None):
             if one.get('type') != 'map':
                 continue
             for k, v in one["data"].items():
+                if k.startswith('@'):
+                    k = k.lstrip('@')
                 ret[k] = v
         return ret
     return cmd_obj

-- 
2.47.1


