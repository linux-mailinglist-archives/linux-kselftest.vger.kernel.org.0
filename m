Return-Path: <linux-kselftest+bounces-866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D63567FE7FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 05:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4AF2823FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 04:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141C914281;
	Thu, 30 Nov 2023 04:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2FCPRiU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239E010EF;
	Wed, 29 Nov 2023 20:01:35 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cd8ce7bf7fso557623b3a.0;
        Wed, 29 Nov 2023 20:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701316894; x=1701921694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+tlaVF1ejQT2xc/EK+l82WKo2KG81j1KjdJppLPFqI=;
        b=c2FCPRiUR+TGH+FLGR9i+DHONelhR1zxQZ+RDHYS68/JIEGg7s/Qxy/tPLMsynC42k
         DyMir+DVK2GDAm3VlbdJe8XLTwB1gLY2CxHYDpPZv75OJsfMPqCuTndhzrKLgx+pIuN6
         9oxgEL38o78K4cNWkvd4Mk42b9+eYrr2x7wgSZLhl/r4JmuSbj1YSDSVoLYCW4RfNP71
         IBghsCLy3AzDMsyH1YfICc19s+FXhxN3JtN/tCih+W4VeM/J3O0rwP50tOII+H6ueYrh
         3ueebgQRxtB8CSHC2Z8OjMpG8e56DV23tQf32I3z/WZueKBklJdigfvC1vYtX/cBVgBX
         Bpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701316894; x=1701921694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+tlaVF1ejQT2xc/EK+l82WKo2KG81j1KjdJppLPFqI=;
        b=cwSInC+i9Lz9YHxMM7dD+sAVvQUS4Jh5N4dFmyYAO1GJiPoDOai2vtWBZq83UGKmw3
         PQHFK7zzPxboDoXbafqJdNukX6Mj456b4klPZ+ufIFGqm5tbz4NUYCrR0ZXNKHZVKzuA
         dPYWBFF+CLA0++deIyLLJ/5qHQA9EJgQxQ0LQx+YeIyI72c7WUnwoWcRJuNGpSlpsP2m
         JFQQm3opz/KxrtHk70eeEy/+IVnJdug2AgiIHM2RX8MfUqMvIHf2miTT9CKLa4zsj57J
         VYYtYLXzOIykMjeu63I+cChTSPUZsaXSr1GyrTpDEVPgjWs2Zsa4hVr3OTr/MY2ygCx7
         6zIg==
X-Gm-Message-State: AOJu0YyYdJj2HykhOskVc1qVRptIR63sWT2VWf01yH+AAm/6KvUoWTFd
	SFO7b5JMGhviBXUhpZXbDT0sTEkTCA3YHg==
X-Google-Smtp-Source: AGHT+IH/mHh293wvbNitlgZDU/VONVhLHnyc2aYeMAg5lDs2IV40iD9ZHrjYIUwEu+fsM+IjbzTAOg==
X-Received: by 2002:a05:6a00:2da7:b0:6be:4789:97ba with SMTP id fb39-20020a056a002da700b006be478997bamr20311594pfb.3.1701316893788;
        Wed, 29 Nov 2023 20:01:33 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p16-20020aa78610000000b006cc02a6d18asm187975pfn.61.2023.11.29.20.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 20:01:33 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	James Prestwood <prestwoj@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Francesco Ruggeri <fruggeri@arista.com>,
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 04/14] selftests/net: convert arp_ndisc_untracked_subnets.sh to run it in unique namespace
Date: Thu, 30 Nov 2023 12:00:55 +0800
Message-ID: <20231130040105.1265779-5-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130040105.1265779-1-liuhangbin@gmail.com>
References: <20231130040105.1265779-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the test result after conversion.

2 tests also failed without this patch

]# ./arp_ndisc_untracked_subnets.sh
    TEST: test_arp:  accept_arp=0                                       [ OK ]
    TEST: test_arp:  accept_arp=1                                       [ OK ]
    TEST: test_arp:  accept_arp=2  same_subnet=0                        [ OK ]
    TEST: test_arp:  accept_arp=2  same_subnet=1                        [ OK ]
    TEST: test_ndisc:  accept_untracked_na=0                            [ OK ]
    TEST: test_ndisc:  accept_untracked_na=1                            [ OK ]
    TEST: test_ndisc:  accept_untracked_na=2  same_subnet=0             [ OK ]
    TEST: test_ndisc:  accept_untracked_na=2  same_subnet=1             [ OK ]

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../net/arp_ndisc_untracked_subnets.sh         | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh b/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
index 327427ec10f5..a40c0e9bd023 100755
--- a/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
+++ b/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
@@ -5,16 +5,14 @@
 # garp to the router. Router accepts or ignores based on its arp_accept
 # or accept_untracked_na configuration.
 
+source lib.sh
+
 TESTS="arp ndisc"
 
-ROUTER_NS="ns-router"
-ROUTER_NS_V6="ns-router-v6"
 ROUTER_INTF="veth-router"
 ROUTER_ADDR="10.0.10.1"
 ROUTER_ADDR_V6="2001:db8:abcd:0012::1"
 
-HOST_NS="ns-host"
-HOST_NS_V6="ns-host-v6"
 HOST_INTF="veth-host"
 HOST_ADDR="10.0.10.2"
 HOST_ADDR_V6="2001:db8:abcd:0012::2"
@@ -23,13 +21,11 @@ SUBNET_WIDTH=24
 PREFIX_WIDTH_V6=64
 
 cleanup() {
-	ip netns del ${HOST_NS}
-	ip netns del ${ROUTER_NS}
+	cleanup_ns ${HOST_NS} ${ROUTER_NS}
 }
 
 cleanup_v6() {
-	ip netns del ${HOST_NS_V6}
-	ip netns del ${ROUTER_NS_V6}
+	cleanup_ns ${HOST_NS_V6} ${ROUTER_NS_V6}
 }
 
 setup() {
@@ -37,8 +33,7 @@ setup() {
 	local arp_accept=$1
 
 	# Set up two namespaces
-	ip netns add ${ROUTER_NS}
-	ip netns add ${HOST_NS}
+	setup_ns HOST_NS ROUTER_NS
 
 	# Set up interfaces veth0 and veth1, which are pairs in separate
 	# namespaces. veth0 is veth-router, veth1 is veth-host.
@@ -72,8 +67,7 @@ setup_v6() {
 	local accept_untracked_na=$1
 
 	# Set up two namespaces
-	ip netns add ${ROUTER_NS_V6}
-	ip netns add ${HOST_NS_V6}
+	setup_ns HOST_NS_V6 ROUTER_NS_V6
 
 	# Set up interfaces veth0 and veth1, which are pairs in separate
 	# namespaces. veth0 is veth-router, veth1 is veth-host.
-- 
2.41.0


