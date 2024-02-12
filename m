Return-Path: <linux-kselftest+bounces-4502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3C4851090
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 11:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3F9282DAC
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 10:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023F319478;
	Mon, 12 Feb 2024 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHiltucp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B7A182D2
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Feb 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733191; cv=none; b=hR8WZ0gsb8FgJQviWrMPUpdG49s2jBS1iYyJY3s/mLY9CTz4O7bcWlTg1sAjpPmEIU4SpuwRkxqOiJG0malz/Vl1u7tRldsJPaQ6S5SwcBcSdU6/52OCy2Qw96C3UepkbsJaHKFNZIHFt+D6qE3Gi+dhFjNFqtwWg3+ZiIRCh4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733191; c=relaxed/simple;
	bh=5pCj54oWQRHPCgb6LaLf+2sw8TGdf2eZvzUyr1NRpPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uIx9vKKoTX/Odju3W+tDAiCyNkEpMyHeoH0kJZz01SqdAWcdGbwEm0hautUyG033nmFbsDwwYEeGbQRPLKwEnM3tubMQAkyVQ2m3XWMQ3h8tJcr+jvHi5ThrAlzi7p4XAQIHji4Nsqa5Th2xQIaZ2Ed1maMPcMjKrwpV0SK1I4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHiltucp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707733189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XrU62/kRoMgXoaI/c5t3+UcrfZGZuObpLx6wfPgtQh0=;
	b=XHiltucpghxYdCg+HKZ5ow1Jnd82hxlSEdl0VyDZkAV/eAvTxVUJWzcanyLYwsbPTkMOgC
	uiq+lCghq84JxPDERacIRbr63cIv+meO0tv4bpDXQ58Xq5dBjGqq4EObndDDsQmfCYlhIF
	ZEkzMpQvp/Yun3hSl1WFrmLJGT7bfkM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-LxN9yIGIM8yX5uLGL6n17w-1; Mon, 12 Feb 2024 05:19:42 -0500
X-MC-Unique: LxN9yIGIM8yX5uLGL6n17w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D625B83FC39;
	Mon, 12 Feb 2024 10:19:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D09914ABF10;
	Mon, 12 Feb 2024 10:19:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Lucas Karpinski <lkarpins@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 0/2] selftests: net: more pmtu.sh fixes
Date: Mon, 12 Feb 2024 11:19:22 +0100
Message-ID: <cover.1707731086.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

The mentioned test is still flaky, unusally enough in 'fast'
environments.

Patch 2/2 [try to] address the existing issues, while patch 1/2
introduces more strict tests for the existing net helpers, to hopefully
prevent future pain.

Paolo Abeni (2):
  selftests: net: more strict check in net_helper
  selftests: net: more pmtu.sh fixes

 tools/testing/selftests/net/net_helper.sh | 11 +++++++----
 tools/testing/selftests/net/pmtu.sh       |  4 ++--
 2 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.43.0


