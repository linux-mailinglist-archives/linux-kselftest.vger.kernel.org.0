Return-Path: <linux-kselftest+bounces-24997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC3EA1A46C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 13:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679741889E3D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 12:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E08B20E32D;
	Thu, 23 Jan 2025 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WW+RH8H2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B423596B
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2025 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737635995; cv=none; b=puTVxD/Y1w8tIw88w/5G4U3J2eSjN2wOAYG7s4bET5X02en8UQAXnTFThn4sj2XE524MHppiePTWq+yx7JZx6hKstcCHxEo7yb99I3PY9E0SOeEHrZTkRePPK5pYBgQ4Jm3uuxoU5v1agzIXxV2/IKiFoDgTtgFTC7t/cs4BlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737635995; c=relaxed/simple;
	bh=ZZpfpxOsk6QR2hoqoGAw++dOyELraEiLWlCCszAoIbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=JfAA8tdmWoVmoPBAuPlcSl7h93h5hUzW+YVwR+DUokdfnoe2pPapnOV3F3U0CyzhmTW9H/BDug9VPOgdxNC520Xad456c0gkc8s3NIm24Dblw5Gh3jtvSyr8h+K0ETiAeaaKfOjmhVbeinZFF6gf42gdPnh53XgdWb6jfuPw3qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WW+RH8H2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737635993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CGm2i3nUL3Bup3l0QlDSK+O+eWfoHuS+QY8rRS/Rgmo=;
	b=WW+RH8H2A2qi2kXpKdaMetnF490hQhrj01N6EZJanX5YM6hb9PuVfyQwqnE5TbWRZ/42lN
	xH2Uu0rE+BV4wkHMpZcrl1q4oE1dJUDLIaSaprbmbwvfCZzEvacEUDOpR4GaJI99XUPa0f
	zUHPdszQb4q8wgC0TdEpKtomfi+cE6s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-iK917NyPMueHe-moxHOsxg-1; Thu,
 23 Jan 2025 07:39:49 -0500
X-MC-Unique: iK917NyPMueHe-moxHOsxg-1
X-Mimecast-MFC-AGG-ID: iK917NyPMueHe-moxHOsxg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84F111956074;
	Thu, 23 Jan 2025 12:39:48 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.62])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B75D195608A;
	Thu, 23 Jan 2025 12:39:44 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: netdev@vger.kernel.org
Cc: jstancek@redhat.com,
	pshelar@ovn.org,
	matttbe@kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	liuhangbin@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net/{lib,openvswitch}: extend CFLAGS to keep options from environment
Date: Thu, 23 Jan 2025 13:38:51 +0100
Message-ID: <3d173603ee258f419d0403363765c9f9494ff79a.1737635092.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Package build environments like Fedora rpmbuild introduced hardening
options (e.g. -pie -Wl,-z,now) by passing a -spec option to CFLAGS
and LDFLAGS.

Some Makefiles currently override CFLAGS but not LDFLAGS, which leads
to a mismatch and build failure, for example:
  /usr/bin/ld: /tmp/ccd2apay.o: relocation R_X86_64_32 against
    `.rodata.str1.1' can not be used when making a PIE object; recompile with -fPIE
  /usr/bin/ld: failed to set dynamic section sizes: bad value
  collect2: error: ld returned 1 exit status
  make[1]: *** [../../lib.mk:222: tools/testing/selftests/net/lib/csum] Error 1

openvswitch/Makefile CFLAGS currently do not appear to be used, but
fix it anyway for the case when new tests are introduced in future.

Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 tools/testing/selftests/net/lib/Makefile         | 2 +-
 tools/testing/selftests/net/openvswitch/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index 18b9443454a9..578de40cc5e3 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g
+CFLAGS +=  -Wall -Wl,--no-as-needed -O2 -g
 CFLAGS += -I../../../../../usr/include/ $(KHDR_INCLUDES)
 # Additional include paths needed by kselftest.h
 CFLAGS += -I../../
diff --git a/tools/testing/selftests/net/openvswitch/Makefile b/tools/testing/selftests/net/openvswitch/Makefile
index 2f1508abc826..1567a549ba34 100644
--- a/tools/testing/selftests/net/openvswitch/Makefile
+++ b/tools/testing/selftests/net/openvswitch/Makefile
@@ -2,7 +2,7 @@
 
 top_srcdir = ../../../../..
 
-CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
+CFLAGS +=  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
 TEST_PROGS := openvswitch.sh
 
-- 
2.43.0


