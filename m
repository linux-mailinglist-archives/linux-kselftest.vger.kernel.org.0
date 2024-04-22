Return-Path: <linux-kselftest+bounces-8642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC158AD907
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 01:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765B5283F99
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 23:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C92F46436;
	Mon, 22 Apr 2024 23:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg8YbqxU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088A6446D2;
	Mon, 22 Apr 2024 23:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828249; cv=none; b=cWpfMrtvUm2cPeuXI7OkOBTUnZclRcZc+K8ldMHKdQ4Aw3CtUjB7P2/GFKpSFjAPwQStLSVEgf3MJlp7nOP4UB8ktoyb8NYDU3FDhIcNzfQxEYw5ONShN2HhM/sgzraIg90VrxlhYp8ytL++3Lf5IRlVPjKehmuv0R6jvUXmplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828249; c=relaxed/simple;
	bh=1SRlFFallDUQYtJJmru3bvqykh41/LGstlBVs36Xkto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ttr/XhBYhl37dheAheeYgqdglnn3zMtJiF8BHuLRqtfG3TFj9ihTLe8K34pkYzhbPac4NTPjr1WF0DxYl575WlC0yFEsVlayuEoZg2IR4n1zndpe8i63SOXx3Es5Jjt8lr1bsNAwlVqB+dwyyNsBxHQALEgZxzlkGC/LZS+f0+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg8YbqxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DF1C32783;
	Mon, 22 Apr 2024 23:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713828248;
	bh=1SRlFFallDUQYtJJmru3bvqykh41/LGstlBVs36Xkto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jg8YbqxUgp0dbu7ZEh0H3pXZe2ybGjoMobW5AIp1D9wfugLXFap3sl0FBGtQ3OqN5
	 K6IUQ6w+VQFYxn/wk4s6IY9oekPRl42nX4BKqoNzRl6HxDxyEbC1ildY75jnkvQElq
	 zhggAu2cMzx5MEYKwbykPry2Yrxg2KwEPLdAFQFgNe8uwcyjKRzoUKznrO2qjrnJS+
	 ryHl28bH5QRugevkOd2t8MV9hc0Pf0HSQxPtoYMkokZMrYzQR01VnbHueoHzJCfqLg
	 A20H8YW+aWkDAjYKmktze3wt6u173LmpS9s9HfkFC3JwSLWzQ8pRXKTqTqiYLWDMzI
	 w1VKS2mmUbxgA==
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
Subject: [PATCH v4 02/10] dt-bindings: vendor-prefixes: Add "test" vendor for KUnit and friends
Date: Mon, 22 Apr 2024 16:23:55 -0700
Message-ID: <20240422232404.213174-3-sboyd@kernel.org>
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

Add the vendor prefix "test" to reserve a vendor prefix for bindings
that are purely for testing device tree code. This allows test code to
write bindings that can be checked by the schema validator.

Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b97d298b3eb6..e590f5ab539f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1448,6 +1448,8 @@ patternProperties:
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


