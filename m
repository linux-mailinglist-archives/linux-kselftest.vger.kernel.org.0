Return-Path: <linux-kselftest+bounces-30151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C17BA7C5EF
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 23:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9474F3BCA92
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F006E22156A;
	Fri,  4 Apr 2025 21:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NDCGCmIV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B6A1AA79C;
	Fri,  4 Apr 2025 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743803772; cv=none; b=uXET3Ha3eNmOAEOgMpCGw0ICWlag4gX5htaiyTSPhVIFCFcpv2nHyZjEEUlj6SB4W4l3pVB5hWhNbnp1JqwsU7y7kcmoTcTBBMN12OIc2qmFlabRWmgXm0uG2whOFN9dUYDIp9ulq01Uy9FsP0ytErmROmnsdh312RAM+hgXkqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743803772; c=relaxed/simple;
	bh=L0t+Q1KKJdJN2RacIOBIUr8a8kwGK+c8Yw6UZguXi8g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1kRQicTY4mFSrKj06IpautENfO7ZJZKjPNwIeMTzxzH9wyih13z+nzTovwFXnTgh9i2fBf7ABTh38COMyKg/60yaiwnYc+NZoSBcKxpKnQE+xgWBI7AUu6RUiZEeZ+tuRUJ1LRxYTejxdKhVYSTR0d7rq5f9of09Pc7EtmPnZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NDCGCmIV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id BECB02027DF4;
	Fri,  4 Apr 2025 14:56:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BECB02027DF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743803771;
	bh=e/k8KYJVXZG2jyZEivOVKZjnNf5Vwltj4SY0RuIsJQg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NDCGCmIVaicPIJAiVo4z6Q2GBrHNSkxFxinre8CfLiQNsZJSkNnczsAyLCo16Hwoh
	 /uTQQ09d3mh98tLkCbt6vKKO20pZiN+kPnKbS+QlMTJ4QKa/MN7BVYKjKQEIiGMj+n
	 sayVVZvLGByqRrYhdp85Y4SQGFL7zCE8R71cNcLs=
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
	xiyou.wangcong@gmail.com
Subject: [PATCH v2 security-next 3/4] hornet: Add a light skeleton data extractor script
Date: Fri,  4 Apr 2025 14:54:52 -0700
Message-ID: <20250404215527.1563146-4-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
References: <20250404215527.1563146-1-bboscaccy@linux.microsoft.com>
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


