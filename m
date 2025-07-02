Return-Path: <linux-kselftest+bounces-36312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90615AF13AE
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 13:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D0C1C2309A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 11:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF7726D4D9;
	Wed,  2 Jul 2025 11:21:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E79267AEC;
	Wed,  2 Jul 2025 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455274; cv=none; b=REv61tdYF296TMrvtWEl/n6uLEhMh4Mj7+D3vFg6NQbqG7rYytKdnv0nwkWQ5RQDII+HvUAI3IFwSBvwID1z3bfUp5HuXEJNeuZgPKpMUR6D4MTzD49gpmlxGQkkk+Vg9Cn4+F6q/mznNwHdTYtvMNk8vbR2v/u7ETmdOj3lsm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455274; c=relaxed/simple;
	bh=5e7Gu2hSYoF78NHOOQ4u3fblm9IpAmXxrCi48b0pb34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JYv5mWLoGIIktjJpnyHvrhlTc2h0Ia+PepTkrez5fIEfjbviaq2LjoFpR3OyK2mP5KqN//oTn5KCWSbOP+xWrdpMTOoVKwNX7cALcTuSRSQTZaU++nRZ8v8xEBa3OpoRkLP3hScC/X1yF0ApnhlqycU4KuZxYAJZIzUayWtWdWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so24061866b.1;
        Wed, 02 Jul 2025 04:21:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751455271; x=1752060071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gaqp+BTPfvuWnqLQlzPe4IbE5DQFSHBJTK+OlPf0tvE=;
        b=mFTDY+YdXk8zopoBSkOqY+Icgzsa2cwq2l9HwH5ZD6q547tTgmhN8OyP22mMKQr+cZ
         JJiJ5lnMKu3ILlHR35CguBw4JqMGHHobT/pfFa/RQs9r6VOCLkYxv6JEkxNjmYFKnbaN
         RM1eIzCCGWn30qXmkYH94/ZeRS0IJOB1Hi3fcG9oO+H48SrIqOLDJfjhkw9VBERWha9s
         CovvbT/ga+Q69zWJi2CA6Wgglz5uE6fIBVSzvGijIQ/oQnUx1OGuG5alvYDIeJtcKnK8
         HITzpaGQjuasGmW3uHMejGTsfD7Rrey/hEjQqOZx0FEtM4ct9pJ4xR5Fbwvcds0tb5j4
         MDbA==
X-Forwarded-Encrypted: i=1; AJvYcCV2XOwJGKUQ5Asc/9qaKivRf5fqM6+G30xJY6S8jBdgxWF+ne+pc+4UForZ49gALvyT4hM=@vger.kernel.org, AJvYcCVtDl2rT9m1Ota7P6j4BVWrJwfIfqO8ETdPMBXgf5N9Arkwt9VUAYftWxvgZcMPF0+CXdnsVgnPC/pzrjwCMDY0@vger.kernel.org, AJvYcCX0grO8AekaqTZzdR608aB4Zwo7s3hNlqDzP8lYHWBUdR3d0VkcYGnrO7rSBv5kgnybidaoUN/D@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhm8ZANK3ue+LEwG/x8zkNPTyCc7295H/jIY8lbx22FK408enl
	cR1sPbOmy62RGSg10efBH3C8kJGOwo/NNYeSpdE25Ovpiuzga1ODkbxX
X-Gm-Gg: ASbGncvJ+70C11+pR9jFIlEikxnATUidv15zwQJCXetndxdcZyi/SpVG3k398e73/zg
	spsiZmBpPutr7rzpD1h/CDvL+qSW682Kb0LXV4279EQCD7aNLIjdvfXeTxVkhzjVKkfsoPEgQMI
	7mo3wQgiljzU6rTh9LGDxy4CGRP5QbHGxtmcjNui+xQVv+1GcEsBxRaLQNjDex+US2vVCNuleVZ
	H4lAAL5OvL4yoV8NlDTRTEgjzNESYCQeiV39wY0RGSjPyx/dn2XkNsIcm8W0bsCiaDmNHqa+gXK
	50nRHdXJGFX3B6t9qtOu3Dj/UrjpaVKeG2t1PiiGlJ3j1etWBhPK
X-Google-Smtp-Source: AGHT+IEDMdTX1CxQMkgRGRYE/ObcPbJRaUJjkn8KHQ8Bisj1r7G4rCh2u1YanIqxelOJpwlxdpeE6A==
X-Received: by 2002:a17:907:3e8b:b0:ade:32fa:739e with SMTP id a640c23a62f3a-ae3c2a904e4mr238897866b.2.1751455270920;
        Wed, 02 Jul 2025 04:21:10 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca1cb3sm1057800466b.157.2025.07.02.04.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:21:10 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 02 Jul 2025 04:21:01 -0700
Subject: [PATCH net-next v4 2/3] selftests: drv-net: Strip '@' prefix from
 bpftrace map keys
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-netpoll_test-v4-2-cec227e85639@debian.org>
References: <20250702-netpoll_test-v4-0-cec227e85639@debian.org>
In-Reply-To: <20250702-netpoll_test-v4-0-cec227e85639@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053; i=leitao@debian.org;
 h=from:subject:message-id; bh=5e7Gu2hSYoF78NHOOQ4u3fblm9IpAmXxrCi48b0pb34=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZRYiYTBEtC3JkZ9ocdPcMBXa6dXyLxUCB2y0K
 sLcAsA6DzOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGUWIgAKCRA1o5Of/Hh3
 beTND/90rxGg4w5ITQE4iXr8TojvxUfs73oXVK7rzP9kn+KibVoOikS2sqsB8Q4JcZK48UyFL8N
 3dgfhbp3wAUloZHuOlF1zHQJRA+QJmOvpG+rk440yQZFbnag/g1xgH/lzAlnM4YAtF45vy5NWx3
 xWktQrcZTtYm42H6n7LfJa+gw8sLJy+fLHVMXKsAcd3bx2GsftIKoKHXszdgNwuNDuomtXR6ZLA
 vD+Du4nefPtSvWZ6w/ohZ6rFYvfCA4RsKvr1zAinrx7nFmJpoLP1hy4mV2+2fVPG38Z+fwImuy/
 Pw8T4uGKDXYEb+Ny6hgqKh9b1amGKsz9MkleaC7K85SqGzbkGkGW3zPUJJ+BecqubOitPv4GDaL
 4msu2xoMEbITgeMyDYq221+ZJiqYU8k0oDLsTUTF85J9gKdxRs3iiHbUQRsyOObWeTXm4BStnw5
 e7bck4YCQwh0U6kMx5tB1LCMX9mDII+nrWA0qC53RKAgBfPh2zdnhXbduXGX244bBkqe8qelVXp
 ndqTQPxHGbIOdayJxcFbXg+4G0fpuRUatn35zk/ZVCnPGh3ntEgIRHHOZcPslxRnq2H6F0yhWtB
 rIIJvllAUpwKWb2TtU7jyTTFNdmNqtzMg+vGWeBenBepgXJtQmqkjoG61ewlPObkDqzS/8Unr29
 VhzhsGPYkamhpAg==
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


