Return-Path: <linux-kselftest+bounces-28217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EC9A4E78E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 18:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C7E8C6C84
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E6228D067;
	Tue,  4 Mar 2025 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VDXy9l2Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AD728F947
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104068; cv=pass; b=G/3O7yG6czxEioj5n1Q7mUzVcMWlpSl/DrCPdnBdDwljHRXcPNG0Ul4SolxAi4laS37dB0iFG/IpbbXp28ppWIlMkabCILziXCYK9qjpUO/d8WY5uA+0UORU1mC+KfSi8AiCr7aGzOe5I34OgrfdPZT7PTv/RspjQl5LkqXC+Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104068; c=relaxed/simple;
	bh=uylAwl9z4lLSLbtftXMVsVSfo+l6pIl66/zaUNQcLB0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d9W6tTwshyE+eihqn6rAzF2JXw3k/gNMJnmKI90Z2+gYupDg9RtOie2QImZIpKdWNQ8UMpt/ZWoqh1ppaxj9kvfHDNdnT+ogfL963PV6Cc9DhQ6i3eWnMOytKylvu8EKWGZFRozW7GS8zI544W9T8z4VVoRnpqwjphUhj8WCg8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VDXy9l2Z; arc=none smtp.client-ip=99.78.197.218; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id C6CAE40F1CE1
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 19:01:04 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazon201209 header.b=VDXy9l2Z
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gNm2RflzG1yf
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 18:59:36 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 2F7EB42732; Tue,  4 Mar 2025 18:59:25 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VDXy9l2Z
X-Envelope-From: <linux-kernel+bounces-541763-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VDXy9l2Z
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id A6C2541C9B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:09:09 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw1.itu.edu.tr (Postfix) with SMTP id E45CA305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:09:08 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9883A7A3DA6
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14D621128D;
	Mon,  3 Mar 2025 13:08:51 +0000 (UTC)
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D41210F59;
	Mon,  3 Mar 2025 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007329; cv=none; b=tcCFC1K7KPOPGFLXDwrsxjSxn2PyO+l/floC12kmwGjn4ncLmDuBY+O7K/3KfbmAxEyYPfQHghc1+3S0/kmxAJKCyVitp+6zi5lnPgwR3dsyOdw+5X1jqrApiJgSRUEcVxU6+eiS8TH8bxg4CZ2L45XNXnENPgd5hZdgRoAN7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007329; c=relaxed/simple;
	bh=uylAwl9z4lLSLbtftXMVsVSfo+l6pIl66/zaUNQcLB0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=skrXokXU853by9KIxiQ1XE+7kJzWJPULPDhjtrS85esV5tjD07Ns4Vl6P8WVskMsDN5l4gTm2nFidAPHqdBPkXN6kNIRmQfBED6v+W0roNcO+q6GsjzNHCrfix0GAPBawgdZvEgLENdmcWJoF4W7F5qPp9I1aQ98xd1gGxzVHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VDXy9l2Z; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741007328; x=1772543328;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ijLS6/7VoNS5QgB9vq9v8BcogTKboYMwaB+vjiqquWQ=;
  b=VDXy9l2Zu9p7ohCfcZOJ9vRCae8CYq5vvLUv2tRSBLYo/HiW4psz9Qkt
   Mj4PXQyj+5BMd4fycVb6Sh9agQrNpbk+ny4LNPm3Jppv5/7jNmT0X9ij9
   weYDqRtNq3BFdhg+qqx02E5nEY2tKj1uBRet1M/l5/HYx06yPQXyUyluO
   g=;
X-IronPort-AV: E=Sophos;i="6.13,329,1732579200"; 
   d="scan'208";a="382575094"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:08:46 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:35314]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.24.106:2525] with esmtp (Farcaster)
 id c10353bf-5d23-44b0-9a7e-a591baedecbb; Mon, 3 Mar 2025 13:08:44 +0000 (UTC)
X-Farcaster-Flow-ID: c10353bf-5d23-44b0-9a7e-a591baedecbb
Received: from EX19D015EUB003.ant.amazon.com (10.252.51.113) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:08:40 +0000
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19D015EUB003.ant.amazon.com (10.252.51.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:08:40 +0000
Received: from email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 13:08:40 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com (Postfix) with ESMTPS id E2BB7A065C;
	Mon,  3 Mar 2025 13:08:38 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <pbonzini@redhat.com>, <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michael.day@amd.com>, <david@redhat.com>,
	<quic_eberman@quicinc.com>, <jthoughton@google.com>, <brijesh.singh@amd.com>,
	<michael.roth@amd.com>, <graf@amazon.de>, <jgowans@amazon.com>,
	<roypat@amazon.co.uk>, <derekmn@amazon.com>, <nsaenz@amazon.es>,
	<xmarcalx@amazon.com>, <kalyazin@amazon.com>
Subject: [v3 PATCH 0/2] KVM: guest_memfd: use write for population
Date: Mon, 3 Mar 2025 13:08:36 +0000
Message-ID: <20250303130838.28812-1-kalyazin@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gNm2RflzG1yf
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708784.82549@PbKvwRdYau+qrIqaqLwdIg
X-ITU-MailScanner-SpamCheck: not spam

This series is rebased on top of Fuad's v4 for shared mapping of
guest_memfd [1].

Change since v2 [2]:
 - David/Mike D: Only compile support for the write syscall if
   CONFIG_KVM_GMEM_SHARED_MEM introduced in [1] is enabled.

In non-CoCo use cases where the host can access guest memory,
guest_memfd can be allocated and populated via the write syscall.  Even
though the same can also be achieved via userspace mapping and memcpy
from userspace, write provides a more performant option because it 1)
avoids double initialisation as the kernel does not need to zero pages
and 2) does not require setting up page tables.

Nikita

[1] https://lore.kernel.org/kvm/20250218172500.807733-4-tabba@google.com/T/
[2] https://lore.kernel.org/kvm/20241129123929.64790-1-kalyazin@amazon.com/T/

Nikita Kalyazin (2):
  KVM: guest_memfd: add generic population via write
  KVM: selftests: update guest_memfd write tests

 .../testing/selftests/kvm/guest_memfd_test.c  | 85 +++++++++++++++--
 virt/kvm/guest_memfd.c                        | 94 ++++++++++++++++++-
 2 files changed, 170 insertions(+), 9 deletions(-)


base-commit: 005f6404708d430abab7fab9b422d0daf6e0c2fe
-- 
2.47.1



