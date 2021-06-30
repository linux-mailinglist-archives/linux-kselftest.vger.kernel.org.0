Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1B93B8279
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jun 2021 14:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhF3MyW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Jun 2021 08:54:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234792AbhF3MyT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Jun 2021 08:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625057510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vmlEc7BRwRklazdkT1yBzgyfwWXXs4DP38lEt6D8vPg=;
        b=RriN5BorCFbaltzXyvKyl2kapy5rVuiVg2oEObSIlM6uV4N4WsIhf97nEyK6j1Zqz1Sgjw
        nwGUnOv7R8rB25mUMwz22ZKag26ZW8BINYoXCP8nuWQxo1lAT70E3ABPxsh2RWE9aJYU5k
        EgxUCFi8qDLp6msdgZVE6ljucGFi82Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-Y-dgomzbO1Wk0bsoeLzIFA-1; Wed, 30 Jun 2021 08:51:48 -0400
X-MC-Unique: Y-dgomzbO1Wk0bsoeLzIFA-1
Received: by mail-wr1-f70.google.com with SMTP id h104-20020adf90710000b029010de8455a3aso913261wrh.12
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Jun 2021 05:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vmlEc7BRwRklazdkT1yBzgyfwWXXs4DP38lEt6D8vPg=;
        b=NKudRvlFkl7RKx/STGh8E3tvtp3BV1u1giS+bCarnEQ27TtHg3jSUJwAy8/1TqFPYH
         RG0dVRbc4fjXNGpv5/7phF7FAIRuP9CGOTKgmkup/xvUN0LzFfOCqKEiAkxa46b+ffSo
         0DzzNP/qC0Az0R9yZw6TU0EESeebRbwE4eCyGwjSo9v+03cTVVOQCo4Q7fvvps1KpR/7
         MEp+RyKMVlojeVfeqmLaKlXDBcrtl8/rDRlUhcEIE9b4T7xvsEDaDkPg7mjGSmYZqVRX
         LmrcodF4aZih+Z/Rgwfz54Qi6Ajk/XcHlbjPdLlBswVkISGRLVp34MaCiGI/IHJr4BHA
         iJDw==
X-Gm-Message-State: AOAM531rMk2BOmS/AzVyLUH4ZrV2NAlwE0GTrTBhr12vLiv52Amo4DtR
        7OX1VKG/EAeKskMpcGF9aYIhfrdrMiwm/RDmfvtIQG7VpoIcPHqi3lGkCBj6IDyGrRsXZHLkP13
        dOH10RHHQmSJukIvkBPfTciMNHuM6
X-Received: by 2002:a5d:4d10:: with SMTP id z16mr39650844wrt.296.1625057507595;
        Wed, 30 Jun 2021 05:51:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/z0yTUQ82kcINzCdIP308oyLfib5e0SKB8ho1B0Sxjzwhdfu/d+VuFCU7w/Tx5b++OoL9Yw==
X-Received: by 2002:a5d:4d10:: with SMTP id z16mr39650835wrt.296.1625057507475;
        Wed, 30 Jun 2021 05:51:47 -0700 (PDT)
Received: from pc-23.home (2a01cb058d44a7001b6d03f4d258668b.ipv6.abo.wanadoo.fr. [2a01:cb05:8d44:a700:1b6d:3f4:d258:668b])
        by smtp.gmail.com with ESMTPSA id w9sm21654363wru.3.2021.06.30.05.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 05:51:47 -0700 (PDT)
Date:   Wed, 30 Jun 2021 14:51:45 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 3/4] selftests: forwarding: Test redirecting ip6gre
 and ip6tnl packets to Ethernet
Message-ID: <a7e9114c4c091fe7a39cc4c7ab42b6c1f53b3df4.1625056665.git.gnault@redhat.com>
References: <cover.1625056665.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1625056665.git.gnault@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add selftests for the following commit:
  * da5a2e49f064 ("ip6_tunnel: allow redirecting ip6gre and ipxip6
    packets to eth devices").

Like with the previous tc_redirect_l2l3.sh tests, verify that the
following tc filter works on the ingress qdisc of ip6gre and ip6tnl
devices:
  $ tc filter add dev tunnel0 ingress matchall       \
      action vlan push_eth dst_mac 00:00:5e:00:53:01 \
                           src_mac 00:00:5e:00:53:00 \
      action mirred egress redirect dev eth0

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 tools/testing/selftests/net/forwarding/config |  2 ++
 .../net/forwarding/tc_redirect_l2l3.sh        | 36 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/config b/tools/testing/selftests/net/forwarding/config
index c543b441a8b5..5d3ab2b63c53 100644
--- a/tools/testing/selftests/net/forwarding/config
+++ b/tools/testing/selftests/net/forwarding/config
@@ -19,3 +19,5 @@ CONFIG_NET_NS=y
 CONFIG_NET_IPGRE=m
 CONFIG_NET_IPIP=m
 CONFIG_IPV6_SIT=m
+CONFIG_IPV6_GRE=m
+CONFIG_IPV6_TUNNEL=m
diff --git a/tools/testing/selftests/net/forwarding/tc_redirect_l2l3.sh b/tools/testing/selftests/net/forwarding/tc_redirect_l2l3.sh
index fd9e15a6417b..207b92775a6c 100755
--- a/tools/testing/selftests/net/forwarding/tc_redirect_l2l3.sh
+++ b/tools/testing/selftests/net/forwarding/tc_redirect_l2l3.sh
@@ -25,6 +25,8 @@ ALL_TESTS="
 	redir_gre
 	redir_ipip
 	redir_sit
+	redir_ip6gre
+	redir_ip6tnl
 "
 
 NUM_NETIFS=0
@@ -318,6 +320,40 @@ redir_sit()
 	cleanup_tunnel
 }
 
+redir_ip6gre()
+{
+	setup_tunnel "ipv6" "classical" "ip6gre"
+	ping_test ipv4 "IP6GRE, classical mode: IPv6 / GRE / IPv4"
+	ping_test ipv6 "IP6GRE, classical mode: IPv6 / GRE / IPv6"
+	ping_test ipv4-mpls "IP6GRE, classical mode: IPv6 / GRE / MPLS / IPv4"
+	ping_test ipv6-mpls "IP6GRE, classical mode: IPv6 / GRE / MPLS / IPv6"
+	cleanup_tunnel
+
+	setup_tunnel "ipv6" "collect_md" "ip6gre" "external" "nocsum"
+	ping_test ipv4 "IP6GRE, external mode: IPv6 / GRE / IPv4"
+	ping_test ipv6 "IP6GRE, external mode: IPv6 / GRE / IPv6"
+	ping_test ipv4-mpls "IP6GRE, external mode: IPv6 / GRE / MPLS / IPv4"
+	ping_test ipv6-mpls "IP6GRE, external mode: IPv6 / GRE / MPLS / IPv6"
+	cleanup_tunnel
+}
+
+redir_ip6tnl()
+{
+	setup_tunnel "ipv6" "classical" "ip6tnl" "mode any"
+	ping_test ipv4 "IP6TNL, classical mode: IPv6 / IPv4"
+	ping_test ipv6 "IP6TNL, classical mode: IPv6 / IPv6"
+	ping_test ipv4-mpls "IP6TNL, classical mode: IPv6 / MPLS / IPv4"
+	ping_test ipv6-mpls "IP6TNL, classical mode: IPv6 / MPLS / IPv6"
+	cleanup_tunnel
+
+	setup_tunnel "ipv6" "collect_md" "ip6tnl" "mode any external"
+	ping_test ipv4 "IP6TNL, external mode: IPv6 / IPv4"
+	ping_test ipv6 "IP6TNL, external mode: IPv6 / IPv6"
+	ping_test ipv4-mpls "IP6TNL, external mode: IPv6 / MPLS / IPv4"
+	ping_test ipv6-mpls "IP6TNL, external mode: IPv6 / MPLS / IPv6"
+	cleanup_tunnel
+}
+
 exit_cleanup()
 {
 	if [ "${TESTS_COMPLETED}" = "no" ]; then
-- 
2.21.3

