Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B73917B09F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 22:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCEV1G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Mar 2020 16:27:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33899 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgCEV1G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Mar 2020 16:27:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id y21so8357pfp.1
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Mar 2020 13:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtiKzPpj8LFUymwSB7yTCNI/ZF3QVUV6m/8sRe74jM4=;
        b=oRBr4FLijrduwoNUKzThW1pzbMbuel52u18sGML2FWtMFIppQsC5WrydR18VOc2DVW
         hPGyQlUvw2GvTRfe2Zd5SmqiARI1lYo9r0C2mchmdOKvUC+IO9X2QES5eu7CcSRdnkhs
         XpSaKYEA4NgV/zoDKF0l6wUjuqj567yZbzxbidkawyB5EvM9/vjsriViU0aaz0xzbOv2
         TvyPuQsJEElz9CngC8iqddtlNanSmDUoNQC8TYVM0fodKKnirkZP3SlCxUS9XhR64ayR
         V+Q2T4DL5gx7NjaOTb0nqMm3a5XMg2TaF06BC+NLW9IPpcFXCCjN1selMaZgT5CLsBOM
         4UgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtiKzPpj8LFUymwSB7yTCNI/ZF3QVUV6m/8sRe74jM4=;
        b=FMZOD2wZaO3pOoH1DAsj8WHWuM4oj4tox0EGlSCdUlmVuhq7bPmGRmJ6wY38zPDdEg
         TJtcB5QinRmCPirq0qEl01uvdYHHwCMX+w6uspOVHik5xvKG4ETxvHZema1Dkw5cEXlI
         xFzKgzsb1JYFMiMDDbpMCh2Oms5b+g458Y+NuRu/tlhidtztAk/oPEOXC5AY9+ON4yMA
         Z+MykHKQjtoFLWkMadZk1kxjIgQpvUpD6GnBVeBOvCw7s3mB8lvkLidY/a7XAWmG/ZEQ
         ybzED/K2MvULqFsKMLOC/wV1kOE+vvrWywZBYFeR6NaADJ0l+3mM1DMLcSqYNw86FlfZ
         jI4A==
X-Gm-Message-State: ANhLgQ2kvtqNBybPAqSN31v3HzrD3hf8YsPmtNJa49h2rAOO3PPrf/hX
        OkZl59k9YuX9exQRHlBt0nZirwGu4MgdSXmq3nm2r3q01eo=
X-Google-Smtp-Source: ADFU+vv1ccqmownE6Ld6bBaNNfKO9+DSifBwb0CTWOQ7cMNitASw2cC+2IapEYQTfniJm4gw/d6RJSKIjoNXzef1WYI=
X-Received: by 2002:a63:6cc6:: with SMTP id h189mr102259pgc.201.1583443625213;
 Thu, 05 Mar 2020 13:27:05 -0800 (PST)
MIME-Version: 1.0
References: <20200305200409.239406-1-heidifahim@google.com> <20200305200409.239406-2-heidifahim@google.com>
In-Reply-To: <20200305200409.239406-2-heidifahim@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 5 Mar 2020 13:26:54 -0800
Message-ID: <CAFd5g46Ht=+ueEyMZPVfG6G-APSTf5j3ragRrxH6=HJFffmi9g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: Run all KUnit tests through allyesconfig
To:     Heidi Fahim <heidifahim@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 5, 2020 at 12:04 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> Implemented the functionality to run all KUnit tests through kunit_tool
> by specifying an --alltests flag, which builds UML with allyesconfig
> enabled, and consequently runs every KUnit test. A new function was
> added to kunit_kernel: make_allyesconfig.
> Firstly, if --alltests is specified, kunit.py triggers build_um_kernel
> which call make_allyesconfig. This function calls the make command,
> disables the broken configs that would otherwise prevent UML from
> building, then starts the kernel with all possible configurations
> enabled. All stdout and stderr is sent to test.log and read from there
> then fed through kunit_parser to parse the tests to the user. Also added
> a signal_handler in case kunit is interrupted while running.
> Tested: Run under different conditions such as testing with
> --raw_output, testing program interrupt then immediately running kunit
> again without --alltests and making sure to clean the console.
>
> Signed-off-by: Heidi Fahim <heidifahim@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
