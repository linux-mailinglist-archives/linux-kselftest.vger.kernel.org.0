Return-Path: <linux-kselftest+bounces-4865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEC985814D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 16:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE4F1C20B9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 15:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF7E145B18;
	Fri, 16 Feb 2024 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaECzf4I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BD0145331
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Feb 2024 15:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097342; cv=none; b=d1gjagc51+fqJ61V3JG09GPHB4Hb4aglKpiOPR3XoWM1ZrYl9FY40iHu/n/8kBVVltBGJ99bb3kLRo1PfrBbso0MpxqP8L3jkkK0tPO0TK86r8LfZ93H7ldDiFo5hTVAMnfQzpRUeLkQTb7uy3UIhpTyW7QPpJtDD5W7StRdNM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097342; c=relaxed/simple;
	bh=XwSfzrGlsJBkrndaH9YkOTz2VtQoc4j1IzY2e0riSOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFfD75s6x+AYrGA3swbGhRYjzxpUZ1NRG3MC2mVHEgpmDl0PIojHMb7WgNFIUEIg4IkeyvnPUIVjuWM0rsyNMl0j18r8pZKxu5hDhNbK5CmT0iX2yNPkdytjgpkyXCb5rLCjhZODblleOBxkRSey6peMRuUSQmC5trSfCzj8ftQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VaECzf4I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708097338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9AipKYmwTOX0KaIYggbIWRV31BYVphMNMwXphJHYrw8=;
	b=VaECzf4IuIRHj/f3he5i/7ZYJOYI2GpZYwx65R159anDPaBaLNnVL9PECBomoTJ081iUAu
	Bo2A5yYjfYCesA1KsMi6N4M5gOviwN0Gj8ar9v5OoTD3r5x8QDh12LY4jY520aZV+3lf6+
	K1c6deNDgbZm8BLzCB/eoHG01cFBZOI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-INOvlRtuOvSHdzhw-Zjj3Q-1; Fri, 16 Feb 2024 10:28:53 -0500
X-MC-Unique: INOvlRtuOvSHdzhw-Zjj3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 860A885A58A;
	Fri, 16 Feb 2024 15:28:51 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.33.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1369D1C066AA;
	Fri, 16 Feb 2024 15:28:51 +0000 (UTC)
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
Subject: [RFC 7/7] selftests: openvswitch: add config and timeout settings
Date: Fri, 16 Feb 2024 10:28:46 -0500
Message-ID: <20240216152846.1850120-8-aconole@redhat.com>
In-Reply-To: <20240216152846.1850120-1-aconole@redhat.com>
References: <20240216152846.1850120-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

In order for the ovs selftests to run, we need to introduce a sample
configuration.  This will get run under the kselftest runner for net, but
given that environment can be limited process wise, the test can take
longer than on bare metal or high availability VMs.  So, also introduce
a settings file which includes a timeout value that should be sufficent
for such environments.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 .../testing/selftests/net/openvswitch/config  | 50 +++++++++++++++++++
 .../selftests/net/openvswitch/settings        |  1 +
 2 files changed, 51 insertions(+)
 create mode 100644 tools/testing/selftests/net/openvswitch/config
 create mode 100644 tools/testing/selftests/net/openvswitch/settings

diff --git a/tools/testing/selftests/net/openvswitch/config b/tools/testing/selftests/net/openvswitch/config
new file mode 100644
index 000000000000..24cff330f3c0
--- /dev/null
+++ b/tools/testing/selftests/net/openvswitch/config
@@ -0,0 +1,50 @@
+CONFIG_OPENVSWITCH=m
+CONFIG_OPENVSWITCH_GRE=m
+CONFIG_OPENVSWITCH_VXLAN=m
+CONFIG_OPENVSWITCH_GENEVE=m
+CONFIG_NF_CONNTRACK_OVS=y
+CONFIG_NF_NAT_OVS=y
+CONFIG_NF_NAT=m
+CONFIG_NF_CONNTRACK=m
+CONFIG_GENEVE=y
+CONFIG_VXLAN=y
+CONFIG_IPV6=y
+CONFIG_TUN=y
+CONFIG_TAP=y
+CONFIG_USER_NS=y
+CONFIG_NET_NS=y
+CONFIG_SYSFS=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_VETH=y
+CONFIG_DUMMY=y
+CONFIG_NETFILTER=y
+CONFIG_NETFILTER_ADVANCED=y
+CONFIG_IP6_NF_IPTABLES=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP6_NF_NAT=m
+CONFIG_IP_NF_NAT=m
+CONFIG_IPV6_GRE=m
+CONFIG_TRACEPOINTS=y
+CONFIG_NET_DROP_MONITOR=m
+CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_IPV6=y
+CONFIG_NF_TABLES_IPV4=y
+CONFIG_KALLSYMS=y
+CONFIG_BRIDGE=m
+CONFIG_VLAN_8021Q=m
+CONFIG_BRIDGE_VLAN_FILTERING=y
+CONFIG_NET_L3_MASTER_DEV=y
+CONFIG_IPV6_MULTIPLE_TABLES=y
+CONFIG_NET_VRF=m
+CONFIG_BPF_SYSCALL=y
+CONFIG_CGROUP_BPF=y
+CONFIG_NET_ACT_CT=m
+CONFIG_NET_ACT_MIRRED=m
+CONFIG_NET_ACT_MPLS=m
+CONFIG_NET_ACT_VLAN=m
+CONFIG_NET_CLS_FLOWER=m
+CONFIG_NET_CLS_MATCHALL=m
+CONFIG_NET_SCH_INGRESS=m
+CONFIG_NET_ACT_GACT=m
+CONFIG_NAMESPACES=y
diff --git a/tools/testing/selftests/net/openvswitch/settings b/tools/testing/selftests/net/openvswitch/settings
new file mode 100644
index 000000000000..694d70710ff0
--- /dev/null
+++ b/tools/testing/selftests/net/openvswitch/settings
@@ -0,0 +1 @@
+timeout=300
-- 
2.41.0


