Return-Path: <linux-kselftest+bounces-34034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F942AC877B
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 06:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C38188C130
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 04:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07022116F0;
	Fri, 30 May 2025 04:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="br4sWy7K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC4120E6F9
	for <linux-kselftest@vger.kernel.org>; Fri, 30 May 2025 04:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748580641; cv=none; b=sx2PxhqaaEmn6xxicp/7lifl/Frw2uUfyOKH25ym25ecGetvivZq6ihiwp9jhC3QVubYGTijKw306VE3B0qLqHEXQsxxVyykhShwhSvprvbNB5dsONEeUKekOc1KsUArap0aZ0mxodMsj84ACQpGJJATj3dkFOvlIQmuJTJgL5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748580641; c=relaxed/simple;
	bh=z6KshIl6HGgt4ZleKE35r87QcaFqdHr3p/xqcA1UR5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=rL9PK3QmEexJt7L+F7c6mfYjGEU9M4UCk+JKRFCoaSIRE6OkpO2w/+9knnEzF8HITgugj9chwSRXy1jEsMhxhdC5BVZCQj70A4CQRa9ol8TL8jJGxK4wxMqTZCnsdmqxZVQmuTztVxKsOlYT6922dJvov3jGGCqgNfyMqJWyHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=br4sWy7K; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-231e8553248so16336795ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 29 May 2025 21:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748580639; x=1749185439; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NOE/sRdLPMAnoL0j8jc6LLcC7i1+AiTcrUdSGiZf/w=;
        b=br4sWy7KqNVoAgmcfCZJRLKTceBgSCS3Ojitq6wElltSfRuLU1olzE7rjNrzZ37fMG
         M9JdZpXgGc3qHrXSVASAuFp8aPiCuwnqde3PWJW2Q7iEnwY8LaQATGX9XcHJQ2pbSdlo
         1Lry4qaLIhiFZUtFSjRUpQvhH5Fvi+TNQNo5ABN6uhXH916k67P6jgKZnGzUZtgpJBtn
         +DZKsITiQOcROBxpM1cCjX11Ag0B0jyNRKxb1zlmb61dHNfWEw3sKdU/waD414CmZVqe
         YNmnpKlnH2MQp1Kq8z7GKWGuWk32hLhaoxbHjm+E8Y7Db9kuKYt8fzwXbH4KrXIJWWPv
         sOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748580639; x=1749185439;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NOE/sRdLPMAnoL0j8jc6LLcC7i1+AiTcrUdSGiZf/w=;
        b=ghTlky/cBoRp+6fS/tl98LItdqc1NgaRkhd/xZIc2e/i3HkNAOGCr6fFrb74Qy0cvP
         0jev6IpyAKUWsnsKfujM8ne0OVD+m6gJw8XuNllk6zSIkqpg+FjEcyTfu4TJIn7JEt5r
         myTQUaDryqI2yHnTZxErkx+O2BDyKW1SNkZ2yUErs+ViKEU1cuEbBhSZCuMY6PsVadJ8
         H79MupuWfzJ/XnXxw+iBNH9iow1aRlv/Tad2pWCcaDBYN3pHGtNmcCncf0iR7DNR77cG
         OQkGW+Zo3CKC9yFq/sxU2352NA43Fou3fuU7coVOM5/EP4jgNv5OM3m4KgnMMe32R0Qt
         cJ3w==
X-Forwarded-Encrypted: i=1; AJvYcCWPACGGtuiHole3Rpo/dyUVOfiLbcWBfaKOEQDc8OZP/Tw5nl1eHhdwd0nrCLKNH9qvSdGG2TKxSSfvhQWDmy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjQlPCcK0dXoz9IN/Xxg53bMW/NBKblcv8saF+cXOrh0Vz+d5+
	jYhHtXOGTbxM39ubDEC4qKlSG3NA06BcwzZ4YZHEbimyJGdwld1XC75N0UujC7o1NJk=
X-Gm-Gg: ASbGnctquSGxliUoeNOuHe7SyRTjN/+LgUf5GXFdyYwn5UPoiBT+JUVnMLN+MtXx6of
	v9BYz0iJ+Re0S4tep+JdRjnvkLEnVauwnf8wNKoVg/2wVkfEg9X6/xcu7/GEL+AyAEhEt4g+HK1
	WvTQqEDzKf++bw/D0Y0gVyIYr/6keQ1RfCTiUovD76F8D5WREjtxp85r5UOTrwT24KXJKm0V/q6
	ux0TXMUJfZKOH507bqYI9mRiy0JZNHFa+6V2ZUKxo6i03AsvqxoPE5T6K6k4WV1O5KZENAwQcCq
	Jdr+eC3axsk4S9HDTGbmkYqrWjyaAKPWYXNFV1uS1HflhdIiuzIa
X-Google-Smtp-Source: AGHT+IEeXcvMFrg0nyBJT3UCjMm5zR9avBrulDbs9crdoWtGa6Ob/x7/c2QyfE4WnvmKLh1jLX4/8w==
X-Received: by 2002:a17:903:2f89:b0:234:eb6:a35b with SMTP id d9443c01a7336-235396e2b3amr13431015ad.44.1748580639345;
        Thu, 29 May 2025 21:50:39 -0700 (PDT)
Received: from localhost ([157.82.128.1])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23506cf9181sm20055655ad.187.2025.05.29.21.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 21:50:39 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:50:07 +0900
Subject: [PATCH net-next v12 03/10] tun: Allow steering eBPF program to
 fall back
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-rss-v12-3-95d8b348de91@daynix.com>
References: <20250530-rss-v12-0-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-0-95d8b348de91@daynix.com>
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
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

This clarifies a steering eBPF program takes precedence over the other
steering algorithms.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 Documentation/networking/tuntap.rst |  7 +++++++
 drivers/net/tun.c                   | 28 +++++++++++++++++-----------
 include/uapi/linux/if_tun.h         |  9 +++++++++
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
index 4d7087f727be..86b4ae8caa8a 100644
--- a/Documentation/networking/tuntap.rst
+++ b/Documentation/networking/tuntap.rst
@@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it::
       return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
   }
 
+3.4 Reference
+-------------
+
+``linux/if_tun.h`` defines the interface described below:
+
+.. kernel-doc:: include/uapi/linux/if_tun.h
+
 Universal TUN/TAP device driver Frequently Asked Question
 =========================================================
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d8f4d3e996a7..9133ab9ed3f5 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -476,21 +476,29 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
 	return txq;
 }
 
-static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
+static bool tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb,
+				  u16 *ret)
 {
 	struct tun_prog *prog;
 	u32 numqueues;
-	u16 ret = 0;
+	u32 prog_ret;
+
+	prog = rcu_dereference(tun->steering_prog);
+	if (!prog)
+		return false;
 
 	numqueues = READ_ONCE(tun->numqueues);
-	if (!numqueues)
-		return 0;
+	if (!numqueues) {
+		*ret = 0;
+		return true;
+	}
 
-	prog = rcu_dereference(tun->steering_prog);
-	if (prog)
-		ret = bpf_prog_run_clear_cb(prog->prog, skb);
+	prog_ret = bpf_prog_run_clear_cb(prog->prog, skb);
+	if (prog_ret == TUN_STEERINGEBPF_FALLBACK)
+		return false;
 
-	return ret % numqueues;
+	*ret = (u16)prog_ret % numqueues;
+	return true;
 }
 
 static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
@@ -500,9 +508,7 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 	u16 ret;
 
 	rcu_read_lock();
-	if (rcu_dereference(tun->steering_prog))
-		ret = tun_ebpf_select_queue(tun, skb);
-	else
+	if (!tun_ebpf_select_queue(tun, skb, &ret))
 		ret = tun_automq_select_queue(tun, skb);
 	rcu_read_unlock();
 
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 287cdc81c939..980de74724fc 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -115,4 +115,13 @@ struct tun_filter {
 	__u8   addr[][ETH_ALEN];
 };
 
+/**
+ * define TUN_STEERINGEBPF_FALLBACK - A steering eBPF return value to fall back
+ *
+ * A steering eBPF program may return this value to fall back to the steering
+ * algorithm that should have been used if the program was not set. This allows
+ * selectively overriding the steering decision.
+ */
+#define TUN_STEERINGEBPF_FALLBACK -1
+
 #endif /* _UAPI__IF_TUN_H */

-- 
2.49.0


