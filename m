Return-Path: <linux-kselftest+bounces-6914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39401892AA4
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 12:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95742B217C9
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Mar 2024 11:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4D42838E;
	Sat, 30 Mar 2024 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euXEljFp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02421200D3;
	Sat, 30 Mar 2024 11:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711796938; cv=none; b=FEcveKNQgbXWYiT92+YVjwy5sFMhCvs25TnN1P7N2C0/KWpMy63Qnss/Q2f+u5QGdIfPio/razF5ucCzF6j2kNnNqO0CvUFbyYDSdpvIwmBJY9husK5c3GiYkhOk7GTMVI1sEt4WT17bT6H9aB8p3rK/yFOCXO1U5bwIS9tq4QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711796938; c=relaxed/simple;
	bh=8VXre+juWgMI4bw+ps7LXjkOXBPEsjsy51WIROR95I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtBcw1dlulPS3PcE0DMSeOSsNd9d6KBIFsLe9kO00YnyrRjCm61TCRiHo/ZC3zXXtg9ptPGdxwM7iFBGrTPpgsGijbXTCrPM0Kq/pY7oc6R7bCKpgJYNS27MMDXDEE6I47MoxG2St6fNiuswPZbKBm424qOTPeFRwJKB/TI3xKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euXEljFp; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso3312844a12.2;
        Sat, 30 Mar 2024 04:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711796935; x=1712401735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xYKCmanOx7E4s4iOABsWWeyfHS9OU5GO/KxHmhFWWw=;
        b=euXEljFp5sf9iS9jhbkJK0ijQfzJnDhcaKlobjsud2pVom6c/8JjHK54Zj4gvIYnov
         k619iC0b+SLz+P2jAccs0pcVPW6vtKMWmpTQybKPIVgGEZeeLeGT+gemlhNGZ7T1gvqO
         IBR+g7/pApyh9v+KDkf9zfOMahDLClQJB68Rr0VY2lG4KeWwmMK8rQw20WKksf2v2k+Z
         kvixD3HeSxEefXBO45QDemIC9j1mX89yi8e2U7AyCYJh33hJEe98ay8jbSE2A1LrHhHF
         IqpjUSfVZxmMfdunnL5lFzt1OgjlskfZpVVtjFjJStn0TnFKN+kgIILRGIZIQtSu7ZAw
         eoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711796935; x=1712401735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xYKCmanOx7E4s4iOABsWWeyfHS9OU5GO/KxHmhFWWw=;
        b=D2/2V2lQQbEiPxIkvxMnOnI4mWNIeGzB1ZJjfaOpFDv0oFlyxBqUndiKAAQlZPRwwM
         asTATPgNnDAd9FItvFYdgFOqhbhjuzYrI+gZW68MZuUKwkRERCVPimCdugbV2eUQnEj9
         M1fGEnHOYUA0mLh7QpV8+bSB1+ZQakg8tFKI47qab4JQlZ3guJ4GT3A0w04F7FapWTY6
         qqMvmgqthJhpdyqAwCr6Z0vlOMif7xqQZpgtxIFw9r0s3DUwJ2tYgCizuND5qdG7axsg
         jUsFr9StZPDCUUnA8914rtFEl2pCoIgPCFiWYecTJF4/U+YJin+xlcJ6sT9TmZnJEgvx
         sTAg==
X-Forwarded-Encrypted: i=1; AJvYcCX0+p6AYxWrjJCObZ4ttmzJml8S7x2nDkT6WEzkmT//+JHNoC3mpJyRNbf+wbxFGkalxJ+tEF4GGhGgEuYyJLp752bUCKaUcVEtEv2ydBW9Nx357MvkFMw+m+/i4E9TEYM1Rww8g8pZI6k+28tf
X-Gm-Message-State: AOJu0YyW8zk61KB9fnFZTWx55WgMs3i9SMRR5tArNhEg5PvbzUF6jZxg
	cb3VDCLWAEuTuwdyuIqSNwCOXdZj7wAwTrEnSM8BE3JJmZ66l9qpXTSOPoOvfZ0=
X-Google-Smtp-Source: AGHT+IEx02O5HNbOVc8Kj6OvzFHtJiN0t5Ty9Tyfmsay24/ivTTLlzNoZ3LNQ7WgyNi98QjGVEWWjQ==
X-Received: by 2002:a17:907:972a:b0:a46:575c:a9a2 with SMTP id jg42-20020a170907972a00b00a46575ca9a2mr3731178ejc.45.1711796934772;
        Sat, 30 Mar 2024 04:08:54 -0700 (PDT)
Received: from gmail.com (84-236-113-97.pool.digikabel.hu. [84.236.113.97])
        by smtp.gmail.com with ESMTPSA id d19-20020a170906041300b00a4750131edasm2954792eja.206.2024.03.30.04.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 04:08:54 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 30 Mar 2024 12:08:52 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	angquan yu <angquan21@gmail.com>, kernel@collabora.com,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests: x86: skip the tests if prerequisites
 aren't fulfilled
Message-ID: <ZgfyxD15dg9tLzyT@gmail.com>
References: <20240327111720.3509180-1-usama.anjum@collabora.com>
 <1d6418a3-67eb-4a39-891a-7d653a26f1fc@linuxfoundation.org>
 <ZgZvaUbZIr0qpxK5@gmail.com>
 <70698a24-3794-4621-ac74-7aaeae01a750@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70698a24-3794-4621-ac74-7aaeae01a750@linuxfoundation.org>


* Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 3/29/24 01:36, Ingo Molnar wrote:
> > 
> > * Shuah Khan <skhan@linuxfoundation.org> wrote:
> > 
> > > On 3/27/24 05:17, Muhammad Usama Anjum wrote:
> > > > Skip instead of failing when prerequisite conditions aren't fulfilled,
> > > > such as invalid xstate values etc. This patch would make the tests show
> > > > as skip when run by:
> > > >     make -C tools/testing/selftests/ TARGETS=x86 run_tests
> > > > 
> > > >     ...
> > > >     # timeout set to 45
> > > >     # selftests: x86: amx_64
> > > >     # # xstate cpuid: invalid tile data size/offset: 0/0
> > > >     ok 42 selftests: x86: amx_64 # SKIP
> > > >     # timeout set to 45
> > > >     # selftests: x86: lam_64
> > > >     # # Unsupported LAM feature!
> > > >     ok 43 selftests: x86: lam_64 # SKIP
> > > >     ...
> > > > 
> > > > In amx test, Move away from check_cpuid_xsave() and start using
> > > > arch_prctl() to find out if amx support is present or not. In the
> > > > kernels where amx isn't present, arch_prctl returns -EINVAL. Hence it is
> > > > backward compatible.
> > > > 
> > > > Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
> > > > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> > > > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > > > ---
> > > > Changes since v2:
> > > > - Update the changelog
> > > > 
> > > 
> > > Thank you - applied to linux-kselftest next for 6.10-rc1
> > 
> > Please don't, I've applied the patch to tip:x86/cpu with a tidied up
> > changelog.
> > 
> 
> Thanks. I will drop it.

Thank you!

	Ingo

