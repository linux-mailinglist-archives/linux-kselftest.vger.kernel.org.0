Return-Path: <linux-kselftest+bounces-43349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C12BE5140
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 20:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ABBB1A64FAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 18:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352012367D9;
	Thu, 16 Oct 2025 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="prBlN1HS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4272223DEF;
	Thu, 16 Oct 2025 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639912; cv=none; b=FfK/ILTZWxZgucvFlJrLEGWdG2YJ0HtcEroR9RFy+EQad1x8rB8KHktSVSDeUNOIlO7jDRPcjlmwcHOtqXW2GVp5hPoukydzQXMOJqf7VXHde98k92bEucyLapZXlDbd4JSKFSfzMYe4OzyjY57FwAGdzJ8VCkAczm5oigmLNIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639912; c=relaxed/simple;
	bh=lpRbctUBWqBep6Xgo3pEO0HiCA5brr76VlzelN7dEV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnmZX/avm/zx6hU7KbpElS2FRSE3NiV4nKik/EHpzffj4XN5CmjDxnvVLkbLMvBMy7hzoRNUIdH2WF9T5hqfgwZ9r53asyos4Qe4M3JRn43TJM/YWaYFksfk1BIE9tSuP+ecOKGen5q0nwJMPTlNy15j+5Js3L8WEUSU445mw3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=prBlN1HS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+XIWR2eV9vDmJV3kHEKdDfSedYJ6d43lfi9oTM5VR7A=; b=prBlN1HSEHCz2rSrto+OvAszUa
	+7gyWm50b7kw9SuZMp7/G7pmIiqtpTVQsL3YiXZmyY55JmpycC6j2CXwRZRoaLKohPO2kiakNXHQq
	7O21baRK5rgyyLHMRSnvBvIpb5C4rA5npNiOErx8v13zPYpLA3O2V+mn0IUM4RHbgUslbOKMssZL/
	vTH7cUaK5I8LVFZ5LgL5xdVyGflRq1Yu/V48X1BIcHyT1Sy+onDjc+MC7mDrZoG/oY5SuFTTUqC5X
	tavGmPbbCxUbixzH4iZ5IKp0u7sH6xUdqfBMHG2WKNXgvbheaaLkp6I80Q4v3+X4CUv7wbOC28Xqc
	no5Qzp0w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9Srs-00000005i4y-0JD9;
	Thu, 16 Oct 2025 18:38:28 +0000
Message-ID: <ee48ad77-e6d5-4954-832c-ebc42e6a1cfe@infradead.org>
Date: Thu, 16 Oct 2025 11:38:27 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] revocable: Add fops replacement
To: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kselftest@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
 <20251016054204.1523139-6-tzungbi@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251016054204.1523139-6-tzungbi@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/15/25 10:42 PM, Tzung-Bi Shih wrote:
> +/**
> + * fs_revocable_replace() - Replace the file operations to be revocable-aware.
> + *
> + * Should be used only from ->open() instances.
> + */
> +int fs_revocable_replace(struct file *filp,
> +			 const struct fs_revocable_operations *frops,
> +			 struct revocable_provider **rps, size_t num_rps)
> +{

Please add the function parameters to the kernel-doc comment to avoid
kernel-doc warnings. E.g.:

 * @filp: foo description
 * @frops: bar description
 * @rps: baz description
 * @num_rps: number of @rps entries


-- 
~Randy


