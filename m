Return-Path: <linux-kselftest+bounces-2558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A57821B01
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 12:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42DCE28324E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 11:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53151EAD3;
	Tue,  2 Jan 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICocrGht"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7626E544
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jan 2024 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704195184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XWxHimkeFDNjn6YSxYvmBLIqeHTwIpJqYoBnohM5/0g=;
	b=ICocrGhtYhSmH1Y2HwX2DibKNNAXD4BN7a5a6YQQ2Ks9KWAjCcaYOrEMrYZCQLs66Ofk7y
	k6SWNRTJiex86prb/97jq4IBFQ5phyPkyCWpwkvJlzHjqgG8KLr9r09kjqiN+RXr/U1KpC
	coOXVjSB4ylLZXMT9AFWR/IHoYQPyt0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-NJOorye0PeOE-_05NUvyOw-1; Tue, 02 Jan 2024 06:33:02 -0500
X-MC-Unique: NJOorye0PeOE-_05NUvyOw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40d45be1ce2so44171985e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jan 2024 03:33:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704195181; x=1704799981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWxHimkeFDNjn6YSxYvmBLIqeHTwIpJqYoBnohM5/0g=;
        b=COPveJ8dVBIeADEH2dsq1oG0ypVGR4Fx9y0UcSBibEwkCsfgZkiyeezPz94zlfZXku
         JYc1+bc8SgbqcsctQvp+mFFumXbcA9nkKKK9mtOj18rhK34soOAKMidBof5Zny2XiZm3
         jGkfX7tItpxR0kV5NZwWJCjEveKj8+5a/xcxZNUC/xzEB4W0pyx8UpYBPXC/piEwvdS+
         Heey/iq6ynsp/Rk0YzBH+w7iKr4suckCXJnCkXWbsfrYBiYH3flbCZauG8NuM7w+n2RP
         K84JiqRJCsWJDD7KVokBqtSj97V40Izny00vXUtDbXyKf2+k1rYZ3+C2TtueSdK8vrnp
         BGvg==
X-Gm-Message-State: AOJu0Yx9T04OgZShdfLp5FW3bfPday08jce84HpctD2VtEk/jqq8uoTP
	ghPUjdlZtigjNFJMYBKTpX/plZ9KdYY9ctH5NNQwYOFFWeV0sBNd7iRX9k9/xQhxjHfOE5qNl4P
	UJD9RT1EAh2WscOqIhwnST0BoWqd0xQ2UPT6f
X-Received: by 2002:a05:600c:2255:b0:40d:80a1:867 with SMTP id a21-20020a05600c225500b0040d80a10867mr2701909wmm.146.1704195180976;
        Tue, 02 Jan 2024 03:33:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmH97otICNik6jF5g8bpqPEue2LDedjKabzLVwMIouA4GG3UCE1rYraye49W7NVZJ+THP9GQ==
X-Received: by 2002:a05:600c:2255:b0:40d:80a1:867 with SMTP id a21-20020a05600c225500b0040d80a10867mr2701899wmm.146.1704195180607;
        Tue, 02 Jan 2024 03:33:00 -0800 (PST)
Received: from debian (2a01cb058918ce008532542fb9fcf433.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:8532:542f:b9fc:f433])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d49d2000000b00336751cd4ebsm28311844wrs.72.2024.01.02.03.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 03:33:00 -0800 (PST)
Date: Tue, 2 Jan 2024 12:32:58 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: netdev@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	lkp@intel.com, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 net-next] selftests/net: change shebang to bash to
 support "source"
Message-ID: <ZZP0akFff+nzFhc0@debian>
References: <20231229131931.3961150-1-yujie.liu@intel.com>
 <ZZFbxyQeHgf3UQrN@debian>
 <ZZPHQF6wL95oSGzK@yujie-X299>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZPHQF6wL95oSGzK@yujie-X299>

On Tue, Jan 02, 2024 at 04:20:16PM +0800, Yujie Liu wrote:
> On Sun, Dec 31, 2023 at 01:17:11PM +0100, Guillaume Nault wrote:
> > On Fri, Dec 29, 2023 at 09:19:31PM +0800, Yujie Liu wrote:
> > > The patch set [1] added a general lib.sh in net selftests, and converted
> > > several test scripts to source the lib.sh.
> > > 
> > > unicast_extensions.sh (converted in [1]) and pmtu.sh (converted in [2])
> > > have a /bin/sh shebang which may point to various shells in different
> > > distributions, but "source" is only available in some of them. For
> > > example, "source" is a built-it function in bash, but it cannot be
> > > used in dash.
> > > 
> > > Refer to other scripts that were converted together, simply change the
> > > shebang to bash to fix the following issues when the default /bin/sh
> > > points to other shells.
> > 
> > Looks like it'd be simpler to just replace the "source" commands with
> > "." and leave the shebang as is (unless there are other bash-specific
> > constructs in these scripts of course).
> > 
> > Generally speaking, I think we should avoid madating a specific shell,
> > unless that really simplifies the test script (which is not the case
> > here).
> 
> Hi Guillaume,
> 
> Thanks for the comments. Actually I also considered replacing "source"
> with "." at first, but finally decided to change the shebang in
> consideration of being consistent with other scripts. We can see that
> there are 140+ scripts in net selftests that have "source lib.sh" and
> "bash" shebang, but none of the selftests has ". lib.sh". If we replace
> "source" with "." and keep the "sh" shebang specifically for
> unicast_extensions.sh and pmtu.sh, we will get only 2 scripts using
> "sh and ." while most other scripts using "bash and source". Maybe it
> would be nice to keep the consistency by changing the shebang as well?
> What do you think? :)

The use of "source" instead of "." is clearly an overlook. Consistency
is desirable only when it brings better quality code.

And it should be easy enough to convert the remaining "source lib.sh"
in a followup patch to make the other shell scripts consistent.


> linux/tools/testing/selftests/net$ grep -rl "source lib.sh" . | xargs grep -F '#!/bin/'
> ./test_vxlan_under_vrf.sh:#!/bin/bash
> ./test_vxlan_nolocalbypass.sh:#!/bin/bash
> ./xfrm_policy.sh:#!/bin/bash
> ./test_vxlan_mdb.sh:#!/bin/bash
> ./test_bridge_backup_port.sh:#!/bin/bash
> ./vrf_route_leaking.sh:#!/bin/bash
> ./l2tp.sh:#!/bin/bash
> ./netns-name.sh:#!/bin/bash
> ./rtnetlink.sh:#!/bin/bash
> ./ioam6.sh:#!/bin/bash
> ./drop_monitor_tests.sh:#!/bin/bash
> ./test_vxlan_vnifiltering.sh:#!/bin/bash
> ./icmp.sh:#!/bin/bash
> ./gre_gso.sh:#!/bin/bash
> ./fib_nexthop_multiprefix.sh:#!/bin/bash
> ./icmp_redirect.sh:#!/bin/bash
> ./vrf-xfrm-tests.sh:#!/bin/bash
> ./vrf_strict_mode_test.sh:#!/bin/bash
> ./fcnal-test.sh:#!/bin/bash
> ./stress_reuseport_listen.sh:#!/bin/bash
> ./srv6_end_dt4_l3vpn_test.sh:#!/bin/bash
> ./test_bridge_neigh_suppress.sh:#!/bin/bash
> ./cmsg_ipv6.sh:#!/bin/bash
> ./arp_ndisc_evict_nocarrier.sh:#!/bin/bash
> ./fib_rule_tests.sh:#!/bin/bash
> ./srv6_end_dt6_l3vpn_test.sh:#!/bin/bash
> ./forwarding/custom_multipath_hash.sh:#!/bin/bash
> ./forwarding/gre_inner_v4_multipath.sh:#!/bin/bash
> ./forwarding/tc_tunnel_key.sh:#!/bin/bash
> ./forwarding/tc_shblocks.sh:#!/bin/bash
> ./forwarding/router_nh.sh:#!/bin/bash
> ./forwarding/skbedit_priority.sh:#!/bin/bash
> ./forwarding/tc_mpls_l2vpn.sh:#!/bin/bash
> ./forwarding/gre_inner_v6_multipath.sh:#!/bin/bash
> ./forwarding/vxlan_symmetric.sh:#!/bin/bash
> ./forwarding/bridge_mdb.sh:#!/bin/bash
> ./forwarding/no_forwarding.sh:#!/bin/bash
> ./forwarding/router_bridge_1d.sh:#!/bin/bash
> ./forwarding/tc_flower_port_range.sh:#!/bin/bash
> ./forwarding/router_multicast.sh:#!/bin/bash
> ./forwarding/bridge_locked_port.sh:#!/bin/bash
> ./forwarding/vxlan_asymmetric_ipv6.sh:#!/bin/bash
> ./forwarding/dual_vxlan_bridge.sh:#!/bin/bash
> ./forwarding/bridge_port_isolation.sh:#!/bin/bash
> ./forwarding/local_termination.sh:#!/bin/bash
> ./forwarding/ipip_flat_gre_keys.sh:#!/bin/bash
> ./forwarding/gre_multipath_nh_res.sh:#!/bin/bash
> ./forwarding/gre_multipath.sh:#!/bin/bash
> ./forwarding/vxlan_bridge_1d_ipv6.sh:#!/bin/bash
> ./forwarding/ip6gre_flat_keys.sh:#!/bin/bash
> ./forwarding/gre_multipath_nh.sh:#!/bin/bash
> ./forwarding/bridge_mld.sh:#!/bin/bash
> ./forwarding/ip6gre_inner_v6_multipath.sh:#!/bin/bash
> ./forwarding/ip6gre_flat_key.sh:#!/bin/bash
> ./forwarding/vxlan_asymmetric.sh:#!/bin/bash
> ./forwarding/tc_flower_router.sh:#!/bin/bash
> ./forwarding/router_bridge_vlan_upper_pvid.sh:#!/bin/bash
> ./forwarding/mirror_gre_vlan_bridge_1q.sh:#!/bin/bash
> ./forwarding/q_in_vni_ipv6.sh:#!/bin/bash
> ./forwarding/mirror_gre_lag_lacp.sh:#!/bin/bash
> ./forwarding/ip6gre_custom_multipath_hash.sh:#!/bin/bash
> ./forwarding/vxlan_bridge_1d.sh:#!/bin/bash
> ./forwarding/ip6gre_hier_key.sh:#!/bin/bash
> ./forwarding/gre_custom_multipath_hash.sh:#!/bin/bash
> ./forwarding/ipip_flat_gre_key.sh:#!/bin/bash
> ./forwarding/mirror_gre_flower.sh:#!/bin/bash
> ./forwarding/router_bridge.sh:#!/bin/bash
> ./forwarding/vxlan_symmetric_ipv6.sh:#!/bin/bash
> ./forwarding/mirror_gre_bridge_1q.sh:#!/bin/bash
> ./forwarding/router_multipath.sh:#!/bin/bash
> ./forwarding/tc_vlan_modify.sh:#!/bin/bash
> ./forwarding/vxlan_bridge_1q.sh:#!/bin/bash
> ./forwarding/bridge_mdb_port_down.sh:#!/bin/bash
> ./forwarding/tc_flower.sh:#!/bin/bash
> ./forwarding/tc_flower_cfm.sh:#!/bin/bash
> ./forwarding/mirror_gre_neigh.sh:#!/bin/bash
> ./forwarding/ethtool_rmon.sh:#!/bin/bash
> ./forwarding/hw_stats_l3_gre.sh:#!/bin/bash
> ./forwarding/router.sh:#!/bin/bash
> ./forwarding/ipip_hier_gre_key.sh:#!/bin/bash
> ./forwarding/tc_police.sh:#!/bin/bash
> ./forwarding/pedit_ip.sh:#!/bin/bash
> ./forwarding/ip6_forward_instats_vrf.sh:#!/bin/bash
> ./forwarding/router_mpath_nh_res.sh:#!/bin/bash
> ./forwarding/mirror_gre_changes.sh:#!/bin/bash
> ./forwarding/hw_stats_l3.sh:#!/bin/bash
> ./forwarding/ipip_hier_gre.sh:#!/bin/bash
> ./forwarding/q_in_vni.sh:#!/bin/bash
> ./forwarding/ip6gre_flat.sh:#!/bin/bash
> ./forwarding/router_bridge_vlan_upper.sh:#!/bin/bash
> ./forwarding/bridge_igmp.sh:#!/bin/bash
> ./forwarding/mirror_gre_nh.sh:#!/bin/bash
> ./forwarding/bridge_mdb_host.sh:#!/bin/bash
> ./forwarding/ipip_hier_gre_keys.sh:#!/bin/bash
> ./forwarding/pedit_dsfield.sh:#!/bin/bash
> ./forwarding/bridge_vlan_mcast.sh:#!/bin/bash
> ./forwarding/mirror_gre_bridge_1d_vlan.sh:#!/bin/bash
> ./forwarding/router_bridge_1d_lag.sh:#!/bin/bash
> ./forwarding/router_bridge_pvid_vlan_upper.sh:#!/bin/bash
> ./forwarding/mirror_gre_bound.sh:#!/bin/bash
> ./forwarding/ip6gre_hier.sh:#!/bin/bash
> ./forwarding/ip6gre_hier_keys.sh:#!/bin/bash
> ./forwarding/ethtool_extended_state.sh:#!/bin/bash
> ./forwarding/router_mpath_nh.sh:#!/bin/bash
> ./forwarding/tc_flower_l2_miss.sh:#!/bin/bash
> ./forwarding/bridge_vlan_unaware.sh:#!/bin/bash
> ./forwarding/router_broadcast.sh:#!/bin/bash
> ./forwarding/bridge_fdb_learning_limit.sh:#!/bin/bash
> ./forwarding/ipip_lib.sh:#!/bin/bash
> ./forwarding/ip6gre_inner_v4_multipath.sh:#!/bin/bash
> ./forwarding/router_vid_1.sh:#!/bin/bash
> ./forwarding/mirror_gre.sh:#!/bin/bash
> ./forwarding/router_bridge_vlan.sh:#!/bin/bash
> ./forwarding/bridge_vlan_aware.sh:#!/bin/bash
> ./forwarding/ethtool.sh:#!/bin/bash
> ./forwarding/loopback.sh:#!/bin/bash
> ./forwarding/bridge_sticky_fdb.sh:#!/bin/bash
> ./forwarding/bridge_mdb_max.sh:#!/bin/bash
> ./forwarding/pedit_l4port.sh:#!/bin/bash
> ./forwarding/tc_actions.sh:#!/bin/bash
> ./forwarding/mirror_vlan.sh:#!/bin/bash
> ./forwarding/sch_red.sh:#!/bin/bash
> ./forwarding/ipip_flat_gre.sh:#!/bin/bash
> ./forwarding/mirror_gre_bridge_1d.sh:#!/bin/bash
> ./forwarding/lib.sh:#!/bin/bash
> ./forwarding/mirror_gre_vlan.sh:#!/bin/bash
> ./forwarding/mirror_gre_bridge_1q_lag.sh:#!/bin/bash
> ./forwarding/ethtool_mm.sh:#!/bin/bash
> ./forwarding/vxlan_bridge_1q_ipv6.sh:#!/bin/bash
> ./forwarding/tc_chains.sh:#!/bin/bash
> ./forwarding/ip6gre_lib.sh:#!/bin/bash
> ./fib_nexthop_nongw.sh:#!/bin/bash
> ./srv6_end_dt46_l3vpn_test.sh:#!/bin/bash
> ./cmsg_so_mark.sh:#!/bin/bash
> ./sctp_vrf.sh:#!/bin/bash
> ./fdb_flush.sh:#!/bin/bash
> ./ndisc_unsolicited_na_test.sh:#!/bin/bash
> ./traceroute.sh:#!/bin/bash
> ./fib-onlink-tests.sh:#!/bin/bash
> ./fib_tests.sh:#!/bin/bash
> ./cmsg_time.sh:#!/bin/bash
> ./arp_ndisc_untracked_subnets.sh:#!/bin/bash
> ./fib_nexthops.sh:#!/bin/bash
> 
> linux/tools/testing/selftests/net$ grep -rF ". lib.sh"
> <-- nothing
> 
> Thanks,
> Yujie
> 


