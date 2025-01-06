Return-Path: <linux-kselftest+bounces-23934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BBAA01DE6
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 03:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3694163C5F
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 02:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C12216A930;
	Mon,  6 Jan 2025 02:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4s+3DM7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02AAD2F;
	Mon,  6 Jan 2025 02:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736132041; cv=none; b=d7lfF64rAi2Kd2d8AX5YXFbzYWAPCNhaHB/ZPoptyML0vxYmJr4lTHegR8D5C/zVPqOWmcB5+O63hEZLsAn1WnoNE9qdU+OkDDiUneXj+J/Ek8UhLK0DQdX/kQmBaXcXBKhYMmZB8syD5nPRtwrJiDB8O6nIQy55aK5Oub0WHZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736132041; c=relaxed/simple;
	bh=35czMcYfWqWdhWTrh7yDm8vItzYjaALer1FEV0y/qBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0/fb4JRKfzA/uJLlLu/nNZs7aHlpSzaV2wZr5APH7y4vUvrHjD1DpTV1YZ1F7dx2o2ekbw4Rytz6eDsUR7U8flARqshKIXWFnnKqgHbYQkyRANEex6zI6JysTC58LNPNJMCEVkGZ5qg6EPmiYCUYLHbkJV1X1i1Ynt8Wr9DolM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4s+3DM7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736132041; x=1767668041;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=35czMcYfWqWdhWTrh7yDm8vItzYjaALer1FEV0y/qBU=;
  b=f4s+3DM7cz6szIsuiwLLBkKf/Ze6t+WAlKNw8zRyYMozWs0um+EXA3ze
   tJHGoy06RhuKMhcv4DQBZcAJZXuuBnB6svWNdrScuq8gmooAiYQeGc4JL
   iU5B4pyN7cMb5VWPdSTai6HT68pgakWApUvZv2ti3tq3VG/0RbRqCGm6t
   UPsLCzuRO2qQ8VlfvTUdgJwBJVZ2IhzBZBHvk2rhUuwjVNqn57JTdme0X
   hzozJpP1DIJZfZqsw8KeHUG2GK/ss7DpvQkivbLUgNe2uwebQb+nUQeZS
   g8n092ZtQa+DzWa7AL/dqRSLfs3EZuOrOa9FnVZH/RG46KOtzHEW4APX/
   g==;
X-CSE-ConnectionGUID: 4QXUOTLkTM6FL1hFTaB9+g==
X-CSE-MsgGUID: gHv/CY0cQTygbaQxgs0SIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11306"; a="40044066"
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="40044066"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 18:54:00 -0800
X-CSE-ConnectionGUID: tpZJa4pBRWuPrOdRnS1tJQ==
X-CSE-MsgGUID: leFVVUmYQS+Y1J6MpcV1pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,292,1728975600"; 
   d="scan'208";a="107172779"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2025 18:53:55 -0800
Message-ID: <9e77c4db-afa1-4cd9-8d57-a1241be6ff09@linux.intel.com>
Date: Mon, 6 Jan 2025 10:51:49 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/14] Documentation: userspace-api: iommufd: Update
 FAULT and VEVENTQ
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 dwmw2@infradead.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
 patches@lists.linux.dev
References: <cover.1735933254.git.nicolinc@nvidia.com>
 <14ee2076bfd7df1d2f7a3322d7f24a71b7417867.1735933254.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <14ee2076bfd7df1d2f7a3322d7f24a71b7417867.1735933254.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/4/25 03:43, Nicolin Chen wrote:
> With the introduction of the new objects, update the doc to reflect that.
> 
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---
>   Documentation/userspace-api/iommufd.rst | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

