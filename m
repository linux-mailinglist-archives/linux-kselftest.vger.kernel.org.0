Return-Path: <linux-kselftest+bounces-22616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5709DC267
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 11:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4038BB22880
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 10:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326911991AE;
	Fri, 29 Nov 2024 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXd83j1N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D271990DE;
	Fri, 29 Nov 2024 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732877494; cv=none; b=nlMs2unGdD4h4cAst22AFbBF7TE35oLravX10I21b2SG6czPAskxkYxCOOHaqxb7SAp6cAvGAJAqLTgM7gShWsZjgUd1nja97RBDtNcq6KkEJer5aC7LDWY8aF8jomVlWAoIXau76fowcEcbmFecU4Gp2ZojGJHjqLKARz0uB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732877494; c=relaxed/simple;
	bh=Glmbj0DMfcjFxWhAUgiB2tFNmYA96JJlsXdCuhHmZKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1qw4EkLyrxLgtRGdS2hvbbvSd63AyKbBhmcxYryps7ho+KDeIh3dYhN5pMBHVU7yFYEvTlAfzuYPBg6Z/nW235Wmoi9P8nRDujNrG7XYg1vqSoe6szcfi2TxROsel9307deX7z/UK6n2soKPZO89rc1n8n/J5Betrc1EiQ7vtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXd83j1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7479DC4CED3;
	Fri, 29 Nov 2024 10:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732877493;
	bh=Glmbj0DMfcjFxWhAUgiB2tFNmYA96JJlsXdCuhHmZKQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FXd83j1NGaShS82H4l9sYzRPRuuyVzSptiwY6DSjJh1iWJrjZ5EL0ytG482OjlOPv
	 UcJv0nbITSIAXPLFsCc0/vIg5zS5KrxqVz3u4/kf+5DtklZVeZBi8KGSZu6m7c2cPW
	 15AbyA80ChUhTVt+nQaLFrt0mJ+itucL+F6az258Lqf4gluegv9wT7AdSkrirmLmsi
	 EOTNFHuWqCcO8/SsDOL45qhVpK8G69Y08Vd/k+Ae4+IYCeZe4if3f62RZpKbwcr6Sp
	 Oc4mRbaUnnqtiQOUq9Nr/p6eE+pMoYLBw0xnT96vqpXzWSLkm7wjiLyjRcMpOCMQNA
	 jly3H5jjBw17Q==
Message-ID: <ccd1587a-0368-4bde-9c72-4f10393c58b0@kernel.org>
Date: Fri, 29 Nov 2024 19:51:30 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] misc: pci_endpoint_test: Fix the return value of
 IOCTL
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, kw@linux.com,
 gregkh@linuxfoundation.org, arnd@arndb.de, lpieralisi@kernel.org,
 shuah@kernel.org
Cc: kishon@kernel.org, aman1.gupta@samsung.com, p.rajanbabu@samsung.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, linux-arm-msm@vger.kernel.org, robh@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241129092415.29437-1-manivannan.sadhasivam@linaro.org>
 <20241129092415.29437-3-manivannan.sadhasivam@linaro.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241129092415.29437-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 18:24, Manivannan Sadhasivam wrote:
> IOCTLs are supposed to return 0 for success and negative error codes for
> failure. Currently, this driver is returning 0 for failure and 1 for
> success, that's not correct. Hence, fix it!
> 
> Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Closes: https://lore.kernel.org/all/YvzNg5ROnxEApDgS@kroah.com
> Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test function device")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

One nit below.

[...]

>  static void pci_endpoint_test_remove(struct pci_dev *pdev)
> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> index 470258009ddc..545e04ad63a2 100644
> --- a/tools/pci/pcitest.c
> +++ b/tools/pci/pcitest.c
> @@ -16,7 +16,6 @@
>  
>  #include <linux/pcitest.h>
>  
> -static char *result[] = { "NOT OKAY", "OKAY" };
>  static char *irq[] = { "LEGACY", "MSI", "MSI-X" };
>  
>  struct pci_test {
> @@ -52,63 +51,65 @@ static int run_test(struct pci_test *test)
>  		ret = ioctl(fd, PCITEST_BAR, test->barnum);
>  		fprintf(stdout, "BAR%d:\t\t", test->barnum);
>  		if (ret < 0)
> -			fprintf(stdout, "TEST FAILED\n");
> +			fprintf(stdout, "NOT OKAY\n");
>  		else
> -			fprintf(stdout, "%s\n", result[ret]);
> +			fprintf(stdout, "OKAY\n");

Maybe replace all this "if (ret < 0) ... else ..." and all the ones below with
something a call to:

static void test_result(int ret)
{
	fprintf(stdout, "%sOKAY\n", ret < 0 ? "NOT " : "");
}

or simply with the call:

	fprintf(stdout, "%sOKAY\n", ret < 0 ? "NOT " : "");

to avoid all these repetition.

>  	}
>  
>  	if (test->set_irqtype) {
>  		ret = ioctl(fd, PCITEST_SET_IRQTYPE, test->irqtype);
>  		fprintf(stdout, "SET IRQ TYPE TO %s:\t\t", irq[test->irqtype]);
>  		if (ret < 0)
> -			fprintf(stdout, "FAILED\n");
> +			fprintf(stdout, "NOT OKAY\n");
>  		else
> -			fprintf(stdout, "%s\n", result[ret]);
> +			fprintf(stdout, "OKAY\n");
>  	}
>  
>  	if (test->get_irqtype) {
>  		ret = ioctl(fd, PCITEST_GET_IRQTYPE);
>  		fprintf(stdout, "GET IRQ TYPE:\t\t");
> -		if (ret < 0)
> -			fprintf(stdout, "FAILED\n");
> -		else
> +		if (ret < 0) {
> +			fprintf(stdout, "NOT OKAY\n");
> +		} else {
>  			fprintf(stdout, "%s\n", irq[ret]);
> +			ret = 0;
> +		}
>  	}
>  
>  	if (test->clear_irq) {
>  		ret = ioctl(fd, PCITEST_CLEAR_IRQ);
>  		fprintf(stdout, "CLEAR IRQ:\t\t");
>  		if (ret < 0)
> -			fprintf(stdout, "FAILED\n");
> +			fprintf(stdout, "NOT OKAY\n");
>  		else
> -			fprintf(stdout, "%s\n", result[ret]);
> +			fprintf(stdout, "OKAY\n");
>  	}
>  
>  	if (test->legacyirq) {
>  		ret = ioctl(fd, PCITEST_LEGACY_IRQ, 0);
>  		fprintf(stdout, "LEGACY IRQ:\t");
>  		if (ret < 0)
> -			fprintf(stdout, "TEST FAILED\n");
> +			fprintf(stdout, "NOT OKAY\n");
>  		else
> -			fprintf(stdout, "%s\n", result[ret]);
> +			fprintf(stdout, "OKAY\n");
>  	}
>  
>  	if (test->msinum > 0 && test->msinum <= 32) {
>  		ret = ioctl(fd, PCITEST_MSI, test->msinum);
>  		fprintf(stdout, "MSI%d:\t\t", test->msinum);
>  		if (ret < 0)
> -			fprintf(stdout, "TEST FAILED\n");
> +			fprintf(stdout, "NOT OKAY\n");
>  		else
> -			fprintf(stdout, "%s\n", result[ret]);
> +			fprintf(stdout, "OKAY\n");
>  	}
>  
>  	if (test->msixnum > 0 && test->msixnum <= 2048) {
>  		ret = ioctl(fd, PCITEST_MSIX, test->msixnum);
>  		fprintf(stdout, "MSI-X%d:\t\t", test->msixnum);
>  		if (ret < 0)
> -			fprintf(stdout, "TEST FAILED\n");
> +			fprintf(stdout, "NOT OKAY\n");
>  		else
> -			fprintf(stdout, "%s\n", result[ret]);
> +			fprintf(stdout, "OKAY\n");
>  	}
>  
>  	if (test->write) {
> @@ -118,9 +119,9 @@ static int run_test(struct pci_test *test)
>  		ret = ioctl(fd, PCITEST_WRITE, &param);
>  		fprintf(stdout, "WRITE (%7ld bytes):\t\t", test->size);
>  		if (ret < 0)
> -			fprintf(stdout, "TEST FAILED\n");
> +			fprintf(stdout, "NOT OKAY\n");
>  		else
> -			fprintf(stdout, "%s\n", result[ret]);
> +			fprintf(stdout, "OKAY\n");
>  	}
>  
>  	if (test->read) {
> @@ -130,9 +131,9 @@ static int run_test(struct pci_test *test)
>  		ret = ioctl(fd, PCITEST_READ, &param);
>  		fprintf(stdout, "READ (%7ld bytes):\t\t", test->size);
>  		if (ret < 0)
> -			fprintf(stdout, "TEST FAILED\n");
> +			fprintf(stdout, "NOT OKAY\n");
>  		else
> -			fprintf(stdout, "%s\n", result[ret]);
> +			fprintf(stdout, "OKAY\n");
>  	}
>  
>  	if (test->copy) {
> @@ -142,14 +143,14 @@ static int run_test(struct pci_test *test)
>  		ret = ioctl(fd, PCITEST_COPY, &param);
>  		fprintf(stdout, "COPY (%7ld bytes):\t\t", test->size);
>  		if (ret < 0)
> -			fprintf(stdout, "TEST FAILED\n");
> +			fprintf(stdout, "NOT OKAY\n");
>  		else
> -			fprintf(stdout, "%s\n", result[ret]);
> +			fprintf(stdout, "OKAY\n");
>  	}
>  
>  	fflush(stdout);
>  	close(fd);
> -	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
> +	return ret;
>  }
>  
>  int main(int argc, char **argv)


-- 
Damien Le Moal
Western Digital Research

