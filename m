Return-Path: <linux-kselftest+bounces-22573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B40DB9DAB5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 17:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A79B20F39
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 16:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EDE200139;
	Wed, 27 Nov 2024 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="QavYvnpj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD74A433A0;
	Wed, 27 Nov 2024 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723629; cv=none; b=Gdie8bGxGo2nX3s2Svq+9U2rrEKFebo59+UMSu2bdpD0sQcgkQtXOXDqtFCv/m1NjYAvlERaMVZhjYGyX2JjlLT3dGVNZhtmIXImKWfOv1R++k6e7MqT+ZfeJecsLfwmZZ/F78Hm/4ZTO9/rNjee/FrzDogJgLgr5NmaOa/ijV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723629; c=relaxed/simple;
	bh=iXdLQN0J8hHqFfx3TgCAu2/5405ejX/hBbiqegu/OPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzA9PEicl1p6sO0ebc9YGBWaUWsFrVt3qhJ21xmN3fCz0mk5dAy23hKra5Bf/CL3ty6oiegZGY31KzpuM4KNvIeBLIhV2stlkBtAwHCJmeQlXIJ+TRdYa8Ep5Ns2lcyilv8UGr66ixQ/gbu2qN3DOlbIejtj4W7W5THC4DUhIjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=QavYvnpj; arc=none smtp.client-ip=45.157.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xz4824c53zqLh;
	Wed, 27 Nov 2024 17:06:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1732723618;
	bh=UaH2dcrVn/mCS85MIkHZSTuN8yFKY64XNyK3N7x0pKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QavYvnpjenCN688aGoKKJdp1LYPWuIblb8ST6JYdOjGW2ip7eJy+fkJ9Xk1TfDOq7
	 T/3BkxI2ieuKXCuJX4qTRgvDUTkLDnPcBr3BE8ZwbI9EUVm1sbUAJ7Rc7AiQqKmUwe
	 zxbdE8eyRYA/qHCY6m4pbEQ7R3od2UVZ12RjoWJY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Xz4820MD2zjM4;
	Wed, 27 Nov 2024 17:06:58 +0100 (CET)
Date: Wed, 27 Nov 2024 17:06:56 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	=?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Subject: Re: [PATCH v1] selftests: ktap_helpers: Fix uninitialized variable
Message-ID: <20241127.ievif7Euleph@digikod.net>
References: <20241127160342.31472-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241127160342.31472-1-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Wed, Nov 27, 2024 at 05:03:40PM +0100, Mickaël Salaün wrote:
> __ktap_test() may be called without the optional third argument which is
> an issue for scripts using `set -u` to detect uninitialized variables
> and potential bugs.
> 
> Fix this optional "directive" argument by either using the third
> argument or an empty string.
> 
> This was discovered while developing tests for script control execution:
> https://lore.kernel.org/r/20241112191858.162021-7-mic@digikod.net
> 
> Cc: Kees Cook <kees@kernel.org>
> Cc: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>

Please add this missing tag:

Fixes: 14571ab1ad21 ("kselftest: Add new test for detecting unprobed Devicetree devices")

> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  tools/testing/selftests/kselftest/ktap_helpers.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
> index 79a125eb24c2..14e7f3ec3f84 100644
> --- a/tools/testing/selftests/kselftest/ktap_helpers.sh
> +++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
> @@ -40,7 +40,7 @@ ktap_skip_all() {
>  __ktap_test() {
>  	result="$1"
>  	description="$2"
> -	directive="$3" # optional
> +	directive="${3:-}" # optional
>  
>  	local directive_str=
>  	[ ! -z "$directive" ] && directive_str="# $directive"
> -- 
> 2.47.1
> 
> 

