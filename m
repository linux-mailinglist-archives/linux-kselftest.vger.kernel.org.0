Return-Path: <linux-kselftest+bounces-10228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BED08C5FBF
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 06:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123A12834D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 04:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DBB38FA3;
	Wed, 15 May 2024 04:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9SSwhNF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6213238F82;
	Wed, 15 May 2024 04:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715747236; cv=none; b=P96Bp0fl31p4dTFuBZrXbIc7hxoJjmLKaxHgfscD+3lcUIOjuI2ULsIOqt06GSENEjnYQXhyJP7X2CBI8eEdJm1Vi5C7m/ATrEpnW92jrJb5n2f0XYdTlMzQ6t/NwUe/6989lL0pypUKPjkpiigTLiKteQDdqGCSfEeHlbP0Pws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715747236; c=relaxed/simple;
	bh=uG3TlZQYwVsJzNK3nRYCiUcbCmFyKeITsFWYtpbGuRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFNFZTzZwhCbKcXFUIOpqIFZfCDx+1TLZZl7IAibkmRjySuBGTbbF2whutPrfhtwrks2KPpn+uEhfDYAOHP7eHzsfA0LjU2kUt/wan3UUyL1uBtlMXy9CHbZNK+3FdTZb8TMpgfTkzUw26Gws0jgj0EdQRD1I7Qd9iJ0QZrdEmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9SSwhNF; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6181d032bf9so63004687b3.3;
        Tue, 14 May 2024 21:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715747234; x=1716352034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WiEIOLpsixcgy3ozP40X2dZ487g1O4kcCzqIi9RaQQg=;
        b=P9SSwhNF4AY36TObyP05CQNMXzOu7ELaYori7nka/fA7uIssxQy4OUuFPVdd/fyniH
         arZ+tQoGPQptUIopSPQEkb53al4J6JwXw0/aK3e+7toA8m9aeyT/J/f8B8TFpl6LYqwd
         wGiOxxOBzFx919/Ut0pOsBGaCsnLLE0SHPOPfJDihg3Tgr2424Mg1bCY2pp3uN+f2vwB
         MUoBnnXguRid9VkNO55UW3js8FUAAXCocSsIchJP+VRxn+sqbR8r4CoKbJVAG/x3e+4o
         0tyHilRAygLWxPervDckQcco3XSzS1kHqCAGZrmUQ4I6xft0XaHXME8Clj3TZK2jbSpE
         H+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715747234; x=1716352034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiEIOLpsixcgy3ozP40X2dZ487g1O4kcCzqIi9RaQQg=;
        b=wO/y9qA8Uz6aujkDYmFUEmBl2akWqc3En0WpboiiVcawGmv0V+7198lwXyWKCNoLgg
         HhhUGWtpe8+r8KbVkiL1gItFyHJBX/GggU2W8hX/qVpEWRrlYTB5Y7XdjlDT+Tus50OH
         ZSAps54nqx/7+k0qzCIfCfRx2mXhwnM02SKes0HHZDAayUwkJ32NaG7WwWwPKtWkYJ+7
         5Q7HgPgV92s9CWxueAuPHY3apqFiV0w5QQavnMy0dE781sL519ph4ttMayt88Gghrnzj
         xlALvCiw7uxi1opt5Sa7YlfwPhjQb1UcskzByXPHsw8zKBEM2//ZsCd7Y02F0BSvoSoz
         ffUw==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZS8R8F5h9nRG6dLZTqIBM4/EEYUrg4EqcVM5b18OaIi+mu6x0U8Oa3oWNke/fw248jhMm3TkGEa8ikQ5OMabSlcAqONkU8qj2CP6
X-Gm-Message-State: AOJu0YwnNRceXyOyc+e7dhn/rqK6T0R27g9nbEU1INb9OSYut5sGJmKe
	H5VGCm8/Y5j9lG7cLH84DuqYcqryzgbsCdGFShDeXxL/uf9P62T/tzPi91pIJv8=
X-Google-Smtp-Source: AGHT+IE9EzcDblcgyUuBQZl41P24ypu366NHZpYiJI7vY8L3WexEfNpzbwPKX6UF0opw3iJhK9/P0g==
X-Received: by 2002:a05:690c:f87:b0:61b:1e81:4f65 with SMTP id 00721157ae682-622afd979demr174326217b3.0.1715747234119;
        Tue, 14 May 2024 21:27:14 -0700 (PDT)
Received: from server (S0106f85e42401d5e.cg.shawcable.net. [174.0.240.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ade2besm10350742b3a.98.2024.05.14.21.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:27:13 -0700 (PDT)
Date: Wed, 15 May 2024 04:27:11 +0000
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [RFC PATCH 0/4] selftests/binderfs: Fixes to binderfs_test
Message-ID: <ZkQ5n4pZYv2PfwmH@server>
References: <20240515010805.605511-1-xandfury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515010805.605511-1-xandfury@gmail.com>

Adding Shuah Khan<skhan@linuxfoundation.org> to cc.

-Abhinav.

On Wed, May 15, 2024 at 01:08:01AM +0000, Abhinav Saxena wrote:
> Hi everyone,
> 
> My name is Abhinav Saxena. I am a graduate student at the University
> of Calgary. This is my first patch series for the Linux kernel. I am
> applying for the "Linux kernel Bug Fixing Summer Unpaid
> 2024". Apologies in advance if I made any trivial mistakes :)
> 
> This patch mainly includes issues reported by checkpatch.pl.  The
> changes include:
> - Running clang-format on `binderfs_test.c` to fix formatting issues.
> - Updates the macro close_prot_errno_disarm macro.
> 
> Testing: I tested patches on my local machine (ARM64 ubuntu) with
> checkpatch.pl and running the selftests.
> 
> Best,
> Abhinav
> 
> Abhinav Saxena (4):
>   run clang-format on bindergfs test
>   update close_prot_errno_disarm macro to do{...}while(false) structure
>     for safety
>   Macro argument 'fd' may be better as '(fd)' to avoid precedence issues
>   add missing a blank line after declarations; fix alignment formatting
> 
>  .../filesystems/binderfs/binderfs_test.c      | 204 +++++++++++-------
>  1 file changed, 126 insertions(+), 78 deletions(-)
> 
> --
> 2.34.1
> 

