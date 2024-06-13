Return-Path: <linux-kselftest+bounces-11870-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 615B090764E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 17:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F043A284AFB
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 15:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1C9149DEA;
	Thu, 13 Jun 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s+SIb8m7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AA51487CD;
	Thu, 13 Jun 2024 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291713; cv=none; b=oALmS5FQVXnT5DIOSlNyzX1FOGRXhmIP6+YMxTAiMq9WcHP+gjLGegjO2O6ub2ktg0sHHxh5jKmdQX1yimrI0f0tSy5VxBJbYL1It6EGYcuEu0Z+YlV5x3nmAbnIjFNNd+9WbIaxWev+min8F5qFXdL4L6J/j3IGSxU85OWCtL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291713; c=relaxed/simple;
	bh=t/eY+5amVbYdVfLNwgvmcm+ME/BSXGaq3JlqdY9LQw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=un5wC9fEsQudEt7RWecyr68AVGqAiSq5aUXbsYdhPEJdFsZdD3wQqjgMHiRKnvZGjKQ/RI0fnptP+ziIhxnz1K+dG/xQpvn45OJZo+p7vPm/WbApJHTLUX3Zzc6snM8WMfvi2Fi8E/qI5kqpC+Oi1cEpbzGW6AjcnqQyehupYGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=s+SIb8m7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718291710;
	bh=t/eY+5amVbYdVfLNwgvmcm+ME/BSXGaq3JlqdY9LQw4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s+SIb8m7d6Byws7aoikJCu3GZeNVGgEIYHysob5H/EwBt49v1ADkj78FMubweX13P
	 X9Yg1bs/xXiDETC0xR26jTUQgkKhQx/zCerpEjdoK2bmP0J2VJgq6zmCKmaNxFwHOD
	 JPjZM0rm1L91wMxl3QbYbRYlskscvsaqhmQcPR57rWJeC/wdC2C+mD8YEIwiVRd2+Z
	 ZzQJf8Dys4MW/8hIpxHMllZLU2hZ46B4nqoRFTBQfRIwoiJfh0v6izrh6Trm6ovdY+
	 bs5tN60JGghLVVU+dYPxRJgXPGtjRZJQDCq5g+RhqyczpuxqsdSjyHY1THsAGnFEJl
	 8nAjs+ND/xeYA==
Received: from [192.168.1.250] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A01E63781F9A;
	Thu, 13 Jun 2024 15:15:09 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 13 Jun 2024 11:14:51 -0400
Subject: [PATCH 1/2] kselftest: devices: Allow specifying boards directory
 through parameter
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240613-kselftest-discoverable-probe-mt8195-kci-v1-1-7b396a9b032d@collabora.com>
References: <20240613-kselftest-discoverable-probe-mt8195-kci-v1-0-7b396a9b032d@collabora.com>
In-Reply-To: <20240613-kselftest-discoverable-probe-mt8195-kci-v1-0-7b396a9b032d@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernelci@lists.linux.dev, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Add support for a --boards-dir parameter through which the directory in
which the board files will be searched for can be specified. The
'boards' subdirectory is still used as default when the parameter is not
specified.

This allows more easily running the test with board files supplied by an
external repository like
https://github.com/kernelci/platform-test-parameters.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../testing/selftests/devices/test_discoverable_devices.py  | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/devices/test_discoverable_devices.py b/tools/testing/selftests/devices/test_discoverable_devices.py
index fbae8deb593d..19f28ea774f4 100755
--- a/tools/testing/selftests/devices/test_discoverable_devices.py
+++ b/tools/testing/selftests/devices/test_discoverable_devices.py
@@ -14,6 +14,7 @@
 # the description and examples of the file structure and vocabulary.
 #
 
+import argparse
 import glob
 import ksft
 import os
@@ -296,14 +297,24 @@ def run_test(yaml_file):
         parse_device_tree_node(device_tree)
 
 
+parser = argparse.ArgumentParser()
+parser.add_argument(
+    "--boards-dir", default="boards", help="Directory containing the board YAML files"
+)
+args = parser.parse_args()
+
 find_pci_controller_dirs()
 find_usb_controller_dirs()
 
 ksft.print_header()
 
+if not os.path.exists(args.boards_dir):
+    ksft.print_msg(f"Boards directory '{args.boards_dir}' doesn't exist")
+    ksft.exit_fail()
+
 board_file = ""
 for board_filename in get_board_filenames():
-    full_board_filename = os.path.join("boards", board_filename + ".yaml")
+    full_board_filename = os.path.join(args.boards_dir, board_filename + ".yaml")
 
     if os.path.exists(full_board_filename):
         board_file = full_board_filename

-- 
2.45.0


