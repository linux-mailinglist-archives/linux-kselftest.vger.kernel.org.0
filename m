Return-Path: <linux-kselftest+bounces-6855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F07C891467
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 08:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5171C22F62
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 07:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2108C405C6;
	Fri, 29 Mar 2024 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7yiiUGi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5E73C6BA;
	Fri, 29 Mar 2024 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697776; cv=none; b=VZ96QsUMsAzDt9e9IsVlUNj+k9lRAsZiWNeO9mmBllHLAYeAcrvQq56eJloJZrSEelXsFZklMX4jVGmOmYylHiOR0uh0+qCII0+Pkiyx+xyq+W33fOCDlePQKRe+9wcfhX8Bci0WZ3mC3um8RH4yneQRfz6/C401LVHNUWulLtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697776; c=relaxed/simple;
	bh=o0M0IyJcUookuFin+xzyNuPuMIMMXKwrYyJEBdm6SJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFMEzbQzTZZymUi2Kzw1It4lBCGrpoQQn1738oYlziyas8I5tibQeBPG27o33C/XXN7cbx9X3JI2tZ3z+O1ZL0bBgnI01LpQtClAosI/AvM+nS/CobH1WR0U4cZmfnq3tm0F+t2VVWqGEjzecNEbyn4lX/wKQ1QymaSUJ0agBOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7yiiUGi; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a44ad785a44so197581666b.3;
        Fri, 29 Mar 2024 00:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711697773; x=1712302573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02I2vw7o3fgaPYQWfuiF5lp5H//jn5NlPZdLwJYApkY=;
        b=e7yiiUGi8fNB7VES8CzjifBgq1WubODph8HpFMbzWe6Bb0iEXl1V+G48Q+kC0LGwAU
         5TkqcJdt8S5Xs6ARdXOiF9qj2ydHJx8ZXWnZ9jPqEeMMUqBBN0+F4s8lcS9OtTvq/ruh
         5sbv76LoqzCxgVP9oV1R8czGLhAnGEmTyZavJrpNVT3mghQu0VDqxcU2XiZ9EepCikHO
         4vzGwuf1s8ubKFumqlJ2fS3LF2cl9SrIKeXeKNNE8b01XLG6SbuP/y1j59EXiPFDBQsI
         OcgxxvOFXNMDMdWAUpyktvAxVCLylzyxV1G0R0rG8FWXGgcThc4tPOX2WuxIf0x0x6cr
         tR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711697773; x=1712302573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02I2vw7o3fgaPYQWfuiF5lp5H//jn5NlPZdLwJYApkY=;
        b=k2Ax1m18yJLjiFNsrz750BQ8H1JxN2gx/tu0/fGYUxZ3vhU1ImcU7r9AcPaKRbRbgs
         aAJKsqPTTd0kCWovBS0zALMswxUGvEQvobzD8O+DOeTvOnPzibd12dRJn8/CwEr5jW5f
         eyh4tp/8r/hKlrZL/KTiniUQPhc+5abFAlzFJWNhnRrdf77sQ6MHyByr55MJY6HpEX+N
         2nJVXIhhn/D4xRNAx50Oc9xtOYtnp4TRsuv3V/uwc6+hSDr6K7Y2290dcK5DaipDhF1P
         XOqdnHP0CjVXApuAS2pH7PAzBcEk2aSe7LcczkG0oY9VD8hstMJEHEnMRs01CsJCuDsV
         BQ+g==
X-Forwarded-Encrypted: i=1; AJvYcCWTWzfjZSbxcDFYzH7V8VaO4fVsooRC0Oe2q9SpOlsR6R29RoyUEFxbabaDFaxRzXidKRBOa2U70mKGqkNQibZpMUO7ZJsuBKCwKfML5w2xe3IGMZwna6OSTYSybSPWedQGvrHM2TdJxwlG/foL
X-Gm-Message-State: AOJu0Yw6Ynap/ENj+X+PSHAkdpkjaRUzkro31uGYRmcF4/I73RfCwvQF
	c3Y/QDZ+81p3msifFMYAM332AU2x3atIcK2eHnPodEMpzfXm8oSzWzGPJz3d+Ic=
X-Google-Smtp-Source: AGHT+IHXLBlv/nEicaqmAk+ih73rZR/7gfPb4gK99oBc5EpKbjwFNQ5lncW1Jkn34lUCoEQx7EZrHw==
X-Received: by 2002:a17:906:3554:b0:a4e:1d55:c21 with SMTP id s20-20020a170906355400b00a4e1d550c21mr896950eja.67.1711697772462;
        Fri, 29 Mar 2024 00:36:12 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090660c400b00a457a55b814sm1629825ejk.73.2024.03.29.00.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:36:11 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 29 Mar 2024 08:36:09 +0100
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
Message-ID: <ZgZvaUbZIr0qpxK5@gmail.com>
References: <20240327111720.3509180-1-usama.anjum@collabora.com>
 <1d6418a3-67eb-4a39-891a-7d653a26f1fc@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d6418a3-67eb-4a39-891a-7d653a26f1fc@linuxfoundation.org>


* Shuah Khan <skhan@linuxfoundation.org> wrote:

> On 3/27/24 05:17, Muhammad Usama Anjum wrote:
> > Skip instead of failing when prerequisite conditions aren't fulfilled,
> > such as invalid xstate values etc. This patch would make the tests show
> > as skip when run by:
> >    make -C tools/testing/selftests/ TARGETS=x86 run_tests
> > 
> >    ...
> >    # timeout set to 45
> >    # selftests: x86: amx_64
> >    # # xstate cpuid: invalid tile data size/offset: 0/0
> >    ok 42 selftests: x86: amx_64 # SKIP
> >    # timeout set to 45
> >    # selftests: x86: lam_64
> >    # # Unsupported LAM feature!
> >    ok 43 selftests: x86: lam_64 # SKIP
> >    ...
> > 
> > In amx test, Move away from check_cpuid_xsave() and start using
> > arch_prctl() to find out if amx support is present or not. In the
> > kernels where amx isn't present, arch_prctl returns -EINVAL. Hence it is
> > backward compatible.
> > 
> > Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > ---
> > Changes since v2:
> > - Update the changelog
> > 
> 
> Thank you - applied to linux-kselftest next for 6.10-rc1

Please don't, I've applied the patch to tip:x86/cpu with a tidied up 
changelog.

Thanks,

	Ingo

