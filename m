Return-Path: <linux-kselftest+bounces-3490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5938283B3FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 22:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7A91C2364A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 21:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CFE1353FA;
	Wed, 24 Jan 2024 21:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdWGIikU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348E712BE96
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132076; cv=none; b=egpTwNXGtItNdmkMss8oWdUe0/yp+Ke87ipmsTyD9ZzlhwhV0v3p8IMOQrunxKxFiZ6FDgOWtgwYFkJUS2+iUBUU5/sHRS+8TONsIXTySEAkTGTibh3uWnbM8nnqEMveoYBnTNyUaSNWK1MNimANbPWXfLNX1SaBhtQkQT6xYWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132076; c=relaxed/simple;
	bh=hyriCY+GdBwl7fFW9d2wSuur2RIckxUxqwT3aYsG0ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XO3nmhfEDKpkIG4jR+3RrN+TqWx4L2uVpe7R7OOgjiop6NQyi9FlAITI0MixQG4vbXgI875u/FW9EOA1cvMI4iZPgBfNlQ/Y8yV/qHkrNXVBHRatSgk73ugUs6EWA5wPQUtpikxb00hv/VFE/QimCBTciAN4kiGcDom3Xw8iyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdWGIikU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706132074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GiQOlEupsfOPv7z7O0qN3/HY/BuiF9CvFySpKPxZr/A=;
	b=UdWGIikUM8kkd93b27/fp27L6knfvbbjfPP7Toa66PIQqCgZ2i7LejESIZ6U3RmI3JHl8q
	+NXlowMc1IQxyX9FY3xXz8zYgPbH3hyFglH7akE9FTjjltmdt1sCEZ7T4vELM3S7QByR+I
	icdvOQdoP8ohx0FgK8m61KolS1VVASs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-PdMlHwXBMiaEf5CA7tDYFA-1; Wed,
 24 Jan 2024 16:34:27 -0500
X-MC-Unique: PdMlHwXBMiaEf5CA7tDYFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EE462837802;
	Wed, 24 Jan 2024 21:34:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6E8582166B32;
	Wed, 24 Jan 2024 21:34:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Lucas Karpinski <lkarpins@redhat.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 0/3] selftests: net: a few fixes
Date: Wed, 24 Jan 2024 22:33:19 +0100
Message-ID: <cover.1706131762.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

This series address self-tests failures for udp gro-related tests.

The first patch addresses the main problem I observe locally - the XDP
program required by such tests, xdp_dummy, is currently build in the
ebpf self-tests directory, not available if/when the user targets net
only. Arguably is more a refactor than a fix, but still targeting net
to hopefully 

The second patch fixes the integration of such tests with the build
system.

Patch 3/3 fixes sporadic failures due to races.

Tested with:

make -C tools/testing/selftests/ TARGETS=net install
./tools/testing/selftests/kselftest_install/run_kselftest.sh \
	-t "net:udpgro_bench.sh net:udpgro.sh net:udpgro_fwd.sh \
	    net:udpgro_frglist.sh net:veth.sh"

no failures.

Paolo Abeni (3):
  selftests: net: remove dependency on ebpf tests
  selftests: net: included needed helper in the install targets
  selftests: net: explicitly wait for listener ready

 tools/testing/selftests/net/Makefile          |  6 ++++--
 tools/testing/selftests/net/udpgro.sh         |  4 ++--
 tools/testing/selftests/net/udpgro_bench.sh   |  4 ++--
 tools/testing/selftests/net/udpgro_frglist.sh |  6 +++---
 tools/testing/selftests/net/udpgro_fwd.sh     |  8 +++++---
 tools/testing/selftests/net/veth.sh           |  4 ++--
 tools/testing/selftests/net/xdp_dummy.c       | 13 +++++++++++++
 7 files changed, 31 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/net/xdp_dummy.c

-- 
2.43.0


