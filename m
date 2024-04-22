Return-Path: <linux-kselftest+bounces-8643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC7E8AD90B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 01:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F92E1F234CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 23:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A48247A79;
	Mon, 22 Apr 2024 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDj6WW14"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593D647A5D;
	Mon, 22 Apr 2024 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828251; cv=none; b=UlFogag4MSt2VuxQbnHDNZYOHSICdJmqBFVy/OAYhyRwaln0Yn2FnMDhMfmooeqz/NIUt3w/unsoN5bdg0CvEHW+z0syB742eGxouIMkHRK3F/WGKiHx9/Ipje9sn8w29UmX2uJdgFqy5b/JCygQvVGUPS+zSIFoHpC+J+P1OHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828251; c=relaxed/simple;
	bh=txKmNSr8LNl8Z0ZZQPe8/hRye88uVkUopMU/72zJRCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+VZOHYK924BeoY+WFxrm1on+sh/kVlsjUO5engpU3+D8BQOV8E+d06mJGCYXB9Kn6CWqOyp6xNZBrgm7hTtykmFMQZmP/OJirxAU9H8m9mBwyzHCcaj47sCX73JaIDmz3GWQzN0G9hLKknG1NEESiLXI6uHGoP81rC0I02t2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDj6WW14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B94CC32782;
	Mon, 22 Apr 2024 23:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713828249;
	bh=txKmNSr8LNl8Z0ZZQPe8/hRye88uVkUopMU/72zJRCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qDj6WW140Kx+6G8grecWdo+EX8FPEHtY+Q5w4jNkXgbdycxViUEivJvuzMeCzHbfh
	 IikszwgSqotqO72X/EEXEsWSbPmQK8nJ30jVoJ7AWfvyq9BH34IEi1BaXvp1F01xXM
	 bNCmQXTbtFFY36vAbiv1WUKWvKe+TrVAGfOsIXvxO33UuDscYJRAuPQUdxskikRyEp
	 WMixHqvFF2+AxrTI/ABf73h3WOwPCv6+skZCPbYtxwlcpwVOjVm8sLxw9n0utPly9S
	 24wTFyYrKks/c5tH5oF/duEcU/iTkuDW/M8R9nhZ0hh7BAEd0ozUfMTPRZeNrOOIlX
	 OmfKBVE2P0W1Q==
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
Subject: [PATCH v4 03/10] dt-bindings: test: Add KUnit empty node binding
Date: Mon, 22 Apr 2024 16:23:56 -0700
Message-ID: <20240422232404.213174-4-sboyd@kernel.org>
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

Describe a binding for an empty device node used by KUnit tests to
confirm overlays load properly.

Reviewed-by: Rob Herring <robh@kernel.org>
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
index 000000000000..20dc83b15bbf
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
+  - Brendan Higgins <brendanhiggins@google.com>
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


