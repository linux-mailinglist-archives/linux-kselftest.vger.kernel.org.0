Return-Path: <linux-kselftest+bounces-38335-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21176B1BC08
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 23:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB65174A06
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C752BCF7D;
	Tue,  5 Aug 2025 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V82Dm7vN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6A29CB5A;
	Tue,  5 Aug 2025 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754430566; cv=none; b=l+4giviGuOvw7BE7Cb/YIF2xZCW5BCzey4NF0YqR8Eb5IPJwco8/xrI9UEr/tvsLaCACNWAvFjeH6vtu5OZ1LVXzxI6cNAw7UxKb0hA3O0lHKFAmZ5b8qk6VKKdXvZ+DE+fdXx4vlfqf5gXdUOnS0JX0ad2C6CWtx8OpRcgB0sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754430566; c=relaxed/simple;
	bh=nH9AzNvXgldUU/AljR6D3DexM35j63PI4USaZ9u/z9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZYPBGSzizNpDC00zP1k35dwo3xwD+o3+lzv4cfEQDiL3E1b8JPEnwItLiIc7c5p8m4pG93dA9lxhBLc+a8Z2FOlHbygL8oyOv3enWPM+onuSt6KS5CFFv8SdTJ5jEDfgIDkfloc3UncAET8pifFSffVdsBDBgrhkCDBU/j+kuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V82Dm7vN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23fd3fe0d81so56702155ad.3;
        Tue, 05 Aug 2025 14:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754430564; x=1755035364; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7WdeYwSOTTiB9deoqbpcAAZGDfkPprbWBWnuaDCaW8=;
        b=V82Dm7vNK9O7k7aSAZMtUmgY74jLPJrWdD3q4EgX9N/ZW7ffhMV2qZUhWoaoMfR+Zu
         9DQqtzU1Giv57Nh0IAO2u3UmvhWcbKp8+B+qaCSI6dwiAWZk7Y/WtWqtUs7ZBuwYm1KV
         BhPKXcHnzhQ7KE6XLe8JSWsikoYndGSBNjcwzR3OJL0HC79IFE20ecS6NiOudgv6lR07
         FlDO3yc8oQlVX6vTTakQXoWiahElGv+k5zR3BwbLuf7Y1axBXvK+SsP6ofSivCy2+KRf
         6a5RyW7k8XtCTdOVyh6NOQ3VPvTdMmQuZN1eozC8TjKrfwKuYw+vpCBrPWSLirduqCjY
         vwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754430564; x=1755035364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7WdeYwSOTTiB9deoqbpcAAZGDfkPprbWBWnuaDCaW8=;
        b=rY2eI0TyNGb8W0yiLlXKj5PLD6BB/T0vUgMl2+GocI9GZ3Lzpe16AtexytN+q9y+dZ
         1HPbX2gn9gziPyc4C1vSdQwaPbGwQzVFCKF8nAPnAm6cRjrncMrGtqhBKX6WSQfrKgTN
         jO1ArSr9bYvd9bTiWwDiDajs1uLtA6WAbDuK5SrC3gBUsXwU81ocYPexSgBp5jlo6xhV
         XRZZT6amm8+L39wXeuYHNlPcBEncvfSjN5BxQSsJBsS+tvVhp/nzzgosxUR6BYSKWB0Z
         +anNsD1JFxsRwcM0vcDJnI2hEVDu0BvhuNY3iJK8nb33992xboMvlQ7fj5nG3bmU5fza
         xNxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX5gN0iEZQYPUyIiuzcjhlx1ved+MOIejHgBz+6Et2nIhdOE6BzulPb7ZNL2X0d4OOgTOVAPYJ@vger.kernel.org, AJvYcCVSEK5aqpPEX3yCLkrctrjlyCcHg08adibtcc7nb8DD0SCsnACbuUQN+QLgiDokzpKG23M9DZyWprCe3MjYRfpC@vger.kernel.org, AJvYcCWLl4Aly0lrK9DVH0JFVEzhohJPDJTL7FChQJj1WXhnZMfSZ43L7SeJ18RX/jobudGlvqyPmuO58MkGNOzW@vger.kernel.org, AJvYcCWfKL21q5QPveWb1c9tY8wK8DOQNSJd0dVSMLu7CR9us8xNzDJ6mv4lCMNkeLcYOUg76og=@vger.kernel.org, AJvYcCXRuGcFo2D7PY1MVBIK/ZSZmoCwFRp9Gxv8fOIg289FoZbDT0aZ5yoKRzqP7gektqKl87G5112uvrLuezQt@vger.kernel.org
X-Gm-Message-State: AOJu0YykSL/qi2md3xJ0XM4DeK8EgUecju6fYFX1CkY/W718g7i/sDaN
	ZfBE7r3gtnhpEeWUasVbFRGSKr+mg7UzyifKQM3rvr9Lv9LMBHXmY22q
X-Gm-Gg: ASbGncuTAEfU1+uI7rOQ3JcfmdztXCETJajX75pGw4yX+U715p+kohDZA8VWaSJuElf
	71BcG7eagSReMb5F74I5fbzd/wwVbbQHk3tJAivoCaZ63DXD8aBeOrjxvmpJSjvwaoBHfMVp7eW
	3aosX5TH8SU9IRPFKfs4EgDuR0zawaUMrmCgI7C7iMJSjXGOHzKlzl7xu5lSJ3+kPf3UN/m0+dT
	G+xNtZQmW4TRAKmKmD6CWHmP+nwc1fT6DXC5avfbmZFrOrx74157Tbf24TgPjS6NzHeEJd2pxL4
	K2HiMFK0Hulos7Vq2RKjiiyWjveLrr2hUXlplF97jskxUu2S7F+FzLOjoTl9NoAuGmCGX4UsFiy
	VHBjmB1vTkhl2D2/+Dd4L3WJmg6PA2A==
X-Google-Smtp-Source: AGHT+IGx4vPl2oXpK9VlREXkqAjZ5FwbF92y0gDsYjmBbN35wDgdgTqIRJq/vOJfOY7uEhYx/Sid4g==
X-Received: by 2002:a17:903:46cf:b0:240:48f4:40d5 with SMTP id d9443c01a7336-2429f5340a5mr8876385ad.39.1754430563927;
        Tue, 05 Aug 2025 14:49:23 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0fb4asm140671005ad.60.2025.08.05.14.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 14:49:23 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 05 Aug 2025 14:49:15 -0700
Subject: [PATCH RFC net-next v4 07/12] hv_sock: add netns hooks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-vsock-vmtest-v4-7-059ec51ab111@meta.com>
References: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
In-Reply-To: <20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Make NS changes not break hyperv. Guest vsocks still remain in the
global namespace always, so the behavior is unchanged.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 net/vmw_vsock/hyperv_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 432fcbbd14d4..8862297b09a7 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -313,7 +313,7 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 		return;
 
 	hvs_addr_init(&addr, conn_from_host ? if_type : if_instance);
-	sk = vsock_find_bound_socket(&addr);
+	sk = vsock_find_bound_socket(&addr, vsock_global_net());
 	if (!sk)
 		return;
 

-- 
2.47.3


