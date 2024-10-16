Return-Path: <linux-kselftest+bounces-19847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6889A0C7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 16:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B981C2083D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F79A18BB84;
	Wed, 16 Oct 2024 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTno0WUw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A6C21E3C1;
	Wed, 16 Oct 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088500; cv=none; b=Mu/18R4wwRMFEB6Zw4boc+fKcQPnq8HRzDEPMBijPNaWuCevzXOjgyhjZodP+5B50/ZUJGK3zBRbztyOp69f52vOgSBCT5GaeE58hikjFfdWB/zkrS4zsN74INuu188MJ/ELepSCOMINDladRggl/MErtpnuQDMGEGdpj7MggrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088500; c=relaxed/simple;
	bh=b3gWtHA7mDXpJUaqEeJesA/LmRgKeKN78pjq9n5Clv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIUsY2Esv9yPuPVysW5G8rVa1WnR7Rx3kwut581zSjwdqSoMfQA9l5rq0lVhdrHKa6vdSYNUiG9tR638Z1PrRvtZA+EaffGZvAx5pUgkqCaF/ugB82GrWrDLaiWI0OAmVPXW0Iw/pMenlqUX3jeVxtxN6fBGbZsIDaPseDo4Z4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTno0WUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B103C4CEC5;
	Wed, 16 Oct 2024 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729088499;
	bh=b3gWtHA7mDXpJUaqEeJesA/LmRgKeKN78pjq9n5Clv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pTno0WUwLTzeEItC6uZRkUnuICWr/hWEJt/cMOtzBjrDgaQ9Um8Vi1xuO5wMZr5Ce
	 Db98CCgcp+jSKSUjOwnLjCVQJFcoQxfh5OGM19Tpvzhz/HlnGRKcYPZKTkfrLYc3YR
	 TX+R//bvqmLFVs1lC9uW4eJrbgBs/0glG0X9NTzb5AZikApZiZO/j5+peZDKcoQ5ug
	 zMeh7x6Wn3EQapZKrO1KuJptqclfrrhiBQb8yFedhYx+T/KO5Rgd6Aq2FDrhTNhzft
	 o3Kxdw7/wWFTSE5c2hitjWpmLKDUPZz+rSFXOwWy8d/1i82SGM8UUBK3V55nYuWUK/
	 xYUV3ZLlrKLXg==
Date: Wed, 16 Oct 2024 15:21:35 +0100
From: Simon Horman <horms@kernel.org>
To: Karan Sanghavi <karansanghvi98@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3] selftests: tc-testing: Fix spelling errors in
 cgroup.json and flow.json
Message-ID: <20241016142135.GI2162@kernel.org>
References: <Zw6flhHF50_4jT4b@Emma>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw6flhHF50_4jT4b@Emma>

On Tue, Oct 15, 2024 at 05:00:06PM +0000, Karan Sanghavi wrote:
> This patch corrects typographical errors in the "name" fields of
> the JSON objects with IDs "4319" and "4341" in the tc-testing
> selftests.
> 
> - "diffferent" is corrected to "different".
> - "muliple" is corrected to "multiple".
> 
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
> 
> v3:
> - Corrected the change logs to make it easy to understand. 
> 
> v2:
> - Combine two earlier patches into one
> - Links to v1 of each patch
>   [1] https://lore.kernel.org/all/Zqp9asVA-q_OzDP-@Emma/
>   [2] https://lore.kernel.org/all/Zqp92oXa9joXk4T9@Emma/
> 
>  tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json | 2 +-
>  tools/testing/selftests/tc-testing/tc-tests/filters/flow.json   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json b/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json
> index 03723cf84..6897ff5ad 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/filters/cgroup.json
> @@ -1189,7 +1189,7 @@
>      },
>      {
>          "id": "4319",
> -        "name": "Replace cgroup filter with diffferent match",
> +        "name": "Replace cgroup filter with different match",
>          "category": [
>              "filter",
>              "cgroup"

Hi Karan,

It seems that multiple is also misspelt several as miltiple in cgroup.json,
basic.json and route.json. While you are fixing spelling here could you fix
that too?

> diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
> index 58189327f..996448afe 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/filters/flow.json
> @@ -507,7 +507,7 @@
>      },
>      {
>          "id": "4341",
> -        "name": "Add flow filter with muliple ops",
> +        "name": "Add flow filter with multiple ops",
>          "category": [
>              "filter",
>              "flow"
> -- 
> 2.43.0
> 
> 

