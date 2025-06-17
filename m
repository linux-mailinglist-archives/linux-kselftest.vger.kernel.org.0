Return-Path: <linux-kselftest+bounces-35190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105D5ADC472
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 10:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918E11673DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 08:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB6D291C15;
	Tue, 17 Jun 2025 08:19:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F3D29009A;
	Tue, 17 Jun 2025 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750148352; cv=none; b=ME6516n66YEtSZZYGyozndHa8vutTyc3PB959VMe/qQdtCvlELdXEWviAn2P632U7VXd8TIGDBz92xXDiSQPK3RRmZxP1FMSlTPAIEkbG11Jzy2NWNxyQ2fZAhoJuGumAFNNAW8rBTHsV/T0sWsyXMWYSSklcIir/lcGMtrDJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750148352; c=relaxed/simple;
	bh=6KqcuxofpPsD8Kfi3BaEJDLfN4REYeQs+F9WSLu+yZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8p+aNtAGLLW5qHBquTchxXpyecdxlerwVrXSZ0/KpA5OQ7LemtKPrPeJM3obP9OYeefcG480gF5gK8yNoyf+I9tQhpjO4svZpwtbUILa0mz89RLmZPVjFXF5msGw637q/m2EM93sV7S1ixY2kW2MUz6EavmHjfDBDF7sfvA2/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ad891bb0957so963520466b.3;
        Tue, 17 Jun 2025 01:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750148349; x=1750753149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LK3wuFiZffMBcWK/Hg3C4XwuR6uKDvuDVe6hhGIvxWQ=;
        b=Ky4jjrGmm6pdzRZV4V+JTnjIZO7Tjv+77XtNbs9s1xSsn4cLIm3Xl1D6RU/NL8Ww33
         CcLbqT61mq4MkUdsDZ3IYgr91juBQFPDn/W+fkvV4pim35IxJ99RvymjHpF4FqNAOXwc
         UDB4CFuZcVMth8hJ4rvlwWfAuWEqAEu7ltV0Q/Xu9mrxQU2Y5kH4SsToNXwyMi3NXqt2
         1lI7Kw3PAuPLsbS9ZPKp/rzqJ1gqmLmsVZvd9ZDcfPXL3+PbQU1MVSfudXxNbkvRz8NC
         1ca4cTthQqKopM/BmrfDNSJ4HjDCNJ9c0os4z/4WPsqQ/fsCUmiW6FUSMYBoUXASYTG/
         /wCg==
X-Forwarded-Encrypted: i=1; AJvYcCWBoPaUeC0h2B+EFIAD54RD1iY0bBnP4FmRbALlwSTnyqi5J8/fIARLeW+/lJGTzhenvsamoDlKbVYnRoQ5Fi+t@vger.kernel.org, AJvYcCWHfEYve/oCD1O6pIt1DLzOHCmxZ0DX2Q+mFcmZwHfPuWQVdnn8VT+1smwpAZGnwksod2TggGqjpULDuqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0iaajNPs1Vk6Ih+VJW4+pByptvdQy1/Sw9LVAO0m8BRsYUF6b
	GeINFAMX/vUnnJoQfR65iA5QJsc4+YTIQnSgBq7WwA2s3rhdgW6yhOGi
X-Gm-Gg: ASbGncsaUgh54Ob1UC3rKSn7FzfMGfD5hj3A2QQkT6zAGAmN5/V7HyHIkcWP0oA3ZPU
	toG+WRCVpLx8THQvfGFo/WH+k41LJucQPl8J9YQfxF/jCqnTaKgEmuSYSCTZK/ICSoK4rUZmnac
	tEMoGAmGKINMHXR2NYwg00p23+YI89s+ZLz6fsDnQYxRUZ8L/M0oHir75QFOQdaZdKKrt+/Zgzn
	KNAhNRXxTNxgCrWcRLiMJkMHaPR2mNpHdMvl9EkMlfmOtihC04ZQRT7BGS5xnIOgdTjz6+RtNeA
	ySiQAgC5RKXVMrNEz3wz6omjThV5NLTOg3KxrjgMry7goZrQm5cm
X-Google-Smtp-Source: AGHT+IGPd9RrwLh6ClBJ9coVRwCRPH367olEReknIBJhEd6TWHx/Nbn6BexdTmRqYDEIk2dJkP7zhg==
X-Received: by 2002:a17:907:d94:b0:ad8:8621:9241 with SMTP id a640c23a62f3a-adfad4f6509mr1278161466b.54.1750148348523;
        Tue, 17 Jun 2025 01:19:08 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adfbfe03b0csm503498166b.121.2025.06.17.01.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 01:19:08 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 17 Jun 2025 01:18:59 -0700
Subject: [PATCH net-next v3 3/4] net: add dev_dstats_rx_dropped_add()
 helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-netdevsim_stat-v3-3-afe4bdcbf237@debian.org>
References: <20250617-netdevsim_stat-v3-0-afe4bdcbf237@debian.org>
In-Reply-To: <20250617-netdevsim_stat-v3-0-afe4bdcbf237@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=leitao@debian.org;
 h=from:subject:message-id; bh=6KqcuxofpPsD8Kfi3BaEJDLfN4REYeQs+F9WSLu+yZI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoUST29Z8RkYLuaV2yrqsTuSaxEgrEcpqeY77sU
 BcwYCTM6mOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaFEk9gAKCRA1o5Of/Hh3
 bX0rEACXKAVC/yqIK3b6PQsl04gX7XSZoEsOrV/UGQ9i78wG/5hRBk5jEepDr19A097lQCn6pl1
 c7xjAv5njSAOgsw3fn7OIpYvDcnxgL5gKWO47dD3/VLo7emj/GP0amuiABQ5RQUDHxBW8aR3uXk
 n9QmDyFckAIijATZO5ZQQ3ZHujnO8sovbODHUGubZNxMvaRd9Q/mscUT+byaC5BJZADzt5veVT0
 lea89PMzVSO+qDI8F4iiP2tdU3OifD8Kw8Xzjb08eRIz0ZVYT6Ngfq5gniHXf7Y2735QRai6sDw
 ocr9bkeGezHPn4/U0Qm+bMno0UVNpDImSSAdvdkjCFrJjrGm5fk4zg1mP3tAYSQWWOckJjPOH7+
 6u+AjbdHpZg7b1a4TbO19d5QrD+mUWvCwUzuliRALGrUK8Tp+zxJ3T40nbwnijBgt0Sz+PjfdTH
 IvwsbhHt1npEpftiBdWcACaOXL61nRCaL6wcbuyM0aQaWuch9uK5bUFxqn7kJRKwSo7yElXVNZy
 MCYI+lnhWeRu2prd/99tA/0Ql3IVLhqWkFIVdXPIyzHlhHDU4nZxI9QNsBU4QteKTNkbQ12zdVo
 kGZedgltJcJdwGybEgf3WjQoBa2g9cv7zFIoxn2PwGvlA+kGY9xubh/kKpBx+tWLq+RpOsbFts/
 Hdnj68Hien6eVoA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Introduce the dev_dstats_rx_dropped_add() helper to allow incrementing
the rx_drops per-CPU statistic by an arbitrary value, rather than just
one. This is useful for drivers or code paths that need to account for
multiple dropped packets at once, such as when dropping entire queues.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netdevice.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 9cbc4e54b7e4a..03c26bb0fbbef 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3016,6 +3016,16 @@ static inline void dev_dstats_rx_dropped(struct net_device *dev)
 	u64_stats_update_end(&dstats->syncp);
 }
 
+static inline void dev_dstats_rx_dropped_add(struct net_device *dev,
+					     unsigned int packets)
+{
+	struct pcpu_dstats *dstats = this_cpu_ptr(dev->dstats);
+
+	u64_stats_update_begin(&dstats->syncp);
+	u64_stats_add(&dstats->rx_drops, packets);
+	u64_stats_update_end(&dstats->syncp);
+}
+
 static inline void dev_dstats_tx_add(struct net_device *dev,
 				     unsigned int len)
 {

-- 
2.47.1


