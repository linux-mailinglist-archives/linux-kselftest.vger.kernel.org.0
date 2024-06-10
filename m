Return-Path: <linux-kselftest+bounces-11544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86732901B3E
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 08:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6BF1C21277
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 06:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D30C17C66;
	Mon, 10 Jun 2024 06:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzcadobU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88291CF8A;
	Mon, 10 Jun 2024 06:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718000831; cv=none; b=SLt/Z6OIUvOqleFMM5APuOjH8CRStniW+ZCdNNFjPpyXBUyu+R3M5435Dk9h6mZ9R7ON7z1F/xe+jdj0Ng3YnoaTEmBte6SDozlwhWi4JxhrjgLCVeavCruefSL93ABQtvL7dJQfyoVmC2oLkdPpSQGznlWcTeLjA6PbUX7IxtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718000831; c=relaxed/simple;
	bh=46ontKYFYxBeCCy+CgEUCpaMHxEXAnXsVFaJAmuzFd4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ut5it7/ajUhfQlqjUVLNVddZH1OMeREYsWDF4pXxf9O8yAQppYOGPSXoJhdODc0gs9a2NdGSvjJMLH5f+Cfku2tN3mqFqFqFiIpEIFnbK5VOrGijCwQ4lZU0loivQg33H+LxfmU+TL+zHG1CbqFDa7edq11d1k1OvE4kKos0Qrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzcadobU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B88FC2BBFC;
	Mon, 10 Jun 2024 06:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718000830;
	bh=46ontKYFYxBeCCy+CgEUCpaMHxEXAnXsVFaJAmuzFd4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=bzcadobUAHWCAsVpT480gaT0KnUkKTEceCmaDDbtm6xomykD5xW9NEl/cU9kwvlo7
	 d/rM1rTG1tw55LKH1fWQ3/PLw4AD3TfFM4bUvU6VBrrJY1zcdULJKfPPRA5xr33SpV
	 UKRuQkhSCjxeJtl10wwV2fQd2sEwaufKqPrRcSPDONcWRNfgOUonB3LHRPX2ioT3Fi
	 G94UasDurkk8+B806ivHWRipGLfjuvYw+GZlnBOLschWwlYMzWVYaTNWAix4TIoljc
	 TZ1+svjB2kHXJ6rCIqhkWPu7LFLe5pcGnQc1g0OlWvhYJa53wg2jivRsm5AEfdjTXa
	 Hsnz9lqE3/Ryg==
Date: Mon, 10 Jun 2024 00:27:09 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
 Jisheng Zhang <jszhang@kernel.org>, linux-kselftest@vger.kernel.org, 
 Samuel Holland <samuel@sholland.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, Jonathan Corbet <corbet@lwn.net>, 
 Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, 
 linux-kernel@vger.kernel.org, Andy Chiu <andy.chiu@sifive.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Shuah Khan <shuah@kernel.org>, linux-sunxi@lists.linux.dev, 
 devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Evan Green <evan@rivosinc.com>, linux-doc@vger.kernel.org, 
 Guo Ren <guoren@kernel.org>
In-Reply-To: <20240609-xtheadvector-v1-2-3fe591d7f109@rivosinc.com>
References: <20240609-xtheadvector-v1-0-3fe591d7f109@rivosinc.com>
 <20240609-xtheadvector-v1-2-3fe591d7f109@rivosinc.com>
Message-Id: <171800082930.1000302.5109301877296329341.robh@kernel.org>
Subject: Re: [PATCH 02/13] dt-bindings: thead: add a vlen register length
 property


On Sun, 09 Jun 2024 21:45:07 -0700, Charlie Jenkins wrote:
> Add a property analogous to the vlenb CSR so that software can detect
> the vector length of each CPU prior to it being brought online.
> Currently software has to assume that the vector length read from the
> boot CPU applies to all possible CPUs. On T-Head CPUs implementing
> pre-ratification vector, reading the th.vlenb CSR may produce an illegal
> instruction trap, so this property is required on such systems.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  Documentation/devicetree/bindings/riscv/thead.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/thead.yaml: 'thead,vlenb' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'dependentRequired', 'dependentSchemas', 'patternProperties', 'properties', 'not', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240609-xtheadvector-v1-2-3fe591d7f109@rivosinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


