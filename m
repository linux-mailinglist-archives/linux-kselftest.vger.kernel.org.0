Return-Path: <linux-kselftest+bounces-9817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306FD8C152A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 21:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ECD9B215A7
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 19:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400637F466;
	Thu,  9 May 2024 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIZOuSA/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7975F653;
	Thu,  9 May 2024 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715281730; cv=none; b=sBWQf9vRkjzD3AB++jfN902SEaWffD59Y+ZJ8hLJ0gq1kd0LFVLQYYOfhnmHZHN4dhsmcTIzeQqUXxNC/SyXk+TdNI/ZZV9+2EWjbCQm/oF2xfHoqyvQSWJqnmf7v7QRN7MrN4XnbLDXOhK4WeHTgBkpv20XPI8yLLy05tC3fCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715281730; c=relaxed/simple;
	bh=SJMNmaa17rzFGv6brCEDHC9jQ4iIWaVWBVPX0V+pJJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bwo3ZfxOpRVTdZHQhNkwsTB5eExW3rnKQ4lyWg0RllNvT4HJqYhyca18DFismNk2R+okzMnMq+a/yTt+B1DeyfoUSbTHXr++K+X5F9VFO7ksE3LUbk1SMawCopQxGZeQFhJE42SQaoXABwTcW3/J+pc1Khuo6oWUr1TOeZ7GH38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIZOuSA/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41c7ac71996so8630905e9.3;
        Thu, 09 May 2024 12:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715281727; x=1715886527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L4MH4ugKZv+ZJW0HxQhPqAphzhpWFwEeKHM4qNwV/3k=;
        b=mIZOuSA/XbX6+IkInLKlhu35O+bqePcw+9Yu0jw6X5ZkZT+rOHXQ/1X9wZy0orv/xG
         2KmScyNZevrmgbbsXy9lBOiY+x2qSZ2oXo5+vo0l0pO/CUSM5ObBvZb+4WTsrulmWQhG
         sYayZX7DnLBAINCUsz6cEslT4cI+j/Hd6/XhpaUJ+o4ix2tZJE0daXykPqtAzmqQVCEL
         BgatrtZsL9dM2OJCzLnumZbGoqG5ChKPqjSNTtUPtpqQnyLXMdO7wPSR3lyfM7HKiB9T
         ICkfmcaP0ivnPxVmKic+7lFlsTNt5ogTZ+5MEbnHGXkkQfxa8pnkLoW4oQQ0l2rGjPoB
         jQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715281727; x=1715886527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4MH4ugKZv+ZJW0HxQhPqAphzhpWFwEeKHM4qNwV/3k=;
        b=X7fBhy6/RoSPB+EPidJbGHd4WgFTQ3bu1Cdl87ub89Y0h/6jrOiITNjhm8tbz4HC0x
         /Xy7zlrMrSiG/nGQW6WHrBJtcGp5wXmqOLS4ucfSFGbh3pVjfnuJHE7rPcf9BBw3NqQc
         CAzeaVuFEofMO9m/XbkoXezm8Med9CkR+XHTmtIvQ4II1KkR11BgU7FyBoZBLI92lrYg
         /Mesj01K3ubx1TQVWjNM7V8VDqK702nNKN0mAn65IWIgWt5wfV/Floy4/BgQnx6yKHNY
         IT17PKY9qLqIWvkb+Ogxox9GU5gO5XCjFEW8ck0P5SJ0no312cB13/UPssBqP+3oht51
         yBMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdHleEqbNY4N/1n02OApsd0EXe3b8BFwWTjSOJDQhZM9ehJQJi8eB+AwXOEGo5LRRcWBS3IQdpXQogSVdBV5YhA/Px7Fznb1qKLnMmC+lQtCxjYNE1Wnr1wtI0vharuw7WvMPkTBR2S2BkVN3JdpFTMfiqoDwqjwY/fpCXmzG2K3Hxcy+o
X-Gm-Message-State: AOJu0Yx6PtjviDKm0ChsfPe47hBNd/PUDH0PlBwN0wkBf7R74FBOduh0
	D/DoKe8EdeDChgVKZOlpM3GtnUu9iHT6/uG30K6NVOAKsxGbjmYQ
X-Google-Smtp-Source: AGHT+IGycfb5nD6ZAsX2dWHkogiN2FNqr5MN+/sU6dG1pn6CZ6G2niBjdq08xvrCzPuPEfOFhX0Dig==
X-Received: by 2002:a05:600c:4ed0:b0:41b:d973:253e with SMTP id 5b1f17b1804b1-41fead7a0b5mr3288415e9.41.1715281726759;
        Thu, 09 May 2024 12:08:46 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87d204b5sm69953895e9.26.2024.05.09.12.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 12:08:46 -0700 (PDT)
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
Subject: [PATCH net-next v10 0/3] net: gro: remove network_header use, move p->{flush/flush_id} calculations to L4
Date: Thu,  9 May 2024 21:08:16 +0200
Message-Id: <20240509190819.2985-1-richardbgobert@gmail.com>
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

v9 -> v10:
 - rebased on latest net-next
 - improved code readability in inet_gro_flush
 - v9:
   https://lore.kernel.org/all/20240507162349.130277-1-richardbgobert@gmail.com/

v8 -> v9:
 - rename skb_gro_network_offset to skb_gro_receive_network_offset for
   clarification
 - improved code readability
 - v8:
   https://lore.kernel.org/all/20240412155533.115507-1-richardbgobert@gmail.com/

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
  net: gro: move L3 flush checks to tcp_gro_receive and
    udp_gro_receive_segment
  selftests/net: add flush id selftests

 include/net/gro.h                 |  85 +++++++++++++++---
 net/core/gro.c                    |   3 -
 net/ipv4/af_inet.c                |  45 +---------
 net/ipv4/tcp_offload.c            |  20 ++---
 net/ipv4/udp_offload.c            |   9 +-
 net/ipv6/ip6_offload.c            |  16 +---
 net/ipv6/tcpv6_offload.c          |   3 +-
 tools/testing/selftests/net/gro.c | 138 ++++++++++++++++++++++++++++++
 8 files changed, 224 insertions(+), 95 deletions(-)

-- 
2.36.1


