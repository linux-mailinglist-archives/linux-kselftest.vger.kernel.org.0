Return-Path: <linux-kselftest+bounces-21630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08DF9C0D82
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 19:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591211F22FB1
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 18:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEDE217902;
	Thu,  7 Nov 2024 18:12:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D841E21733D;
	Thu,  7 Nov 2024 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731003139; cv=none; b=F00/5kTY4vAr/Vv+dEGqioLXWcSE6xtXbP03yvdViOSDsfvHQGjdVrEXw4A0c0q3LBaY3TcMEwvvnR1gZdVMwvFqaGaFzvTojMC1R9/44poxkxAK+hUl43jD91sW6wvIbiJDzRrLdPAd1LaHifga6TcB/gmqP7BfupazioiO7v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731003139; c=relaxed/simple;
	bh=BJNDPj2EW/7eBR3P0ASg3cYQs56qXa3RvksZiRR0saU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amVrBAGdsZbPnExPPwEJjMoLWpiFdz2F4vmP3sVAudfr2bQzJobKTXgsK6AWmuQ5vlMZTV1p5PJZL0cAbf8E9LL/SIh73vS2WLRFKsBgzB/000f4o7WdYzU6LbDfiCvezMC3PUgMp2rjP/T6xdHEWr/fUMSDbPStjO02JjLdSqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so1075721b3a.0;
        Thu, 07 Nov 2024 10:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731003137; x=1731607937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4w+ZoIX01KDuregY361pXi0ktHoI4FAq2xqZjxJlJE=;
        b=rSnyjMYlJJKRO3irco72Ue9OPbfLeKW5aRYv3eRreDUBX0oQsTfzalyoVNY+IylBc1
         27aAuoG/FUpZrbGNvT+dhLZmUd3fGnVtAsxGSO+3B+yNewbulsALL+PrLTG/ZjbiBBBD
         tsWG4DWM72tZYljStYfyS45gwMKLVvGjOhHUoCxsBv39eHc4pzwnZeYNHkeGX8Z+zDZb
         gtAsy5m7VXGIEUNMrQBaOn6A9QWH2ZCaxkDiGVEgqC58UaYoQjsZpxKgtCz+us7+98qV
         TXf8K4KlUhIvM7i8ZFsvAIyNrgGhlNkE1OgGk7u0m88ypqSMSmIEPMfv4E5HFg/16863
         WYdw==
X-Forwarded-Encrypted: i=1; AJvYcCXAkLoqUVYHGCNjgEvCX0iYiqd7U1gsj7eTusbg1mSiNHfXZEV6NeWCo+Qd9x874ywPCzS/6xAzk5ecYcUQ+6RN@vger.kernel.org, AJvYcCXjvtyLHnBhJQUeBQfrv74B9jpA+IPRplZ20pySBCSU06HXq+sz80VMZicIJ6+liULl0cPZwZBBxsj3Frk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ0vIViYjsm7QIXd+uweYUsDr6R45NiqWlifr9y9Lfgy2OHINv
	WhFiW91syY02tcZE4oofxRfJ6WQxbzsvezRmJgF+V0dFy5GDdw9A2aAq
X-Google-Smtp-Source: AGHT+IEXKuPN883Ey5CWPn15bOCKfr9AQJUwyirHXPJOPvwOkA97gvv47fpVfdg5IftUYabkaEOG/Q==
X-Received: by 2002:a05:6a00:889:b0:71e:cb:e7bf with SMTP id d2e1a72fcca58-724129a97e7mr388982b3a.18.1731003136834;
        Thu, 07 Nov 2024 10:12:16 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a467bsm1901368b3a.43.2024.11.07.10.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:12:16 -0800 (PST)
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
Subject: [PATCH net-next v8 03/12] selftests: ncdevmem: Unify error handling
Date: Thu,  7 Nov 2024 10:12:02 -0800
Message-ID: <20241107181211.3934153-4-sdf@fomichev.me>
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

There is a bunch of places where error() calls look out of place.
Use the same error(1, errno, ...) pattern everywhere.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 3e7ef2eedd60..4733d1a0aab5 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -339,33 +339,33 @@ int do_server(struct memory_buffer *mem)
 	server_sin.sin_port = htons(atoi(port));
 
 	ret = inet_pton(server_sin.sin_family, server_ip, &server_sin.sin_addr);
-	if (socket < 0)
-		error(79, 0, "%s: [FAIL, create socket]\n", TEST_PREFIX);
+	if (ret < 0)
+		error(1, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
 
 	socket_fd = socket(server_sin.sin_family, SOCK_STREAM, 0);
-	if (socket < 0)
-		error(errno, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
+	if (socket_fd < 0)
+		error(1, errno, "%s: [FAIL, create socket]\n", TEST_PREFIX);
 
 	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEPORT, &opt,
 			 sizeof(opt));
 	if (ret)
-		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
 
 	ret = setsockopt(socket_fd, SOL_SOCKET, SO_REUSEADDR, &opt,
 			 sizeof(opt));
 	if (ret)
-		error(errno, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, set sock opt]\n", TEST_PREFIX);
 
 	fprintf(stderr, "binding to address %s:%d\n", server_ip,
 		ntohs(server_sin.sin_port));
 
 	ret = bind(socket_fd, &server_sin, sizeof(server_sin));
 	if (ret)
-		error(errno, errno, "%s: [FAIL, bind]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, bind]\n", TEST_PREFIX);
 
 	ret = listen(socket_fd, 1);
 	if (ret)
-		error(errno, errno, "%s: [FAIL, listen]\n", TEST_PREFIX);
+		error(1, errno, "%s: [FAIL, listen]\n", TEST_PREFIX);
 
 	client_addr_len = sizeof(client_addr);
 
-- 
2.47.0


