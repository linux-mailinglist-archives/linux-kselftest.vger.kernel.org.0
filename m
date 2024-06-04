Return-Path: <linux-kselftest+bounces-11220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74C88FBD90
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 22:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDC8282D16
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 20:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B329E14BF85;
	Tue,  4 Jun 2024 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtzebJxR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDAA14AD20;
	Tue,  4 Jun 2024 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534427; cv=none; b=tt9IDQ3g8OhyAD50FuQoT88DafeXFIDiKSqEZDJOYKW0rvkUehktaaK6TbCcQOE+tha/BxJJ5q1tKAg9V9tSD6lex85cB63nhjj1e2kTlK0/Rv+sD4EmpzlBQ4494t9cckNVPsthJIbfgnjnRYTslLM8KO66kR99w44Z0X9GTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534427; c=relaxed/simple;
	bh=dETldA+Uc3dn/2mRGg3NI1fmIioFc+Mu4RQpJ7i8mHI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=TNgQlPnpyYI/+R+sGXNtGIRaufWTZU0v1XnBhmXWWAaAzl78ixeBQCAs32bOea1qtI5Y2j6aXEDPui8CxV7biAWUahk+r0dMzc7++QxWJjwqRuDTYRaT+EGugxFInIToe0qcvKViV+azRCZWxIs3PEJE5sPWsdRt0m68eAu6t7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtzebJxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6F8C2BBFC;
	Tue,  4 Jun 2024 20:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717534427;
	bh=dETldA+Uc3dn/2mRGg3NI1fmIioFc+Mu4RQpJ7i8mHI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=mtzebJxRwhstbSAwjrrlOpacnZt5VvbrKBhixvPQfL4Ma3zZsmjysR5EXhoHmSZlt
	 rZIXr/QwSb24TjxyOrhW1F48sgvIY4xy5AqfFHpKAdXuQY40Q7y+xVSHmVthDs3BG1
	 Im9J755bSUUDJZiQ62csE2N0zrW0JfNG7puRCmIoJeb82g59vg53ECrV+rS8oOOA7i
	 SBxTbiDA3xwr05hKS4rP2NqquQfqbVK5eYL3gEjW3jkrU6F7YVTu68g6qxM5LvBZ3A
	 E2swq4tF2uSGTJnpHXmZXg/XasLHReeWL9iJsmuVNkVmkuMcs/9afQcsNs9c7Ug+pP
	 c25HDMkUAVdjw==
Message-ID: <912d8de4856d52c7bbced7104b95c0ad.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAL_Jsq+mGbW=4RbF+E1knvQco+5b1s7Tk8=2wyo9rT48Q=zkFQ@mail.gmail.com>
References: <20240603223811.3815762-1-sboyd@kernel.org> <20240603223811.3815762-8-sboyd@kernel.org> <20240604130526.GA12945-robh@kernel.org> <cce5a85e48f35f5ad5464a2443ca972e.sboyd@kernel.org> <CAL_Jsq+mGbW=4RbF+E1knvQco+5b1s7Tk8=2wyo9rT48Q=zkFQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] dt-bindings: test: Add single clk consumer
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: Rob Herring <robh@kernel.org>
Date: Tue, 04 Jun 2024 13:53:44 -0700
User-Agent: alot/0.10

Quoting Rob Herring (2024-06-04 13:19:18)
>=20
> Yes, but I just added it for you.

Oh, we'll probably want to update checkpatch as well to ignore test
vendor prefix.

