Return-Path: <linux-kselftest+bounces-4859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9739A85813B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 16:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010F5282086
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAAF13958B;
	Fri, 16 Feb 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyWVvfB5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FAD12FF75
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Feb 2024 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097335; cv=none; b=mNoFVFCLxCdlBIRtgAvUJRXMcYAv6vQJCb9LkieI+fZoTrweFO9+jMxcMhKw009xmRZ9XAm8yQ1jHaHkYcexSQA39yuxbvw0F1PhHanjxgUqdneHdgb3wwna0lRKFs5arleeROvXjMtYIjOw7Xp+otvWz/2qekUFlO1iO+QCh2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097335; c=relaxed/simple;
	bh=t1h2kdMiTtuCIfBL0CePWXZ+Hjndv9p3kwl2Y/ZmQy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3JLfpjn0hcP0kdA2N1A+1fFhAKIe3+nV9DukzYzL6B4UEpi6xnMG/QaSz7BosVWxed3GRmRg/DdXLCmZPa/DhRgeoJlv1yEH2P6Q3DuJxC2Ewr2Tg83R0iGHHxENmthIvqSdS/+VHkhfVOhxVrMUHc9gBqqR8wHJe194/LZWGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyWVvfB5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708097331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=edt3xu1cmL6LpGIFSJYthkfNUPiclw0xLjPATKYu3z0=;
	b=dyWVvfB51x0OOLkDVigOrNSO4zJrlaYbsKTpAytiALPBK+lg/DpDnB9cQYYfAotQNhNiN5
	5I3krWrOJlBwrBwp+idzmhQTBeEfU/dRPiczEa54IbK65L+vevpvOjF5qbV+C91Cc7sefJ
	XjYPXn465JyyE0s8ZqU2ixWnxfho668=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-QPe5yCaSMlueCLk9gypxSQ-1; Fri,
 16 Feb 2024 10:28:48 -0500
X-MC-Unique: QPe5yCaSMlueCLk9gypxSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C56A1383D745;
	Fri, 16 Feb 2024 15:28:47 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.33.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 467171C060B1;
	Fri, 16 Feb 2024 15:28:47 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	dev@openvswitch.org,
	Ilya Maximets <i.maximets@ovn.org>,
	Simon Horman <horms@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [RFC 0/7] selftests: openvswitch: cleanups for running as selftests
Date: Fri, 16 Feb 2024 10:28:39 -0500
Message-ID: <20240216152846.1850120-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

The series is a host of cleanups to the openvswitch selftest suite
which should be ready to run under the netdev selftest runners using
vng.  For now, the testing has been done with RW directories, but
additional testing will be done to try and keep it all as RO to be
more friendly.

There is one more test case I plan which will print the debug log
details when a test case fails so that a developer can get a clear
picture why the test case failed.  That will be done for the proper
submission as another patch in this series.

Additionally, the timeout setting was just an arbitrary number that
I picked, but needs more testing to tune it properly (since 5
minutes may be a bit too long).

Tested on fedora 38 using virtme-ng with the following commandline:

../virtme-ng/vng -v --run . --user root --cpus 4 \
    --rwdir=/home/aconole/git/linux/tools/testing/selftests/net/openvswitch/ \
    -- \
    make -C tools/testing/selftests/net/openvswitch \
         TARGETS=openvswitch TEST_PROGS=openvswitch.sh run_tests

Aaron Conole (7):
  selftests: openvswitch: add test case error directories to clean list
  selftests: openvswitch: be more verbose with selftest debugging
  selftests: openvswitch: use non-graceful kills when needed
  selftests: openvswitch: delete previously allocated netns
  selftests: openvswitch: make arping test a bit 'slower'
  selftests: openvswitch: insert module when running the tests
  selftests: openvswitch: add config and timeout settings

 .../selftests/net/openvswitch/Makefile        | 12 ++++-
 .../testing/selftests/net/openvswitch/config  | 50 +++++++++++++++++++
 .../selftests/net/openvswitch/openvswitch.sh  | 33 +++++++++---
 .../selftests/net/openvswitch/settings        |  1 +
 4 files changed, 89 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/net/openvswitch/config
 create mode 100644 tools/testing/selftests/net/openvswitch/settings

-- 
2.41.0


