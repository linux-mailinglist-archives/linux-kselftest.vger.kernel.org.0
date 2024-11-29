Return-Path: <linux-kselftest+bounces-22626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E2B9DEB0C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 17:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81141650BE
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11083189BAD;
	Fri, 29 Nov 2024 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WfDzfvLM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E3214F9F9
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Nov 2024 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897833; cv=none; b=UiIhSGumYQao1z5BqTk4xRvvihsPDxJnqSYZrUuy1F6eqIFU2Ejp4O/dEMZ34h5aJQPhZKIf+lHuQOszZ5kIVDNvx3P09Lnz9ZWja+kY4OQsxrNuTcBFq30uLMNwt8+gwTAMAtESfFn/jhK6yim8KoHeizOGCnsKcPDUl7BE9tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897833; c=relaxed/simple;
	bh=4LUwpfrnHFkQR7mkasG/yVhtbXt53mi0rkc8s6chCjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0+h6g3XqjsyzO5KyKpib8jqpVX+H3ujj89vx+KyzoKgetOjWLZQcVsJRONCpX06KjfugP2R0L4Lqn4IbTuVOnPylOy4WC3LFbg3DNywbhE+PJ52N3ojRBS4Nwfr00h5Z6iisjfQkEzoAQdJ/L/Tzngf/i7BUsSnXFKuJEPzsfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WfDzfvLM; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7251ce598adso1433290b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Nov 2024 08:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732897831; x=1733502631; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QyeRJ0oZlkItp/9Z/e7gPKi87niWzmGMkQiYND8MHPw=;
        b=WfDzfvLMod+EfZk3ofLK6Onxu8f1JIqIgCo4zuKhf1lmn4K35Ecx7IdTZ/kE4hUjgC
         7QAt6BN7WIWPzD3A8rWGcv+oCk9AI1sZvx9ejQnzbee4z7UlXtHKxrOF80R31uKK8vc5
         6Mn6HwBhCovQbPVizoIpYAcVL/5kF/TZSR0EU9Wgqk6/n6sewkCa6e66mpF+wPs+2SQr
         DAx4LxXpkD1qI7q3q/cUkLAQOaEaSyTTLfJQtqZPLOm8BxNZYY5rw81FWZEVb6ObafPM
         aT0M9Oz9gVFpeMCJtbm7/Cd1H4eR9BkeSpYc9791R8SRXwRkaUBBgYDh3CiaoOxRiBEB
         uvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897831; x=1733502631;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QyeRJ0oZlkItp/9Z/e7gPKi87niWzmGMkQiYND8MHPw=;
        b=sx2x7YKGmmV9kNLAu0vTqvksnP+/3jh5X/XODOfLnSDYI0YXn7WGuQboUXCBkxYZWn
         NbJzKMaEGB6e0uSN/kCLP8uu6btvYyE/oDj0YFP/c5MGQRI4HtfYofqWZin411mwADif
         7s1RNwHUsSeRgkoTVGjtBQJwmY63YV/YoINTcqMXfmv3g5UTV/DuQMBaNJOVt/nxzTqS
         L72N1RIXRCKA36k8o9v4ApJYko10nhZZO+jruAeEXUFoim0d5CjyWEMiA967w3SrNzAF
         KNI8z2YP4FkALYper7JETi2kW3qjrhsC9WsSXA2mgd9xdKQS0fWRY5PjLUd+escF8oHp
         Lwig==
X-Forwarded-Encrypted: i=1; AJvYcCXVhO3jLfdxfjiOChsML+VSg7u3zdgCe38CRuh2DD3CGWDPCz/2tciteKm8B0ON8vyC9+oIZ47WaOVxcLZ7/9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAaUghG8OnNul8KAyBJb4bAu7MurZ3dk9QDGK7P3himE9iAEZ8
	SjGJfbdchyn2gvF+HSwvSLz8hejUsWJJQpgk8jzmBkmFWWg7aFl5CPMK2NtiZg==
X-Gm-Gg: ASbGncsdjQku9IuGAcOTs9crQ3uYi/sgBuIC17drXzcPHvRjPkk8CcmFgVUNyKOa0X8
	fSA3464W/MVdiPoYNKxC7rcvFnAIbZuf147winjTmw48rSvOmUvn9rtd765r7njtyBbnq2uFwHo
	qGx2UXvb7frTVWybq5ZIIUBOJk+Z84yt+SC7e98xKaPogRuF2KmtWQ+SLrvG6O8m66ugk7dXxc9
	nQrIJVC7/+8lWRYb+e6OdV+OMy3S7fHAdqYa2cA+Q3TjbmX+oQNpkphaB5a
X-Google-Smtp-Source: AGHT+IH/b79cT3F2/ZbtOtbSBA5CGpMCFdRTUFf0LguaqMw2cMJZe8pECNxkpAmdc42N2WE/pRPSOA==
X-Received: by 2002:a05:6a00:b45:b0:725:7a8:6f7c with SMTP id d2e1a72fcca58-7253017ba1amr16472888b3a.26.1732897830504;
        Fri, 29 Nov 2024 08:30:30 -0800 (PST)
Received: from thinkpad ([120.60.57.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541828c61sm3677043b3a.163.2024.11.29.08.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:30:30 -0800 (PST)
Date: Fri, 29 Nov 2024 22:00:24 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: kw@linux.com, gregkh@linuxfoundation.org, arnd@arndb.de,
	lpieralisi@kernel.org, shuah@kernel.org, kishon@kernel.org,
	aman1.gupta@samsung.com, p.rajanbabu@samsung.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/4] misc: pci_endpoint_test: Fix the return value of
 IOCTL
Message-ID: <20241129163024.dvz2ojldopeoyr6c@thinkpad>
References: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
 <20241129092415.29437-3-manivannan.sadhasivam@linaro.org>
 <ccd1587a-0368-4bde-9c72-4f10393c58b0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccd1587a-0368-4bde-9c72-4f10393c58b0@kernel.org>

On Fri, Nov 29, 2024 at 07:51:30PM +0900, Damien Le Moal wrote:
> On 11/29/24 18:24, Manivannan Sadhasivam wrote:
> > IOCTLs are supposed to return 0 for success and negative error codes for
> > failure. Currently, this driver is returning 0 for failure and 1 for
> > success, that's not correct. Hence, fix it!
> > 
> > Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Closes: https://lore.kernel.org/all/YvzNg5ROnxEApDgS@kroah.com
> > Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test function device")
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Looks OK to me.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> 
> One nit below.
> 
> [...]
> 
> >  static void pci_endpoint_test_remove(struct pci_dev *pdev)
> > diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> > index 470258009ddc..545e04ad63a2 100644
> > --- a/tools/pci/pcitest.c
> > +++ b/tools/pci/pcitest.c
> > @@ -16,7 +16,6 @@
> >  
> >  #include <linux/pcitest.h>
> >  
> > -static char *result[] = { "NOT OKAY", "OKAY" };
> >  static char *irq[] = { "LEGACY", "MSI", "MSI-X" };
> >  
> >  struct pci_test {
> > @@ -52,63 +51,65 @@ static int run_test(struct pci_test *test)
> >  		ret = ioctl(fd, PCITEST_BAR, test->barnum);
> >  		fprintf(stdout, "BAR%d:\t\t", test->barnum);
> >  		if (ret < 0)
> > -			fprintf(stdout, "TEST FAILED\n");
> > +			fprintf(stdout, "NOT OKAY\n");
> >  		else
> > -			fprintf(stdout, "%s\n", result[ret]);
> > +			fprintf(stdout, "OKAY\n");
> 
> Maybe replace all this "if (ret < 0) ... else ..." and all the ones below with
> something a call to:
> 
> static void test_result(int ret)
> {
> 	fprintf(stdout, "%sOKAY\n", ret < 0 ? "NOT " : "");
> }
> 
> or simply with the call:
> 
> 	fprintf(stdout, "%sOKAY\n", ret < 0 ? "NOT " : "");
> 
> to avoid all these repetition.
> 

Sounds good to me. Will incorporate in next version, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

