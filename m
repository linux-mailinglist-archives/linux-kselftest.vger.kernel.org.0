Return-Path: <linux-kselftest+bounces-593-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCFE7F7A31
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 18:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E931C20FBD
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 17:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42A639FC3;
	Fri, 24 Nov 2023 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy0nuGGd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A2E1718;
	Fri, 24 Nov 2023 09:16:51 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41cc535cd5cso10202281cf.2;
        Fri, 24 Nov 2023 09:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700846211; x=1701451011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=af1+2koe7V56mmURceKREPPaIe6SUwS89TrLZExIq8o=;
        b=Jy0nuGGd/TjVtWvMD0DPR+7658ft96W23ujyUaBknAe8jJIH+dH0OhIxUOdtT7ydmE
         D8b/aKH2CusSkPhd+dv4NHjxIQOXCBSmuobUDuYWDuhxhX15cwOADn1qdy1wlKqkbBn/
         /i/USzC7EILHK4s6YFYZqF/CPQZYAz2HnEtswGp0TTEXfehZ5QLRzoJolR6wJRQVkvZx
         C9tpqyY385zyBF3aBbA3YwicWKQUvSEYMhsCyd1MYz4PRdeb+vDjpwW7AUWRd98gByRY
         e8QvCrlbnB9yc24vx6Z8siDLLbXkdLxCl8RiXJWkxoU4sYSCJnzomI1NqR2LzmHZVSwr
         3fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700846211; x=1701451011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=af1+2koe7V56mmURceKREPPaIe6SUwS89TrLZExIq8o=;
        b=uegHy9C6W7LO8qSrJ74UiVjn7VABRmHG7La5avts5VPVjxbZUdA8wAK1a2WUWjEn3g
         FK9ICaxnnuHPERTw6ya26X1REBcNwc26akY9QTofpcWlB9ClmgkNFKY9Lwjra9h4+coE
         N8bF2zbO/ivddQNE0ZqBb34eOYRQqOsvqZL1Tb4srUG3UfdlR9Egp5UqL/51pAcm/pRN
         p/DMeZxNJhreTuQJT1gzpFx816AebTMNdbqzz1tzZhKpoR2/ZMXc+PLijNk0TTeZkTRF
         V5OTtF0iLUPFqlIQhZFWtzRXPEQu9dxzrsVMHLb3GjqFFK4Q4i1rKoDJBztdiAGdr+9z
         0Dvg==
X-Gm-Message-State: AOJu0YzeqBJscMjqxXZNWwEVT2sOR8rENxQwALH3byfWbEukWSIT88TH
	kacjWiJzPCc9FIEhFzlfBqxx4wHiDbM=
X-Google-Smtp-Source: AGHT+IHfWRqp0G5GAIhgLsja5PYY9aE/hq9PcYJ5RqZ17mhhd1LspLh6byXAL/qHWyBiv3Ff0xdVag==
X-Received: by 2002:a05:6214:1fd0:b0:66d:1ae6:2a5a with SMTP id jh16-20020a0562141fd000b0066d1ae62a5amr3618105qvb.7.1700846210686;
        Fri, 24 Nov 2023 09:16:50 -0800 (PST)
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
Subject: [PATCH net 2/4] selftests/net: fix a char signedness issue
Date: Fri, 24 Nov 2023 12:15:20 -0500
Message-ID: <20231124171645.1011043-3-willemdebruijn.kernel@gmail.com>
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

Signedness of char is signed on x86_64, but unsigned on arm64.

Fix the warning building cmsg_sender.c on signed platforms or
forced with -fsigned-char:

    msg_sender.c:455:12:
    error: implicit conversion from 'int' to 'char'
    changes value from 128 to -128
    [-Werror,-Wconstant-conversion]
        buf[0] = ICMPV6_ECHO_REQUEST;

constant ICMPV6_ECHO_REQUEST is 128.

Link: https://lwn.net/Articles/911914
Fixes: de17e305a810 ("selftests: net: cmsg_sender: support icmp and raw sockets")
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 tools/testing/selftests/net/cmsg_sender.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
index 24b21b15ed3fb..6ff3e732f449f 100644
--- a/tools/testing/selftests/net/cmsg_sender.c
+++ b/tools/testing/selftests/net/cmsg_sender.c
@@ -416,9 +416,9 @@ int main(int argc, char *argv[])
 {
 	struct addrinfo hints, *ai;
 	struct iovec iov[1];
+	unsigned char *buf;
 	struct msghdr msg;
 	char cbuf[1024];
-	char *buf;
 	int err;
 	int fd;
 
-- 
2.43.0.rc1.413.gea7ed67945-goog


