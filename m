Return-Path: <linux-kselftest+bounces-28962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 262A9A5FCDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 18:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FB53B548C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 17:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A75026A0D5;
	Thu, 13 Mar 2025 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xFpn2Kmb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209BE269D1A
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885228; cv=none; b=sIzi+NzmzuJdCf9OYSpy/d6IJI3vIBO+k7k+IaIv0V57FHHl60LwvuzWQGg+2k3wcxBRg4y8jKFBzothclgXeDSo8tnooQo7cF09RvwhzU0alt9YQaxYcTuIj3CRgS4BHTDirBrZvuEqc6IMsm1UGMQIv9AUu0z43ynHBudGD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885228; c=relaxed/simple;
	bh=31dmEYbClSFQ+777iEycvnrwhs4MHxlaRIx4vP74XmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nx+oQmeMEOmcpRvkvcABtFlyZ+L+QbRSw4CUwdgX7/EBXeVVQ4/XrgIAIYjm9CSciIdahXdq8dBLkML0qxkRcRHn+lf7WzkE7cJC9wC98oWI4fuaXASBOPC04sqgsY1/CozEOvwy4W9hUQJiqPigM8wppTcuKt5Ol6SsPc7xTbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xFpn2Kmb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so2248389a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741885225; x=1742490025; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Tusq3pDNFXo3UBk2NCC4K0gAQ8d6jHbFL+kELh3G6w=;
        b=xFpn2KmbE4ixFx+8g3XTFLeaywT+oDKejLkemtFiMNh//2iHk3l7iUEIcm2gwSj3Ra
         RFagGlL0ou180vQYvUW2ubmOxCQUnbt3NXBpFt21100TTsjaMNHyuwUcKuCGVbjnibSN
         vOFaqnogc0/UOQtTZBSmNKXsVRK89pL74kMJ7RHoeZXyPv7AJ7csqTMlwEFc83WFOHoi
         rdUhzmuW+EhjJgpUOIU8zPpyzvBk96Hn+HgtBRN/Af4chadJQF3XyIgre1WIqe2MMR0x
         MtrBPLLXr575c8T8M4RQo/eX/L0cT3f/uO2uZ7N8irD+Qe2tkNX+V37MFAx6sIelQ3Tj
         eiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885225; x=1742490025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Tusq3pDNFXo3UBk2NCC4K0gAQ8d6jHbFL+kELh3G6w=;
        b=MyJLjjZM4Gd2NZUk2jfnLU/gEQJzSGpPxVWcIeTXkBypd5CU9gKV/3YaM1iz3v1O5p
         +AEerXptDNnnsiwQCG5aS6jyX8YUiJYJ2mf+YvkNqugI6KCDqqhpYUcFHCUoZDq47ENP
         UrkxMTtCwSjo6N/ULluGAxMRHUN3EBOrGzXI8Sf6GqZdniPWUlNA8OTl5uHPsD4FArei
         4t1u3+pggnfzOg9AAZr+jB3gUP602fJMbEVAI3YxuRb+3DcmjNKrmYaC+8TAb2OkHZYF
         pQ/Wou4/L4rxQCwOKISgyCNoV4Sb1ExZdPbClOw3CnUaxjqrYjdtjizLakgrq4a6XxS9
         6RJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4fjdL8aleHBU2SzLmxzfLGB5bxwuqDwhAwjY874Jkz7rtmlI417gMnp765nYx+S5EiQeavb4/rb+2TZ3ZLDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIuusZggxRUTDrW71rrxonn/dhnij64ZIqEKVnO0iV0l5PSAgh
	3lplw6B2B4+mx9rOpfUR2KDZKk3pEkEN+kIFLvWlSeqW5CixP1nh52ss+Y1Ebg==
X-Gm-Gg: ASbGncsfkGXaY1Tha5YAYje5iWpGCX3/hGd6QlGpiq/H8Jj73Tw0a34ZOHY36oUe++F
	w5RX4d/ilgRTLhr0JnBSLa9fg8KY94f5/POQggBB3v6pbdGS3/d0tbKB5IWjyCIVTItspU4siDM
	3b8vXQP0CYs7vztt/3WY2LhXFgCHGAsm0Wv5naxFr+qBDDj+YAgGStUDeESrTcA633TlfiRED+E
	DXnzUkLtMjIFKkyS5qZVG/fggx3za4tIubs6yab/yHQcvXWzyyL0puh4dqMteVsYJD6980ssOH1
	JqreKo2w/l/vF0sC9mPgQMRH2hdc993TxPv8qx1D/mqvLhW8szXNDw==
X-Google-Smtp-Source: AGHT+IHrhxG8cBBN1mLcB50PY8xDofHLIoxLCvQgTyzYBBZ9ISoM3YC4LO95ACXRFgZFksUOSpVtyg==
X-Received: by 2002:a05:6a21:68c:b0:1f5:80a3:b006 with SMTP id adf61e73a8af0-1f58cb44e1dmr20356279637.21.1741885225140;
        Thu, 13 Mar 2025 10:00:25 -0700 (PDT)
Received: from thinkpad ([120.60.60.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9dd388sm1504361a12.20.2025.03.13.10.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:00:24 -0700 (PDT)
Date: Thu, 13 Mar 2025 22:30:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Krzysztof Wilczynski <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Shuah Khan <shuah@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 4/6] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
Message-ID: <20250313170016.oeq2pfbfyal3hq74@thinkpad>
References: <20250225110252.28866-1-hayashi.kunihiko@socionext.com>
 <20250225110252.28866-5-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225110252.28866-5-hayashi.kunihiko@socionext.com>

On Tue, Feb 25, 2025 at 08:02:50PM +0900, Kunihiko Hayashi wrote:
> There are two variables that indicate the interrupt type to be used
> in the next test execution, "irq_type" as global and test->irq_type.
> 
> The global is referenced from pci_endpoint_test_get_irq() to preserve
> the current type for ioctl(PCITEST_GET_IRQTYPE).
> 
> The type set in this function isn't reflected in the global "irq_type",
> so ioctl(PCITEST_GET_IRQTYPE) returns the previous type.
> 
> As a result, the wrong type is displayed in old "pcitest" as follows:
> 
>     # pcitest -i 0
>     SET IRQ TYPE TO LEGACY:         OKAY
>     # pcitest -I
>     GET IRQ TYPE:           MSI
> 
> And new "pcitest" in kselftest results in an error as follows:
> 
>     #  RUN           pci_ep_basic.LEGACY_IRQ_TEST ...
>     # pci_endpoint_test.c:104:LEGACY_IRQ_TEST:Expected 0 (0) == ret (1)
>     # pci_endpoint_test.c:104:LEGACY_IRQ_TEST:Can't get Legacy IRQ type
> 
> Fix this issue by propagating the current type to the global "irq_type".
> 
> Cc: stable@vger.kernel.org
> Fixes: b2ba9225e031 ("misc: pci_endpoint_test: Avoid using module parameter to determine irqtype")
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index acf3d8dab131..896392c428de 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -833,6 +833,7 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
>  		return ret;
>  	}
>  
> +	irq_type = test->irq_type;
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

