Return-Path: <linux-kselftest+bounces-1513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 654E880C60C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 11:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E9D1F214C2
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 10:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B4E25569;
	Mon, 11 Dec 2023 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToO2fI9U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C2BFD;
	Mon, 11 Dec 2023 02:10:12 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7b71b10391aso111445739f.3;
        Mon, 11 Dec 2023 02:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702289411; x=1702894211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQi+kDlznq0CFqtjRvuPpTyk/PEd2xJSKjNfnpVe/PA=;
        b=ToO2fI9UdArxizR3YRLGddXZkB1jpBnWAbR/32s1sVJ92gJmtGc1zkPj+iDNCa3IkW
         TSDJ1GrNwrS2SA77rG6E0DiU6UhEyOg/1qKJ2nRwO3gOXillIORkEwMycWd12fWsQ8ky
         NvNKJr0e9XFCAKQo6YIqSmh9J/Wp4jH6iR/FpAfBL6FMtNxqEWJM24C+Q8IjRq00afnN
         lkj0e57zOR/6I2vUZKeyV9Rzr9xtaA4uXvgUHSiT59Bvh9zQdMD/Q4KL21HgptrJdZJ8
         Ibg7VaP8am+AOuWxp9tirj4YhUDvIBQ/PEwhn9Cl2w4D+rJp8//Az/D/qLc9Qk+zwH4k
         Jb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289411; x=1702894211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQi+kDlznq0CFqtjRvuPpTyk/PEd2xJSKjNfnpVe/PA=;
        b=lIXC2YE6N6rfvkwf3uxoudPFcKGI7keMAlK5psiagKy6LAHkCj2i+qBsOoe0Q9llcR
         wueA5N2xUYbKtF1BrCwzYIuFVFj+8W7ytXRxovX0dPQFH9PMf4uCOwYhFx+KMyXUsaJp
         b4NDPVZHbQozhOyRtfr5QC/FG4OcNp10oTK/LcEq1IyOprASIpWnolNFqetuCglXso3/
         AbJDfc8G/AA6EcGwQfrozJbFQ+MkyliQ2F2tNC/moZ0a4qUk9rWod4B1mXv83I0hYj3q
         RMeF+NjaI88/E1w07i1HZVXQULU6SF4cxK+v5zM9hu8NEyoCUDu6EJIb3SMeDE+KpEJR
         ZdjA==
X-Gm-Message-State: AOJu0Yz2jsbeK9UmpU5jGUfqFKAPE7VAg5NyHYJaFRSsxzwlRfRd40wU
	D5fIpAlCLcNgMopVWi34aykrrnypGxWZB/zw
X-Google-Smtp-Source: AGHT+IEpp31aJ5fCfA4XZA7ukDL/jQ3GR6UAwqffxnWK9uItH+VtHrGZQD4bcc2bV36cC6nt8Xny6Q==
X-Received: by 2002:a05:6e02:168b:b0:35d:6740:763a with SMTP id f11-20020a056e02168b00b0035d6740763amr3210007ila.68.1702289411552;
        Mon, 11 Dec 2023 02:10:11 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o17-20020a656151000000b005c2420fb198sm5151733pgv.37.2023.12.11.02.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:10:11 -0800 (PST)
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
Subject: [PATCH net-next 10/13] selftests/net: convert fib-onlink-tests.sh to run it in unique namespace
Date: Mon, 11 Dec 2023 18:09:22 +0800
Message-ID: <20231211100925.3249265-11-liuhangbin@gmail.com>
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

Remove PEER_CMD, which is not used in this test

Here is the test result after conversion.

 ]# ./fib-onlink-tests.sh
 Error: ipv4: FIB table does not exist.
 Flush terminated
 Error: ipv6: FIB table does not exist.
 Flush terminated

 ########################################
 Configuring interfaces

   ...

     TEST: Gateway resolves to wrong nexthop device - VRF      [ OK ]

 Tests passed:  38
 Tests failed:   0

Acked-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/fib-onlink-tests.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/fib-onlink-tests.sh b/tools/testing/selftests/net/fib-onlink-tests.sh
index c287b90b8af8..ec2d6ceb1f08 100755
--- a/tools/testing/selftests/net/fib-onlink-tests.sh
+++ b/tools/testing/selftests/net/fib-onlink-tests.sh
@@ -3,6 +3,7 @@
 
 # IPv4 and IPv6 onlink tests
 
+source lib.sh
 PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
 VERBOSE=0
 
@@ -74,9 +75,6 @@ TEST_NET4IN6[2]=10.2.1.254
 # mcast address
 MCAST6=ff02::1
 
-
-PEER_NS=bart
-PEER_CMD="ip netns exec ${PEER_NS}"
 VRF=lisa
 VRF_TABLE=1101
 PBR_TABLE=101
@@ -176,8 +174,7 @@ setup()
 	set -e
 
 	# create namespace
-	ip netns add ${PEER_NS}
-	ip -netns ${PEER_NS} li set lo up
+	setup_ns PEER_NS
 
 	# add vrf table
 	ip li add ${VRF} type vrf table ${VRF_TABLE}
@@ -219,7 +216,7 @@ setup()
 cleanup()
 {
 	# make sure we start from a clean slate
-	ip netns del ${PEER_NS} 2>/dev/null
+	cleanup_ns ${PEER_NS} 2>/dev/null
 	for n in 1 3 5 7; do
 		ip link del ${NETIFS[p${n}]} 2>/dev/null
 	done
-- 
2.43.0


