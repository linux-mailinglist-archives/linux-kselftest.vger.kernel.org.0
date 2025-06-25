Return-Path: <linux-kselftest+bounces-35774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F930AE81AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1796F1889709
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C777D25E83C;
	Wed, 25 Jun 2025 11:40:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EF125D8F7;
	Wed, 25 Jun 2025 11:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851603; cv=none; b=hSdhf9LXi6J31Dp0HY1WkiIDL2YvNB9t/Ijt3lzeQYJxWivdOYCIzjYZVvrl0I9z20qFsEeP/3MACazXiP/4o3iVLq1MH1zKD+bhrCKs8/Ow6dy6VHTcF4RoMLU/A7reccPct4Y2vUyjJrSKm/7V9T4Ohg+pyCOQCi7kzj4u+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851603; c=relaxed/simple;
	bh=l/nda0XltKPv0ZkUvAchmFcqXkIO0WFjK5teLGJzfFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SuZM54jVmySn1X/TwRwZu79F+7KjCAYXRWa4IApo4qBohA6cB+Q0Qq4e1eDVSKguy4oRCjy1V06+Aw7iM+ViyfmAB5M+jKNMC3UtGu0g8yE7diEtVMiCkyaF6ScU0WbtR12WkYSVUsuJv/itV1jiT40mvHmJ/u6xMa7ao5hV2m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60c5b7cae8bso539894a12.1;
        Wed, 25 Jun 2025 04:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750851599; x=1751456399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qT3VxGjg5ZOgOxiB0n/oc2JG8GkxQUHlqVHQBSwcuUw=;
        b=MlYuyJA2tHEcLm2xVBr0/LfXCw3/6FoyDzChDL38N3HoG8oyhVV5rQr9wsgiJrCV0O
         CdaS/V+i4kMm6he8w5/1DuUaARbDN4C6drwO8UAMPB93hwOrmZcPaOUuMhvRruBxkPip
         ULLnm7KFKt6OSM1SLHW+TCDl4ciseiB+Ci7xewREldl1o0r7j6ocmtAu4d2cO1hQDtrG
         01yIq6zq5jIg+X1X6Jup8YUHHUmBwMCqV87b58i3bi+/vr6ulJPvJkK0Dfxbg83NzE/e
         NLQUzr+y7s5Haddq9/ahzr0dtHJylLL7rWpg/H+4WWi5Vxy5M36WCQi52kWXGTLFoen7
         w0jg==
X-Forwarded-Encrypted: i=1; AJvYcCUGeZVrOChJo+Zxpnt6+i4ImLXoZ1xZSl5rQLtYE8sqOx3NdvP41TVZCh+l9flyuQQS7jg=@vger.kernel.org, AJvYcCUe76iAQqRkp9XRQ1vdnl4xg+8AaN1n7GEVunigPFxVLNYWYF7Sg2y91ABMTO5bzvYisLsZXm6e@vger.kernel.org, AJvYcCWZRk67/KWt5a9Nxot40eD+8S5Fqux3cbHNo33g24AfpdeOCGV8fOllQJfyBv30/yEnE6Y+pp69GbmGqE5BfY50@vger.kernel.org
X-Gm-Message-State: AOJu0YwN/jD0zjEFQtjFZtMzvq6sjHzWkeIA8No3Usk6ADstqG/QCP2D
	wM4MVU7gEFCw72spyR/nUhZP36BGZPgsoAX9k+sjKhrJ0w8I4ZrKuurH
X-Gm-Gg: ASbGnctaMX8M1bhymwhF7g68a7zjQekaUQrLAmgirgrXlBx5kfwGCbQc2iIrCbdRp0/
	Srn2Iuw9mslhJv7YLwQxRmObVPU6wTkO2QWMZ4+KOpklVX1ge3CU8bSBrJDs8rC7Rn1PEdf7wPr
	pxLyhhRVvwmDDEgcN/MxJ6ZOyQ6vLgkj9dBJvj25Vsikjh+LOjG+TT6J7Wav20bzU8VB3yy7WuZ
	PxdQGPeE8Kb8Sv+v8S2+v16lDMep07cQGq/FobXuoy1gWEiZAPX/wrJdtG2oU/FReskdfAj5MUA
	ySKktRP7B8LTmIwvLKpBT1FYQPJh1QiL+oanLcuiAjH0Ap9fE57i0g==
X-Google-Smtp-Source: AGHT+IGwyL4vIDC3UIoBolr9zLc3zbc81T3CSXzzZXAeGlrkeaZuN/J4iuyZ/NpTJWt3hDAIK81XqQ==
X-Received: by 2002:a17:907:7e9d:b0:ad2:425c:27ce with SMTP id a640c23a62f3a-ae0be90f2eemr281661166b.2.1750851599255;
        Wed, 25 Jun 2025 04:39:59 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b74cesm1051024466b.142.2025.06.25.04.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 04:39:58 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 25 Jun 2025 04:39:47 -0700
Subject: [PATCH net-next v2 2/4] selftests: drv-net: Improve bpftrace
 utility error handling
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-netpoll_test-v2-2-47d27775222c@debian.org>
References: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
In-Reply-To: <20250625-netpoll_test-v2-0-47d27775222c@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org, 
 gustavold@gmail.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094; i=leitao@debian.org;
 h=from:subject:message-id; bh=l/nda0XltKPv0ZkUvAchmFcqXkIO0WFjK5teLGJzfFE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoW+AKJtUozNMIskVSr3fnFpO0qK1UhqbTQYG2r
 5CnlBIX7CmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFvgCgAKCRA1o5Of/Hh3
 betsD/0dDiB8Vne1O00F+BDRbJfQVeifkj9vq8hxwdlkxQ1yHsmzGrzJv10TVdOQXF3E2VpxOZH
 BFqJg8usEEcctRDXhcbCBUCRSdr4lbSHY/sxx8BhvQzhMy9bmsBSbEcrxvmyJjsiuhGtbtoS0s2
 FDyt0/g/XikNLixQjXjjekqOrx3IZpurVScf7pjG+SuKeG6f27jjp/8Nn5atsYTqjVZzH1axqxV
 yLOD4LSFaTpiUuo4H3Fk5cELz3TvQkEGdgH4gC2MJ8/oM4W0lfFeRj9i3hAwi+BCU7ZgyQyDqgP
 HO3PLWejTgKiGBfOEU/ojQ5WNe5NbwV5OaAUD9AfpW2v1/lZpUx0Kyi96J84gAK4LOLgT+kzg8m
 XUgYSg07eKpS0a/9eVXiT8JsHMz7v6iLbvTXmtWtngwEvCFZMzL5IqWe5U8/xGlZF+Kmng1HB3e
 dDhOOcaSwbyDIX2u+7zyd6opkV2EPTpwX4ac+052D1DoE8fGP8uVmCwhuqM8/FJYgw7Lyr63nKM
 GziA33LM66RB0NLjrl4fcdnhx/GVeRblUTK6PKx18dzhItbeW8nrsT+d7LrZeE1UUbUWUOxEne4
 j70jocMX3sma+vfH7Bv/PYJXV47Zot751TfhLnuhEHRQddFKNHdQy92PNhNAgrmjt1EI8Nz/lcw
 Eb9AZJ3752thyMQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Enhance the bpftrace function to raise an exception if the underlying
bpftrace command returns a non-zero exit code. This helps detect and
surface errors from bpftrace execution in test scripts, improving
robustness and debugging capabilities.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 760ccf6fccccc..c4e26567ee6fb 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -203,6 +203,9 @@ def bpftrace(expr, json=None, ns=None, host=None, timeout=None):
         expr += ' interval:s:' + str(timeout) + ' { exit(); }'
     cmd_arr += ['-e', expr]
     cmd_obj = cmd(cmd_arr, ns=ns, host=host, shell=False)
+    if cmd_obj.ret != 0:
+        raise Exception("Warning: bpftrace command returned a non-zero exit code.")
+
     if json:
         # bpftrace prints objects as lines
         ret = {}

-- 
2.47.1


