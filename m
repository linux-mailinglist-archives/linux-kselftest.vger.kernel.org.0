Return-Path: <linux-kselftest+bounces-14515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E234942945
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 10:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8301F228FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51E11A8BE1;
	Wed, 31 Jul 2024 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnpP+5oW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFDA1A7F86;
	Wed, 31 Jul 2024 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414901; cv=none; b=ORzXGfTqyI4FGcKz6sDdEZwQh3mJVb+SKljRftOYf12mpItwGPZAmzwJiABIk9VPFN5pmSA6AiC4tJojelj+jSJZgjgu6KatUUE3bcH3zcruEQWpq10C8F8uggSyG4tfsjmB0IaVbIYUE6wIJefEgyIKeZ/gwDLb36LKHoV0n8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414901; c=relaxed/simple;
	bh=05ht8ctkPisuuS9oYm2U1tCisPpW/jJnLjCQjhAXk4Y=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=hXAiZ1IOwjSnDau1jofF2p861iiL5A1XvEtuXT014sgG8S2oa7OlJDyk77gNQxbMuDZtcvmShoCfZGMNTxyFifChTqXucGoBNnRDPV9rbi/H5m98yfoF+jDNZ3hyKC+oY/0qPNd4vTVODp5+aNew/qMpqa0GusVaPJuPmrB8x0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnpP+5oW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5EFC116B1;
	Wed, 31 Jul 2024 08:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722414901;
	bh=05ht8ctkPisuuS9oYm2U1tCisPpW/jJnLjCQjhAXk4Y=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=bnpP+5oWtgudiiBuGmXUMF3wOZ7NuBA6pggp57SVyrQkFa2B4fgnCCnI3+ic5SjME
	 25J/dM+9dI4qc1IADshSSbUGBuL5Kr6VrK8pgnLFaPFzQFx8QbVEY+x1yCRnfmyE6U
	 zLgRPR/cPpAmuR2mp52LHoqXh/ie4s8svDT3CXFlu6lrWRPYD0g4YDDSDfVe0jqRTj
	 28dy7hvtbPf3EIMD3aQmgiWFhr1vrL8efzVhrR/RG4oTaPvJBA2s1bG706X7VmGt7O
	 VT+LnWmzOxE+YMg+odjrMCVNi6vPgUKUGwdyd1quYvKahCvSGx04b6EqDnUlEZa63J
	 xPg83aTpWT9sA==
Message-ID: <938af9c931203f2d2cba5332be3e530b@kernel.org>
Date: Wed, 31 Jul 2024 08:34:58 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "David Gow" <davidgow@google.com>
Subject: Re: [PATCH] kunit: Device wrappers should also manage driver name
In-Reply-To: <20240731070207.3918687-1-davidgow@google.com>
References: <20240731070207.3918687-1-davidgow@google.com>
Cc: kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, "Brendan
 Higgins" <brendan.higgins@linux.dev>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Kees
 Cook" <kees@kernel.org>, "Matti Vaittinen" <mazziesaccount@gmail.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Nico Pache" <npache@redhat.com>, "Rae Moar" <rmoar@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

On Wed, 31 Jul 2024 15:02:06 +0800, David Gow wrote:
> kunit_driver_create() accepts a name for the driver, but does not copy
> it, so if that name is either on the stack, or otherwise freed, we end
> up with a use-after-free when the driver is cleaned up.
> 
> Instead, strdup() the name, and manage it as another KUnit allocation.
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

