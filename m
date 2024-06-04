Return-Path: <linux-kselftest+bounces-11201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3B58FB330
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 15:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC15FB2A406
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 12:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBF8148855;
	Tue,  4 Jun 2024 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxMknA+X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CA314882B;
	Tue,  4 Jun 2024 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505433; cv=none; b=EQee+zDe1W0JZkNm6wm+sVXxgpIGFyHNM8EWcuF959uwtB/fYrLRjjzY0f8/DLeC95JhVhlOz/RJT4WT0gSvNnAsE64uKwUMGlmRy9mbUMPEjw3Q4TN+K7YQ45G2cT7v4WIicoA8Pyi7O+AYP+RgGni34aahSJ2bzGdEqx0jRd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505433; c=relaxed/simple;
	bh=CLuSD10Auw3b45Rs7wDNc1Y+bI+7e6t/jKqHAQlZhBo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=RBO9NZ4Dk82NMFN+kPHmM0J0RVUE3ZslteipjLwJCHwQ3anqAGwpbDpvPdMUp7IkuKRyCnWNq5RghDh68+0AacLnNrlpe8Vj3DxND5g1MgM0Hx6BQls5TRFv00gANYCRV/AHtzsQnB+mbA9Wkk+VIAz2BJ9UJ/eHSVYVoTh8AL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxMknA+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCD6C3277B;
	Tue,  4 Jun 2024 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717505430;
	bh=CLuSD10Auw3b45Rs7wDNc1Y+bI+7e6t/jKqHAQlZhBo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NxMknA+X6kjkzdJE34TjJfT5bJm+unUH6RIKDrzTQ3rWpldei90v2NMZNZ3eUJB4b
	 7n1NWjjUpL7oovMphxfKQCZdx1bMG5wiGuo7S1VuHhabzglGHjhoiqh7Bft+V5XLgq
	 CQ6lyyCbDcscAzRNeMgLPXwQcGXbW38GJst6eTP9GL1YBJRdlytiZmGDE1KRO84n06
	 GtWLn/d6usN3winasKQcnAThxqfpZlC4Gm6EIcTbTt9OQldb1kHh9/Pgk2Z8VCc7Nz
	 uL8OsWtSCCQdMYHu7mZ5J3QY9pPJrQ3yYUsyPnWxUAnXP77e/7+RR6voWRRKRbZhTC
	 WenSkITJvWQbw==
Date: Tue, 04 Jun 2024 07:50:28 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Daniel Latypov <dlatypov@google.com>, Maxime Ripard <maxime@cerno.tech>, 
 linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, 
 patches@lists.linux.dev, "Rafael J . Wysocki" <rafael@kernel.org>, 
 kunit-dev@googlegroups.com, Christian Marangi <ansuelsmth@gmail.com>, 
 Saravana Kannan <saravanak@google.com>, linux-kselftest@vger.kernel.org, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240603223811.3815762-8-sboyd@kernel.org>
References: <20240603223811.3815762-1-sboyd@kernel.org>
 <20240603223811.3815762-8-sboyd@kernel.org>
Message-Id: <171750542807.3346.5048720218082629186.robh@kernel.org>
Subject: Re: [PATCH v5 07/11] dt-bindings: test: Add single clk consumer


On Mon, 03 Jun 2024 15:38:04 -0700, Stephen Boyd wrote:
> Describe a binding for a device that consumes a single clk in DT. This
> will initially be used by a KUnit test to clk_get() the clk registered
> by of_fixed_clk_setup() and test that it is setup properly.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  .../test/test,single-clk-consumer.yaml        | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/test/test,single-clk-consumer.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/test/test,single-clk-consumer.example.dtb: /example-0/clock-consumer: failed to match any schema with compatible: ['test,clk-fixed-rate']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240603223811.3815762-8-sboyd@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


