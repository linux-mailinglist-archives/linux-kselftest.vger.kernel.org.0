Return-Path: <linux-kselftest+bounces-25577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC969A2608A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 17:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D7A188683A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 16:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C29620B218;
	Mon,  3 Feb 2025 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdVwDtVy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FCE1FFC55
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Feb 2025 16:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738601367; cv=none; b=hB2CrWDeAfhdAsiPAXVFvMd2hKxubdh8GL5/xrDZYUP+R4OTtcvEjGnUqwlNl6ZZ7cliccFMHWaTeVuIkV15l4ExU5T8CrLRn+j8z0d3cvxio5vrTCbcieDgcS7qbcjOUIAS4bEqDnbJXfYFXmWDxK/tkxsj2iJ8c/YAXDYhhvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738601367; c=relaxed/simple;
	bh=+UyR62zTgCr1lGwsuyjbDBvoQJqiSJUA2EWl/uEDU10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XV6wVLIra8w39w9l0Fd630RO5jinh8d7kQPIzvXW9MKL/bvds8kyHw/Y4ehSWsZnbES4IdaUrJ+3+6Slq6kHfmL91m4KGAAYizOJWNoP66JdmQMcdmIgrSNkjGd0HwHhYYp2z5sa7wUtUlA7mg+YdAHfc/XjoFZcP+39Fh8a+Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hdVwDtVy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216634dd574so54144125ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2025 08:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738601365; x=1739206165; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xddVJAtP16YTUeYljd46EP8hHDLsfmX6IxpdykZZ3ws=;
        b=hdVwDtVy+mopd6CSzSaA7ieBaDawSATD7GDdz6QLXHWs0cMTL8Ez3EFgxPRgGW8SqW
         +WnoEK5Aelf0J0+pHZgcOjZoDqOFvoyPci5YFSvTvdKQMmaMDMLJipnvhuln1CPU8Ifi
         MYY9B9G06EFixjmi7weQ0oxj0fjUFOnLTTacY71N8kzjjzP3f2P8g8RUB4j9tjHz5jxZ
         /2hZXyRTjO4bl1lDDRPMYGx3ukRl1B2gHpZ6de8PylLnmsRomksHKNmC5UMnVuTzckft
         WzFets3MDihIRL+udQYneFsjPnSDTpWUeSU2AWmDwU4Wa7aTdWS4reaO7NDomgQvflDd
         Aqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738601365; x=1739206165;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xddVJAtP16YTUeYljd46EP8hHDLsfmX6IxpdykZZ3ws=;
        b=jBIzvt1/uqScFkJw9aXL5YyLnfWClPBdqZ5yx/xLtEfsVovHuFZNEfpfGYBdCQiZTr
         WpPdFKBsGS1C/zioc4lTu0VPlrEX9DmYkipzhz+lcsTcqGfuvwkOS7V0IBY4AFzUvSyF
         7nUSzalNhL924wDLgv+6rnpR/4ncS60oJMUdcZDusoytg1T924Xqrzw4JWZo9MaNi/3D
         Qu2iPyh5UAmIEPYjQF3fL724knzYbgJ48h2nMEzXjGtq6JTXHSnBXX4/6TKnT0wjcPsa
         Fid2n7fPNt7KX+og3eKvDpjMWpyHUusi1VXh2x6Scg15XlVwUHIV+GFxKxrKq+zQykiK
         4w2A==
X-Forwarded-Encrypted: i=1; AJvYcCVaSTBgMAvDxjWSn8tGqvcc9hCBRhPkpegnTH0V1ILgjAfk8smdG4YhcK9PS3jL6V3kFVJvroEtaStVsbwsuDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6P++58qd+vRlnSO8TWu+vSs2k/9zbA4Pkp8tdq/sSX9FUorXM
	pnNWGhLLMwHxtgHMnCUhdQJXVxIFw7I69Oz3dK3Pt+tY+SyRjqvN1SyTRHMQzwB5UYFxWexzC4U
	=
X-Gm-Gg: ASbGncvvoRI/c6yuJGLAPGTDsCgOkNHi5Y3sUY2dsg+0Dg8whJZ959XpwLbO67mDBsu
	MREsBwXdsvN9XzzKXxwYG0ufNL5Xb5ZKJQTzacOeqz5QmzG9d0rPNQMIaUWpEVh5/URl+h5k+rh
	6Q4SmNYYsh8ef/UZqsuvn27vm/e4ufUX/jtOhS8X4ZUOnbkG9h1RNEAV8ilI2oSErGrR/1Y5GuZ
	DphfORm4YOebxh6ep6Wd4jtEAK9L82sLcQtEZANG2OeNA/Awuc3sUsN4LzyWmEnrQxmA+DX2m+B
	0UXAN4Wieh9YwHOyW77mWwBLjA==
X-Google-Smtp-Source: AGHT+IF2HYH7tkkxi/7uRTkKqdlCtvWmxGsmA8l7XQB4XkL8zo4HNy1c2T8FM6N7NBKlOO2+px++7A==
X-Received: by 2002:a17:902:ced0:b0:216:5448:22a4 with SMTP id d9443c01a7336-21dd7c56007mr398076005ad.10.1738601365325;
        Mon, 03 Feb 2025 08:49:25 -0800 (PST)
Received: from thinkpad ([120.60.129.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331fabdsm78765805ad.221.2025.02.03.08.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:49:24 -0800 (PST)
Date: Mon, 3 Feb 2025 22:19:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: pci_endpoint: Skip disabled BARs
Message-ID: <20250203164921.elqigp5cuqz4dg3p@thinkpad>
References: <20250123120147.3603409-3-cassel@kernel.org>
 <20250123120147.3603409-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123120147.3603409-4-cassel@kernel.org>

On Thu, Jan 23, 2025 at 01:01:49PM +0100, Niklas Cassel wrote:
> Currently BARs that have been disabled by the endpoint controller driver
> will result in a test FAIL.
> 
> Returning FAIL for a BAR that is disabled seems overly pessimistic.
> 
> There are EPC that disables one or more BARs intentionally.
> 
> One reason for this is that there are certain EPCs that are hardwired to
> expose internal PCIe controller registers over a certain BAR, so the EPC
> driver disables such a BAR, such that the host will not overwrite random
> registers during testing.
> 
> Such a BAR will be disabled by the EPC driver's init function, and the
> BAR will be marked as BAR_RESERVED, such that it will be unavailable to
> endpoint function drivers.
> 
> Let's return FAIL only for BARs that are actually enabled and failed the
> test, and let's return skip for BARs that are not even enabled.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I was thinking about doing something similar since some of the BAR tests are
failing on my Qcom setup. And you beat me to it :)

- Mani

> ---
>  tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> index c267b822c108..576c590b277b 100644
> --- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> +++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
> @@ -65,6 +65,8 @@ TEST_F(pci_ep_bar, BAR_TEST)
>  	int ret;
>  
>  	pci_ep_ioctl(PCITEST_BAR, variant->barno);
> +	if (ret == -ENODATA)
> +		SKIP(return, "BAR is disabled");
>  	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
>  }
>  
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

