Return-Path: <linux-kselftest+bounces-22219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A729D1DA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 02:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9628A282884
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 01:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0C812AAC6;
	Tue, 19 Nov 2024 01:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnKyEGhG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC204C79;
	Tue, 19 Nov 2024 01:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731981335; cv=none; b=Ugd1ANzTWuElvw5lE4OkvlGd93bHnKkYnfVQUhhtqPN2WOjUXXOdCIGb1EOAlP6VHelvYvziDgy0o6M0dbHdHC2tbdjMGSbOJXgpvlFf5Y4k0UElo9r5ii4U5P4xSQ4PKA7/+sQ+7bdsEn1FbM/0lborCmgHs+Yq/2jgEcZ8K4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731981335; c=relaxed/simple;
	bh=nbfoeYQK6EhKdq8qOgt2GKP/DAqXwmo30qkQQWl0lCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cb4bDTi6jZjE86qZD2cmersGJWx3oTOnWSkdqKs/NxjpZ0uO0Fm+g5E4M+tVsyVeBPBO+u7N5XEBaqpKym2EH6T0pwGduLTPvCz5m0U9qS+88ic61mRkfnYwm+XdMMG5WdYE/VO59xBAeQWq8POoNKfu4eKLRUhBnAq2DskhW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnKyEGhG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cdb889222so35277835ad.3;
        Mon, 18 Nov 2024 17:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731981333; x=1732586133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QKCvxnGxwarB9jI0/ci1ckuEMFUz5SJJ7vO0XAscHy8=;
        b=LnKyEGhGsRf5dUmowJMAFRp92ht8Zhsf18Dz2JwLdvZnIMWpHxF07iwcXpQgafBf9z
         lwBi7w3COjv52DA+P/hMR6yPi1XqcqVsaPcgAgnVhcgHVnLlvjlTjMz0RLoAJ/7SNqS+
         ub1wY2opx7TOMy7iVdK/pLgkd0qdc5+eXYEmsHBxz0D9EUouggcvYtESu/8exL54IsY/
         yyT4sqF2E+22a8CZS8KBjnBodRuctSjVewh4+hOKLeUtrR+Yc9bJlc5rAAgi6PW1ahKc
         8ZAYgD4uJSKCe7jY74kmTMZC+uR3DJetSkAoIhfozoYCpd8txKuZ870qQIjHndZXBlop
         UCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731981333; x=1732586133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKCvxnGxwarB9jI0/ci1ckuEMFUz5SJJ7vO0XAscHy8=;
        b=ScJeDi0t8PR4UVyZcOlZjL8XKITDqjFMnlROUbKJ7cMcmD7KxO3kEEz9Pe2R1x7w1s
         8TN9SL7+BvaBoJSDQz2Lwyws4DSaEgVyqjipcU4uDV6cKR3+3BIqTPlEWMEa25x+5WeP
         PnPdxz/3pM3ncIB8FYb+CecfpDomZMlVWbyJNtsJAQx95G4BoiXnuzGdWaCdAPMkKn1T
         FRig5h/ROtw9yZ7gJtGMuFtSaA/v8ko9a6lrBI76t8TQDJtomUZ0Bg0tsn3X+8y8acIb
         f3LLkzPUU0DvFF68npSlFHlEddoRsYOa26FcHBVTuZv5AlMJCr8RmYu9llXup5EdRCvO
         pwvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2wl20h0ak/aExuiqqU8uS0CfaFDQzz8XLXAKXfnSMy5igmKzSq9YZsv4kC+SEmln4HKU4cmnbmPqIwpDAfnEg@vger.kernel.org, AJvYcCWCUVRmi+cR9FUQHiJAevRJnG2OLX+90w4sFsffCCRUM6916JyWM9k9o1QdGjj2RjxXU/DDU5Rrf221kTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlTsOy8wOnekC6wYS7ZlW8t3TwFhtoRbOdrApSpUXqvePlvuTh
	U/r1x3GUY/G9JA1iT9ETrKYG2LkuZSvwXZc6OpccX1E3KPQx4VU3
X-Google-Smtp-Source: AGHT+IE1Jb+sOkpEBwtoyowba0RoDPBYa93N+5jz8i6bw/AkiPN6j307nff2peLT9avr89yPDuCPzA==
X-Received: by 2002:a17:902:e750:b0:20b:8ef3:67a with SMTP id d9443c01a7336-211d0d6ee87mr169131815ad.7.1731981332823;
        Mon, 18 Nov 2024 17:55:32 -0800 (PST)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ec8608sm63999285ad.96.2024.11.18.17.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 17:55:32 -0800 (PST)
Date: Tue, 19 Nov 2024 09:55:29 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>
Subject: Re: [GIT PULL] KUnit update for Linux 6.13-rc1
Message-ID: <ZzvwEUIVs0M+/3Yu@visitorckw-System-Product-Name>
References: <589ea100-ee1b-4a37-8f18-a25d86fdb082@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <589ea100-ee1b-4a37-8f18-a25d86fdb082@linuxfoundation.org>

Hi Shuah,

On Mon, Nov 18, 2024 at 12:19:50PM -0700, Shuah Khan wrote:
> Hi Linus,
> 
> Please pull the following kunit update for Linux 6.13-rc1.
> 
> kunit update for Linux 6.13-rc1
> 
> -- fixes user-after-free (UAF) bug in kunit_init_suite()
> 
> -- adds option to kunit tool to print just the summary of test results
> 
> -- adds option to kunit tool to print just the failed test results
> 
> -- fixes kunit_zalloc_skb() to use user passed in gfp value instead of
>    hardcoding GFP_KERNEL
> 
> -- fixes kunit_zalloc_skb() kernel doc to include allocation flags variable
> 
> diff is attached.
> 
> Tests passed on my kunit repo:
> 
> - Build make allmodconfig
> 
> ./tools/testing/kunit/kunit.py run
> ./tools/testing/kunit/kunit.py run --alltests
> 
> ./tools/testing/kunit/kunit.py run --arch x86_64
> ./tools/testing/kunit/kunit.py run --alltests --arch x86_64
> 
> thanks,
> -- Shuah
> 
> ----------------------------------------------------------------
> The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623:
> 
>   Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.13-rc1
> 
> for you to fetch changes up to 67b6d342fb6d5abfbeb71e0f23141b9b96cf7bb1:
> 
>   kunit: tool: print failed tests only (2024-11-14 09:38:19 -0700)
> 
> ----------------------------------------------------------------
> linux_kselftest-kunit-6.13-rc1
> 
> kunit update for Linux 6.13-rc1
> 
> -- fixes user-after-free (UAF) bug in kunit_init_suite()
> 
> -- adds option to kunit tool to print just the summary of test results
> 
> -- adds option to kunit tool to print just the failed test results
> 
> -- fixes kunit_zalloc_skb() to use user passed in gfp value instead of
>    hardcoding GFP_KERNEL
> 
> -- fixes kunit_zalloc_skb() kernel doc to include allocation flags variable
> 
> ----------------------------------------------------------------
> Dan Carpenter (2):
>       kunit: skb: use "gfp" variable instead of hardcoding GFP_KERNEL
>       kunit: skb: add gfp to kernel doc for kunit_zalloc_skb()
> 
> David Gow (1):
>       kunit: tool: Only print the summary
> 
> Jinjie Ruan (1):
>       kunit: string-stream: Fix a UAF bug in kunit_init_suite()
>
The patch [1] intended to address the UAF issue in kunit_init_suite()
is not correct and does not actually fix the problem. A v2 patch [2]
with the proper fix has been sent.

Regards,
Kuan-Wei

[1]: https://lore.kernel.org/lkml/20241024094303.1531810-1-ruanjinjie@huawei.com
[2]: https://lore.kernel.org/linux-kselftest/20241112080314.407966-1-ruanjinjie@huawei.com

