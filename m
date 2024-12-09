Return-Path: <linux-kselftest+bounces-23098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C419EA2C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 00:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E611885B05
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 23:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AE01FF7BE;
	Mon,  9 Dec 2024 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F53pHC6S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6611FD7A3;
	Mon,  9 Dec 2024 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786763; cv=none; b=KSFlJI66vAhQ97lds9LF1iydAgPCRqaK7sz1LxpGetwF16o/n527qbKsqIsEwlxDj0kFKpDIF+MZS7RpeanrZtiOidCkR7ctn+NULT8hEPEC3eZ7O/lkzImHhnFKgTDR7hNeJjrGp1ZsssB+79mkfn+ABrUMXx+s8sR6lF9wZ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786763; c=relaxed/simple;
	bh=qIPxX49xXZagNIW/CMZJSjgZ01tbBFGBDYqCLqukdq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfHcGYpifzXWuyQ5jE8u4YbgUxO+ULdJFbOgJ2HPfyFKIrlBFs5sjSCizlscYDVkGsHfteVGnXNSTxOg35lwHgKnf16QaO7sFEkBTmJ+lNeeNQ616nd/+yrUgVnhwLdc+z86ETRU3a9RzUPWej/AVVfABLTRrFNFrAOEWe8UuIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F53pHC6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8FCC4CED1;
	Mon,  9 Dec 2024 23:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733786762;
	bh=qIPxX49xXZagNIW/CMZJSjgZ01tbBFGBDYqCLqukdq0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F53pHC6Sp/E7HxJiAvT3YWNyDkBIW9IDkDcU/M5vUCHqbaHjnnt0ivg0dtvdUAaKZ
	 bm2cRReF0ciruyMESsVoC4dOg88njTYVfKJVtihzfu5Bkc7oPdngbJRvERUZzDX+ia
	 UUm0PGPj1LG/lghoJt3/cxIzNaKiFdN5wTvULbXqvVsyVhXWjK4hfgTjsyZB9Bu0Jq
	 kPBYgAttYirMbzoyS9L34vrUtY5h29m2ivWH08P0VbxKONQ4YCTP6o61FEEaumQ32N
	 PVWpW6HZTxJxYe9vvwfkTmlFoR/uqSnKzaqGJKuxgFdkWAU1kdLHi/N54xEpF5/DNv
	 V9S9tTOlTk19g==
Message-ID: <b3b02cc6-69c0-4cde-b459-cb7c7fab9f30@kernel.org>
Date: Mon, 9 Dec 2024 16:26:01 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/vDSO: support DT_GNU_HASH
To: Xi Ruoyao <xry111@xry111.site>, Shuah Khan <shuah@kernel.org>,
 Fangrui Song <i@maskray.me>, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <297cfe11-0418-4633-8c15-4ffc7d290a3d@linuxfoundation.org>
 <20241206130724.7944-2-xry111@xry111.site>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20241206130724.7944-2-xry111@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/6/24 06:07, Xi Ruoyao wrote:
> From: Fangrui Song <i@maskray.me>
> 
> glibc added support for DT_GNU_HASH in 2006 and DT_HASH has been
> obsoleted for more than one decade in many Linux distributions.
> 
> Many vDSOs support DT_GNU_HASH. This patch adds selftests support.
> 
> Signed-off-by: Fangrui Song <i@maskray.me>
> Tested-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site> # rebase
> ---

Thank you. Applied to linux-kselftest next for Linux 6.14-rc1.

thanks,
-- Shuah


