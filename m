Return-Path: <linux-kselftest+bounces-7398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 611D989C6B8
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859EB1C22A41
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CFA86640;
	Mon,  8 Apr 2024 14:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhCOGV76"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB0A85C62;
	Mon,  8 Apr 2024 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585874; cv=none; b=QqDRPhABxRGBFywbRX23hlH/9B23DAxPcT6VHrNvQ8CI1cOSxzvZn3ctabs2IH8KW5XqF85DNOF+hJU6YC4aTqo1zIRdQH77s9frV8XnnrmbxDV5YCfwjeVqUKaRY9QuPaPeSstD5ZoFUq2odypFUlH2b19wzp3Z/aQcp22gK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585874; c=relaxed/simple;
	bh=Cl8QpYOgFS27JEtOyqS+PfQ5qeqh0B3tVFHersoU1nc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wl/NlUJRq7efc7we8lcWe6qQA4jiNBS852T15tjqIcqbmcSWP8euS9yG7WJFD5AOtiK+1/Ce2gOoshhVkVC7cNr2E1Em70eHvzpst7hQmAL5QjShCSRqj2kOTc7zpQrIDeoxfIKYR8YXqeCkZGoeXb32O+dwgWBtGJAR0mtVE4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhCOGV76; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d87450361fso29562611fa.2;
        Mon, 08 Apr 2024 07:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712585871; x=1713190671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M31BcrwK8SyOstFSsCRRJRL+DvnUXY7YE1UKU/j7W1Q=;
        b=IhCOGV7663PB/vTHSaBbNVItEGqXkqMfXr+1rqdg5Oaxpqnfss73iMbg/IyuzZgQGP
         LxMAQNSksLRUHdF3yLnBs1OCu3hj9+EXHkbgo6BSHJfOEddUGjju4JPubSYvD1xKWyCQ
         35+sCLcB9I3JxQ7FuQLiHYgd8U4F3kCiasXp6CCFZDH0GJjc2NoxiJe8iO0ytIn72Q3B
         ZMunMYYegTp0vWPPz/FfweckMWKOsmFTu5WAOejFEUCxUwZMu/6Q4rmAxZsZqJ4B/m7+
         uzXUPcuKI0z8qyQ/ZJ6IBkt04QRcpHltNgkBtwK8wNwz3jg6UzwAHg+0awiRKqQf2MM7
         mFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712585871; x=1713190671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M31BcrwK8SyOstFSsCRRJRL+DvnUXY7YE1UKU/j7W1Q=;
        b=WlQAR//eHsDxkrUrVkR220CD75qj2wLuybxTZyzckabvan0lSsboFRLbGrKE7k13KO
         2PerXmap792HV95V4a0FQhBlY5EwuuBE+aXORQ4m4bUBF+6FvbQWGxUFwLztSut//Z6o
         b5UlkJisJ97OvlTN1xE7m6lMubIQaSTAQe4QrOIzwqkTEGjBxhblAE25HrLziOrZJNTR
         JCIzKb1bM1AFCY3rLrFJAUy1JHoxYuSrXuol5jbN7QVhcNfJ+lYPAow03HmfG7fBc+qx
         4iiTNm3AtxBVjLBBCVd3LLT5qJVaycFGwDKyutIEJzu1DAynsZgSV7W9bER8pl9qM6KZ
         IELQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPeVF7ugy1pUn9GHL0VdBwcaI7KrmmEINeiDvkM/pkJpOidy0yRLlYtoYcz1uEtuio7OyMDk3TlcmIA3NLjppJi3zTCgaJiXxVSv8Wsv3uAxrjgiFbVUf+xCxUi2HAKbBAERIiQdxtPgcd7N5tnM9FEJut1c2Td5ZVkAj9esmKq6BODIj+
X-Gm-Message-State: AOJu0YzcnE/KqvQa2FymQw91fOxOoeiNsQrT0z8FrL6DYHuRUdqHZnbs
	DPoOM/hf+B0o3leY0NVz+X11vA3nhEwfPGFAVwRiMJDW/E/uCHGZ
X-Google-Smtp-Source: AGHT+IFnpIW39OsH1V2HOl6MsdfzguPCEEvF7udJVoH0kUnAjrqa8nv/jsxnbhshQZ8EESW8mdNILw==
X-Received: by 2002:a05:651c:4cd:b0:2d8:9baa:50ae with SMTP id e13-20020a05651c04cd00b002d89baa50aemr799329lji.31.1712585870446;
        Mon, 08 Apr 2024 07:17:50 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c468d00b004163059bb53sm12321801wmo.16.2024.04.08.07.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:17:50 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v5 0/6] net: gro: encapsulation bug fix and flush checks improvements
Date: Mon,  8 Apr 2024 16:17:14 +0200
Message-Id: <20240408141720.98832-1-richardbgobert@gmail.com>
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
  net: gro: move L3 flush checks to tcp_gro_receive
  selftests/net: add flush id selftests

 drivers/net/geneve.c                      |   7 +-
 drivers/net/vxlan/vxlan_core.c            |  11 +-
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
 25 files changed, 336 insertions(+), 161 deletions(-)

-- 
2.36.1


