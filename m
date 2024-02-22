Return-Path: <linux-kselftest+bounces-5309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E643860448
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 22:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3419F1F24967
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 21:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0E16E5EC;
	Thu, 22 Feb 2024 21:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB7ZJ0Nu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1999610A05;
	Thu, 22 Feb 2024 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635678; cv=none; b=s2tNUVPkN/y8ZAuSjS/WzrtBvMflflj6j+zdSBS0UrHCf7tZ4iZp1aIQbF8UpNnciM4kgQPVrN9raHqtHSQcUDvxdPlN3b5XfVOcSv9BIRQXsp9vybf8f2UhLnBmZFsTI1RvCfYvsh7M9tI2T1CMu+N5PHJVLDIyKsLDFy/cLnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635678; c=relaxed/simple;
	bh=0o7JcANzu77v1OOVxgTmP0KHe9QWfy1TFeyR4mBFW5c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=GaL2e1DLMxk6WTpC55jwzYR+ajfv5NDZYJgnKqUun2Lsk8U/dcJmLbvf75xoJ1GZQrDW/2liSRMaYns3UKrS9zim1evac+qoRwC0JeaG1wRY8C5CF77wLnunfeRjJtlcSH0QtvIGWhbiVXkvHlJvdmyBM/sDEOdprfw4/Lz33rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IB7ZJ0Nu; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d208be133bso3067401fa.2;
        Thu, 22 Feb 2024 13:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708635675; x=1709240475; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6oH+qo1R8KP/GaMF1B2QMIj0swdnvO6mC2aR2+NNiDk=;
        b=IB7ZJ0NuvrZIwIP8UKOIvLXrt+7F9rVpWkAYCjV0ITIkUp/bSSA+ARAs3ARgrPhslY
         AAQKv700DngM5EKUP97x/2HitgX6QRaPlLhd2KmGTM4IRvfcSlkbSNyDH9AueatxFkZ4
         cf+lo6mfcYDrH5yEz4MUkGiDlrcHqRV12RopSy0898SPC3w3HULfNc4G2uYs6EKGxwF/
         FqQVMft+sZvjmpvhiNgQ7x2OWm2W1JtapXKWZPAhgyg1XNQ+QG85fiSX1Okrg9/FCrkM
         9NxhiZIrCvgDGRqcBdC4WulWuTbJEmEcR+nxb6Jru2LK4194O3QgLHPT5jKnSEr/+Rg9
         Ui9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708635675; x=1709240475;
        h=content-transfer-encoding:to:subject:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6oH+qo1R8KP/GaMF1B2QMIj0swdnvO6mC2aR2+NNiDk=;
        b=Aj1exefCfL1aI1wai5+6s19BxzgPjcFSmp/l+JoNNWw+XtfYXdg+2m8iGoi9PJSl7x
         y2dM2gq1YKQmn2k2DBJTleIMnGoN6SwzuF8dsKLw1Qm+2/e3TGhOySBWERzLhaN6dFHA
         a+FPVcO9Lrwg59LHBcOnYtL7ku/cdAdMeuQV+rDlECduhde/HzSUeklx90ZkgBRacza5
         uZTGT1owSnzQ4JT5059jtH3j5tQf9vTu/DUy3wt7stB4R/og7Hr6YUMAq9eUUbRQlPpZ
         Trd9VQpQOC7gjW5X+laIjB0RCuydTj2TuYVkV1rhsNU5d5Y51ZDo9ijSGRS5x2rrduFx
         Jl3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkrU8UIC8tFBTpcn3z3/J7codUBaElK4q8ASf59nsJCRw0j3DvHc0dpfJR5P52zntgalNNQhWf2uAKfLWmE0YQ52CC1HBTM8rXEFDbS4trzILZt/LPg/HCup6DuuFu5v+6nxwxfp1d8sUtTTZxODdJ+bUaUXAE6AbX5u4ZnyuQslxYZ549
X-Gm-Message-State: AOJu0YxothT+2V/fyNOMADbCmQ23Vc9IGd4oKpAoaumr1lgDlyHI32NW
	iU7xhfsq/q32mVL41CehoMEQX0Vz98zOercsEFeC9B89ECWyATbI
X-Google-Smtp-Source: AGHT+IHNG0dtgQPgn+V0ONyr9LkeNb/q/Q5pPRueOlg01yJfoaZB2X1nS/B081r9HZKUPzSzGiinQA==
X-Received: by 2002:a2e:9cd2:0:b0:2d2:3b9e:dcff with SMTP id g18-20020a2e9cd2000000b002d23b9edcffmr92206ljj.46.1708635675054;
        Thu, 22 Feb 2024 13:01:15 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id t11-20020adff60b000000b0033d01fe1f04sm198729wrp.55.2024.02.22.13.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 13:01:14 -0800 (PST)
Message-ID: <e1d22505-c5f8-4c02-a997-64248480338b@gmail.com>
Date: Thu, 22 Feb 2024 22:00:42 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next 0/3] net: gro: encapsulation bug fix and flush checks
 improvements
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org,
 liujian56@huawei.com, horms@kernel.org, aleksander.lobakin@intel.com,
 richardbgobert@gmail.com, linyunsheng@huawei.com, therbert@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series fixes a bug in the complete phase of UDP in GRO, in which
socket lookup fails due to using network_header when parsing encapsulated
packets. The fix is to keep track of both outer and inner offsets.

The last commit leverages the first commit to remove some state from
napi_gro_cb, and stateful code in {ipv6,inet}_gro_receive which may be
unnecessarily complicated due to encapsulation support in GRO.

In addition, udpgro_fwd selftest is adjusted to include the socket lookup
case for vxlan. This selftest will test its supposed functionality once
local bind support is merged (https://lore.kernel.org/netdev/df300a49-7811-4126-a56a-a77100c8841b@gmail.com/).

Richard Gobert (3):
  net: gro: set {inner_,}network_header in receive phase
  selftests/net: add local address bind in vxlan selftest
  net: gro: move L3 flush checks to tcp_gro_receive

 include/net/gro.h                         | 23 ++++---
 net/8021q/vlan_core.c                     |  3 +
 net/core/gro.c                            |  3 -
 net/ipv4/af_inet.c                        | 44 ++------------
 net/ipv4/tcp_offload.c                    | 73 ++++++++++++++++++-----
 net/ipv4/udp_offload.c                    |  2 +-
 net/ipv6/ip6_offload.c                    | 22 ++-----
 net/ipv6/tcpv6_offload.c                  |  2 +-
 net/ipv6/udp_offload.c                    |  2 +-
 tools/testing/selftests/net/udpgro_fwd.sh | 10 +++-
 10 files changed, 97 insertions(+), 87 deletions(-)

-- 
2.36.1

