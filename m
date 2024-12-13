Return-Path: <linux-kselftest+bounces-23291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4037B9F02F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 04:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0126216AD1B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 03:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02599170A23;
	Fri, 13 Dec 2024 03:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1xpMz1C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3275F16C684;
	Fri, 13 Dec 2024 03:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734059328; cv=none; b=MKqyFAzvr7yMcxJWxThMGw9zhaCuaXIIyHgvPn7cRii34pmNlEUALLpoqATrktWaDWALLMW4DlzT0AMFianqo4mEYA2kvnToQ0Gd+qHoIC/qhGmTJR7uO5zolutyPZkRlbH+iDe9whXFuXkljS5Dh/QcUevsGkkLsNMuiLqQd6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734059328; c=relaxed/simple;
	bh=8ZUI3Ibtg3ddO05q8gCUWcVBm413XnxCeeXRzbyT5Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASBgowe8hhLdZwoAdw4xJhcblqQCzlQ/D1I+pSsWhDhfRTBuQcMUg6T8oizcPQFprbLyMB7F4h6HMlQvFaNtZc3F5KOsWnatqsa7l4i5nHbho2g4RqYyIFnekZ1+shnP9O4xMhEKJndCyl6Df6Xgs2rLh3TaOPyTCls80rAF0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1xpMz1C; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7265c18d79bso1472149b3a.3;
        Thu, 12 Dec 2024 19:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734059326; x=1734664126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luedh3E5fjeOowLern4iwDWN0UhJnMCsLuFyaHGaQ2s=;
        b=i1xpMz1CZ2qrdjyn9vLcu2anFb7SrLMNYLdwrRnvF7EO9EK/wgqrxJa4dcI9yAd5yz
         mWk/egGkeWxSv6UaZuIoX7LcQLATPKL9QO870mU72l4F9nvl3bbongBmvU+3HrmCSl3A
         MJa+FNB3jnDhr45e8SiKvOaqWIdiH5xZj2z55YVpV+AZDP2WbHJNnreYkuDYo7RzGO4O
         luOX+zi1jSzLpNbAzneLU7/vx1sUhz10crj1CQWdywZyACDai7REN5DswuFXAx+leGs7
         +GugnmLtEhdaACAp+hhHu4INfOlUbxwRUvLg6Rb3Ts4cVI/zTGlObDi5JtOVKuU+hZhE
         GWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734059326; x=1734664126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luedh3E5fjeOowLern4iwDWN0UhJnMCsLuFyaHGaQ2s=;
        b=KmSW+zqAi1jwb6ypmbZGFlD1K9Y0Ie2wXmjVy/tSMDOND3oiaLO5oVJVGHi5+KqPzl
         R9XScikHNP2ijTCDQce6E4gAPgJkN2Qnp8GTdfouQ2ANtUqwYkGm9VfGRJ+enF/Pl1wj
         vJ+ZJQFHzfXMGk6ZCQui4U/ryw3o5lIX3l/0ViVbuBIPHFoyySzPE0d8BWx3TwgkwKqQ
         rdXeMWaKV7W5x9AICoVLSxWbLWfsuQ+PVs+OfWm1TwrpXutEEIYDL0GFQ9zxkiOBUPc7
         S5W+H+VqVTZsapwI7QH3KQ2UprwuYbOywVgPP5sr0DO9gnZ85+ZIPt9Ujoit4nl8T+oE
         2tIw==
X-Forwarded-Encrypted: i=1; AJvYcCUyWQo/Kw/c0G4tHk4Nfb4qBBGVcQSmLQ2ZJbbXbrtG6PDuofBM6mfjCAeKZ+/x3fhgT9M=@vger.kernel.org, AJvYcCVoh01Om43wHj1hzlhnMi9PHTCtb3s6yvgxX0VV/eMDuWI9nRPsuAYIhlQUzKsuj4lMZdBT6lOy/nexA51JEfVZ@vger.kernel.org, AJvYcCWMP9vPsANio+sc6UsFH/sUDp8tB1n4/XbVFXZmrfsd988DAWCl/xBbPQN/64n0xVeYW9/ol4zjcqqJzT93@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5jZzR/naHVBaSxPG+UWQ75Wq+79hf8r04yJvqOx+LxJoCVii5
	YWFDKn1uUfkgWh2XzBj7wTzmm09ILHqtxrIGr0YRqg3cR8knL3MdUFTJUxn4
X-Gm-Gg: ASbGnct/5ALVYaEDUklhEJxZUZapQ2leQCLzL2NCtkQDUVQSgbZjYdd7buw8S/pVum/
	iWxaoPrJwjaZ8Nlr+YozqAIfYc/Rj+RbrrNFR9m9VRaW4TR4vg4tI0P+KgIJkFk1XWFAwR+BIVt
	1+1z5i2/99eOE9FdlwnaMZoDKqyBpgg5QBdbcjqaJ9nVU9CGulo6Q7uGLz6Q4eqjrCtiKmqF1z1
	XuOd5+UAawx8SgElFymTQD75KuBmFrbp0iKusjjiDq5eniTHfYSZUrnCvTLIMPO7OiHcGYrZgzt
X-Google-Smtp-Source: AGHT+IGYK9E6V1ljVwWs41gWcPcHM9MzFn4nVnvgoAVy8bYSHXluPqnbuqIAPcABaWu+rX3CxbRjAA==
X-Received: by 2002:a05:6a00:2995:b0:725:eacf:cfda with SMTP id d2e1a72fcca58-7290c25ae78mr1402221b3a.17.1734059326079;
        Thu, 12 Dec 2024 19:08:46 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e4b13545sm9152783b3a.126.2024.12.12.19.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:08:45 -0800 (PST)
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
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 2/2] selftests: wireguard: update to using nft for qemu test
Date: Fri, 13 Dec 2024 03:08:19 +0000
Message-ID: <20241213030819.49987-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241213030819.49987-1-liuhangbin@gmail.com>
References: <20241213030819.49987-1-liuhangbin@gmail.com>
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
 .../testing/selftests/wireguard/qemu/Makefile | 40 ++++++++++++++-----
 .../selftests/wireguard/qemu/kernel.config    |  7 ++--
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/wireguard/qemu/Makefile b/tools/testing/selftests/wireguard/qemu/Makefile
index 35856b11c143..10e79449fefa 100644
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
@@ -322,11 +324,12 @@ $(BUILD_PATH)/init-cpio-spec.txt: $(TOOLCHAIN_PATH)/.installed $(BUILD_PATH)/ini
 	echo "file /bin/ss $(IPROUTE2_PATH)/misc/ss 755 0 0" >> $@
 	echo "file /bin/ping $(IPUTILS_PATH)/ping 755 0 0" >> $@
 	echo "file /bin/ncat $(NMAP_PATH)/ncat/ncat 755 0 0" >> $@
-	echo "file /bin/xtables-legacy-multi $(IPTABLES_PATH)/iptables/xtables-legacy-multi 755 0 0" >> $@
-	echo "slink /bin/iptables xtables-legacy-multi 777 0 0" >> $@
+	echo "file /bin/nft $(NFTABLES_PATH)/src/nft 755 0 0" >> $@
 	echo "slink /bin/ping6 ping 777 0 0" >> $@
 	echo "dir /lib 755 0 0" >> $@
 	echo "file /lib/libc.so $(TOOLCHAIN_PATH)/$(CHOST)/lib/libc.so 755 0 0" >> $@
+	echo "file /lib/libmnl.so.0 $(TOOLCHAIN_PATH)/lib/libmnl.so.0 755 0 0" >> $@
+	echo "file /lib/libnftnl.so.11 $(TOOLCHAIN_PATH)/lib/libnftnl.so.11 755 0 0" >> $@
 	echo "slink $$($(CHOST)-readelf -p .interp '$(BUILD_PATH)/init'| grep -o '/lib/.*') libc.so 777 0 0" >> $@
 
 $(KERNEL_BUILD_PATH)/.config: $(TOOLCHAIN_PATH)/.installed kernel.config arch/$(ARCH).config
@@ -338,7 +341,7 @@ $(KERNEL_BUILD_PATH)/.config: $(TOOLCHAIN_PATH)/.installed kernel.config arch/$(
 	cd $(KERNEL_BUILD_PATH) && ARCH=$(KERNEL_ARCH) $(KERNEL_PATH)/scripts/kconfig/merge_config.sh -n $(KERNEL_BUILD_PATH)/.config $(KERNEL_BUILD_PATH)/minimal.config
 	$(if $(findstring yes,$(DEBUG_KERNEL)),cp debug.config $(KERNEL_BUILD_PATH) && cd $(KERNEL_BUILD_PATH) && ARCH=$(KERNEL_ARCH) $(KERNEL_PATH)/scripts/kconfig/merge_config.sh -n $(KERNEL_BUILD_PATH)/.config debug.config,)
 
-$(KERNEL_BZIMAGE): $(TOOLCHAIN_PATH)/.installed $(KERNEL_BUILD_PATH)/.config $(BUILD_PATH)/init-cpio-spec.txt $(IPERF_PATH)/src/iperf3 $(IPUTILS_PATH)/ping $(BASH_PATH)/bash $(IPROUTE2_PATH)/misc/ss $(IPROUTE2_PATH)/ip/ip $(IPTABLES_PATH)/iptables/xtables-legacy-multi $(NMAP_PATH)/ncat/ncat $(WIREGUARD_TOOLS_PATH)/src/wg $(BUILD_PATH)/init
+$(KERNEL_BZIMAGE): $(TOOLCHAIN_PATH)/.installed $(KERNEL_BUILD_PATH)/.config $(BUILD_PATH)/init-cpio-spec.txt $(IPERF_PATH)/src/iperf3 $(IPUTILS_PATH)/ping $(BASH_PATH)/bash $(IPROUTE2_PATH)/misc/ss $(IPROUTE2_PATH)/ip/ip $(LIBMNL_PATH)/libmnl $(LIBNFTNL_PATH)/libnftnl $(NFTABLES_PATH)/src/nft $(NMAP_PATH)/ncat/ncat $(WIREGUARD_TOOLS_PATH)/src/wg $(BUILD_PATH)/init
 	$(MAKE) -C $(KERNEL_PATH) O=$(KERNEL_BUILD_PATH) ARCH=$(KERNEL_ARCH) CROSS_COMPILE=$(CROSS_COMPILE)
 .PHONY: $(KERNEL_BZIMAGE)
 
@@ -421,15 +424,34 @@ $(IPROUTE2_PATH)/misc/ss: | $(IPROUTE2_PATH)/.installed $(USERSPACE_DEPS)
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
+	cd $(LIBMNL_PATH) && ./configure --prefix=$(TOOLCHAIN_PATH) $(CROSS_COMPILE_FLAG)
+	$(MAKE) -C $(LIBMNL_PATH) install
+	$(STRIP) -s $(TOOLCHAIN_PATH)/lib/libmnl.so.0
+
+$(LIBNFTNL_PATH)/.installed: $(LIBNFTNL_TAR)
+	mkdir -p $(BUILD_PATH)
+	flock -s $<.lock tar -C $(BUILD_PATH) -xf $<
+	touch $@
+
+$(LIBNFTNL_PATH)/libnftnl: | $(LIBNFTNL_PATH)/.installed $(USERSPACE_DEPS)
+	cd $(LIBNFTNL_PATH) && PKG_CONFIG_PATH="$(TOOLCHAIN_PATH)/lib/pkgconfig" ./configure --prefix=$(TOOLCHAIN_PATH) $(CROSS_COMPILE_FLAG)
+	$(MAKE) -C $(LIBNFTNL_PATH) install
+	$(STRIP) -s $(TOOLCHAIN_PATH)/lib/libnftnl.so.11
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
2.39.5 (Apple Git-154)


