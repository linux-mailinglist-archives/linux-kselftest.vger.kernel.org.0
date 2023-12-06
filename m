Return-Path: <linux-kselftest+bounces-1232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BD18067EE
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 08:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 385E6B21218
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 07:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D75B12E75;
	Wed,  6 Dec 2023 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glCDAw0Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECAC1A2;
	Tue,  5 Dec 2023 23:08:09 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-58d08497aa1so4609290eaf.0;
        Tue, 05 Dec 2023 23:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701846488; x=1702451288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1FcdaoNhIvj8wf9am7v8CAUySSq+YiuzFlS25TzdsQ4=;
        b=glCDAw0Y9ixRMXxLGvo41YRCJ1iUHDudOu7lpatfQpL6hQeQz7x/Vlu7WtEEkYsPpU
         xu2YK/3uz9TR+nCQtBybV4sNm37AhAnhC2AXpGTzJ934wy/mMxLuKveWKDq724Q0kdHw
         73ws27sTHu90eaPvayqSmINsl/OwEWx3ZGxsMDsuNDUkFrfiALvZSNWO028nXd5oyCnI
         z8I2CzYthIXKoKb69gvCt1PPvESiHUbLgUOtk35PstFORumCWNnG6WF3ydD1YCxFRjc9
         gNFTd9kelPGqiJgJjZsYvm5mjGzbmBqHWODapscXXavyXBl1PaeFNtqYPb03SiadZ/6F
         xIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701846488; x=1702451288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1FcdaoNhIvj8wf9am7v8CAUySSq+YiuzFlS25TzdsQ4=;
        b=PAtU2glw2EeuyVMKnEBw0v9xRDrEXhglJb2YzDxUsx0h6hwnGV6O3lMXq1QlFDa4qG
         hOsXw7L5I8d5TPR2Q3ASQDcUHO8eWkm5SnpzjL0cl5g4a0aukMSvN3nL7ISEYZ44mfcA
         PdJ+ef7R7AZ0qsNI8PrHxPYwQfoGEKe/AVwBbqJLiViqzEIZem4OMftxpUso7vrq+2iU
         aGAoWUZfvkQmlWD+Q6xtEkCyUWJFnRMLt7whlBVvcuuJHdgF3/wOJwp8Q3jnamaORwDX
         oaKs+hXQAJSiXEgjtdWnw8z0EW6znsEbGfDg95d3HP4JxWBMre3yjJWcppu+Sowca4Py
         VbKQ==
X-Gm-Message-State: AOJu0YzmBgl9mx5vSZ3zj3N6CRVqewjcnJI9Y0cz9qJs4eOH+t7Oqkja
	EMpz7isIOGILy3EFGDlx0cEjSER706R5Xo59
X-Google-Smtp-Source: AGHT+IEhk7A5OI4/zCuTSmBveErtUIsaLislI17EnuuxqPH0JfprD/nsTRxUbn4Wa0fPgcECF3fz3Q==
X-Received: by 2002:a05:6358:6204:b0:170:17eb:9c40 with SMTP id a4-20020a056358620400b0017017eb9c40mr656660rwh.33.1701846488172;
        Tue, 05 Dec 2023 23:08:08 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n7-20020a63f807000000b005b529d633b7sm10184212pgh.14.2023.12.05.23.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:08:07 -0800 (PST)
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
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Vladimir Nikishkin <vladimir@nikishkin.pw>,
	Roopa Prabhu <roopa@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 0/9] Convert net selftests to run in unique namespace (Part 2)
Date: Wed,  6 Dec 2023 15:07:52 +0800
Message-ID: <20231206070801.1691247-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is the 2nd part of converting net selftests to run in unique namespace.
This part converts all bridge, vxlan, vrf tests.

Here is the part 1 link:
https://lore.kernel.org/netdev/20231202020110.362433-1-liuhangbin@gmail.com

Hangbin Liu (9):
  selftests/net: convert test_bridge_backup_port.sh to run it in unique
    namespace
  selftests/net: convert test_bridge_neigh_suppress.sh to run it in
    unique namespace
  selftests/net: convert test_vxlan_mdb.sh to run it in unique namespace
  selftests/net: convert test_vxlan_nolocalbypass.sh to run it in unique
    namespace
  selftests/net: convert test_vxlan_under_vrf.sh to run it in unique
    namespace
  selftests/net: convert test_vxlan_vnifiltering.sh to run it in unique
    namespace
  selftests/net: convert vrf_route_leaking.sh to run it in unique
    namespace
  selftests/net: convert vrf_strict_mode_test.sh to run it in unique
    namespace
  selftests/net: convert vrf-xfrm-tests.sh to run it in unique namespace

 .../selftests/net/test_bridge_backup_port.sh  | 371 +++++++++---------
 .../net/test_bridge_neigh_suppress.sh         | 331 ++++++++--------
 tools/testing/selftests/net/test_vxlan_mdb.sh | 202 +++++-----
 .../selftests/net/test_vxlan_nolocalbypass.sh |  48 ++-
 .../selftests/net/test_vxlan_under_vrf.sh     |  70 ++--
 .../selftests/net/test_vxlan_vnifiltering.sh  | 154 +++++---
 tools/testing/selftests/net/vrf-xfrm-tests.sh |  77 ++--
 .../selftests/net/vrf_route_leaking.sh        | 201 +++++-----
 .../selftests/net/vrf_strict_mode_test.sh     |  47 ++-
 9 files changed, 751 insertions(+), 750 deletions(-)

-- 
2.43.0


