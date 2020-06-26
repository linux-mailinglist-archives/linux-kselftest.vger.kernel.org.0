Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD47420BB94
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jun 2020 23:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgFZVaD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jun 2020 17:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgFZVaC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jun 2020 17:30:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C00C03E97A
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:30:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a127so5144938pfa.12
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+IN/dHrnSFJwCdsiVxf8dhkTYXziQPztMYyCGVl57TM=;
        b=Pqzaouq9BT4GE0gjlmD3L3Uoidh8l7ZS7+O86mF+FHQf7Fm27moUcW7Dod9X/TdcKT
         rT06Kwg1pQmk8zhRtK/5z5iRSdXzqfIs2K0BC0hqy21Vim6PSB7gW7XyFtjDu4LOB/bD
         RU8AX5Ebj622H1q2YqlUvFkcglwp2WcEqUoD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+IN/dHrnSFJwCdsiVxf8dhkTYXziQPztMYyCGVl57TM=;
        b=kAAeuaq/FHpnPYuZ4cV/pMIg4WSh8dGE1DPlgEcFdtzg+f+iiSGyXt1oJmFc031zBK
         vm3ZVfz5im6+yRciSIMhw8O4LfVAxSRsweBUyimTgqtSN2IYxTE7dwHntPrmUF7elmzA
         FSp34EZcLPnTyuSxFsF9+ISP8oAjynj0bGIGLzRFQugHQAE4JQl5OLv/dOwvUdOgzJJd
         WIcdXOyWevPM1MUkarr+EFUa7VmfZwR7ptJgCUqOPUgizSsg+ggGvvKLK+kh4S6uEsmf
         XoE0zqSpYDYKQHdNmpjPeXXu6y4PyjRxMpdGZrl9Sy6TjGgPWBe2zZnJ29jqD34ZofDk
         NtCw==
X-Gm-Message-State: AOAM533l+rnjxQm7GPHZ8j6CPantvYo6uT7NaWF83vU62fjaHs9ptUo4
        vY0xFeRWqWjI9cWTHeWot6SWVA==
X-Google-Smtp-Source: ABdhPJwffNZVFojpM9ARq7D+MFPkJd4phuspFIs1JaOLslJ57S8CfThHPaQNj4fP51cEdSRPJwcAjQ==
X-Received: by 2002:a62:8811:: with SMTP id l17mr4509571pfd.72.1593207002451;
        Fri, 26 Jun 2020 14:30:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a7sm12857762pjd.2.2020.06.26.14.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:30:01 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:30:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, skhan@linuxfoundation.org, alan.maguire@oracle.com,
        yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org,
        rppt@linux.ibm.com, frowand.list@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        chris@zankel.net, jcmvbkbc@gmail.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v5 06/12] arch: xtensa: add linker section for KUnit test
 suites
Message-ID: <202006261429.5F1A1F72BB@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-7-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-7-brendanhiggins@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 26, 2020 at 02:09:11PM -0700, Brendan Higgins wrote:
> Add a linker section to xtensa where KUnit can put references to its
> test suites. This patch is an early step in transitioning to dispatching
> all KUnit tests from a centralized executor rather than having each as
> its own separate late_initcall.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  arch/xtensa/kernel/vmlinux.lds.S | 4 ++++

If you ever find yourself modifying multiple arch linker scripts for a
series, something has gone wrong. ;)

-- 
Kees Cook
