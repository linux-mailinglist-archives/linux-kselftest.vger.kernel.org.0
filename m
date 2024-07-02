Return-Path: <linux-kselftest+bounces-13091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66980924BA7
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 00:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C409DB2214E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 22:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A6D12EBF3;
	Tue,  2 Jul 2024 22:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY4oq/I7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD0C1DA30E;
	Tue,  2 Jul 2024 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719959966; cv=none; b=Y2iZciSXqiRy+gqhnrRuYhuhf2AIWJiXBVedmPY3TS3JrrCc7cH6qSlIoHsByBw2xjKG9bOx81qDvN6APvTopufHXqvAz3sGO34lOC0caJNeag5X/EGgoPTAL98oJZAWAfnH2h6oIb9+ohVS7DaxYORwGLfFRcgCrAnSj8F1s8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719959966; c=relaxed/simple;
	bh=LgnI/y/ID6Jy6F31lOFO9UJIUnQJCf1qYLS9n9iNhAM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=gdfD1TOH4iwuoqIkRMOx9uIS9+yZRbkmsVZ3HgiWtDLxJ4tuZWT+3gL6Fx2+o7sEeagUzvXhJFmMsMcFv95rGFf7XHCH0M4w/nDZuSMBefIR1nChmyww3tEuamZA4wBLGBv0KUy1MPavYsG2gBM2pxWoxmRgUsHgR4VNqsg9qNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY4oq/I7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59534C116B1;
	Tue,  2 Jul 2024 22:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719959965;
	bh=LgnI/y/ID6Jy6F31lOFO9UJIUnQJCf1qYLS9n9iNhAM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=NY4oq/I7w5IZfNPKQcSPPbrf+mR/IhrVFUXlrVxQQXGchIqAFgHzIxznu7UQeAf3+
	 r5kwVgJVg9xCHZAccEJxvWG95SADm+ZQdSsSzAhuDYVbvddjyurP3UYSzR2Se5UUS9
	 MLaFmKTtYwNkODF7N0fjGJq7J7MCiwj64AcybBuRRcmZSqsM9P+a/uVQGb9cssmtNV
	 in4oHMY7hzoQ1QwWZiq/q1epeB37+ivyO3OmOT6eqgtzBkk4aTkujQDjAMsa3O+jcb
	 ki2+UyIFajsB6ky8XlKMwjIwuWltdSzNoIE1HQhYahkPAf4ED4VxLPuc66EI16Jw6o
	 H9G6DSxj0QsQw==
Message-ID: <2863a45a9fa0479707672c52164ceb0d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABVgOS=duqR0Lea0i92pWR-618iRGkvvATk30MJrU7RRDR8LPg@mail.gmail.com>
References: <20240603223811.3815762-1-sboyd@kernel.org> <20240603223811.3815762-3-sboyd@kernel.org> <CABVgOS=duqR0Lea0i92pWR-618iRGkvvATk30MJrU7RRDR8LPg@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] of: Add test managed wrappers for of_overlay_apply()/of_node_put()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: David Gow <davidgow@google.com>
Date: Tue, 02 Jul 2024 15:39:23 -0700
User-Agent: alot/0.10

Quoting David Gow (2024-06-13 00:48:54)
>=20
> This looks good to me.
>=20
> I was a little confused at first by some of the wrapper names: in
> particular that of_overlay_fdt_apply_kunit() is applying the overlay
> immediately, and deferring a cleanup action, but of_node_put_kunit()
> is not doing anything immediately, and deferring the put action. My
> feeling is that the ideal thing would be to have wrappers for all of
> the of_* functions which return a node which needs to be 'put', and
> have those wrappers add an of_node_put() action. You could then have
> of_node_put_kunit() provide a way to trigger that action early. But
> that seems like it'd be a lot of work and generate a lot of wrappers
> we otherwise wouldn't need, so this seems an okay compromise to be
> able to keep using the existing of_ functions. The documentation /
> comments help make this more clear, too.
>=20
> So, no actual problems. (Assuming you don't want to put the
> documentation under the devicetree rather than under KUnit -- it can
> go either way.)
>=20
> Reviewed-by: David Gow <davidgow@google.com>
>=20

Thanks. I'll just leave this alone as I feel like the kunit postfix
means "do stuff when test is done".

