Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBCC29570B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Oct 2020 06:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgJVEMG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 00:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgJVEMG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 00:12:06 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029A3C0613CE
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 21:12:05 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so157434pgb.10
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 21:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQhpluPH5qHzdGU1m9lM1IM2rcQRF5f75ETwpEdF6uY=;
        b=f1BMc+bjjOYUfqER0mjy5LXht/UnuAA1w76etaCKD1D1S+RlWaoTkCu5aSYgZ8DLYo
         AuJdWqOwD8FAkHM9/GP8kaHilwaBJNre5byK5Ftq0KWPKaHcoc9DtbI0RnCZK3uhjshA
         1L9jbshbzkiiiwSrkFt2biJbQmAISYfoBdfIKKB8BcSkgh2M9TbKhL1RyD92QoUyoUkG
         rghwJmNU10hNOL3xeMiPjxiu0tXWm/7G71T62hBLmNo2oGZMSci4Ul1/JAyfMn3xk9Ab
         abBamVgTUwSf3BiCtkOu/Rj9/+r74mVIp1OpPXaKkbTC9IeUGDSX1xYBnhoc0oQ7aGdH
         xsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQhpluPH5qHzdGU1m9lM1IM2rcQRF5f75ETwpEdF6uY=;
        b=H6UTamJyMFtv42Qj7cVmN6ilCQUOFbOVPtTl7zCsfw2chTreQCxwe8sK/PkXlBPmVf
         JN36gPvDDR8lPmvhaZIYJageAgHIGPaDRumWaXJmbt6++K5BDEYo+Ykj0XL8hq01bYTp
         DwhK2uWw7B/gjdwS+rQ36m5kDlFLSasVt62hZVqzxCeEKmO3vGGRmCU7DxeBRpF7ucYV
         f4wS4ixdxL8bDTE5WnLvEEDKJfaIgsubnjkDmoSvv2HVLkvzGdc11AbmR9XYbIvy/TyB
         CoJIUzSmVXtxXMxfHZBuzqPGc3Q8OUWafgQhR1b9MgS5EOfborxnP4uC1TvPgoyJAIR6
         fDig==
X-Gm-Message-State: AOAM530CrwO1auXJsfp2gwIVigZSJ3H8XeQrqtopMYHerfRfyWDJ6lhp
        3KIpt7du+R2+bk3uCdiUM/OODgLlxWoXRhRsGQ3dlA==
X-Google-Smtp-Source: ABdhPJzSJ6KtTk5GozpZmod5MQ1LR1Oaxxto6Ruzf4ywJ3/iOB2Prv8JciiCvZBnC2k6EbbYjgoxBopq2v9dgFX6ACk=
X-Received: by 2002:a63:1e5e:: with SMTP id p30mr701573pgm.159.1603339925261;
 Wed, 21 Oct 2020 21:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201022030455.1871987-1-davidgow@google.com>
In-Reply-To: <20201022030455.1871987-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 21 Oct 2020 21:11:54 -0700
Message-ID: <CAFd5g46D69b1GgGhL4jvCLUCDG3NDja2ZDXYxx2a1Rv=DQtEmA@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix kunit.py --raw_output option
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 21, 2020 at 8:05 PM David Gow <davidgow@google.com> wrote:
>
> Due to the raw_output() function on kunit_parser.py actually being a
> generator, it only runs if something reads the lines it returns. Since
> we no-longer do that (parsing doesn't actually happen if raw_output is
> enabled), it was not printing anything.
>
> Fixes:  45ba7a893ad89114e773b3dc32f6431354c465d6 ("kunit: kunit_tool: Separate out config/build/exec/parse")
> Signed-off-by: David Gow <davidgow@google.com>

Thanks for fixing this!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
