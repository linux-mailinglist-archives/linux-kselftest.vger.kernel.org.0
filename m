Return-Path: <linux-kselftest+bounces-35117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD32ADB793
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 19:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8FB3B1A9F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 17:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0506E288506;
	Mon, 16 Jun 2025 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxygrzAk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DDC28641F;
	Mon, 16 Jun 2025 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750093801; cv=none; b=uHZhCjes8uXmCSEGaRIW3ww7DCYZ/6dyTnJ5JQSUEtV2LGD0u7s44PesZ0JYKpPg0QNLp7XZBsJL5Z39Jmhc3Y19AK3JWBHk2qMdBHYgEymn7s6VuJL/EjK8o/kV+Juk3k8/PWaSeNH+tYcwl33GWIWPHpVMxUrhU+bIciQ66Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750093801; c=relaxed/simple;
	bh=p94oIFo4jUglnAhbc3gfVf3Xl1s0WKJ0t3PNRYqQRvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PAg9njnw9/MB6L/j5c9yOvOO4Ebn1qIzxHaMkC/+WOUJYFCnxQPBsaTbzk/gaRMqye33kpNzB9qsvPYjHhV6TN0i0TEwhQlTG42J09VewwPTuRxSpwQXyiABs/E1Mcddyv6Tpil3kTiLqGgRwwAB4pClSpUlg+yUZnfnz2gJHIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxygrzAk; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d0a61e6c0fso91589885a.0;
        Mon, 16 Jun 2025 10:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750093799; x=1750698599; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqK4XVmf88e+UTUicEUcYEEd52VK5FIFk2p//V1IESs=;
        b=YxygrzAk+faobAEsNttAhOYsARCywL5gk+wjOIK8IegXGRYsQH6dFQhoGS0X81D7dc
         07TxUxO78LDxxeYg8Dm6xdn5GlU2AeWQwWc/0k8aAoLkx5KSxIkrLXtcyBNg3G9LUwc1
         yMTocMQ/OHb0d9xDsmnqjCc9BheRs82jluzWny1OVrQk/NGPZH+8dS4mzLioCom8ybPF
         V96q34K8jxsImgUfv8Ai+Xg9FE5otf3KdqsLX0QdTKu0XPMz5EDRBKL/HwcMexQ0cOZ1
         euBtu6duFyiNhwCcVqx7VJjsbKiZYLRMk1NRlvrlbJjpBWGFG4g4x1Bpf0Bhpmed2Sml
         NN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750093799; x=1750698599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqK4XVmf88e+UTUicEUcYEEd52VK5FIFk2p//V1IESs=;
        b=Q11xwQm9ioZyduwpUp+TRECaHgAQUXUQdfRO4qatw4gLYoJf47rojnnDbRWMnpHyC0
         nWHHmcuda7go3wAtk8P+drDpBso6Rz4EK/2+PMhZwOAVcyCfcCLzQWRoImzApdrbiKYX
         QX5BnLKbg/VB9BSlFM8GQJMO6cW8adEIyUO+m3tWDHXdTz8DbpZV2sqfSl33e4qXt9HG
         dm6ZMfw9YJhGNNyvhOIqrtAuYmep89XGx+K+nValqmoa5Xb9e0v4msg/N5rBhMLb2hyx
         xyLD8003OIeCLRJBUJyT++dfAsamJKIrG7yImu90i1o9jsn6Mxym5JOgn94Gbr5R8V1L
         UhJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmOCQeVW4YSD54PfqU85Xt87RxDEXndwzAVLyFbFSeISfgo/gUh/RAhfaFrSxuPFliV0s7Dfrnemszeklf3ZP5@vger.kernel.org, AJvYcCX7CVw6jfJ0ncZk3IK0OXNfvjxXmsCdGYnhNMXgfEXyuWnkq8b4xOedHWagyDqXWbl+fTjxqbXbWbQ=@vger.kernel.org, AJvYcCXg/pj8PWEiToi6CnNo2nVq0wYoy2Jk2gf1APyE0zlFx/UjHGDOBRG1NHvLZzuQXmhCuq2pbaQf3kX2SgPT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxn6IjW8zhvDKt+sYA51Fzc9SmiVlSJG7fS45kmxJgZt/iA6aX
	KhXOualHgvTBaJModFj6mEThqOPXzD7L01ber6KEzNERf4x8WVt66Zh0
X-Gm-Gg: ASbGncv3bSGCq30ngbSHi9IrcDw4q6YuZUIp/Fj9ltqDNVGThPu0h72+EDwCA6creIn
	o4yPMkZbqhRnofoXlQ8eRJcIZDKT8D0oT7lRPVuw6wxhME7k0gIkCwHHGb7EzGhcBtn1bfqueg5
	KJud/ItqjyBSeSIxIgItKfbJKkJ4ODnlb3oWVoHeYWer0CHX+bulXmytIklyl/0+5XJAHAvLz9h
	KfiMEj6z2s7hXk1BrXRX5bvCueLFStj6KZwaZJu45AwmGjhw5KjEVM4VHQf8L/zZz9O6w3qBC/t
	g39sghn7qmC/UMzidImOX6zCmQnqnUfIuE3IqN/crF4lX9qzMH3h
X-Google-Smtp-Source: AGHT+IGIE0kzQ41K+NmIjHxuzcgQ0+W/XetuT71lQEkSUG1FBibxHRp1Y9F9EUfgFHfiAs48X7FY/w==
X-Received: by 2002:a05:6214:3211:b0:6fa:ed8e:372c with SMTP id 6a1803df08f44-6fb5b1ac9eemr3159806d6.1.1750093799173;
        Mon, 16 Jun 2025 10:09:59 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb5a3980b4sm4273736d6.89.2025.06.16.10.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:09:58 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 16 Jun 2025 10:08:35 -0700
Subject: [PATCH net-next v3 1/5] netconsole: introduce 'msgid' as a new
 sysdata field
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-netconsole-msgid-v3-1-4d2610577571@gmail.com>
References: <20250616-netconsole-msgid-v3-0-4d2610577571@gmail.com>
In-Reply-To: <20250616-netconsole-msgid-v3-0-4d2610577571@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

This adds a new sysdata field to enable assigning a per-target unique id
to each message sent to that target. This id can later be appended as
part of sysdata, allowing targets to detect dropped netconsole messages.
Update count_extradata_entries() to take the new field into account.

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 1eb678e07dd0..5f8c8c6c5393 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -113,6 +113,8 @@ enum sysdata_feature {
 	SYSDATA_TASKNAME = BIT(1),
 	/* Kernel release/version as part of sysdata */
 	SYSDATA_RELEASE = BIT(2),
+	/* Include a per-target message ID as part of sysdata */
+	SYSDATA_MSGID = BIT(3),
 };
 
 /**
@@ -782,6 +784,8 @@ static size_t count_extradata_entries(struct netconsole_target *nt)
 		entries += 1;
 	if (nt->sysdata_fields & SYSDATA_RELEASE)
 		entries += 1;
+	if (nt->sysdata_fields & SYSDATA_MSGID)
+		entries += 1;
 
 	return entries;
 }

-- 
2.47.1


