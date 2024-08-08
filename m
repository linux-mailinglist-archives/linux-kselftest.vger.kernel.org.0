Return-Path: <linux-kselftest+bounces-15037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F1794C0AF
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 17:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E9F0B2635F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 15:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A2918FDD4;
	Thu,  8 Aug 2024 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dB4miB+X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7F18FDAB
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Aug 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130033; cv=none; b=YmVvcCX8cA15wvlP3ORxH2hpbRQZO+b06+KwwNtULJIHVGgSAy/CaCvYcV65mPXx+Vqw4p+yYkuv/e0htrlC76o+WbyNUIwl6Up47RxgE0yluMeF2SgmJkR9K0LAOtKp0Y5OEQ82qc5+Pc0okLv8/ZW4YRCjGhMy4c4kCWv18LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130033; c=relaxed/simple;
	bh=eqXF/iva4qGU+Q8HS3uwQf8py3MxoDUmsRFkoMpN5xU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IKGwdHwC2PEmd7+8MJ3UHxyNDPoydw9Ss+79ckWHGNo/rBMn+ncx0kjtBDoirkNSYSJPlhl+EvmWHBDKygISQNkmcIwTUNE+hHMISwq0AAHnk4j85Txhn0m14llR67Lqx1SzAKPZkga71/K1RqfjWS09qeoFkEog12phTYTnbIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dB4miB+X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723130030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=uoaG0PKMNSxBaZ2aPgzhq5VUPOfhSfefHdm4kUxUj5w=;
	b=dB4miB+XqMEYEWcQXrl55Jig+dYdApnrujHWcmAtNNbpP9/mWBaE6S0o/ppI4jVcOMRiMX
	f+73w1Q2Rdlg3/VK69DzLD86Hah6/GDWsnKQSLjr+umU5L0RbbbiXmCH+lIxw8hObGh+Z0
	NWPD5ISLKmZ2qKobGwR2UrVla0NeRq0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-r-wqDeBjMjKTlNAkqEu76Q-1; Thu,
 08 Aug 2024 11:13:45 -0400
X-MC-Unique: r-wqDeBjMjKTlNAkqEu76Q-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B652196E033;
	Thu,  8 Aug 2024 15:13:43 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.45.242.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D175F300018D;
	Thu,  8 Aug 2024 15:13:39 +0000 (UTC)
Date: Thu, 8 Aug 2024 17:13:35 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Artem Savkov <asavkov@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/rseq/Makefile: fix relative rpath usage
Message-ID: <20240808151335.GA5495@asgard.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The relative RPATH ("./") supplied to linker options in CFLAGS is resolved
relative to current working directory and not the executable directory,
which will lead in incorrect resolution when the test executables are run
from elsewhere.  Changing it to $ORIGIN makes it resolve relative
to the directory in which the executables reside, which is supposedly
the desired behaviour.

Discovered by the /usr/lib/rpm/check-rpaths script[1][2] that checks
for insecure RPATH/RUNPATH[3], such as containing relative directories,
during an attempt to package BPF selftests for later use in CI:

    ERROR   0004: file '/usr/libexec/kselftests/bpf/urandom_read' contains an insecure runpath '.' in [.]

[1] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths
[2] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths-worker
[3] https://cwe.mitre.org/data/definitions/426.html

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 tools/testing/selftests/rseq/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 5a3432fceb58..27544a67d6f0 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -6,7 +6,7 @@ endif
 
 top_srcdir = ../../../..
 
-CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=./ \
+CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=\$$ORIGIN/ \
 	  $(CLANG_FLAGS) -I$(top_srcdir)/tools/include
 LDLIBS += -lpthread -ldl
 
-- 
2.28.0


