Return-Path: <linux-kselftest+bounces-32217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDB7AA797C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 20:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D8B4C7216
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 18:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DCD26AA8A;
	Fri,  2 May 2025 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KZ4By14a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618D826A0EB;
	Fri,  2 May 2025 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746211483; cv=none; b=eLEh3EQc8wOoZzpqEbGmCVu85b9NaqZf1/5C/V+DHu+R5ALTd183d7FZbUoJX+IZIWYwkcNv2fHpqO12eC/dXwOgX9yv79SnM54mbdCYUH9DWWDCDTasL4TiiTEovNw19kVrjWVHsk0g6RrmZgOJAg4sS75zph7pvQKjopcHyTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746211483; c=relaxed/simple;
	bh=L0t+Q1KKJdJN2RacIOBIUr8a8kwGK+c8Yw6UZguXi8g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sU//tnFAShjRoE5MwKj5Tf6UdmnIgpl+ajQDl/jYoPPFrIFTV8svwhwUmScrxjIOvFBVrm40ctTl5eT41wNE9P9gjWkIbzLZpco15N7QrHTernSpksAnNUc82bs2SUGxVFbO2fgTMoZZDmuXgMIayPaNbChRN+siktX6VpEPBag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KZ4By14a; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [40.78.12.133])
	by linux.microsoft.com (Postfix) with ESMTPSA id 877C8211157B;
	Fri,  2 May 2025 11:44:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 877C8211157B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746211482;
	bh=e/k8KYJVXZG2jyZEivOVKZjnNf5Vwltj4SY0RuIsJQg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KZ4By14aATDlHhSvs8SE1JpSNj1a1sDQHCt0duH/OQunP5fDzjWjHwoBZ9BP/dALf
	 FGlS9H0RloPPrrq+OpTPdwEAu0TW/RVBvx+lN/I4wfA0BgLFVu6+s7dQJX//mlyGA3
	 MKIK+VUvbl6QM0UZuW05oc0r1DtOaq8et+fCVz1w=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Jonathan Corbet <corbet@lwn.net>,
	David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	Neal Gompa <neal@gompa.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	xiyou.wangcong@gmail.com,
	Tyler Hicks <code@tyhicks.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: [PATCH v3 3/4] hornet: Add a light skeleton data extractor script
Date: Fri,  2 May 2025 11:44:09 -0700
Message-ID: <20250502184421.1424368-4-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This script eases light skeleton development against Hornet by
generating a data payload which can be used for signing a light
skeleton binary using sign-ebpf. The binary payload it generates
contains the skeleton's ebpf instructions followed by the skeleton
loader's map.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 scripts/hornet/extract-skel.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100755 scripts/hornet/extract-skel.sh

diff --git a/scripts/hornet/extract-skel.sh b/scripts/hornet/extract-skel.sh
new file mode 100755
index 000000000000..9ace78794b85
--- /dev/null
+++ b/scripts/hornet/extract-skel.sh
@@ -0,0 +1,29 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Microsoft Corporation
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of version 2 of the GNU General Public
+# License as published by the Free Software Foundation.
+
+function usage() {
+    echo "Sample script for extracting instructions and map data out of"
+    echo "autogenerated eBPF lskel headers"
+    echo ""
+    echo "USAGE: header_file output_file"
+    exit
+}
+
+ARGC=$#
+
+EXPECTED_ARGS=2
+
+if [ $ARGC -ne $EXPECTED_ARGS ] ; then
+    usage
+else
+    printf $(gcc -E $1 | grep "static const char opts_insn" | \
+		 awk -F"=" '{print $2}' | sed 's/;\+$//' | sed 's/\"//g') > $2
+    printf $(gcc -E $1 | grep "static const char opts_data" | \
+		 awk -F"=" '{print $2}' | sed 's/;\+$//' | sed 's/\"//g') >> $2
+fi
-- 
2.48.1


