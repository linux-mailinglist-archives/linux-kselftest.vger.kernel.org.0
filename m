Return-Path: <linux-kselftest+bounces-19302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74933995B69
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 01:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C72EAB2124B
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 23:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D88D216A2B;
	Tue,  8 Oct 2024 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eONwHUSy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8778173336;
	Tue,  8 Oct 2024 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429124; cv=none; b=dJWnYPv29qXVkAtWl+SOaTKq1UePCpVZu2KTZ4eAu3jwTbqScqRLsrJN20dCOXL8N5j/LAnMHjI1LEXvTIvDCMWBDkLgdFQ9PLWeTnITB34HnvrzrxI7XJ9K/Y6eAHdYruY70rLhbqqFWARmHSl5t3gtWCtOerT8zvCTz3GjYtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429124; c=relaxed/simple;
	bh=Bki+M28Uxgy/me7xvfPv7pJjxyUy06JPfx4V50qSkoU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=pKcSgRkNAZqIVE90knHhidOfDYxEpbVMGqhf5IdAKEWj1fgt9Eod+9xW5Mdmxl8le9SmnHtEgV1WpkJkDg5wongB/hIfOLGzbTF4Bot9hzqkAGUOGECU6vjf6a4lY5MQiaGGA9z9D+pkZY6zev+JdqT1l67t67ykhs7U/xI9/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eONwHUSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47898C4CEC7;
	Tue,  8 Oct 2024 23:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728429124;
	bh=Bki+M28Uxgy/me7xvfPv7pJjxyUy06JPfx4V50qSkoU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=eONwHUSy/QglbYsCbdw2Rwy/P6GtWCWP95d3T9XiyozzzzjSkWKtFIRGPqoTYdt6T
	 a5MVWrbDT3WxfgHTdp2HCkZA5DbWXAgYBWtJ6D28RbhXTAgA/zKWGLLrhl4A1dZZs8
	 B/QAeWabS7AccKyKwepAUe909Rpk2qfr0sE7sJtdpKqZvnxBIBZLeLmwns0nsDDrUz
	 i9YX6Np+9iZ8u9HLAudlI6lTqbrCVc9EPz5fZV2dtdPQSD2PinMwxS0S7hLaHUFbKl
	 wza/yFRmshcoYyi98P/kda2wsf3s/V/NOyNB4FlBvlkyltWCQ5ykKIlXyrrxheuD6f
	 MYGhWVScEIuqg==
Message-ID: <ccd372f2754e80d6c01e38a9596bed34.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cb1e0119-6e3e-4fd2-92ea-3fec18f5843d@roeck-us.net>
References: <20240718210513.3801024-1-sboyd@kernel.org> <ba88a29c-f05e-4ca3-82d1-0a634613caee@roeck-us.net> <4216b852-11a2-41ae-bb01-5f9b578ee41b@roeck-us.net> <879831a8-2039-4cdb-bce2-aefdeb7ab25f@linuxfoundation.org> <da260b77-2ecb-4486-90cb-6db456d381ef@linuxfoundation.org> <f5f1c42d-77c0-48c7-ac52-3d4a3b5c2b47@roeck-us.net> <4a8abb5f501279de7907629f4dd6be24.sboyd@kernel.org> <3e1de608-008c-4439-acd2-647a288dcdc0@roeck-us.net> <cd31493888acc2b64a4986954dfa43ae.sboyd@kernel.org> <cb1e0119-6e3e-4fd2-92ea-3fec18f5843d@roeck-us.net>
Subject: Re: [PATCH v8 8/8] clk: Add KUnit tests for clks registered with struct clk_parent_data
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J.Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>, Geert Uytterhoeven <geert+renesas@glider.be>
To: Guenter Roeck <linux@roeck-us.net>, Shuah Khan <skhan@linuxfoundation.org>
Date: Tue, 08 Oct 2024 16:12:02 -0700
User-Agent: alot/0.10

Quoting Guenter Roeck (2024-10-03 21:52:09)
> On 10/3/24 17:42, Stephen Boyd wrote:
> >=20
> > Can you please describe how you run the kunit test? And provide the qemu
> > command you run to boot arm64 with acpi?
> >=20
>=20
> Example command line:
>=20
> qemu-system-aarch64 -M virt -m 512 \
>       -kernel arch/arm64/boot/Image -no-reboot -nographic \
>       -snapshot \
>       -bios /opt/buildbot/rootfs/arm64/../firmware/QEMU_EFI-aarch64.fd \
>       -device virtio-blk-device,drive=3Dd0 \
>       -drive file=3Drootfs.ext2,if=3Dnone,id=3Dd0,format=3Draw \
>       -cpu cortex-a57 -serial stdio -monitor none -no-reboot \
>       --append "kunit.stats_enabled=3D2 kunit.filter=3Dspeed>slow root=3D=
/dev/vda rootwait earlycon=3Dpl011,0x9000000 console=3DttyAMA0"
>=20
> That works fine for me. Configuration is arm64 defconfig plus various
> debug and kunit options. I built the efi image myself from sources.
> The root file system is from buildroot with modified init script.
> kunit tests are all built into the kernel and run during boot.

Thanks. I figured out that I was missing enabling CONFIG_ACPI. Here's my
commandline

./tools/testing/kunit/kunit.py run --arch=3Darm64 \
	--kunitconfig=3Ddrivers/of \
	--qemu_args=3D"-bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd -smp 2" \
	--kconfig_add=3D"CONFIG_ACPI=3Dy" \
	--kernel_args=3D"earlycon=3Dpl011,0x9000000"

Now I can boot and reproduce the failure, but there's another problem.
ACPI disables itself when it fails to find tables.

 ACPI: Unable to load the System Description Tables

This calls disable_acpi() which sets acpi_disabled to 1. This happens
before the unit test runs, meaning we can't reliably use 'acpi_disabled'
as a method to skip.

The best I can come up with then is to test for a NULL of_root when
CONFIG_ARM64 and CONFIG_ACPI are enabled, because the tests
intentionally don't work when both those configs are enabled and the
'of_root' isn't populated. In all other cases the 'of_root' missing is a
bug. I'll probably make this into some sort of kunit helper function in
of_private.h and send it to DT maintainers.

---8<----
diff --git a/drivers/of/of_kunit_helpers.c b/drivers/of/of_kunit_helpers.c
index 287d6c91bb37..a1330e183230 100644
--- a/drivers/of/of_kunit_helpers.c
+++ b/drivers/of/of_kunit_helpers.c
@@ -36,6 +36,9 @@ int of_overlay_fdt_apply_kunit(struct kunit *test, void *=
overlay_fdt,
 	int ret;
 	int *copy_id;
=20
+	if (IS_ENABLED(CONFIG_ARM64) && IS_ENABLED(CONFIG_ACPI) && !of_root)
+		kunit_skip(test, "arm64+acpi rejects overlays");
+
 	copy_id =3D kunit_kmalloc(test, sizeof(*copy_id), GFP_KERNEL);
 	if (!copy_id)
 		return -ENOMEM;
diff --git a/drivers/of/of_test.c b/drivers/of/of_test.c
index c85a258bc6ae..6cca43bf8029 100644
--- a/drivers/of/of_test.c
+++ b/drivers/of/of_test.c
@@ -38,6 +38,8 @@ static int of_dtb_test_init(struct kunit *test)
 {
 	if (!IS_ENABLED(CONFIG_OF_EARLY_FLATTREE))
 		kunit_skip(test, "requires CONFIG_OF_EARLY_FLATTREE");
+	if (IS_ENABLED(CONFIG_ARM64) && IS_ENABLED(CONFIG_ACPI) && !of_root)
+		kunit_skip(test, "arm64+acpi doesn't populate a root node on ACPI system=
s");
=20
 	return 0;
 }
diff --git a/drivers/of/overlay_test.c b/drivers/of/overlay_test.c
index 19a292cdeee3..3e7ac97a6796 100644
--- a/drivers/of/overlay_test.c
+++ b/drivers/of/overlay_test.c
@@ -64,6 +64,8 @@ static void of_overlay_apply_kunit_cleanup(struct kunit *=
test)
=20
 	if (!IS_ENABLED(CONFIG_OF_EARLY_FLATTREE))
 		kunit_skip(test, "requires CONFIG_OF_EARLY_FLATTREE for root node");
+	if (IS_ENABLED(CONFIG_ARM64) && IS_ENABLED(CONFIG_ACPI) && !of_root)
+		kunit_skip(test, "arm64+acpi rejects overlays");
=20
 	kunit_init_test(&fake, "fake test", NULL);
 	KUNIT_ASSERT_EQ(test, fake.status, KUNIT_SUCCESS);

