Return-Path: <linux-kselftest+bounces-673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB547FAE67
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 00:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5269528154E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 23:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61951495FC;
	Mon, 27 Nov 2023 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H9emDfZb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEF81AD;
	Mon, 27 Nov 2023 15:36:08 -0800 (PST)
Received: from notapiano.myfiosgateway.com (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 1075566022D1;
	Mon, 27 Nov 2023 23:36:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701128167;
	bh=YEe8v7wDFFs3gQgZ9RcTV5I1wDd3U2Sg4ahCaTkprQo=;
	h=From:To:Cc:Subject:Date:From;
	b=H9emDfZbsGRiS+F7o/zTjCwpKOs9ATigOjvWWhy0SbmNQ69YCARc1007iQcAPpPaJ
	 d68ud9ABQ5h4isZTQstZd7TVlnqHPX+5aKqTnST515c8vuv+CdsdgBAmIu2PRQ1o6J
	 KHiWC5kJd7I4I0SWI99sgftn5KTtNDda51pfVjMR/5HjQAbu2WG3eegfZxZQSDEHBg
	 kZ8kQDTJOOkQrAGLZQgsBlcTnAYqgwoEJxwEdYGzT7sispRNN7BzmSS8D9wQbZhQW9
	 HeRoF10/cE7rO/VNqgF7DVIO74rsHEBCma2H6cqN+If86xm+TY7TP7x8AYbEHmH/Pq
	 IWg9QJj2qfGZQ==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Saravana Kannan <saravanak@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	kernelci@lists.linux.dev,
	David Gow <davidgow@google.com>,
	Guenter Roeck <groeck@chromium.org>,
	linux-kselftest@vger.kernel.org,
	linux-usb@vger.kernel.org,
	kernel@collabora.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Tim Bird <Tim.Bird@sony.com>,
	linux-pci@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	devicetree@vger.kernel.org,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/2] Add test to verify probe of devices from discoverable busses
Date: Mon, 27 Nov 2023 18:34:05 -0500
Message-ID: <20231127233558.868365-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Hi,

v1 [1] was discussed during Plumbers [2], where a lot of feedback was given. I
hope to justify the changes in v2 and address the feedback here.

One feedback from Shuah was that keeping per-platform files with the USB/PCI
devices to test as part of the kselftest tree wasn't maintainable. One proposed
alternative was to generate a list of probed devices on a known-good kernel and
use that as a reference. However you need someone to look at that generated
reference to be able to say it is a good one, and you need to save it to ensure
it will be reproducible later anyway, so that wouldn't actually solve the
problem. It is a matter of hand-crafting vs generating the test definitions, but
they will need to be vouched by someone and stored somewhere in both cases.

So for this v2, in patch 2 I just have a sample test definition, and the
per-platform test definitions would be added to a separate repository.

The other feedback received was that the BIOS might reconfigure the PCI
topology (at least on x86), meaning that relying on a sequence of device and
function numbers (eg 1d.0/02.0/0.0) as a stable description of a device on the
platform is not possible. I couldn't verify whether this is really the case (if
you have any more insight into this, please let me know), but with that in mind,
here in v2 I have taken a different approach. Here I'm using the device's
properties which are used for driver matching (the same that show on modalias)
to identify a device in a stable way.

This approach has some drawbacks compared to the one on v1. For one it doesn't
uniquely identify a device, so if there are multiple of the same device on a
platform they have to be checked as a group. Also the test definition isn't as
human-readable.

I'm adding in CC the people I recognized at the Plumbers session that were
interested in this work. Feel free to add anyone missing.

Thanks,
Nícolas

[1] https://lore.kernel.org/all/20231024211818.365844-1-nfraprado@collabora.com
[2] https://www.youtube.com/watch?v=oE73eVSyFXQ&t=9377s

Original cover letter:

This is part of an effort to improve detection of regressions impacting
device probe on all platforms. The recently merged DT kselftest [3]
detects probe issues for all devices described statically in the DT.
That leaves out devices discovered at run-time from discoverable busses.

This is where this test comes in. All of the devices that are connected
through discoverable busses (ie USB and PCI), and which are internal and
therefore always present, can be described in a per-platform file so
they can be checked for. The test will check that the device has been
instantiated and bound to a driver.

Patch 1 introduces the test. Patch 2 adds the test definitions for the
google,spherion machine (Acer Chromebook 514) as an example.

This is the sample output from the test running on Spherion:

TAP version 13
 Using board file:  boards/google,spherion
1..3
ok 1 usb.camera
ok 2 usb.bluetooth
ok 3 pci.wifi
 Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

[3] https://lore.kernel.org/all/20230828211424.2964562-1-nfraprado@collabora.com/

Changes in v2:
- Changed approach of encoding stable device reference in test file from
  HW topology to device match fields (the ones from modalias)
- Better documented test format

Nícolas F. R. A. Prado (2):
  kselftest: Add test to verify probe of devices from discoverable
    busses
  kselftest: devices: Add sample board file for google,spherion

 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/devices/.gitignore    |   1 +
 tools/testing/selftests/devices/Makefile      |   8 +
 .../selftests/devices/boards/google,spherion  |  12 ++
 .../devices/test_discoverable_devices.sh      | 160 ++++++++++++++++++
 5 files changed, 182 insertions(+)
 create mode 100644 tools/testing/selftests/devices/.gitignore
 create mode 100644 tools/testing/selftests/devices/Makefile
 create mode 100644 tools/testing/selftests/devices/boards/google,spherion
 create mode 100755 tools/testing/selftests/devices/test_discoverable_devices.sh

-- 
2.42.1


