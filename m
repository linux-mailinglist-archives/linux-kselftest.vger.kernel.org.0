Return-Path: <linux-kselftest+bounces-1800-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA3D8109E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 07:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577161C209CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 06:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508AEF9FA;
	Wed, 13 Dec 2023 06:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxdTMPRM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0300DB;
	Tue, 12 Dec 2023 22:09:33 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b88f2a37deso5165861b6e.0;
        Tue, 12 Dec 2023 22:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702447772; x=1703052572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9WNKLwTxW+NRKX+s4k9F6FcmoGKGyZCEBdcLv9+DV0=;
        b=IxdTMPRMc1rsqxoJ688cH3nYjgDfrR+GDXp/0395vixXskvHPKbdZYJ6xKxd4U3ycE
         p/k8sN8zdmTOctzdUMbstm9XwGG1v7E/+vNuNSuEXrEycfaRqSejuwESPp3H4QVhlSgb
         hSPcnw2byjyUQw/cZxh6Q/6eWQwzQw6mlK8eT/TmG1I63wG+xtFZpCmpMiXWjUoOjHLC
         hWGWdYLtk1HLvb09ZA7J2fxb89sG0Uo9Q5ku5wevyxvXnOACvHcoxDFep7V5rgDKzwDj
         uZbFANiNyyX67prnXCk83snFnTYRNPep0DGkF+j8DewG5TYJkYdhX2MA7Mqz4l0EU5/e
         repQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702447772; x=1703052572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9WNKLwTxW+NRKX+s4k9F6FcmoGKGyZCEBdcLv9+DV0=;
        b=F0haRkrmskktulvlZfU5LaIt0BT54rM1uITJQeheOba8dm3RJTafhs7rg0rDksyfou
         CsbUprJmNl+d1BkSd8s/3l9vs+4m9/6lExy1KfOnB7BNkU5UQFUpuL860Hd8/2jfQD8t
         ajjho1k1U8XRJIU2cG8u6s9qJGUVNwfi/K15qeXUv8YnDwNT18CIJPi7kmCdV+cfZ4YE
         lAN8Q8oTQgepbfR0aJtFzU61hcIgBdWQ82PzCi2aI+XYaJejd3iGT7FpKtpNuTnRXn9i
         +J3XGsb4Mdlfyn3/PLOIHb6FvoqcC895v+hEdaj7B0hdTvzAxrw5xIAWz8SpTeleYfHL
         FRRA==
X-Gm-Message-State: AOJu0YyFYQY+i72uUyQ51HzeUdqDkGKhQeiaHd830v7iiRagZEBBqWXq
	DApzWKz0RB2ZCj1oaiHihw7oMAwVaNlTp0YepTU=
X-Google-Smtp-Source: AGHT+IHM/w1EcSrdgsH8qqP9PKu0J1HusBgB6M0I+AwP6lAnp2e/11P9uwFSOrUvqb0Jg1VR5+tYUQ==
X-Received: by 2002:a05:6808:1401:b0:3b8:b063:5053 with SMTP id w1-20020a056808140100b003b8b0635053mr9912878oiv.84.1702447772201;
        Tue, 12 Dec 2023 22:09:32 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kq9-20020a056a004b0900b006cef5e5a968sm6890084pfb.201.2023.12.12.22.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:09:31 -0800 (PST)
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
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Amit Cohen <amcohen@nvidia.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 06/13] selftests/net: fix grep checking for fib_nexthop_multiprefix
Date: Wed, 13 Dec 2023 14:08:49 +0800
Message-ID: <20231213060856.4030084-7-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213060856.4030084-1-liuhangbin@gmail.com>
References: <20231213060856.4030084-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running fib_nexthop_multiprefix test I saw all IPv6 test failed.
e.g.

 ]# ./fib_nexthop_multiprefix.sh
 TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
 TEST: IPv6: host 0 to host 1, mtu 1300                              [FAIL]

 With -v it shows

 COMMAND: ip netns exec h0 /usr/sbin/ping6 -s 1350 -c5 -w5 2001:db8:101::1
 PING 2001:db8:101::1(2001:db8:101::1) 1350 data bytes
 From 2001:db8:100::64 icmp_seq=1 Packet too big: mtu=1300

 --- 2001:db8:101::1 ping statistics ---
 1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms

 Route get
 2001:db8:101::1 via 2001:db8:100::64 dev eth0 src 2001:db8:100::1 metric 1024 expires 599sec mtu 1300 pref medium
 Searching for:
     2001:db8:101::1 from :: via 2001:db8:100::64 dev eth0 src 2001:db8:100::1 .* mtu 1300

The reason is when CONFIG_IPV6_SUBTREES is not enabled, rt6_fill_node() will
not put RTA_SRC info. After fix:

]# ./fib_nexthop_multiprefix.sh
TEST: IPv4: host 0 to host 1, mtu 1300                              [ OK ]
TEST: IPv6: host 0 to host 1, mtu 1300                              [ OK ]

Fixes: 735ab2f65dce ("selftests: Add test with multiple prefixes using single nexthop")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/fib_nexthop_multiprefix.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/fib_nexthop_multiprefix.sh b/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
index 51df5e305855..b52d59547fc5 100755
--- a/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
+++ b/tools/testing/selftests/net/fib_nexthop_multiprefix.sh
@@ -209,12 +209,12 @@ validate_v6_exception()
 		echo "Route get"
 		ip -netns h0 -6 ro get ${dst}
 		echo "Searching for:"
-		echo "    ${dst} from :: via ${r1} dev eth0 src ${h0} .* mtu ${mtu}"
+		echo "    ${dst}.* via ${r1} dev eth0 src ${h0} .* mtu ${mtu}"
 		echo
 	fi
 
 	ip -netns h0 -6 ro get ${dst} | \
-	grep -q "${dst} from :: via ${r1} dev eth0 src ${h0} .* mtu ${mtu}"
+	grep -q "${dst}.* via ${r1} dev eth0 src ${h0} .* mtu ${mtu}"
 	rc=$?
 
 	log_test $rc 0 "IPv6: host 0 to host ${i}, mtu ${mtu}"
-- 
2.43.0


