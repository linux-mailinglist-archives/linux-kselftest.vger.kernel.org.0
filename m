Return-Path: <linux-kselftest+bounces-23392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BE69F29CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 07:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5D816684F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 06:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7228B1C54B4;
	Mon, 16 Dec 2024 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkfYUpBq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C31946CC
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2024 06:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734329037; cv=none; b=KVagsKe8ImOaORA7WG0nKOf3bqAeo5liA1lS5LU/2V84MQjJXBje6wk1nLQSqDWTKsIPvGU35Hbt11Qx9khsHuwOPtICkIBSpicn62glzaSjnVvQrLmTF8ogOPFYrBKNB17gCJOFHZg07/3uqFSuXgoZtKmnGe84HUcR7gxEtAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734329037; c=relaxed/simple;
	bh=yOIMDtITdjwU8dGlUR5f1kxRPPSJQcdRUFbDxwRHrkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7+oha7+bFSAIlN+tjmbhXCN6as+jj3w8XnQtdahRvMCadi9zL4x5vRd8ODbu2RsF/Sv9nCEOYTRGnG4vAe4rI4PDCapOmJiDbO/LUlH8VLbReQuRmKL46BQM0GSkVKpfOQIQbyY0Zlfr9PkqtrQDe/ddBrNwyF3UrYpJZj2gUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gkfYUpBq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725ce7b82cbso4262637b3a.0
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Dec 2024 22:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734329035; x=1734933835; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8l56HNoVKCWoq3UFQbYWo8NhPQGEBKhUZs3vIB/kw4s=;
        b=gkfYUpBqvyEiXJARbueaiqOtQ6w/MIK9IUxJduIfjPEbNcd+YnqmTgjTbIJwNJTRBf
         Ilc7AAd4WuZ0oid+ofouRJ/0Op10+R5UuS9d4fV9oguvaZ7I4SZL+IyAkJkeTaTS7Haa
         Rge5w27OiYdJRnAVffmoER6TFQq+dGqZw/Kg12pRRqQ19n3pZcL+B4biRbP4bg0/oDua
         CUNPmDGMZiQy3aQjQvIM4KCX3/T6E+99r62UVpQTp4OUPXGS0Zmk135ImWd74dgRDbkt
         3B1lB4pdnhDKUFjk9kkZQZaBlftvJBNPUTzOzwost+Zlm3n48+rP4ZewRGNeclihIH/a
         xV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734329035; x=1734933835;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8l56HNoVKCWoq3UFQbYWo8NhPQGEBKhUZs3vIB/kw4s=;
        b=cfdy1f6buP/UUe1YLjoTjIIcn18ZxhKZ66TaGOIbZKGVUNiCO88UwLXREx+GnZPWed
         nnW1jaAJMAEdfCWU7VlF6TOJ7y9sGqWojI+uqNvuwBZJPK4gOZPE2GxSj9QllYARZYlw
         tJZExx9tbH1Mnaz9cedY+scP0zUL11XMdeXkyD3ttX33nO44is6nGiOijheAoMbSnODN
         a4Gnruu92nHKa5iiqNMNUqX2JtrVc2f1T99WRrxM08X9Vb7Uqbe3Mvkb85NoR6i00nXp
         cUmdZWmX+tGr9rsM3lxw87ROp0eGt5rmcqM4c50kZUK5pbfQsEjHgRpLdfhfggc+6fkK
         97vg==
X-Forwarded-Encrypted: i=1; AJvYcCWTKly/TpPR+l0jmHJnR8fP3rI+ridpE0ftfS9gGwLcB7rgThA+qC9Ajbvr9SGaLuFZjyGYTNtoWVUPLfOUUNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHSqlBfN8TGYwHmRwjTTGLgHrq5RqdI8QN8g5lP6MmkIUUUvZa
	qV+0AfsO7tvGTrrYlFV0D61qL0/1L3M0wESoD57L+oOziqdO4hIYylRIww+Jmg==
X-Gm-Gg: ASbGncuMyKAbUQKCFuPTVNiZq40k5ANoDemKKD0su8d4mSvgP/wbmIr+CCkd7u+co4Z
	0YOvRzyHxRo5mdBQn+9TTL+hvyVz2UO4xz29lBQ5GS0j9Vu6M9eYkqrDas5S48UqgWw/1/7WFEX
	mCj3+h7tW1uEN0o3MAJu324oFKk/cSiZ9BB7/u+uM+UYS+5VsazbfIhx01vurDaD8hn2S0NP3ia
	Zautr1QczE7ev4ojVGhtswNa2pdDkrqfodbAkhPhZDMhFLTwZffSzK6flJmUvVFff8=
X-Google-Smtp-Source: AGHT+IE89dTdzc53pbTNLiYWQP76UGO9avKXTxiixxWoLDIUfwYBcA6Og+5vQuX+VCSfds7qpcJuug==
X-Received: by 2002:a05:6a00:17a1:b0:725:e05a:c975 with SMTP id d2e1a72fcca58-7290c264e09mr16165494b3a.19.1734329035071;
        Sun, 15 Dec 2024 22:03:55 -0800 (PST)
Received: from thinkpad ([120.60.56.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ad5664sm3936114b3a.73.2024.12.15.22.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 22:03:54 -0800 (PST)
Date: Mon, 16 Dec 2024 11:33:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Migrate PCI Endpoint Subsystem tests to Kselftest
Message-ID: <20241216060337.cvhwvdzt34ocg2uf@thinkpad>
References: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
 <Z1qsIREtdeR38fF6@ryzen>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1qsIREtdeR38fF6@ryzen>

On Thu, Dec 12, 2024 at 10:25:53AM +0100, Niklas Cassel wrote:
> Hello Mani,
> 
> On Wed, Dec 11, 2024 at 01:31:01PM +0530, Manivannan Sadhasivam wrote:
> > Hi,
> > 
> > This series carries forward the effort to add Kselftest for PCI Endpoint
> > Subsystem started by Aman Gupta [1] a while ago. I reworked the initial version
> > based on another patch that fixes the return values of IOCTLs in
> > pci_endpoint_test driver and did many cleanups. Since the resulting work
> > modified the initial version substantially, I took over the authorship.
> > 
> > This series also incorporates the review comment by Shuah Khan [2] to move the
> > existing tests from 'tools/pci' to 'tools/testing/kselftest/pci_endpoint' before
> > migrating to Kselftest framework. I made sure that the tests are executable in
> > each commit and updated documentation accordingly.
> > 
> > NOTE: Patch 1 is strictly not related to this series, but necessary to execute
> > Kselftests with Qualcomm Endpoint devices. So this can be merged separately.
> 
> Having to write a big NOTE is usually a hint that you should just have done
> things differently :)
> 
> If you need to respin this series, I strongly suggest that you send the
> Qcom fix separately. It is totally independent, and should be merged ASAP.
> 

Even though it is an independent fix, it is needed to get Kselftests (also the
legacy ones) passing without failures. That's why I kept it as patch 1.
Otherwise, someone may test it and report failures.

> As you know, this series conflicts with:
> https://lore.kernel.org/linux-pci/20241116032045.2574168-2-cassel@kernel.org/
> 
> I don't see any reason why the above patch has not been merged yet,
> but it would be really nice if the above could be picked up first,
> so this series could also add a kselftest testcase for the above.
> 

I was hoping that Greg would pick misc driver changes, but looking at the git
log of this driver I got to know that the changes were picked by PCI folks only.

@kw: Could you please pick the patch from Niklas?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

