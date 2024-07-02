Return-Path: <linux-kselftest+bounces-13058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82665923EF2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 15:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50191C22BE7
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 13:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1424A1B4C58;
	Tue,  2 Jul 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0tZOY9r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A0F1B4C32
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jul 2024 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926930; cv=none; b=sCo5CwPpd0dIJFu+TaQFz49BvXg5yjgMXl4JoR631MnmBuA9h+dScvfeSbICkoXqn3I32hJOs8ZbxKeh2rkVwGxowExh7eNMK5tJTB24VT6jfudtrBVOawgagQS+2BeiydMsyQf/9DYtsFLUFxgfN+7yx9/BlLK9WnpuOxPEYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926930; c=relaxed/simple;
	bh=q4svAmMc1YfDU639c9nrEQ3wazxYZ3hYbGX2/VSIc/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tExOnK4nf8yHewH8SafMjNHgtUP5tdrPC8g3pdIiLDI1+rurJyG4P3wOoOpcH8ilgUvl9zsjof0vRXgAycy8+MA++NtXVm0+cAOTfoLxcQZOmA/4OWS2mTdqdseDwA/L3AcBHXX+l4/xHuVI4IvQ4mhDyMvkzHuGoyrUSR6r17E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0tZOY9r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719926927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TZPqfUHHXo3++9COyemfH9RMfBNgVvcEH+ci6+xoSdQ=;
	b=P0tZOY9ri6vjWd+n1PWrEvLeudWwJECHBAS8DP66g+oapBq4o3+ssuhc+7h8LEGBCs0vnv
	pRbbzwHmmIfZlEZlS7J7DRky+DuyXzeQt47T5B1LigKuQL7hs5I+IaF2obXyyJp1bD1/3j
	QYoVpYcNpoUg8tYJE6orqlXcdR47+nM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-q5tTnlavPdSRguWfHzVwdQ-1; Tue,
 02 Jul 2024 09:28:40 -0400
X-MC-Unique: q5tTnlavPdSRguWfHzVwdQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82C6C19560A7;
	Tue,  2 Jul 2024 13:28:34 +0000 (UTC)
Received: from RHTRH0061144.bos.redhat.com (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CD56319560A3;
	Tue,  2 Jul 2024 13:28:31 +0000 (UTC)
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
	=?UTF-8?q?Adri=C3=A1n=20Moreno?= <amorenoz@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 0/3] selftests: openvswitch: Address some flakes in the CI environment
Date: Tue,  2 Jul 2024 09:28:27 -0400
Message-ID: <20240702132830.213384-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

These patches aim to make using the openvswitch testsuite more reliable.
These should address the major sources of flakiness in the openvswitch
test suite allowing the CI infrastructure to exercise the openvswitch
module for patch series.  There should be no change for users who simply
run the tests (except that patch 3/3 does make some of the debugging a bit
easier by making some output more verbose).

Aaron Conole (3):
  selftests: openvswitch: Bump timeout to 15 minutes.
  selftests: openvswitch: Attempt to autoload module.
  selftests: openvswitch: Be more verbose with selftest debugging.

 .../selftests/net/openvswitch/openvswitch.sh  | 23 ++++++++++++-------
 .../selftests/net/openvswitch/settings        |  1 +
 2 files changed, 16 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/net/openvswitch/settings

-- 
2.45.1


