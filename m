Return-Path: <linux-kselftest+bounces-33834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC71AC46C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 05:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00621174342
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 03:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A82F1B413D;
	Tue, 27 May 2025 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbFFa8js"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984A61AF0AE;
	Tue, 27 May 2025 03:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748316420; cv=none; b=Zf+sqYv7lwGX9jbK/xFosjKe2jheTgbG4OuNC9+O8EpSkHg+sCrq/6sz+4Jn7zpsvs5vJB6F59UxG5bTYxOIVUFuAGUY6Eykd6XA92542RFs65XhBSfON03HFFGw0/wIcaBS47bjj8NiDsjWbgPvXS4jOWZcEDiZ7gamT2lglxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748316420; c=relaxed/simple;
	bh=25kfwZWrJCdg3wZt8cA0jm1AToacY98iZoqDX4a/Ij0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+l3Rgv15w8D4UieiS4SJAU51S2izcMzOjFtrzVODH5NPZZgOBZhn/EqXk87B4ceWt8ptmEO006SCLUxjqpKnl+AQQRiVNYvv3EA+mXi6heqlUO3OUL6woADLWJDWbKSrTNor+P8JSrQYUAsjolOBOvBH7gifxxMTGXuP1TEt8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbFFa8js; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso3104343b3a.2;
        Mon, 26 May 2025 20:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748316418; x=1748921218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0d3Ceii2JHd7DdtO/Jyc5PB50s2tl91HKnoWaWMWAkc=;
        b=CbFFa8js6JmcNX3afR/CdYTD2BVI+4YcjW23uCZd+YM6XwP/ImXPoKpUeuDxfUYAnF
         v7C4XrqVSvsMDCTBGdqJV36Mwx4rsiQmjuc3b9c2EFEGfwFUwCMev13MpDUikO83XtAM
         f5lH2TDcp7UnIHPeypCi7YAWLlgkLfD6j8YOB37yQ8CTxJPJlpVFemIQWU2fP6/H+jcA
         Vb9dj2vveKkUjJEF4hfYNA4H9EONrnCEx18GiP0uNQ6VH+0uTw+6hiygokVUdKxmdBzB
         CZoL3DPKOqL53/54o4v17AFXDdxts+0qFmBVBocVoo0QL+pQj614RgiVkwoCWaGW3qma
         MWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748316418; x=1748921218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0d3Ceii2JHd7DdtO/Jyc5PB50s2tl91HKnoWaWMWAkc=;
        b=Pj9qusKOUne59hzwPwN2ehiQeCFbhMZXfFE2zrDF81nJA8cr2MwhVrl8LShpdKROBb
         fNWz7UjjZbu/n/ydEV2bDc47cHnkeu4P3PwOhQYvS+TPHoa2gRQJi89OGnh/hSJhJhXV
         zezRsCto3zX9Okt+G1DuihqZukzBQSs7vQgQ5UtnTJJvkPQnx1tXAoAehKuQtv6N9bcV
         s6nGDPLpHZ5I2ipNbpZNvAO+wEcGZZDNiWPyaU9pwvSshs2augnn+XlmhpMhCG/96hbh
         3y2O4+QcOCyNL1cfDIkYZ5Zy5aapMqVlnKAKAvcoG2Ly/s7+lZlE9TPPa45eH/9N8Fte
         U2RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv0FNoFPvEIi6XUdQj6FI+8ET8Er4XEHQy02YhuKioQbgOFmTMa6yt8qp1NbtnCGwgWNuQN+WQ3sfvLAE=@vger.kernel.org, AJvYcCXsOqSiBIH0G3tXn1nCz1/80zi0eyiFrb86TzdeAXFBY2E3toChXdGgaDG2QpySCkDpCId2M+GpgdkPmUISsbje@vger.kernel.org
X-Gm-Message-State: AOJu0YxVxlUJRYvWEkEUIG4vO0D6EN9so+oHWJmKBVwywVmYGOeXhJHv
	eoiqfsirIYJyy6qA0eIEqaOv8CLhutwf0ti09Q+CgnEsTxg4di7vjcMCOyrhbCssT1gWtg==
X-Gm-Gg: ASbGncsPvWITdJYmGgFGVh84FZWU3ubtn29m9RMQPRMCkEwUCLJf51+l8rmrAI10ppS
	uAoZsd+QkxDHdT2GKF/Si76Aixiqt9HrSopRTNZa5X7f28gpTmGl35CSGIinDsiQH+lfW4/AibA
	jsg+6smT390beZFDMEuSE/Smzj2f4eo26awBNhh6xpvN4oB36XomDDPzEHqZJzzXOHOw9+VxR9I
	DXwbCQo8lDMqHgQIyIAY8kBCMuVO3uFFIrD3+mroqRWnCu7wUecrAxx+zxMEtWvrUMGEljGRBRI
	DM+tRRF7s58L6rwZH8Cf6zyZgdXVBehXTO3YScwguLn/GFuMqmhxsbO4M3vTz4wyCdhj9QY=
X-Google-Smtp-Source: AGHT+IGb+7qaXKyhT4wWXjgKeo/vySCxcdkeuTOl8hvnSfuDcHsEUB0t6+UFO7+PhMdJKjqH/VNvJQ==
X-Received: by 2002:a05:6a21:3399:b0:1f5:709d:e0c6 with SMTP id adf61e73a8af0-2188c3b4987mr17871610637.42.1748316417674;
        Mon, 26 May 2025 20:26:57 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74622b3b481sm865926b3a.131.2025.05.26.20.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 20:26:57 -0700 (PDT)
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
Subject: [PATCHv7 RESEND wireguard 2/2] wireguard: selftests: update to using nft for qemu test
Date: Tue, 27 May 2025 03:26:35 +0000
Message-ID: <20250527032635.10361-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250527032635.10361-1-liuhangbin@gmail.com>
References: <20250527032635.10361-1-liuhangbin@gmail.com>
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


