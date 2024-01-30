Return-Path: <linux-kselftest+bounces-3746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF51A842B25
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 18:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C1D2876CB
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 17:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2738814D42F;
	Tue, 30 Jan 2024 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZWnZ5Da"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D06C1292EF
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706636857; cv=none; b=OWGeCRTxE7DlxQfzJ8UVWbJMS6Aqmejx77xY+QRJV8zWtUfydRgc8qdq4rmo6xkDzcgxvoL6SAk1BEcihaknWoSB1Xu5BEhOTPiKoPc5PS6d3f0UFX8TAZu7VDmTUoF8qC6XTAMxA+A0Eg8Uf3sOwKGlPoPnChMG3/bkgmqTBGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706636857; c=relaxed/simple;
	bh=fWBa8WaNkFC0eYi6l2ZV9td7z/s2dCg1CfeBjkSezWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GGuIh8Xkv5hF6qA3yH7gPJ5V9mDH4gsx6mqW8SsS4SrTofXpUimwyzqtocJulZJ9+gZm0AvILY7bvI4rcx5ZwDc+BfRSmZDSRDCnfWfpVXng0REqw71VnY48jTuKVyuRfAmwlqHAIwgNa5LFnp42jy4BwYFcQ0NqviC86BXk/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZWnZ5Da; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706636854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WE2fG9po5mgQ4dfeaE6W7sm+LOcadSGcRLlm6cSubmI=;
	b=JZWnZ5DaASp2qVDfd7vQEWIp4WNBefxEZdW6crd+4YpiTBNu2uJsWJn9mat6/6/E22cBb9
	ByRSlYgZbgYbzZpDp3Xd2CAFI/3GiTmUIE3w0oTDdh6EQpiuFyPWRUoBhifxkpqtjrDzTv
	i9gqD/Y4/WZGyA7B5m87yDDsjAyqFww=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-_ezFk7J_Ptmx3UMFnIpazw-1; Tue, 30 Jan 2024 12:47:31 -0500
X-MC-Unique: _ezFk7J_Ptmx3UMFnIpazw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58265185A7A7;
	Tue, 30 Jan 2024 17:47:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.163])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6FC141121312;
	Tue, 30 Jan 2024 17:47:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Guillaume Nault <gnault@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Florian Westphal <fw@strlen.de>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 0/3] selftests: net: a few pmtu.sh fixes
Date: Tue, 30 Jan 2024 18:47:15 +0100
Message-ID: <cover.1706635101.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

This series try to address CI failures for the pmtu.sh tests. It
does _not_ attempt to enable all the currently skipped cases, to
avoid adding more entropy.

Tested with:

make -C tools/testing/selftests/ TARGETS=net install
vng --build  --config tools/testing/selftests/net/config
vng --run . --user root -- \
	./tools/testing/selftests/kselftest_install/run_kselftest.sh \
	-t net:pmtu.sh

Paolo Abeni (3):
  selftests: net: add missing config for pmtu.sh tests
  selftests: net: fix available tunnels detection
  selftests: net: don't access /dev/stdout in pmtu.sh

 tools/testing/selftests/net/config  |  3 +++
 tools/testing/selftests/net/pmtu.sh | 18 +++++++++---------
 2 files changed, 12 insertions(+), 9 deletions(-)

-- 
2.43.0


