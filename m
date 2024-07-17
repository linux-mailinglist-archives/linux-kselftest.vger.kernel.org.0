Return-Path: <linux-kselftest+bounces-13829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B702E933B68
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 12:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720DE28112E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 10:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DA77E767;
	Wed, 17 Jul 2024 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LM+ag3Q+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88671878;
	Wed, 17 Jul 2024 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721213271; cv=none; b=dIFMavJkn3lxgO0nwkh9anZHEaTbF2bInpewGD/5NtZHBQSJCyl/nlVpiTyxKv9qkY2ENkjXmD8mTMalVcKPnjRweMm9D+hQBFnWMjUZp+HH96j4v0uBhfGsceAQLLGbmUEFGbU715gyOUry6V0YBquMzvjfjV4LfHF0b9LtEMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721213271; c=relaxed/simple;
	bh=ruY8fr/FDHPN/H5Srs6o/2mLXsBXXssKCNZQ+en4LkU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qfMGMFOF/iXAZrp7mWeSwF/CCfH6N9fGkXi4QZB4BDm3NZHnbzAK2LqvvdHqiBi6kR35MGh5FxVRw25vl0kT7ewZq/trEd3ZIoAlbdnmznOYqwgR1+YxVIOFSbO+VVUZwVuh9CPf4TAkc6AlBqO2f2phiDCBF2ZfcYCyJ1zMdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LM+ag3Q+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721213268;
	bh=ruY8fr/FDHPN/H5Srs6o/2mLXsBXXssKCNZQ+en4LkU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=LM+ag3Q+xxXDeckyZLl5bWQvkGinlvht/MJ+ZYyv5wumRFXODKOQHaDwHuBkm3iIK
	 a9aXDzvD9MCBCYrand53jclBIrjB+AjlcDA/OhTm6N446CF40NyizFY9hHKd6CMmnT
	 tIL35Oyp1MhT8+gxTDJrRYpkjRTpLvt5BABM+n2BPFCgfkk/BOF467s7AeuIMhafl0
	 Gc/CNAeDh+CwBCR/sGV3UYo9EFzGKJpVljXKXLAdw70oFqXp9C981rWsdzTc3gzv9f
	 jocmmnePsjkTzu4XGdF2ep+pu6IGfu6x3RV+EOLhwHbGLuaCI0+g17Fs2cqpl8zMrk
	 yYE5LG/+eojkQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 109D93780BC9;
	Wed, 17 Jul 2024 10:47:44 +0000 (UTC)
Message-ID: <2a5b0ce2-cb82-4a23-bca6-f402cc13627e@collabora.com>
Date: Wed, 17 Jul 2024 15:47:38 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
 "open list : KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, kunit-dev@googlegroups.com,
 "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: Converting kselftest test modules to kunit
To: David Gow <davidgow@google.com>
References: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>
 <CABVgOSmD6j2OK1WXXcO+fTRN7PSpMFph8BT3Unko0c+Bv+3bjA@mail.gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABVgOSmD6j2OK1WXXcO+fTRN7PSpMFph8BT3Unko0c+Bv+3bjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

On 7/16/24 12:33 PM, David Gow wrote:
> On Mon, 15 Jul 2024 at 18:09, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Hi Kees and All,
>>
>> There are several tests in kselftest subsystem which load modules to tests
>> the internals of the kernel. Most of these test modules are just loaded by
>> the kselftest, their status isn't read and reported to the user logs. Hence
>> they don't provide benefit of executing those tests.
>>
>> I've found patches from Kees where he has been converting such kselftests
>> to kunit tests [1]. The probable motivation is to move tests output of
>> kselftest subsystem which only triggers tests without correctly reporting
>> the results. On the other hand, kunit is there to test the kernel's
>> internal functions which can't be done by userspace.
>>
>> Kselftest:      Test user facing APIs from userspace
>> Kunit:          Test kernel's internal functions from kernelspace
> 
> Yes: this is how we'd like to split things up. There are still a few
> cases where you might want to use kselftest to test something other
> than a user-facing API (if you needed to set up some complicated
> userspace structures, etc), or cases where KUnit might be used to test
> something other than individual pieces of functionality, but that
> categorisation is a good start.
Yeah, makes sense. It is helpful to find out what others think. I'll be
back with changes.

> 
> The Documentation/dev-tools/testing-overview.rst page has a more
> detailed look at when to use which test framework (which basically
> just repeats those rules):
> https://docs.kernel.org/dev-tools/testing-overview.html
> 
> Cheers,
> -- David

-- 
BR,
Muhammad Usama Anjum

