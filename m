Return-Path: <linux-kselftest+bounces-34887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D84AD89A9
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 12:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BD7189E0B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 10:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E592D8799;
	Fri, 13 Jun 2025 10:40:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186E22D5C8D;
	Fri, 13 Jun 2025 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749811214; cv=none; b=LnE08Jt1oTDAbXwdsnHXIeIzeh2tHX4fQzjYD87f5bMQ/oZH7PZ9W+zk0VVppj8QUf7wIpk8aJdNx6Hfy+HVZ6WuC8a/jWCeeKA8QPZcS/GPa8/Gn5jD4m/Yg909cW0Z9S5p31GJRnyMM7buzbUfQa3nFc43/e7UkW2DAjcY5NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749811214; c=relaxed/simple;
	bh=AqfV1NX8BoGe0GJPQwQ8UbZPxGhH4fkElCqTTnkr9HE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PEvdKiwKmfIJU867jRfSgudvJboi/dUNLApqmM8s3Nqy5WkOX94jOT0h/a4Fd3lqJUY1YpoHSgknHz3J0s6BeYOtBH7Z3iZLtwTiHD5qrm/6WfxVYIoUqpKX6ggknVjAI6F+bseEdfDFVnvgafrlJEPGImny2bfNdizQzD/vJCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ade33027bcfso313228166b.1;
        Fri, 13 Jun 2025 03:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749811211; x=1750416011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbZuricXHXpmfe23rN2nXUlOFLjB6q4uFGOuojOrd4k=;
        b=vUgCTIrJ3m6pZYMl+UdbfS+yIgZKJoNznWnWqYmBzmq8ow5oto+bNaa0W06IvPT3WL
         P4UCJ/8gyzPnGN5ZMCjaz+f9TSxMui47wboYYyPw7Qk/N/a7zjMJvzsUNlrKdTTZlt42
         U6mNlrpoNsbCa9SLizy10gfEEeggIIBo4uXXYzdBqyQj5xBuUInOICLVJR+hsPpz3smi
         H7Fa2Y4r+R8ZFBB9HOKz1jtwmRh49KxVhNNMG/rYVbdJYjQo11qZgrgFxEXKlezNwzRr
         xAVFemtriIoD4Ph3Q46+dB7e4vOcaHy6x6kaoe5kDay/3DFtiyff3A58shbgWUTs3dvz
         AayQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAEzTUc81kfVSb8KV1Lut5ONSMYDXNYHRhLSM044tvua2h3HdpiWrTCbQ19ylWueNXvjpQEl8y718/GUQ=@vger.kernel.org, AJvYcCXZ3HzijWIjAwmdt5zAmWhK7ZWXqnvtMdIwLtiSSC4ZKehGa8FfInjZebQFci/pcuFS4xMS/PtjIC9TyjYqWpgD@vger.kernel.org
X-Gm-Message-State: AOJu0YywSwj/rfomYVssFEitSknFMqIsb6g3j1toLtqZ7aARvPydX5Fa
	yvNYw4OrIY4px2Iufg0oLBj+6kv0i+P64SesLu2mLc0OvMPQfk1f92BT
X-Gm-Gg: ASbGncsrjWgSdEcD1zWTqfa1TiW0r5ZQ6FPWYm+AWZlPZTg9rbZuuh08UqeYEwtotcV
	PxEnLA/SlGWmoAVhDATGVO/yy08CcAt/gPNNgfHzfDVu+skYbWvCfFxYHUQfVh6z3u9TBEVpNc4
	H8U+k+R8EHrjK9qvaZQ/ngKHoKQftBIUF8fKa/Yz55Rf7LPMdv1+ZP+smf36RPRMujy61xOOHe6
	hrvZqlibSwi/nLvQH8TZrSrD8gHXzSpXP9Ao/hsM5S6p6WBJdXboXNakygnIetCPYGir6f1+ped
	IcO2M42CuTHhshPI4WL0DFSlZVeVqZWBV0vsWdeqz+Y8MJioSCGfxw==
X-Google-Smtp-Source: AGHT+IEMOEBEgYcwbWI/CUEMyy6ZYVwCR7SfjEdslIEKCEfXZv3uU/TRPE0OYTdz6lC4UmYskjD5ZA==
X-Received: by 2002:a17:907:6ea2:b0:acb:5c83:25b with SMTP id a640c23a62f3a-adec54ae7e7mr279550166b.7.1749811211005;
        Fri, 13 Jun 2025 03:40:11 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7c::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88fe540sm106658466b.84.2025.06.13.03.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:40:10 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Jun 2025 03:40:00 -0700
Subject: [PATCH net-next v2 3/4] net: add dev_dstats_rx_dropped_add()
 helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-netdevsim_stat-v2-3-98fa38836c48@debian.org>
References: <20250613-netdevsim_stat-v2-0-98fa38836c48@debian.org>
In-Reply-To: <20250613-netdevsim_stat-v2-0-98fa38836c48@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, David Wei <dw@davidwei.uk>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, joe@dama.to
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=leitao@debian.org;
 h=from:subject:message-id; bh=AqfV1NX8BoGe0GJPQwQ8UbZPxGhH4fkElCqTTnkr9HE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoTAAFXsDxkit1JQsFcaI9zZp7AchuenA3nvPuc
 I6E9xtXCgCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEwABQAKCRA1o5Of/Hh3
 ba2lD/0fiu+9joQWp+P247v4pPuuOyIrNXr1bwsiUBnxUJwJEccZG+zglTOSJkggWK/zEl+x4pU
 UIjf3wqR0Ch/M5BdUfkdo8U9iYzF0j8s2zxjiGLajiApcRbrZUElE6pOOVsuW4qX0y/Y0kFwu+J
 c9g2jV/bXI/VuicJH6DKRj1ftz3a9mFM0YzMrYXq0S/rmoG/9lj1Y+WJe1JXV+5JxohdtdM9H9M
 xy9p9g2NBnIw4K4GxIn4F2kCRwmVKu8Ne3WjfpxBuGihs8DiSpnUxxhXwd3tn1vKzeLBIXXwY1z
 v0RUKOEgGgNFCUemGraCLLV5zw2AmMZxp4vn8KCvZbrGf3PURAuiBiYE3vMbD6je7WdzYqh90mA
 rDRkycT4QhQthMw7qi/L8Z7r4PxA/ayJmamCjZ6whPee7DZXwoopmy4obPVr7zc1JGp0/cL3ZJP
 VJYrrYR9e7X1Qhc7C7h0+ootqsBEn6XxiHDjHYYURyZnjSjMErTxeNORA+TXCmJAeIEbnMalgwL
 VnfLGiPlCqR0dRwIc5Bf4ipUU3sf4o5E6hZVtc9Lcm4Ytp9bI0m4hOe6dSzujzhd5DBzvMp2bBq
 9ot9FP9/qQdY+VU7cDZP3GSbaRsjYs0KFqyiAkYXivHNGrzYhRE3iJ51+bYxRpu54/C6i/NK5Ra
 V96qt+UVZtft+4g==
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
index adb14db257984..2e9100468e1af 100644
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


