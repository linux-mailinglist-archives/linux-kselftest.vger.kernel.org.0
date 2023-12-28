Return-Path: <linux-kselftest+bounces-2510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A33FD81FC19
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Dec 2023 00:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370F11F212DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Dec 2023 23:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DB710A0A;
	Thu, 28 Dec 2023 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD5uAs/1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2113310A00;
	Thu, 28 Dec 2023 23:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F3EC433C7;
	Thu, 28 Dec 2023 23:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703807630;
	bh=AtXCWBZ3/hv7kak8skJj92km/jnX8jl2+Cn2Spna3ts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JD5uAs/1LZEK6k8suyobstsdyxgvjmREdGq1Ruc1dPJ8Cb1dReom3Z6Rhz4IaTFAU
	 IbD1wsLGISDXayB2Wz4VOZ6uwj+uWdtGhrAguNsvSJn5c5eC1/hS2cgpNHjgrNvaaB
	 T/j9Ru3/2cuWJsXRq6Q3JQVTa1gBpCf8JiR4NxnbubfIYnrrTHN/M1dOwKMHxYD339
	 Ibj3wklQoo0bUgX02Y1yTNCIOQj6TDixFnRfZeHcQ/aGKWhRmdwlh983iyE2kUTm5R
	 UnJnaqtZg8qh6orsRYd013WT9d4RGQKx3qPNzwd73/3kdSZ0a4nBu0Ss9ISkrW/yj+
	 bmK1XF7GhL1tw==
Date: Thu, 28 Dec 2023 17:53:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, kernelci@lists.linux.dev,
	kernel@collabora.com, Tim Bird <Tim.Bird@sony.com>,
	linux-pci@vger.kernel.org, David Gow <davidgow@google.com>,
	linux-kselftest@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Doug Anderson <dianders@chromium.org>, linux-usb@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Guenter Roeck <groeck@chromium.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 0/3] Add test to verify probe of devices from
 discoverable busses
Message-ID: <20231228235348.GA1559485@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227123643.52348-1-nfraprado@collabora.com>

I have no opinion about the patches themselves, but just a heads-up
that "busses" may be regarded as a misspelling of "buses", e.g.,
https://lore.kernel.org/r/20231223184720.25645-1-tintinm2017@gmail.com,
I'm guessing because codespell complains about it.

Git grep says there are almost as many instances of "busses" as
"buses" in the kernel, so I don't go out of my way to change them.
Just FYI, doesn't matter to me either way.

Bjorn

