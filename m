Return-Path: <linux-kselftest+bounces-26675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5DCA364EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 18:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D33F3A7A87
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 17:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD840268C67;
	Fri, 14 Feb 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDuCv44Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA72676D8
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Feb 2025 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555111; cv=none; b=b29FfqOnKdLk550rIUWUEMj9v5NwK6PaYPaIgGkp4YZKiLgZcygUXVQPNPxd6p41QMSU8f3cfDOt+8B4pm6a592WS8Vm2PXXloUlaQzGfvqWSsgCeZIzOg/9Hl0rqoVDrH3Lwwtx208AgFSPWg41KnNbuz4aCfTSp/8REKoJrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555111; c=relaxed/simple;
	bh=ybmFuF9ibx8fsXQXA1od1ZQ512hbYjs8egXp1ixsiv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQFFU9cqXb1WvnkT+DlW5s78ZTfb6dqx5IDukaVcDBeJ5qfhP2fj7y25e/NPUF1bjrSLwddD9KPksitMIG9OXdMy/Zif+Dgtp4tEd2nKMgx1boqtl1oSIZdwnj00Wy5XTTPUsC9t2lyHE1QPR7q2dt1hs2IcOa6pLTcXxXsaauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VDuCv44Z; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220f4dd756eso16193905ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Feb 2025 09:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739555109; x=1740159909; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5mJWLq0PJ55ynNZW1CqmDU64iYck9U3dQjbL7H23J8o=;
        b=VDuCv44ZA0jDklNf/WlzOgVRgSDMMJqdxq9g2SSzncn6IKMbKnU4fWOAGmh5L4WMY3
         3sqsOypS+nd9DU/8Og2a3p49+v20xk2BlJmqnv7JYFDr1zT8+ZsG7urnF2fv5SMs2HKg
         5jvkqjMhKNHIgDLld68/OatgSUdo6RcEgpPG/Fifo00pDbmIwvy6u5I33TVYQM6n/YHs
         Mj3JQw0Qxefp7nA6W/gXjpGT6cGqGeci1CVVQhDafJava34V1oVymviZs+hBq0vsgTEJ
         qZ/CJncYVsxWWZ8aAH0XdFaQY96scm+V2hEVxl59HncnvJ+9c13h0VVjP19mNrhj/Da/
         fssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555109; x=1740159909;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mJWLq0PJ55ynNZW1CqmDU64iYck9U3dQjbL7H23J8o=;
        b=gFsVbZAvHzrKHAVDw8uePbarynWFNGQLniTf59utKgjSdQsWO0FbSZakjwntMG+hDN
         9BpZZAj6M34vOlnPwq8Dqg2NdL04do/FdxdvRyqJQUP4XPYiL74UVVOnTGaL/kN1EUzR
         k5rvSxX4YyrwcavoE5aCuZRuIuIbKH1z+w19yrelSI13mz/Zh0wbY96ylPCqcBGCUITR
         xedFgcbSA9a43IxOZQt4csozkQjpEXBbibJRw50xi0D15/SJ1cJZKOYRQ21vyrJY0vQx
         GfiEZROGP8IhxgYbCRIB3KMzbyQrD/L5QTBboeC8odiM2bF7Mw2uHzbU8AkWPfjD/sBc
         j8TA==
X-Forwarded-Encrypted: i=1; AJvYcCVFAgEPcJo/68hN6uZ5osi9me5QCoQ/PD534+kUOuW+tTxNA4sZKJWjs05/JvYvw04GWWMWPfOAz9cdgEwJM5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL8oSuCH/m0rJNy30G5v5H+QHg1tx1tEHMuxuj+4orCk+yg5a+
	8VmoH2wuJUYphwWWYuQGh9SomOzAncQ0gAJ3jAm120ivTIbMu48iOI/vOt65FA==
X-Gm-Gg: ASbGncv6bh2TFcWouG8FUcyWV9Db53dkcDGLCP86t90xJfSRStJ1DRQkVGqFW2uJN16
	9EDrLANToGGSqTPLuZYWsw2Uk9N6bfHbegS5/zirly3aLZdErtTRt+ed7koq/LJiUeF0VWuJYI4
	P5U7bznCYYreU8o25ETWZ+84HCs4aoRNag62ghVp26VycmN55mGqEWTvB5SCoQuaAbWP7rwmPno
	1IqhXk1/3k2/8xocLLE57MXrVafloi0Ocqe6JykborXtILwo/8l5FW1jH1puC8Y6BEz63+4wuNo
	CP3X3GLPJV3lhm55k7GQtt8Yi6Q=
X-Google-Smtp-Source: AGHT+IErjq3v7C8zZFbR9QpBV8b3Rae4Pp44QaWUlDQobtQDaZ0FJlpuEU0JZbEjGpy5/bpbsPDRFg==
X-Received: by 2002:a05:6a00:2e28:b0:732:5a8f:f51b with SMTP id d2e1a72fcca58-7326179ebd4mr449479b3a.8.1739555109254;
        Fri, 14 Feb 2025 09:45:09 -0800 (PST)
Received: from thinkpad ([120.60.134.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324256aa6asm3514115b3a.60.2025.02.14.09.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:45:08 -0800 (PST)
Date: Fri, 14 Feb 2025 23:15:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: pci_endpoint: Skip disabled BARs
Message-ID: <20250214174505.5bo473evkpovjtyt@thinkpad>
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

Applied to pci/endpoint!

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

