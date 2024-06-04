Return-Path: <linux-kselftest+bounces-11216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DCE8FBBB0
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 20:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B93C287215
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFE414A612;
	Tue,  4 Jun 2024 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeCjGfAV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1624149DE2;
	Tue,  4 Jun 2024 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717525699; cv=none; b=JbREdxtos2LL24QoWBMXpUY0JkplzjpvB25/2RoZJ0fZ0apdMUllyrYYOTt/x3r23dozrBSapyxWrNbsWYiG7FvUHsl/133+IPnYpUZ0K2B0GzS+yCJubDT1qNdMemfZuJg6NwdrWi1luF8AE1WKJoY7HstMiH6f1K+B/UkdbBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717525699; c=relaxed/simple;
	bh=kIEYUuEX7E2+uY0Qphw9+ECQqMwNwRaCDQiB6eHl2Wk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=X2D3Da0J/9D2vl5YEf0q1vVgRH358oBQNHlotVlmAFkmdSdqAaQoNdOZ+3SkLHUEzalD1gDdZ5H9tTC+JQyyNIi5x9fbqwmpKBsR/hoTLQ15xyZrQJN1jKJesIt9X8hS8YNgQH2spy26TLMoOajE5qISfYEJDr+WLBlPWMF/XI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeCjGfAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ACDC2BBFC;
	Tue,  4 Jun 2024 18:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717525698;
	bh=kIEYUuEX7E2+uY0Qphw9+ECQqMwNwRaCDQiB6eHl2Wk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=QeCjGfAVAn1A/3hD8DsW+EqwbJolKBt/+3CWR7T2tZyxomLtQ0RlP5QzICJZaI4nE
	 9biw15hXJ0DhWOKE4cUOE3s7iKMnXK9hMTCk/Q89XoMKgUM0jah7Dn8oawTFZ97G2X
	 23iZdnyJmTTpD3SMblGEl7QnM+4Ex44dOsTxa1XsI9txaY/Dp7fCGnQeZL4yhngEf6
	 3QeyThEWO2X/IPFfJ7rsMB6815hMGS6MD/pDaBs2AOhCNEZRiS4B5JTDAYGdaR8GE+
	 BSnLyTq0xlO3E3rJFgrX78mk5Tfj7PBbx+oTJrqhvJF1BcexSofNjgMjwjpmqc3w5n
	 lCdGovF9ENnNw==
Message-ID: <cce5a85e48f35f5ad5464a2443ca972e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240604130526.GA12945-robh@kernel.org>
References: <20240603223811.3815762-1-sboyd@kernel.org> <20240603223811.3815762-8-sboyd@kernel.org> <20240604130526.GA12945-robh@kernel.org>
Subject: Re: [PATCH v5 07/11] dt-bindings: test: Add single clk consumer
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Rob Herring <robh@kernel.org>
Date: Tue, 04 Jun 2024 11:28:16 -0700
User-Agent: alot/0.10

Quoting Rob Herring (2024-06-04 06:05:26)
> On Mon, Jun 03, 2024 at 03:38:04PM -0700, Stephen Boyd wrote:
> > Describe a binding for a device that consumes a single clk in DT. This
> > will initially be used by a KUnit test to clk_get() the clk registered
> > by of_fixed_clk_setup() and test that it is setup properly.
> >=20
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > Cc: Conor Dooley <conor+dt@kernel.org>
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Rae Moar <rmoar@google.com>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  .../test/test,single-clk-consumer.yaml        | 34 +++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/test/test,single-=
clk-consumer.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/test/test,single-clk-con=
sumer.yaml b/Documentation/devicetree/bindings/test/test,single-clk-consume=
r.yaml
> > new file mode 100644
> > index 000000000000..8c384c48707d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/test/test,single-clk-consumer.y=
aml
> > @@ -0,0 +1,34 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/test/test,single-clk-consumer.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Test consumer of a single clock
> > +
> > +maintainers:
> > +  - Stephen Boyd <sboyd@kernel.org>
> > +
> > +description:
> > +  A consumer of a single clock used in tests.
> > +
> > +properties:
> > +  compatible:
> > +    const: test,single-clk-consumer
>=20
> I don't know if there's much value in defining bindings for tests. We=20
> could alternatively make 'test,' opt out of everything. There's already=20
> some support in dtschema for this with 'foo,'.
>=20
> I need something for the DT unittest as well.=20
>=20

Ok. So I should drop this patch and the other one that adds a binding
for the fake clock provider? And replace it with something that makes
the test vendor prefix opt out of all checking? How is that done?  Some
patch to dtschema directly?

