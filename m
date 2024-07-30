Return-Path: <linux-kselftest+bounces-14483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AC4941F4D
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 20:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0661F1C21658
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 18:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F06F189902;
	Tue, 30 Jul 2024 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtwDbNbm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759C91A76CA;
	Tue, 30 Jul 2024 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363209; cv=none; b=NKXf/5pTU0HJlQvQDF3odFV0XJ1dXvsKzAtD7wi1bUnF6mjVsjHScpaMhuXwA0iSAOEuWwNnFhRESwNkFuZL+CmW2kaNmuab23/pUh3BD3u5K966dtH1pzU8qQz5vleQJvY2/GUCa2ZOK/IDtvZqQo7injZ6jXAsW8ZFd/BLWwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363209; c=relaxed/simple;
	bh=5pGAoIXpSCo5ZatiPwppi7lW++5Tf9Q3c4l0hTvG+0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7b4mK8Xvps+jVF95mxKknICmzpqzLYZNrErXjKVPkUBpIwGodaNB3Mr5tdukYkG3MMwaqlOONrVAm7xw2DRhSn4z09rSJ33R4SiB6btvjR2NVVGumtXclwkHZh4cF4awcvNmM7shdKYtRIDnkseFGMhcml01JbO9WWZwT53/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtwDbNbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A343EC32782;
	Tue, 30 Jul 2024 18:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722363209;
	bh=5pGAoIXpSCo5ZatiPwppi7lW++5Tf9Q3c4l0hTvG+0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YtwDbNbmwecSTk3y40ZEwP41G/55pyx+0OMT8APQYBIEcTY8E72ovijrrTvqececG
	 J24r5gp8tHkurbab5uLyQCbrjC21DsKqctYj+laSMMiwCXkGbBMbJ3O3ZnNwAolyjE
	 tN+hRvD6yOzQi0qlu2mZAQLAmFII0aMcpjPZ6Hcg3/aQVA+ih8pPDPv5bbOGc8s2Tm
	 DASyjAdjpgY6sKN4Ri59aMuCDqgLykHOPWOaYzgbxzcwldaxiBJn6Dg+AeN+93UquP
	 edboo6jMFPp8lmjgmfx0ypr1bfuR91ezbhSF8N0sowhD8qNfCoGyVK4epiw4cHYjjZ
	 einx8J3TT0AHg==
Date: Tue, 30 Jul 2024 11:13:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Shuah Khan <shuah@kernel.org>, Joe Damato
 <jdamato@fastly.com>, Petr Machata <petrm@nvidia.com>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: net: ksft: support marking
 tests as disruptive
Message-ID: <20240730111327.2dc367b8@kernel.org>
In-Reply-To: <ZqkStZ9UHfcYBG9L@mini-arch>
References: <20240729221042.2700882-1-sdf@fomichev.me>
	<20240729221042.2700882-2-sdf@fomichev.me>
	<20240729190013.5b0743e7@kernel.org>
	<ZqkStZ9UHfcYBG9L@mini-arch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 09:20:05 -0700 Stanislav Fomichev wrote:
> SG! The patch you reference is doing it in NetDrvEnv* but I'll probably
> try to keep most of the code in 'core' ksft. So far I'm thinking about
> adding some ksft_setup(env) to initialize that disruptive=yes/no state.
> LMK if you prefer me to keep everything in NetDrvEnv instead (or wait
> until I send out a v2 later today).

Yup, core is cleaner, agreed. I haven't spent the time to investigate
how to hook it in properly but both DISRUPTIVE and VERBOSE are really
core settings. Just to state the obvious, would be great to maintain
the ability to load the settings from a file (_load_env_file())
It's convenient not to have to re-export after reboot or when SSH
session dies.

