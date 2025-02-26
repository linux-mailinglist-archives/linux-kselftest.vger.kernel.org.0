Return-Path: <linux-kselftest+bounces-27554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1629AA454F7
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 06:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3474E3A6E98
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 05:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BB7192B9D;
	Wed, 26 Feb 2025 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOEz30dZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8E142E67;
	Wed, 26 Feb 2025 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548730; cv=none; b=lvb2XQY2WNPMJDcbsK0c5nFpjPv07E4BS2YKbOnu237y0ifMbtZ0tFTYZpLfjgFzun9UwUxiAZmAoCMwm8Ra41YAkI5rv22OMIz85Q/flCERTkSd7yyyx0EfiaAZq7olmsAdBjHd07lvK33TsPvED8IYJYgcnIbnRulvh9EB1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548730; c=relaxed/simple;
	bh=++6djOQAEe1B+vd/9KrPcvRzuDgVELNpD0pj9UUy6NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jyyv3J5lkZrPm6hd8jHvP7fvf77uY33WrcCQOH4Nx0Paq6y8Cb2a2AamRRKVP+PgvcepK4Xbx/fuskggd7gGWgfIaXA6vHz0kte8fivF47cFN8I1ljXXvOzvxwsnU1J0Q1PvCrwNoG/QUJwqOPaOJ7jVJw3tjiKJ/GFHnK7nnlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOEz30dZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740548729; x=1772084729;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=++6djOQAEe1B+vd/9KrPcvRzuDgVELNpD0pj9UUy6NY=;
  b=SOEz30dZmSH0lVNFdYhBOtwwcX5vo8SUBxDjv2j4C8q8rObEpslxfb0r
   XJORzeG6bRglL3t4A5NhqhGeThsykHXUlQHANKTCLx9UPsOl65MxF393I
   5rwPIyBmN6jYoE3BddkwxYMAmLA1LnEOllq2mv9l5qsrvPz8pZTltqYoN
   URDOGW3UbHETbec3RyGEJyncvvX5Rm1JN9c6oKjSGk+3quO9nAA1uaiL+
   SAE+4yG/0yPjCHghoyCZFUYIxTEUgIL4GRlxSJqj8CnSxy1vfbTLnadNV
   Vb9WNfsf0hO/7qtQ+cQnD8flHsUYPpzrYeM695U7xiteem+3QhswsBcwC
   A==;
X-CSE-ConnectionGUID: WhYnZFsWQ9CXqsw0mjlmHg==
X-CSE-MsgGUID: ariBtS4oSs68acLVDzTYcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="45295784"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="45295784"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:45:28 -0800
X-CSE-ConnectionGUID: 8Y9jzLmYR7alrBOq2PtsJQ==
X-CSE-MsgGUID: ZeGz/YAkQ9CzhM7IwOb3uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="147428792"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:45:22 -0800
Message-ID: <e6922f47-a804-491f-a3c1-1fd93b7b4edd@linux.intel.com>
Date: Wed, 26 Feb 2025 13:42:07 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/14] iommufd/fault: Move two fault functions out of
 the header
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 dwmw2@infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org, eric.auger@redhat.com, jean-philippe@linaro.org,
 mdf@kernel.org, mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
 praan@google.com, patches@lists.linux.dev
References: <cover.1740504232.git.nicolinc@nvidia.com>
 <14a01d676b06dc7c013edba6961a4c1e9503a4e1.1740504232.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <14a01d676b06dc7c013edba6961a4c1e9503a4e1.1740504232.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 01:25, Nicolin Chen wrote:
> There is no need to keep them in the header. The vEVENTQ version of these
> two functions will turn out to be a different implementation and will not
> share with this fault version. Thus, move them out of the header.
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

