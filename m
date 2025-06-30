Return-Path: <linux-kselftest+bounces-36114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E85AEE3D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 18:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89C067A1B37
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 16:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64392E542A;
	Mon, 30 Jun 2025 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN1yM8vi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7E02E5421;
	Mon, 30 Jun 2025 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299773; cv=none; b=T7GMFy6fm+6ppFv0CnFBFHx0waUo6ZwMfNJtThsGZbJ1DEL/40DcAh9uUb2Y3zN9SH3PWRVLtMeRD2nhDDYiCDrlDVqD6CJoX0Du+0vS7NGSVlOQukUUM3uxd5YVrbKcecHQrkdONQDcvv3j0S2EbhE3aZO1wX47qUJ9iufiEAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299773; c=relaxed/simple;
	bh=SE9eZEcNzQCiD5gbUHyqcf5TMYGHEfi7eExeFYrl3q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcJ302VNnH6GWuHo/DucHbBoJY7qrjoP1tNcjO0xq1CcihHyZPrXbR1weij49vWxF0VPJR9dfLRWXAr2NEtW7NvoJoKV5uPGW/gk1qVXbDLIABcpv5msnXjEghyjs4Q5lVJazI+kpqMieN5lCAebevgnDTcDSSHS4CN+MHTEjZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN1yM8vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B2DC4CEEF;
	Mon, 30 Jun 2025 16:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751299773;
	bh=SE9eZEcNzQCiD5gbUHyqcf5TMYGHEfi7eExeFYrl3q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gN1yM8vicWiVSnh1wR0wbQoEyKIuI93qMK24J+yJv6ntdqyqiinjKIM5jTV1Q70e/
	 u9xGDcMJVcW4RbVFG5CC7vRSPTTt53amdKkwhUpyrhQzdKNkURyYYtAvWQGJsJsCmd
	 BiQmRMgQf5Oe9vTTpUitWmhFGpowjvfpSnZLr0ullQCrnrBq/75TOu3sj0VK5oyrB0
	 fr5YNqfdYyJ1x000eVZK1SRWTTX7RfpgX/I0hekwpi/OREUXD7wWTBINGtyhq4dwOv
	 R30hINjQKSAGIrJOTtbOsdGT+TZSm1CNRniqdKX6j9INBoZlFYKPY4LR8MgwmfZosw
	 o3n1oxrIP7+fA==
Date: Mon, 30 Jun 2025 17:09:27 +0100
From: Simon Horman <horms@kernel.org>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stefano Salsano <stefano.salsano@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
Subject: Re: [PATCH net-next 2/2] selftests: seg6: fix instaces typo in
 comments
Message-ID: <20250630160927.GI41770@horms.kernel.org>
References: <20250629171226.4988-1-andrea.mayer@uniroma2.it>
 <20250629171226.4988-3-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629171226.4988-3-andrea.mayer@uniroma2.it>

On Sun, Jun 29, 2025 at 07:12:26PM +0200, Andrea Mayer wrote:
> Fix a typo:
>   instaces -> instances
> 
> The typo has been identified using codespell, and the tool does not
> report any additional issues in the selftests considered.
> 
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>

Thanks,

With this patch in place I see that codespell only flags
false-positives for tools/testing/selftests/net/srv6_*

Reviewed-by: Simon Horman <horms@kernel.org>

