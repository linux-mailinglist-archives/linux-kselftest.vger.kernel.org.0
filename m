Return-Path: <linux-kselftest+bounces-16185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F69A95D865
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 23:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1F01C212BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 21:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6821C8228;
	Fri, 23 Aug 2024 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5pkNIHZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9767380C02
	for <linux-kselftest@vger.kernel.org>; Fri, 23 Aug 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724447956; cv=none; b=cijLM/dyA/xx8bAoEvxmjJUVZX27hTkRqdxbpVzd5tqFrtoZhYfqsYmDzFhTBl18cb1klYwfZedMU2jnEo2/jfHJsuN3nWUYutpGKWmx8ZcIQYD8ft/orUqtrJqsgHislOKYJZ0au7cqj4kSKgZjVeQfDNN6DKbMbRwBGhYZTTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724447956; c=relaxed/simple;
	bh=XyCgw5UF4hvpNNbAF9WuDKiYF+S+ElScv26HhGg89EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VXc1hRfyQ+YlEfdqBbfE3+rvYrOITD3Ohx5NJzHVU+PRDzDirDLNtD2unfPAWwR6KS8rXCZbjSslOddGw2Cb+nVabncogvXpzew1UK+f50MyXXSb8WsGkLr0Vkff+dsjKAg/ZIYoYTq/WgiIwcURCiVMHJk9r8WXRmgwnyea8PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5pkNIHZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724447952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7HfPS57VnLyk5BvUkJOD00Gk+0YtbDpDFzzh3Mg+yAE=;
	b=Y5pkNIHZIuktEQd3OyIbZUZUkPx9kEM+JoaGhi9+N2qMg7Uy1qEfpA/YbT6dAQZG3Enc/N
	PbZREFmoSPlZIWw5tXKehe5pztVq77M7W6v5BgycVJIAHkivXn+jpaoUXHMg74/d9gNArt
	ZZbSMPhu3l+9AKoMIosICQV9hvHCYsg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-EtL3xGJ_P1mOYTfmHgnMOw-1; Fri,
 23 Aug 2024 17:19:09 -0400
X-MC-Unique: EtL3xGJ_P1mOYTfmHgnMOw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFF39195608A;
	Fri, 23 Aug 2024 21:19:07 +0000 (UTC)
Received: from jmaloy-thinkpadp16vgen1.rmtcaqc.csb (unknown [10.22.8.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84E41300019C;
	Fri, 23 Aug 2024 21:19:04 +0000 (UTC)
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
Subject: [PATCH  0/2] Adding SO_PEEK_OFF for TCPv6
Date: Fri, 23 Aug 2024 17:19:00 -0400
Message-ID: <20240823211902.143210-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Jon Maloy <jmaloy@redhat.com>

Adding SO_PEEK_OFF for TCPv6 and selftest for both TCPv4 and TCPv6.

Jon Maloy (2):
  tcp: add SO_PEEK_OFF socket option tor TCPv6
  selftests: add selftest for tcp SO_PEEK_OFF support

 net/ipv6/af_inet6.c                           |   1 +
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/tcp_so_peek_off.c | 181 ++++++++++++++++++
 3 files changed, 183 insertions(+)
 create mode 100644 tools/testing/selftests/net/tcp_so_peek_off.c

-- 
2.45.2


