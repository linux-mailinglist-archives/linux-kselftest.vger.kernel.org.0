Return-Path: <linux-kselftest+bounces-19392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F09599756D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 21:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A438F1F22020
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 19:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA821E1C36;
	Wed,  9 Oct 2024 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGRLqNV0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D8B1E1A2D;
	Wed,  9 Oct 2024 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728500832; cv=none; b=KsVs8c15MTsOFGxj3tvoMOuKtK77r6VHRKbpoUSe1eTlvRvhfVdmptfCNI0XA5zsgh82Q12hpnjO5cpc8KYc8tMhzI6xaHiNgYxLfu+WnJcHqHoMoAc5PUy62Oz8IfYt2I5g+t6+odWjYNebytZrpj58cljBIp8bKEl7ZC1wrSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728500832; c=relaxed/simple;
	bh=4YhfyUPTJur7qJRzsElWPQS3vLCvkLgU3avegz4EN2Y=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=PXqJHctmuezFYRTzSnKMM3ixX5yWN7N/Xu6Q6BVDsxfhRW3plYxFGnQmQSPvoPTxKaVLdGBLwux3teIzpcrkunq1B6Y81QP56SD2KC/cIzhh2TouslPQtQNkaOyUOVSue/cDn45ryqL43un2M0/+hkw5VWNWzlJtYc0r7tlFyuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sGRLqNV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAC7C4CEC3;
	Wed,  9 Oct 2024 19:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728500831;
	bh=4YhfyUPTJur7qJRzsElWPQS3vLCvkLgU3avegz4EN2Y=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=sGRLqNV02n9pRRQsPmE0+bdGuK0ZSiJR+hnkoYqhKd/oPWvDtKOC9eMTzNVeQE0B0
	 F0HReY/2YKP7xrDZQ5D8OpU8DtXhhufOgpQdY/yqBYlQ8cLaC4apN5MAsCrEqAi1LI
	 A10Nt40p/jo11FOVMLrp/HQwldHtug3X8bnQbT0GxU63oOjj6woCLT+T4X/hXbvMzW
	 4VbCSPD7VLnKXHt/Q7Eu2S3CR667uY0Xo2Wiu8g37sjinFy7JcXNCC/4b6T2FjMpIh
	 gXqIiomtWTwJpW70OiuG7CHrV01jtk7X3JtWMgUodw+XVc5xKIKYU0GiE9az2+VANU
	 1qjw3YZCruJ4g==
Message-ID: <81668a9199b39fe46cefd256d3eac44c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <594e8e50-8322-480e-ae34-3f8e14f3fe18@roeck-us.net>
References: <20240718210513.3801024-1-sboyd@kernel.org> <879831a8-2039-4cdb-bce2-aefdeb7ab25f@linuxfoundation.org> <da260b77-2ecb-4486-90cb-6db456d381ef@linuxfoundation.org> <f5f1c42d-77c0-48c7-ac52-3d4a3b5c2b47@roeck-us.net> <4a8abb5f501279de7907629f4dd6be24.sboyd@kernel.org> <3e1de608-008c-4439-acd2-647a288dcdc0@roeck-us.net> <cd31493888acc2b64a4986954dfa43ae.sboyd@kernel.org> <cb1e0119-6e3e-4fd2-92ea-3fec18f5843d@roeck-us.net> <ccd372f2754e80d6c01e38a9596bed34.sboyd@kernel.org> <594e8e50-8322-480e-ae34-3f8e14f3fe18@roeck-us.net>
Subject: Re: [PATCH v8 8/8] clk: Add KUnit tests for clks registered with struct clk_parent_data
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J.Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>, Geert Uytterhoeven <geert+renesas@glider.be>
To: Guenter Roeck <linux@roeck-us.net>, Shuah Khan <skhan@linuxfoundation.org>
Date: Wed, 09 Oct 2024 12:07:09 -0700
User-Agent: alot/0.10

Quoting Guenter Roeck (2024-10-08 16:27:37)
> On 10/8/24 16:12, Stephen Boyd wrote:
> >=20
> > The best I can come up with then is to test for a NULL of_root when
> > CONFIG_ARM64 and CONFIG_ACPI are enabled, because the tests
> > intentionally don't work when both those configs are enabled and the
> > 'of_root' isn't populated. In all other cases the 'of_root' missing is a
> > bug. I'll probably make this into some sort of kunit helper function in
> > of_private.h and send it to DT maintainers.
>=20
> Sounds good. Thanks a lot for tracking this down.
>=20
> That makes me wonder though why only arm64 has that restriction. Both
> riscv and loongarch have ACPI enabled in their defconfig files but call
> unflatten_device_tree() unconditionally.
>=20
> Oh well ...

Some of the reason is described in the thread I linked earlier. In
particular, this email from Mark[1]. There's also more comments from
Mark on an earlier patchset[2]. Maybe arm64 will allow it later, and
then we'll be able to revert this skip patch.

[1] https://lore.kernel.org/all/Zd4dQpHO7em1ji67@FVFF77S0Q05N.cambridge.arm=
.com/
[2] https://lore.kernel.org/all/ZaZtbU9hre3YhZam@FVFF77S0Q05N/

