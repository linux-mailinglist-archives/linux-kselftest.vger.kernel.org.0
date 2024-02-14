Return-Path: <linux-kselftest+bounces-4616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2362F85445B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 09:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564E11C26F25
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 08:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D347475;
	Wed, 14 Feb 2024 08:53:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAA179C0;
	Wed, 14 Feb 2024 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900829; cv=none; b=pW7EqMmc013pYnSRuCnFDmIRDeGR8KgVUlFuxNyCAUQhliL/ifmrlT//IHYA/pjZ+w3cw/dkJ/VcEPchdso88ZP4cUlhGKtqyNt9DgnwDs9Bw/IoT5wRUS5ZuSJ3nqLjUau/4+UbJF/z2A9310dTBid6sldTLTEvrlpDyYoUSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900829; c=relaxed/simple;
	bh=7yuKfUQdYlngyiEfBODfjH2ZuFBRWHUCv8szbD99F6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxPOxt3tYyJpVd57ii507Y7NdrIJLZ45Kv7Ylyl1rh5yyupnlWuS7JYaBXqQfzbJcj5brlJFLu1TJjyV5VlBKNgQt/vFzv/QGijAD760l2LNB+TPHq83Ri1n6T49h6kDAsT4gP1dWQpuc/Wranx9VsckVrnY+XlZihV6OWU/hz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADD3D1FB;
	Wed, 14 Feb 2024 00:54:26 -0800 (PST)
Received: from [10.57.64.120] (unknown [10.57.64.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99E953F766;
	Wed, 14 Feb 2024 00:53:44 -0800 (PST)
Message-ID: <0e7606c6-9844-4b05-958f-458f9b5b6d34@arm.com>
Date: Wed, 14 Feb 2024 08:53:43 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Don't needlessly use sudo to obtain root in
 run_vmtests.sh
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240209-kselftest-mm-check-deps-v1-1-19b09b151522@kernel.org>
 <17c0b7a1-6ec2-4504-8287-f0fa111b9748@arm.com>
 <ZcdthfAvzLQ9lzvd@finisterre.sirena.org.uk>
 <9ff817f4-e999-4a95-b00d-6984a7ea6181@arm.com>
 <75fa3e12-8b0d-407b-b11f-333be70d157e@sirena.org.uk>
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <75fa3e12-8b0d-407b-b11f-333be70d157e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 19:13, Mark Brown wrote:
> On Mon, Feb 12, 2024 at 08:32:58AM +0000, Ryan Roberts wrote:
>> On 10/02/2024 12:35, Mark Brown wrote:
> 
>>> Ah, I was assuming that some of the suite ran usefully as non-root given
>>> that the only point of that sudo was to acquire root.  If the whole
>>> thing needs to be root then we should instead have a check for root at
>>> the top of run_vmtests.sh and just skip the whole thing if we aren't
>>> root, but then I'm unclear why it's invoking sudo in the first place.
> 
>> I can't speak for how others use the suite, but there are a bunch of setup
>> operations in the script itself that require root (e.g. reserving huge pages).
>> Some of the tests will work without root, I'm sure, but I'm not sure its hugely
>> valuable. Personally, I'd vote for just doing a test for root at the top, as you
>> suggest.
> 
> The hugetlb tests appear to be checking for root while running...  I'm
> not super fussed either way myself, I don't really use these tests
> myself except in a general "keeping an eye on CI" kind of way so I'd not
> object if people wanted to just go for just requiring root for the whole
> thing.

My vote is to keep it simple and require root for the whole thing.

