Return-Path: <linux-kselftest+bounces-1503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344B080C5EE
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 11:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A0A2B20EAF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 10:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A27422318;
	Mon, 11 Dec 2023 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTAN3/yW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE8B12B;
	Mon, 11 Dec 2023 02:09:32 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cebbf51742so2824237b3a.1;
        Mon, 11 Dec 2023 02:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702289371; x=1702894171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OjyhT1vuz7BD+Lm/KeTclRkgWUbqbofPOWgP2VPLHUI=;
        b=JTAN3/yW5ziZAm77F+c9stLTRziGO81chER5LZnG6qcXXNJLF2Coa/P0EplslNw22q
         hBnaWmK2Cp3BypJHmzysMdYFKM3pezORMCjd4LQ8gqLDUi5SC4TOf9VWl1KoF8KiVA2l
         CuSIJGNmyS8WasuXbk4qZnUzDQ1t1U4jsylR2x9ggNmfTNd1UHTej2egqhUgtTYEzUvv
         HK3YpyAa8+gR2rlPfrqxQfAJ+j9P0fMFkrD7Nw3ZsBfK8cD47nlF/+qZ098EtKkuFPHr
         s86kG/53pASAE1tgYgqHC57H0JaLwc6Rbsbp1P38XmVkrQjD/b+mVPbHPcfDdGIfkWtD
         uySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702289371; x=1702894171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjyhT1vuz7BD+Lm/KeTclRkgWUbqbofPOWgP2VPLHUI=;
        b=GE8KcH3GA8qC9sjGx2NE0Xl93XPDBJc8veeCjkeUqMVKK5ciCllIO7WHUo+I67+8KY
         cerof0KJDiiGEcxzgAC1AHIF1MLlVP/e+QbgqWdQu3zWqya+k4LM3mY+sgdXinirc6gl
         xWYWNDR0sVODS0TR8AB+MWA7XUwD09+UajypLRfEHDKvny5Kw9mV2QtZVNuAstVUDW/L
         8asjMoKg2rYgy75eKpJHM9Csi14epiJv52t2/d95AiKhEjc2U+BuTAXC1i7VtcvCtIRQ
         4yGF1NP5mVLeibc4zy/9FEBaRjiOW0FjmSqCuJ2CVlEJEcZB8n2qMmrotQKfj/iqhEeq
         78TQ==
X-Gm-Message-State: AOJu0Yxc20yOqdSp/0sxRwV9OUDlF9GMwoqbCOyZDx7wIPUzRP54AqhE
	LELA4E9038MjhO7mAUwCorR9+cXDgmK3YoNR
X-Google-Smtp-Source: AGHT+IEcUvSqQi6E3SojhtbicN/T4wG/6+0CcUp4FzYuZhN55xlceb8ZD8mdk93gIC2p7EdZEoQPbg==
X-Received: by 2002:a05:6a00:2d18:b0:6ce:2731:47b3 with SMTP id fa24-20020a056a002d1800b006ce273147b3mr4897021pfb.19.1702289371561;
        Mon, 11 Dec 2023 02:09:31 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o17-20020a656151000000b005c2420fb198sm5151733pgv.37.2023.12.11.02.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:09:31 -0800 (PST)
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
Subject: [PATCH net-next 00/13] Convert net selftests to run in unique namespace (Part 3)
Date: Mon, 11 Dec 2023 18:09:12 +0800
Message-ID: <20231211100925.3249265-1-liuhangbin@gmail.com>
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


