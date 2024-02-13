Return-Path: <linux-kselftest+bounces-4576-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D05853A7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 20:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75BB1C25027
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Feb 2024 19:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474661CA8F;
	Tue, 13 Feb 2024 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2Zj+Lw5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E26111AA
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Feb 2024 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851002; cv=none; b=XwGlfn/QKDSXfLymWF01QxGig1g60WaeKa/YiOUwXHD11/+u7+zLY29BoMQaQnd7SMTeqKLHOheLq0uIkQ22HyAcir+8FTp0kaW3fX+YS5pQx0x2J+8E2HuC2XDfBkOXnqECp2h8GfYeAD6Y74CxOlqVjf+IcL/JORdI95jYIOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851002; c=relaxed/simple;
	bh=AVKluNExNHT6Mn0krhj0AePAyvPf6omOyM9JCMx+mgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQ7WMqn/aD/fo4wdvf8zd2H5b76L6ZQxxskyI+wMjN/54Uml/h+ExJ1KNJmVIRv5iV7WpJczHsYNLfowFey3Ap0P8vjhMYrvRD3iV78pcjZ7rth4AC1OfFqfJ8BQhtDDBR5PHrbQyU8Ge3AnpvZ0LmQerWb3ceFtJZ8eIv7ePDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2Zj+Lw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A406C433C7;
	Tue, 13 Feb 2024 19:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707851001;
	bh=AVKluNExNHT6Mn0krhj0AePAyvPf6omOyM9JCMx+mgA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A2Zj+Lw5NVDqIpsDlNjCNjwpIkOcbtSIF6It8rvlv033q5Lj0MZOJdIXdLrptVG3d
	 AsuB87gUwshMSjz2FKMuqhowW7Tf0/RYuPsEF3Dm9maSWFNB0DtUeaOq1eyZh/M7Vy
	 BAwk98sAZjxEfx3/TMiq2tI55LR4RFLCGqNQdO3m27g0yliJGl0ZtpZXkhg84wkb8S
	 52Artoo8b0fA53FHqCrYyuSpnU/7f/u+3gfvssLgBPTiSND3HkIaK3Pw+TOPyFxyNw
	 eQ+GAVJvotYA4mrOT1fJVwKuvIRdDmqHWw6LF3pavJOGbUacKDgM4L8Ek4y/qVlQ8q
	 c4RvWf3qHk05Q==
Message-ID: <d860b9a2-0914-404d-aa60-48fdc0d6c9be@kernel.org>
Date: Tue, 13 Feb 2024 12:03:21 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: resctrl selftests ready for inclusion
To: Reinette Chatre <reinette.chatre@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 shuah <shuah@kernel.org>
References: <39f71a7a-9a3c-4b0e-aa11-7b94f1003cc4@intel.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <39f71a7a-9a3c-4b0e-aa11-7b94f1003cc4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 11:06, Reinette Chatre wrote:
> Hi Shuah,
> 
> Could you please consider Ilpo's resctrl selftest enhancements [1]
> for inclusion into kselftest's "next" branch in preparation for the
> next merge window?
> 
> Thank you very much.
> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/20231215150515.36983-1-ilpo.jarvinen@linux.intel.com/

Sorry for the delay. This also ended yup in my spam.

thanks,
-- Shuah

