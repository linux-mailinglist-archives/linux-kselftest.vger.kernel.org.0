Return-Path: <linux-kselftest+bounces-24626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4317A134C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 09:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E64F3A11F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 08:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCE01D79A5;
	Thu, 16 Jan 2025 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="lw8uTMOp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091BA1A4F09
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737014929; cv=none; b=GzatB0asM34wTNz+aGXvqX5TbHQvbbT/tZO2sBJsrvkrp/xzUGKcFICk993nSxJTowSEhlS8VRaEHUvNL/mGbzqU2irKtmjtgh8wEuMUIC51xjGKieD6gw7fc8jUNlq/1XoQ8Zvp+16+TO+NIZLxIpbAT4Iu04GW1Uu9wU4MBHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737014929; c=relaxed/simple;
	bh=/419PxDofAsCUo/JZxu3j3vP33oHhAqgdevqSkikvxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=dacGqKcSbEtpqawBk0OKLAu5Y2NBxLXu1UMB83XmZE/2M7veNrcqtDth3imTcFjcyGwlDIZLqpoXiJLBX/fnCfVEnd6qQo9YBeXxKKsayuW068gfbNjIqX5LLf37gCVZ7Z+aBSB7oYnY2Te20C3TNGKjOgMxFCeHXj5poXRQEKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=lw8uTMOp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21680814d42so8673905ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 00:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737014927; x=1737619727; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2j5vDk29ORNIvTpV6DoLsO8UQi3lrdzW7BTzShujmAk=;
        b=lw8uTMOpTkm4B4EoWgnbIJEelz40uuijEG50q9xu6lflQ+4iXefIfdUM2YJ0qf5xUW
         fgd88W+H7aokI2/bvZAJ0vSTU2Nk2GhjVEqAnabxKohA12Ck9JDUCa0sMwVM7YqUFsWX
         loSdgtZOyCEhTWrTl7GtqDgMIwSfgpLnmylkB2AoKkVJ2YnZgjvd3VzeibSW4BBSe1F4
         U0nmiIdz9BHUYo39c6oqkzVTahCUrR3JCQ6P6pygkUv9RROg0AsMUw9Gbf20FusztbJb
         4OSuVecofsfme1NgOZFuZzQpTNlUZF02rbItVEUTBxu2lZcqVsznzkDMOB65Q6wb0NaC
         hXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737014927; x=1737619727;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2j5vDk29ORNIvTpV6DoLsO8UQi3lrdzW7BTzShujmAk=;
        b=WvfFsNhYw94Ekt1Ud2tOPTec6O1uprtXiMPGYk6NAp6zq6/Jgg27dpJshB67aNlbxV
         cIJu71kUTQ3Ov7X1dc3BMP3EPT8xm1a8OTqVQ/tudPXdq9wXv8FAKeYClo49GkuIGeL8
         RtJuH9BMN2W4BXtIM65PbDW4PjCJaLw7JVDWvAqZmjY9n3aHs8obQz+W9PWlHZc2p8zU
         E4eS7DGLXa+0OVAeKdzSOmosJ5owSaIiX3WoP/KSm5v7wOfpZKRXhhO60Aqj+IPnBKA2
         iNPiAjImP2hm/Dn1tI2IC6tNSlOKo3IR2bIALp0NDakJxWS3oTrzTuajobr5SoteOgrw
         eIFA==
X-Forwarded-Encrypted: i=1; AJvYcCV8kOlRG5NOL+4mVwSrBtHMY532abWEbQeak4id40NOQWT2iNyPn/iyUmpuwTRuXn3W/PFvNMIE4VPT6h8eCBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFFAS1LCqjFm6L9/Nhngo8c8mIjv+cX7n0WBOAnqwAuGqaAVg6
	mUfNBVhh57iJNnCBByKficxJ5lblGgza0o0wBQ0o5nYpxBZnjfXFAVzilkZeIv4=
X-Gm-Gg: ASbGnctCrST2ylH8U7SdOAzjiPX9fAqMjSaTPZ6Cx8L6R9QPuo4yB8gNMYrVpUNchqE
	fsrcBPtLf+SQoOVI3zryjFmElunouaXKeUSJfeUcNkzyL+82LH+HnY6YCSVZFq7+voprHi0Ktsw
	xSTwBqjcwpVuUvf2pXwIZsZB/rRIdnN2OELsNepvHv+7+HAUGSx+siYtw4Ee2bZbYfjs+EYre3S
	bK4fvRhhmSiqQltML2kc8XJ5SsmER7JOXMAp1wFL9DccVUXrdoCFw8082U=
X-Google-Smtp-Source: AGHT+IFXnY5IpJjGACI7HaxQcoaTwGb7qy2/2clnYLiMHQFPxHM1iUKDDNzZY45rgekWHJMGYf+fSg==
X-Received: by 2002:a17:902:d2d2:b0:215:a039:738 with SMTP id d9443c01a7336-21a83f42444mr517969985ad.5.1737014927403;
        Thu, 16 Jan 2025 00:08:47 -0800 (PST)
Received: from localhost ([157.82.203.37])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21a9f10ddd4sm93691125ad.39.2025.01.16.00.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 00:08:47 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 17:08:05 +0900
Subject: [PATCH net v3 2/9] tun: Avoid double-tracking iov_iter length
 changes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-tun-v3-2-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
In-Reply-To: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3

tun_get_user() used to track the length of iov_iter with another
variable. We can use iov_iter_count() to determine the current length
to avoid such chores.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 drivers/net/tun.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 452fc5104260..bd272b4736fb 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1742,7 +1742,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	struct tun_pi pi = { 0, cpu_to_be16(ETH_P_IP) };
 	struct sk_buff *skb;
 	size_t total_len = iov_iter_count(from);
-	size_t len = total_len, align = tun->align, linear;
+	size_t len, align = tun->align, linear;
 	struct virtio_net_hdr gso = { 0 };
 	int good_linear;
 	int copylen;
@@ -1754,9 +1754,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
 	if (!(tun->flags & IFF_NO_PI)) {
-		if (len < sizeof(pi))
+		if (iov_iter_count(from) < sizeof(pi))
 			return -EINVAL;
-		len -= sizeof(pi);
 
 		if (!copy_from_iter_full(&pi, sizeof(pi), from))
 			return -EFAULT;
@@ -1765,9 +1764,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	if (tun->flags & IFF_VNET_HDR) {
 		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
 
-		if (len < vnet_hdr_sz)
+		if (iov_iter_count(from) < vnet_hdr_sz)
 			return -EINVAL;
-		len -= vnet_hdr_sz;
 
 		if (!copy_from_iter_full(&gso, sizeof(gso), from))
 			return -EFAULT;
@@ -1776,11 +1774,13 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		    tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2 > tun16_to_cpu(tun, gso.hdr_len))
 			gso.hdr_len = cpu_to_tun16(tun, tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2);
 
-		if (tun16_to_cpu(tun, gso.hdr_len) > len)
+		if (tun16_to_cpu(tun, gso.hdr_len) > iov_iter_count(from))
 			return -EINVAL;
 		iov_iter_advance(from, vnet_hdr_sz - sizeof(gso));
 	}
 
+	len = iov_iter_count(from);
+
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP) {
 		align += NET_IP_ALIGN;
 		if (unlikely(len < ETH_HLEN ||

-- 
2.47.1


