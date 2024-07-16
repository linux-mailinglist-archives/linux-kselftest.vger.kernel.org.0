Return-Path: <linux-kselftest+bounces-13797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2FF932FEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 20:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B821F23316
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 18:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64ED1A070D;
	Tue, 16 Jul 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqmB3NQZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA8E1A0702;
	Tue, 16 Jul 2024 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154416; cv=none; b=gEgyZjtrfaUfL8mWgEgateu8Hj5cQmL0Pi8hl3Bwy3mp6I2mZhEAPz8q4Fgq/QQGj1FVu2bVlGl8NZIRRMOrwjKc1+2kPHmF7yj0G8t8X+D3omdTLEXZ/lQVeQRDwDhb+miXXrqzF0Ial0OU+OGEb84MXELAtVGVSVNwc8VdbXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154416; c=relaxed/simple;
	bh=ysl9DH2yXr5Lh8llXyDr1QTsZ4bj/lVm5BbTmR2Ro0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hf2unGG3DoNVJpXo+KQMdlQVfOWKvrpKcCPRK17dOiRlq+EwsVmLRlk7b8m/N7sGfZ33nwl8zJZIRYjCya+qd55SMi7O1M6wMlhKmSXrsfkKsRrGZ8CsId+TJVwRHTT9oScnAZ/SfyBc4a4iG95erDu9pX/7q41upRxGmBIl1Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqmB3NQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224B9C4AF0E;
	Tue, 16 Jul 2024 18:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721154416;
	bh=ysl9DH2yXr5Lh8llXyDr1QTsZ4bj/lVm5BbTmR2Ro0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PqmB3NQZ7glH3Q9ZZ8lejHDWoxlb+hGOjENHMv+LkX/KbNqhVtMRXedYx28NnQf61
	 oEpx8Rm90pN6PcmpmZpFEaD4jFa8lBk6X15lh2DRYCZg2EGWmuT7ryCnGe6O1Z9XB2
	 foZa1WTXjoCIV2oRiMuU0NqfjkzyNuuw1RMNg0s7lnIk13ckp4FyabKM+4xW//fVmI
	 LKohF2F5xssPr14h0C5lxVoes2PDmTINwcVBVE1OxwSXCRt34/fK47v6zq90jrt6Ce
	 eKxjnH/gNoaPa2JOxzedae8Tmj/colXT63tch5Bd74jLLVzFvxewm5xV+Zzq6YZq41
	 zvLkAEwtHnfjg==
Date: Tue, 16 Jul 2024 11:26:55 -0700
From: Kees Cook <kees@kernel.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>, davidgow@google.com,
	"open list : KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	kunit-dev@googlegroups.com,
	"kernel@collabora.com" <kernel@collabora.com>
Subject: Re: Converting kselftest test modules to kunit
Message-ID: <202407161124.8DF2E794AF@keescook>
References: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>
 <202407150936.C32FE24CA@keescook>
 <8412a936-b202-4313-b5b4-ce6e72a3392f@collabora.com>
 <202407161005.CACE2E355@keescook>
 <11359c6a-9863-4ffd-8fe4-04b777c72c9f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11359c6a-9863-4ffd-8fe4-04b777c72c9f@nvidia.com>

On Tue, Jul 16, 2024 at 11:04:06AM -0700, John Hubbard wrote:
> This is a classic case of testing a kernel API via ioctl into the
> kernel, so I think it meets your criteria for moving to KUnit.
> Having said that, I must now go try out KUnit in a bit more depth
> before I'm sure that this will work out. But it should.

I've found the docs really helpful:
https://docs.kernel.org/dev-tools/kunit/

Searching for *_kunit.c will also give a lot of examples. And the kunit
folks are really responsive to questions, helping guide finding solutions
to novel testing needs, etc. :)

-- 
Kees Cook

