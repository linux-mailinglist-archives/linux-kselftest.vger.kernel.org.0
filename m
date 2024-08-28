Return-Path: <linux-kselftest+bounces-16547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63CC9628AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 15:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D726F1C21BA8
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 13:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27284188000;
	Wed, 28 Aug 2024 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JixoSt3G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1431C69C;
	Wed, 28 Aug 2024 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851956; cv=none; b=RgsSMNmvwkr3i0ylflFLgXREYpsv9AZ3iVDfRcXPxP4ueOkTRqkU9iXQIrHdTNhEo8oZBvGPuv/7GgXhmmdUaCRjuzGc/SPikaPrKS6ywj3zBpMcvREPhH5em5uC8T1PPT6GPmmH0DNdCFcWa84NwK1xFAfaj1NZDkXPVb2YZSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851956; c=relaxed/simple;
	bh=vEmNlQLx6fy4MiE0/ANt5tObQCXRx6fyVaP9jO+FDrI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iXoIfvG+pPprACCXl7n/12YGoy4973kmyKEYLRdezI0Hkm0iALqXnokCsyXLhqgOTX4APxZQ1iijXmK3W/trWrqrErGTcCR3Q/NYXECHzK7YnfhkFt/NBXF2jdgq5DqI4yCPUzeHxSVlZ+VHAyUEqHgy6tlCsyyOHOPrsGERcDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JixoSt3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69D3C4FF5A;
	Wed, 28 Aug 2024 13:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724851955;
	bh=vEmNlQLx6fy4MiE0/ANt5tObQCXRx6fyVaP9jO+FDrI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=JixoSt3GrADJQMBSGtidVr7k75oIngOXb2D7UL72pK3xCmRJPkRGkAEvh2E53W24x
	 KDaQEr4ndTBHrDUStR9sp4hrGdVUua6ERh5m3BTJdRG21pwfCVbbSTdgzTvq/ED4hK
	 NeTsxKff4qUfjp+mLF9E0mDqF4K8Nw5dDEgTpSfh0xqHIBPLKzb/Y+iwGOWqFrYag3
	 dQp2/7EJ/1hd7rKbCBKeqnWB/BVej+jHDCvVzXqttEboKtALY1RRRPnAXv1ai3Dedn
	 9kd5nZOPAd1+9D0CrN8AY5fKhqGqM6TCrFp0sz+3fEfQ7pGu1QE1K1OnHHw7JDsHHU
	 4S2rJy8u4palg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Aug 2024 16:32:31 +0300
Message-Id: <D3RKZJGWMFY4.3CHBC8OBPQ3SA@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests: tpm2: test_smoke: Run only when TPM2 is
 avaialable.
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Michal Suchanek" <msuchanek@suse.de>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <52c629ebbfc8f5218a90fa539f816c8555cb552a.1724842902.git.msuchanek@suse.de> <1794c9c1d60a34ebae28d3a18b408765e955907b.1724842902.git.msuchanek@suse.de>
In-Reply-To: <1794c9c1d60a34ebae28d3a18b408765e955907b.1724842902.git.msuchanek@suse.de>

On Wed Aug 28, 2024 at 2:23 PM EEST, Michal Suchanek wrote:
> Since Linux 5.6 tpm_version_major sysfs file is avaialble which gives
> the TPM version.
>
> Using this file the test can be skipped on systems with TPM 1.2.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  tools/testing/selftests/tpm2/test_smoke.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/s=
elftests/tpm2/test_smoke.sh
> index 58af963e5b55..e5e3386077d9 100755
> --- a/tools/testing/selftests/tpm2/test_smoke.sh
> +++ b/tools/testing/selftests/tpm2/test_smoke.sh
> @@ -5,5 +5,7 @@
>  ksft_skip=3D4
> =20
>  [ -e /dev/tpm0 ] || exit $ksft_skip
> +read tpm_version < /sys/class/tpm/tpm0/tpm_version_major
> +[ "$tpm_version" =3D=3D 2 ] || exit $ksft_skip
> =20
>  python3 -m unittest -v tpm2_tests.SmokeTest

Thanks, I tagged and reviewed the patches:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

