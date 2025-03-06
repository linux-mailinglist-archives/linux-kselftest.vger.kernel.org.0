Return-Path: <linux-kselftest+bounces-28372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F0AA54394
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 08:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4552F3AFCEA
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 07:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B921C5F2C;
	Thu,  6 Mar 2025 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Epjct/qw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C11A840E;
	Thu,  6 Mar 2025 07:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245877; cv=none; b=eLScm3gAcyXaTaz0Q/tVmPstLjr1qgGo/YXB/qeQ/oGb0qcthea7eBF5fhCdDExxbOvm72cq4+i7XQFvMrGIxnS7zW6X2YmvQPK/tZyFPpU6Bj2Ec7+Zf2D0fX+NTajSm5p5z/3Fla73HbE7Dpr1PWnbI4qeBypDMpU+cQgU0n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245877; c=relaxed/simple;
	bh=P3QlUWO3B1sjb1y0/Ih+caIW3hAbskw+CWCdwAVwGas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R5Rvq1gcUF6uJsS7xea91O4SWj9cQfP2HzUdzemvv2Ksbe8XIpxwS9WMAkOt4xaZDGdP9d8xauzWc3z+XQZ1OREBN8zg04/o7GJWaNvWyKn9glMEDfhIps3oOQlJTtODrmwQ06w+yq90U75w/mPh75mEAFCvcuU0Nk6oZ0+Gozg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Epjct/qw; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fea8d8c322so811391a91.2;
        Wed, 05 Mar 2025 23:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741245875; x=1741850675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QCHNyH7HcesADLhrCnq0/Gi87OcwJV3RBMISxRC0Sn0=;
        b=Epjct/qwScL5F4dMX92trOULhMIxBxj1R3U0uKGXPp5yWn2gbCT9sOQAmQ52Ys9Hz6
         0no3vup86I4Cq2EVozyQiy/i2XOgcEFTtDUlezSA6jw3z/mESnFNUZ9O+Jf359eqAHub
         yyfraTKDz/UTfKgAszogM7USrgxkEJAPEQYdcG1d2eylOULnWhYZSM6Gy8tgQr+twMCu
         +Z8z4DFv0coN4de9rlKie7Xm/jyCijIdzy6k9AHwyPqLlU+FnZp3S0sFgz9iM7vhpPn8
         ELSYlbp/v+0tWFRW2xW6AOThrammnibMjGNH5Odkj9QQfNPUoH9vaBKO8CEjGRZR0OEI
         fxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741245875; x=1741850675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCHNyH7HcesADLhrCnq0/Gi87OcwJV3RBMISxRC0Sn0=;
        b=nM5WXI8E8klPbJeZjOiTh+DErPxWy22F7Bjo1iYOt0NfaIMJVbTiOmLHSyFDRhG2u7
         JeyzDoyjyC+R1DglBMZvYuejgiadbJNTu8r3CPGqSVFx66EfPP1EAp+zC2U8UhA4Pf3S
         dIIUHIvGDB8SJxXzG+lIJ9b1FkVFm8Uv2SXHwO5FYSMtw5A6Ng5ZwLEojkvUvle1zBmG
         9H40lrQU8gnwcbW6WkqjWlCLvfebVUhrHetPB6nNEaKaOdfVNBCYUw+5i6yg8nIlAJrq
         Js6uyhDggd20UrMQ3YRrmgaKV5Evqt4x8RrdNTsF2OQLT9nV2x2qlQn7MCuR9Ouva0+p
         m7Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUdsQv40N59iSSdurdppREmcqsfJRXmkWlKuF+HfXuzUSIAgzVpx5YifUwDsX0eOngy6qeN6qfd@vger.kernel.org, AJvYcCVmbo4KY93nAzZqlJtQoea4bFeuA2l72/29mmO+zBePde4L8ZRm6xvYmXPgo9WzKFR3fUnxnxYvUUoPzN3L4p4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ2MLQu7pUr+/VUp4W2EPTvJbLefllWBTtphcHxVssgKamF86L
	EQhac/BuP9O89wTPnO6Oofw81ZmUdv0aRbEsF0+jz6IfGQKkCI4Y
X-Gm-Gg: ASbGncuLYhT6AoZp2imVx1RNsr5pQdDBNksEToiMgwp8s/OPca/Wcf8fauSFQXfmt+O
	+xYellycLG2uxseOBWX5XO648RZFLq77W8+vm+ywnxO41fjZX+gGLVwJkPVWzYIjv47wNRagfAH
	X6nkrvsZegGx083agDl+bsRluO7OkhDjEnhZ8nlYT5nfIvS/bc4Nr6gplxeb0ZEy8q+KbPWOVgI
	hT6MldaokR6paxv4ygD90dLZ1GhD1gebZSZb5rD9V0G38zlaCXyupEwzjvuF+2JYe9IwGDae11W
	3Uyxf4KIwAVm2vh/+3sDuCpsG8njl+5skQ==
X-Google-Smtp-Source: AGHT+IEAsfYMQU2UZb6sCiDqapBRWchcb6f9ZPKQ69qiv0IU4yBW7a8wZA7NtVd6z2K2if1Rtfs2ow==
X-Received: by 2002:a17:90b:1c06:b0:2fe:b8ba:62de with SMTP id 98e67ed59e1d1-2ff498244f7mr9998319a91.25.1741245875085;
        Wed, 05 Mar 2025 23:24:35 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693534f8sm567196a91.17.2025.03.05.23.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 23:24:34 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: almasrymina@google.com,
	asml.silence@gmail.com,
	willemb@google.com,
	kaiyuanz@google.com,
	skhawaja@google.com,
	sdf@fomichev.me,
	gospo@broadcom.com,
	somnath.kotur@broadcom.com,
	dw@davidwei.uk,
	ap420073@gmail.com
Subject: [PATCH v2 net 0/6] eth: bnxt: fix several bugs in the bnxt module
Date: Thu,  6 Mar 2025 07:24:16 +0000
Message-Id: <20250306072422.3303386-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first fixes setting incorrect skb->truesize.
When xdp-mb prog returns XDP_PASS, skb is allocated and initialized.
Currently, The truesize is calculated as BNXT_RX_PAGE_SIZE *
sinfo->nr_frags, but sinfo->nr_frags is flushed by napi_build_skb().
So, it stores sinfo before calling napi_build_skb() and then use it
for calculate truesize.

The second fixes kernel panic in the bnxt_queue_mem_alloc().
The bnxt_queue_mem_alloc() accesses rx ring descriptor.
rx ring descriptors are allocated when the interface is up and it's
freed when the interface is down.
So, if bnxt_queue_mem_alloc() is called when the interface is down,
kernel panic occurs.
This patch makes the bnxt_queue_mem_alloc() return -ENETDOWN if rx ring
descriptors are not allocated.

The third patch fixes kernel panic in the bnxt_queue_{start | stop}().
When a queue is restarted bnxt_queue_{start | stop}() are called.
These functions set MRU to 0 to stop packet flow and then to set up the
remaining things.
MRU variable is a member of vnic_info[] the first vnic_info is for
default and the second is for ntuple.
The first vnic_info is always allocated when interface is up, but the
second is allocated only when ntuple is enabled.
(ethtool -K eth0 ntuple <on | off>).
Currently, the bnxt_queue_{start | stop}() access
vnic_info[BNXT_VNIC_NTUPLE] regardless of whether ntuple is enabled or
not.
So kernel panic occurs.
This patch make the bnxt_queue_{start | stop}() use bp->nr_vnics instead
of BNXT_VNIC_NTUPLE.

The fourth patch fixes a warning due to checksum state.
The bnxt_rx_pkt() checks whether skb->ip_summed is not CHECKSUM_NONE
before updating ip_summed. if ip_summed is not CHECKSUM_NONE, it WARNS
about it. However, the bnxt_xdp_build_skb() is called in XDP-MB-PASS
path and it updates ip_summed earlier than bnxt_rx_pkt().
So, in the XDP-MB-PASS path, the bnxt_rx_pkt() always warns about
checksum.
Updating ip_summed at the bnxt_xdp_build_skb() is unnecessary and
duplicate, so it is removed.

The fifth patch makes net_devmem_unbind_dmabuf() ignore -ENETDOWN.
When devmem socket is closed, net_devmem_unbind_dmabuf() is called to
unbind/release resources.
If interface is down, the driver returns -ENETDOWN.
The -ENETDOWN return value is not an actual error, because the interface
will release resources when the interface is down.
So, net_devmem_unbind_dmabuf() needs to ignore -ENETDOWN.

The last patch adds XDP testcases to
tools/testing/selftests/drivers/net/ping.py.

v2:
 - Do not use num_frags in the bnxt_xdp_build_skb(). (1/6)
 - Add Review tags from Somnath and Jakub. (2/6)
 - Add new patch for fixing checksum warning. (4/6)
 - Add new patch for fixing warning in net_devmem_unbind_dmabuf(). (5/6)
 - Add new XDP testcases to ping.py (6/6)

Taehee Yoo (6):
  eth: bnxt: fix truesize for mb-xdp-pass case
  eth: bnxt: return fail if interface is down in bnxt_queue_mem_alloc()
  eth: bnxt: do not use BNXT_VNIC_NTUPLE unconditionally in queue
    restart logic
  eth: bnxt: do not update checksum in bnxt_xdp_build_skb()
  net: devmem: do not WARN conditionally after netdev_rx_queue_restart()
  selftests: drv-net: add xdp cases for ping.py

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  36 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  18 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   6 +-
 net/core/devmem.c                             |   4 +-
 tools/testing/selftests/drivers/net/ping.py   | 200 ++++++++++++++++--
 .../testing/selftests/net/lib/xdp_dummy.bpf.c |   6 +
 6 files changed, 221 insertions(+), 49 deletions(-)

-- 
2.34.1


