Return-Path: <linux-kselftest+bounces-8349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6DC8A9FE0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 18:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094422833DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 16:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCB316F8F2;
	Thu, 18 Apr 2024 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR5MGKKR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A254923D7;
	Thu, 18 Apr 2024 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457106; cv=none; b=r1/ftAiVbltZPlOOXXtgRBO9Sieztw3R/5m1P1Eaco+LEm2XfoeAvixc4ux30K0y+PniEjOwMlwVgGYCPFEJ7csbAZ6JFCTSg0IRZZnSb/kzH1kSMFfFdBYs5wDBuv5tyKASdaAaG7knFnN/a+JU2cktFFynqgAiZMc4lRFpGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457106; c=relaxed/simple;
	bh=vFLgheje66Qv6l45gylaRtvz0SlV/4DPRUamMmh1528=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=Uj4y6api1bBMouxklBpEM0Mjp9RIuvpzQ8vWkod1usjdhzLst5IAO+3Q1j8OX8Cv1wMc3LlyHwAgaluGar0sc4RwL85SGdor55BpeYs7w+vNAnoHDQO02oB95DuYCL7x89OD6ImGR5ZSaKy16+8NjJT7shyu6awTbIgX9ojz0+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR5MGKKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69A8C113CC;
	Thu, 18 Apr 2024 16:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713457106;
	bh=vFLgheje66Qv6l45gylaRtvz0SlV/4DPRUamMmh1528=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=JR5MGKKRFWuT6H5/kroIKoNFq9foiF9OQGxJGoJDqeN4yDH2ZXpfh8q9CEgSBbeKJ
	 lvLATEUeSSbL2aikZwl/G03CfyuwWLdy+JuqYUYkQC5gXZ18E1pWCOJgEiM9Ym68Uj
	 qU5bqGg1zMcPocqazcPRW591ZPn667rPSyHolSydmbzyMaRN69k7V9awtOb+nto4+n
	 jJLKBp/J5rkbAB3JebRS6JZ8LCCsrTZVGIKTtS7ZFQF0CEpOvC1RyUzRJ1nVsJz775
	 bYf6KwaMH362Ua/As8viNSmseNPV4pbu++WWiBm50cmUNRDbRWnTEacpv0c0Xt/TQ9
	 VcA2H/stu9gGQ==
Message-ID: <37cee03809aee9051d00eff068eaf77c@kernel.org>
Date: Thu, 18 Apr 2024 16:18:23 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Wander Lairson Costa" <wander@redhat.com>
Subject: Re: [PATCH v2 0/2] kunit: fix minor error path mistakes
In-Reply-To: <20240418160039.69993-1-wander@redhat.com>
References: <20240418160039.69993-1-wander@redhat.com>
Cc: "Brendan Higgins" <brendan.higgins@linux.dev>, "David Gow" <davidgow@google.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Matti Vaittinen" <mazziesaccount@gmail.com>, "Maxime
 Ripard" <mripard@kernel.org>, "Rae Moar" <rmoar@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "open
 list" <linux-kernel@vger.kernel.org>, =?utf-8?b?Im9wZW4gbGlzdDpLRVJORUwg?=
 =?utf-8?b?VU5JVCBURVNUSU5HIEZSQU1FV09SSyAoS1VuaXQpIg==?= <kunit-dev@googlegroups.com>,
 =?utf-8?b?b3BlbiBsaXN0OktFUk5FTCBVTklUIFRFU1RJTkcgRlJBTUVXT1JLIChLVW5p?=
 =?utf-8?b?dCk=?= <linux-kselftest@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

On Thu, 18 Apr 2024 13:00:36 -0300, Wander Lairson Costa wrote:
> Hi,
> 
> These two patches fix some minor error path mistakes in the device
> module.
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

