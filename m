Return-Path: <linux-kselftest+bounces-21111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 811A79B65C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CA11F21FFD
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5CB1F4FCD;
	Wed, 30 Oct 2024 14:27:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CD91F4701;
	Wed, 30 Oct 2024 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298450; cv=none; b=UtjG7fh2pcp8scqq94bmDfWzSmUNAfOuUayoIqorftcqpIt9dbr3XIgJwkjmYGeBBlWGDHcr65RxxejMPUtn4vdJHfPJJLiOGC5qt1BrGxfJVRXUc7GL+zMc+FAzZZd3TnHF7LVaq6gkxbXwyYkmKPKQi1c+Dwm0LfS7VaR5emo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298450; c=relaxed/simple;
	bh=OIDSuCZ7YG+e+v0WLdyGHp25gpwYSalsNS50axL7TJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtMoOX+N+Rdt6adsX2hwd8YdX1x+TFCvE9aRdeKR8+YMJZgCoq/Y2E5pwx0xRcOsJ//21f30bWVsf4SO33rE8kUbFpZvWYFWfbRRb6r/ZUJGYQKAQp3RqpixuBtTn2Qk0EYRYgECBRAFh3tD43ElWFwF5VDAzwEt20Mci0E19Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c8b557f91so63786005ad.2;
        Wed, 30 Oct 2024 07:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298448; x=1730903248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+29L4jHAr9oczA6UEMXmjLx3Osf7cPlK2lZ59Hz8FA=;
        b=NhSU/DB+iRyHiLYvTouIWn25MlgFo5lEcn1bviKtjfamZyMAZu26C1pungF7Rszqe1
         L9X87EvGVXrrCla2syKRB03HlWb4j5xKnbEIMAtOKuMS7ZK2KDqBxUNudXNYehHIATQW
         QVYFJ2jDBErM7gI4ZduWq1H6j9llz/sK6IMGJ8SCM6lFrJTe/raPYQTAGH0eEnKYCVAs
         d38x18WNjtvhTzS1xngGE0n2JQuItYq4YAWrjpxch6xNnfhK+vrARZzaGQu9rcf5JmRP
         ERbQmtlCW/XvOhiseRBHvqG8pyDR8h7z1zs9WduHyJtwv1xt3fry3Hq4bp3Buij/R3iK
         wqgg==
X-Forwarded-Encrypted: i=1; AJvYcCWYEq1HQC82ixBvjL+vc9fVDhhB71TfhvNEz2rxs+0TotEm3SQIL02UEAS15F4kJgHriW9ZvZ7ILbT2nXU=@vger.kernel.org, AJvYcCWv+6vuvs82RPSvx1oO3J0QJFPPICMnQvSOmimQayS5nUdUCvP30qwDM5bRteACdq/+JD6PmDQZBhdde6kHqzfo@vger.kernel.org
X-Gm-Message-State: AOJu0YwdlAlgPcBmpByE86kMODqK+KLSwtJx4GtG5A9nPvuajFF0XawD
	QO4kT4b9cJNwdIQNhzY/Q4wGlC9blHZAhsSt2vQinf7d+OYLV3l2HxJtf2A=
X-Google-Smtp-Source: AGHT+IHpEKJrNK+QUexvQiW8T/gG0xZvnnPgaacp4Xcgs+8s7aGvnWKM5fcaMFxbtl0o170WOj/Law==
X-Received: by 2002:a17:902:c94e:b0:20c:af07:a816 with SMTP id d9443c01a7336-210c6c0dcfcmr176301445ad.31.1730298447813;
        Wed, 30 Oct 2024 07:27:27 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc0492f8sm81429065ad.256.2024.10.30.07.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:27:27 -0700 (PDT)
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
	sdf@fomichev.me,
	almasrymina@google.com,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v6 03/12] selftests: ncdevmem: Unify error handling
Date: Wed, 30 Oct 2024 07:27:13 -0700
Message-ID: <20241030142722.2901744-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030142722.2901744-1-sdf@fomichev.me>
References: <20241030142722.2901744-1-sdf@fomichev.me>
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
index 9b3ca6398a9d..b89b62445158 100644
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


