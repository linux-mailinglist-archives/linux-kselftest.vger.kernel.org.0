Return-Path: <linux-kselftest+bounces-20696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C3E9B0F53
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 21:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80332B270E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 19:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B179B20F3D0;
	Fri, 25 Oct 2024 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BgYrs3ek"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F6920BB2E;
	Fri, 25 Oct 2024 19:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729885572; cv=none; b=OfJNuOQ+VyYv2QnHxWdQ2l+ZVeeMnCHtTycM/qjx2EgVeXAdqkFC7jNFJaQu/s2R5dRTYi89vYkgOqMRR+tPLHETgHogZRNbxE4rzOvOGaeLn6lTGR0SoLNdGG4qogb6fLADB5BVd06Jegc90idro5F1NOabTJU7vTVmQJCeH9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729885572; c=relaxed/simple;
	bh=a1xD5U+KJRHHHihCSOYqaYazM7sD048UvQTjfIB42Gs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fFjrJbcW5Zq+Z0bXujINIgSYXe01TkdSdP0p4E0blddIQmytZYPbZqS5x2G2SGBw6xaH8gor6npGXQdFHoBmKrOgpo9O9j0jrMDFdA0EmHoMg+vWXOBNbuQA9fI625W7HopV0oUDPcGCT5SM7zIZa3X9FpU6emKZbqa2GQUt2rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BgYrs3ek; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729885568;
	bh=a1xD5U+KJRHHHihCSOYqaYazM7sD048UvQTjfIB42Gs=;
	h=From:Subject:Date:To:Cc:From;
	b=BgYrs3ekdOayxKEFAUcDI91I69Pms2obdaqO60iGnJ+8ccKCq+VqafhPQliizIHv2
	 4/Om4Yu589ezyURJsJqv4HmTZmRQ0bIRkLyXIhhWdsZvV7fbdVJK7xLUuQ9DnEZlG6
	 R/ZjygaS8Y0NGtodknIvfvg+Mhfzj4hq3SORioMWnx3ykaCuGIS2ZP2AK93ttOPA5A
	 wF0Gv6sKFJ+hkGAfHQbzI0xcI5VktsE4SCHngYoRNgToH3lCXZGihUZ/kV/9QUsrdd
	 T3jufgDRuN2iiogTP0S2o7IqebXyfot3eEEngGO0DIeZbEfA4ZBgCuMeKUEw3xT9Ji
	 x6O8hHrJY1O6g==
Received: from [192.168.1.54] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 85DC217E3704;
	Fri, 25 Oct 2024 21:46:06 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH RFC v2 0/5] Verify bias functionality for pinctrl_paris
 driver through new gpio test
Date: Fri, 25 Oct 2024 15:45:35 -0400
Message-Id: <20241025-kselftest-gpio-set-get-config-v2-0-040d748840bb@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF/1G2cC/4WNTQrCMBCFr1JmbSSpNlJXguAB3EoX6ThpB9tOS
 UpRSu9uKO5dPHg/8L0FIgWmCOdsgUAzR5YhhXyXAbZuaEjxM2XIdX7UpbbqFanzE8VJNSOLipR
 MEsrguVGWirq2J43GFZAYYyDP743/gPvtClUqW46ThM/2OZtt+uHLP/jZKK2MddoWzuMBzQWl6
 1wtwe1ReqjWdf0C88Dq29MAAAA=
X-Change-ID: 20240906-kselftest-gpio-set-get-config-6e5bb670c1a5
To: Sean Wang <sean.wang@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bamvor Jian Zhang <bamv2005@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mediatek@lists.infradead.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 kernelci@lists.linux.dev, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

This series was motivated by the regression fixed by 166bf8af9122
("pinctrl: mediatek: common-v2: Fix broken bias-disable for
PULL_PU_PD_RSEL_TYPE"). A bug was introduced in the pinctrl_paris driver
which prevented certain pins from having their bias configured.

Running this test on the mt8195-tomato platform with the test plan
included below[1] shows the test passing with the fix applied, but failing
without the fix:

With fix:
  $ ./gpio-setget-config.py
  TAP version 13
  # Using test plan file: ./google,tomato.yaml
  1..3
  ok 1 pinctrl_paris.34.pull-up
  ok 2 pinctrl_paris.34.pull-down
  ok 3 pinctrl_paris.34.disabled
  # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Without fix:
  $ ./gpio-setget-config.py
  TAP version 13
  # Using test plan file: ./google,tomato.yaml
  1..3
  # Bias doesn't match: Expected pull-up, read pull-down.
  not ok 1 pinctrl_paris.34.pull-up
  ok 2 pinctrl_paris.34.pull-down
  # Bias doesn't match: Expected disabled, read pull-down.
  not ok 3 pinctrl_paris.34.disabled
  # Totals: pass:1 fail:2 xfail:0 xpass:0 skip:0 error:0

In order to achieve this, the first three patches expose bias
configuration through the GPIO API in the MediaTek pinctrl drivers,
notably, pinctrl_paris, patch 4 extends the gpio-mockup-cdev utility for
use by patch 5, and patch 5 introduces a new GPIO kselftest that takes a
test plan in YAML, which can be tailored per-platform to specify the
configurations to test, and sets and gets back each pin configuration to
verify that they match and thus that the driver is behaving as expected.

Since the GPIO uAPI only allows setting the pin configuration, getting
it back is done through pinconf-pins in the pinctrl debugfs folder.

The test currently only verifies bias but it would be easy to extend to
verify other pin configurations.

The test plan YAML file can be customized for each use-case and is
platform-dependant. For that reason, only an example is included in
patch 3 and the user is supposed to provide their test plan. That said,
the aim is to collect test plans for ease of use at [2].

[1] This is the test plan used for mt8195-tomato:

- label: "pinctrl_paris"
  tests:
  # Pin 34 has type MTK_PULL_PU_PD_RSEL_TYPE and is unused.
  # Setting bias to MTK_PULL_PU_PD_RSEL_TYPE pins was fixed by
  # 166bf8af9122 ("pinctrl: mediatek: common-v2: Fix broken bias-disable for PULL_PU_PD_RSEL_TYPE")
  - pin: 34
    bias: "pull-up"
  - pin: 34
    bias: "pull-down"
  - pin: 34
    bias: "disabled"

[2] https://github.com/kernelci/platform-test-parameters

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v2:
- Added patches 2 and 3 enabling the extra GPIO pin configurations on
  the other mediatek drivers: pinctrl-moore and pinctrl-mtk-common
- Tweaked function name in patch 1:
  mtk_pinconf_set -> mtk_paris_pin_config_set,
  to make it clear it is not a pinconf_ops
- Adjusted commit message to make it clear the current support is
  limited to pins supported by the EINT controller
- Link to v1: https://lore.kernel.org/r/20240909-kselftest-gpio-set-get-config-v1-0-16a065afc3c1@collabora.com

---
Nícolas F. R. A. Prado (5):
      pinctrl: mediatek: paris: Expose more configurations to GPIO set_config
      pinctrl: mediatek: moore: Expose more configurations to GPIO set_config
      pinctrl: mediatek: common: Expose more configurations to GPIO set_config
      selftest: gpio: Add wait flag to gpio-mockup-cdev
      selftest: gpio: Add a new set-get config test

 drivers/pinctrl/mediatek/pinctrl-moore.c           | 283 +++++++++++----------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |  48 ++--
 drivers/pinctrl/mediatek/pinctrl-paris.c           |  26 +-
 tools/testing/selftests/gpio/Makefile              |   2 +-
 tools/testing/selftests/gpio/gpio-mockup-cdev.c    |  14 +-
 .../gpio-set-get-config-example-test-plan.yaml     |  15 ++
 .../testing/selftests/gpio/gpio-set-get-config.py  | 183 +++++++++++++
 7 files changed, 395 insertions(+), 176 deletions(-)
---
base-commit: a39230ecf6b3057f5897bc4744a790070cfbe7a8
change-id: 20240906-kselftest-gpio-set-get-config-6e5bb670c1a5

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


