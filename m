Return-Path: <linux-kselftest+bounces-25803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F7EA28450
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 07:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C73B1884E0F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 06:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3CD22838A;
	Wed,  5 Feb 2025 06:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="rQiSpLAK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E007E212FA7
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Feb 2025 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738736569; cv=none; b=Alwm8uB03Xd+KBv65LcCPdjKBQZhBsRzIOZGygMRCd9EBj7VZT07F6Ff1TfwuJ+73QlJ3bVhVEl/8OBwjUQ4eWMNzl4NQ7PlZ1wJgh4P3dOxTqYYiDEtWfVEccn6VFursiXnKl7IvwIL0ESRIpPUv6cjEOtFod4igynKbk+4cRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738736569; c=relaxed/simple;
	bh=OvIPYK+g9j4h856snHiOWJ7ZQgHA0nLVU5L7vERmbt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p4TgO1bnpwCKPq7X9pHFaHZ4ZZmdUGBgAZyjA0R39P92SCfNWzt3z1KEoGcKjPUMpfPAMy4C/Bz3UTgRc9RWMIWGQBmZLXkFz6ULFD4RvlD8IXee9NvIhhji1GTx8Olpz94L1RSzhbbH9txoExwi1zoNK2Vkqg+d1AgX5A2bhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=rQiSpLAK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-219f8263ae0so120934515ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2025 22:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1738736567; x=1739341367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c3Yb4yc3CLfLvYu/aaxzBml3Yua5P+KV0PLbqfrkL/0=;
        b=rQiSpLAKLYhgPz/Dq0zwIKV8znShlql2iGSmW+6IMuMdpGfWlQEaVwWGaP7U4lg7q5
         ZkYRyXEP4+X5CnhgHKmAccQd5+NS0mWeHh3POI6xr9dU7xPdg84T6OSWGcg0DFdjygh5
         uDUPePRXftXd9yj5jyi3FLWSZqhVN3scuyHxheP+PcRNP/NS4cYdJVRLwhn8zwTy04qQ
         OL0AinXEEcLMxrhJBwW48m2qaUsIk5JNxbceO5wn4Uq4wUzx8dk+KT9046JGI3hcqQCv
         8JjkrMRHXWvRs7OsGjLChRdrPgqw+chuT66d/4qYv/15ze0IUEBnHTLK1AisM9iAKo0k
         m0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738736567; x=1739341367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3Yb4yc3CLfLvYu/aaxzBml3Yua5P+KV0PLbqfrkL/0=;
        b=WnxLvD27CcxguthhKQHRX3xG+kEnBJvv4mg98qmjY0EL+nt/BBgPY+bTpVqVkSXekE
         ifUt9+Bb99CqeSjSwkZiZ7wg6kDkSMa/kKy/ioqoo+Ggy6T8Pu684U75rs1hl1aIMoYR
         2dc4z5UwPcNiAg3j0ZqTI6mtBrfQ0FuGHhzl1CeVCpNdljRVlydatYlk82dUT4QZj1mV
         ZzssCc9op2YoJFfhYr8qePa+jVsNupu5xGwfXCJNdxnpA6kBxLv8l6kOCqhJJlgCmff2
         QZuFT/VT071kfvswSocTuhzyi6TI5uVAGNe8i9ZF3deH5hddTvaKsoV/5u+3pkzz/+p2
         5U7g==
X-Forwarded-Encrypted: i=1; AJvYcCVEa5p/pPW5hO9Yb69YE//Qe4IqglObmvG0DPun+nUmM/rtmbgey8fTGzM2k8SpFbqzUEbrDFEbsRLWLChtO4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Bb+EVTZ7hpOCVCoOHkGADTrhbYCp/7Hz4VkBVDbIH0ezIu0b
	8TQt476N8QfTEw399WA3wixEykYsf5x7HsCZUmsSO8UDFkR/bOZ53R7qvN11b8o=
X-Gm-Gg: ASbGnctNcS51NPYbHd5WfpohfWmdVKhPbtl1U8qmNztK3zKQi0UuBQXL8f5DLgIr7E3
	YQvesLqY7TxwS+MrHOZHsn60yJn4EmkeVdYeszeEF2ySEORhehhbXv2JZZIyesHXlyf7BD1gfiH
	JsvBBsGxJYQAI3jfFbbF+15PCEEnnLmnn/pfcRJsRQ1qufiYgHnkvcKbNsZf3EqAnjRxyP+ZdX3
	bvpTvEGdmeLTu6Jwb3rcY1U4Jjut3voMgMVUfa4klcpyP7CQJpW70F+afgoMWErEqgwGkWuaWPd
	bGofpwgIR/RLHXbC1tg=
X-Google-Smtp-Source: AGHT+IGzWVq9qQMR0OtpSV0vC3qHwySYobptxhoMmB1piJ2/BjXgoNAU3mlOXjwt7ZL5XD+44dzxog==
X-Received: by 2002:a05:6a00:2e1b:b0:71e:6c3f:2fb6 with SMTP id d2e1a72fcca58-73035101c2bmr2780925b3a.8.1738736567160;
        Tue, 04 Feb 2025 22:22:47 -0800 (PST)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe6427309sm11714424b3a.43.2025.02.04.22.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 22:22:46 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 05 Feb 2025 15:22:24 +0900
Subject: [PATCH net-next v5 2/7] tun: Keep hdr_len in tun_get_user()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-tun-v5-2-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
In-Reply-To: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
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
Cc: Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.14.2

hdr_len is repeatedly used so keep it in a local variable.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/tun.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 452fc5104260fe7ff5fdd5cedc5d2647cbe35c79..9d4aabc3b63c8f9baab82d7ab2bba567e9075484 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1746,6 +1746,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	struct virtio_net_hdr gso = { 0 };
 	int good_linear;
 	int copylen;
+	int hdr_len = 0;
 	bool zerocopy = false;
 	int err;
 	u32 rxhash = 0;
@@ -1772,19 +1773,21 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		if (!copy_from_iter_full(&gso, sizeof(gso), from))
 			return -EFAULT;
 
-		if ((gso.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
-		    tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2 > tun16_to_cpu(tun, gso.hdr_len))
-			gso.hdr_len = cpu_to_tun16(tun, tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2);
+		hdr_len = tun16_to_cpu(tun, gso.hdr_len);
 
-		if (tun16_to_cpu(tun, gso.hdr_len) > len)
+		if (gso.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+			hdr_len = max(tun16_to_cpu(tun, gso.csum_start) + tun16_to_cpu(tun, gso.csum_offset) + 2, hdr_len);
+			gso.hdr_len = cpu_to_tun16(tun, hdr_len);
+		}
+
+		if (hdr_len > len)
 			return -EINVAL;
 		iov_iter_advance(from, vnet_hdr_sz - sizeof(gso));
 	}
 
 	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP) {
 		align += NET_IP_ALIGN;
-		if (unlikely(len < ETH_HLEN ||
-			     (gso.hdr_len && tun16_to_cpu(tun, gso.hdr_len) < ETH_HLEN)))
+		if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_HLEN)))
 			return -EINVAL;
 	}
 
@@ -1797,9 +1800,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		 * enough room for skb expand head in case it is used.
 		 * The rest of the buffer is mapped from userspace.
 		 */
-		copylen = gso.hdr_len ? tun16_to_cpu(tun, gso.hdr_len) : GOODCOPY_LEN;
-		if (copylen > good_linear)
-			copylen = good_linear;
+		copylen = min(hdr_len ? hdr_len : GOODCOPY_LEN, good_linear);
 		linear = copylen;
 		iov_iter_advance(&i, copylen);
 		if (iov_iter_npages(&i, INT_MAX) <= MAX_SKB_FRAGS)
@@ -1820,10 +1821,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	} else {
 		if (!zerocopy) {
 			copylen = len;
-			if (tun16_to_cpu(tun, gso.hdr_len) > good_linear)
-				linear = good_linear;
-			else
-				linear = tun16_to_cpu(tun, gso.hdr_len);
+			linear = min(hdr_len, good_linear);
 		}
 
 		if (frags) {

-- 
2.48.1


