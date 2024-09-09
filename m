Return-Path: <linux-kselftest+bounces-17539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BBF9721EC
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 20:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B206B1F24054
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 18:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C3718952A;
	Mon,  9 Sep 2024 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="b5OE9DTd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621171891D1;
	Mon,  9 Sep 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725907098; cv=none; b=niKhEQ8xsWyCRK4CUSs9hmxgTRZXsp3wcrN8s5xyKG35fxftmiRnznyVuHgGoGd6XzyF16gwTSickBM5WSRzjovXuouSiP4Xl3q8P3RGtXugRq+SudxSXjmUzHIW3TQf2pgMa16UGgHHsjH/b3zi5RktnjAp3l/0S3KSvItW9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725907098; c=relaxed/simple;
	bh=QvSdxTDvn8AaYy6kGpwsljEiMhfwzV+X7Yjh0q69b1g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JCNb0ltoTYjQ7syhdUxHT+Bc+YCe/K46fU1lHEDUWUfdqkqosaGsxVfrL5VhckPddX244/C8xebr6EE+mPzNe26lGDDUtCznpyYmNrOwcj88x8vabjUec12Zfn+kSexa1yLiAYEQR5+VGApwpzMGF0NsRVyAIpivakgR2FbiOpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=b5OE9DTd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1725907093;
	bh=QvSdxTDvn8AaYy6kGpwsljEiMhfwzV+X7Yjh0q69b1g=;
	h=From:Subject:Date:To:Cc:From;
	b=b5OE9DTdhoalVXxxeEAxJs4KvmlVPW5zCkFstuELc2cLUW/NE0RqPnFPm7z1ebPof
	 qldjWVxBgavSO3WPNll69gLZLM36jEABuWO4sRRSwtH6Y7gKH4TpK9LN1ZaJJWtjTD
	 M5eO3wwC9V6126wbdoFtMdRg4mQZVfotachXYMl4qqVvuhiY218LIojdijtOy877L8
	 jn1yompLUoI+9TeJ5Y0L3m6UTsHeZV/tlgwu2uLWg6U60p1/GxtNIGi4jgvK/MHUZs
	 6FyljcO5m99Ko+EgN1ZDirIqhnqIR3g4AXv3aHmqd6O5al+L1cOhZVYpO1p6EVzygw
	 CR3jFj0T+Q4AQ==
Received: from [192.168.1.95] (pool-100-2-116-133.nycmny.fios.verizon.net [100.2.116.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A441217E35FB;
	Mon,  9 Sep 2024 20:38:11 +0200 (CEST)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH RFC 0/3] Verify bias functionality for pinctrl_paris driver
 through new gpio test
Date: Mon, 09 Sep 2024 14:37:31 -0400
Message-Id: <20240909-kselftest-gpio-set-get-config-v1-0-16a065afc3c1@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGtA32YC/x2MwQrCMBAFf6Xs2YW0tBG9Cn6AV/HQxpe4KEnJl
 iKU/ruLh4GZy2ykqAKlc7NRxSoqJVu0h4bCa8wJLE9r6lzXu5Pz/FZ84gJdOM1SWGFihJKjJPY
 YpskfXWjHgewxV0T5/v93ul0v9Nj3H+YIlT10AAAA
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
X-Mailer: b4 0.14.1

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

In order to achieve this, the first patch exposes bias configuration
through the GPIO API in the pinctrl_paris driver, patch 2 extends the
gpio-mockup-cdev utility for use by patch 3, and patch 3 introduces a
new GPIO kselftest that takes a test plan in YAML, which can be tailored
per-platform to specify the configurations to test, and sets and gets
back each pin configuration to verify that they match and thus that the
driver is behaving as expected.

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
Nícolas F. R. A. Prado (3):
      pinctrl: mediatek: paris: Expose more configurations to GPIO set_config
      selftest: gpio: Add wait flag to gpio-mockup-cdev
      selftest: gpio: Add a new set-get config test

 drivers/pinctrl/mediatek/pinctrl-paris.c           |  20 +--
 tools/testing/selftests/gpio/Makefile              |   2 +-
 tools/testing/selftests/gpio/gpio-mockup-cdev.c    |  14 +-
 .../gpio-set-get-config-example-test-plan.yaml     |  15 ++
 .../testing/selftests/gpio/gpio-set-get-config.py  | 183 +++++++++++++++++++++
 5 files changed, 220 insertions(+), 14 deletions(-)
---
base-commit: 6a7917c89f219f09b1d88d09f376000914a52763
change-id: 20240906-kselftest-gpio-set-get-config-6e5bb670c1a5

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


