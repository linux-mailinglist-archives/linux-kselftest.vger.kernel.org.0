Return-Path: <linux-kselftest+bounces-19922-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479129A1B91
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 09:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B63EFB24B55
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 07:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C2F1C242D;
	Thu, 17 Oct 2024 07:20:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED911BAECA;
	Thu, 17 Oct 2024 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729149640; cv=none; b=DbSegBC2cZdkknUSB83aSQMjcJrPImL5Tff3cIJGIc668XYuDmtlsFZuRxqSEL69y6Kuw20dKZ+F6vvA1+Nc37rRdF7aupnriVTkkpx0tPHOk44D4hrKihPGzzRIhR2UkcUg4f5KjlkmHbH+01JmYAxhTSP+bHOJCuXSTykKng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729149640; c=relaxed/simple;
	bh=fvakE0IN1O3PjI+4aghDRz0swUxzZH/Z11YyglO32ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNvsxpJ8OAbTlB92wpzfeVJuLn1p+FF0vea6oYRUPmgoCZQb0SQG9PYBhWazSGWnxLDS8MohKnbL/d2vpozVXwRP01nD814XA2rg/RCPbRD3RiAPkKtPhsfStDFR4Ohv7bFU9GUhpAc3pDwyBTlxwvK2Ny19o9xDz+wbiS8zdjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7721DFEC;
	Thu, 17 Oct 2024 00:21:05 -0700 (PDT)
Received: from [10.163.39.37] (unknown [10.163.39.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 664883F528;
	Thu, 17 Oct 2024 00:20:33 -0700 (PDT)
Message-ID: <2497f65b-0041-4454-9d72-a1c6699ba1a7@arm.com>
Date: Thu, 17 Oct 2024 12:50:31 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: mm: fix the incorrect usage() info of
 khugepaged
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nanyong Sun <sunnanyong@huawei.com>, shuah@kernel.org,
 zokeefe@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com
References: <20241015020257.139235-1-sunnanyong@huawei.com>
 <37ce9dfa-3193-4e11-bfd1-d2c8b60b0090@arm.com>
 <20241017001441.2db5adaaa63dc3faa0934204@linux-foundation.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241017001441.2db5adaaa63dc3faa0934204@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/17/24 12:44, Andrew Morton wrote:
> On Thu, 17 Oct 2024 12:31:31 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> On 10/15/24 07:32, Nanyong Sun wrote:
>>> The mount option of tmpfs should be huge=advise, not madvise
>>> which is not supported and may mislead the users.
>> Agreed.
>>
>>> Fixes: 1b03d0d558a2 ("selftests/vm: add thp collapse file and tmpfs testing")
>> But nothing is really broken here. This just fixes usage information.
> The usage information is broken!
> 
>> Please drop the "Fixes:".
> Fixes: is appropriate.  It tells people which commit introduced the error.
> 
> I don't think it's serious enough to add a cc:stable.  Others might disagree.

Alright, usage information is part of the functionality itself.

