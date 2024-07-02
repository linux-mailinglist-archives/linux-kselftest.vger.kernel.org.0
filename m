Return-Path: <linux-kselftest+bounces-13083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF57D924A0E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 23:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CB12810C4
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 21:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFC3201248;
	Tue,  2 Jul 2024 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frvUd9Qt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959311E49B;
	Tue,  2 Jul 2024 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719956761; cv=none; b=uW34bNf3+zK88RXde/43/ZA0JDzQPYihQ32GV/KwoLj12CQH1GOdoQ68Zsqa86neOqnFPyVbRc9mcevh8aJVCtNeGBRkNIzHLk+pO7G5Sgkh5Q4Y88yjPpf0NbU541CmxG1KitVluhCAlxblBlioNjHnNX9e83qSuoGy6zQXKY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719956761; c=relaxed/simple;
	bh=EVDeS5bhZaQNx/z3pwDmSAZD7O83XESQxLMheWbjE80=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=mhyeAkpsU0coAkGNYcaTpu2mcb3xUekg3Weie7wpwhYIGHdOK8m/DWMg94qNJIHSidOSbuAgo03tNE75lTFl2/pQ27Zo3hzkkxU51Ad9RD8llBrPa/dAEEQIJ/BFITwKFIq83BFHTPIb5q7l0QpbjbrtlDhMi/yvg1a1K1WZ3yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frvUd9Qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C15FC116B1;
	Tue,  2 Jul 2024 21:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719956761;
	bh=EVDeS5bhZaQNx/z3pwDmSAZD7O83XESQxLMheWbjE80=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=frvUd9QtRJ37MpqpTgT8BODw3/ggbDL8D4lWs6f35otWKrNac+/n2h/y9uws76i+U
	 mNeH1FjLnJMY2ZIiKI3BdJTtJnZYeC0asyI/KpnooLztTcODINWv5SPVOQ3hK5CdFY
	 la79rxNre0at+NSqQo9rRcV8+dPL5ac802W0nP9YFL1IXZj+zbTDRpYljwzFwqkbA6
	 RJZC+a6A3yg2ROOesrHbfTLAEah6RSlatWkLejWsZ048FODt/xuhpZQF5sJCcvtHFx
	 2+hUOFzKlcngt8d13UVtRRxJSO+rScI+4BA3MixbGAgdBXXQ6BKG9M24aYI4UURRvF
	 JoqDNL/CSWpEQ==
Message-ID: <051672a1de438842d4a9b20911ba9bfc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOSkASLVve_Ki2HAx34BJDEM=AXzZxNZ8Ji9T5pKq2hER=A@mail.gmail.com>
References: <20240603223811.3815762-1-sboyd@kernel.org> <20240603223811.3815762-6-sboyd@kernel.org> <CABVgOSkASLVve_Ki2HAx34BJDEM=AXzZxNZ8Ji9T5pKq2hER=A@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] of: Add a KUnit test for overlays and test managed APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: David Gow <davidgow@google.com>
Date: Tue, 02 Jul 2024 14:45:58 -0700
User-Agent: alot/0.10

Quoting David Gow (2024-06-13 00:50:10)
> On Tue, 4 Jun 2024 at 06:38, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Test the KUnit test managed overlay APIs. Confirm that platform devices
> > are created and destroyed properly. This provides us confidence that the
> > test managed APIs work correctly and can be relied upon to provide tests
> > with fake platform devices and device nodes via overlays compiled into
> > the kernel image.
> >
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Cc: Daniel Latypov <dlatypov@google.com>
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Cc: David Gow <davidgow@google.com>
> > Cc: Rae Moar <rmoar@google.com>
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
>=20
> This is looking good from my point of view, and passes on my test
> setup. One minor question (do we need both to select OF_OVERLAY and
> skip if it's not enabled?), but otherwise:

We don't need to skip if OF_OVERLAY isn't set because it's forced on for
the test. I'll remove it, thanks.

