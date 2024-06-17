Return-Path: <linux-kselftest+bounces-12087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA4790B8EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 20:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4398A1C23CA9
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 18:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68111991B4;
	Mon, 17 Jun 2024 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YEOB0lJP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED51990DC
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647353; cv=none; b=RObwLDNRocr8iuy22sfz4WBXkBWGz6+/jbfntyNeOa1h1+jKU/JcFvGLDjQdcmU9S47h3xexE+gEHPvp8wvuc3UJYkZvddVe5/V6ggTfxkXtjUT7p8Brm1CbdnsY8jJiS6ECT+oGha+ju+NDANB4sByLUdzjVSaTzkskfImfbfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647353; c=relaxed/simple;
	bh=Jkg1obHM/vTGjyrs0Vbnp8XnJ3MsjzZbXkLumGAgbFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rK3CigFRv2owQ0gaMSjP/dYIDmn4t08yJOkxD1qtL61EUUsv0PUrfghonlF3NZHg6Jh8cZdemDp6rOp27vnfmRIB+Rsc+DlYbTeTvMxz6KNMMggonmxnZz9wGWvLx7qdl0fLLq6YLbi8zXgcr4Ws1WZT1R1eYJtRMBXV10joRBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YEOB0lJP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718647351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WZR6KXHFj1nYjg6X4UiL6MUXyvMQKOMKT1uk25ibU0s=;
	b=YEOB0lJPqvZng/VjEp3lAI754nGdxRceMYR6PWswfalmibbLtwo1borprL28pVxKUF6fKp
	HkWOB6f+XtjXqn+0vnV5Pp8dlwEowt+6Spb8SSk4nPXQI4dkaZPJ6J/+rqPRIKgEL1sL5U
	xyAbym2gmjKA8fU8FFBumqBrfPzb7f0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-sbceSbKlN3y4p3pgP7gGvw-1; Mon,
 17 Jun 2024 14:02:25 -0400
X-MC-Unique: sbceSbKlN3y4p3pgP7gGvw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 963421956062;
	Mon, 17 Jun 2024 18:02:22 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.16.41])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B61E1956087;
	Mon, 17 Jun 2024 18:02:19 +0000 (UTC)
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
	Stefano Brivio <sbrivio@redhat.com>,
	=?UTF-8?q?Adri=C3=A1n=20Moreno?= <amorenoz@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 0/7] selftests: net: Switch pmtu.sh to use the internal ovs script.
Date: Mon, 17 Jun 2024 14:02:11 -0400
Message-ID: <20240617180218.1154326-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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

Aaron Conole (7):
  selftests: openvswitch: Support explicit tunnel port creation.
  selftests: openvswitch: Refactor actions parsing.
  selftests: openvswitch: Add set() and set_masked() support.
  selftests: openvswitch: Add support for tunnel() key.
  selftests: openvswitch: Support implicit ipv6 arguments.
  selftests: net: Use the provided dpctl rather than the vswitchd for
    tests.
  selftests: net: add config for openvswitch

 tools/testing/selftests/net/config            |   5 +
 .../selftests/net/openvswitch/ovs-dpctl.py    | 372 +++++++++++++++---
 tools/testing/selftests/net/pmtu.sh           | 145 +++++--
 3 files changed, 453 insertions(+), 69 deletions(-)

-- 
2.45.1


