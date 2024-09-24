Return-Path: <linux-kselftest+bounces-18267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E830983C01
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 06:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D511C21F5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 04:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD63A26AD0;
	Tue, 24 Sep 2024 04:14:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E5928F3;
	Tue, 24 Sep 2024 04:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727151287; cv=none; b=fNLL5rBJKMCqDEMFpH/a4Tm5IKneMqYZoEBe+eyOcG5Bp96g7prFa1pXh1N9qyXcTg86AQT6UMB6dv8wbt7SN0oq0xeeBU6RjUyu0+vyBaGQDL0VBlHmJyXg9nssArBId7tNPQO4+zyp849DZUKFgKYtE8RNEFry9Nw/bb2OeC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727151287; c=relaxed/simple;
	bh=4wA7LJby5MMAlW2VOcDYEOB3y6sEwWK36cno40AV8Cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByObMBqPNnLSlX7lLAn7pa4j+79fpORjiQvCbZee/meLAdZ49+qzrWT/IeeooHcYQJycl95LxCnI+Zp3B33iDzI/QFvqMcZPBbPLECX4ZsH3dYv4BDZuP5nokAx5HmTDDyU2PrC1XYnTtdJN2JXrvMJJqQ4ID8Vrxz1d5uwKBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 542D7DA7;
	Mon, 23 Sep 2024 21:15:14 -0700 (PDT)
Received: from [10.162.43.15] (e116581.arm.com [10.162.43.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84A1E3F6A8;
	Mon, 23 Sep 2024 21:14:42 -0700 (PDT)
Message-ID: <240f982a-a119-4205-b724-605fd627cd03@arm.com>
Date: Tue, 24 Sep 2024 09:44:35 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/damon/access_memory_even: remove unused
 variables
To: Ba Jing <bajing@cmss.chinamobile.com>, sj@kernel.org
Cc: shuah@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240924021426.1980-1-bajing@cmss.chinamobile.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240924021426.1980-1-bajing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/24/24 07:44, Ba Jing wrote:
> By reading the code, I found these variables are never
> referenced in the code. Just remove them.
>
> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>

Reviewed-by: Dev Jain <dev.jain@arm.com>


