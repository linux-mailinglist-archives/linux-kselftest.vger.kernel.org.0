Return-Path: <linux-kselftest+bounces-25576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C33A2607D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 17:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A0C3A713C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C981420B7EB;
	Mon,  3 Feb 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bvG2n9u3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF0320B7E2
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Feb 2025 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738601219; cv=none; b=N1AXB5coMtf1M8ng8xShvB6GOrNCOLcV3yPREZjkOt9/hWZ/SQB2elvvw4bbv36IuqAxzRLnUvk70UO1A85zPL6FaEa+jgsaQOvS6SgC2rxv1lKZ8BOfzQSZBw/uDChE2pCQ8ED3suooXh59EeyHFz+9pCnLG+OEMjc1gSLEW7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738601219; c=relaxed/simple;
	bh=oPuO6+y5Ch8+3t5fklBZMsIEy13TC/lriruGMbXavTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0B4DldsEsquv9imb8ZuE9JM9nl87vYQqTZDkhbO7ZoXEOw2fWVPGwie7fNWft5pD5yrAFB/B71BM5Ue+uQm6zrBbm8Oq2WLSAFXroWpp6qhyZxEjoTmoaECMvqYXogN4LhfDPem3BlQ4Dh8arf8zJYVi9UfET0HnaZO/0JcYXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bvG2n9u3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7be6fdeee35so730488985a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Feb 2025 08:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738601217; x=1739206017; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+j1L+4jvQNDUpA3HWhjXx2Lq3Pzav+YGqjyReZafTQQ=;
        b=bvG2n9u32x6+Evzq78tICJbfbyPZpqNjowrKEscV+hUv2wn9J4VQiZvodAEobn0glm
         DhT3plzCVQ1advRTuN61ftO3sZWgUtDQThoSER1ylfjJg/OqdZy3wky2jicFfcA6Akbd
         PGN+FoQjd0PTm4cH0IFYyNCHGa5Jfk7ZLJVfVdvaTvvDGO37gmQu8n9adsXN2ZsRHpBc
         X0l5f1LOc6+kilggTInPgBJFhMUtWE9ofPlc8SX5OOiVa72FVURgSSqXGvHcMsm9TrhC
         DcOula3iGkjxFyXSub2PDdUjgJR92KF/dELOq/hOvzvf5Ikbs8FzQNOHm+alzJigiAxY
         65vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738601217; x=1739206017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+j1L+4jvQNDUpA3HWhjXx2Lq3Pzav+YGqjyReZafTQQ=;
        b=kgVdikmPd6Fj/la+cMuiyAl2UrVa+HJAl1WH9rYtOuU4tldIvMZEDV1ShAXcXPuLF0
         Z+dDCdUpFVib9Nd5phwpRcgPR3f9BaWKBxoUL/hE99gXmok7T7nUuqggij1ZqpH+7oAe
         lq6d/qBNhuDiVyYhRshIlICK1PASHTCZMoNpQnExd2LtufupUt3o9RMU2GM30nZBGSQY
         xohSyHOrhXc32vJc+Ri6xPigMTb0YF18VRsrggIyto3O2jP7jXi7nyGMGlNrM46NcisG
         M5kJ+98C6k79ZoaIGYzxttoTUWSCJmi3Fn6Nx2OJovI4zjWpBQwWf+/CXET9/ZrlsRBv
         fmKA==
X-Forwarded-Encrypted: i=1; AJvYcCUPEX/w9PKfZTk2nfiLOSzSuQX6LGg53uHeeli3xjVmCUeBtIWS5d11ziy/VQJvnft6JD+si9io7GD6jPhjE98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUk59BudABGH+7sJyig88eIQZCQ1deiZvSHZjZK0WhsAx477r
	0ziLtDw6+dOqT0Q1C7Wgjr4WV4xM0Jt66Po/dv2hxPiepvgkuZen/MFI2ljOZfQAjYwXOwvXm6E
	=
X-Gm-Gg: ASbGncu5OWMYHwNmnLz/sl8TUIyNM17PKYypcu31U9u3HXu7oRHXoiZTXJrIzs+u+qh
	PwsGOy4Igd3yPYowPxZq8S+U3w3kUNVehjJsjb8LZBvUal9aLjg0ik9I9gjePYU3Z5kSAWqnRnR
	oiH7GsRtRAMsE0liNHTWhqY6F70BoD9QIagg4q10N+ZpqTwywk05HHLCVKDrcmgw3qxHJJLnolQ
	Nb2FQ/ZNn5Pbzi0zKb8OnqdwL71uhST4ADDwCIJvAo9Fkyufy3AjSJsV8Mmz6i/izZC6Tm3lGF5
	FgdyLfbQEgAK0F0CYIvGVDbD+g==
X-Google-Smtp-Source: AGHT+IHrFweDFwKoOEmRTN59Uomc+Brz5YLPX0hWCTptBMIIDyrG04lGI+m05w/b/HeGG02jJWBNkw==
X-Received: by 2002:a17:90b:5408:b0:2ee:5bc9:75c7 with SMTP id 98e67ed59e1d1-2f83abbea88mr30670143a91.5.1738601205592;
        Mon, 03 Feb 2025 08:46:45 -0800 (PST)
Received: from thinkpad ([120.60.129.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bccc8bcsm11584902a91.13.2025.02.03.08.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:46:45 -0800 (PST)
Date: Mon, 3 Feb 2025 22:16:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] misc: pci_endpoint_test: Give disabled BARs a
 distinct error code
Message-ID: <20250203164640.2oyjgurfjohdsaiq@thinkpad>
References: <20250123120147.3603409-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123120147.3603409-3-cassel@kernel.org>

On Thu, Jan 23, 2025 at 01:01:48PM +0100, Niklas Cassel wrote:
> The current code returns -ENOMEM if test->bar[barno] is NULL.
> 
> There can be two reasons why test->bar[barno] is NULL:
> 1) The pci_ioremap_bar() call in pci_endpoint_test_probe() failed.
> 2) The BAR was skipped, because it is disabled by the endpoint.
> 
> Many PCI endpoint controller drivers will disable all BARs in their
> init function. A disabled BAR will have a size of 0.
> 
> A PCI endpoint function driver will be able to enable any BAR that
> is not marked as BAR_RESERVED (which means that the BAR should not
> be touched by the EPF driver).
> 
> Thus, perform check if the size is 0, before checking if
> test->bar[barno] is NULL, such that we can return different errors.
> 
> This will allow the selftests to return SKIP instead of FAIL for
> disabled BARs.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Hello PCI maintainers.
> This patch might give a trivial conflict with:
> https://lore.kernel.org/linux-pci/20250123095906.3578241-2-cassel@kernel.org/T/#u
> because the context lines (lines that haven't been changed)
> might be different. If there is a conflict, simply look at
> this patch by itself, and resolution should be trivial.
> 
>  drivers/misc/pci_endpoint_test.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index d5ac71a49386..b95980b29eb9 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -292,11 +292,13 @@ static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  	void *read_buf __free(kfree) = NULL;
>  	struct pci_dev *pdev = test->pdev;
>  
> +	bar_size = pci_resource_len(pdev, barno);
> +	if (!bar_size)
> +		return -ENODATA;
> +
>  	if (!test->bar[barno])
>  		return -ENOMEM;
>  
> -	bar_size = pci_resource_len(pdev, barno);
> -
>  	if (barno == test->test_reg_bar)
>  		bar_size = 0x4;
>  
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

