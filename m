Return-Path: <linux-kselftest+bounces-40122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B64B38FDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 02:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A069803AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E011CEAD6;
	Thu, 28 Aug 2025 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0J8smbi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65BD19ABC6;
	Thu, 28 Aug 2025 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341097; cv=none; b=UcN23U84rr+Bik18M8XejGU8eczEhiL2Te2lDV1EdOQi3uaQZTHp8aAfnEDoXXyrHP+9M+5jxcOOghNGfUIb+GF2DAeXVIFYGNtac143qyFuij+aavEc+VZuico66c0D7+bPRVsg3r7JXqT06/4scgxDnZ349Ay4nzeSXqt2ay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341097; c=relaxed/simple;
	bh=z+sr6MdX8qILdTTvivuBLqgcZDE/1O6PGveEjKKmkI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CUiYeq9MPkwN11+iFytA9Zp6cubDcnKnpkQLA8m8KjmVTA0B0BEmKnyAY2geCecEQCauI11DPCSjDjM7OB8VfpgWtAd3c2yirbwmBgEu+KXobahRMuWA7JmIcBGy3fIp0EWygjPox+PitlJUMmEam2dzg32fzIZnMxP1G2UVnSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0J8smbi; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so457696b3a.2;
        Wed, 27 Aug 2025 17:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756341094; x=1756945894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgPhhCZTl4chPUEyREnq+4qsbR5ADg6VFT1FXFFAJKw=;
        b=N0J8smbia3UKKOrHNQUI0UYfiQxVQ0kYa1oSrR//jG5DX7s2f+x5dC94Za+SKEdqIZ
         P7eYx4KJ6oBaWT564UzC8drIM09PNwmR/yJzx3KlE7iyoLz9D79NZaDy2ZCjq6RNICqj
         ZdgapVFJ7f8wmw1zfbL4bmyWgh9Y1Y4MtUIg2SJgVwq0bhRIBvEU4TBErNY/3d+IZB6f
         9vdftvscaNNyg7YqtrY0DePEZ1k04sy5RkKQnGzpzSGoNE6y5+H2FxUErA1euv9zhWGw
         1Hnjd33uBsPC5DO8jV4xnaCQeuaUMAUeguJ/kc5Ky1duFhss0tcxAYp2iXssEgtfz8MQ
         F2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341094; x=1756945894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgPhhCZTl4chPUEyREnq+4qsbR5ADg6VFT1FXFFAJKw=;
        b=W0OCpdj+DoBb+EjMiufbNVw/uxcGHeVuzMFllugwInxe45jeLJi4hcaVDPt741bchk
         JP7Vbg5kFuVDjff1PDSrEpZlSCvLGO3MOCfoISKdt+sclib/EiZLzkvC/ambzrvIr3GF
         bGzK/l4imiuFncAm3L1U5dn3GNjzmtsWWpLBWCgiqDspzE8YpZVNjYnuxsb1aXlOS5qA
         vdx/IF9hp2A9eM8cjkSn4HpK0oDZgrv+QR9vV4wrLqg6mocXxkGdl/1KkjcMME6n0Ady
         yXEeVHf5CydUfscCd1mbwZcuGoCeIBtWrwaGdIJP6ori0iYtryY+VD6Asqq8gMTmK67y
         XivQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1B/QzZxA+/OH2U6bZtFQuU2vTsTtbCeJZ48YoQvkNqvX3DCjXlbKgvNE6YtRxFn617yeL9sn9JceJIGSH@vger.kernel.org, AJvYcCWDBU1SVptxj705LM4ZYt27o79Lq1e9fr1XiX1cH2cP3YZQhmJIgrgJ2PpNoYXR4+2ZB4aiG5fN1X5RuyqLXt4c@vger.kernel.org, AJvYcCWkwZ5lS9YJfkcOg4st6HW0j7+0cmETxBJ7yjb16uXu7H+bt63mtjb8Q0zJ3Vu9/Z1MsMQ=@vger.kernel.org, AJvYcCXZsFKVLE+ZbgkrxQlfJ0PWfBOh8pq2PBIGwGpW1spViipkcNvUxg5/lb/hG8C/cjXcjV4nDuuS@vger.kernel.org, AJvYcCXi/N/nE7PSyPdv3fJrjazrDYdjiOR8oNfuIKKpvY1ELPsWbAaonCG1yoNo8vuHzq/2f0GopT6xZEAlEIiS@vger.kernel.org
X-Gm-Message-State: AOJu0YwklNCiC+VL8Rm44vDpnJ3de2+ziTwIAuW4nLJa2XTxdQBiBnX3
	Or/0S2yP8sAchwQEGZ4QcXOoQn3dVMW3q+1FZh7WNWPGlZuGQA172fPy
X-Gm-Gg: ASbGncvx84u41jVbxlYBZfj/z18xtKPC0oAa+PfwB1Z3pyB3QiB/djV5sGuI4sdqzzd
	NalLq5FPYkZgtohh2QxXKMThmtTHF9f2QX92JdNSZOWOvniUqgfYFR8kNkxd4eVbbKPkuAIY9s0
	6KC3LwToEqdCm4vpE8267z44YNlZU/ia9dE8ynVUZmTNWk/CVpzMyX0zkOkkJ2r654YoH/OLxvS
	DbTynAnVr8P/LhEjSrL6qwsSWxJXu3vzFJ/vVEWDnitaUoVl+xNKlKgKGAAF3eQx/j5fWYlIGkm
	O1TBMVLkB60sBymZXdVCvgWjO94liIwC/2kKtSPLtN3LDcnBvdmee0W1i+jpKWHUHbxbFL/DvmY
	iDM1ILW1jewg9QcLStIQ=
X-Google-Smtp-Source: AGHT+IGASGKslm4YnrVrCyR6nvJ/i2wzlfWuyETjLKTMh0O1Ojw/wh+hTG7OFeKYXpYEcTD89VSvYw==
X-Received: by 2002:a05:6a00:179a:b0:772:65e:4273 with SMTP id d2e1a72fcca58-772065e467dmr5963292b3a.18.1756341093774;
        Wed, 27 Aug 2025 17:31:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772093cac4bsm2796708b3a.12.2025.08.27.17.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 17:31:32 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 27 Aug 2025 17:31:29 -0700
Subject: [PATCH net-next v5 1/9] vsock: a per-net vsock NS mode state
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-vsock-vmtest-v5-1-0ba580bede5b@meta.com>
References: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
In-Reply-To: <20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the per-net vsock NS mode state. This only adds the structure for
holding the mode and some of the functions for setting/getting and
checking the mode, but does not integrate the functionality yet.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

---
Changes in v5:
- use /proc/sys/net/vsock/ns_mode instead of /proc/net/vsock_ns_mode
- change from net->vsock.ns_mode to net->vsock.mode
- change vsock_net_set_mode() to vsock_net_write_mode()
- vsock_net_write_mode() returns bool for write success to avoid
  need to use vsock_net_mode_can_set()
- remove vsock_net_mode_can_set()
---
 MAINTAINERS                 |  1 +
 include/net/af_vsock.h      | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/net/net_namespace.h |  4 ++++
 include/net/netns/vsock.h   | 20 ++++++++++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bce96dd254b8..deaf7f02ec32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26578,6 +26578,7 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/vhost/vsock.c
 F:	include/linux/virtio_vsock.h
+F:	include/net/netns/vsock.h
 F:	include/uapi/linux/virtio_vsock.h
 F:	net/vmw_vsock/virtio_transport.c
 F:	net/vmw_vsock/virtio_transport_common.c
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d40e978126e3..5707514c30b6 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
+#include <net/netns/vsock.h>
 #include <net/sock.h>
 #include <uapi/linux/vm_sockets.h>
 
@@ -256,4 +257,45 @@ static inline bool vsock_msgzerocopy_allow(const struct vsock_transport *t)
 {
 	return t->msgzerocopy_allow && t->msgzerocopy_allow();
 }
+
+static inline u8 vsock_net_mode(struct net *net)
+{
+	enum vsock_net_mode ret;
+
+	spin_lock_bh(&net->vsock.lock);
+	ret = net->vsock.mode;
+	spin_unlock_bh(&net->vsock.lock);
+	return ret;
+}
+
+static inline bool vsock_net_write_mode(struct net *net, u8 mode)
+{
+	bool ret;
+
+	spin_lock_bh(&net->vsock.lock);
+
+	if (net->vsock.written) {
+		ret = false;
+		goto skip;
+	}
+
+	net->vsock.mode = mode;
+	net->vsock.written = true;
+	ret = true;
+
+skip:
+	spin_unlock_bh(&net->vsock.lock);
+	return ret;
+}
+
+/* Return true if vsock net mode check passes. Otherwise, return false.
+ *
+ * Read more about modes in comment header of net/vmw_vsock/af_vsock.c.
+ */
+static inline bool vsock_net_check_mode(struct net *n1, struct net *n2)
+{
+	return net_eq(n1, n2) ||
+	       (vsock_net_mode(n1) == VSOCK_NET_MODE_GLOBAL &&
+		vsock_net_mode(n2) == VSOCK_NET_MODE_GLOBAL);
+}
 #endif /* __AF_VSOCK_H__ */
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
index 000000000000..d4593c0b8dc4
--- /dev/null
+++ b/include/net/netns/vsock.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_NET_NAMESPACE_VSOCK_H
+#define __NET_NET_NAMESPACE_VSOCK_H
+
+#include <linux/types.h>
+
+enum vsock_net_mode {
+	VSOCK_NET_MODE_GLOBAL,
+	VSOCK_NET_MODE_LOCAL,
+};
+
+struct netns_vsock {
+	struct ctl_table_header *vsock_hdr;
+	spinlock_t lock;
+
+	/* protected by lock */
+	enum vsock_net_mode mode;
+	bool written;
+};
+#endif /* __NET_NET_NAMESPACE_VSOCK_H */

-- 
2.47.3


