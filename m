Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1373B1C84
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 16:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFWOcq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 10:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhFWOcp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 10:32:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13CBC06175F
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 07:30:27 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g21so747103pfc.11
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 07:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WKMVzZz8u7uLBmWomdYlr+oMy96WS6tUJGPPtCZ0D60=;
        b=eYVZTdGsyVwQA4kGhfrZ47tU/XyD6Gdfb5Rx3FV6lq4wWZL1YRspeUnNTaN16uOM/5
         PiZwMKxRT8JUaXAUA/B6aFfoWoCGBSxCgq9OBk8jcWvqbh7VlX3w1dMY1/ykca4/GhDN
         OY8g353DIBKO8cvg/x7Zg5+Dnx1v8r30cn340=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WKMVzZz8u7uLBmWomdYlr+oMy96WS6tUJGPPtCZ0D60=;
        b=nfQXl720CJlVOyeGKKUGmuK1yaCgBQqsIOhtsLo1GZzxIxxDSdTVuEDpWUhJScDj1N
         wdEFxgyR1nXUjXgJECLjW9HX5ruwnehyJC+GR5MLWI3Ie2lFLk7F+mk96wbhrS05OG8F
         MX8R/zF3SB5C9pxhjmcCYeci+5fW9SVH3i3Mc59wlr+d0EmU+qS14vVLIGKYxKOPEpy1
         eUF7I357gRNbzfeynTF4lvEbqdSL7YZN4oBv3r7uCrrNWATEeUF0ju23YYwADQEQFKDF
         M0gjPyG8bO9aexTDSFUYV+LI9Z42cfe10lSoMgwjlDfSYdJOevwIFnzay7ae6f7qYWNM
         z2wQ==
X-Gm-Message-State: AOAM531Qg+UwZXgxCsVdR2Brf31RdsQf/7RSb0EkXoOHFSFOKN6eE0bK
        eraXwZm6cRW5XZgz5ucoLvFj0g==
X-Google-Smtp-Source: ABdhPJzBNh/oD3wHuk2SjWKRS7Sjx1wJamx3k/4NZa6pNlIIEJ2pDtPK2Km1/JZKZW6Ey9ydWdubmQ==
X-Received: by 2002:a63:8241:: with SMTP id w62mr4176796pgd.343.1624458627555;
        Wed, 23 Jun 2021 07:30:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q4sm158954pgg.0.2021.06.23.07.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 07:30:27 -0700 (PDT)
Date:   Wed, 23 Jun 2021 07:30:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Shuah Khan <shuah@kernel.org>, stable@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [selftests/lkdtm]  84d8cf25b0:
 kernel_BUG_at_drivers/misc/lkdtm/bugs.c
Message-ID: <202106230728.4844CE5@keescook>
References: <20210619025834.2505201-1-keescook@chromium.org>
 <20210623143549.GA25993@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623143549.GA25993@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 23, 2021 at 10:35:50PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 84d8cf25b0f80da0ac229214864654a7662ec7e4 ("[PATCH v2] selftests/lkdtm: Use /bin/sh not $SHELL")
> url: https://github.com/0day-ci/linux/commits/Kees-Cook/selftests-lkdtm-Use-bin-sh-not-SHELL/20210619-105959
> base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
> 
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-f8879e85-1_20210618
> with following parameters:
> 
> 	group: lkdtm
> 	ucode: 0xe2

Heh. Yes, this is working as intended. :) Most of the lkdtm tests will
trigger Oopses, and this is by design: it is checking that the kernel
catches bad conditions and freaks out appropriately.

-Kees

-- 
Kees Cook
