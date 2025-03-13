Return-Path: <linux-kselftest+bounces-28890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EACA5EC7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 08:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB3B63A92E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 07:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3B1204864;
	Thu, 13 Mar 2025 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="J9q7IxgJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9039A2046BA
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 07:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849343; cv=none; b=EhsJpo9iGaG/jJNwft5KiWMDE/Ise/T3OxE+GT9oyqOWn1Vxlm2jhCxHQQsTaUsMINTcWl5Dww+XL9KfVax42mkXjSCxBLeOWM3kGPQsTKX0L/vikkYcmCQr2zflwZQ3HZXZdKcbPd4+Q8nCwNCXheOv9CVbHS0wx9W+L3xDXvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849343; c=relaxed/simple;
	bh=ccfXZvxiSAaG5MPb2w/JWrekNXtLfO8PT1kfNykthKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=pfSDrSaZc11ld6wd4jY7m0P3/0W6weoQRUxHk819PxBjeuZgLiOC8jXgc7xc1HX3+vVmGbgSE/HM5STraX4JELJK2OmNqQ+J9zKdKdc2/ZxLFar4MjmoZwCvwC9yUliG8vj4ThVp+0+NkS6TnS+sOdTsqR6hds4p44IZ6owPPkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=J9q7IxgJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22337bc9ac3so10968545ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 00:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741849341; x=1742454141; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3BkVPEmJoa+6yr2vocUy5kvhLH0cmr2yCWFD5W/C7U=;
        b=J9q7IxgJ4stdoM/xRWmjPMr7JP9W+H2YBe7j+nv2t2yfGviVHUDj5iTP+AgglpVd1f
         PEokAwzh+Bl45wxkn4c7O8iBgOHYS7vvTC8OzWleoTAlEpvp94IfNDUYrzcra8yGT/GC
         6jrqgwlkJ6NDVn6aplzh3qvLzXP+UPCCEu0QB0soU0rZxenuTi47P/AHIkio67XFyKOy
         BL94Zy7Dm7w5fAiDIUw0TSDO61zwG1eNNV/CExwH7Id71+FRT7Ea7x8vma6cK/E9IM/J
         ffoulW2/KVXsSuSZeRc9/nM1gVMV86iOsodR99HZhZncRc9Mlz9GdSreJfSBli+l1k3X
         swwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741849341; x=1742454141;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3BkVPEmJoa+6yr2vocUy5kvhLH0cmr2yCWFD5W/C7U=;
        b=hM/zX87GQqOdmboEdA1R23cUzoQMryAHiDeR3k/DQ0+e6Ez0F5kRkzgDVDv2I+HPnt
         cugbcJXN8/3kaeneLHFGIJ5yM+a8DmXhwiCp/F06xKq7EixTc6u74vpsjEo3kfTqVvNi
         FVAY1mcNr/c3S7BAofapfaK0/O/YmF4/4dfLISSb61liyeD3tyOj2HTxKCbnUaPT8Fjx
         9lEld/0ZGBQ+z8QImJ8ZwQpKpathUH7FJwkleWftbjlB9EnNSnvdb++VwMFprnzEe27e
         b1Lug5MEa2WpneTOnc797YdKAYXHFu+DiPnPUavqxKkb57oCzcCQ38E5wXxPQ0qPR9n4
         +zlA==
X-Forwarded-Encrypted: i=1; AJvYcCUhtcEMiATlrpP5sO95IzC85XRQ4NKyZKBMYg2Yh/GrsxGOHDXiz1xNyYxmY9zlkUbSqvZhfPDRa/D93LSkXxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcr21aGxbmgI+HfQaeRdpz9s5opYBQfIjn1if3ms5fv1okZJNx
	WxWTQ5fKfyxACwRkSMwIfudoQFD+0oQQgLEyaHopeCXEK9USHfX4n17Y/3wcb8g=
X-Gm-Gg: ASbGnctYeEjiki+cGiOwp/RGtI+Nv0dKc1133GT6CJCJ7F7T/CYg3OnL3Y7hzMcj42l
	z6Vg3q1l3v0J9BjKFsjFcaBuwljqJiNTaXnjHKsEW/YcykPnfflzfhd4dZt1P1D57N8KK/BlijY
	gBGe8FDbDIevFrw4Pvs2fwj892tnhGSE/Ggme6KlJ2ZlFjwI6VngJOzAt08u2pg5OehWD2dVsGl
	K2ddDKgLumDS5HXHsbYsCE1iXlHYi0+TYDivadfWRxF2knTb/K9LOOvlYTTBAzhMK8CvZLIDWaF
	YYPSgtQUXERPsJ/GId3Cz/IH0DvPuYAOG7j1x8LvaP3E94we
X-Google-Smtp-Source: AGHT+IFaX1olq5WQi+7fcP4HReHGKVkvSZ9sg15FYUug/XHg7z4NmpOMBbEE1p5tCvq05aXsAHzDQQ==
X-Received: by 2002:a05:6a00:2d83:b0:736:a7ec:a366 with SMTP id d2e1a72fcca58-736eb7d882bmr12600967b3a.9.1741849340468;
        Thu, 13 Mar 2025 00:02:20 -0700 (PDT)
Received: from localhost ([157.82.205.237])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73711695ee8sm632427b3a.154.2025.03.13.00.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:02:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 16:01:12 +0900
Subject: [PATCH net-next v10 09/10] selftest: tap: Add tests for virtio-net
 ioctls
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-rss-v10-9-3185d73a9af0@daynix.com>
References: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
In-Reply-To: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
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

They only test the ioctls are wired up to the implementation common with
tun as it is already tested for tun.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/testing/selftests/net/tap.c | 97 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/net/tap.c
index 247c3b3ac1c9..fbd38b08fdfa 100644
--- a/tools/testing/selftests/net/tap.c
+++ b/tools/testing/selftests/net/tap.c
@@ -363,6 +363,7 @@ size_t build_test_packet_crash_tap_invalid_eth_proto(uint8_t *buf,
 FIXTURE(tap)
 {
 	int fd;
+	bool deleted;
 };
 
 FIXTURE_SETUP(tap)
@@ -387,8 +388,10 @@ FIXTURE_TEARDOWN(tap)
 	if (self->fd != -1)
 		close(self->fd);
 
-	ret = dev_delete(param_dev_tap_name);
-	EXPECT_EQ(ret, 0);
+	if (!self->deleted) {
+		ret = dev_delete(param_dev_tap_name);
+		EXPECT_EQ(ret, 0);
+	}
 
 	ret = dev_delete(param_dev_dummy_name);
 	EXPECT_EQ(ret, 0);
@@ -431,4 +434,94 @@ TEST_F(tap, test_packet_crash_tap_invalid_eth_proto)
 	ASSERT_EQ(errno, EINVAL);
 }
 
+TEST_F(tap, test_vnethdrsz)
+{
+	int sz = sizeof(struct virtio_net_hdr_v1_hash);
+
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
+	self->deleted = true;
+
+	ASSERT_FALSE(ioctl(self->fd, TUNSETVNETHDRSZ, &sz));
+	sz = 0;
+	ASSERT_FALSE(ioctl(self->fd, TUNGETVNETHDRSZ, &sz));
+	EXPECT_EQ(sizeof(struct virtio_net_hdr_v1_hash), sz);
+}
+
+TEST_F(tap, test_vnetle)
+{
+	int le = 1;
+
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
+	self->deleted = true;
+
+	ASSERT_FALSE(ioctl(self->fd, TUNSETVNETLE, &le));
+	le = 0;
+	ASSERT_FALSE(ioctl(self->fd, TUNGETVNETLE, &le));
+	EXPECT_EQ(1, le);
+}
+
+TEST_F(tap, test_vnetbe)
+{
+	int be = 1;
+	int ret;
+
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
+	self->deleted = true;
+
+	ret = ioctl(self->fd, TUNSETVNETBE, &be);
+	if (ret == -1 && errno == EINVAL)
+		SKIP(return, "TUNSETVNETBE not supported");
+
+	ASSERT_FALSE(ret);
+	be = 0;
+	ASSERT_FALSE(ioctl(self->fd, TUNGETVNETBE, &be));
+	EXPECT_EQ(1, be);
+}
+
+TEST_F(tap, test_getvnethashcap)
+{
+	static const struct tun_vnet_hash expected = {
+		.flags = TUN_VNET_HASH_REPORT | TUN_VNET_HASH_RSS,
+		.types = VIRTIO_NET_RSS_HASH_TYPE_IPv4 |
+			 VIRTIO_NET_RSS_HASH_TYPE_TCPv4 |
+			 VIRTIO_NET_RSS_HASH_TYPE_UDPv4 |
+			 VIRTIO_NET_RSS_HASH_TYPE_IPv6 |
+			 VIRTIO_NET_RSS_HASH_TYPE_TCPv6 |
+			 VIRTIO_NET_RSS_HASH_TYPE_UDPv6
+	};
+	struct tun_vnet_hash seen;
+	int ret;
+
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
+	self->deleted = true;
+
+	ret = ioctl(self->fd, TUNGETVNETHASHCAP, &seen);
+
+	if (ret == -1 && errno == EINVAL)
+		SKIP(return, "TUNGETVNETHASHCAP not supported");
+
+	EXPECT_FALSE(ret);
+	EXPECT_FALSE(memcmp(&expected, &seen, sizeof(expected)));
+}
+
+TEST_F(tap, test_setvnethash_alive)
+{
+	struct tun_vnet_hash hash = { .flags = 0 };
+
+	EXPECT_FALSE(ioctl(self->fd, TUNSETVNETHASH, &hash));
+}
+
+TEST_F(tap, test_setvnethash_deleted)
+{
+	ASSERT_FALSE(dev_delete(param_dev_tap_name));
+	self->deleted = true;
+
+	ASSERT_EQ(-1, ioctl(self->fd, TUNSETVNETHASH));
+
+	if (errno == EINVAL)
+		SKIP(return, "TUNSETVNETHASH not supported");
+
+	EXPECT_EQ(EBADFD, errno);
+}
+
 TEST_HARNESS_MAIN

-- 
2.48.1


