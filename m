Return-Path: <linux-kselftest+bounces-5939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86BF8726AF
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 19:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA1A1C22EB3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 18:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34E118639;
	Tue,  5 Mar 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5IaiDTh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F771BC26;
	Tue,  5 Mar 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663895; cv=none; b=Mb1coxc3JZzE+XjE2BYwVswDssi/c8u3eqjrEQmjQof9V5M5elaHky4XqrSCpQizH5fY5O1RswEJbuNbur8CuT+jp/Ias52VcNOjQVgDyRanex/Som43AtAI7VJ4pSUJOBBiGvydroK9Q7wf+3mc+bRxeW2NpWoKvgvPiudz1kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663895; c=relaxed/simple;
	bh=jpAm1zYYQsLEehQYoa1ojXYdsiZS6ytxodAFhX2P7Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUSSM954r+lqtnaiQw2/NlvrL91q8wLBEUU/ULsDZ2tpa3iYKureJZkp5irR+CBJFWkIVhg5NRPGifJEVR3Fz+M5sMGdcknzVF1ZuRNCKxUVm2RCs/L/pZtDYG1ZR4kDKY3GOGjD5yq4Ig2OYfv3nniv+37180GK+zGPuc0fpLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5IaiDTh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1AAC433C7;
	Tue,  5 Mar 2024 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709663895;
	bh=jpAm1zYYQsLEehQYoa1ojXYdsiZS6ytxodAFhX2P7Vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O5IaiDThotBkXPvaVZJNGJwNzbX4phN9vU+0m3EZVajRn5ZUSBJrvWPFFQTjUm5Ke
	 566mBpxxMHEREV4gBHQm4f6Wqnpi8Onb5tzB2+pUYAUCIMnkxm0WJSk79Oa71u1OzK
	 Rx6jfA1DOOKgzAoLC5sPUcNhTkrlnY8r3GWQQ96xUtWCV+qFr2lTN1jCLOcPEu0y/a
	 YCO7MydRi18XWiaURiAXeHuLhu2d7FizVE30i5SkIfgkuPkNHk3sm2N1QUXFSQ2jFQ
	 nChN/bzWLxp0zRjIqkJ/56PorfYXne8N49eCoieqsfG3PNR4qxkh12VmaXJGV8m6ED
	 lgxxTUfYaI3NA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-kernel@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org
Subject: [PATCH v1 2/2] RISC-V: drop SOC_VIRT for ARCH_VIRT
Date: Tue,  5 Mar 2024 18:37:06 +0000
Message-ID: <20240305-stress-earflap-d7ddb8655a4d@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305-praying-clad-c4fbcaa7ed0a@spud>
References: <20240305-praying-clad-c4fbcaa7ed0a@spud>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4198; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=SLlSaZ+G4FwHZPlvuZ1ianZDFUhekawPuNsTN8M0NIc=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnP04KKXSUf5cTo/6v+/e+ixs77UTo717P2my9J05y0o ff93ktJHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZhIdjQjw17OXRd2OTK6nl2i oPE4fl7zvb07y+3+Mkq3Jb6SbTqiPYfhv/fam6sPncvMsT5fPeny3KrCV9/+2Z4S2aem9zfoFdd xMX4A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The ARCH_ and SOC_ versions of this symbol have persisted for quite a
while now in parallel. Generated .config files from previous LTS kernels
should have both. Finally remove SOC_VIRT and update all config files
using it.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I had a 1.5 year old ack from Jason that I dropped due to the passage of
time.

CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: Brendan Higgins <brendan.higgins@linux.dev>
CC: David Gow <davidgow@google.com>
CC: Rae Moar <rmoar@google.com>
CC: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: Shuah Khan <shuah@kernel.org>
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
CC: linux-kselftest@vger.kernel.org
CC: kunit-dev@googlegroups.com
CC: wireguard@lists.zx2c4.com
CC: netdev@vger.kernel.org
---
 arch/riscv/Kconfig.socs                                    | 3 ---
 arch/riscv/configs/defconfig                               | 2 +-
 arch/riscv/configs/nommu_virt_defconfig                    | 2 +-
 tools/testing/kunit/qemu_configs/riscv.py                  | 2 +-
 tools/testing/selftests/wireguard/qemu/arch/riscv32.config | 2 +-
 tools/testing/selftests/wireguard/qemu/arch/riscv64.config | 2 +-
 6 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index e85ffb63c48d..dcbfb659839c 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -52,9 +52,6 @@ config ARCH_THEAD
 	  This enables support for the RISC-V based T-HEAD SoCs.
 
 config ARCH_VIRT
-	def_bool SOC_VIRT
-
-config SOC_VIRT
 	bool "QEMU Virt Machine"
 	select CLINT_TIMER if RISCV_M_MODE
 	select POWER_RESET
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ab3bab313d56..8d46a9137b1e 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -32,7 +32,7 @@ CONFIG_ARCH_SOPHGO=y
 CONFIG_SOC_STARFIVE=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_THEAD=y
-CONFIG_SOC_VIRT=y
+CONFIG_ARCH_VIRT=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PM=y
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index b794e2f8144e..de8143d1f738 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -24,7 +24,7 @@ CONFIG_EXPERT=y
 CONFIG_SLUB=y
 CONFIG_SLUB_TINY=y
 # CONFIG_MMU is not set
-CONFIG_SOC_VIRT=y
+CONFIG_ARCH_VIRT=y
 CONFIG_NONPORTABLE=y
 CONFIG_SMP=y
 CONFIG_CMDLINE="root=/dev/vda rw earlycon=uart8250,mmio,0x10000000,115200n8 console=ttyS0"
diff --git a/tools/testing/kunit/qemu_configs/riscv.py b/tools/testing/kunit/qemu_configs/riscv.py
index 12a1d525978a..c87758030ff7 100644
--- a/tools/testing/kunit/qemu_configs/riscv.py
+++ b/tools/testing/kunit/qemu_configs/riscv.py
@@ -13,7 +13,7 @@ if not os.path.isfile(OPENSBI_PATH):
 
 QEMU_ARCH = QemuArchParams(linux_arch='riscv',
 			   kconfig='''
-CONFIG_SOC_VIRT=y
+CONFIG_ARCH_VIRT=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
diff --git a/tools/testing/selftests/wireguard/qemu/arch/riscv32.config b/tools/testing/selftests/wireguard/qemu/arch/riscv32.config
index 2fc36efb166d..2500eaa9b469 100644
--- a/tools/testing/selftests/wireguard/qemu/arch/riscv32.config
+++ b/tools/testing/selftests/wireguard/qemu/arch/riscv32.config
@@ -2,7 +2,7 @@ CONFIG_NONPORTABLE=y
 CONFIG_ARCH_RV32I=y
 CONFIG_MMU=y
 CONFIG_FPU=y
-CONFIG_SOC_VIRT=y
+CONFIG_ARCH_VIRT=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
diff --git a/tools/testing/selftests/wireguard/qemu/arch/riscv64.config b/tools/testing/selftests/wireguard/qemu/arch/riscv64.config
index dc266f3b1915..29a67ac67766 100644
--- a/tools/testing/selftests/wireguard/qemu/arch/riscv64.config
+++ b/tools/testing/selftests/wireguard/qemu/arch/riscv64.config
@@ -1,7 +1,7 @@
 CONFIG_ARCH_RV64I=y
 CONFIG_MMU=y
 CONFIG_FPU=y
-CONFIG_SOC_VIRT=y
+CONFIG_ARCH_VIRT=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
-- 
2.43.0


