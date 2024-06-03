Return-Path: <linux-kselftest+bounces-11143-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B828FA5BD
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 00:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7EB81F22D1A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 22:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4931A13D62E;
	Mon,  3 Jun 2024 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJvadQhb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1B13D619;
	Mon,  3 Jun 2024 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454300; cv=none; b=Yrv66fN3ZLz0s51o+zZlt1vX/rLWS1p8H8YLXv3+Zx9m+a77oVvM4H+WEj1TATec0jIb8NETylkKThTWRn4Asx0tj5rfKAtYgUgIcbb3bPSlPCwiZClVsyux9PkpuYf6byRdv+MvLxjnWfJIMFfKZE+BpGPmPAqL/8hXhFgRmpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454300; c=relaxed/simple;
	bh=469X2JKZ0g03+k9+5uxrzFAjuN3p7Y/r6p3KLMLUt+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oU1PQgFkkOwfB3gfXbsmDAkiC4Xrc6z3bhZXdmS8hM0wgnhKfXRZ4BgLf+Aijpwln27VxP8Z+zdCPnuW3hpm7EG+2lTYKOwma0o5YKnI1FcReYkpisbj4lJlnVUictroXCVF7h/ZdHhjTwDjrTz6Ccro/EVxv3GhTOppb7dDXhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJvadQhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C43C4AF08;
	Mon,  3 Jun 2024 22:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454300;
	bh=469X2JKZ0g03+k9+5uxrzFAjuN3p7Y/r6p3KLMLUt+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJvadQhb/PC0fkbJ8+bgdxh4RQ2bvFoSZ6bjY2N7lE3heiQTVcRA4ErMOvZvB2iTe
	 vUYHhlLL5+7r1Es1t+2RnGYB4HcVe7v5Hz6Ovk2PYJShVcv1vjWoD9ggbn3HPqTrpl
	 AAKCg41etEJCHlrmGWYdCyz1JrF1ds5e6CNeZd5WJ6itP0ZFg3SvtZ8s150vQ03dGM
	 +cDujppM7PeV35g57IcNLIqoV4q4Kwi7m/BcfulRMKtS2oxOoySozK7MiQiA+3bPos
	 51RVVtJTJfmyO60IryCuj3uJDyj2/KJLNkdn8UT0c/YIR3zQcHb4m2AgDj9E+t2SR3
	 ljWSUxrIe8nvA==
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
Subject: [PATCH v5 07/11] dt-bindings: test: Add single clk consumer
Date: Mon,  3 Jun 2024 15:38:04 -0700
Message-ID: <20240603223811.3815762-8-sboyd@kernel.org>
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

Describe a binding for a device that consumes a single clk in DT. This
will initially be used by a KUnit test to clk_get() the clk registered
by of_fixed_clk_setup() and test that it is setup properly.

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 .../test/test,single-clk-consumer.yaml        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/test/test,single-clk-consumer.yaml

diff --git a/Documentation/devicetree/bindings/test/test,single-clk-consumer.yaml b/Documentation/devicetree/bindings/test/test,single-clk-consumer.yaml
new file mode 100644
index 000000000000..8c384c48707d
--- /dev/null
+++ b/Documentation/devicetree/bindings/test/test,single-clk-consumer.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/test/test,single-clk-consumer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Test consumer of a single clock
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+
+description:
+  A consumer of a single clock used in tests.
+
+properties:
+  compatible:
+    const: test,single-clk-consumer
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


