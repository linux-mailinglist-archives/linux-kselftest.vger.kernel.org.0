Return-Path: <linux-kselftest+bounces-35775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C64AE81A9
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 13:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9D316940F
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9729125F7AC;
	Wed, 25 Jun 2025 11:40:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB03825E80E;
	Wed, 25 Jun 2025 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851604; cv=none; b=SQaEPeYnVLgck0mtNYvLbDwQEzb40+XjqEj7HTzum0ryIecso/A2iDbLjlS6eLakMbPQkDnFDZbun2uEyQWPJAP4gVec67uI9g45yZtSaoDr5YVU0LK3xf5alCjnaV+astSQkOt65hrF7mbOW/0blG83c0M+YxIqQLdUqX1SnR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851604; c=relaxed/simple;
	bh=XNs8x8ajNJh0fetiIm2YiGOf+JuBt4IW4h9OB4WhzIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FBjXp7xxsqJpcFg6uNeYFtIMXiH6rN0tg/fqZoGf/oQqpxlUVRccQfdtoE/5nbRAbuTcHRDA6Z8kRiTC16V4nOXwRvc+6gNRwh+6QI25Xfd/CfxQIK/t95QQOSpApoctvuycgCrkkkVzRcpZhIcljKeuYHKeKRgU23I6gyeOvKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ade4679fba7so263301766b.2;
        Wed, 25 Jun 2025 04:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750851601; x=1751456401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBluJOszNCTRK8dAY0/F78ijOirMy7nuGhXV+efUFY0=;
        b=aE0DvOqIa2/tIzLY6dv1Mzhqtqgw54OCVqlKZ1Lhv4Y3cAMXPx3v2QJV+zdoYkPhfB
         DiTOfKPTX4TCQX1hKq6NiGGlg2Z7i1QmY2eoT6oKy8DDhCvvu21IbnknKIE0xLeZoywp
         +C+NRKWL8Zhv4WZG7mcJRmvZLvNqCuv+8w3sROGWa1vkRJtSAwM2Hoe+Bn1j+Mumk8Vu
         vR1YMHn8uVhPIBHvPkFoe5Gj1gpXUb12DA0Bag7g0Oy41dQyINUpsJTqJLpXw979KqBd
         rmT23q9K40tgwk4RsYzFwe51vUwyFIcAjS8k32E+pooh7rmdiAOgtqyt9t5zLu6BkuN8
         n99g==
X-Forwarded-Encrypted: i=1; AJvYcCUWOtjqS3YC+T2paT4ZGStNkptFH3WSRlCBeqmc0QwoVtA1E0j1quo/iWbv3Fho9re2IxB6C9IAJMAhNiuB/wg5@vger.kernel.org, AJvYcCW0Val+2CSvvks4kGSrkufZlVCrQxt8BvTPRlXJWeRhUQcm0r2p5W4VJEKdRredl5FyE9ZJ5HK/@vger.kernel.org, AJvYcCWqPcIQCkkFCyT7oUTYx3NzbmnL8x3E102JP28D5uVyGZGJEubcb4WDIRWYd2S2oYh+gs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22iMF/lNaPRMW99vr7kQMivp3jpEA48cCbph3vTNNjt7vJjOv
	NGBQJgXMwwNFHORxtWvpie+3dPS2eHLIZVfqgntBvBNDV9GpHNw359Ki
X-Gm-Gg: ASbGncsv9n74C6Q+mi6nSoThKSveT1ACrfSfKbUjlPPe8Aix1kE8fv1GPKcU2EcvJJH
	v5d+mHe6OOyPB/cJZIIrALwajwyKvdpfTLqwARps2PxiIivyOHu/eCelsnYv/ls1EVAqVYJAzgl
	NAEM5/IO4yDkeTrh+Qqwbdsc5NS+u9yzfx8hvuCxTUi4XG5j+dChMkCQ87aO/pI9StTIw51WXcy
	nO31WvH15RYGkxjb+HOWcwuXQTAWNu8l/AG9/E3e/ordc3Nb+mzzTb2fl5bbZmZe21FAFq/MVNQ
	E0wXW3tA02W+p4jP1XrFqxMYG8CyPpJwbql0ERxtlrLoY9U0Jw7K
X-Google-Smtp-Source: AGHT+IHpNTp1W7tJfq4L4KfthhwdbcUMxxT1qFXk9AO0VZ5Xmv20HUmqkjjmbnLK3RPqlKFIixNxPg==
X-Received: by 2002:a17:907:d24:b0:adf:f3c5:c858 with SMTP id a640c23a62f3a-ae0bf018b47mr264620566b.15.1750851600679;
        Wed, 25 Jun 2025 04:40:00 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054209b81sm1049408566b.171.2025.06.25.04.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 04:40:00 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 25 Jun 2025 04:39:48 -0700
Subject: [PATCH net-next v2 3/4] selftests: drv-net: Strip '@' prefix from
 bpftrace map keys
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-netpoll_test-v2-3-47d27775222c@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053; i=leitao@debian.org;
 h=from:subject:message-id; bh=XNs8x8ajNJh0fetiIm2YiGOf+JuBt4IW4h9OB4WhzIE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoW+AKh0+jsKLXI3AbZ4DZBx1prGQzTY0cOOwSR
 +rkK0YH/BSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFvgCgAKCRA1o5Of/Hh3
 bU5oD/95q5BM8Sr+/mJTE4kLrtVtHnpMdYsy+kVaSn+Q56G33qiiAaxHOOuwCOh1zQ/g1DtoYn+
 1t9CRBo8caWK7E4W3gTZ/p4xj9mzacSN4InF2PR/AzPUkSNswXPgHXqKKBKsHqqhZzbkZq7lL/7
 iX8VhcHi+j3gUZEVOwU8L5k06DNRr1WOGP39pvGIeeZywM+DKGwI9FnWYKTwt2rgGthJujk3M6W
 5fTTuN6BZuX7LcHFlgMrocmhX459FiYI2SY5VhGA1YG+vfRF0dXAxxIyeXaYVfOvvrCT8/RT39B
 hxUxAPelYRk3tocZgn9n2eHGyrhiJDdkUPJfToVkF9Ukoa3QCe6P68FQoKO1IEDMAfqVivKtOGH
 2k95KzqJz60FcyYQPIvPFmxYNQTDc7zMqT8hHNXlwg2vKG3xR9TZ01OHnHqmKmU0N5USNF6D0p8
 4+3FADzczgjJLhnEAaKzpTH+j/6FasG7wSpFY7AInadPC4znJnyRCjiM5xPaa/SG2EeaFSXLmMZ
 LJ/FAgVb0XZwSWpgyjavhTqQgzZigPMrZtdkNyXNZ4YXJHk27DPa5NnP5ltsEWPfOPg6/GmpnWQ
 t0bEb3fOJXCV2ANzemPwXTLq3QdIuzTblQKSTwvTQ8JLBIVNEewqwsN9vFpsLsBmTNju44TYd9E
 J5DCgwQ/su8812A==
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
index c4e26567ee6fb..31d4d63621c5f 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -216,6 +216,8 @@ def bpftrace(expr, json=None, ns=None, host=None, timeout=None):
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


