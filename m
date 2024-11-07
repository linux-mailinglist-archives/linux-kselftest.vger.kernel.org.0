Return-Path: <linux-kselftest+bounces-21631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F9B9C0D85
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 19:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A517283DD3
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 18:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB169217F56;
	Thu,  7 Nov 2024 18:12:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FDD217F2B;
	Thu,  7 Nov 2024 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731003141; cv=none; b=EB3ycb1977sw/afm/YE0OEsg0Rk4AtJpGBAbYJ/XKRnOV+SZmcg8m86INQyfaVzLGLs31J6SjB2W9nen6XcTwabme3BqOlUiblJF/EPKWCbWgw5Ra5LSswP1OTz6xMH536IgQnfp0IUP8GhXGSxCmziga8L0bLV2DEGQNZXuUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731003141; c=relaxed/simple;
	bh=9X6FLUGAqn3qmzaE6xbIR1acTxKaykWu0We8X1AhD2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s83V2F9oc40GUxJT2pOB8QSg2LZMZ6X0jlXRXaOLzG3T0VGTV7Jbz48TLkUtmKcDoqzycaVb6xJLmS8TegIbmiXuXv53BkDMiXowdXLdgGoPMjSGSEWYq4Bd3K9Fnsn8UtSI4e0UAb8v1AMyxVhs6edq2QYmK/KmmeSUy9WbDoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-210e5369b7dso13692505ad.3;
        Thu, 07 Nov 2024 10:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731003138; x=1731607938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNjL6vCUogToxpfHoTXEsRohnjfAJy/fV2Z2nSZAqtk=;
        b=nNL19S9RQatu0kpRMIF/5JI1c72dYcbQdjEpQxpo67xB7r2XNx/hFo6nky6f/o1cg/
         VX6gD1uUDYLws8p44zdHWC3lZlpmKWBPxZhBTYBD4zunw/Zvk1aCGpPt7pg32ZMUztUe
         vdZq/edNCJPB5gA4vfi1MQXFTjprHUJr31CJ+GnWUPAhWKK6Oa4a3nFdCT5P6SFbQzM3
         O91RUvgPtLMlfCKscSsnx7s/eW8WzrbNsAmaA2soi8O8XZRD41ol7CYrLXJ7fv3X72my
         fwvd/25VYAu2kSEOt0SWPLBMs5Ro6dueZztxdxf2qHprsYeqX88pirJ0iOrhDBZK2Ggw
         6lWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6o/xffTbcsmNcErAPlLFvafmacFAN66SRyRwigSUbskcCo2LpQsa0R/CIlxUs4vD0bh7ExhYrVVG+GqoW3zJe@vger.kernel.org, AJvYcCXl07QhSIN1jS6rBUwliNZF6SjJnCCXTbGAD8LmzOnvEfofUXgb/UtTv1VC0jf9I6NVPDHTKVFwV7RLek0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJwK9b2lDor0DaIJY/3CpJ7z4Wdtpyti1FlSGw0/FXGgjqECY
	k51kGcmLvRL0+VS2PN0sjA6QYGaJl3vZEXnD0Gt3DKrMgVQAlAyrN77Q
X-Google-Smtp-Source: AGHT+IGoEzfdRe0g7TDcmu0xvjVnA8zNCF40GERGBOa9bD1bBZPEPCGvD0KdlEsex+4nh0MOk4bDUQ==
X-Received: by 2002:a17:90b:1c08:b0:2d8:3fe8:a195 with SMTP id 98e67ed59e1d1-2e9b16ea69bmr145835a91.4.1731003138062;
        Thu, 07 Nov 2024 10:12:18 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177ddd616sm15146285ad.63.2024.11.07.10.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:12:17 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	horms@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com,
	jdamato@fastly.com
Subject: [PATCH net-next v8 04/12] selftests: ncdevmem: Make client_ip optional
Date: Thu,  7 Nov 2024 10:12:03 -0800
Message-ID: <20241107181211.3934153-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107181211.3934153-1-sdf@fomichev.me>
References: <20241107181211.3934153-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support 3-tuple filtering by making client_ip optional. When -c is
not passed, don't specify src-ip/src-port in the filter.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 4733d1a0aab5..faa9dce121c7 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -62,7 +62,7 @@
  */
 
 static char *server_ip = "192.168.1.4";
-static char *client_ip = "192.168.1.2";
+static char *client_ip;
 static char *port = "5201";
 static size_t do_validation;
 static int start_queue = 8;
@@ -236,8 +236,14 @@ static int configure_channels(unsigned int rx, unsigned int tx)
 
 static int configure_flow_steering(void)
 {
-	return run_command("sudo ethtool -N %s flow-type tcp4 src-ip %s dst-ip %s src-port %s dst-port %s queue %d >&2",
-			   ifname, client_ip, server_ip, port, port, start_queue);
+	return run_command("sudo ethtool -N %s flow-type tcp4 %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
+			   ifname,
+			   client_ip ? "src-ip" : "",
+			   client_ip ?: "",
+			   server_ip,
+			   client_ip ? "src-port" : "",
+			   client_ip ? port : "",
+			   port, start_queue);
 }
 
 static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
-- 
2.47.0


