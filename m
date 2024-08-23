Return-Path: <linux-kselftest+bounces-16186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D602795D866
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 23:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149711C213DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 21:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3588F1C8242;
	Fri, 23 Aug 2024 21:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+Vr4Ni5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE7E1C823C
	for <linux-kselftest@vger.kernel.org>; Fri, 23 Aug 2024 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724447958; cv=none; b=Z0dzUbyF+bi9ry9pEdWwr693mXS3J1tCXvQN07MvIm807b8kXtJq3oceDlCdcRZqKUQ/lvYIx8CQtnZ3s++5CI7JvOynAhg/B/8PA7+HeY4nr4OK3puPwJ2UeSqReeZx3agVqZywnbHTp7A27nWdliP1AggsITRtz30ccNEjzPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724447958; c=relaxed/simple;
	bh=ra8d8mvAcL8zhdIyJ5ZY8A8nQDUJTO7T4BHUPzwU9ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLFANMPoFsR0fGMF1wTrVwy6ZoTL4vSb3Aw29J47FuhG3eiyb5WdJxVTLlzlguUF09mXrwCJSeh5qqsohAZsPIevBWal055aJ8q38S36Q0618Qz7AO2vBrnqHJyvC7QV8xEUYlW+xi//rjbek7LZzKEEg23arbcE0WBlizNDbs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+Vr4Ni5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724447955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDg8aTq0+IRJ2YG0WKlzlK9QrxdK9WrqE2P+1a17Yps=;
	b=M+Vr4Ni5qAowcoCfuTvPfoNi2G/K4rrAccKPrZ/5G0ngxZ8yRL5DWszAu2RqLdCJol4FUw
	flXSjtxwcR+daYtROFiQh1xlyxUgrGnspqvzY9Mgrw24ug+DTsU5yRW8YAXoRl/98KpIkj
	/UgIngUt+AMnIp5fWYsETzywj+ieTF4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-ZecDWR2RMYamaS2s9CdeFg-1; Fri,
 23 Aug 2024 17:19:12 -0400
X-MC-Unique: ZecDWR2RMYamaS2s9CdeFg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 089C419560A2;
	Fri, 23 Aug 2024 21:19:11 +0000 (UTC)
Received: from jmaloy-thinkpadp16vgen1.rmtcaqc.csb (unknown [10.22.8.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 089B33002246;
	Fri, 23 Aug 2024 21:19:07 +0000 (UTC)
From: jmaloy@redhat.com
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	davem@davemloft.net
Cc: kuba@kernel.org,
	passt-dev@passt.top,
	jmaloy@redhat.com,
	sbrivio@redhat.com,
	lvivier@redhat.com,
	dgibson@redhat.com,
	eric.dumazet@gmail.com,
	edumazet@google.com
Subject: [PATCH  1/2] tcp: add SO_PEEK_OFF socket option tor TCPv6
Date: Fri, 23 Aug 2024 17:19:01 -0400
Message-ID: <20240823211902.143210-2-jmaloy@redhat.com>
In-Reply-To: <20240823211902.143210-1-jmaloy@redhat.com>
References: <20240823211902.143210-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Jon Maloy <jmaloy@redhat.com>

When we added the SO_PEEK_OFF socket option to TCP we forgot
to add it even for TCP on IPv6.

We do that here.

Fixes: 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Tested-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Jon Maloy <jmaloy@redhat.com>
---
 net/ipv6/af_inet6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 90d2c7e3f5e9..ba69b86f1c7d 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -708,6 +708,7 @@ const struct proto_ops inet6_stream_ops = {
 	.splice_eof	   = inet_splice_eof,
 	.sendmsg_locked    = tcp_sendmsg_locked,
 	.splice_read	   = tcp_splice_read,
+	.set_peek_off      = sk_set_peek_off,
 	.read_sock	   = tcp_read_sock,
 	.read_skb	   = tcp_read_skb,
 	.peek_len	   = tcp_peek_len,
-- 
2.45.2


