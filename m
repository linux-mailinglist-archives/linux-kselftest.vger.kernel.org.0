Return-Path: <linux-kselftest+bounces-6045-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB899874FDE
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 14:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B7B4B24393
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 13:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0EA12C52D;
	Thu,  7 Mar 2024 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLMDsbhQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFB9126F3E;
	Thu,  7 Mar 2024 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817765; cv=none; b=XpsbZ+ekjBszzMVTYzTyY+bTlU/i2ruB+gfppJ4O3P9jFGJBjQWq+A5bnnQrkjwX890iM/3aMdE9ZHw9wcDYtcrYmljXk6lI8zcDOfDSvM9BLCfW/ltWjGioIVoveJrlVXkIL7+GM8hNsYiLoaq/c6xOYfDZLQlmAu5g8kc3QKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817765; c=relaxed/simple;
	bh=BJjO1ugkVUqdf+8Apz35cxnUeUI1ML5rW7GTNeJ5rAM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=h94v5bMT76Q3vkN9DAUoP5MvSz3/USIVtwods2ntTEYTtF/sUVqXR0gJKcVrBLdWDjzjvueag2dqDzyhTA/AZlLOW8hnjcobqv1EGg7YDzsfgrtupYwINAikPzl7Gk/UzY2rHZc7Stu5wa0BPy3+4KUwNiAV3nslfEb4O+SaIT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLMDsbhQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412ea23a750so5702885e9.0;
        Thu, 07 Mar 2024 05:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709817762; x=1710422562; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VuTaArBgg54vJ0OjHE2HG4k9mtlNuGTtzmNJHg/V9mo=;
        b=HLMDsbhQnWzodJu32rYHKHe9mwWkW+uTFrD2Jc6G4gqmE1bFChJnLWJ4YrXe5ne4UG
         s7U5jWKKJmM2nYFZPKiSZECHc2ry0VXhNDszSCT2Gn8Et8LL273Ezc3OUJI3dghGOxy8
         xi0OmzREluznSeQ64YQfzAoAkp6CPA5QeHrZb1ZMyZ/l2lbndsLBwre1++ahHAy3OFd4
         VK5uOiCi0KZkxN4T3GxxauEv/5YkrbSt9VX3vrVo+rBavao69id+o/Xt+ZdekCFbaOio
         G8dka/97WJqrZFDjBMXb153C62B6Pr4T+oqoQmlZSGm7yaPghoGnm+pfngtxxRDSDpQV
         chjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709817762; x=1710422562;
        h=content-transfer-encoding:to:subject:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VuTaArBgg54vJ0OjHE2HG4k9mtlNuGTtzmNJHg/V9mo=;
        b=NDG1CXYwrNGVvlbDyrGVNnc6wU0ecs9fsMzWzuFuNgs39pMXTdvpfgtnQhIsPsxITD
         /g0Vv27+pReBUxptrTLwrvqPGGUga1thrY6AK7/3MdXn7Ds+nxUPRQKFxXQVtNz5HcRo
         oJRZMXSajLyYvdWZM7J0fHDvMevu0791UvQPCIewMELh5uLrGi1N9am8Em/VcZVWZAUV
         T2YgGUF4GAGF5yR85bqxWV1vLE95FIQtRws3WPTI0MAeNFVMj3XjHgiWqYN36sImHCoq
         tbyjUqfwW3cG4ze72u5PjdIs3fP9aRokszHodJ1inQ8FmQ26CRAiF3BjfNIjzBk9T+Ee
         Ao4A==
X-Forwarded-Encrypted: i=1; AJvYcCX9Z3qYKAgLVMU7shT0JKHMB4r1ZStmquAtiMGjMbZ0awIx3p8e0wzpl33O8xyhhvUHIXh8ktcda5jTD8d59dfldQdefwhcrSOia6ylDq0n7idqsnl4jjBuIIdGYNKQ/IMbZ/umfD1TDTQmR6x9Vqqob6T9PaoTtEhPJ6Iea+4HQFH0PvkV
X-Gm-Message-State: AOJu0Yx9Sw/0bM2VcCGKa32/UPyQEEczZhEIffqxcozAa5NEk4MTPcMn
	PfKyPXwVoKcX0ddE/A1EB9m233ofiWici6NKKBzs7KDysdlOrN8/
X-Google-Smtp-Source: AGHT+IEUKtgQ255Jq/XH7tG6mzkgUggI/JjYuvk5f6ZL0x2ze8VuBIAK/A/0vEpzN0QX+9VPF+IYig==
X-Received: by 2002:a05:600c:4fd2:b0:412:f8e4:78cf with SMTP id o18-20020a05600c4fd200b00412f8e478cfmr296832wmq.5.1709817761759;
        Thu, 07 Mar 2024 05:22:41 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id cr14-20020a05600004ee00b0033dd06e628asm20284889wrb.27.2024.03.07.05.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 05:22:41 -0800 (PST)
Message-ID: <2ce1600b-e733-448b-91ac-9d0ae2b866a4@gmail.com>
Date: Thu, 7 Mar 2024 14:21:54 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v2 0/4] net: gro: encapsulation bug fix and flush
 checks improvements
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
 shuah@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series fixes a bug in the complete phase of UDP in GRO, in which
socket lookup fails due to using network_header when parsing encapsulated
packets. The fix is to pass p_off parameter in *_gro_complete.

Next, inner_network_header is always set in the receive phase of GRO,
this is then leveraged in the next commit to remove some state from
napi_gro_cb, and stateful code in {ipv6,inet}_gro_receive which may be
unnecessarily complicated due to encapsulation support in GRO.

In addition, udpgro_fwd selftest is adjusted to include the socket lookup
case for vxlan. This selftest will test its supposed functionality once
local bind support is merged (https://lore.kernel.org/netdev/df300a49-7811-4126-a56a-a77100c8841b@gmail.com/).

v1 -> v2:
 - Pass p_off in *_gro_complete to fix UDP bug
 - Remove more conditionals and memory fetches from inet_gro_flush
 - v1:
   https://lore.kernel.org/netdev/e1d22505-c5f8-4c02-a997-64248480338b@gmail.com/

Richard Gobert (4):
  net: gro: add p_off param in *_gro_complete
  selftests/net: add local address bind in vxlan selftest
  net: gro: set inner_network_header in receive phase
  net: gro: move L3 flush checks to tcp_gro_receive

 drivers/net/geneve.c                      |  7 +-
 drivers/net/vxlan/vxlan_core.c            | 11 ++--
 include/linux/etherdevice.h               |  2 +-
 include/linux/netdevice.h                 |  3 +-
 include/linux/udp.h                       |  2 +-
 include/net/gro.h                         | 33 ++++++----
 include/net/inet_common.h                 |  2 +-
 include/net/tcp.h                         |  6 +-
 include/net/udp.h                         |  8 +--
 include/net/udp_tunnel.h                  |  2 +-
 net/8021q/vlan_core.c                     |  9 ++-
 net/core/gro.c                            |  5 +-
 net/ethernet/eth.c                        |  5 +-
 net/ipv4/af_inet.c                        | 53 ++-------------
 net/ipv4/fou_core.c                       |  9 +--
 net/ipv4/gre_offload.c                    |  6 +-
 net/ipv4/tcp_offload.c                    | 80 ++++++++++++++++++-----
 net/ipv4/udp.c                            |  3 +-
 net/ipv4/udp_offload.c                    | 26 ++++----
 net/ipv6/ip6_offload.c                    | 45 +++++--------
 net/ipv6/tcpv6_offload.c                  |  7 +-
 net/ipv6/udp.c                            |  3 +-
 net/ipv6/udp_offload.c                    | 13 ++--
 tools/testing/selftests/net/udpgro_fwd.sh | 10 ++-
 24 files changed, 188 insertions(+), 162 deletions(-)

-- 
2.36.1

