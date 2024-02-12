Return-Path: <linux-kselftest+bounces-4498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1D5850EE6
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 09:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBAF1C214A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AC733E1;
	Mon, 12 Feb 2024 08:33:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCFF171D8;
	Mon, 12 Feb 2024 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726785; cv=none; b=l+gqiiFfGKFkPkUtwXYg72A1bLmunXYKWJhoJkJi9VNnT8fnKANjG2I7et7iK7Za7ljagUGk5lFKj0yspbWagO2yy8FiMDx4A3BntDfiMRSZNzgF8+GVYA6wZyfVvXmZ+s+EMmqnO5p0xEuRbu3nOaONKTfiFwZZ6OtC+x9NiNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726785; c=relaxed/simple;
	bh=oAx7UdIptNGJIyOG4C2MhW+Ho6HfSOl4NTYv7z3o+MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwlyQZATGr7fWSCuLq6qKAy/i+5Mo4eNCuglrJ8aWn1Z67YpbZPQmeeMiK2igoxyf9bqCGpNjiUREQlcMvnsOj2u2VQTn/5huVn0CZTC1GyhlmHh3IUKWqBT63vXsR062l5ZUvgnGv/6BpumxDfjr3u4bfFJhvyrun9HkqJ7WP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FC3EDA7;
	Mon, 12 Feb 2024 00:33:42 -0800 (PST)
Received: from [10.57.78.115] (unknown [10.57.78.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19CCD3F762;
	Mon, 12 Feb 2024 00:32:59 -0800 (PST)
Message-ID: <9ff817f4-e999-4a95-b00d-6984a7ea6181@arm.com>
Date: Mon, 12 Feb 2024 08:32:58 +0000
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
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZcdthfAvzLQ9lzvd@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2024 12:35, Mark Brown wrote:
> On Sat, Feb 10, 2024 at 07:40:16AM +0000, Ryan Roberts wrote:
>> On 09/02/2024 20:21, Mark Brown wrote:
> 
>>> When opening yama/ptrace_scope we unconditionally use sudo to ensure we
>>> are running as root, resulting in failures if running in a minimal root
>>> filesystem where sudo is not installed. Since automated test systems will
>>> typically just run all of kselftest as root (and many kselftests rely on
>>> this for full functionality) add a check to see if we're already root and
>>> only invoke sudo if not.
> 
>> I don't really see the point of this. run_vmtests.sh needs to be run as root;
>> there are lots of operations that depend on it and most tests will fail if not
>> root. So I think it would be much cleaner just to remove this instance sudo.
> 
> Ah, I was assuming that some of the suite ran usefully as non-root given
> that the only point of that sudo was to acquire root.  If the whole
> thing needs to be root then we should instead have a check for root at
> the top of run_vmtests.sh and just skip the whole thing if we aren't
> root, but then I'm unclear why it's invoking sudo in the first place.

I can't speak for how others use the suite, but there are a bunch of setup
operations in the script itself that require root (e.g. reserving huge pages).
Some of the tests will work without root, I'm sure, but I'm not sure its hugely
valuable. Personally, I'd vote for just doing a test for root at the top, as you
suggest.

> 
>> The problem that I was referring to yesterday, about needing sudo was for this case:
> 
>> CATEGORY="mlock" run_test sudo -u nobody ./on-fault-limit
> 
>> Here, we are using sudo to deprivilege ourselves from root and run
>> on-fault-limit as nobody. This is required because the test is checking an
>> rlimit that is only enforced for normal users.
> 
>> Somebody on list was talking about skipping this test if sudo wasn't present a
>> couple of weeks back. Not sure if that happened.
> 
> Yes, there's a check:
> 
> 	if command -v sudo &> /dev/null;
> 	then
> 	        CATEGORY="mlock" run_test sudo -u nobody ./on-fault-limit
> 	else
> 	        echo "# SKIP ./on-fault-limit"
> 	fi

Ahh that's obviously been added in the last week. The version of mm-unstable I'm
looking at doesn't have that. Although the skip message could do with being
TAP-compliant.




