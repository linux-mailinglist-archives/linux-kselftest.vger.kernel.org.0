Return-Path: <linux-kselftest+bounces-1794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1078109D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 07:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1924EB20BDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 06:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7F4D2E7;
	Wed, 13 Dec 2023 06:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEossKGp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BF298;
	Tue, 12 Dec 2023 22:09:07 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so4776847b3a.0;
        Tue, 12 Dec 2023 22:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702447746; x=1703052546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DnIqejU5E/i8DJMJPMz/pdZV//cE3Bqqs3/YKP8S8t4=;
        b=MEossKGpUNT+sEJ2ns8QG2iViKUwjkFZP2m9jgjNfRrExJWs9CH+1ukH2zCd1EUzhM
         9Fr8L3IlR+wrXtIvil3mdbowcg/SQdcvTthzhSzntFyJLk5WPedHnDbwZAAHYeccO2Z2
         bq1uV3CwYw8ryvBv4UhuDicK7zU2CuaBlM7JKMhb2p/NTRoAszaHKIwiv1bQS9nM/bw4
         /NwhlYnr2hfVCnekDJ8rv3vxJQw1mhBJqEZm/LMZy0Ct6sSQ0Nzugn73UCYtjhHLppXQ
         lJbEcT4nmu2ZiEW00Qz3WQw9e2VDf8wKh9aw9x3MAwZ3bsXC9Cb/EHzkQfpZKr9v8VZJ
         h1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702447746; x=1703052546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnIqejU5E/i8DJMJPMz/pdZV//cE3Bqqs3/YKP8S8t4=;
        b=RomTqRn88cZyxbxKOb7qzb3dSvBI3qLq/WjPg63whqA6DRlxRENRSQM7TAJ1nVAptM
         WhNHCxKHI6B3RVLHYgChMBSmtslJxlS2Cz54BhcoVf9Fas9LNlsgOJBGxzC2yJGVcr8g
         shUGTvPrT0ano76R49yiwsAYQHB/AAeXNvuZIJOAosGB7viKQjrK7RqjS7OolWYLd/oI
         q/q05d7i7+mdBdGNX70oqeq4ErUc3Lf3PLynqrVSVxDO9+HTUcayCw2nh9Z5/yewJJ8y
         QCznhD4YCa5DKBpCtniWc2NsVwa8Oi9RFcwjJv81r83qwi+fDaU0OmN0gbq7U+m6Kf6h
         c6xA==
X-Gm-Message-State: AOJu0YyuWcO1Pr2d13uU2UYeHX1gAksE5StjphVD5iTWnoVAnEWJEtqV
	eccM1BHTAi6wb8B3hlZvq08uNXSgrroKHJAvyTc=
X-Google-Smtp-Source: AGHT+IFxvHeer4GRIMWHAbqqKWcygvgh+eHtPM8jsVQCaF54Q+uFDzfr+MK53nEhbNwovY8wUcKRlQ==
X-Received: by 2002:a05:6a00:174a:b0:6ce:939e:bed6 with SMTP id j10-20020a056a00174a00b006ce939ebed6mr9244668pfc.34.1702447745871;
        Tue, 12 Dec 2023 22:09:05 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kq9-20020a056a004b0900b006cef5e5a968sm6890084pfb.201.2023.12.12.22.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:09:05 -0800 (PST)
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
Subject: [PATCHv2 net-next 00/13] Convert net selftests to run in unique namespace (Part 3)
Date: Wed, 13 Dec 2023 14:08:43 +0800
Message-ID: <20231213060856.4030084-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the 3rd part of converting net selftests to run in unique namespace.
This part converts all srv6 and fib tests.

Note that patch 06 is a fix for testing fib_nexthop_multiprefix.

Here is the part 1 link:
https://lore.kernel.org/netdev/20231202020110.362433-1-liuhangbin@gmail.com
And part 2 link:
https://lore.kernel.org/netdev/20231206070801.1691247-1-liuhangbin@gmail.com

v1 -> v2:
- indent the test result in case --- cut off the patch (Jakub Kicinski)

Hangbin Liu (13):
  selftests/net: add variable NS_LIST for lib.sh
  selftests/net: convert srv6_end_dt46_l3vpn_test.sh to run it in unique
    namespace
  selftests/net: convert srv6_end_dt4_l3vpn_test.sh to run it in unique
    namespace
  selftests/net: convert srv6_end_dt6_l3vpn_test.sh to run it in unique
    namespace
  selftests/net: convert fcnal-test.sh to run it in unique namespace
  selftests/net: fix grep checking for fib_nexthop_multiprefix
  selftests/net: convert fib_nexthop_multiprefix to run it in unique
    namespace
  selftests/net: convert fib_nexthop_nongw.sh to run it in unique
    namespace
  selftests/net: convert fib_nexthops.sh to run it in unique namespace
  selftests/net: convert fib-onlink-tests.sh to run it in unique
    namespace
  selftests/net: convert fib_rule_tests.sh to run it in unique namespace
  selftests/net: convert fib_tests.sh to run it in unique namespace
  selftests/net: convert fdb_flush.sh to run it in unique namespace

 tools/testing/selftests/net/fcnal-test.sh     |  30 ++-
 tools/testing/selftests/net/fdb_flush.sh      |  11 +-
 .../testing/selftests/net/fib-onlink-tests.sh |   9 +-
 .../selftests/net/fib_nexthop_multiprefix.sh  |  98 +++++-----
 .../selftests/net/fib_nexthop_nongw.sh        |  34 ++--
 tools/testing/selftests/net/fib_nexthops.sh   | 142 +++++++-------
 tools/testing/selftests/net/fib_rule_tests.sh |  36 ++--
 tools/testing/selftests/net/fib_tests.sh      | 184 +++++++++---------
 tools/testing/selftests/net/lib.sh            |   8 +
 tools/testing/selftests/net/settings          |   2 +-
 .../selftests/net/srv6_end_dt46_l3vpn_test.sh |  51 +++--
 .../selftests/net/srv6_end_dt4_l3vpn_test.sh  |  48 ++---
 .../selftests/net/srv6_end_dt6_l3vpn_test.sh  |  46 ++---
 13 files changed, 332 insertions(+), 367 deletions(-)

-- 
2.43.0


