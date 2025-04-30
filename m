Return-Path: <linux-kselftest+bounces-32009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02792AA422F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 07:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E8F9A5807
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 05:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD431E3DFE;
	Wed, 30 Apr 2025 05:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8OTW4Ye"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D95C1E32D6;
	Wed, 30 Apr 2025 05:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745990311; cv=none; b=izwDDBNX90DINOs+53qK9o1WueI84JtWlkNj5tu+hDhUmlDz8JViNcizIM4rujYAhoODNHY3MQFqkxQelli4Z5JovCDOw38uYSE/91mN+bofIc5T9STXIBfYGPzN5V1OwinDo4DnBDzmbNoTvI7ruP6D5/ysaxO3P+t5ZUnwQz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745990311; c=relaxed/simple;
	bh=vJNafRqavmjLD9aDj+IFuyQdV0eiO+Scf8aHDP3rM74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hcf1SYmO+/rBK8Wv6oztkrTk7ZzX8sskxNAGqHzLsEoe0oidK1d58rEkjiGIwzKimepUdJmt3ytI1TGGgtAk7qLCnfk/oTcSRb9o4grZgOudHv0uhyrkBBwEGbHAZM5AZGnb5hGuR1ag2CamFW+JePHXZr7lKfLRCaGREAJGelw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8OTW4Ye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0091C4CEE9;
	Wed, 30 Apr 2025 05:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745990310;
	bh=vJNafRqavmjLD9aDj+IFuyQdV0eiO+Scf8aHDP3rM74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N8OTW4YeWxaseH8T9vSS8ev8gTx72VRN7NqVbT+7JCutPUf+99l4WTa4mlQavvjD6
	 atRLJ3ipMQjodipS4RqZI9MjDLS0nYvuWGpUR6qYzH9XkxSf538QCyeHkZ83162EQ3
	 bqNB7hENbcM980H8/BLc9+t0/lQDGG52+5Rr+k3CM9m4rMS+sOxE8Cc6Le3AuP8Iee
	 EwKSiwI8O54VsgwwYVDpHDO+trDq4doTeNnN506/oUj3Cep/YLk+r5dSmZ7adCB/zI
	 L+Sy8GDNPXclynuA8jdFpVLmNwMTgoPvbTRn/46jhz3VNhZB0a8lndYENYZ5mTOJ8b
	 0qM7or8q/CuYA==
Date: Wed, 30 Apr 2025 07:18:25 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com,
 corbet@lwn.net, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kunit: add tips to clean source tree to build help
 message
Message-ID: <20250430071825.1e196cb1@foz.lan>
In-Reply-To: <dc8f4035a8d493be9ddc0e868a3ffd67626cca00.1745965121.git.skhan@linuxfoundation.org>
References: <cover.1745965121.git.skhan@linuxfoundation.org>
	<dc8f4035a8d493be9ddc0e868a3ffd67626cca00.1745965121.git.skhan@linuxfoundation.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 29 Apr 2025 16:27:12 -0600
Shuah Khan <skhan@linuxfoundation.org> escreveu:

> Add tips to clean source tree to build help message. When user run
> kunit.py after building another kernel for ARCH=foo, it is necessary
> to run 'make ARCH=foo mrproper' to remove all build artifacts generated
> during the build. In such cases, kunit build could fail.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  tools/testing/kunit/kunit.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 7f9ae55fd6d5..db86a396ed33 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -583,7 +583,7 @@ def main(argv: Sequence[str]) -> None:
>  						'the options in .kunitconfig')
>  	add_common_opts(config_parser)
>  
> -	build_parser = subparser.add_parser('build', help='Builds a kernel with KUnit tests')
> +	build_parser = subparser.add_parser('build', help='Builds a kernel with KUnit tests. Successful build depends on a clean source tree. Run mrproper to clean generated artifcats for prior ARCH=foo kernel build. Run 'make ARCH=foo mrproper')
>  	add_common_opts(build_parser)
>  	add_build_opts(build_parser)
>  
Would be better instead to detect if the last build was not done
by kunit.py and call "make mrproper" inside kunit.py?

Thanks,
Mauro

