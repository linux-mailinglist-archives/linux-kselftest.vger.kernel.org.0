Return-Path: <linux-kselftest+bounces-13896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EEE9352B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 23:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561091C20C9F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 21:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFA81465AE;
	Thu, 18 Jul 2024 21:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRj/l+J1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5577145B22;
	Thu, 18 Jul 2024 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721336718; cv=none; b=WGMt7cdFvELX5LzyqAKp4g0Co1eXBhESMcVonSvSaKIoX/EZgQBonFA7GnTXGKIvbUCYAj2lbmjIjRI54T/v1vGatCEgIeI9HQey7STZJh2rTKujFdBNEJsK/vPn2Cu2KLsvraS8oM2rwaf6MN2eo+ruiKLSCsDhwcBxuLvFzUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721336718; c=relaxed/simple;
	bh=wxvLpOW05IZBhoJ42Z143u9/Maq90L38LvE9Gw8PR+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4xug22M3jKKoMq1PtQjZbwB1nny+Zgj6ytFgFy4kjZ1TckeIgWMGt1+mhB6KE4UHkgP5psYvU6+UWRfTdIbo6s+loOk5rvswKAn+zT/43fedsxSleay9WdbileqRqp8czlI1lVbe9L5r5T9Z75EvSxrnlj2pqDAmJFskwjeCtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRj/l+J1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5249FC4AF15;
	Thu, 18 Jul 2024 21:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721336718;
	bh=wxvLpOW05IZBhoJ42Z143u9/Maq90L38LvE9Gw8PR+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRj/l+J1znMlhHM0RTvyfFgtJD4hX32+j2O4OEFGJjmlEDrBXRjC8bIJL5B8yvPOg
	 gEY+X0rwninunmHUuDyofarLiJ38+27ZsWqCCPzmJfcUhA5yxiAfLE3cnUZYMsbCoR
	 qjnHofGP42/nfPKp65kdPVbbUzNGKsl5WJcYYWjQkMPUv/w9Nrc7PAkZptqhi7zNHU
	 0404atXt61X69VyHY8+rrk0lZSPpJfnlZCwD27RAiBbY9NK+szNPFvpz9b9fab+6Kk
	 VVeYu5nYSqfDLpjkFIRFyH/nNUSE4dkt4cpRTjIywaWWwQreMFnwoVYx1bTXC/1+Rv
	 5CCZB3GVs85Jg==
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
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v8 3/8] dt-bindings: vendor-prefixes: Add "test" vendor for KUnit and friends
Date: Thu, 18 Jul 2024 14:05:02 -0700
Message-ID: <20240718210513.3801024-4-sboyd@kernel.org>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
In-Reply-To: <20240718210513.3801024-1-sboyd@kernel.org>
References: <20240718210513.3801024-1-sboyd@kernel.org>
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


