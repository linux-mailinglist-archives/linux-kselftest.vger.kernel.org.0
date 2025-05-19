Return-Path: <linux-kselftest+bounces-33303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 436DBABB35A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 04:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D311896622
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 02:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64AF210F4B;
	Mon, 19 May 2025 02:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOtww293"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C20120E31B
	for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747622137; cv=none; b=IJwXCw1Qeik2Pblzd2iQXelnSfP3WiYGHDZwtsaTSYaCxklRkgVyJOMWNMah7pm2fk+Vm4j55DYuVWiVw1but/khuRmIYXwRiDAV7/ih8IKdx1OwmRq6S/YyJ2ET4SWAuwVHqS26RXYmVZxbD1w4huoGwRe58q4y3LWOR3OP5nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747622137; c=relaxed/simple;
	bh=RrPVhAa66e66GaEwz0wQ3D7hCOWXRdfrdXeUxMO+Rog=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aZ77LL+KA9jk7rBWpEv1GYi6rL9SV1N2QmJaemG+JsxE+PJTGkLxg0esDJ3j93u4CVdnUr59T/rbuOKmBo+IQ2IQb/YQMuEfGeVGIv2lIwcA0el5/VDVzUONA/myCLRPqGRnot0jw5xnOyiNKDZdy9G5inncd+7Pw5TUIcSD4HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jOtww293; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b16b35ea570so3840911a12.0
        for <linux-kselftest@vger.kernel.org>; Sun, 18 May 2025 19:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747622136; x=1748226936; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Glndt75G+OVXAAyKARdAz9i34uW2k/8nkArkfG9jRQ=;
        b=jOtww293+X4rPff3K+J+q384ObwJNJgnL/qR4Q9WceIWatjjwLzQgQ7OoYsVp0WuCE
         lAl015nCIDBlurAnfmQUXgPHJZWdKiOnvNJDLsKP3sN8Cm1czlNv84q6DI2Sij/TJM0b
         Wbu7lagmNycOly8IjaaortIcrBS9ksZaMvBqqpdCdxwzphzqmyouBO6IqsmIAYQPQXH1
         7kNo81BSkkeV0+2cuV0iTqIc4L5YZ7Tg2jxmKHoZTA56H0L1ALGk4Qxfqi4eoyIm61tS
         KvvcwsBrDFUNNyAukG98iUmOn5sMThLRbDx5FvZx5Ny/88oy9bbrh0YY2JfKrOXY3IAN
         lRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747622136; x=1748226936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Glndt75G+OVXAAyKARdAz9i34uW2k/8nkArkfG9jRQ=;
        b=CVHMV1Jjulsw/SS5qzkilHOBoDytcRQiM4KniK7ihUR6io5iHQRbi+hnNbyoGdOFl3
         5TdoNzP5PkRPd7Gy121U37GsgkI61DUsGkZDLKgCdCRXSfdjPec2XqBzqJ2V4FvSkw2f
         LZfT4SXjXGsFszM6G7Es4wualslYTcVpcZlISqymOYtNLu/h22l8aiqztOPtHAWBSVGz
         2eMkv7WnU/DBDMWVdbi2JGZa3OJTr1Ql4jRPNBYdyP6YZghXPbjPZVQ1hbdkrZ8pULj9
         GQCjhEAqrMh8rsG1onEIN+GPXmjXvdMz/fuv1r9yT47kb1j9sI9AgjTNOdsFCnWPX6vO
         skzg==
X-Forwarded-Encrypted: i=1; AJvYcCUe3av8HW4m8i+7xx7XSutiNi7zv8wX/NuX/thEHfkAbE98QgyG6gHi2FVZO+j0Di+ehuQb+gGzo2CHaqwBaJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjZd/IHaoF5ITzF6cy/V5+CHc4den3cfEe867Z2bMRLUYRVn6V
	DfFUlyttwDnr5Nsi5oGmK/6qJJgYmrmRRoz2co8wzFjq1QWuWEmzIzBK19a9mCIpgYi/EZ2wp8v
	dLj+D1k4j7TyPObc+JdeYJTH1+w==
X-Google-Smtp-Source: AGHT+IFwRhrMNWbY27xjgLky+xuDZgpoiQb6iEc1dBa6/1lAvXmfz8U9WnJ0DFLv/7SmNdMeydFBL9ineFFXIDYMvg==
X-Received: from plrj13.prod.google.com ([2002:a17:903:28d:b0:223:fab5:e761])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3d07:b0:224:a96:e39 with SMTP id d9443c01a7336-231d438b420mr163717575ad.9.1747622135688;
 Sun, 18 May 2025 19:35:35 -0700 (PDT)
Date: Mon, 19 May 2025 02:35:17 +0000
In-Reply-To: <20250519023517.4062941-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519023517.4062941-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519023517.4062941-10-almasrymina@google.com>
Subject: [PATCH net-next v1 9/9] net: devmem: ncdevmem: remove unused variable
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"

This variable is unused and can be removed.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index ca723722a810..a86e4ce5e65d 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -526,7 +526,6 @@ static struct netdev_queue_id *create_queues(void)
 static int do_server(struct memory_buffer *mem)
 {
 	char ctrl_data[sizeof(int) * 20000];
-	struct netdev_queue_id *queues;
 	size_t non_page_aligned_frags = 0;
 	struct sockaddr_in6 client_addr;
 	struct sockaddr_in6 server_sin;
-- 
2.49.0.1101.gccaa498523-goog


