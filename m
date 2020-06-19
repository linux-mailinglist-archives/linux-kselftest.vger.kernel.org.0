Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292262000E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 05:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbgFSDmE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jun 2020 23:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbgFSDmE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jun 2020 23:42:04 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1940AC0613EE
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jun 2020 20:42:04 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a127so3794150pfa.12
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jun 2020 20:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ylj+KbsOX76QNrUjj2VobkcpDWhDyawSP5wEBfqItRA=;
        b=Wos3wqRNr6giopwl7Ps797+D/UE+C34msegI+7bk+NOANm7xwlQgbmdMHILTzP/+Qh
         QxvdwZuO/nNW22FpNV799fSHpqJZvRbyVtXrOw+w56g23CVlW6VslBCgebkVcP9KQXX0
         i9JOA5DvM0E8m0JiwcLCXtTMI7/JNofOh+/rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ylj+KbsOX76QNrUjj2VobkcpDWhDyawSP5wEBfqItRA=;
        b=LUSHAJ1vSs3VqIiHhg2C0rfql0pRzd2gIIeaD6RgsvKSP7QHcXFXXGOkWBvOeOoJa2
         lS02m4En7rFNPfKWF4sLxkXWu68O74iOKO/zxNfmgzr/fyxckuroPuDScf/kYohoodAV
         k60EKxjsRShJpM5yjNSq76M1Va7O1TeBl0ZlEedmQBaalMFdCLRxyu2jUMW+zFf3uE7n
         AYU1zDO7p5vN0/6EmXqD18g56EgaWbZUpGUvlGKM0u6/liWkkwhRSYquYuRy6tw17e+7
         8Bn4UXvLGNOBdFUhPW6myTJ5xmEJwR8IEmgtGIIObVA1uT2D6Z6CzPr0Nk0zdqq+mmbf
         H1LQ==
X-Gm-Message-State: AOAM531/gaWY+MhY2aFhI53zkYQy3mdbsv6LEZX1+Td0cLmDcKYwwlhr
        YmmqVZn4jokaL5Q/SnzC/xFbAQ==
X-Google-Smtp-Source: ABdhPJzzGJYAhwVkP7J4IYD2kzImEk41O+zNGDOowEtJkbh+VyxQSFTwMHUCTD1U6pKjg40y7tCahA==
X-Received: by 2002:a62:be0b:: with SMTP id l11mr6651490pff.1.1592538123475;
        Thu, 18 Jun 2020 20:42:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j12sm4355572pfd.21.2020.06.18.20.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 20:42:02 -0700 (PDT)
Date:   Thu, 18 Jun 2020 20:42:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: common KUnit Kconfig and file naming (was: Re: [PATCH] lib:
 kunit_test_overflow: add KUnit test of check_*_overflow functions)
Message-ID: <202006182016.C93BC8AB@keescook>
References: <20200611215501.213058-1-vitor@massaru.org>
 <202006121403.CF8D57C@keescook>
 <CABVgOSnofuJQ_fiCL-8KdKezg3Hnqk3A+X509c4YP_toKeBVBg@mail.gmail.com>
 <202006141005.BA19A9D3@keescook>
 <CABVgOSkPYBL8Qy9Fsr0owNhh2=tXZmdwCsWhnq+PshJLr06YKA@mail.gmail.com>
 <alpine.LRH.2.21.2006160956170.16027@localhost>
 <CABVgOS=-AHNABkAVV7p=pq67hwoVcXXJSEPvxNbp90Eh_RaxBg@mail.gmail.com>
 <CAFd5g44kZe7h+qKHmx029Qj15FdqxsFRFD3TEx_iEhPEt0jJmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g44kZe7h+qKHmx029Qj15FdqxsFRFD3TEx_iEhPEt0jJmA@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 18, 2020 at 01:27:55PM -0700, Brendan Higgins wrote:
> I am cool with changing *-test.c to *-kunit.c. The *-test.c was a hold

I am fine with basically any decision as long as there's a single naming
convention, *except* for this part. Dashes in source files creates
confusion for module naming. Separators should be underscores. This is
a standing pet-peeve of mine, and while I certainly can't fix it
universally in the kernel, we can at least avoid creating an entire
subsystem that gets this wrong for all modules. :)

To illustrate:

$ modinfo dvb-bt8xx
filename: .../kernel/drivers/media/pci/bt8xx/dvb-bt8xx.ko
...
name:           dvb_bt8xx
                   ^         does not match the .ko file, nor source.

Primarily my issue is the disconnect between "dmesg" output and finding
the source. It's not like, a huge deal, but it bugs me. :) As in:

$ strings drivers/media/pci/bt8xx/dvb-bt8xx.o | grep 'Init Error'
4dvb_bt8xx: or51211: Init Error - Can't Reset DVR (%i)


All this said, if there really is some good reason to use dashes, I will
get over it. :P

(And now that I've had to say all this "out loud", I wonder if maybe I
could actually fix this all at the root cause: KBUILD_MOD_NAME... it is
sometimes used for identifiers, which is why it does the underscore
replacement... I wonder if it could be split into "name" and
"identifier"...)

-- 
Kees Cook
