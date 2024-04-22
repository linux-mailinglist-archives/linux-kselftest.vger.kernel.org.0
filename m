Return-Path: <linux-kselftest+bounces-8646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D098AD917
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 01:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8CFE28716C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 23:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14CD1474D8;
	Mon, 22 Apr 2024 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj4L0KBI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4C13FD71;
	Mon, 22 Apr 2024 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828253; cv=none; b=CaI5s5BwFkR97dZiqBDNRaaI2E14x2YngUoCZdAhyQcMeMYaaW7o5fWp8SrG25BAhk1VRCmQ7IucKiwOJ7vxMKlsApsLazHbQ11m0ecwwuHjWstFyzVhXA0F7FTfCJDqaQHEqBXCNTBF+gN/nnHF2a2U/OYSJkKTwuU9yLxRgoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828253; c=relaxed/simple;
	bh=O0SBhxpsnp1Sc1JQzxFViruQQyQ4DAJXXTgts6Jan3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWniSI8RuW9HkCJWbOvC/aiZzat3U4zOfYtvEMJG9UHpLGkq2DxyhnwBN9EPCihcpx7SDsG8/SMPszVF9u87RtC6fDWdh5axkxGEQgTyugoiPtX7AbrKYxWtmkJO4MZo8Z8b1T4jMfbPWa+PJFSgpa58hxuHQJnwpoNzX+rIegc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj4L0KBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80706C32782;
	Mon, 22 Apr 2024 23:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713828253;
	bh=O0SBhxpsnp1Sc1JQzxFViruQQyQ4DAJXXTgts6Jan3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nj4L0KBIFk48fxasEv2sz7zSWzTUt6WT286UXH6snR3i0Q/EaTQ4zSCT4AW5V7vfQ
	 +exGkGYqzwi8XjL/txcHd27esnX/SK7YKUwPk93Txf/PMB/kEiYCFlLIvh+AQ5C/HD
	 Z2AMYFRnplIS3p+EgyOjxDbz1q0hhYYkNIaibf5ir886+0/3QTWIT+hGs5zOUeoqkm
	 30xZPOFARX5WtG8AxSm2oaaj+Rwj9EE/RcmZyDeyPoXpmWhrDUoyU5v4X8jZtXASLF
	 S/2OfLpNxLlgbJVfjPM1MlIQJYnZaSnfalOzs3jFqv68qgXgbbXGQ8YPsuiI5y5qXx
	 JzpaeOTiAWZag==
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
	Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 06/10] dt-bindings: kunit: Add fixed rate clk consumer test
Date: Mon, 22 Apr 2024 16:23:59 -0700
Message-ID: <20240422232404.213174-7-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240422232404.213174-1-sboyd@kernel.org>
References: <20240422232404.213174-1-sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe a binding for a device that consumes a fixed rate clk in DT so
that a KUnit test can get the clk registered by of_fixed_clk_setup() and
test that it is setup properly.

Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 .../bindings/test/test,clk-fixed-rate.yaml    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/test/test,clk-fixed-rate.yaml

diff --git a/Documentation/devicetree/bindings/test/test,clk-fixed-rate.yaml b/Documentation/devicetree/bindings/test/test,clk-fixed-rate.yaml
new file mode 100644
index 000000000000..b9f58cba944c
--- /dev/null
+++ b/Documentation/devicetree/bindings/test/test,clk-fixed-rate.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/test/test,clk-fixed-rate.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: KUnit clk fixed rate test clk consumer
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+
+description:
+  A clk consumer of a fixed rate clk used to test the fixed rate clk
+  implementation.
+
+properties:
+  compatible:
+    const: test,clk-fixed-rate
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-consumer {
+      compatible = "test,clk-fixed-rate";
+      clocks = <&fixed_clk>;
+    };
+...
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


