Return-Path: <linux-kselftest+bounces-4235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B0184CB7C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 14:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843451C24B7A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 13:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8C176C8C;
	Wed,  7 Feb 2024 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDn4wL/Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AF676C8D
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Feb 2024 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312264; cv=none; b=szmNf05enjxLkNTJ61ZppsTWE6oJpMfzIcZGHKsNfZg6WMW1WrPTL36gttcfGItqfd0qNTnC6STkqyO63EAUYl71fiG04KqVCky8g9/sE+fOLfYqOEMtmT0mbDJy9HzeV1A5YtlWwp1VSnZGS9Hj9aUTH/Eb3RACzBPCqZV38Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312264; c=relaxed/simple;
	bh=nx2aID+klOWlx+PJfrE2Zk/DDOPQSaFnkyL/qMxKz5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=il2YYNgXlteHUPMdRlgX+qpbl6OZw3LRckbs573XmQSNSJxpOVg6rp3Q6N8h3Eh8JRQte1zSosejF1xWWmAQOqbisDWzdO8PJqyWHdvdjQuRuQQZ06F/P0Pa5Z6NrR7483v5EiK2n7SUVphDYPQJOOxYiMkl6FtmZlcmOFh8Gy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDn4wL/Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707312261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YCsl236vDq59y6Sou28tgYzysNQep84BeqzATVrUb2Q=;
	b=ZDn4wL/Qqldkn5a/oivqA/l9kz/hl3wSuFHXMHEJYly4FtyspHTEJu2epUi6lzDoYFGEni
	/lTKeQrxK3x4THlkSR2b1DMYycz5WPOxnFDgUtHcWfUJDaFpCcJ6EMyPuCzPcR72ncSjby
	xYZwlJnqMxSIlqPtompeXkDPd5jTyWQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-p_8hj3azPOa4e_bO7DWfWw-1; Wed,
 07 Feb 2024 08:24:18 -0500
X-MC-Unique: p_8hj3azPOa4e_bO7DWfWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA84D29AC00D;
	Wed,  7 Feb 2024 13:24:17 +0000 (UTC)
Received: from RHTPC1VM0NT.bos.redhat.com (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2EB60AC18;
	Wed,  7 Feb 2024 13:24:17 +0000 (UTC)
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
	linux-kselftest@vger.kernel.org,
	andy zhou <azhou@ovn.org>
Subject: [PATCH net v2 0/2] net: openvswitch: limit the recursions from action sets
Date: Wed,  7 Feb 2024 08:24:14 -0500
Message-ID: <20240207132416.1488485-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Open vSwitch module accepts actions as a list from the netlink socket
and then creates a copy which it uses in the action set processing.
During processing of the action list on a packet, the module keeps a
count of the execution depth and exits processing if the action depth
goes too high.

However, during netlink processing the recursion depth isn't checked
anywhere, and the copy trusts that kernel has large enough stack to
accommodate it.  The OVS sample action was the original action which
could perform this kinds of recursion, and it originally checked that
it didn't exceed the sample depth limit.  However, when sample became
optimized to provide the clone() semantics, the recursion limit was
dropped.

This series adds a depth limit during the __ovs_nla_copy_actions() call
that will ensure we don't exceed the max that the OVS userspace could
generate for a clone().

Additionally, this series provides a selftest in 2/2 that can be used to
determine if the OVS module is allowing unbounded access.  It can be
safely omitted where the ovs selftest framework isn't available.

Aaron Conole (2):
  net: openvswitch: limit the number of recursions from action sets
  selftests: openvswitch: Add validation for the recursion test

 net/openvswitch/flow_netlink.c                | 49 ++++++++-----
 .../selftests/net/openvswitch/openvswitch.sh  | 13 ++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 71 +++++++++++++++----
 3 files changed, 102 insertions(+), 31 deletions(-)

-- 
2.41.0


