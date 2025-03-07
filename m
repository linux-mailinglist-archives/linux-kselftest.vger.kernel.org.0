Return-Path: <linux-kselftest+bounces-28452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28395A55E2D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 04:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD921892757
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 03:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6061E18DB1F;
	Fri,  7 Mar 2025 03:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ph8XvFOe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AE318CBFB;
	Fri,  7 Mar 2025 03:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317558; cv=none; b=BsmbO/saWfIxXJxwQGbl6Qs6xUoRkLoGqwvpI9nB5vzqsKglh5Z3Dl92MnlIfUvJS+KqhOOCzR1Nj4fOAmGE/GYgmCPGjGJAB7P7rga7jPs5KpdDm8Gnrs8PIoGFw2wfTV4h931kQf9jA9i5f1LWLxS0K5vv44wSt2zsJHtBNbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317558; c=relaxed/simple;
	bh=/6oi7wSIJIu9yoaKPqaE7fOmrgWjLaHaF4QZAeiYf64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XOJHlbeGPrzzwMM6HGIvfb4+RKB62XZNTNM3pOt3fyGpZtl8ZOc2kr/4hvDUC1d/b5JYpC8DmYqAx8rDEvY7ILMdL+8jHu51v+REI4cNOhqP2VHJ6RxY7qhlVq3gC+oVaRUcu1J6FsBgTf5DrWov+yPPmxHhe7XCokw6qtlUv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ph8XvFOe; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2234e4b079cso24615105ad.1;
        Thu, 06 Mar 2025 19:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741317556; x=1741922356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g0DK/lZwUbq7evCxhu6vzBF9behgLjjOobAObHJFVgo=;
        b=Ph8XvFOeelnEDwOfNCzXnLjBhf8+sGxjfkRDw0lp4G1FM9eSrtTNvVlQBX2FwaBJO1
         xhNXduF1kSsmA+2za9t3yhunucRVD5brx/jrSjSNHOWxA72WRvfT9/1nN+37yB5QmY5Y
         KEEVIn6iCf6scceot2ysrqz6UVzGNvUmTL53VHUCcwBKiujcrTJQLmJoFdnMDctQXVef
         n0EDqFGc2e7rgfENXEOXvaIuD0QY/VehQJGmiEbwDBgeGnlvAWmmlGgk7sw4c6PtESVo
         FezNH1qg2u+zIRAKuNZqg62UY/fxiOhDipGtMVMXWe5aAg77eoguiHxKFE9BZYgz9AmG
         ee+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741317556; x=1741922356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0DK/lZwUbq7evCxhu6vzBF9behgLjjOobAObHJFVgo=;
        b=b2pqT7k1W2VJrHFs5k/1vvNzsd/rUQYO5gnpQbAkA1xgkjUgS9AdE3VcH6zCbaEoQi
         oVHO+zbmdui4bJVyqgkKFvIBFz0sRP9gkF/t7riyByCvPKlnAG/eAQx8yd++4UpJXTuJ
         /33X5NecHBnOGYo4sKBVsF7diTcjN9poDGLJpcuM/6XSmMCf62PQ9dq6v2B8bmNQLxyo
         Fma7L+R93SxOqp89RtLBMdNhGkjQX5KAzgJ1w632naSndZlERgmVbXRUmBO/MDsFfxe/
         fRcZ1G84LSewKgLx9IWeWbBPkaycnJ49uVoUeudkoUg3BKIl6nV9XYJyMYtyMCRUJsJn
         JmLA==
X-Forwarded-Encrypted: i=1; AJvYcCXLu6XBPXeHdqB2oayQuCSIarR/HKXY84x7HZQNOCxpVHLC7qgt1MA8v0seC+BiPQNsX9lUMzNS8aYTp9lmR726@vger.kernel.org, AJvYcCXrRQxhIjYe+6YHg1GblZa/d3rrYeOt/vvbdznK9pmkqgHCaBMC2wRusD0zl2H0W4jdesHnL9Gknz3EksU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50zkCgoftcDcbT9xJwYR8yDjdEVRydxhvMhv8N/XXSGBaXzB8
	ktARM4s+jgWXfoD/cUIuuZ/7bAlmxI9EYPLzk2cUMJby3brctaa9a2ksQLbZkI8Q4A==
X-Gm-Gg: ASbGncvM6zFpOf5fuO+Kw82D4j3a5wIUd/7n0rCqnS4t2HTBpZI9aH3U0KoD9D1sG5F
	kgso5FgzCZch2s4ej6ZtiLWff6iTYyg3MgDqSiQKjLc0gXo7aDNomXTSaEf5Plc1mC51d6eM3UR
	QX+1vayXFQwnk4Bj2/EIU+odJLtIP3QTJdkvHXyq2n+ZDNmKhUYzljm6CNbypR2tjZ3B/3P6MEL
	1NbOt7XQdUWG9K4xyg3veY840jjox4FVOs9uaJxTQP9tza+ikc7/JgBDah9PeLl1Yw/mnI84oe1
	6vk8Dm5gXo/GXJ7oHYlBnNk9LTy1B2Qz69dnW7WJlrh8IgL0Dx2AQWcVTdZ0E9xC
X-Google-Smtp-Source: AGHT+IH+ZDw0vly2IOyYkYtErzzTuxnj+SAqAwUEg7zi6SXNoZLp37GC+HhxjMBwtVZeqnKva9kTlA==
X-Received: by 2002:a17:902:f686:b0:224:1ec0:8a1d with SMTP id d9443c01a7336-22428ab535bmr25997165ad.30.1741317555631;
        Thu, 06 Mar 2025 19:19:15 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109dd5e2sm20013165ad.15.2025.03.06.19.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 19:19:15 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Jarod Wilson <jarod@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv5 net 0/3] bond: fix xfrm offload issues
Date: Fri,  7 Mar 2025 03:19:00 +0000
Message-ID: <20250307031903.223973-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first patch fixes the incorrect locks using in bond driver.
The second patch fixes the xfrm offload feature during setup active-backup
mode. The third patch add a ipsec offload testing.

v5: use list_for_each_entry_safe() when del item in list (Nikolay Aleksandrov)
    do not call spin_lock_bh in sleep function xdo_dev_state_free (Nikolay Aleksandrov)
    set xso.real_dev = NULL to avoid __xfrm_state_delete() is called in parallel()  (Cosmin Ratiu)
    remove spin lock in bond_ipsec_add_sa_all() as it doesn't resolve the race condition.
v4: hold xs->lock for bond_ipsec_{del, add}_sa_all (Cosmin Ratiu)
    use the defer helpers in lib.sh for selftest (Petr Machata)
v3: move the ipsec deletion to bond_ipsec_free_sa (Cosmin Ratiu)
v2: do not turn carrier on if bond change link failed (Nikolay Aleksandrov)
    move the mutex lock to a work queue (Cosmin Ratiu)

Hangbin Liu (3):
  bonding: fix calling sleeping function in spin lock and some race
    conditions
  bonding: fix xfrm offload feature setup on active-backup mode
  selftests: bonding: add ipsec offload test

 drivers/net/bonding/bond_main.c               |  71 +++++---
 drivers/net/bonding/bond_netlink.c            |  16 +-
 include/net/bonding.h                         |   1 +
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond_ipsec_offload.sh | 154 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |   4 +
 6 files changed, 222 insertions(+), 27 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_ipsec_offload.sh

-- 
2.46.0


