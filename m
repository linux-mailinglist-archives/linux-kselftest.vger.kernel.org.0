Return-Path: <linux-kselftest+bounces-865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FCF7FE7F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 05:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420722821E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 04:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0041B1429B;
	Thu, 30 Nov 2023 04:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gu/UFExe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7096DD66;
	Wed, 29 Nov 2023 20:01:29 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cdd28aa7f8so533970b3a.3;
        Wed, 29 Nov 2023 20:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701316888; x=1701921688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gn24feUcDktE4CLPYLJABui5PkAzSwve/ZqToQ7F038=;
        b=gu/UFExey5rISdT9BQu8A0Aqx4xKDLVEZnFcL6XPTcYaqfA5wu4o6DGr7kOD7XaAer
         JJF1vGP1GmmO0Y3q5znKUUKuzL0A1DP4SddyUUYQ9W/xV6qloDwPWZKEAhqFPcjLMv3R
         Mdw613bbCqbd4uy8fEPZi6jrI8Ct1PCzg0PsDx5sccFeYR8NV/4cWO3YOsOGBWsNXJez
         93c8N+V4l+t+5N97cV2Nbck8fWc3VwKIZ/18kdaCkHohvZz/dVOjPc2QkaskLKtMj5Gi
         z9whM7sNlz86tUUw9hywVoOygFD3ylTvY2IZ+YgZHRYjzC4ZHb7yMqW2nMLkLRbiGAC8
         Yilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701316888; x=1701921688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gn24feUcDktE4CLPYLJABui5PkAzSwve/ZqToQ7F038=;
        b=kNDYRIkT4eIbCmsGJULM9YL3F4Nc1rVbfqcTm+ZZYcTqXIa2kSxdTZRdYAijvyNStO
         8WcHnt5smxgqKAK0xckVZyGgblYvofEjzkWAEcQDKlsTcw2PfJxlWZCLpFtFKjl4u1vr
         3NcPQ/rfjT/IQzKnuIeI93W8ZQzNqs4X10IVc7kJ9SYNOpjkOi88Cl/ZZbbXixbo0BLB
         0vNLVEuwB8ZRdMgedhCcI6aEXykk3GVvLvkNXerYQZiAHxczN1cxNjZomwRF5Uf5byuK
         KkqCTD+EfYHpgk5Rp96UJsnv2GpzFW2UE4E3uHDlzW1tR5ojC/eaqIXRhg1Ej9x4arnT
         fMIA==
X-Gm-Message-State: AOJu0YyG3ZsmPhk4ISOR0eHvQHW4ma9nlzCHaLifRltBxFSH4MuJmekl
	m9DbMao3LtIyI+gU1Bs+G++dGK3Y6TCaTQ==
X-Google-Smtp-Source: AGHT+IHGZ4Hbwn2lBlgEmk1FPYdCJfbDh0ZFH0kxNEEbSP30eDyKAd2Xf0Tz4DBdEnIurl1fXvwq7Q==
X-Received: by 2002:a05:6a00:1c82:b0:6be:2901:2cd with SMTP id y2-20020a056a001c8200b006be290102cdmr20163956pfw.10.1701316888484;
        Wed, 29 Nov 2023 20:01:28 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p16-20020aa78610000000b006cc02a6d18asm187975pfn.61.2023.11.29.20.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 20:01:28 -0800 (PST)
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
Subject: [PATCHv2 net-next 03/14] selftests/net: specify the interface when do arping
Date: Thu, 30 Nov 2023 12:00:54 +0800
Message-ID: <20231130040105.1265779-4-liuhangbin@gmail.com>
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

When do arping, the interface need to be specified. Or we will
get error: Interface "lo" is not ARPable. And the test failed.
]# ./arp_ndisc_untracked_subnets.sh
    TEST: test_arp:  accept_arp=0                                       [ OK ]
    TEST: test_arp:  accept_arp=1                                       [FAIL]
    TEST: test_arp:  accept_arp=2  same_subnet=0                        [ OK ]
    TEST: test_arp:  accept_arp=2  same_subnet=1                        [FAIL]

After fix:
]# ./arp_ndisc_untracked_subnets.sh
    TEST: test_arp:  accept_arp=0                                       [ OK ]
    TEST: test_arp:  accept_arp=1                                       [ OK ]
    TEST: test_arp:  accept_arp=2  same_subnet=0                        [ OK ]
    TEST: test_arp:  accept_arp=2  same_subnet=1                        [ OK ]

Fixes: 0ea7b0a454ca ("selftests: net: arp_ndisc_untracked_subnets: test for arp_accept and accept_untracked_na")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh b/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
index c899b446acb6..327427ec10f5 100755
--- a/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
+++ b/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
@@ -150,7 +150,7 @@ arp_test_gratuitous() {
 	fi
 	# Supply arp_accept option to set up which sets it in sysctl
 	setup ${arp_accept}
-	ip netns exec ${HOST_NS} arping -A -U ${HOST_ADDR} -c1 2>&1 >/dev/null
+	ip netns exec ${HOST_NS} arping -A -I ${HOST_INTF} -U ${HOST_ADDR} -c1 2>&1 >/dev/null
 
 	if verify_arp $1 $2; then
 		printf "    TEST: %-60s  [ OK ]\n" "${test_msg[*]}"
-- 
2.41.0


