Return-Path: <linux-kselftest+bounces-591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 201AA7F7A2F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 18:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71896B21041
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 17:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A75381BF;
	Fri, 24 Nov 2023 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgpyujTu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6FD1725;
	Fri, 24 Nov 2023 09:16:51 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-66d264e67d8so11138306d6.1;
        Fri, 24 Nov 2023 09:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700846211; x=1701451011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=065lvx7Qel1Qqzgxc2Lf3Xry0KnOsZoE16eEGlBVdZs=;
        b=lgpyujTu9/WkIUwT/xiID7O/PR6uulVpF8ve43VHrotYmc0VE4G2NyCF20xptQA+Tm
         X0+J/m3qCiUWI03rFWchbPkA6FfTet/hm4ufX6h1N7faWqZ0dpilX/XPkwHWIadc9gO0
         dY0MX1Qr7VqVx5V/FLeUnfhxetOVRRI2v8qzGybhBMAguAJoKQtRplYo6XyF9dKXaZjb
         QYRoh2oV6CQ4bh0k3tTzzWwRALX88RyMa3k7GV4Oh9sZKiUN/V+1p9AodzpPnO4eULmD
         NT34eE9hJ3XpxmhAFa60XEnOzB+pi+ZuWeV9I5VKn6rXyTH3woizFnjbRsDJkVRiZPf0
         Rbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700846211; x=1701451011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=065lvx7Qel1Qqzgxc2Lf3Xry0KnOsZoE16eEGlBVdZs=;
        b=lu4SC16LJJCq91O/k1bUcIaOxWZlkgr5hUsOHsIpvS0+2AYgGzleukoAtgL5F5W9qu
         NRYq/ObftW9bMjekK0bWwhyege1pVQOCIdqN1I5uuoHHE4dUdCck5lCXBdFaou7aPsVN
         bWy95Zo+ERhvNH7wElZkNW1R4C0ez00Yeh7kEoHZMHb5qaPr3ng1ghPhUND41F/SdlSx
         u7xOedVaY3q2g8JRgO/CCUE2PQ/SJm74ybpJtAR58dgEA3kktvVU4a5i00hkr0RpSHoR
         34BKx51rLCFiguTaDJoD87pR4DTzy0Ef+2mAQ/XIy3tRDMrFBLiOMUSKoO5SuQVLpuQi
         2Rpg==
X-Gm-Message-State: AOJu0YzxHnd0+Xs1gEi9N64QjhBgXslHBzqMkr6BlgTOi+3cd8/c1KxF
	EV/8i7Ul6bQjb4WvZZfa/w5YhHOLu50=
X-Google-Smtp-Source: AGHT+IFu95tKs6mBRzoxVROwtpSYCNufscR1FnyQdDBw8jxCr6QFF63d6wwzGqK4SvsOhcvK9e4ChA==
X-Received: by 2002:ad4:44ab:0:b0:67a:19d0:4b6c with SMTP id n11-20020ad444ab000000b0067a19d04b6cmr2297271qvt.13.1700846211119;
        Fri, 24 Nov 2023 09:16:51 -0800 (PST)
Received: from willemb.c.googlers.com.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id mn23-20020a0562145ed700b0067a0a00b24csm1389278qvb.73.2023.11.24.09.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 09:16:50 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net 3/4] selftests/net: unix: fix unused variable compiler warning
Date: Fri, 24 Nov 2023 12:15:21 -0500
Message-ID: <20231124171645.1011043-4-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231124171645.1011043-1-willemdebruijn.kernel@gmail.com>
References: <20231124171645.1011043-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Remove an unused variable.

    diag_uid.c:151:24:
    error: unused variable 'udr'
    [-Werror,-Wunused-variable]

Fixes: ac011361bd4f ("af_unix: Add test for sock_diag and UDIAG_SHOW_UID.")
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/af_unix/diag_uid.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/af_unix/diag_uid.c b/tools/testing/selftests/net/af_unix/diag_uid.c
index 5b88f7129fea4..79a3dd75590e8 100644
--- a/tools/testing/selftests/net/af_unix/diag_uid.c
+++ b/tools/testing/selftests/net/af_unix/diag_uid.c
@@ -148,7 +148,6 @@ void receive_response(struct __test_metadata *_metadata,
 		.msg_iov = &iov,
 		.msg_iovlen = 1
 	};
-	struct unix_diag_req *udr;
 	struct nlmsghdr *nlh;
 	int ret;
 
-- 
2.43.0.rc1.413.gea7ed67945-goog


