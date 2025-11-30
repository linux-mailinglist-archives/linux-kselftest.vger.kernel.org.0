Return-Path: <linux-kselftest+bounces-46768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0C2C95640
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 00:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7713A1EAB
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 23:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6082E542A;
	Sun, 30 Nov 2025 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4f8V7nv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D3823ABBF
	for <linux-kselftest@vger.kernel.org>; Sun, 30 Nov 2025 23:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764545733; cv=none; b=q49yeN5FjMZslLdpG8v4ZXIN8G9cTjEys3x0xeyTq5R9/ca7E7uI8HzNQAnkIDfRS+V0Fob2k9CQEM3/xN8yZ2Af4CX6ujAux9DsNpV5ioyOyOrZwg+RVTotxs+JRTU6d2d2pwYJrjabDV+wDyBYJ6GX4oXNQElEMRcYYDh/o7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764545733; c=relaxed/simple;
	bh=avO1UeedN/STJoSnCOQ5Xr9OSRYW37NwH27coYDpseQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pwii+ufbryclHx5NNEc6Hj5QovOXwatQi0yjJyj7UBzMTgleehoROzLKhcIyfnaVMJn9n0ABBOlcdCMIFwNiqRvzREGwvqfOtYnBTZOoyGhakPxl3sP5QzUdaHGRjYoqeLIj+Q4x4a3cPchfUPukp390KJIoDV4UE42U0bzXFYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4f8V7nv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso21139795e9.2
        for <linux-kselftest@vger.kernel.org>; Sun, 30 Nov 2025 15:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764545730; x=1765150530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ALyiArP9r0l0ZpA0zLf3NyzsTN9+4HjumhR11AEukHk=;
        b=h4f8V7nvPWWoMVa68CRM2LO+qo+XByujMWOZ5O7binnC5OBl2uVh5CRq/ZxhwA4pOJ
         sVBFdhnPUKGj/49+CrUa+p7MbZ2MVV2jHG6tZr7QZei1fe6iHaq8nqGdoIYItbAQ0Ht/
         Gvy7nSwxZJWiC4kBX6IBd0swsU33v6O7We9GUk2bV60PJ/jCgeCKPb7VaCPYoJRYNmsC
         SfeKrHsavZTmfhwxjfpJLXLM3eNE2JOQ2Yenhgyy7+52FQl7aRyNqatsSmqmDVuOZ6l+
         IcAP0hxvk+nhGJDPI5NYBv19nBce+1ytyN/4KYgeNq+qmV0ttr8VpQ3YDIuGQDSi1aBz
         wJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764545730; x=1765150530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALyiArP9r0l0ZpA0zLf3NyzsTN9+4HjumhR11AEukHk=;
        b=op1AZGke5mS7TviuLIkV/etBm97fV4sld7MSpml2JtmT0scRQS2r5DCl17rXkS+n4+
         NIBUQMmCTid4AKycfjWZ9tNe4/+iw7D1e7STl/Y2T7RJmnrefVW4+v9GOaOi3UwMkKJw
         AUbFgACl8unwh0s/C4Eyt6/otDCV/eHjuCMgpRvwn6hBFQzmWbH96xK7yIAIaUCh9gCU
         LQ5aJiYiBF1Vy4e7X8/l3s9hhI6d/iJyt6xo87flfvvUXyEVZkWzoD0odP3QKgy4KN2m
         JlqttrtxlfHNvm0gK3fG96ShgmQI4u5V+ONxsevnhSRLt5qD3I/GEBSpeGFelPq0NcwS
         jpUw==
X-Forwarded-Encrypted: i=1; AJvYcCXVWCwdF/n7Hkt4IfHL4ox42CEEvnH34ANTWWxxgiUrL816G52hrnLZ7RKzigTVjCztlWF7vrYWPk+1SBqhUy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ1lveGzrfvtLWko67e/0Ui8yaCRcG0DFjMsGrgvSChMC58Gnp
	VYLlXRFt4XsXHn7K14+fJcxCvzFcGgDwtC/RVi8kyctAX5wWc4A6spIC
X-Gm-Gg: ASbGncuGXguCK7sDkeAUn8GUxQ3tf5TRgZ3Tn5b6sa91e6WUI4hjaYuOmUWz0qpSQfc
	hIrN4bDmw7Xogz9tus63QK+Pwyi0ZxDBndgMjAj8ASIRKlHZ19JVpLXNUClzhdBT3jFgeJ+do/J
	qm0bRSN0giNzOyjuk80ETuaQZsk55QzuwuzpfILeZuwJvsOYZ0QCdYF4rDU2fT1p03wvD8rsKin
	CbEZeaiBk1hJTIoQweMxfatUBXKFgF0g2JLVrRK93YdDu2sDuRAe2CBMA+1qKBBV2743j4kzCZw
	gr3x3nFjtpRhnEP21JoW4P8P/RzG3IOIsUZJLp9dxilfZNB7pAaQFXe0eZ+S+QizVvA/CWVlbpU
	uQzWfPnchV+PLiyOrdL55ThocUvSyIbdpOVKr1IHCzFv929U+po8DC735zGVGj0EOgmIAhFaL60
	Ba1kXQXX+dPKehUJhjPL6/gVUYOQouhthhJIRVLGqMwNqM77zhc4kAxdTeLfTuPDsWquZ6Fht7e
	BCsHwHwvhR5A+M4
X-Google-Smtp-Source: AGHT+IEsn3y7t81hF2sQhBQPO/kczdL3fkFMA/jNBZwT0LAhZBVzEYImw+yrGW7ekTwLlt8XRlDFBQ==
X-Received: by 2002:a05:600c:1d0e:b0:477:89d5:fdb2 with SMTP id 5b1f17b1804b1-477c017d9damr362894825e9.14.1764545730116;
        Sun, 30 Nov 2025 15:35:30 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040b3092sm142722075e9.1.2025.11.30.15.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 15:35:28 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yue Haibing <yuehaibing@huawei.com>,
	David Wei <dw@davidwei.uk>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Joe Damato <jdamato@fastly.com>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	dtatulea@nvidia.com
Subject: [PATCH net-next v7 0/9] Add support for providers with large rx buffer
Date: Sun, 30 Nov 2025 23:35:15 +0000
Message-ID: <cover.1764542851.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note: it's net/ only bits and doesn't include changes, which shoulf be
merged separately and are posted separately. The full branch for
convenience is at [1], and the patch is here:

https://lore.kernel.org/io-uring/7486ab32e99be1f614b3ef8d0e9bc77015b173f7.1764265323.git.asml.silence@gmail.com

Many modern NICs support configurable receive buffer lengths, and zcrx and
memory providers can use buffers larger than 4K/PAGE_SIZE on x86 to improve
performance. When paired with hw-gro larger rx buffer sizes can drastically
reduce the number of buffers traversing the stack and save a lot of processing
time. It also allows to give to users larger contiguous chunks of data. The
idea was first floated around by Saeed during netdev conf 2024 and was
asked about by a few folks.

Single stream benchmarks showed up to ~30% CPU util improvement.
E.g. comparison for 4K vs 32K buffers using a 200Gbit NIC:

packets=23987040 (MB=2745098), rps=199559 (MB/s=22837)
CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
  0    1.53    0.00   27.78    2.72    1.31   66.45    0.22
packets=24078368 (MB=2755550), rps=200319 (MB/s=22924)
CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
  0    0.69    0.00    8.26   31.65    1.83   57.00    0.57

This series adds net infrastructure for memory providers configuring
the size and implements it for bnxt. It's an opt-in feature for drivers,
they should advertise support for the parameter in the qops and must check
if the hardware supports the given size. It's limited to memory providers
as it drastically simplifies implementation. It doesn't affect the fast
path zcrx uAPI, and the sizes is defined in zcrx terms, which allows it
to be flexible and adjusted in the future, see Patch 8 for details.

A liburing example can be found at [2]

full branch:
[1] https://github.com/isilence/linux.git zcrx/large-buffers-v7
Liburing example:
[2] https://github.com/isilence/liburing.git zcrx/rx-buf-len

v7: - Add xa_destroy
    - Rebase

v6: - Update docs and add a selftest

v5: https://lore.kernel.org/netdev/cover.1760440268.git.asml.silence@gmail.com/
    - Remove all unnecessary bits like configuration via netlink, and
      multi-stage queue configuration.

v4: https://lore.kernel.org/all/cover.1760364551.git.asml.silence@gmail.com/
    - Update fbnic qops
    - Propagate max buf len for hns3
    - Use configured buf size in __bnxt_alloc_rx_netmem
    - Minor stylistic changes
v3: https://lore.kernel.org/all/cover.1755499375.git.asml.silence@gmail.com/
    - Rebased, excluded zcrx specific patches
    - Set agg_size_fac to 1 on warning
v2: https://lore.kernel.org/all/cover.1754657711.git.asml.silence@gmail.com/
    - Add MAX_PAGE_ORDER check on pp init
    - Applied comments rewording
    - Adjust pp.max_len based on order
    - Patch up mlx5 queue callbacks after rebase
    - Minor ->queue_mgmt_ops refactoring
    - Rebased to account for both fill level and agg_size_fac
    - Pass providers buf length in struct pp_memory_provider_params and
      apply it in __netdev_queue_confi().
    - Use ->supported_ring_params to validate drivers support of set
      qcfg parameters.

Jakub Kicinski (1):
  eth: bnxt: adjust the fill level of agg queues with larger buffers

Pavel Begunkov (8):
  net: page pool: xa init with destroy on pp init
  net: page_pool: sanitise allocation order
  net: memzero mp params when closing a queue
  net: let pp memory provider to specify rx buf len
  eth: bnxt: store rx buffer size per queue
  eth: bnxt: allow providers to set rx buf size
  io_uring/zcrx: document area chunking parameter
  selftests: iou-zcrx: test large chunk sizes

 Documentation/networking/iou-zcrx.rst         |  20 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 118 ++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   2 +-
 include/net/netdev_queues.h                   |   9 ++
 include/net/page_pool/types.h                 |   1 +
 net/core/netdev_rx_queue.c                    |  14 ++-
 net/core/page_pool.c                          |   4 +
 .../selftests/drivers/net/hw/iou-zcrx.c       |  72 +++++++++--
 .../selftests/drivers/net/hw/iou-zcrx.py      |  37 ++++++
 11 files changed, 236 insertions(+), 49 deletions(-)

-- 
2.52.0


