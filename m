Return-Path: <linux-kselftest+bounces-47091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFF1CA658B
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 08:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EDAC304C985
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 07:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C142E8B6C;
	Fri,  5 Dec 2025 07:15:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D2926C3B0;
	Fri,  5 Dec 2025 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764918929; cv=none; b=bWOr2JN/IzVMXjtGYFFauJgUcUw4YD8q9YltR+UNWKjuaG0VBc5/0sTn48fEg8QiZw70OPiVseQETgakssNWFa3dYlfqnl1P7B8+O10nHQZzf9hhoIK3jcNVUsqBFtupRm0/4QClf2SXZjcd83SrD7+qG/XzNxgiKlBj5BsVr94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764918929; c=relaxed/simple;
	bh=JF0R2KKNXnghqbJLNnzi14kmoLvvAZflarM4SvoCNyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMqnA2QgdN5sStaUm+VpnEoi173wTKHDiGDJ6bUW1JrctMNiYn8NMmayBGJukNUDrV+7q+W+is2/o0O0+I+pfwuoI2GGeCxbl1xCzR86kE2spCi/jxaQshNmrOwMLBpkHcAPsbbxbgFiPHKjCYX6MxnUHOmw/6JzlLLIcs159PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
Received: from 172.18.26.4(mailfrom:shenxiaochen@open-hieco.net fp:SMTPD_---.fdRjYRY_1764918911 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 05 Dec 2025 15:15:15 +0800
Message-ID: <7fa13af7-48d1-4cb8-a42a-5ccf58baed4f@open-hieco.net>
Date: Fri, 5 Dec 2025 15:15:10 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftests/resctrl: Fix non-contiguous CBM check for
 Hygon
To: Reinette Chatre <reinette.chatre@intel.com>, tony.luck@intel.com,
 bp@alien8.de, fenghuay@nvidia.com, shuah@kernel.org,
 skhan@linuxfoundation.org
Cc: babu.moger@amd.com, james.morse@arm.com, Dave.Martin@arm.com,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shenxiaochen@open-hieco.net
References: <20251204123816.2802393-1-shenxiaochen@open-hieco.net>
 <20251204123816.2802393-4-shenxiaochen@open-hieco.net>
 <87eb3a3d-854d-4c3c-a075-9096ca67c89d@intel.com>
Content-Language: en-US
From: Xiaochen Shen <shenxiaochen@open-hieco.net>
In-Reply-To: <87eb3a3d-854d-4c3c-a075-9096ca67c89d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 12/5/2025 8:55 AM, Reinette Chatre wrote:
>> Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
>> ---
> I think it may help to add a maintainer note here to highlight even though this
> is a fix it is not a candidate for backport since, based on your other series,
> support for Hygon is in process of being added to resctrl.
>

Great suggestion.
I will add a maintainer note as you suggested in v2 patch series.

 
>>  tools/testing/selftests/resctrl/cat_test.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 
> Reinette

Thank you very much for code review!


Best regards,
Xiaochen Shen

