Return-Path: <linux-kselftest+bounces-8771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B7C8B0B91
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 15:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6AA4282CD3
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 13:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB31015D5CB;
	Wed, 24 Apr 2024 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INHMA6Q/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E8C15AAB6
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966874; cv=none; b=SLYrrOixan9lhhmcOXc/4mlom7ZsLvTwN4ER+INuxV+IyfyX52MgHpcMaOoPqmfXEuEMWEBFx8sVTm32CHu8w7/9d1Ow8Ruuklf51Hh3f5y524c87ebFlSgc1mEEHSyZpmKCHFvhAPi4bKTNyT5Wj8AZGQXK52gJ52Kr+BT58K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966874; c=relaxed/simple;
	bh=KPARR30ZZmFE0n7R9yKr0iH+xt44HKxu1rqWPjRLPiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvoUN9jOaAu6G2Kb5wzi7hbXZkAZFuTa8LJwv78Rl1daXptNWri3UflkemYUtWykwK6icZMFvprTs4l3nZfUWz2R/vcPF7eKggF6XyzKhFx3U5mrJSvv7fT/VgChfm10cQHSg/wj7OTWGsnk0iBa68/BXq05QgRNUqLzcwWS4LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INHMA6Q/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713966871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MpzcW4eGUsXhIEVGjUGz71es2y4/452F4J6OFr59NG8=;
	b=INHMA6Q/7gUvaBkJMzwwrlBAPUccAE2bphbSzktUYtuUfZlIsLAnqyRGV1L/ESt1AdULe1
	bIDDizidi3GOu06cTmdW7KSEak//DI+R6eT7pf+3WLzhMEYsXENO2VlEgdTX/nVkDkEf6H
	ILccgjzwIs8r2FmSuaWsWfdwl2VYrGU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-HuqN15zsOGehoISiB1vxHA-1; Wed, 24 Apr 2024 09:54:27 -0400
X-MC-Unique: HuqN15zsOGehoISiB1vxHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 664FA104D526;
	Wed, 24 Apr 2024 13:54:27 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.98])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C09391C0666A;
	Wed, 24 Apr 2024 13:54:25 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	Adrian Moreno <amorenoz@redhat.com>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 0/8] net: openvswitch: Add sample multicasting.
Date: Wed, 24 Apr 2024 15:50:47 +0200
Message-ID: <20240424135109.3524355-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

** Background **
Currently, OVS supports several packet sampling mechanisms (sFlow,
per-bridge IPFIX, per-flow IPFIX). These end up being translated into a
userspace action that needs to be handled by ovs-vswitchd's handler
threads only to be forwarded to some third party application that
will somehow process the sample and provide observability on the
datapath.

A particularly interesting use-case is controller-driven
per-flow IPFIX sampling where the OpenFlow controller can add metadata
to samples (via two 32bit integers) and this metadata is then available
to the sample-collecting system for correlation.

** Problem **
The fact that sampled traffic share netlink sockets and handler thread
time with upcalls, apart from being a performance bottleneck in the
sample extraction itself, can severely compromise the datapath,
yielding this solution unfit for highly loaded production systems.

Users are left with little options other than guessing what sampling
rate will be OK for their traffic pattern and system load and dealing
with the lost accuracy.

Looking at available infrastructure, an obvious candidated would be
to use psample. However, it's current state does not help with the
use-case at stake because sampled packets do not contain user-defined
metadata.

** Proposal **
This series is an attempt to fix this situation by extending the
existing psample infrastructure to carry a variable length
user-defined cookie.

The main existing user of psample is tc's act_sample. It is also
xtended to forward the action's cookie to psample.

Finally, OVS sample action is extended with a couple of attributes
(OVS_SAMPLE_ATTR_PSAMPLE_{GROUP,COOKIE}) that contain a 32 group_id
and a variable length cookie. When provided, OVS sends the packet
to psample for observability.

In order to make it easier for users to receive samples coming from
a specific source, group_id filtering is added to psample as well
as a tracepoint for troubleshooting.

--
rfc_v2 -> v1:
- Accomodate Ilya's comments.
- Split OVS's attribute in two attributes and simplify internal
handling of psample arguments.
- Extend psample and tc with a user-defined cookie.
- Add a tracepoint to psample to facilitate troubleshooting.

rfc_v1 -> rfc_v2:
- Use psample instead of a new OVS-only multicast group.
- Extend psample and tc with a user-defined cookie.

Adrian Moreno (8):
  net: netlink: export genl private pointer getters
  net: psample: add multicast filtering on group_id
  net: psample: add user cookie
  net: psample: add tracepoint
  net: sched: act_sample: add action cookie to sample
  net:openvswitch: add psample support
  selftests: openvswitch: add sample action.
  selftests: openvswitch: add psample test

 Documentation/netlink/specs/ovs_flow.yaml     |   6 +
 include/net/psample.h                         |   2 +
 include/uapi/linux/openvswitch.h              |  49 ++++-
 include/uapi/linux/psample.h                  |   2 +
 net/netlink/genetlink.c                       |   2 +
 net/openvswitch/actions.c                     |  51 ++++-
 net/openvswitch/flow_netlink.c                |  80 +++++--
 net/psample/psample.c                         | 131 ++++++++++-
 net/psample/trace.h                           |  62 ++++++
 net/sched/act_sample.c                        |  12 +
 .../selftests/net/openvswitch/openvswitch.sh  |  97 +++++++-
 .../selftests/net/openvswitch/ovs-dpctl.py    | 207 +++++++++++++++++-
 12 files changed, 655 insertions(+), 46 deletions(-)
 create mode 100644 net/psample/trace.h

-- 
2.44.0


