Return-Path: <linux-kselftest+bounces-7568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4222289FBE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 17:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55003B25020
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FD616EC15;
	Wed, 10 Apr 2024 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYD+q7fX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5B916D9D7;
	Wed, 10 Apr 2024 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763310; cv=none; b=PMx3RYLug3InlFH0inPGDnaGEu8RpMDVGfgfocte8mLYyifoKDizG7VMLIFEKP9D5iflJSZe3d3bY92qs+CK2J1WQlQjw7f/v8yJvw7kkdBgiN9Z0v1WbYpY+E37/jiNpdnu90IziUiwE2LH7v8M1Nsdb7CQ8RGUvgJDf+hikk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763310; c=relaxed/simple;
	bh=OyYmf1SyhSUzOgp08bHoq9Ows/Jqw8LDMHkgdUbp6Ek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OfydDcT75nia1PvSuZooR6manNcg6W9eMWUuLSBtXCQoYTeCiWl/dCJmfeL/CzEOIGWnAdxB7e3kqQCnBtEBPJRhvmMF/6GQOt5HsvKlM2/yV1oj4NZgfN8Pe6FAKDWUosTrC9BW28GFAn9k2ktd85fMx/V9rf6P7yocx+qIUiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYD+q7fX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34641b7c49aso1131473f8f.2;
        Wed, 10 Apr 2024 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712763307; x=1713368107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IBwnaqezteqUdRNwVBziFTTAPvV0prxLvZrb7i97J20=;
        b=UYD+q7fXSPtM8KSeZLRKiNueBon4V0JXPRLkSI/CbVfpTVWFJAGzHpCNjzPaPbGSlY
         /pXI2ZywofQLzVEynUjP8jugll7anJUiZglwK6ovYBYae8L0AI+Fe2Wv/0TXz+kiJa+D
         ZWGOtbLum4zCffVCMDa+oPzx0zjPpMJi9TxcTbQ/PBWo8p0MnobUJxqakbVIUiIyyVh4
         Dx4n2SU5paJQvFerqNh/CA4SmZ0JfCvKtTll8T851QMkpVKKzkXCOViXnOkU5F05yN+/
         CC2gTY08iw98lB7B2dY8mRt5ikl5zifaTQNiPFJHZacJTavanoX7zyWMRXmkz4usMGNP
         z57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712763307; x=1713368107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBwnaqezteqUdRNwVBziFTTAPvV0prxLvZrb7i97J20=;
        b=O4mX15GcURx5BJEjd5f9HPU5cx++djkEt/37Kea1yHqap+0xFEQJTWQ6xq4axMzQni
         Eldu9UfgFhT6VGN5OpWtmwajhjNI9rDqmY3JH6O6x8i0hE47St2/xqDa1k9mT1VDh6G2
         bTW5e1uOY+KuIVN8gbhSdImExTUl35oQfSV+q9g6Lqce5u+kARc2bMft+H7O0uweg5sq
         OehnRrqSfEJNIse1M00W8DY3wX5R3AqPzpepzBP8wh0NxQlJ5Xbsh1ltHABAuztQCiAv
         74fhAeD6OJjV+/EaAH6BcFMkxqN65vkMeOmUAlnE1+V5XWk6uxp/P/IKbXQ595WufgTR
         4lZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXisDL3qbhVbFxqUESouKgwU1wTgadRAGO3E+vKoHWCPGfI8Ir3UtOpWu01V8+//kHoSwM3KjCthZr8oID57QKT/ixrnVo1PUoy3RSfbAWR7fUo90AC/O3FxnM+gw9UM4cTfRFuXRFokmFx+CLczW4mXpxsNNcanJY4JeLCLy08X++6K9pj
X-Gm-Message-State: AOJu0YwX9R8EuU71fwiR3yvK8rzmb32LckpJpP9b5TxCUBraeLDq7h+J
	hRbtqJt29g3jYSwuqxxziw/MapoLIGAl7y51ovxkoAatvPG8fbvX
X-Google-Smtp-Source: AGHT+IEHQGILqG1ONGi096fZ2/M+fo1TMzuOfTDDP+hD9obdwj/L+7ph97nSdh1g89FRPBTVWhAF6g==
X-Received: by 2002:a5d:54c9:0:b0:346:251a:396d with SMTP id x9-20020a5d54c9000000b00346251a396dmr1843405wrv.51.1712763306706;
        Wed, 10 Apr 2024 08:35:06 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id q1-20020adffec1000000b00345aa92fa1dsm7945078wrs.117.2024.04.10.08.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:35:06 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	dsahern@kernel.org,
	aduyck@mirantis.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v6 0/6] net: gro: encapsulation bug fix and flush checks improvements
Date: Wed, 10 Apr 2024 17:34:17 +0200
Message-Id: <20240410153423.107381-1-richardbgobert@gmail.com>
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

v5 -> v6:
 - Write inner_network_offset in vxlan, geneve and ipsec
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
   https://lore.kernel.org/all/20240325182543.87683-1-richardbgobert@gmail.com/

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

Richard Gobert (6):
  net: gro: add flush check in udp_gro_receive_segment
  net: gro: add p_off param in *_gro_complete
  selftests/net: add local address bind in vxlan selftest
  net: gro: add {inner_}network_offset to napi_gro_cb
  net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment
  selftests/net: add flush id selftests

 drivers/net/geneve.c                      |   8 +-
 drivers/net/vxlan/vxlan_core.c            |  12 +-
 include/linux/etherdevice.h               |   2 +-
 include/linux/netdevice.h                 |   3 +-
 include/linux/udp.h                       |   2 +-
 include/net/gro.h                         |  93 ++++++++++++--
 include/net/inet_common.h                 |   2 +-
 include/net/tcp.h                         |   6 +-
 include/net/udp.h                         |   8 +-
 include/net/udp_tunnel.h                  |   2 +-
 net/8021q/vlan_core.c                     |   6 +-
 net/core/gro.c                            |   7 +-
 net/ethernet/eth.c                        |   5 +-
 net/ipv4/af_inet.c                        |  54 +-------
 net/ipv4/fou_core.c                       |   9 +-
 net/ipv4/gre_offload.c                    |   6 +-
 net/ipv4/tcp_offload.c                    |  22 +---
 net/ipv4/udp.c                            |   3 +-
 net/ipv4/udp_offload.c                    |  31 +++--
 net/ipv6/ip6_offload.c                    |  41 +++---
 net/ipv6/tcpv6_offload.c                  |   7 +-
 net/ipv6/udp.c                            |   3 +-
 net/ipv6/udp_offload.c                    |  13 +-
 tools/testing/selftests/net/gro.c         | 144 ++++++++++++++++++++++
 tools/testing/selftests/net/udpgro_fwd.sh |  10 +-
 25 files changed, 338 insertions(+), 161 deletions(-)

-- 
2.36.1


