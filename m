Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE9A7ADC7B
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 17:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjIYP6T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 11:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjIYP6S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 11:58:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8250B92;
        Mon, 25 Sep 2023 08:58:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:b07:646b:e2:e4be:399f:af39:e0db])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: laura.nao)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 58A83660730D;
        Mon, 25 Sep 2023 16:58:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695657490;
        bh=pWW4E+juaK7sF2s3dY0MCFnnwr1NNNbo05xJAUGYROA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ls0Xjum/CtdmRFRNcGlGFVV91i4W5NGWQBarpZh8bf2tuql3/484rhRUzosm61Fkz
         XeFO6yosnwhD1iMuW6v6UebEVR4DVGWcs/xMDhybzV0k8I8oW8dEXiY7VcWhpjqgg4
         1iQ87heThFs7/BvP4xnEUV/E7brWT00zqhw3NurWGQUCjy6sgRt7YHPC+xr9T92TqQ
         BIdIAUWbLAfNY/Bg6TzwVI007mD6949+ArZvts/+OxKCUVP9khlk+0Ews2VXYG2Jbe
         e4UpgrrnjqQViZHYuniMt9Eo8mcnfY3E3dxDfCmuKfBg0JnO1QMb90SmJPFpkeQ/c4
         aags64so693TQ==
From:   Laura Nao <laura.nao@collabora.com>
To:     rafael@kernel.org, lenb@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kselftest@vger.kernel.org, groeck@chromium.org,
        broonie@kernel.org, robh+dt@kernel.org, kernelci@lists.linux.dev,
        kernel@collabora.com, Laura Nao <laura.nao@collabora.com>
Subject: [RFC PATCH 1/2] acpi: Add script to extract ACPI device ids in the kernel
Date:   Mon, 25 Sep 2023 17:58:05 +0200
Message-Id: <20230925155806.1812249-2-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230925155806.1812249-1-laura.nao@collabora.com>
References: <20230925155806.1812249-1-laura.nao@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a script to extract all the supported acpi device ids
from kernel sources.

The list of IDs returned by the script can be used as a
reference to determine if a device declared in the ACPI namespace
with certain _HID/_CID is supported by the kernel or not.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 MAINTAINERS                   |  1 +
 scripts/acpi/acpi-extract-ids | 60 +++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100755 scripts/acpi/acpi-extract-ids

diff --git a/MAINTAINERS b/MAINTAINERS
index 27751573e314..7540316d82f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -294,6 +294,7 @@ F:	drivers/pnp/pnpacpi/
 F:	include/acpi/
 F:	include/linux/acpi.h
 F:	include/linux/fwnode.h
+F:	scripts/acpi/acpi-extract-ids
 F:	tools/power/acpi/
 
 ACPI APEI
diff --git a/scripts/acpi/acpi-extract-ids b/scripts/acpi/acpi-extract-ids
new file mode 100755
index 000000000000..12c8e09281dd
--- /dev/null
+++ b/scripts/acpi/acpi-extract-ids
@@ -0,0 +1,60 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Heavily inspired by the scripts/dtc/dt-extract-compatibles script,
+# adapted for the ACPI use case.
+#
+
+import os
+import glob
+import re
+import argparse
+
+
+def parse_acpi_device_ids(file):
+    """ Find all device ID strings in acpi_device_id struct """
+    id_list = []
+
+    with open(file, 'r', encoding='utf-8') as f:
+        data = f.read().replace('\n', '')
+
+        for m in re.finditer(r'acpi_device_id(\s+\S+)?\s+(\S+)\[\](\s+\S+)?\s*=\s*({.*?);', data):
+            id_list += re.findall(r'\"(\S+)\"', m[4])
+
+    return id_list
+
+
+def print_acpi_device_ids(filename, id_list):
+    if not id_list:
+        return
+    if show_filename:
+        compat_str = ' '.join(id_list)
+        print(filename + ": ID(s): " + compat_str)
+    else:
+        print(*id_list, sep='\n')
+
+
+def files_to_parse(path_args):
+    for f in path_args:
+        if os.path.isdir(f):
+            for filename in glob.iglob(f + "/**/*.c", recursive=True):
+                yield filename
+        else:
+            yield f
+
+
+show_filename = False
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser()
+    ap.add_argument("cfile", type=str, nargs='*',
+                    help="C source files or directories to parse")
+    ap.add_argument('-H', '--with-filename',
+                    help="Print filename with device ids", action="store_true")
+    args = ap.parse_args()
+
+    show_filename = args.with_filename
+
+    for f in files_to_parse(args.cfile):
+        id_list = parse_acpi_device_ids(f)
+        print_acpi_device_ids(f, id_list)
-- 
2.30.2

