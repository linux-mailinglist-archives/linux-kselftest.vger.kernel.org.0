Return-Path: <linux-kselftest+bounces-34748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5FDAD5CA1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 18:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82935188EC95
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 16:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8261E2139B0;
	Wed, 11 Jun 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ags5zr5g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D3210F44
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660467; cv=none; b=V7QCyfEDQbh0xDga/Dk6vOg4rqB0x6VngDbnCVe/jUj0BGY2/j14Hhg1D+3B4Q+fpyGDGobGtgy4XLp8sdPsBO+M2xhj43b0b8t54OWejSArVcMCwg7ZxZhkteHtfyZvjGBqfvGlqoLxlLfVznOu6KvcrUwOcdbBpL3Gy84q/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660467; c=relaxed/simple;
	bh=B9MohXx4AXA4k+FrYa3U3UV1gxDApK8skRfveXG9R7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNaKjbsiwUAOaLsGLR/Kydw+wjmw8TSL29O3ou0WITXq7xOpmCVBbEzm4E9Ysgma21A1RyzCiPJbTqTYvKBxUi/70aCIfsqcedslmF4/0DXh+FmdtOLeo7ADsUwWQN87H8/b8hTnsiJ4u6E8uVeJic2WeCbXmDbECGmV0g2iSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ags5zr5g; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so78604f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 09:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749660464; x=1750265264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aa2QXtJbJhCTINUZzXosw2JXgzKQuhbyrlej22q07Vo=;
        b=Ags5zr5g2o99dUpv8971TmqpooEfBJ4KFAbpmH5witIphzt/Fvz1muSpAuX1Evkrsr
         skMCAqrRkjDdykvh8EKIkW8ym7eyzXq0vZ4KO0WyPqgAPYTu4RW4Qo1Gn428luIy4VuR
         ux0DDRzOi8q1LdQ1kBZaPx//Fa/EOyvhzHGLvpKQkOMYMbiMd8sbcABpTt8Fngt/raSD
         ghYLwBfQMpjyQL6pI4A0gXICTOkcu4WCzuxmzvkNoMiycmL1ombhzpmO/5Zg+q5jhoia
         bj32WzEnR5Jkz8dFhHlCmSj5XKc0guVqb1mE48P72JC4jjTXojBPx4d1jJsNEE49Zs2w
         40uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749660464; x=1750265264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aa2QXtJbJhCTINUZzXosw2JXgzKQuhbyrlej22q07Vo=;
        b=V87fAxw/nfv2gBJRP9fnQI8j6wcs5HVIjvNffPBzmktPmYUCcV3Tf7iRTPFUSYBan4
         TbHJZ8g9h2YJRLfvHzj4B0L0OTRUlsbpAu07982IUpDTYB+PcPEQNFODI5Joo8HA4xG6
         izULYyQBD56AYiNXxqK87yBw0fKIOXMCFUVCEsVuVab89shrUwzV1kT8aspDU/s2Q+SS
         aO24RXczT7rsqPHTpW35sjiwXVCZCKi/1sWxEfbYi3XTHIuewgCycDqdM+VZGQyljLeB
         3b1VFWwmvhIa35e1uZ3Eo/k9xWSn08QD7lQYhb35L9Cj5vhfqPxvLswjQRPgOTI5G0Z1
         XLhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTeXepqSwJIwmUOI6CnLuocrfRqGxph3sS0mRjP67x7vR/QCtJT1QH5wjHJw4+xJ4VhOaLAYj4UZqc4+wHJlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaxqPrQTvmgfD40UxRJ63LM43U2uUuq/Y7R++30LEjybjs0dg/
	m1O+rmt5A/UujcQgtu8tm03maPcIMkszdD3uhxK5JCrzVEZaqHpDaEEdbv4vbzAOBS/a30URwcu
	D61pr
X-Gm-Gg: ASbGncsS3XlPQKS8kRJjEvYBr9F7nHdae+zoLOrBXF1WXW+QlGr25B4AzLvd0wwyjxF
	od7tSoih68fi574/z0uQytYdAH2JdlIuJ/9H1i5tJdblxEEh/QPZNHUOB+BTnn6O6AIAVyZ7AKh
	K7NmLJbhR3ocig8dQKB/45ZlSygWPTrfWLXd08zkk8ctY1bTrFA2hYU9+Q1TkCKU/VyVRmG7Gs/
	2qbE6TEm2V58k7PfAUkKwcENXofaYHQRQZbdjp/im9bNjt8YsLDRcfMPJMUwqyY0RdYVasRMFi4
	zXiaj2I8esCKD+pJlhwk31gdFhloVzHDB0Og+RrM4h7Ut2sNWPH/1bcEg/0jyQDmqzvYNQGiKpF
	SlA==
X-Google-Smtp-Source: AGHT+IG1I4wXbndzOO2svvUjoO/b5iTEize8HjYtNFgDUXR08tLDK+qTi10v6jyEAqbWH86+wPS7Jw==
X-Received: by 2002:a05:6000:25c2:b0:3a4:edf6:566b with SMTP id ffacd0b85a97d-3a5586c3069mr3191218f8f.6.1749660463878;
        Wed, 11 Jun 2025 09:47:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a53244f0cbsm15688709f8f.81.2025.06.11.09.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:47:43 -0700 (PDT)
Date: Wed, 11 Jun 2025 19:47:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: clang-built-linux <llvm@lists.linux.dev>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org, Nathan Chancellor <nathan@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: selftests/filesystem: clang warning null passed to a callee that
 requires a non-null argument [-Wnonnull]
Message-ID: <aEmzK5B4pbF5MZ6Y@stanley.mountain>
References: <CA+G9fYt-CMBGCFxV5ziP98upkeK2LBxkZRo7-0XN1G+zLtWK4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYt-CMBGCFxV5ziP98upkeK2LBxkZRo7-0XN1G+zLtWK4A@mail.gmail.com>

This seems like a Clang bug, right?  The test for _Nullable is reversed
or something?

regards,
dan carpenter

On Thu, Jun 05, 2025 at 05:41:01PM +0530, Naresh Kamboju wrote:
> Regressions found on arm, arm64 and x86_64 building warnings with clang-20
> and clang-nightly started from Linux next-20250603
> 
> Regressions found on arm, arm64 and x86_64
>  - selftests/filesystem
> 
> Regression Analysis:
>  - New regression? Yes
>  - Reproducible? Yes
> 
> First seen on the next-20250603
> Good: next-20250530
> Bad:  next-20250603
> 
> Test regression: arm arm64 x86_64 clang warning null passed to a
> callee that requires a non-null argument [-Wnonnull]
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Build warnings
> make[4]: Entering directory '/builds/linux/tools/testing/selftests/filesystems'
>   CC       devpts_pts
>   CC       file_stressor
>   CC       anon_inode_test
> anon_inode_test.c:45:37: warning: null passed to a callee that
> requires a non-null argument [-Wnonnull]
>    45 |         ASSERT_LT(execveat(fd_context, "", NULL, NULL,
> AT_EMPTY_PATH), 0);
>       |                                            ^~~~
> 
> ## Source
> * Kernel version: 6.15.0-next-20250605
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git sha: a0bea9e39035edc56a994630e6048c8a191a99d8
> * Toolchain: Debian clang version 21.0.0
> (++20250529012636+c474f8f2404d-1~exp1~20250529132821.1479)
> 
> ## Build
> * Test log: https://qa-reports.linaro.org/api/testruns/28651387/log_file/
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2xzM4wMl8SvuLKE3mw3csiuv3Jz/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2xzM4wMl8SvuLKE3mw3csiuv3Jz/config
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

