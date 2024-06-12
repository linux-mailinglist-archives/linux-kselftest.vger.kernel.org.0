Return-Path: <linux-kselftest+bounces-11789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3982905B60
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 20:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC6B28E272
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 18:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605D45A4C0;
	Wed, 12 Jun 2024 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnIdIh9G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34117757E5;
	Wed, 12 Jun 2024 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217873; cv=none; b=YRE+yXq/ZnUMIvvjN+5uMLxowbYTPYoWm03kyXpvozg2FbNlYgvYjGfdKZTqNpMijrY/Sp07g/s1+5rlmvXM0yz23sumkT60nBabuI7uSc3P+xtmEU3cCN5pLr4I7Jr+5S5JMjdOsZTkrBlcmNK3Pwra02yRjbai7rESLD7+mkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217873; c=relaxed/simple;
	bh=yqaEOGVGz/BenIqXBokoUcl0MRlmm1/UI7MPcy+JMbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swIOj+3mlTAYEvbUDmC3Fu0rQJI6WKPNMFiJQNtSNMXIO8JfUfpaMWrjKxHAcJcBgSwXVgAp8w4dUES7QLsfQpOxq9xzysuLQqKZbzg94aP1H9CRkBEt94eNk69Z/yLh7lwqxjpAQrsjIa3gOjcLQtfK8st6OCfog4e/9SL9zt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnIdIh9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A5EC116B1;
	Wed, 12 Jun 2024 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718217870;
	bh=yqaEOGVGz/BenIqXBokoUcl0MRlmm1/UI7MPcy+JMbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YnIdIh9GKOd77HAfLlrrY3rPi1M8c9CWwC/vR2tfplbfJSafpnCSXuRVwQwe+NX8P
	 i08JylThZesu0MVSXTKvVCJ16tEnrkfByE58j8SR6yqNP7ovYvlJzf2rleNXUwMKPg
	 CGl+2p2ojDEHNwpTgUavUVtksFFEuGIbUMTZpoQxMrIEhAmXjzk9ZOQRf7VRdvHUFr
	 joEDK63vJKyH98tR/viDwrxCnET4lkDfdkFGNnEszDIiBvWJWaBS/xfsmFHFUASkLr
	 x0hxZeJHJ0oCQyLp+IFkgd7sjqIN896OULF7pie2E6xPa0eC7SnRooW8PadIClT5MY
	 vFnC2zsBBURQg==
Date: Wed, 12 Jun 2024 11:44:30 -0700
From: Kees Cook <kees@kernel.org>
To: Amer Al Shanawany <amer.shanawany@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3] selftests: seccomp: fix format-zero-length warnings
Message-ID: <202406121144.0EE6C17FF@keescook>
References: <43e24489-a3af-4e53-afc6-ff1dd9462ee2@linuxfoundation.org>
 <20240611151638.5767-1-amer.shanawany@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611151638.5767-1-amer.shanawany@gmail.com>

On Tue, Jun 11, 2024 at 05:16:08PM +0200, Amer Al Shanawany wrote:
> fix the following errors by using string format specifier and an empty
> parameter:
> 
> seccomp_benchmark.c:197:24: warning: zero-length gnu_printf format
>  string [-Wformat-zero-length]
>   197 |         ksft_print_msg("");
>       |                        ^~
> seccomp_benchmark.c:202:24: warning: zero-length gnu_printf format
>  string [-Wformat-zero-length]
>   202 |         ksft_print_msg("");
>       |                        ^~
> seccomp_benchmark.c:204:24: warning: zero-length gnu_printf format
>  string [-Wformat-zero-length]
>   204 |         ksft_print_msg("");
>       |                        ^~
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312260235.Uj5ug8K9-lkp@intel.com/
> Suggested-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>

Thanks!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

