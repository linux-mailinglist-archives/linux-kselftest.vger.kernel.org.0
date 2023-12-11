Return-Path: <linux-kselftest+bounces-1509-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA6E80C600
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 11:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14BCC1F21511
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 10:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4366B2511E;
	Mon, 11 Dec 2023 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdPW7uNM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B9C106;
	Mon, 11 Dec 2023 02:09:56 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-35d54370b4bso16311285ab.1;
        Mon, 11 Dec 2023 02:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702289395; x=1702894195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgPgAyCi4hmyGne0v6bKY88o9U7d9WJXnmNU6rBiFYY=;
        b=SdPW7uNMkDBR1c/oXzWY4NfTko03FkVu6y0xe/w6U8QWrDbHGw98YO9BK5bFaQ3Hu/
         AA6TuLzRO1X3qd46AqEwh11YP/BGuux4FT1Is3ScCRDsNHwRQXlvyG14q/MJpHit9V7R
         +VttR7FNBV5yjW1WT/C+Tr92xj48TCo1y0vHAYt6Gtx2wgk53gX4LPx/W2BGnpNA2hXn
         9XhJMMl/dQnMEgVO7favvdoTCv60fExa703lbAl+5CsjqF/1vAw1MO7O7eyRuyeMwcRJ
         hfff3Jfqxs/koi8wNCD8tI7MGc9tTR+qR//TavOSSZBPqt+K2k7xrVvZOK+lryIdRe+i
         W0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289395; x=1702894195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgPgAyCi4hmyGne0v6bKY88o9U7d9WJXnmNU6rBiFYY=;
        b=F/G9Vivyf/uePfjoONIEDqa4eNWSRlzF/Uc5PVFHn4m5N2cR7TK4rKH2DxE2psKmoT
         ImDpI+Xr+263XyYnUEoeFJzUrxTjMr3KiEzK+YAUEnN6KziQNFpZP6Yn65oCSzC0gZCm
         oGVTKt6Qx5kmIq5vPDpxoGfR9vjLSDuGM+MVWxVnuMtzanFo/mH5+bLPsmo57fbaJ8PL
         HyPB0o9QPnIwufTC1eHS1bV5QzB92nLcACm6WCXHkQE8iLMMShAzgMEoex2GiQxha8px
         BXVlmL9Z5lb4/NpgqNsPGPptlKHfF7lJNSF9+aJ5d5i+uGzaaASQc4AUf4c8eM5mRi+W
         Kzcw==
X-Gm-Message-State: AOJu0Yx9Yk7uiE65zNc387CPg19FIHhFFB/Qni04jKGwu9NU18/7IVeX
	dro6zgMCclEp1yp2laMD0cadFP8/IsMSb5rK
X-Google-Smtp-Source: AGHT+IEHGLUOcheJZUYsXe6rpDKfH5uK/XR8LUtm+Rp0QdijsC7egOo5MiTwqpcCLClrs2fKMJ2CgQ==
X-Received: by 2002:a05:6e02:1cab:b0:35d:59a2:bb5 with SMTP id x11-20020a056e021cab00b0035d59a20bb5mr3473525ill.75.1702289395685;
        Mon, 11 Dec 2023 02:09:55 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o17-20020a656151000000b005c2420fb198sm5151733pgv.37.2023.12.11.02.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:09:55 -0800 (PST)
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
Subject: [PATCH net-next 06/13] selftests/net: fix grep checking for fib_nexthop_multiprefix
Date: Mon, 11 Dec 2023 18:09:18 +0800
Message-ID: <20231211100925.3249265-7-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211100925.3249265-1-liuhangbin@gmail.com>
References: <20231211100925.3249265-1-liuhangbin@gmail.com>
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


