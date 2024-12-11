Return-Path: <linux-kselftest+bounces-23168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C817B9EC76F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 09:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE85280F70
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2091D90B1;
	Wed, 11 Dec 2024 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+EHGhlN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9C33F6;
	Wed, 11 Dec 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906275; cv=none; b=R6q7UaW98vFGQ7wrxw7fV6dGMpv6J5gOTGi/RvXfwlOxJDhsrZCRffruLj/FYYByHMX30CjeA9YhX/w0BZarpPemcctXyyUBBhj8C+8wrSVqBqBUWZ0fRM+UsHEq1vdPZut9MUkPomXIeTm30MYfyHVKyFIY5hetcHbgw7S89nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906275; c=relaxed/simple;
	bh=P1GiAszIbta6s2sD9isayEmhXtr0Kio9YlMt+Xl684A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XELLY03WheJGnfnEjISL/tpM2C8qLuLfIeIsnNqky9+Wj45Zw9mUa63DE95ameZjawXNhlMYNERvxwSV5KqR/i9Tak5i/CukGrYsCyszfT/NMGL8FrMOmrnkkZQscUeRprHqLeQZzRr2JYA17KQv9FmlK5Vr9yP94rQDSYLBWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+EHGhlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60519C4CED2;
	Wed, 11 Dec 2024 08:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733906274;
	bh=P1GiAszIbta6s2sD9isayEmhXtr0Kio9YlMt+Xl684A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a+EHGhlNcjy8QuRGCc4B+HFv3nVEHpuavWS26HbbSN2uvnLdK6b5A06tHQsrSysn7
	 zxO0TDDqUWT9Im+H1h75PmN03l+CVyhb0BfA4Jw5ov2prNJ7VraI10g9Fp4U/nYIXK
	 Lc3OfNL9lp1Yoi/SfTqs9FFXVaCWIAzP+n1knb7OumK0wG1iJCVveOcA+I7Obkx0ar
	 p/H1btFYyawVCX6cqnKQt8vX6ndFAmLo2H5Ee+Nm0Arr1iiuGICCBvD2EFOIS6/W7c
	 hifIAbaLumXx7WbfFapSeJdPmqVgu46GpQn6EUUPQvOx81T6m3lEaO07rTK91WSrb7
	 Eh0lRXA3GHwjg==
Message-ID: <1bd6ea1e-a5d7-400b-bed7-d9ff7163e960@kernel.org>
Date: Wed, 11 Dec 2024 17:37:27 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] misc: pci_endpoint_test: Fix the return value of
 IOCTL
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, kw@linux.com,
 gregkh@linuxfoundation.org, arnd@arndb.de, lpieralisi@kernel.org,
 shuah@kernel.org
Cc: kishon@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhelgaas@google.com,
 linux-arm-msm@vger.kernel.org, robh@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241211080105.11104-1-manivannan.sadhasivam@linaro.org>
 <20241211080105.11104-3-manivannan.sadhasivam@linaro.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241211080105.11104-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/24 5:01 PM, Manivannan Sadhasivam wrote:
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

Why not simplify as I suggested to avoid all these repetitive (and ugly) "if ()
else" ?


-- 
Damien Le Moal
Western Digital Research

