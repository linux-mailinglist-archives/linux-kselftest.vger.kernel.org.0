Return-Path: <linux-kselftest+bounces-38985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7382BB26BC5
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 18:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847F4AA7F28
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 15:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB25C2459F3;
	Thu, 14 Aug 2025 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BdulEQfx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3232242D6C;
	Thu, 14 Aug 2025 15:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186911; cv=none; b=idcg1c+SvwiuQ7cFUHAt5/BASP62EIoRlA6PH7D5gcip+bCeyI69syMJOm7wD/jGNk3GDhuxixS67ut1SFvaz/3349z1l35rpGSI2MrmIcXZtLpL1Ezjdmti1HR6h1Nu7melejEauDiPtQsp+eLq4B8iStnznMpVylsBan1BNag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186911; c=relaxed/simple;
	bh=l5NsTlyYGuBSUnU5NHBa/IFlVu8zRwy9gd7QoG3Nf0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oEWPmklWcdatJBz0LXCwPojgvFwSaixlAm/hxRmF4/ih6Y6OVjLDw/h4VnI8PogvzOzRT+XTq7RHQPlaGZYrQGegD7FkzW7i0k5WqqRch8AYqpe8tnQ6T9G4df9p/E0mRaUE5abD3DCFnY9TdxmoVWspV1AxZIpAXZtSrP1Kdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BdulEQfx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=jXSjDuDVOESAA1CoUhZckTlT/FwJb4D/Ow1YcDeFnaI=; b=BdulEQfxRV2ccaccxKzarfTo/z
	a5p2bh5GUyzuzw1HxQDyLwkUDX7rFsvitXp6aPfDs6yxCz2j0YYXDc89c2blR9W7lXsY/Wl0y8wdM
	m3c4Nj2g968qqzQO0ha5OJgSZOttoa7SzShc3qYti5KE2hMzcPuF99OC1kTa2uzDhn/IxRU2iJLOB
	CBCpPU0AkTjDvzCIypvuxY4hcAxN1L/rutQdL/tkROo27pYfHYJ/TzdME62YUQItonRD6VfQ2/jp6
	gARXm66ih3Dv5xj2OlwmUjjhVItk1Ed1bFZ0Qivkm558ML+LqprFoWHU+fcl80X6R/+uIGv8dJRVs
	8Zn6pbuQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umaIH-0000000HXy0-1dDC;
	Thu, 14 Aug 2025 15:55:09 +0000
Message-ID: <e2186e21-d069-4881-8829-b698cf90d5e3@infradead.org>
Date: Thu, 14 Aug 2025 08:55:08 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Documentation: ktap: formatting cleanup
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Workflows <workflows@vger.kernel.org>,
 Linux Kernel Selftests <linux-kselftest@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Tim Bird <Tim.Bird@sony.com>,
 Rae Moar <rmoar@google.com>
References: <20250814012046.21235-1-bagasdotme@gmail.com>
 <98ed6868-8030-4d10-b66d-c7e3d42886f8@infradead.org>
 <aJ2Epp0b3HgeaMxk@archie.me>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aJ2Epp0b3HgeaMxk@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/13/25 11:39 PM, Bagas Sanjaya wrote:
> On Wed, Aug 13, 2025 at 06:58:12PM -0700, Randy Dunlap wrote:
>> Why send this patch series to the workflows mailing list?
> 
> Workflows ML is listed in get_maintainer.pl output.

Thank you. I didn't realize that. So in the MAINTAINERS file
workflows ML is listed under DOCUMENTATION PROCESS and with
these specific directories:

F:	Documentation/dev-tools/
F:	Documentation/maintainer/
F:	Documentation/process/

so yes, you got it right. Thanks!

-- 
~Randy


