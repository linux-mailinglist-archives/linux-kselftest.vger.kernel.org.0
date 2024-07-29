Return-Path: <linux-kselftest+bounces-14406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3BF940138
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 00:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B77B283303
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 22:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D038C18F2DA;
	Mon, 29 Jul 2024 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPFMYwIU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBAB18EFE1;
	Mon, 29 Jul 2024 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292645; cv=none; b=InHI7x+d34TP3Xy0AGrI8ra3pA8cqCo+U9Zl6uVx1HJMnWPK79a/e7PhKPFkHuzQ6YpX5V79FhIdmn2Aonf3KnAayP7gxCoEBTlo/oyKUR888sxl4Jul/zYle+H1NCi8ohTakAuEJA5j/8Aik5L23PpOkrnouFT7bRBzNmDqLj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292645; c=relaxed/simple;
	bh=oo/Srlvs6meUpL5z5ZI4NdWZcC53CTdfCuomaeCQPMM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=i/gy6g8ZeqzrVnDASs43cFF+B8pZTL5flwWYhJVL/n1ctDgdEC/f5SYet2Iw4NXNV5GkjKRdtBVraflCehwEqOXpbS5RxfXIbQcDe0F7Q/HGZtK4lrUVid3lpzURFUpFTtDF0YvbvD0XrQSVTq1Xt+QvQ5Osj4p+sQTkgS0LIMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPFMYwIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2758CC32786;
	Mon, 29 Jul 2024 22:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722292645;
	bh=oo/Srlvs6meUpL5z5ZI4NdWZcC53CTdfCuomaeCQPMM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=hPFMYwIUlCQNDOITSDGiBel2UqoAGLGfI2VlwCd5YesSQkPidQdjkWaEseL0CzCFT
	 MbmnMxTYocbxSW175h7+j4Wh2/RG+bIUB32DEk60VUuYSA8SvhGkjlzbAzs8yiTkwy
	 GFYAv8PR0qYbGjwWCaHy/E1pDree73p6mQjaJTk5IIWcsPczguPFSNysgEPpAqDbi+
	 PIZNoXvFZj7JslBpxvT42D+9XV8nXDQpYR+eyJ0xvCVBdcgppOFQOtif1R5zvvifFF
	 ESYO9t0zqDa34EreMTPOViEqPyfJlm39sJMUmxwTMHkHANwUrKgo7+0Hd8BqUUsAdo
	 Mgu1jZxJrenPg==
Message-ID: <be2edca255cfcd93bebe012a9159db22.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240718210513.3801024-4-sboyd@kernel.org>
References: <20240718210513.3801024-1-sboyd@kernel.org> <20240718210513.3801024-4-sboyd@kernel.org>
Subject: Re: [PATCH v8 3/8] dt-bindings: vendor-prefixes: Add "test" vendor for KUnit and friends
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>, Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 29 Jul 2024 15:37:23 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-18 14:05:02)
> Add the vendor prefix "test" to reserve a vendor prefix for bindings
> that are purely for testing device tree code. This allows test code to
> write bindings that can be checked by the schema validator.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: David Gow <davidgow@google.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

