Return-Path: <linux-kselftest+bounces-1006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3635E8019CB
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 03:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04D61F210A0
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 02:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE813D82;
	Sat,  2 Dec 2023 02:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV1EO+t9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BC4F9;
	Fri,  1 Dec 2023 18:01:34 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-35942cb9ef4so10690225ab.3;
        Fri, 01 Dec 2023 18:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701482493; x=1702087293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onvRpZD4ywvlpKAlzg1MS6yFyzjU8lVdSg7RK1XJzV0=;
        b=WV1EO+t95zos/h6pV5eBs+nn3s97LkToMIYKpsaGJhNksB9/pxh+bY/W/x7Q+7OcGt
         v9/9nonyb/w3C6cCrOp3JMzQ3cbXZQ2D7/ynFCVo+zan6L3i2hThgzp+DVxxIEsNhvER
         foC2hf4SsnYFHP4XvUAkVqjgr+5QJAA/m3r94kx3Lh6AJPyQEmDahK04xU7o1dIEY4G4
         4dnaW5oLvU7b83igOor5UaT/pAmuHCnowulTBsuTBkv7pBRC8aYEodQ/p9FgkEARGYD3
         CizRZOdiWKay4rLfNd1IY0DC7qiBBnPMR+a5zSwAHVmbxmnhEUFaAjcgo82qiIgNy+G9
         PCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701482493; x=1702087293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onvRpZD4ywvlpKAlzg1MS6yFyzjU8lVdSg7RK1XJzV0=;
        b=IIOio5hjtG1AeFanD71BcO1rmE55x9MoaDdQhnWzjZbMjYGXoCCVydIZxPXujMtvYn
         Dqnz2fg4xtsboBPwNvh9HvBxATDwxvn8c1LAAGgy6kklkBGqZi1e+Xvd33RFgu4Zjk6a
         bLgrjq8nDkJU6aD2y4nB7mnFp+Dz6fhVjv6gFfTcd95jZnEAoo+cNpdTyR/lAurfcZ24
         3Tu3kxC8s5jAFxuP34o/jdY7pxUkkgj/EDgpxnxF7P6hsshChBpQwX6V2mG8BzZfEEKi
         QsG45olO8rxTTScxE98mKr0W0cvFZDQ1Da9KmrUc/2yHWJv1d0dpM8Qox6oqpYEyXiF4
         jRmw==
X-Gm-Message-State: AOJu0YwqyWKmiTqJ9/3ppQ4WiPZAb86dzjMl0F+YEOSy1n0TC9qDoB26
	tj+MqUmoluyv8s5Doisk/MkTq/5tqPHBFraJ
X-Google-Smtp-Source: AGHT+IE8Y6YsBDHHzVCY5OlCV9bLhbY+nzDPam+ZH7Mj/bbDcFJ8AnIgWu+NvGu6CW15cPHV8RIsbw==
X-Received: by 2002:a05:6e02:12c6:b0:35d:59a2:2a8 with SMTP id i6-20020a056e0212c600b0035d59a202a8mr698734ilm.72.1701482493597;
        Fri, 01 Dec 2023 18:01:33 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b001b3bf8001a9sm3993034plf.48.2023.12.01.18.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 18:01:32 -0800 (PST)
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
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>,
	James Chapman <jchapman@katalix.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 03/14] selftests/net: specify the interface when do arping
Date: Sat,  2 Dec 2023 10:00:59 +0800
Message-ID: <20231202020110.362433-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202020110.362433-1-liuhangbin@gmail.com>
References: <20231202020110.362433-1-liuhangbin@gmail.com>
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
2.43.0


