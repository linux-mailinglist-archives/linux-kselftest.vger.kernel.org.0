Return-Path: <linux-kselftest+bounces-11133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 648948FA555
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 00:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0011F222FC
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 22:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511C413C9BD;
	Mon,  3 Jun 2024 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbRzgWfi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE0113C91F;
	Mon,  3 Jun 2024 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717452124; cv=none; b=Bu+ZgwHxxbiVTdWNgdK1YkLS7ornT+DeL+Ifoq3Jik04SDRLBAatKN8UJqaM3ekf8yfG0JZrh8wWsDEcpbNcueeLRpPG17I+wasB+lrN8an6ljje9DLLTvhXSJBaTRsUiAeP058LYFUHW/dFQBjUYhv/d5VZD1yukP4FSlTWsdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717452124; c=relaxed/simple;
	bh=djC34ORqw2xb3Cf7QYPDabOUVU/AAmQubNKuizP0gBg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=MME8c1aDgZzKR2dIU1T57v79dehSE+yCQCAKIPQpesZb/JB/Y1Nw9E24Y6NZGVB4yYouts4rz9Bc8EG5mmEDFV6xX/mmYTTkgRmhhKMLvfiZ5naIA3AXRORPvmMrYSPBi4E5OeMCX4gjqR6geNMj7uHcka5WlWWcELEY3mpZYRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbRzgWfi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867CAC2BD10;
	Mon,  3 Jun 2024 22:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717452123;
	bh=djC34ORqw2xb3Cf7QYPDabOUVU/AAmQubNKuizP0gBg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=tbRzgWfixxLCCAnv86IJhJm3P/kq8T5W9Nv/ov0UFl8E8KFqBurN17GHgyofXsMrD
	 pgEPlwTODDI97U0KPzHTUvLA7ro/O/NMFPJrBkuEgEaok154AUrdZQMLkqhmgBH04b
	 F2nARv+gmHL8NxRGcT+bgM6wnJIvk45H8jqzl7soKWoFCwPpiwJIlR2OQ73F7cwkLG
	 /rVtdIACiJNv8VJjbNht4RoaTqve4DGL4AapG1+dsnMuOJaIIAAxFwdDVJhgSRuhKl
	 nduLa666srYuD7qNk06xHNEAfGKdiRszER/GhC/naKhAWhdng7C+rirXbplWGnD9E+
	 APXqfKXj/LK8A==
Message-ID: <ac141363f0b6c44b11c421f752776ef9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240422232404.213174-7-sboyd@kernel.org>
References: <20240422232404.213174-1-sboyd@kernel.org> <20240422232404.213174-7-sboyd@kernel.org>
Subject: Re: [PATCH v4 06/10] dt-bindings: kunit: Add fixed rate clk consumer test
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 03 Jun 2024 15:02:01 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-04-22 16:23:59)
> diff --git a/Documentation/devicetree/bindings/test/test,clk-fixed-rate.y=
aml b/Documentation/devicetree/bindings/test/test,clk-fixed-rate.yaml
> new file mode 100644
> index 000000000000..b9f58cba944c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/test/test,clk-fixed-rate.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/test/test,clk-fixed-rate.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: KUnit clk fixed rate test clk consumer

Removed KUnit from the title.

> +
> +maintainers:
> +  - Stephen Boyd <sboyd@kernel.org>
> +
> +description:
> +  A clk consumer of a fixed rate clk used to test the fixed rate clk
> +  implementation.
> +
> +properties:
> +  compatible:
> +    const: test,clk-fixed-rate

None of this is really fixed rate clk specific. I'm going to rename this
to "test,single-clk-consumer" so that it can be used anywhere we want to
consume a single clock cell. Someone can introduce a double/multiple
binding as needed.

> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-consumer {
> +      compatible =3D "test,clk-fixed-rate";
> +      clocks =3D <&fixed_clk>;
> +    };
> +...

