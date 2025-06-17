Return-Path: <linux-kselftest+bounces-35166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01D0ADC0AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 06:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6873B72A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 04:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4779523BF9F;
	Tue, 17 Jun 2025 04:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uq9jUamM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE27A23B618;
	Tue, 17 Jun 2025 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134778; cv=none; b=f8wEC9sAkcqP2J0B0wqQ1GaQoPRDDvy84ZJ4/Shta+N0LKZxBBOapuuQtwQKQNqAYwXVjvDjZZpLOx30rdLWuAvoKU6FXkGcl2iqitlyCMHnBtYbwxRZBNRRd8erBw8/az9NoeDP7tvyLclYtoSFI9Pigq8VBCwLJtdZEmj17F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134778; c=relaxed/simple;
	bh=XMTDR15bVq1YCZLijwAIRIhb0QtK2FVowursT7gd180=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CTgjYLLZ36VOJFSfnMKMdJk0CpH/rNK7Y5Tbi6o/ffvK1k6LbOW+ZHmfc5J/bfm4AKyKGSX0gT65WSP21y2qOFmPkHbcxZCa1l1T7Z8r3lxmijdsUmTWgsYCxgU5T5/0UG/V+L4UeX3d+/r0ue0LyHVA/8LXJul60WTUuL3vdFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uq9jUamM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234c5b57557so49830925ad.3;
        Mon, 16 Jun 2025 21:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750134775; x=1750739575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n7GRFjLCtYMBnTd1HWFkFToBtNX7DzGE0tByfQl3zSM=;
        b=Uq9jUamMGvhRPIjGl/e5Rb6t52mYBqHhP9umumaf0O/fm0F+ZCiTclYWnGY3nZ87Ku
         YFXbTLc9GRXkjQYtBoN6qr2pLgDJwSBnuCfXXLUwEf4S4oMmx9JsVDh/z1OKJE9pvsWt
         PnAzCGrBOheiR6JMaIyDWqwf4fAhwA1UcAUMLTIs8sbiMytrVCiaKldtbwv2Q/VVnyTO
         0nYbLGHo4eApeC/D9pGlKQ8Hr/bcN8ziaKCgcjy4eVJLjm24wm34zla57HVOLlMqp/Lz
         N5VBOYTf726BXbhDrlQjRPMZyDHVuy/xdagKBUfgsD4hJFMrW6CJNU/efTEpIdEKgSqF
         Vurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134775; x=1750739575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7GRFjLCtYMBnTd1HWFkFToBtNX7DzGE0tByfQl3zSM=;
        b=lLWEr9rkCanTyiciJ99gV2e0SL/+bzDTtGjR4yAkuZe+HFoE81uAsLZ+JFvtmRRmPN
         vAg1cx6P6DiepHQQXQdUYAlpP3kE1KSAN8c6jjvw4huQ1VPtURcf2ECu68dIqHzFUJGi
         5bXhk5ELLh497h9WjZ93ydPEmQwtD1u5qv9bYfLPNv4skrzx4D0X4AFR0MitvY8tor8U
         SuGxvExNMLWZRKthrHfzeyOxYWtsX6Qi25xcRXzh7s8AmybKSAIkddQTMShogz1T7z/o
         HgFtNFxiPcDuZEbywRltz0BOgAcKkRUqa06JDpqwI/xjLSWzhoDD6DGzopLWwCfM5Deq
         jfmw==
X-Forwarded-Encrypted: i=1; AJvYcCWEzktHeX9/HW8MShql2QeUagkZuTSZawpCT56XOCDwfYkwfnMtiISXzqWPxPKIhdU5odWghIS7B0n7UUBuPkvA@vger.kernel.org, AJvYcCWJSA6WM7rgIgKvtwEqApOmMLDLqv7ICl4ZO4lnevdly+rvb/YEVSb3l/9c7Cp1dln19Uo3jk1o@vger.kernel.org, AJvYcCWyIpZWimsOi9hXD7ZJfbkOoAbCalE6E52ZWzQI+bJwl1Y9iuVxe0NvuyVHhrmywTiZq6/vODJD2lXO9H4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqp5NMnuWRFp09qXCXkyozWz68VE8AdYMUNFpzjIWr3qrJ7tmv
	NuMZFUfVUAfzbt1TaKAHhHM5wFs8s3GahRkmHUvfk7Up/Kp/CPSgyZkOoFhdRmgh
X-Gm-Gg: ASbGncudj/mbqPyjGgMm6m3tqccQLlUQsYHqFbrXzMcM2swgnQUid5WC4Rlakjhotx0
	SugjL7/1UpTopGo91qLT+03r74H6GwAMCB06OSlozVTbVQyRheL87B7l7zT0NjnvXu2V5ih6v5s
	Yhn35uDId2CMotJcNfceRueugCH/57oSXw0upjfbJm3Xc8mfCPP4euIw89jueWg9s7PrR+FyXGu
	etcZ3iOOKj00mHR5ndSi50X6ijl1X5K9+6BZjgAEfc3NWPfHevSGy5fdxP+Gxy0KutTD6PjHIzN
	5qtD4FJ7PN9FujncdYzeggGoUwhcItO4O7YmB2YHTSQtKpZ7IZLcXxURk4o=
X-Google-Smtp-Source: AGHT+IF23dOLSSVd/bkPFQcDWGiYXTfx0Wmn0PL/ratRnnqT9FQS95X0J9Qb/FnCqL00zJlKlQ2idQ==
X-Received: by 2002:a17:90b:3fcd:b0:312:e445:fdd9 with SMTP id 98e67ed59e1d1-313f1cc51demr19790632a91.10.1750134775296;
        Mon, 16 Jun 2025 21:32:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19b826asm9622012a91.3.2025.06.16.21.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 21:32:54 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Jun 2025 21:32:51 -0700
Subject: [PATCH RFC net-next v4 02/11] vsock: a per-net vsock NS mode state
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-vsock-vmtest-v4-2-bdd1659c33fb@meta.com>
References: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
In-Reply-To: <20250616-vsock-vmtest-v4-0-bdd1659c33fb@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the per-net vsock NS mode state. This only adds the structure for
holding the mode necessary and some of the definitions, but does not
integrate the functionality yet.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 MAINTAINERS                 |  1 +
 include/net/net_namespace.h |  4 ++++
 include/net/netns/vsock.h   | 19 +++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 507c5ff6f620..bf9015498854 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26149,6 +26149,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/vhost/vsock.c
 F:	include/linux/virtio_vsock.h
+F:	include/net/netns/vsock.h
 F:	include/uapi/linux/virtio_vsock.h
 F:	net/vmw_vsock/virtio_transport.c
 F:	net/vmw_vsock/virtio_transport_common.c
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 025a7574b275..005c0da4fb62 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -37,6 +37,7 @@
 #include <net/netns/smc.h>
 #include <net/netns/bpf.h>
 #include <net/netns/mctp.h>
+#include <net/netns/vsock.h>
 #include <net/net_trackers.h>
 #include <linux/ns_common.h>
 #include <linux/idr.h>
@@ -196,6 +197,9 @@ struct net {
 	/* Move to a better place when the config guard is removed. */
 	struct mutex		rtnl_mutex;
 #endif
+#if IS_ENABLED(CONFIG_VSOCKETS)
+	struct netns_vsock	vsock;
+#endif
 } __randomize_layout;
 
 #include <linux/seq_file_net.h>
diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
new file mode 100644
index 000000000000..ea14b46ed437
--- /dev/null
+++ b/include/net/netns/vsock.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_NET_NAMESPACE_VSOCK_H
+#define __NET_NET_NAMESPACE_VSOCK_H
+
+#include <linux/types.h>
+
+// TODO: rename to VSOCK_NET_* ?
+#define VSOCK_NS_MODE_GLOBAL	1
+#define VSOCK_NS_MODE_LOCAL	(1 << 1)
+#define VSOCK_NS_MODE_INVALID	(~0)
+/* VSOCK_NS_MODE_WRITTEN_ONCE indicates "write-once" write has occurred */
+#define VSOCK_NS_MODE_WRITTEN_ONCE	(1 << 7)
+
+struct netns_vsock {
+	struct ctl_table_header *vsock_hdr;
+	spinlock_t lock;
+	u8 ns_mode;
+};
+#endif /* __NET_NET_NAMESPACE_VSOCK_H */

-- 
2.47.1


