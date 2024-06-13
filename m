Return-Path: <linux-kselftest+bounces-11885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3D9907AAB
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 20:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3FB1F22C40
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9132614A4F0;
	Thu, 13 Jun 2024 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrO/zRBj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E8514A62D
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302425; cv=none; b=HKYvWmCPtekwEWmfa+7d0OZAwJBinHU7A0qak9rzRXaS3EXaQfVmFKWFlCEO42ziOnc3DW5byymzuotObHvdLCf7KeaORGSjrzLaVRoteZ9eF4EwXwDCiInUFoFDLFOE0RKf3sWWWUCPLe1EQa1u4ZtI5sqn7h+ySrmK9p8duw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302425; c=relaxed/simple;
	bh=hoIXYPbZ6aocu1qJ+2/TrKkuZM2SVzmqHzSo7LfY/eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GdF+MoNhP8DlAzCHt976qvZFhcMJktxnrPagZq/GWWisPZ/FmEbyLygPBmp+bwe/q5XrWFV+EVqXw+y39YoD36U/68T2s84cY+i6YKZobpTZo9BrK/EB6PAsJR60aA93vkU4lgHYuQ4ht06PnX8SgJT81pYFi+Xj5+a/Tl8vZoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZrO/zRBj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718302423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z8TqPTUTw/4Zs7sR0nY6BGVi0puLg7Tsv8WeeuKNgVQ=;
	b=ZrO/zRBjEd6tu3/tjBA5NHG8reQX7YOZaZRTIOkr8hwc1HyZtM1s3uyQKOtJQwikMphtEI
	lDp9CNt1HjFf2vPUZCj1jAZKB61W0vm+hcxJaey3uKV3LZT9AdcLjOXAfdhHNCVZ0l5JXs
	AUwX9ZcAo+neZbC0jhJcFJPOy1qzHqc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-cloVpsloNMCGhS9OlICJuw-1; Thu,
 13 Jun 2024 14:13:39 -0400
X-MC-Unique: cloVpsloNMCGhS9OlICJuw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E076219560AB;
	Thu, 13 Jun 2024 18:13:37 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.16.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74F8419560BF;
	Thu, 13 Jun 2024 18:13:34 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Adrian Moreno <amorenoz@redhat.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [RFC net-next 0/7] selftests: net: Switch pmtu.sh to use the internal ovs script.
Date: Thu, 13 Jun 2024 14:13:26 -0400
Message-ID: <20240613181333.984810-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Currently, if a user wants to run pmtu.sh and cover all the provided test
cases, they need to install the Open vSwitch userspace utilities.  This
dependency is difficult for users as well as CI environments, because the
userspace build and setup may require lots of support and devel packages
to be installed, system setup to be correct, and things like permissions
and selinux policies to be properly configured.

The kernel selftest suite includes an ovs-dpctl.py utility which can
interact with the openvswitch module directly.  This lets developers and
CI environments run without needing too many extra dependencies - just
the pyroute2 python package.

This series enhances the ovs-dpctl utility to provide support for set()
and tunnel() flow specifiers, better ipv6 handling support, and the
ability to add tunnel vports, and LWT interfaces.  Finally, it modifies
the pmtu.sh script to call the ovs-dpctl.py utility rather than the
typical OVS userspace utilities.

NOTE: This could also be applied as-is.  I'm trying to get the vng test
      working in my environment, so I submitted as RFC because I didn't
      get to test with the config change in 7/7.

Aaron Conole (6):
  selftests: openvswitch: Support explicit tunnel port creation.
  selftests: openvswitch: Refactor actions parsing.
  selftests: openvswitch: Add set() and set_masked() support.
  selftests: openvswitch: Add support for tunnel() key.
  selftests: openvswitch: Support implicit ipv6 arguments.
  selftests: net: Use the provided dpctl rather than the vswitchd for
    tests.
  selftests: net: add config for openvswitch

 .../selftests/net/openvswitch/ovs-dpctl.py    | 370 +++++++++++++++---
 tools/testing/selftests/net/config            |   5 ++++
 tools/testing/selftests/net/pmtu.sh           |  87 +++-
 3 files changed, 394 insertions(+), 68 deletions(-)

-- 
2.45.1


