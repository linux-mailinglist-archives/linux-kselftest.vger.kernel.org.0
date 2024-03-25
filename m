Return-Path: <linux-kselftest+bounces-6583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB4888AE9A
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 19:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBAC321F1B
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12A355798;
	Mon, 25 Mar 2024 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9O+uwX7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE212E6A;
	Mon, 25 Mar 2024 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391207; cv=none; b=KTm/M8LlaWjX/L3qL+GCw1O1HDzACKWZgzZ6bfCUomG51a19ClVC07QqebQqNEkFa8ktqAg/TheCi+YFLhv/2dz9QANFD58Obo+8HcxuNC0ITXk8g6THlw1UkoZyK6H+VzcERS86Y0SKrFqBhhjYUXdsbMAOHyJXAttX/Xamg+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391207; c=relaxed/simple;
	bh=alToMwgx8F4x0ok8bQUuFA0DjFg6nUSwo0GbUNoR+Y4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Yh0CE/i4pCHxJNo6GFYq5z+dIqJziF9JtQxDFYHSW27ZFfWT81S8P9BWm7L1ESwjfRD62wPqr86WSeD6sCycwkZoyQzB7cHZh2wrp4EHvv4cqHbFOFQdjBTyYsae5ENrzAhkBoxxRO3HG49qD1I5DPH/fNz6maysr3eFGyJu1DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9O+uwX7; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d52e65d4a8so62254541fa.0;
        Mon, 25 Mar 2024 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711391204; x=1711996004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=olLxRakxTUSwwI2bXiG7lgWcNd9XDiHnHMSgPu9OGUM=;
        b=Y9O+uwX72Qh9SYkInPsX1u6sR5p44/JwT5JVdyE7YmbewS42Bgwi4S6B5OuvoPP2MA
         K1a/PHgbIa0f//GskYXchrYxRJhYXcVxeziyXkimMPtTuRS64AdF2sofUFoPDRvjEQ8U
         UGivsw/xM2tY2PcqwAfzqiLZuPzEJ5Ispfx2Y5hs3cTSjJ2FcfXxOmrK/EQ3GiNWqkD3
         EfsAQV9G2aoRx3KYbtnYJT2kQRLJBg/3GpXmr0D+JwlDExXcYlQWc8gvcXgULEIBDBCr
         dVYxPlv7BtgzQl/iy/kV7+ygxXfwX1Urywcip+GPkf+uMgtp8Ab0Ub7PCqTQW7Og3vjb
         esEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391204; x=1711996004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=olLxRakxTUSwwI2bXiG7lgWcNd9XDiHnHMSgPu9OGUM=;
        b=YW9/Xp53iTrzowoPiAJcfjrpmXJVYLON9gUcT4uELnl56KQDEZL4vuTvpyt57GCFaO
         kvUDFEAgF6lKpFlyNBWW0UHzrLywDoRpSERkL/LVGTL0LRd2C6BRc3ueTPIcnwu26Ahm
         kli06fGo+QnTbYSoEySxSipXJf1gbFQljBgCA4SBrDH2YtSNVXAWXS91YAVn64tDS6NW
         d8n/tA21ljQ79ZUG4MWDbX7W/lacsV35iDmH6IUyroFBcxqbyvfW95FxO78pkjj80osI
         prgPjDVjtNAFnF2k/kbJKPs2R7vqIE84h3PhmTUocQvVgdncSaSd9D23utPsceNlfc1U
         CoQw==
X-Forwarded-Encrypted: i=1; AJvYcCU7zOgV+sScWVlds+ZApMr5Yx1jl9GuWPa0bAYVORPgAOIF29uTaG1Su+z+8XA1enYqWve2JV8AMR91DJwDSPbUBBteT9c2XkYoRLk8Jm1agS5HfnTzvN5TWOGb0NjfMsPVrlpF/3t0M2WFIfKHFMAfa+isqRkrWpK1rTIRoi5gB3AOQTRG
X-Gm-Message-State: AOJu0Yy3T2Hvr88df2mnwwU+Hov6Tadju2EBfQtBW9dSp4zq/5YaHBr8
	pA1r7I3DR82DdBaMsljZjnxDY8ZDTAOGGBtdPi/NQ9wz26UabG3L
X-Google-Smtp-Source: AGHT+IGkr9xEaWrbpwvTksrMxwc7O+nLPCMPgTZT/0FSruWW9Qp8zNzF8aG5i68YvH31sBzy2fp04w==
X-Received: by 2002:a05:651c:b06:b0:2d6:d9cd:ac8c with SMTP id b6-20020a05651c0b0600b002d6d9cdac8cmr2496722ljr.43.1711391204062;
        Mon, 25 Mar 2024 11:26:44 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id m9-20020a5d4a09000000b00341bdecdae3sm7954758wrq.117.2024.03.25.11.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 11:26:43 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	dsahern@kernel.org,
	xeb@mail.ru,
	shuah@kernel.org,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	petrm@nvidia.com,
	jbenc@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	liujian56@huawei.com,
	horms@kernel.org,
	linyunsheng@huawei.com,
	richardbgobert@gmail.com,
	therbert@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4 0/4] net: gro: encapsulation bug fix and flush checks improvements
Date: Mon, 25 Mar 2024 19:25:39 +0100
Message-Id: <20240325182543.87683-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a bug in the complete phase of UDP in GRO, in which
socket lookup fails due to using network_header when parsing encapsulated
packets. The fix is to pass p_off parameter in *_gro_complete.

Next, the fields network_offset and inner_network_offset are added to
napi_gro_cb, and are both set during the receive phase of GRO. This is then
leveraged in the next commit to remove flush_id state from napi_gro_cb, and
stateful code in {ipv6,inet}_gro_receive which may be unnecessarily
complicated due to encapsulation support in GRO.

In addition, udpgro_fwd selftest is adjusted to include the socket lookup
case for vxlan. This selftest will test its supposed functionality once
local bind support is merged (https://lore.kernel.org/netdev/df300a49-7811-4126-a56a-a77100c8841b@gmail.com/).

v3 -> v4:
 - Fix code comment and commit message typos
 - v3:
   https://lore.kernel.org/all/f939c84a-2322-4393-a5b0-9b1e0be8ed8e@gmail.com/

v2 -> v3:
 - Use napi_gro_cb instead of skb->{offset}
 - v2:
   https://lore.kernel.org/netdev/2ce1600b-e733-448b-91ac-9d0ae2b866a4@gmail.com/

v1 -> v2:
 - Pass p_off in *_gro_complete to fix UDP bug
 - Remove more conditionals and memory fetches from inet_gro_flush
 - v1:
   https://lore.kernel.org/netdev/e1d22505-c5f8-4c02-a997-64248480338b@gmail.com/

Richard Gobert (4):
  net: gro: add p_off param in *_gro_complete
  selftests/net: add local address bind in vxlan selftest
  net: gro: add {inner_}network_offset to napi_gro_cb
  net: gro: move L3 flush checks to tcp_gro_receive

 drivers/net/geneve.c                      |  7 +-
 drivers/net/vxlan/vxlan_core.c            | 11 ++--
 include/linux/etherdevice.h               |  2 +-
 include/linux/netdevice.h                 |  3 +-
 include/linux/udp.h                       |  2 +-
 include/net/gro.h                         | 36 +++++++----
 include/net/inet_common.h                 |  2 +-
 include/net/tcp.h                         |  6 +-
 include/net/udp.h                         |  8 +--
 include/net/udp_tunnel.h                  |  2 +-
 net/8021q/vlan_core.c                     |  6 +-
 net/core/gro.c                            |  6 +-
 net/ethernet/eth.c                        |  5 +-
 net/ipv4/af_inet.c                        | 49 ++------------
 net/ipv4/fou_core.c                       |  9 +--
 net/ipv4/gre_offload.c                    |  6 +-
 net/ipv4/tcp_offload.c                    | 79 ++++++++++++++++++-----
 net/ipv4/udp.c                            |  3 +-
 net/ipv4/udp_offload.c                    | 26 ++++----
 net/ipv6/ip6_offload.c                    | 41 +++++-------
 net/ipv6/tcpv6_offload.c                  |  7 +-
 net/ipv6/udp.c                            |  3 +-
 net/ipv6/udp_offload.c                    | 13 ++--
 tools/testing/selftests/net/udpgro_fwd.sh | 10 ++-
 24 files changed, 187 insertions(+), 155 deletions(-)

-- 
2.36.1


