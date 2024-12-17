Return-Path: <linux-kselftest+bounces-23443-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E382E9F4550
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 08:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356FA169AB4
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 07:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9680E1D9A47;
	Tue, 17 Dec 2024 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbxekWgh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A04E13D244;
	Tue, 17 Dec 2024 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421264; cv=none; b=BeL9JMwwQXtOwlrHo8E/vysiSgX2jOkOXuRMvRH02tuHeGhmoQPVHkH+TTM/zJNckw0gRVQDdX5kvWgxXvz8P/qFN2MMM7QmRTmUxIT/vAtyZ7aK470I1JBi3QNobrkUaF8WHT5NnxC60SGiNth8MsKYj6V3NfTn+r/5lRpjqtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421264; c=relaxed/simple;
	bh=RX9k1VmegBCx5K+I/yb/Brg71gytyPPuM70sMeD07I4=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=KTGAECgZK6MlubR9NcXHKmSBbyEWt1zp2NPv5giHigXhBtMn5lNw8yTh7XsRKe6WliFQBfxG6TgLo0GZ+lMOQGSVKUDLxoTgyVPIwX0PeA6nopN0CgFQ8JSnS7CL0MCFEnRgMU3sPurcsvSyHLTchUJLEYq8MhNrmBWCODq8kiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbxekWgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF942C4CED3;
	Tue, 17 Dec 2024 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734421264;
	bh=RX9k1VmegBCx5K+I/yb/Brg71gytyPPuM70sMeD07I4=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=ZbxekWgh/0GWDXFIXpU1Vmpz713NEebbw6dPS9jcFBWYoVoCezr6bYKI8eFqkJUit
	 /C3KqHtmYib/a9z3Kkam5Vn9iauekzVv3OovbrZaCXmwKOD/iaZVY0NN/4lfwqbg3S
	 kNENzTUTxGxcAkqTSDVd/FaAD4QTkgHGea6ByHPXmixy1VRxKs5muouphn0AFYXcEs
	 7nYefIbJ8y7SJoMtLCg4dy2dzDnsvDitUXKKKgzc2wgms5hM+QVIXoI1NBijrL5Wi/
	 f3CmButgU9BLUJ8fsIuAstEUWktpVp8R0jOsGbi4hnr3qLzQSboLcwHUG0ROCIuPfg
	 73rJgbn+sbW9Q==
Message-ID: <17fbc356583050369235d1a23456eb2e@kernel.org>
Date: Tue, 17 Dec 2024 07:41:01 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Brian Norris" <briannorris@chromium.org>
Subject: Re: [PATCH v3 2/3] drivers: base: test: Enable device model tests
 with KUNIT_ALL_TESTS
In-Reply-To: <20241216201148.535115-3-briannorris@chromium.org>
References: <20241216201148.535115-3-briannorris@chromium.org>
Cc: kunit-dev@googlegroups.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, "David
 Gow" <davidgow@google.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Maxime
 Ripard" <mripard@kernel.org>, "Rae Moar" <rmoar@google.com>, "\"Rafael J. Wysocki\"" <rafael@kernel.org>, "Rob
 Herring" <robh@kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

On Mon, 16 Dec 2024 12:11:43 -0800, Brian Norris wrote:
> Per commit bebe94b53eb7 ("drivers: base: default KUNIT_* fragments to
> KUNIT_ALL_TESTS"), it seems like we should default to KUNIT_ALL_TESTS.
> 
> This enables these platform_device tests for common configurations, such
> as with:
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

