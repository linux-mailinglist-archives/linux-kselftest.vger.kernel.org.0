Return-Path: <linux-kselftest+bounces-25722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EB7A27AE9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 20:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F94716703A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 19:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23066218ADB;
	Tue,  4 Feb 2025 19:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="p2iNy5Wu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8033221767A
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Feb 2025 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738696275; cv=none; b=Z/8azvfuU37Fq0onjlB/pjuK3kzfH0sBft1SFvZVy6PVLa+C1m6gz+MxhTd8COFSoBX2sPNSad+0clKnqeW5icikMqIRtKlwH6+IW6msrAtJyoSi8JY0/w2SzCt/nJ1Q3LucLJ7dbEwO09tfLMoVN6rQJrlgMh6WgiUix7VJ9dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738696275; c=relaxed/simple;
	bh=0fuYrIsqllSYzLcHkJwRY4bJmN7f0RR3V+7BnwkqZU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NryboiJz0Bw5TXPEvc1K0qekeh2+3+BQ3bhfse2BgNwwJSrpcRFwOu2UrHGdGdZE6+K0R3GYxkmQJln1jXDGNl2KLQmCeGSf+0FCb04axBswttvlvom0N4mxDDcWszw0ezWURVX3MDL2Xr1rzs/X6Oig8FALdVFU95L5krktSpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=p2iNy5Wu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2166651f752so21100425ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2025 11:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738696273; x=1739301073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f6v2PFnPWGVlwpnR5q4crYxZDb82PXI2M6sV6qpxfa4=;
        b=p2iNy5WuLXL7dHihh847affEbdk5jw/XsmMqHzVKEeg58Taq2ilrheA+kep6UOex1C
         3fzqB7rMwZs820NvP1WwDqN9HeD5/3ExVn3TUh9mHjae6bMXvoE8CorbfPt+FYD2RHB+
         cFnL4nkHXDUb/ThnD9Uh/NUBUQB+sKeWPLwKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738696273; x=1739301073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6v2PFnPWGVlwpnR5q4crYxZDb82PXI2M6sV6qpxfa4=;
        b=YWN8nU7CkH7/2vbXbIv3J5jchcFPduEkrjkIcVkkPGj/fGVtn8KxH97+Fg+I2rGDuA
         VDdoqUGfJRfCD6fNLIUDx+WY6zGKKJm6fOGBLtLWr5jvzKaD6mAsn9/ANNQPJ1CVxNSi
         TqTJFiPd+CTk5cZq244Saf0W884P42+iS4D6NDnR3bkfVX0Fr62tX7kveE66Z5FntRjP
         EjIzupfXohhh+Wo+hoyXphWSStV/GAtmdM/K/GjY3A6XLPUAOYtB7CEB9HBt4mFK+GqH
         SHSL0G4gwasnpkjr+6Ao37613A8iISJ+BrfO9sjjZMujwadeM/x3pXaMmSDwqBaFFaM1
         agKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqC0nfASDb1dXUTj03cWohFoxWrrr0yEB7NCYDn25i/SOX3jO1Air/5IV12qdak5pMOoS79lGC1SdBcAlltgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB3ta7ELE2sUBTlYB4obygN+pn2mjY23gAJ29yi33kfNJfPBJO
	H/MExpoQHBmbblnhkgLDXLORwLFqAPLWBZGaCVpmRY4W0orZIJvFertlKH9VvkU=
X-Gm-Gg: ASbGnctDi0K+eOCsKj1R+1BkDwspVEhF1jq6wSSdUHlE9HYp1PpBBHndkPMUnXC5ZGb
	x6PesxSMrKAt8EdKJ2ly2bDckaBVjQZJO/NQAXysgpxUzFRVRrHoQWRcj+0CTf+4m8fGEanuAPH
	Wt5QYJTll1F/ReK2ddPdXQW33i6mUSSWnQh2URATdrU5lv1lxAgPw7JWwDWWYvuRtLuJ1C97Unr
	vlgb52k2zFcA3rRkRk6RcbevhcyiYEIKmmbHFBvGKUmYfF2K8ZfnGLqMAOJMWZCSzuL/GCVgv40
	SvuLR2tcL3NdFhNkH8o2ILY=
X-Google-Smtp-Source: AGHT+IHanqXpzFtreEkBCacmTKic/+ySduWwGEttNxARnmGyeReqSJRYRr1Lcw0ZgAN2NJKjdJwsaA==
X-Received: by 2002:a17:902:e747:b0:219:cdf1:a0b8 with SMTP id d9443c01a7336-21dd7d7ccaamr366849085ad.30.1738696272708;
        Tue, 04 Feb 2025 11:11:12 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea5f1sm100749785ad.130.2025.02.04.11.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 11:11:12 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_)),
	Daniel Borkmann <daniel@iogearbox.net>,
	Daniel Jurgens <danielj@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next v3 0/2] netdevgenl: Add an xsk attribute to queues
Date: Tue,  4 Feb 2025 19:10:46 +0000
Message-ID: <20250204191108.161046-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v3. No functional changes, see changelog below.

This is an attempt to followup on something Jakub asked me about [1],
adding an xsk attribute to queues and more clearly documenting which
queues are linked to NAPIs...

After the RFC [2], Jakub suggested creating an empty nest for queues
which have a pool, so I've adjusted this version to work that way.

The nest can be extended in the future to express attributes about XSK
as needed. Queues which are not used for AF_XDP do not have the xsk
attribute present.

I've run the included test on:
  - my mlx5 machine (via NETIF=)
  - without setting NETIF

And the test seems to pass in both cases.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250113143109.60afa59a@kernel.org/
[2]: https://lore.kernel.org/netdev/20250129172431.65773-1-jdamato@fastly.com/

v3:
  - Change comment format in patch 2 to avoid kdoc warnings. No other
    changes.

v2: https://lore.kernel.org/all/20250203185828.19334-1-jdamato@fastly.com/
  - Switched from RFC to actual submission now that net-next is open
  - Adjusted patch 1 to include an empty nest as suggested by Jakub
  - Adjusted patch 2 to update the test based on changes to patch 1, and
    to incorporate some Python feedback from Jakub :)

rfc: https://lore.kernel.org/netdev/20250129172431.65773-1-jdamato@fastly.com/

Joe Damato (2):
  netdev-genl: Add an XSK attribute to queues
  selftests: drv-net: Test queue xsk attribute

 Documentation/netlink/specs/netdev.yaml       | 13 ++-
 include/uapi/linux/netdev.h                   |  6 ++
 net/core/netdev-genl.c                        | 11 +++
 tools/include/uapi/linux/netdev.h             |  6 ++
 .../testing/selftests/drivers/net/.gitignore  |  2 +
 tools/testing/selftests/drivers/net/Makefile  |  3 +
 tools/testing/selftests/drivers/net/queues.py | 35 +++++++-
 .../selftests/drivers/net/xdp_helper.c        | 89 +++++++++++++++++++
 8 files changed, 162 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/.gitignore
 create mode 100644 tools/testing/selftests/drivers/net/xdp_helper.c


base-commit: c2933b2befe25309f4c5cfbea0ca80909735fd76
-- 
2.43.0


