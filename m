Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658893B827B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jun 2021 14:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbhF3MyY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Jun 2021 08:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234792AbhF3MyX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Jun 2021 08:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625057514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=84cTndThNFAP1cz9xpPfYSoGM0TMxENWRGeocdlBP7E=;
        b=c6VvIsAQSFA9kXlZs29RM0gR3Rv33R7Po+Ou3Yp1irEQk5qi0P/A6ksfvqpjPB+sFn+xJl
        G1iYilMpgAmVaVPgl+n2H4uk38k+6DVT707eWM6GEbBIWbqOYJ6Hoe/J7lbD8B/zYmesmP
        I8ehniI+idtB7p/3TuAG4DcOECrHb4U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-JtgVSbWpONygIzVwXgGLsg-1; Wed, 30 Jun 2021 08:51:52 -0400
X-MC-Unique: JtgVSbWpONygIzVwXgGLsg-1
Received: by mail-wr1-f72.google.com with SMTP id g4-20020a5d64e40000b029012469ad3be8so931503wri.1
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Jun 2021 05:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=84cTndThNFAP1cz9xpPfYSoGM0TMxENWRGeocdlBP7E=;
        b=uAmCe8qttEENVMDnzOqPY9gbn3pmAFUDkfY6v+DNF2kQqhoTKx0Cn5b11borgHAqxI
         hIFxCngctPf+lIDMSkk2bNpvlwRL3iGFh7W7IDoNe4n02v3I9yLdh6uP//yzj7+JacdU
         IkXLG18SIjv9mu8eW6iRKPKMobFTV/kTfHlMB8MDxY/B86IUEThh1O21e9U8oze9f8nN
         TtupBJ9alhqb26OLhwxBWiS5l0TPjqJwK5rblMpUP0gRMrYrlmoGIprRntAH+08jMxcM
         qMAzwipE1vY/yFPiePVFH7U8nfQbBkHdizhGeAqo4Wo4YqrpyB41oHTgy6UHgnxPjqNH
         rbqA==
X-Gm-Message-State: AOAM533j/hsk9WYrlp7CpvrF3cF4x+taZiokNK0KVxLdRYdI8cX5J2dR
        HhaIPnX605XeVLYdR2H1hDBmx/xXucFOnAQtUz3HUpGN1/tab0im4MJmPmdrP2kUOyvqrqp0ES0
        rm7prEnoL3zVcSJcxPjli9y6OrBM+
X-Received: by 2002:a05:600c:2243:: with SMTP id a3mr4509986wmm.86.1625057511797;
        Wed, 30 Jun 2021 05:51:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJtHA1JpXRvoSoeZX/KpRktkcHYi/igAmdcBzVYumDkUdf7bojHz46vt8JXkhH0vapodEjcA==
X-Received: by 2002:a05:600c:2243:: with SMTP id a3mr4509967wmm.86.1625057511624;
        Wed, 30 Jun 2021 05:51:51 -0700 (PDT)
Received: from pc-23.home (2a01cb058d44a7001b6d03f4d258668b.ipv6.abo.wanadoo.fr. [2a01:cb05:8d44:a700:1b6d:3f4:d258:668b])
        by smtp.gmail.com with ESMTPSA id n8sm21822762wrt.95.2021.06.30.05.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 05:51:51 -0700 (PDT)
Date:   Wed, 30 Jun 2021 14:51:49 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 4/4] selftests: forwarding: Test redirecting vxlan
 and bareudp packets to Ethernet
Message-ID: <340d1bce299c23e3f7e97d8b71b0f38a2ce0a7e3.1625056665.git.gnault@redhat.com>
References: <cover.1625056665.git.gnault@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1625056665.git.gnault@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add selftests for the following commit:
  * 99c8719b7981 ("bareudp: allow redirecting bareudp packets to eth
    devices").
(no commit for VXLAN-GPE, which has always worked in this configuration).

Only test collect-md mode as both bareudp and vxlan-gpe devices don't
currently implement classical mode.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 tools/testing/selftests/net/forwarding/config |  2 +
 .../net/forwarding/tc_redirect_l2l3.sh        | 55 +++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/config b/tools/testing/selftests/net/forwarding/config
index 5d3ab2b63c53..ec49660ee808 100644
--- a/tools/testing/selftests/net/forwarding/config
+++ b/tools/testing/selftests/net/forwarding/config
@@ -21,3 +21,5 @@ CONFIG_NET_IPIP=m
 CONFIG_IPV6_SIT=m
 CONFIG_IPV6_GRE=m
 CONFIG_IPV6_TUNNEL=m
+CONFIG_VXLAN=m
+CONFIG_BAREUDP=m
diff --git a/tools/testing/selftests/net/forwarding/tc_redirect_l2l3.sh b/tools/testing/selftests/net/forwarding/tc_redirect_l2l3.sh
index 207b92775a6c..db8ccef9a334 100755
--- a/tools/testing/selftests/net/forwarding/tc_redirect_l2l3.sh
+++ b/tools/testing/selftests/net/forwarding/tc_redirect_l2l3.sh
@@ -27,6 +27,8 @@ ALL_TESTS="
 	redir_sit
 	redir_ip6gre
 	redir_ip6tnl
+	redir_vxlan_gpe
+	redir_bareudp
 "
 
 NUM_NETIFS=0
@@ -354,6 +356,59 @@ redir_ip6tnl()
 	cleanup_tunnel
 }
 
+redir_vxlan_gpe()
+{
+	local IP
+
+	# As of Linux 5.13, VXLAN-GPE only supports collect-md mode
+	for UNDERLAY_IPVERS in 4 6; do
+		IP="IPv${UNDERLAY_IPVERS}"
+
+		setup_tunnel "${IP}" "collect_md" "vxlan" "gpe external" "id 10"
+		ping_test ipv4 "VXLAN-GPE, external mode: ${IP} / UDP / VXLAN-GPE / IPv4"
+		ping_test ipv6 "VXLAN-GPE, external mode: ${IP} / UDP / VXLAN-GPE / IPv6"
+		ping_test ipv4-mpls "VXLAN-GPE, external mode: ${IP} / UDP / VXLAN-GPE / MPLS / IPv4"
+		ping_test ipv6-mpls "VXLAN-GPE, external mode: ${IP} / UDP / VXLAN-GPE / MPLS / IPv6"
+		cleanup_tunnel
+	done
+}
+
+redir_bareudp()
+{
+	local IP
+
+	# As of Linux 5.13, Bareudp only supports collect-md mode
+	for UNDERLAY_IPVERS in 4 6; do
+		IP="IPv${UNDERLAY_IPVERS}"
+
+		# IPv4 overlay
+		setup_tunnel "${IP}" "collect_md" "bareudp" \
+			"dstport 6635 ethertype ipv4"
+		ping_test ipv4 "Bareudp, external mode: ${IP} / UDP / IPv4"
+		cleanup_tunnel
+
+		# IPv6 overlay
+		setup_tunnel "${IP}" "collect_md" "bareudp" \
+			"dstport 6635 ethertype ipv6"
+		ping_test ipv6 "Bareudp, external mode: ${IP} / UDP / IPv6"
+		cleanup_tunnel
+
+		# Combined IPv4/IPv6 overlay (multiproto mode)
+		setup_tunnel "${IP}" "collect_md" "bareudp" \
+			"dstport 6635 ethertype ipv4 multiproto"
+		ping_test ipv4 "Bareudp, external mode: ${IP} / UDP / IPv4 (multiproto)"
+		ping_test ipv6 "Bareudp, external mode: ${IP} / UDP / IPv6 (multiproto)"
+		cleanup_tunnel
+
+		# MPLS overlay
+		setup_tunnel "${IP}" "collect_md" "bareudp" \
+			"dstport 6635 ethertype mpls_uc"
+		ping_test ipv4-mpls "Bareudp, external mode: ${IP} / UDP / MPLS / IPv4"
+		ping_test ipv6-mpls "Bareudp, external mode: ${IP} / UDP / MPLS / IPv6"
+		cleanup_tunnel
+	done
+}
+
 exit_cleanup()
 {
 	if [ "${TESTS_COMPLETED}" = "no" ]; then
-- 
2.21.3

