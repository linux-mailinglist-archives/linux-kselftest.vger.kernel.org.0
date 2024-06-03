Return-Path: <linux-kselftest+bounces-11140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABF48FA5B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 00:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2143283020
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 22:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BE013D2A6;
	Mon,  3 Jun 2024 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+dM7326"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BDB13D29D;
	Mon,  3 Jun 2024 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454297; cv=none; b=IC5adCuKW+dP8G8R7qnqWgI8xcXoZtTpGsX7YoJTRbvzCrb+cH8VL6jRq/c11AFLoVS1JumZuCGaqniglyq9bUwZLHSYJZHVSvlYiE52MCMk7h/eqMUuRcOFg80aQKJuFBa6zaD3dvWl0hRuz8dgXR3MrpT6D68AHHfzMAXLKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454297; c=relaxed/simple;
	bh=48RSG7/FicYJuswPyflH/1WuDmKoTrKDmJz1ZEqIa6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcAx/vA/cXlcp+vAPbZOzJ5nfGd0sMfthLNPBEW8MF34cx2nViVc9ZzthH1eBw6nxwzwbJEFpVPmz8FDbAkc5TXjt8T5cGtKKEqNOGdgoQlbfuHjl1Z2vmWfSyonpSJkqHb93go0pp5Fy/IKYGcDOUrVkN3uOS+KXS+XG8rHD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+dM7326; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11B2C4AF0A;
	Mon,  3 Jun 2024 22:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454296;
	bh=48RSG7/FicYJuswPyflH/1WuDmKoTrKDmJz1ZEqIa6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+dM7326TBX2TsA2rU/gemSffppyWfE+haTrmupAGraXKdIS/CobTC/iGsrk9x7rz
	 bg0aB3q6vo1bzLHHV/+lCHd9JrAqj8H/HSY1QVbijrydPcxd6nbpNqNtp6btiP99Zk
	 1dAhcjsdlAognkhUlONknBrD4GZSgQyYAnNAObc0ojQHUg1J8F0Odw8sr/XQN/lOU4
	 b1hsltrH++L/gnW/piVL1jWKb8b3GKXO2trrlki2pwynLwDrF8H9+ah8aHiy7EBefY
	 CPlU6r3u4pTFsMIB9tEpbFb5h2GTOSAoO5FMGmlCZS2QrXw7OWAsAjJeAKEYbyUS5d
	 uYaJmQCQ/jriA==
From: Stephen Boyd <sboyd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Daniel Latypov <dlatypov@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <maxime@cerno.tech>,
	Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v5 04/11] dt-bindings: test: Add KUnit empty node binding
Date: Mon,  3 Jun 2024 15:38:01 -0700
Message-ID: <20240603223811.3815762-5-sboyd@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240603223811.3815762-1-sboyd@kernel.org>
References: <20240603223811.3815762-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe a binding for an empty device node used by KUnit tests to
confirm overlays load properly.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 .../devicetree/bindings/test/test,empty.yaml  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/test/test,empty.yaml

diff --git a/Documentation/devicetree/bindings/test/test,empty.yaml b/Documentation/devicetree/bindings/test/test,empty.yaml
new file mode 100644
index 000000000000..030df7123af1
--- /dev/null
+++ b/Documentation/devicetree/bindings/test/test,empty.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/test/test,empty.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Empty node
+
+maintainers:
+  - David Gow <davidgow@google.com>
+  - Brendan Higgins <brendan.higgins@linux.dev>
+
+description:
+  An empty node to confirm tests can load device tree overlays.
+
+properties:
+  compatible:
+    const: test,empty
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    kunit-node {
+      compatible = "test,empty";
+    };
+...
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


