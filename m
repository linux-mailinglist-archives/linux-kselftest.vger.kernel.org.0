Return-Path: <linux-kselftest+bounces-46949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD40CA0AD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 18:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59FBC3217902
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 17:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7324B334C0B;
	Wed,  3 Dec 2025 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZV8jfWj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51733343E
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Dec 2025 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764782734; cv=none; b=O1k3gyhfVN512C69QIYPh+QzCrEPOXAqVMBNJuaEj+WLvMFdmlSuY7/xtC3wMRfYZi9w2Snxgq9DjMvY5lx/6cbEkOddvePQ0zvID6UQGyQU7wilzME3F5PxMzQ4QIxTFP/vDNf3sC00tHn0U+yZC/MwnCxROvjH7YQ+myC5g14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764782734; c=relaxed/simple;
	bh=6c7cGUs9cfTWhFHVG5mv9TJwxz/8PcRoOPZHLxcU5Nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bEhW3HGNFjeF0tJUnXP0NNtCJJUgHyCOANiULhrn3oUgv7Hd9AF+YLkiVcbyp2/kcxp/qDdgHAnF1EI1eZGEZWgv7iP88m9jkSLbu92D/pxt7FuaomPIw1kHYbsrYoFdOtqChbUReQuqNYxbwE2fwSYf6MPszF316FaiRWGyrFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZV8jfWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FA3C4CEF5;
	Wed,  3 Dec 2025 17:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764782730;
	bh=6c7cGUs9cfTWhFHVG5mv9TJwxz/8PcRoOPZHLxcU5Nc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NZV8jfWjHuUbkKHPTO+RW0jJiDXWoAuIkhIL8EWNeYeG5e+e2EzkQxCkt7tcf5ykr
	 10WfopzlDQS0vuIMFaMLHynQdq3JZFGkRVvWSI7sOk1WvUPA7kO1DFKVekMEHT8CAn
	 9nkVUfuIslaZ2q4Rv3te9IUbxm+vrj8BQ3Je3mVnXTp6xC9zZPVELpnS/DA0ozd9dK
	 0tovUrkF6+rNUFmzIGPROYjOy8M4cl0b/s/IMzvuslcMxzk6bPzCKTt3hD4sd2Hcjs
	 ULIEUB4cIj5PnNstGQ8VYKkWDSEWB/yPDhQbGz+Fh/rYECV1sRnm3vEWCwW8cUBrSH
	 GhujNOfbDWi5Q==
Message-ID: <bb2426dd-3c29-4c94-ac77-aaa0b422b2e7@kernel.org>
Date: Wed, 3 Dec 2025 10:25:29 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems when trying to build tools/testing/selftests
To: Guenter Roeck <linux@roeck-us.net>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
References: <44e08e2f-7f22-4106-b581-56150cafb048@roeck-us.net>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <44e08e2f-7f22-4106-b581-56150cafb048@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/2/25 22:20, Guenter Roeck wrote:
> Hi,
> 
> when trying to build tools/testing/selftests, I get a lot of warnings such as
> 
> mount-notify_test.c: In function ‘fanotify_fsmount’:
> mount-notify_test.c:360:14: warning: implicit declaration of function ‘fsopen’; did you mean ‘fdopen’?
> 
> and subsequent build errors.
> 
> testing/selftests/filesystems/mount-notify/mount-notify_test.c:360: undefined reference to `fsopen'
> /usr/bin/ld: tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:363: undefined reference to `fsconfig'
> /usr/bin/ld:tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:366: undefined reference to `fsmount'
> /usr/bin/ld: tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c:371: undefined reference to `move_mount'
> 
> This does not just affect a single file, but several of them.
> 
> What am I missing ? Is there some magic needed to build the selftests ?

Not sure. It built fine for me on Linux 6.18 latest. Are you missing
a library possibly?

thanks,
-- Shuah

