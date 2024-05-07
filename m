Return-Path: <linux-kselftest+bounces-9618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF748BE8C7
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 18:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841F7283A81
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABED016C6BD;
	Tue,  7 May 2024 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObR8VvlO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F267416C697;
	Tue,  7 May 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099066; cv=none; b=YQODyQsDGmUs234P0RlbuiSE/dV+vjIjmAn43fWeD8i2AvMfn2Di685IrKXUFmwZyrzctEi6mt2kQiuGAeZu0nqEtuvCSL2JgXTFx/Oxzdq1XwXqhe+zzjD0kKOWOpBDTO1jNnY6XuHDllfutGH/LiMrRkfIG8ILbOqpkBmy4yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099066; c=relaxed/simple;
	bh=lV/KHit7dzBx/dqTpedX6zF05hJ6yuvIAm+QIf8+4c4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FWAJkjWQn72jIumDUX4Y0b2V9+YCShMJiCjeEDoWdDHKc7ftzlHgZV049iU/5N7FPpVTyps0TBXyYtXAepm+m8SiyQm69QAFfs7rhJ6ZUuyu2G8EEDSYSh9WcJMQ9FPyG7/4PLBqrKG8sm8KuG8ffCJGqySAOYhy27YV5XraPcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObR8VvlO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34d9c9f2cf0so2504429f8f.3;
        Tue, 07 May 2024 09:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715099063; x=1715703863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H7xp/fk6cv9hTgtMu9MpbQCHEqA9h660fDuMw67BHqo=;
        b=ObR8VvlOocvmFT9jAowALsT4WbZKr0QyzmDYT44G4yjd9ZroBi7Tla1O0AKR/00+7K
         TXuFYQCE00egtT94Nn33iktT/UyLmKjFWjA7cIM3EW/tGXi//EUKB24T/jhQQFJ41Ezr
         wTWzuUXXtL/dnm35B5ZQSQfFQ8ipYko84vhalhmMokplLi9ThbOkJ9HYUy9t4pfDT16t
         Wmjfhjq/vduiHdUQ3Bac0Ufb9ex/K6CCj0B1poRsl0Szg32LFVIjOZMNJDIoNXKIAJ9j
         IQpzq0BTYzKf6jdm9DCpNEDRxz23YJ8kMRzWrNeNM8ZAM3lq0Qr7zkfROFRjEAXtgtp8
         ko1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099063; x=1715703863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7xp/fk6cv9hTgtMu9MpbQCHEqA9h660fDuMw67BHqo=;
        b=WzoFnBOu8PBN69oo+eg8NJHdEVL2IKRBdJCfw47d+Kj+gVPVDSIQneTjwUgk1kc91f
         UuIbmHLBYMrPmfpSrYbQQdM/JbwAWQgDu3TiHjr1NhWUbaSs37z/8/0obT6RWpdxYwVq
         0kyDNFle4KVv+u4yMFS0Pmu1GpaUUXWcM5qJ5zUFBaj0WLov2KGtCYHqU9bQER80SVdw
         NTl1/o9t1O4pXJcid1DGvglGVomAYda5l4EaWPP7ZqxALFXSLOEhaNi2qgCb5uPTslCq
         juK8x18rUIAFflwoRHn02At4TgUnogWXEDmWKTWRRxqSWfY4Ul+enmz96jYrU5XDOBeL
         H9uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw7ivuVW+JAx1H8E6ssS29dwH31X/ntdIVWaCO/NVJ8GWLxKMEB+ihDGKlGCLNQ7S48QH2zpFNOMTcCsAuc/b34Cv66YTQVhXkEEn0UP2Iah2pJWges5vA2cmb1L+LNToamFvwHEkZ4xuY+7K54VyFtxAoF3i4lfi3wi4VyrwNKGXT2O3u
X-Gm-Message-State: AOJu0Yy+u1qkj9PVwKxRbfE5T+O9MCOamCRglamqi9d2NC/PHNYZ1Mp6
	5CGStYhTsRZiXymxzSWCuOrdgmUDrlKRbk47pEfmRcYAHY2PfZhk
X-Google-Smtp-Source: AGHT+IF3oE3dSC8Orfh6qoCYqeL7TEDpHOGeGitXh2UVUUCtJMpHfidBnO0S4+wERZriREuoBrg/zg==
X-Received: by 2002:a05:6000:1104:b0:34f:96ba:ca3f with SMTP id ffacd0b85a97d-34fca621dbcmr357621f8f.53.1715099063264;
        Tue, 07 May 2024 09:24:23 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c4ec700b0041902ebc87esm20102264wmq.35.2024.05.07.09.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:24:22 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	dsahern@kernel.org,
	alexander.duyck@gmail.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v9 0/3] net: gro: remove network_header use, move p->{flush/flush_id} calculations to L4
Date: Tue,  7 May 2024 18:23:45 +0200
Message-Id: <20240507162349.130277-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cb fields network_offset and inner_network_offset are used instead of
skb->network_header throughout GRO.

These fields are then leveraged in the next commit to remove flush_id state
from napi_gro_cb, and stateful code in {ipv6,inet}_gro_receive which may be
unnecessarily complicated due to encapsulation support in GRO. These fields
are checked in L4 instead.

3rd patch adds tests for different flush_id flows in GRO.

v8 -> v9:
 - rename skb_gro_network_offset to skb_gro_receive_network_offset for
   clarification
 - improved code readability in tests and gro_network_flush functions
 - v8:
   https://lore.kernel.org/all/20240506093550.128210-1-richardbgobert@gmail.com/

v7 -> v8:
 - Remove network_header use in gro
 - Re-send commits after the dependent patch to net was applied
 - v7:
   https://lore.kernel.org/all/20240412155533.115507-1-richardbgobert@gmail.com/

v6 -> v7:
 - Moved bug fixes to a separate submission in net
 - Added UDP fwd benchmark
 - v6:
   https://lore.kernel.org/all/20240410153423.107381-1-richardbgobert@gmail.com/

v5 -> v6:
 - Write inner_network_offset in vxlan and geneve
 - Ignore is_atomic when DF=0
 - v5:
   https://lore.kernel.org/all/20240408141720.98832-1-richardbgobert@gmail.com/

v4 -> v5:
 - Add 1st commit - flush id checks in udp_gro_receive segment which can be
   backported by itself
 - Add TCP measurements for the 5th commit
 - Add flush id tests to ensure flush id logic is preserved in GRO
 - Simplify gro_inet_flush by removing a branch
 - v4:
   https://lore.kernel.org/all/202420325182543.87683-1-richardbgobert@gmail.com/

v3 -> v4:
 - Fix code comment and commit message typos
 - v3:
   https://lore.kernel.org/all/f939c84a-2322-4393-a5b0-9b1e0be8ed8e@gmail.com/

v2 -> v3:
 - Use napi_gro_cb instead of skb->{offset}
 - v2:
   https://lore.kernel.org/all/2ce1600b-e733-448b-91ac-9d0ae2b866a4@gmail.com/

v1 -> v2:
 - Pass p_off in *_gro_complete to fix UDP bug
 - Remove more conditionals and memory fetches from inet_gro_flush
 - v1:
   https://lore.kernel.org/netdev/e1d22505-c5f8-4c02-a997-64248480338b@gmail.com/

Richard Gobert (3):
  net: gro: use cb instead of skb->network_header
  net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment
  selftests/net: add flush id selftests

 include/net/gro.h                 |  87 ++++++++++++++++---
 net/core/gro.c                    |   3 -
 net/ipv4/af_inet.c                |  45 +---------
 net/ipv4/tcp_offload.c            |  20 ++---
 net/ipv4/udp_offload.c            |  10 +--
 net/ipv6/ip6_offload.c            |  16 +---
 net/ipv6/tcpv6_offload.c          |   3 +-
 tools/testing/selftests/net/gro.c | 138 ++++++++++++++++++++++++++++++
 8 files changed, 227 insertions(+), 95 deletions(-)

-- 
2.36.1


