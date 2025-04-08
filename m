Return-Path: <linux-kselftest+bounces-30340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEE8A7F79D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 10:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16ABE7A75F7
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 08:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85639264A77;
	Tue,  8 Apr 2025 08:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4nGXKP4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB072264629;
	Tue,  8 Apr 2025 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744100248; cv=none; b=pE6DBK4CbjCfzTCAp7YSluEN4uPRfyvnpAi0vmbsJ8I+69+UeK94Lh4CC482O92cUlQlkxs+MJMYJQH8mmlUsmmFGeiwlk9U3YVsYTrv4sPmPxTK39N6DyqmNMdEDv1AlnjjDb1MdqtgNjOZZ4OZZrtZWmHsfWgUPL/vmN9T/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744100248; c=relaxed/simple;
	bh=25kfwZWrJCdg3wZt8cA0jm1AToacY98iZoqDX4a/Ij0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzjWAPV0rcp8u5WDh5ctoSLNKdsYo9V9bjdlc6DA4oppB5C4y8o0VG5Ca3zTxuqQ68dh+fy5zjr2LO++XsuAiQR0ow41jyREObd8E1ABXW0mTnzJYQFza1suHTDd0G5xYoRcJan9AWuYSifanjrLlTUsUT/T54saph5Y2Pp5Xls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4nGXKP4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22548a28d0cso73204075ad.3;
        Tue, 08 Apr 2025 01:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744100243; x=1744705043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0d3Ceii2JHd7DdtO/Jyc5PB50s2tl91HKnoWaWMWAkc=;
        b=f4nGXKP4uvDf74hZ9mop8Nv2QjK9VVbAQxOUfH4Lg7NkDp4/jEmqtn6OvMC5mFEWdp
         YvdRlT7Qxo++UD4Sknb9FlqL6Rhw1FQGhW7wRtBGfo5tyuSWdW0eeiGcTqNbs3ku6wSf
         eCDo5i6kmyIiPs0cY4omXWzzrIOU//4ZTUA5exyD3koXM5OIQNf98LGQwLlts/WsRBLE
         XdvVLeKNQROeesF5ldfck/igzHkxhdyQyTBjbEq81dnKmyyfhs8vATMCYdDtZU05m+x5
         fvB3wO/w/YkIEnxdAh9sizYP3Rx8ZTgNrvc2p2ONbTu57BmYd+A9nDOxJPRcKyndmYBx
         uFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744100243; x=1744705043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0d3Ceii2JHd7DdtO/Jyc5PB50s2tl91HKnoWaWMWAkc=;
        b=DijtQkkz+S0p2ND1e8AGKZfoI0L9kP2ZjZvi7txWEuu6XpE/G2GyZQ7xLf+SmqB9r2
         +w0Gb7o0Yuzc+XVLMqpbPoQwbsDv8QKSDxM79XjRQTJSUzFoiZrrzQ+0Y0OQOjLvQMyI
         omawTgg1nkyQ2augV5jko3qzgH3kNEu+3+e9JrmT0y1Ms8HbSvmeiSCnV+8/W1wwGIXF
         w9PhWSnDTFnFTxJ/yLl/s+GRd6SSQWs2qUu3L11e1WHLXhrX0S0Vd+ITWJmsRQ7JEAX4
         pZHmNvVkFlwBh900FE+6tkjMODgGr9OfvV861XvQurK5zkmeISLcDu1jdYPMe4e0+zDE
         ijGw==
X-Forwarded-Encrypted: i=1; AJvYcCU+b8Oa7BuhTIYv0JXLJCFAa75+9vd/SOZVqVmP2KC6nc7r6Sdi7aVvsINaco/o3RX75vs7HL7ZEsBF2L04zFZD@vger.kernel.org, AJvYcCXQLMPLY4aIY4TQ+URav9YUyJfLyw4uUTfn3gVBLpkKoBLNx9Ybl9qBhJbmU81OEjSAd3CqpFIxkPyUKyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzoqNZpUKtGqTmzJmB4Qm9bpXn8o9xKKw+5r/xcNsNqOhKVJHD
	V9k9l8NCxTmz/TWF5dIj4zIsFaOj7uQTYgwjBGAt2nhMRagA04AuMQUv1zaaXbg=
X-Gm-Gg: ASbGncucikPo1yID3UDcxYz6ZqoHP7OuX2KpbolYuje4+jTEltfRTmSfjgtH2LuPYes
	kbiey0Oo/0n6QMgVeqDck4ZRulQOj86ect3tAHuj3ME1SVTN/vCkfXa4npvZBp7OPMe7wb/g0RH
	zWse9gXj0AvN4htgmJvQgCa4+AcacWF5r/MVLuSoPWxOKSVCee7tsEKFbDZkY8xJqJuLWHG+GDz
	VFdRcyF1NzWbeiJvBlirO8ZGlWWPbGmXK6OQDMIfot+uWgfhqeIZ9lmpC57hwvUdTgmfE2doJpJ
	1W7fY8tWYrI9g/27QhwKxoMsxaOzy1v9WNzteXsR5+5zOqyy+75o0v5d+mzH6+uDWl1mxg==
X-Google-Smtp-Source: AGHT+IGi1HhT35CGTn4OHIXajxXrLV4KFaDuVWc5PJ3Zmw4syv6sGb4JtQdYhMc/JNW13o1mWUN14g==
X-Received: by 2002:a17:902:e552:b0:220:e5be:29c7 with SMTP id d9443c01a7336-22a8a8b833emr206228755ad.39.1744100242645;
        Tue, 08 Apr 2025 01:17:22 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ada20sm94319535ad.46.2025.04.08.01.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 01:17:21 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>,
	Petr Mladek <pmladek@suse.com>,
	Yoann Congal <yoann.congal@smile.fr>,
	wireguard@lists.zx2c4.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv6 net-next 2/2] wireguard: selftests: update to using nft for qemu test
Date: Tue,  8 Apr 2025 08:16:52 +0000
Message-ID: <20250408081652.1330-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250408081652.1330-1-liuhangbin@gmail.com>
References: <20250408081652.1330-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we will replace iptables with nft for wireguard netns testing,
let's also convert the qemu test to use nft at the same time.

Co-developed-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../testing/selftests/wireguard/qemu/Makefile | 36 ++++++++++++++-----
 .../selftests/wireguard/qemu/kernel.config    |  7 ++--
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/wireguard/qemu/Makefile b/tools/testing/selftests/wireguard/qemu/Makefile
index 35856b11c143..2442ae99f007 100644
--- a/tools/testing/selftests/wireguard/qemu/Makefile
+++ b/tools/testing/selftests/wireguard/qemu/Makefile
@@ -40,7 +40,9 @@ endef
 $(eval $(call tar_download,IPERF,iperf,3.11,.tar.gz,https://downloads.es.net/pub/iperf/,de8cb409fad61a0574f4cb07eb19ce1159707403ac2dc01b5d175e91240b7e5f))
 $(eval $(call tar_download,BASH,bash,5.1.16,.tar.gz,https://ftp.gnu.org/gnu/bash/,5bac17218d3911834520dad13cd1f85ab944e1c09ae1aba55906be1f8192f558))
 $(eval $(call tar_download,IPROUTE2,iproute2,5.17.0,.tar.gz,https://www.kernel.org/pub/linux/utils/net/iproute2/,bda331d5c4606138892f23a565d78fca18919b4d508a0b7ca8391c2da2db68b9))
-$(eval $(call tar_download,IPTABLES,iptables,1.8.7,.tar.bz2,https://www.netfilter.org/projects/iptables/files/,c109c96bb04998cd44156622d36f8e04b140701ec60531a10668cfdff5e8d8f0))
+$(eval $(call tar_download,LIBMNL,libmnl,1.0.5,.tar.bz2,https://www.netfilter.org/projects/libmnl/files/,274b9b919ef3152bfb3da3a13c950dd60d6e2bcd54230ffeca298d03b40d0525))
+$(eval $(call tar_download,LIBNFTNL,libnftnl,1.2.8,.tar.xz,https://www.netfilter.org/projects/libnftnl/files/,37fea5d6b5c9b08de7920d298de3cdc942e7ae64b1a3e8b880b2d390ae67ad95))
+$(eval $(call tar_download,NFTABLES,nftables,1.1.1,.tar.xz,https://www.netfilter.org/projects/nftables/files/,6358830f3a64f31e39b0ad421d7dadcd240b72343ded48d8ef13b8faf204865a))
 $(eval $(call tar_download,NMAP,nmap,7.92,.tgz,https://nmap.org/dist/,064183ea642dc4c12b1ab3b5358ce1cef7d2e7e11ffa2849f16d339f5b717117))
 $(eval $(call tar_download,IPUTILS,iputils,s20190709,.tar.gz,https://github.com/iputils/iputils/archive/s20190709.tar.gz/#,a15720dd741d7538dd2645f9f516d193636ae4300ff7dbc8bfca757bf166490a))
 $(eval $(call tar_download,WIREGUARD_TOOLS,wireguard-tools,1.0.20210914,.tar.xz,https://git.zx2c4.com/wireguard-tools/snapshot/,97ff31489217bb265b7ae850d3d0f335ab07d2652ba1feec88b734bc96bd05ac))
@@ -322,8 +324,7 @@ $(BUILD_PATH)/init-cpio-spec.txt: $(TOOLCHAIN_PATH)/.installed $(BUILD_PATH)/ini
 	echo "file /bin/ss $(IPROUTE2_PATH)/misc/ss 755 0 0" >> $@
 	echo "file /bin/ping $(IPUTILS_PATH)/ping 755 0 0" >> $@
 	echo "file /bin/ncat $(NMAP_PATH)/ncat/ncat 755 0 0" >> $@
-	echo "file /bin/xtables-legacy-multi $(IPTABLES_PATH)/iptables/xtables-legacy-multi 755 0 0" >> $@
-	echo "slink /bin/iptables xtables-legacy-multi 777 0 0" >> $@
+	echo "file /bin/nft $(NFTABLES_PATH)/src/nft 755 0 0" >> $@
 	echo "slink /bin/ping6 ping 777 0 0" >> $@
 	echo "dir /lib 755 0 0" >> $@
 	echo "file /lib/libc.so $(TOOLCHAIN_PATH)/$(CHOST)/lib/libc.so 755 0 0" >> $@
@@ -338,7 +339,7 @@ $(KERNEL_BUILD_PATH)/.config: $(TOOLCHAIN_PATH)/.installed kernel.config arch/$(
 	cd $(KERNEL_BUILD_PATH) && ARCH=$(KERNEL_ARCH) $(KERNEL_PATH)/scripts/kconfig/merge_config.sh -n $(KERNEL_BUILD_PATH)/.config $(KERNEL_BUILD_PATH)/minimal.config
 	$(if $(findstring yes,$(DEBUG_KERNEL)),cp debug.config $(KERNEL_BUILD_PATH) && cd $(KERNEL_BUILD_PATH) && ARCH=$(KERNEL_ARCH) $(KERNEL_PATH)/scripts/kconfig/merge_config.sh -n $(KERNEL_BUILD_PATH)/.config debug.config,)
 
-$(KERNEL_BZIMAGE): $(TOOLCHAIN_PATH)/.installed $(KERNEL_BUILD_PATH)/.config $(BUILD_PATH)/init-cpio-spec.txt $(IPERF_PATH)/src/iperf3 $(IPUTILS_PATH)/ping $(BASH_PATH)/bash $(IPROUTE2_PATH)/misc/ss $(IPROUTE2_PATH)/ip/ip $(IPTABLES_PATH)/iptables/xtables-legacy-multi $(NMAP_PATH)/ncat/ncat $(WIREGUARD_TOOLS_PATH)/src/wg $(BUILD_PATH)/init
+$(KERNEL_BZIMAGE): $(TOOLCHAIN_PATH)/.installed $(KERNEL_BUILD_PATH)/.config $(BUILD_PATH)/init-cpio-spec.txt $(IPERF_PATH)/src/iperf3 $(IPUTILS_PATH)/ping $(BASH_PATH)/bash $(IPROUTE2_PATH)/misc/ss $(IPROUTE2_PATH)/ip/ip $(LIBMNL_PATH)/libmnl $(LIBNFTNL_PATH)/libnftnl $(NFTABLES_PATH)/src/nft $(NMAP_PATH)/ncat/ncat $(WIREGUARD_TOOLS_PATH)/src/wg $(BUILD_PATH)/init
 	$(MAKE) -C $(KERNEL_PATH) O=$(KERNEL_BUILD_PATH) ARCH=$(KERNEL_ARCH) CROSS_COMPILE=$(CROSS_COMPILE)
 .PHONY: $(KERNEL_BZIMAGE)
 
@@ -421,15 +422,32 @@ $(IPROUTE2_PATH)/misc/ss: | $(IPROUTE2_PATH)/.installed $(USERSPACE_DEPS)
 	$(MAKE) -C $(IPROUTE2_PATH) PREFIX=/ misc/ss
 	$(STRIP) -s $@
 
-$(IPTABLES_PATH)/.installed: $(IPTABLES_TAR)
+$(LIBMNL_PATH)/.installed: $(LIBMNL_TAR)
 	mkdir -p $(BUILD_PATH)
 	flock -s $<.lock tar -C $(BUILD_PATH) -xf $<
-	sed -i -e "/nfnetlink=[01]/s:=[01]:=0:" -e "/nfconntrack=[01]/s:=[01]:=0:" $(IPTABLES_PATH)/configure
 	touch $@
 
-$(IPTABLES_PATH)/iptables/xtables-legacy-multi: | $(IPTABLES_PATH)/.installed $(USERSPACE_DEPS)
-	cd $(IPTABLES_PATH) && ./configure --prefix=/ $(CROSS_COMPILE_FLAG) --enable-static --disable-shared --disable-nftables --disable-bpf-compiler --disable-nfsynproxy --disable-libipq --disable-connlabel --with-kernel=$(BUILD_PATH)/include
-	$(MAKE) -C $(IPTABLES_PATH)
+$(LIBMNL_PATH)/libmnl: | $(LIBMNL_PATH)/.installed $(USERSPACE_DEPS)
+	cd $(LIBMNL_PATH) && ./configure --prefix=$(TOOLCHAIN_PATH) $(CROSS_COMPILE_FLAG) --enable-static --disable-shared
+	$(MAKE) -C $(LIBMNL_PATH) install
+
+$(LIBNFTNL_PATH)/.installed: $(LIBNFTNL_TAR)
+	mkdir -p $(BUILD_PATH)
+	flock -s $<.lock tar -C $(BUILD_PATH) -xf $<
+	touch $@
+
+$(LIBNFTNL_PATH)/libnftnl: | $(LIBNFTNL_PATH)/.installed $(USERSPACE_DEPS)
+	cd $(LIBNFTNL_PATH) && PKG_CONFIG_PATH="$(TOOLCHAIN_PATH)/lib/pkgconfig" ./configure --prefix=$(TOOLCHAIN_PATH) $(CROSS_COMPILE_FLAG) --enable-static --disable-shared
+	$(MAKE) -C $(LIBNFTNL_PATH) install
+
+$(NFTABLES_PATH)/.installed: $(NFTABLES_TAR)
+	mkdir -p $(BUILD_PATH)
+	flock -s $<.lock tar -C $(BUILD_PATH) -xf $<
+	touch $@
+
+$(NFTABLES_PATH)/src/nft: | $(NFTABLES_PATH)/.installed $(USERSPACE_DEPS)
+	cd $(NFTABLES_PATH) && PKG_CONFIG_PATH="$(TOOLCHAIN_PATH)/lib/pkgconfig" ./configure --prefix=/ $(CROSS_COMPILE_FLAG) --enable-static --disable-shared --disable-debug --disable-man-doc --with-mini-gmp --without-cli
+	$(MAKE) -C $(NFTABLES_PATH) PREFIX=/
 	$(STRIP) -s $@
 
 $(NMAP_PATH)/.installed: $(NMAP_TAR)
diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
index f314d3789f17..9930116ecd81 100644
--- a/tools/testing/selftests/wireguard/qemu/kernel.config
+++ b/tools/testing/selftests/wireguard/qemu/kernel.config
@@ -19,10 +19,9 @@ CONFIG_NETFILTER_XTABLES=y
 CONFIG_NETFILTER_XT_NAT=y
 CONFIG_NETFILTER_XT_MATCH_LENGTH=y
 CONFIG_NETFILTER_XT_MARK=y
-CONFIG_IP_NF_IPTABLES=y
-CONFIG_IP_NF_FILTER=y
-CONFIG_IP_NF_MANGLE=y
-CONFIG_IP_NF_NAT=y
+CONFIG_NF_TABLES=m
+CONFIG_NF_TABLES_INET=y
+CONFIG_NFT_NAT=y
 CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IPV6_MULTIPLE_TABLES=y
-- 
2.46.0


