Return-Path: <linux-kselftest+bounces-21396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C92B9BBD0A
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 19:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00455282E96
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 18:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D941CEAD3;
	Mon,  4 Nov 2024 18:14:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545AF1CB9E5;
	Mon,  4 Nov 2024 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744077; cv=none; b=EtKPM12E3O6BXXY3afJb2wju0WEWIf9CwSwZtnclubNep9kzt+GfEpTu73769uM/WL6df+E6USJF/v1rPcQhve5DQuJd22QQifpzdVMgLPsJDTMTbKFwYzrE7uuulOYUrzq7G6bMYe31MbQUnQP2YLbih+v5mSj0uZMQcXvS7+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744077; c=relaxed/simple;
	bh=OUr7UbIXtV5F/r5JGVxieSj3s2Uf+l56sMqWfLXByW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxQPRnvIctyLqRsiOrY4PNUq1UTYgAJdqzZ1ABu+bIJrV+Yb1Vv458YKKotMJK8RB4HGAOiUotqaIZnSkvB0TSJ63Ki9bF9j1guzTuTvqr0xqoouQk50/iLeOCQMZX1eNmJhTlWF8pYtN+7tENrPJ6H/bVqa23C7jkzQrI1izQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ee4c57b037so2810708a12.0;
        Mon, 04 Nov 2024 10:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744075; x=1731348875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3/Gw3ir+FV9hqmx4cbabiMNpLz/qP2wnn0S+2scwDo=;
        b=Ol3yuFv8GSeN/J8BwDh4oVSktpFhbfr99VBrjUnCzhfaNaPmC46qHqvlkzD1fde9Yl
         VnsI8XfkymcZXSrdk9r4oT5vyMT4AIsYPqOXeerpKAOpfZF731kSrnlmrk3puzkbsBZ5
         fL4lRkb6w9cA0qotDepYgdMmbIEmD/PhEdfAJnPPrIdB7/vMgdNIIPJqqhZi4SeXhzXo
         CDQSTOBBazl5zgvIMm/mjEjYmlPz47P/F0kSu+yof8tn6U4pV8eQUtb/CygoMgjZhh7E
         sX4KDaO5v+G2fkiJT/+NmxLQia29+pUeu1cbHCdjj5w01T4mExB9vakuWu8algat734g
         swpA==
X-Forwarded-Encrypted: i=1; AJvYcCUOhLIsUBw8+9EhdwTn0946m5HJ+doe7DQRzGnVGO8HEDGqTSUusamKjbOm4NCg+6+LXcD5md2jXZ6wTik=@vger.kernel.org, AJvYcCXSPfxyXY9Yo6zu2UN0MrA4MW3U3FwwNxLyDJdFlr+IBS6MIAhyZaWz4x1AwjrDhms+keILX/PHMpZI7LuZx2yr@vger.kernel.org
X-Gm-Message-State: AOJu0YypgwJWKOIbVArzeYrcTeIRtlC7WA/0rNkOQ+xGPwb7rKw1TbgT
	+3d/gtqcsIj1BYjMwhLYWy3AuGAO3/UPLxZZD6Wr4cwmVKb0gDzxeTuS
X-Google-Smtp-Source: AGHT+IFKz78OOOgmoJsZEYNL1ytho71uwEre0CcD7w+r/UaD7HBnhbqlYYmFZapW71b1taVJc4Lp7g==
X-Received: by 2002:a05:6a20:8403:b0:1db:eb76:578d with SMTP id adf61e73a8af0-1dbeb765792mr1955530637.36.1730744075395;
        Mon, 04 Nov 2024 10:14:35 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720c6a39a53sm7354819b3a.178.2024.11.04.10.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:14:34 -0800 (PST)
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
	petrm@nvidia.com
Subject: [PATCH net-next v7 03/12] selftests: ncdevmem: Unify error handling
Date: Mon,  4 Nov 2024 10:14:21 -0800
Message-ID: <20241104181430.228682-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104181430.228682-1-sdf@fomichev.me>
References: <20241104181430.228682-1-sdf@fomichev.me>
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


