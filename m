Return-Path: <linux-kselftest+bounces-18590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD4B989CE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 10:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46EE01F224C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 08:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69AE17BB3E;
	Mon, 30 Sep 2024 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKYqda/b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8914F17BB38;
	Mon, 30 Sep 2024 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685517; cv=none; b=ApN4RcdF+iWrfFUJW4TxrepNtIeg3baOA7+TSnfdqrpnULWOop84graeGbVkyYGKgKYb/0+ecay6Q1/XO3rIKnPlaXhUrSNpAqIWki6f1vx3B7oAfMJzs5gKYkrkvvqW5nVWEe6XzOUi8YXhZ+l9HC1CU2AwZRWCRDWON4dUoBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685517; c=relaxed/simple;
	bh=XiLson/o2rcjPk1CUp3hszvprA20fLVquqKPfskqctk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+3HdjKNvPKy7VzL5abBYDHHInNxBXy/HgeajDjrTpY+eFpBPiy9TSjWDGgOID9OxBKixAhOfM9y4BXDGdHnyYPIgn1K36+RW69AHksHAn1vfntYUVvyafpeVcJmiFOAzP2O3NRjqqLqpLbweNgEfz4kfmGpoGG6UPuOm+YgPx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKYqda/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92275C4CEC7;
	Mon, 30 Sep 2024 08:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727685516;
	bh=XiLson/o2rcjPk1CUp3hszvprA20fLVquqKPfskqctk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKYqda/bjmm2AYIWX6NjaFTZ4XQ6fUkYRJam6Lac7cdOVwR/bIlWYnFuQus+3jVTe
	 ynDM/z2x8IoGib0xoJ0urkbD2FKTjr8wGZcCkd7oXj1wQhflAEtreRDUZs7LSPZxrQ
	 KTBZiIHcB/w1eRJUVlFfvqBJY/13EsAaczNG1QWkCx3AgW3Gy9WNlBkjPEjeKJWeGG
	 215F9P7VmZL/vOsPheKpCzDF+5CCioJWbHeKAmJXtvjQT7fIVtbRrWEfaLyIX3F2AG
	 UvJ8aYwCK64iVzBGllvCdrcbh1l003mx1C15gq92TPdFo8xUCTiv42/MMyY7VRLmjR
	 YITtad05xngeA==
Date: Mon, 30 Sep 2024 10:38:32 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Yun Lu <luyun@kylinos.cn>
Cc: jikos@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest: hid: add missing run-hid-tools-tests.sh
Message-ID: <mimf5cv52q747fwhafr7pv6lgxyyt3rauz373e7hoinpqycmha@2oncke2rw2sc>
References: <20240929085549.3528293-1-luyun@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929085549.3528293-1-luyun@kylinos.cn>

On Sep 29 2024, Yun Lu wrote:
> The HID test cases actually run tests using the run-hid-tools-tests.sh
> script. However, if installed with "make install", the run-hid-tools-tests.sh
> script will not be copied over, resulting in the following error message.
> 
>   make -C tools/testing/selftests/ TARGETS=hid install \
>   	  INSTALL_PATH=$KSFT_INSTALL_PATH
> 
>   cd $KSFT_INSTALL_PATH
>   ./run_kselftest.sh -c hid
> 
> selftests: hid: hid-core.sh
> bash: ./run-hid-tools-tests.sh: No such file or directory
> 
> So add the run-hid-tools-tests.sh script to the TEST_FILES in the Makefile.
> 

I assume we probably also want:

Cc: stable@vger.kernel.org

> Signed-off-by: Yun Lu <luyun@kylinos.cn>

Not sure about the timing regarding our next PR to Linus, so in any cases:

Acked-by: Benjamin Tissoires <bentiss@kernel.org>

Cheers,
Benjamin

> ---
>  tools/testing/selftests/hid/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
> index 72be55ac4bdf..38ae31bb07b5 100644
> --- a/tools/testing/selftests/hid/Makefile
> +++ b/tools/testing/selftests/hid/Makefile
> @@ -17,6 +17,8 @@ TEST_PROGS += hid-tablet.sh
>  TEST_PROGS += hid-usb_crash.sh
>  TEST_PROGS += hid-wacom.sh
>  
> +TEST_FILES := run-hid-tools-tests.sh
> +
>  CXX ?= $(CROSS_COMPILE)g++
>  
>  HOSTPKG_CONFIG := pkg-config
> -- 
> 2.27.0
> 

