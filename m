Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A6143FEC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 16:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhJ2O6f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhJ2O6e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 10:58:34 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1155FC061766
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 07:56:06 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id a26so9437276pfr.11
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FjCjcYP+D3o8tv9NFpZxsW155sRvSDfbhIEl3Au16T8=;
        b=fbhsEQHwwevdlsxfPYH0ZOMBGl0MBuTNZ7ZM/mtkL50sTixcSo0LP59DlAS7YgLIeH
         bd5ffqgdd4NPwRRMPVUM41XFNfQEF4lyvY2qy9/Lhh5gdHAF/RlD3+DNaQeeAL7ckacF
         uLBqY/pAqpEJF8p+CdGM/OdDjeEMUXe4vrNhRHmNXMw+kQ6GHr1j51B22WZ2cII8JYkY
         Wtjvk1Ld27LsAm+eskBlsB4uzBEErJsNMfmyQH+nt1IU1CbDeSirNMVr0dGUw9inhgps
         WU7jJ+CB46GNSD+JDiuUTGANWIGnAeQbKrRIJiJ1ISf8+QJDe1v34NYWmrK1yf14lhQk
         8hSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FjCjcYP+D3o8tv9NFpZxsW155sRvSDfbhIEl3Au16T8=;
        b=3x0sUO0YlUG7e/ENhR272/F6EyBDjAFVUtvtYJ9JC25yYtPk7+7rVZt/jaKAysCIcU
         d85mWEN0JOKTt0CPtfESV6C4RuFr/6Ew5g1o4StT/Wb5N9Hd68lfPNMxRaZo3mT+3NOr
         vCc4oSU0/EypMwFVosRtvLgEnopAdgJ/DlIbDQHWNHi3gbSJx8o+HWWkxFYvHUHolEpo
         xLLjRWb/5v/BQ1aa8L9ub7jV9VNbW4Znpx9AD1eUB2ewYffsxJAp6HcdeFdGh7EASQKX
         lFp4uGkY80s74X1zun/z9ku1+y5eRdEhwNk+JO/HmmRfzJX3jS/3g0/2GpIjX93N2Hsp
         Eh7w==
X-Gm-Message-State: AOAM532DUtNXnDPsLc+o8E5/ugTEc4eRHOwSx3Mvqd0aXvG2CtBpk80M
        EelkiNTO6PT6QW/itmaFgVbREg==
X-Google-Smtp-Source: ABdhPJw1r41vo9z6GWts/4z+DJNa7FX6eXkNXDzDgmec/E95Um8w49RuJ9Bh5EuGaGZRKpqNN8QPog==
X-Received: by 2002:a63:9dc5:: with SMTP id i188mr8471251pgd.143.1635519365363;
        Fri, 29 Oct 2021 07:56:05 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f8sm6253333pjq.29.2021.10.29.07.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 07:56:04 -0700 (PDT)
Date:   Fri, 29 Oct 2021 14:56:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>, jarkko@kernel.org,
        linux-sgx@vger.kernel.org, shuah@kernel.org,
        dave.hansen@linux.intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 01/15] selftests/x86/sgx: Fix a benign linker warning
Message-ID: <YXwLgAdOA1jlsSiq@google.com>
References: <cover.1635447301.git.reinette.chatre@intel.com>
 <545aac243037bf5c2640929c4d8ff5c1edfe3ef8.1635447301.git.reinette.chatre@intel.com>
 <d382d0b0-15fb-5e96-accd-c3b59be72dd3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d382d0b0-15fb-5e96-accd-c3b59be72dd3@intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 28, 2021, Dave Hansen wrote:
> On 10/28/21 1:37 PM, Reinette Chatre wrote:
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> > 
> > Pass a build id of "none" to the linker to suppress a warning about the
> > build id being ignored:
> > 
> >   /usr/bin/ld: warning: .note.gnu.build-id section discarded, --build-id
> >   ignored.
> 
> Do we have a good grasp on why this is producing a warning in the first
> place?  This seems like something that could get merged quickly with one
> more sentence in the changelog.

The SGX selftests use a custom linker script, tools/testing/selftests/sgx/test_encl.lds,
to configure the resulting enclave binary so that it's loadable as an enclave
more or less as-is.  One of the things the script does is drop sections the
selftests doesn't want, .note* sections being in that category.  I don't recall
exactly why the script drops sections; I assume it's to simply the loading process.
Anyways, .note.gnu.build-id is collateral damage and the linker complains.
