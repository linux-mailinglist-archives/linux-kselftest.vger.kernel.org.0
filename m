Return-Path: <linux-kselftest+bounces-24933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7251EA19307
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 14:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBE83AD65D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEFB2139A6;
	Wed, 22 Jan 2025 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlYPBAmy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2C8212D82;
	Wed, 22 Jan 2025 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737553953; cv=none; b=EnEg4IJaRL09iq87BhRKrhp9U+IYBVv54MBVaZNZMg1Vr+nnpsqfYAl24LDf8sgdulaDppS/W7cWrS0gRiLS9zyHj7tK6nJ1zr5lbmCsPyXlmKN+iuA2e+SadOQUH/5H4JQ4jZ1dhn2tIVbMIZeUYJVeWMqFNi9yt4uRI3/IAQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737553953; c=relaxed/simple;
	bh=ugjOL8nijfKLzjFT/CTYc+RV7W5j52FMoWjXv+L3+FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qgocuhjU5cLk2PBG1v+WVZauJyTZ6fZFg7UB34Qj/gQUkA8HcH2kmMUiWtu9hwnZVVtA0JKp/S1ZL/NTD44ZRwjKXhof62d/YbKLR3CBUdD+3IihYzKZ5o/80TLMzVGKF86JyPBgAlUAok92JYUidnaz1BiS379piBgGBX+crMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlYPBAmy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21a7ed0155cso113409545ad.3;
        Wed, 22 Jan 2025 05:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737553950; x=1738158750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IVZfMOGQeMlwWkkNAeNmUhChlFIoaA51Jt3ZCvVjgVc=;
        b=YlYPBAmy9SnjNHE+25CtJ8JEG+o6BPTHIb9bAaPW27We9A7kFcfEp1N8QTiO1WcX+P
         sy+Ft1JGP6YFnSJM8pAUyIm5glhVhf+sWAXwfFSLWlAes6g+usUO3tyxMnRNr7I4l1mf
         6icIQVF5jjltPgaahY3c3bZ4RHEOMJrN63LFEnmKNn5hbhgmFexfHW7jjg281oU2gE+S
         8G36wbZLWEfRQPYwPimko+sOIFnP/61jVXTiUxQNuXvWVERqVu8sQIrVmuwUcSLAiK7r
         HBBy8eCbEtEhOWNC4ujnKz+GTssh0wX3AcCNvOK3WzDst+pZGqKIfzny4aJRdXFBwzR7
         AeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737553950; x=1738158750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVZfMOGQeMlwWkkNAeNmUhChlFIoaA51Jt3ZCvVjgVc=;
        b=h7pFvSqolfluyvCOK2hFqjzqNmpL+kovVtp1Mr25CWJNy/emHDHqQnj9kYSMbXiIJR
         s0THpNHD0dA+QRT+nJSDVZ/4J2yoxyuQvlJgah6fkP1A0o6YhPyyCxZvhY6e79L6Y0RA
         UtnoOUHclGCPdbszmcgv7yMUFgI//1z5CPhMxVlKNJveH5sO7+5r/cQHp1r7a87KdJLI
         IZv7eu5zika5BOawKBQE8yd7xI0pMziKZQ8WxBZRf1tUaAtCcOCPNXIrT+jyfnwRluV4
         HVAlfgW6tRGgTq7fwMBuCP+77eZZfGQomDu8Q/QN+DEGf0XJZKYzhDvgADzALpEIg80/
         TBCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJEnGzNY27Ws3pV0pbXK+4S1JHV5rfz/DftZN+W03LEWKZIpM2wdOvOUl57qDB+5+Y1JiQ7r92yPJFZpk=@vger.kernel.org, AJvYcCWU/C+tVd4tBH2j1nkQsAltlzs22nAEhmjBeTHh3CRmL94CxPMgzD0iDrhj30aqjlgWbpFLuL1BOa18vb/i+/61@vger.kernel.org
X-Gm-Message-State: AOJu0YwmO2wK0n4a80ZXGsKeUzV2uvVFrsr1qF5iZDn3rK1pah41AFSB
	Ux/erd4U+sZnOuyW3yYfhzFtQ8wR4d0TY759UV1cW7afbeQMJ7QWSiSkFav8gVA=
X-Gm-Gg: ASbGncvwIu1R/dE78RX2/F7nwKqx9QlnEXqq1tzr+8Mqqt6UDQLGJ24XLer4i66fEuz
	naRyo5Nc9kRxR2w3z5MGG3bRde9ME6HfLshQgyzszQaeB5FMtEFU31Ik+mglfFE8t79MCH8SyQr
	w5AfMc8DTEp2++OlP1qSrLz/Hdj0s37uGxRXcHE+UEaNzMwQZlVQ+DxJR2HRlajHZvLGpnnAuCI
	01ONu3FWIxPztMaW9e6zMTrjrLWZZr5BANt9AJy6ZJd+sKlRPgwaLygz+58FkGcOyLfE+abmu27
	tef1rg04kFjAsw==
X-Google-Smtp-Source: AGHT+IE0jp97rM0gIVwFqkYLQ1jRgjfuRcIlaCe/sqJZyt9rHKld88UU6xmRh+WPsy2C7nBxYASi5Q==
X-Received: by 2002:a17:903:11c3:b0:215:af12:b61a with SMTP id d9443c01a7336-21c35629a68mr302636515ad.50.1737553950170;
        Wed, 22 Jan 2025 05:52:30 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d426a3asm96121635ad.249.2025.01.22.05.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 05:52:29 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>,
	Liang Li <liali@redhat.com>
Subject: [PATCHv2 net] Bonding: Fix support for gso_partial_features
Date: Wed, 22 Jan 2025 13:52:18 +0000
Message-ID: <20250122135218.183578-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fixed commit adds NETIF_F_GSO_ESP bit for bonding gso_partial_features.
However, if we don't set the dev NETIF_F_GSO_PARTIAL bit, the later
netdev_change_features() -> netdev_fix_features() will remove the
NETIF_F_GSO_ESP bit from the dev features. This causes ethtool to show
that the bond does not support tx-esp-segmentation. For example

 # ethtool -k bond0 | grep esp
 tx-esp-segmentation: off [requested on]
 esp-hw-offload: on
 esp-tx-csum-hw-offload: on

Add the NETIF_F_GSO_PARTIAL bit to bond dev features when set
gso_partial_features to fix this issue.

Fixes: 4861333b4217 ("bonding: add ESP offload features when slaves support")
Reported-by: Liang Li <liali@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: remove NETIF_F_GSO_PARTIAL bit if not set gso_partial_features.

The issue is reported internally, so there is no Closes tag.

BTW, I saw some drivers set NETIF_F_GSO_PARTIAL on dev->features. Some
other drivers set NETIF_F_GSO_PARTIAL on dev->hw_enc_features. I haven't
see a doc about where we should set. So I just set it on dev->features.
---
 drivers/net/bonding/bond_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7b78c2bada81..09d5a8433d86 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1598,10 +1598,13 @@ static void bond_compute_features(struct bonding *bond)
 	}
 	bond_dev->hard_header_len = max_hard_header_len;
 
-	if (gso_partial_features & NETIF_F_GSO_ESP)
+	if (gso_partial_features & NETIF_F_GSO_ESP) {
 		bond_dev->gso_partial_features |= NETIF_F_GSO_ESP;
-	else
+		bond_dev->features |= NETIF_F_GSO_PARTIAL;
+	} else {
 		bond_dev->gso_partial_features &= ~NETIF_F_GSO_ESP;
+		bond_dev->features &= ~NETIF_F_GSO_PARTIAL;
+	}
 
 done:
 	bond_dev->vlan_features = vlan_features;
-- 
2.39.5 (Apple Git-154)


