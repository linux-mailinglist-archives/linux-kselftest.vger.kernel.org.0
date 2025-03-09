Return-Path: <linux-kselftest+bounces-28556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A16A5848F
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 14:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D8E167C18
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8751D7E21;
	Sun,  9 Mar 2025 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+KLGjIn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D198BE7;
	Sun,  9 Mar 2025 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527794; cv=none; b=DJqpd6lW/BHhgikSJo3R5Sutcm35Xes6kMXkAh1VXpThzymdXj+zPJ+s8fJWjhdTqLphF+oFFTN/yN0w2OCgNS8CBOyGp+NQVvCg+sI5tQWc1N6YoaaQmjMSvD4iP/QYf3+oIqYDtCsClSLI0A6OwVG4RexSyM6TQkNnE9ZP8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527794; c=relaxed/simple;
	bh=ptaBI1DW7fhaXym6zEru1flC4oPyvt4zqSxYkqZx+IE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QPt9cTUR8utecvL/LRwGbpY7kGEjzJ4Q2SE+2RCv7s94URwF3xOUb+mT5i9C3EXPuNg26gaeWX/ndyszXxEy6ShsJnpP5AdYvbE5aTdMQ4K37+7FUu+uaNLZkVO+5xxG5dcdgMHZZHU7Thw4ttliSOUDvCWVhD9i9KRvEnzoBCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+KLGjIn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2241053582dso44073385ad.1;
        Sun, 09 Mar 2025 06:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527793; x=1742132593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CAQ+yMYhuk11yp71sjN1dUb/qzVlg3VAKia/ThnuUfo=;
        b=H+KLGjInebF6u1pYRLVSnLZ3RaaOycSHZ/r6e7YlTHxTmp8Wgz5ByGmlbqBgEck3FX
         OOUKfxWXqhPp2TTIsxdaKIFYjNLVdn+pS2fqSsNzsgjjR7r3qhtvUXExuoQ4K20CQb5/
         fW+wz0nfZyzqCnRTGntbIQk6WFUdDxo4NOY+WRXIquyiy6UOXf9Us9vDNnir1fF5Ef9i
         7DjN6un2U3I3xUZokqN8dGJTU1jEQxB4shal4tAFyH7PIaXfVJNkd8Pml2BAOn9Gcmd2
         5GuqMkfYujc7l9ADndVlVFHUoSwFCMBiRTjO9zESTJi4nnoc1Sa8b5HSBMSZdnjFF5v2
         gazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527793; x=1742132593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAQ+yMYhuk11yp71sjN1dUb/qzVlg3VAKia/ThnuUfo=;
        b=EUM9hKW/N8NwsmnHczLPVqRxzq0S6HLz52ajNySq1x2DsW8sOrLfq43nEJtTwwpLDh
         +0InH2cvHR5g/A2hYvCzuLSDOadkQuys0RJQY5pI6Th6PCyuZ6BUPnyFVrKPZa5x2sjU
         5jK1ZxIMqB2KY1QZPkv7mYPjb0WK0q5jTYe9kOkPrj2yT79t3sz9wFANqZAE5sWskAbE
         ofZCUtAmI23SsyJzyQsCHb1Dq4+i7Ak0p+oRQGCLt4qbVF9pMyR5J9KNqPC+hWByhB+q
         Q4D5qZsHcYYSSn8Ftii3QOwUnUTfVnEXuloGDK2LUfXHORKg50DOU+xcV7PYtrD64IwO
         TolQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNvZCruCslmZXc2zRuEu6feDSO9K7lK4MCiTo1Qd4qEJHjw4kPlJNZXkbGfSMVSxR/JwURr83fuaKdkCA/9p0=@vger.kernel.org, AJvYcCWmnvP/PCXQDX+/NI3mxdaMVPNjyKnxOPsW9PO/IgtDh6/nS9fFiTy1bmzi/kRtG5I9wEnZUF6g@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/jOSEBPH2Me0Oy74doOcwfLIfwTrBVwFuUY1jwNBys8w0Db4f
	hG9UloT+HCYxiZa3iUdXsmAW4b5XFyW10VxYfw66OE7kC6Ewocsx
X-Gm-Gg: ASbGncuhSaDvBlDn2hJpuKN4Zv+R3RFTA0arZ/2Oz6bxEp28AU/c1K954NzFPxB3t+V
	VGRZDtPV7U9KFX9mVCyZmnsi3J1ILo29o0ODrvvhsW1ntIZhrLX0j55/GXHXCIcmqLVqIHqkllR
	KRaz1nkD/fCbnmx0WzWWSn0IIAUYz64kpbDB7BykitqJFCcjZp2hYD3f5g1VcHAzRV5nZgh6WdK
	Yun+ONEOiyWUn/Vjan5pOqXsLfkInFH2Lb4piXQcGPRDXlqDqMsffDxTqoPTIUkkn+tuoX7RAS3
	JiEGty7LfGiXBUryEysQ8aJbkubHnEuliw==
X-Google-Smtp-Source: AGHT+IGJFXohU7jVZ5YG/UL4bY/C+oepEFX1XDvn9VrJl6iy4lSy9dR9uGcsUX3y/jOJV7JxuPqXAA==
X-Received: by 2002:a05:6a00:c8f:b0:736:546c:eb69 with SMTP id d2e1a72fcca58-736aa9e0a95mr12267632b3a.9.1741527792587;
        Sun, 09 Mar 2025 06:43:12 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736c41dda7csm2296841b3a.85.2025.03.09.06.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:43:11 -0700 (PDT)
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
	amritha.nambiar@intel.com,
	xuanzhuo@linux.alibaba.com,
	ap420073@gmail.com
Subject: [PATCH v3 net 0/8] eth: bnxt: fix several bugs in the bnxt module
Date: Sun,  9 Mar 2025 13:42:11 +0000
Message-Id: <20250309134219.91670-1-ap420073@gmail.com>
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

The fifth patch fixes a kernel panic in the
bnxt_get_queue_stats{rx | tx}().
The bnxt_get_queue_stats{rx | tx}() callback functions are called when
a queue is resetting.
These internally access rx and tx rings without null check, but rings
are allocated and initialized when the interface is up.
So, these functions are called when the interface is down, it
occurs a kernel panic.

The sixth patch fixes memory leak in queue reset logic.
When a queue is resetting, tpa_info is allocated for the new queue and
tpa_info for an old queue is not used anymore.
So it should be freed, but not.

The seventh patch makes net_devmem_unbind_dmabuf() ignore -ENETDOWN.
When devmem socket is closed, net_devmem_unbind_dmabuf() is called to
unbind/release resources.
If interface is down, the driver returns -ENETDOWN.
The -ENETDOWN return value is not an actual error, because the interface
will release resources when the interface is down.
So, net_devmem_unbind_dmabuf() needs to ignore -ENETDOWN.

The last patch adds XDP testcases to
tools/testing/selftests/drivers/net/ping.py.

v3:
 - Copy nr_frags instead of full copy. (1/8)
 - Add Review tags from Somnath. (3/8)
 - Add new patch for fixing kernel panic in the
   bnxt_get_queue_stats{rx | tx}(). (5/8)
 - Add new patch for fixing memory leak in queue reset. (6/8)

v2:
 - Do not use num_frags in the bnxt_xdp_build_skb(). (1/6)
 - Add Review tags from Somnath and Jakub. (2/6)
 - Add new patch for fixing checksum warning. (4/6)
 - Add new patch for fixing warning in net_devmem_unbind_dmabuf(). (5/6)
 - Add new XDP testcases to ping.py (6/6)

Taehee Yoo (8):
  eth: bnxt: fix truesize for mb-xdp-pass case
  eth: bnxt: return fail if interface is down in bnxt_queue_mem_alloc()
  eth: bnxt: do not use BNXT_VNIC_NTUPLE unconditionally in queue
    restart logic
  eth: bnxt: do not update checksum in bnxt_xdp_build_skb()
  eth: bnxt: fix kernel panic in the bnxt_get_queue_stats{rx | tx}
  eth: bnxt: fix memory leak in queue reset
  net: devmem: do not WARN conditionally after netdev_rx_queue_restart()
  selftests: drv-net: add xdp cases for ping.py

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  25 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  13 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   3 +-
 net/core/devmem.c                             |   4 +-
 tools/testing/selftests/drivers/net/ping.py   | 200 ++++++++++++++++--
 .../testing/selftests/net/lib/xdp_dummy.bpf.c |   6 +
 6 files changed, 220 insertions(+), 31 deletions(-)

-- 
2.34.1


