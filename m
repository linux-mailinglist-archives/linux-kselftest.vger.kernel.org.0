Return-Path: <linux-kselftest+bounces-6111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497378766B1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 15:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F96B22001
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 14:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C5B1EA80;
	Fri,  8 Mar 2024 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ItlpOjxi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D51DDFC;
	Fri,  8 Mar 2024 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909389; cv=none; b=SZqibxYNDMCWuQGjFYl7Z3iFz993M5z33wTN7uDuoUGvfHrx15o25/I4KI1AXWdutmBjwrFhTL6eAQ7No/b42sbCoIF6TFpSo2kjCMqPJ1tJ8RTOLNzbUGBlr52ReEx/RGgCebd4djuWCKTLMF4WgWu17XT+L2YKSyyG440/otw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909389; c=relaxed/simple;
	bh=UeS4ZdPkO5z7qjdsXrZyfaBB7u/CUx1wJV4TT44Am5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IWcr3OSICyouzMkedWgH3L5QhWswJkFyUjTkvlyqoq7j+FSKjZn30ZftOeKG7Zj1MJUXbhh4q4AgMD9hNs2aIZlvPzWBhTSqCLZ+wydNSvZFetHpeLU+T9olwKVWdVIaZrJrdzEsChmrHV2GeOcfXZoNCYgj7vRDQV1M6uFfjAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ItlpOjxi; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709909386;
	bh=UeS4ZdPkO5z7qjdsXrZyfaBB7u/CUx1wJV4TT44Am5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ItlpOjxi44qmDdh53IhqmihoatBwxImLDuMOaRLMXy0CKLga9wLa6veY9iWE6BSoL
	 uJMzWQJ+z/MIT5uxDk7FXKzZMhDLJsUlOFTM2Z7J/a3tVHS+UIUNhJhf5Be+g8CvSs
	 pzW26TcPkcsk1n3NqvVUxhBgLfJy7t+SbWeiI5dkYSFas5ibKfBF8grJrfb0NLf8fN
	 uCik8PtXTsgyYeUwPqykkM8Eao9xZ77xXga9SrQlj6guYVg6tVL6T5rRseRdCz7HoA
	 mMSFBk9rjjEdIKmkC5Kx9c3IRekw1Nm4LYifH1Y8N0HM26tYMPrmNf326snuSHJ0ww
	 VzWG9h/241DOw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8FC3837820C3;
	Fri,  8 Mar 2024 14:49:44 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	shuah@kernel.org
Cc: dan.carpenter@linaro.org,
	broonie@kernel.org,
	groeck@chromium.org,
	kernel@collabora.com,
	kernelci@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	robh+dt@kernel.org,
	saravanak@google.com,
	davidgow@google.com,
	Tim.Bird@sony.com,
	dianders@chromium.org,
	Laura Nao <laura.nao@collabora.com>
Subject: [RFC PATCH v2 1/2] acpi: Add script to extract ACPI device ids in the kernel
Date: Fri,  8 Mar 2024 15:49:32 +0100
Message-Id: <20240308144933.337107-2-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240308144933.337107-1-laura.nao@collabora.com>
References: <20240308144933.337107-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a script to extract all the supported acpi device ids
from kernel sources.

The script looks for IDs defined in acpi_device_id structs within both
.c and .h files and prints them. If the -d option is used, the script
only shows the IDs that are matched by a driver, identified through
either an ACPI match table or a list of supported IDs provided by the
driver.

The list of IDs returned by the script can be used as a
reference to determine if a device declared in the ACPI namespace
with certain _HID/_CID is supported by the kernel or not.

Note: this script cannot identify IDs defined via macros.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 MAINTAINERS                   |  1 +
 scripts/acpi/acpi-extract-ids | 99 +++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100755 scripts/acpi/acpi-extract-ids

diff --git a/MAINTAINERS b/MAINTAINERS
index 375d34363777..8333ead448c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -293,6 +293,7 @@ F:	include/linux/acpi.h
 F:	include/linux/fwnode.h
 F:	include/linux/fw_table.h
 F:	lib/fw_table.c
+F:	scripts/acpi/acpi-extract-ids
 F:	tools/power/acpi/
 
 ACPI APEI
diff --git a/scripts/acpi/acpi-extract-ids b/scripts/acpi/acpi-extract-ids
new file mode 100755
index 000000000000..4c492d384a35
--- /dev/null
+++ b/scripts/acpi/acpi-extract-ids
@@ -0,0 +1,99 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Heavily inspired by the scripts/dtc/dt-extract-compatibles script,
+# adapted for the ACPI use case.
+#
+
+import fnmatch
+import os
+import glob
+import re
+import argparse
+
+
+def parse_acpi_device_id(data, match_list=None):
+    """ Find all device ids in acpi_device_id structs """
+    acpi_device_id_list = []
+
+    for m in re.finditer(r'acpi_device_id(\s+\S+)?\s+(\S+)\[\](\s+\S+)?\s*=\s*({.*?);', data):
+        if match_list is not None and m[2] not in match_list:
+            continue
+        acpi_device_id_list += re.findall(r'\"(\S+)\"', m[4])
+
+    return acpi_device_id_list
+
+def parse_acpi_match_table(data):
+    """ Find all driver's acpi_match_table """
+    match_table_list = []
+    for m in re.finditer(r'\.acpi_match_table\s+=\s+(ACPI_PTR\()?([a-zA-Z0-9_-]+)', data):
+        match_table_list.append(m[2])
+
+    return match_table_list
+
+def parse_acpi_driver_ids(data):
+    """ Find all driver's ids """
+    id_list = []
+    for m in re.finditer(r'\.ids\s+=\s+([a-zA-Z0-9_-]+)', data):
+        id_list.append(m[1])
+
+    return id_list
+
+def is_header_file(file):
+    _, extension = os.path.splitext(file)
+    return extension.lower() == ".h"
+
+def parse_ids(file, driver_match=False):
+    with open(file, 'r', encoding='utf-8') as f:
+        data = f.read().replace('\n', '')
+
+    if is_header_file(file) or not driver_match:
+        return parse_acpi_device_id(data)
+    else:
+        match_list = parse_acpi_match_table(data) + parse_acpi_driver_ids(data)
+        return parse_acpi_device_id(data, match_list)
+
+def print_ids(filename, id_list):
+    if not id_list:
+        return
+    if show_filename:
+        compat_str = ' '.join(id_list)
+        print(filename + ": ID(s): " + compat_str)
+    else:
+        print(*id_list, sep='\n')
+
+def glob_without_symlinks(root, glob):
+    for path, dirs, files in os.walk(root):
+        # Ignore hidden directories
+        for d in dirs:
+            if fnmatch.fnmatch(d, ".*"):
+                dirs.remove(d)
+        for f in files:
+            if fnmatch.fnmatch(f, glob):
+                yield os.path.join(path, f)
+
+def files_to_parse(path_args):
+    for f in path_args:
+        if os.path.isdir(f):
+            for filename in glob_without_symlinks(f, "*.[ch]"):
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
+    ap.add_argument('-d', '--driver-match', help="Only print ids that should match to a driver", action="store_true")
+    args = ap.parse_args()
+
+    show_filename = args.with_filename
+
+    for f in files_to_parse(args.cfile):
+        id_list = parse_ids(f, args.driver_match)
+        print_ids(f, id_list)
-- 
2.30.2


