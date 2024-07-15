Return-Path: <linux-kselftest+bounces-13752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4266D931AF0
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 21:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35992832E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 19:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0333A13AD06;
	Mon, 15 Jul 2024 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqRqWAd9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EF413A25D;
	Mon, 15 Jul 2024 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721071545; cv=none; b=TpflnN+vgscyHvSgGBfK4cJTyXOqDpJVgJ9TkbIgYQ82MBb2XizQEL7MX7Iw4MpEljtz4kqmrXjKEbteKemJSZnIfLliEs8Z8GFJRjjePFJH7Tv+EXDGqfym31eej2IvPY11+5xg7t7IAfN+50mS7NQHZe+820QpA1fwBzx6quM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721071545; c=relaxed/simple;
	bh=Chxr3Uuks9kyNfIoyGNkVK4Vg2r6tdc6gwgnwyG63do=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=bOu13gRcwWox1NeYF6szuJce0pUxwoHZYF4vVYZrv1ARmiMBGjMYdqfYXku5DlYjVJpApUg4FiThBUbMTZtrHR7EtWZL4DP301JImDD6twbg5JfVlL9YlnwLXA0QMysERP89F8aRysODmRw8uqDL2kRiE0jbdhVt/d6cN9mQ53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqRqWAd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8821BC4AF0A;
	Mon, 15 Jul 2024 19:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721071545;
	bh=Chxr3Uuks9kyNfIoyGNkVK4Vg2r6tdc6gwgnwyG63do=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=kqRqWAd9bcejprhPo+5fMo5mIy3NShY7I5tA4bsem2pl0PPB+6CSBTb/X7NKnayvq
	 xkDHsKl/hqmm8PDRT62rFfFw6CVIw2OkSSCN2PkqslCqo0F6oZjvnKN31qkXXMEq2k
	 o4SE8V8rAM4NVKjYRK7VrZRI85g0BRXWLrvrcpa76kHau//q/vC5RlmhpMeU40Fy8l
	 5aDoHjzDdbUvaCo5u3xBgcKF7kW669Lt5ZM1PjddWBT+k6DtB44UE3u2T0zuuXKbI9
	 kIoV+N4i5p+ZlI//Mu2Sbl8N1BqA0QH7zfal+oXMQ7/aY02QCc2D8+EERaJi+RWM2A
	 ImXaho6pi62+A==
Message-ID: <97c4bc36e2584cc5258cd9feb0b283a3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240710201246.1802189-9-sboyd@kernel.org>
References: <20240710201246.1802189-1-sboyd@kernel.org> <20240710201246.1802189-9-sboyd@kernel.org>
Subject: Re: [PATCH v7 8/8] clk: Add KUnit tests for clks registered with struct clk_parent_data
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Date: Mon, 15 Jul 2024 12:25:43 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-10 13:12:44)
> Test that clks registered with 'struct clk_parent_data' work as
> intended and can find their parents.
>=20
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Reviewed-by: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

