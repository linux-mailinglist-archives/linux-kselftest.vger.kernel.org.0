Return-Path: <linux-kselftest+bounces-41068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A9AB507E0
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 23:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FA44E0491
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 21:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2F3258EC8;
	Tue,  9 Sep 2025 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2qCwLhd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E92E2571A5;
	Tue,  9 Sep 2025 21:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452366; cv=none; b=jQDkmJ0wHBDObpB2B1geR+B0P0uSESr3x6t39AdH46eKDGK2sNm1/6Zxu10jCU1OJPUIaltYzM/pJTBCN8Pfz7kpIyH9zSX6b7zSLT26ar5Qz3wBP1frRjl17KT5nX/j2kdNptDSk7J6etyT1XQ7DEkuyX5KyBqjxi4yM0lp7tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452366; c=relaxed/simple;
	bh=b3zVpKcWVRzzAV4PoKPYfkAzAKs5wqpx9sDSqMK2hLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dk2Ue6RTlWrq1xahf7cgKcEw43vFkGWzqgDhBXlQP97r7oUPJafH/TpeVuUbC+oQ0CsGecpEeItFRl3M/uKUNo4q1/yViLQQnw1o3f0Q6GEXhNAW2fkD0yqXHbiNbgXkUuGvb41L/Ws5v2pCkiEYumWlANIaV50Y/6Jd5P47OAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2qCwLhd; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f98e7782bso31905e87.0;
        Tue, 09 Sep 2025 14:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757452363; x=1758057163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhtGHWyefO4/6V0Mfz8aoHHvCaYrHjSgfLtudKA9GGM=;
        b=I2qCwLhd3VWcySHrlHPOb4XkqrKSYDzr5+V7z22y6kexGumGzRDOz+T4DY61HCkEXp
         txccNNQbezeP1WiEVR5amZatWl9PLhs6etlCVXDGaCbgr3HyGFCbgR20bkdEYIoJKhDK
         LH8rgYGjWEyBVI4x4k8KFU0gToITXBZL0Kfg1RW6IYkwJfrDu4k8qP2BNikZkSAhitM0
         eDbDARlKGTG/8aRi9pnav8yQxNdPQaigDQYgzmZKne6GU2++mqfABGlLxxHwaQzDjTKD
         WciyRaTyKTnJ5lageMCXQgXnQhX60bHkx04Uhx6MEsrQv+bfsxaJPLWv/3ZhSzw8JRV9
         rRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757452363; x=1758057163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhtGHWyefO4/6V0Mfz8aoHHvCaYrHjSgfLtudKA9GGM=;
        b=HGmY/rRlkWlrxTApiJSl0uuC/+G9mjADvuqCcOeuqOSqwOEUWcQbv9CbplyFL88URg
         TSsbOEK8iGO6b0Z5C5Pof27E3dPPF3eZylKkAzAO1Y4HJRBqYCNBizdM1mY/ktmI+dFw
         1c55+9UHO4wgCStdxJBsxcLfRZPZnX1gcbhOa8N5Fb2i1curvWuInrKZqVGcoYMPCLqi
         dmOcxfFmmrpvL9BPjUt6fergJxgYEnT0hY8gm/Z1rd2MqyoxEVYiccqtFkj/4wSVKxWx
         JAnqGEI1UUnkUZ0NBHB2f/a3rhwm+xt6Xsf5DIVfX9p3Sv36O8VmWWW06fg+88or2/8z
         PHNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDRkWGTWLl3GWZyYcrnXpe2DzcSQjeWHoERM36iSX0ZTx9t8Jcup+W+pYilcYKbNxQSt9YKcBOt8N9GSU=@vger.kernel.org, AJvYcCWF79xBQm0NA7LJg0MJIetbZoO9cz2wLuUGCTckraNDm+oXYJQC1uFdpcf6V5QxAUjRiUfND7lcUP8c+ygQaIG1@vger.kernel.org
X-Gm-Message-State: AOJu0YyNyZRgfEx5UgdWYd5JIdmGkcySXZylpHV226Yl3NIaThG8yThu
	SAmGH3zihC8Od9ymssgSdpp++fUmQzzY2G95+RnWMp4h48ncFQ/BVDDq
X-Gm-Gg: ASbGnct6Ig2mO70PX0joaqsfyQeVIKNEBxWJUHEbIR7rwGn/GFiWNUlEEfSTsMX0XYy
	Ms+/gynbjo0Zaz/lOxVkJgc8HljCAF9vPU+tojIyN+B2Vg2HLQCKW4tZXac+AMEePwk30rGGf/A
	7AgbNHhlgN+Kpv2s57uTfI309Ktr4ZW8EWAHOiP9zSo1466lHUQ/udEhNC0+GPqz+0RghucQSpB
	v4LcK4Nnorf8B3An/Twf6GfrjYFPFW6C3vr8wBuARSe4YTCbcQS45VyAMetJxh31YcBrMCiQXwn
	rwO4BqOtoo3oIKweVu2QRW+44J8MHNSrKvNMZ4Fv6VOvVqf87YL80Ad5L6HZBRCv8K9oh+LBtYH
	mH0No+2iPf/BYuKbuVYqI3fPIj6M=
X-Google-Smtp-Source: AGHT+IESClFExStOcpY/3lxx/WxtfMGI3So+QT5Y61P7ufuKUl8U0bqCOUUb3NvlKXF073U65HqoKA==
X-Received: by 2002:a05:6512:2215:b0:55f:6b08:e60 with SMTP id 2adb3069b0e04-56099434b54mr5833970e87.5.1757452362268;
        Tue, 09 Sep 2025 14:12:42 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680c424fc9sm757025e87.9.2025.09.09.14.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 14:12:41 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Date: Tue, 09 Sep 2025 22:12:12 +0100
Subject: [PATCH net-next 1/5] netconsole: add target_state enum
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-netcons-retrigger-v1-1-3aea904926cf@gmail.com>
References: <20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com>
In-Reply-To: <20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757452359; l=804;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=8V6SGnkKJouMeVLTzdn4Y5ZWQGfJsCbNdTJXQi+AdQs=;
 b=J1AS/rPSRm3utMfKLZvtLtQk3W/MP54Fzy3m7kB+++kyLXjVisgPm25oGYufz2sB57wPWN+WK
 NFvs+655aP5B3cU7Xiq3dcXr2BynL+YrXZ8g+3lI8Y8uSrk5fF8K1Wf
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

Introduces a enum to track netconsole target state which is going to
replace the enabled boolean.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 194570443493b1417570d3fe3250281cffe01316..b5e6a9fdc3155196d1fd7e81def584360ecbc3d2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -117,6 +117,11 @@ enum sysdata_feature {
 	SYSDATA_MSGID = BIT(3),
 };
 
+enum target_state {
+	STATE_DISABLED,
+	STATE_ENABLED,
+};
+
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.

-- 
2.51.0


