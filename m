Return-Path: <linux-kselftest+bounces-11139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9318FA5AB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 00:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAB21F23EFB
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 22:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A55B13D258;
	Mon,  3 Jun 2024 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPc50aNm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE96013D24F;
	Mon,  3 Jun 2024 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454296; cv=none; b=Z3HPQa8/M2HDCeySKi1q31Wm6h/exUezwSbNPol07whLJ5N6AHpdVqM4+68i1qL+W/LBSEgT6fHw8LoH0+jJCtYqu6+hUU8R3zkVEvZfUBq4MPyFX225q/94n3Lmb7YaoUMNFLYpbBGrCcS3iZnClavcPNQ5y+6ScFabMLHpBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454296; c=relaxed/simple;
	bh=wxvLpOW05IZBhoJ42Z143u9/Maq90L38LvE9Gw8PR+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZP4sUPMWVzDTSL4h2p0D2ZRj8s7SZdXu+tNKpxJDvpuw9OpEcdyntAZPjCK/JB3LWcBDnwKPW5ffJjmhP72pY2AaKT1bgX57ejnzYQDOnTsqQ6BtLp7OXoy+ZIAvlTH/neHEPfhxBotNLPxDaY1FTHJsJFWzCLy122z9Z/cSR4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPc50aNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC6EC32782;
	Mon,  3 Jun 2024 22:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454295;
	bh=wxvLpOW05IZBhoJ42Z143u9/Maq90L38LvE9Gw8PR+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PPc50aNmOSKQrpMjFdFU6Rb1ZIRY8y2FSPjOR73zZIjMSIyqLuEoFLplfEBph5D4m
	 s0itCD2FqQSuep+trzNv4Yq0xJ5Zme7VPL+Y7mKrNdL+juLXRc28zRBlnlVDt8Pnn8
	 SYO56Sxfk5jSAKXvz5oHNixC/J5wfFFc7+M4H9ZfYd0f9f8oumGBuJJ5BzJg92BEFh
	 7iXLe7t49T42tjz9bEmt5RNglE+nF2Rm7vNvni4JrbVql+5SShLKUrAvixbwnX3K8u
	 Uz+nLikpwjn6zOZFDR4ycdvy9pP0bbYjUyxQb0xFyMx1J/kK5YgBrq3EaCPeVSuKai
	 t7Tk3NhGJSGGg==
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
Subject: [PATCH v5 03/11] dt-bindings: vendor-prefixes: Add "test" vendor for KUnit and friends
Date: Mon,  3 Jun 2024 15:38:00 -0700
Message-ID: <20240603223811.3815762-4-sboyd@kernel.org>
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

Add the vendor prefix "test" to reserve a vendor prefix for bindings
that are purely for testing device tree code. This allows test code to
write bindings that can be checked by the schema validator.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: David Gow <davidgow@google.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbf47f0bacf1..02a22c2722ec 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1456,6 +1456,8 @@ patternProperties:
     description: Terasic Inc.
   "^tesla,.*":
     description: Tesla, Inc.
+  "^test,.*":
+    description: Reserved for use by tests. For example, KUnit.
   "^tfc,.*":
     description: Three Five Corp
   "^thead,.*":
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


