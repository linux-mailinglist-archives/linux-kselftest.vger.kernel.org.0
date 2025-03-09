Return-Path: <linux-kselftest+bounces-28563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD97A5849F
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 14:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14343AE4CE
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 13:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1F71DD9A8;
	Sun,  9 Mar 2025 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nyh6MnNf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062E91DD88D;
	Sun,  9 Mar 2025 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527840; cv=none; b=ZKc5/CnMxsx+71QXE1Z8xbNIEpRQoveKA7mULaKrx9ZbqCVGF/DQeMb7Ryc6mMLQT5gGXMc8n7sczkM9i6HN2Cvua1/2T88rOH/gAGaEpYgwqoi5UKxey0ACLo12nyu44mBLmbSQGHqdUMhAh0bnASO0kTKTFYhN6KsC4JmmPJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527840; c=relaxed/simple;
	bh=HKzvcqvzC2csHS53Vp55KWB/vIGKh0ZE6AdrIf+H6GQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=laz86YZ9cIqpg+DDkMC//Xr0L4dn/Mly1YKGPdPkfYe5iFjjJUq9dVmOFvTpkVBwc7W0JCY4rKAfQxPjCFYv/SrAjaVS2maxNIGndJ368Iw+j9NS7wxnWAUKJ0UWNZHeXFW9hXvoeGIk5StsB/EWLLVTKLrIK1EwJxdf6Wpmyuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nyh6MnNf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22548a28d0cso25503445ad.3;
        Sun, 09 Mar 2025 06:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527838; x=1742132638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyRlgTDa3EPD0DdiASnsACMSNPi+mDYbd0XgNytQebw=;
        b=Nyh6MnNftKKbh0AfBK7D7EAKgZdrjRWKQEG0ssz6elz82qPkDoiILomIgS60Y7hAMs
         bssO9KTs2hpP3Kw/Vw+dUBHRe3sZZ57Q982XRrwe8pIl/VYWvPDweIoq4zph6hj2Jn+n
         f9MIDZ1ujBOv0GZdKXrVnLKOXDoSAcaFoMbPBqmPmcCyTOhLcQmaR0Hueog00qyYfMCF
         yHzH7yreil3g6bCM99jDtFlrdfwUlkBgQeT8P1DVM8AfjVfdiztmkpls7Qq872vI0Iqs
         XvuJPOFuP2oFGiWe4WzwwVehlhjmKxkJD61HK4WQPGHhhmQ5VMbWGOkmexZz4LD9GFRj
         4/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527838; x=1742132638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyRlgTDa3EPD0DdiASnsACMSNPi+mDYbd0XgNytQebw=;
        b=BVSzpDFVAgridNbZkb/urEDE7h9bxYoB+Buo918B27v2y3mVxrHXTsFiDFZMXqqxOv
         I7gCs1ppKvP/LgvVzRKbrxtW+Y0Zh1nRclqPwbloci7C0CU3K1Qddhhr3wSRXnh0Aw8I
         GgsykOvnSScKqExYS9Xa1wnhfZiPMpQdmLnISxTjPczQoe7XsLaAdwzWWfAMAKDiD3aw
         Z2GqosIKSqIRJYKMYBNnwOigV2bf2PwBKJOelarCA8QPD2xQTnYSe8ld3woclk3BPS7A
         f3krUrEn92JxrObxfcJuHJQN4hdl8wARffJq7D5jmwLFF/0Vztc7W5d9EEa0dkHye75U
         6lZw==
X-Forwarded-Encrypted: i=1; AJvYcCVbND82tr0S4JwsbopmHMdouDHejIktNBXIRHHMvD8lvOd3E7RnKU+xYxI58tNPBs1ZfX5Y59HZ@vger.kernel.org, AJvYcCWQUhVYM22T5TUv6UjeTAnZs4bVmVuOquxRw20wO2NBayFuzXXtPoFKcT99x5k7Z+lkF9VBwe2LgaDfhOxWhx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPxMP2hroSCciWNBvTiwE7jm+Y4PHltGmVr1OK9V0D7Urx/dEy
	datlx3nV4BMX0vSZWac0Cjb7qfgwNBjSeFLgYeyHkBoUzC+ruFzT
X-Gm-Gg: ASbGncv+Ar+Xv9K6bf/sTvwgZng4/ZxxA5lxZa7N8MPYEaLXOK6XuVbVPH0nmZQ9/4c
	BwXTqP8joyPyUXaEu443TSJv6534DIK6M8SJVEqaW+aTom1FM1YDHKIrdO/g300DjgxqXgOAOY8
	yx23cke0tXrqXSMa06AJGGUApyOxQUCS73bC5U59QMl710WwA/2zNpelsh5DyYKEs9+au74dJ+/
	qcA1yR+kN7ptkRM7Y6r7xwsi02D1Ye+ocGxBStDhnoXBYLRcqoj/KPYHtnwbvB7+IMPImvqh7Gt
	jlcwL2c66ASdZZg91+VnWHbp/Z7LXTd5ksu1K26Paqy8
X-Google-Smtp-Source: AGHT+IFBX9S/JsoN9xRiqia8Ykc6YLc2hDACAbWrYdEFdxC90ipZtywXiXgCY1La5SZokf27kF4K+g==
X-Received: by 2002:a05:6a20:1584:b0:1ee:85b2:ef7c with SMTP id adf61e73a8af0-1f544c601f0mr17472191637.27.1741527838202;
        Sun, 09 Mar 2025 06:43:58 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736c41dda7csm2296841b3a.85.2025.03.09.06.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:43:57 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: almasrymina@google.com,
	asml.silence@gmail.com,
	willemb@google.com,
	kaiyuanz@google.com,
	skhawaja@google.com,
	sdf@fomichev.me,
	gospo@broadcom.com,
	somnath.kotur@broadcom.com,
	dw@davidwei.uk,
	amritha.nambiar@intel.com,
	xuanzhuo@linux.alibaba.com,
	ap420073@gmail.com
Subject: [PATCH v3 net 7/8] net: devmem: do not WARN conditionally after netdev_rx_queue_restart()
Date: Sun,  9 Mar 2025 13:42:18 +0000
Message-Id: <20250309134219.91670-8-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309134219.91670-1-ap420073@gmail.com>
References: <20250309134219.91670-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When devmem socket is closed, netdev_rx_queue_restart() is called to
reset queue by the net_devmem_unbind_dmabuf(). But callback may return
-ENETDOWN if the interface is down because queues are already freed
when the interface is down so queue reset is not needed.
So, it should not warn if the return value is -ENETDOWN.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v3:
 - No changes.

v2:
 - Patch added.

 net/core/devmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 3bba3f018df0..0e5a2c672efd 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -109,6 +109,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	struct netdev_rx_queue *rxq;
 	unsigned long xa_idx;
 	unsigned int rxq_idx;
+	int err;
 
 	if (binding->list.next)
 		list_del(&binding->list);
@@ -120,7 +121,8 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 
 		rxq_idx = get_netdev_rx_queue_index(rxq);
 
-		WARN_ON(netdev_rx_queue_restart(binding->dev, rxq_idx));
+		err = netdev_rx_queue_restart(binding->dev, rxq_idx);
+		WARN_ON(err && err != -ENETDOWN);
 	}
 
 	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
-- 
2.34.1


