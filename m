Return-Path: <linux-kselftest+bounces-28793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CF3A5D52C
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 05:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F3918944DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 04:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768E11DB933;
	Wed, 12 Mar 2025 04:58:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEBD1CD215;
	Wed, 12 Mar 2025 04:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741755495; cv=none; b=XtQs1rMyjNgowOiWEp01/vsuI5B0CB8wx5PSVTRNdD/cTUDf4NONVAABYPFPLVgRSpIeyQX1fIiUVnP384IdfqO6HCieUZxN/DQ19a0AS+DU6LIjeULi3Iyowhe4MYjVzsl2ofABs4bnfvkK/dXfqc8LpNPf+xEyPFf13CDNAGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741755495; c=relaxed/simple;
	bh=ECYwJZBrLoF83761dihrLkGa6j/q3ptBCtDxYK135qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNHNUR1XccESpwbd59Ev0YeVfg5LZCWywk8TizpvsWhfyWdHq6jXeZB1FdlN5yNWPohJsxJL3UU+/gkxyOTJiy49LHwG/gZ9DHeLhwWy8MK+QFVFmBqT628fubqTYX6xOEW2eznc5MnMl2vM3FPpFzmhlmzyXmPy+sus6ZRBZJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38D45152B;
	Tue, 11 Mar 2025 21:58:17 -0700 (PDT)
Received: from [10.162.43.49] (K4MQJ0H1H2.blr.arm.com [10.162.43.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12DD13F5A1;
	Tue, 11 Mar 2025 21:58:03 -0700 (PDT)
Message-ID: <b7d07379-3e80-42af-9234-31f4f5ec7489@arm.com>
Date: Wed, 12 Mar 2025 10:28:00 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm/cow: Fix the incorrect error handling
To: Cyan Yang <cyan.yang@sifive.com>, akpm@linux-foundation.org,
 shuah@kernel.org, david@redhat.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250312043840.71799-1-cyan.yang@sifive.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250312043840.71799-1-cyan.yang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/03/25 10:08 am, Cyan Yang wrote:
> There is an error handling did not check the correct return value.
> This patch will fix it.
> 
> Fixes: f4b5fd6946e244cdedc3bbb9a1f24c8133b2077a ("selftests/vm: anon_cow: THP tests")
> Signed-off-by: Cyan Yang <cyan.yang@sifive.com>

Reviewed-by: Dev Jain <dev.jain@arm.com>

