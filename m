Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44620297854
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 22:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756248AbgJWUkB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Oct 2020 16:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756247AbgJWUkB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Oct 2020 16:40:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34466C0613CE
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Oct 2020 13:40:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f19so2325326pfj.11
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Oct 2020 13:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0OMEC4oyzo/0r4GlCsMtRRADIfS+cnnJZeKT3qLLCs=;
        b=aYqfSroNecRtzOX7VAwgpoKg9njgF9SvPa92jBMsLRe3+iiLksaF/VSbdWHdctLPs7
         lt0RmW02+CReRujEoEoyZNPTsUynApBYTRDKgT98cm/tsZuC2X66lBPuPVfrcl0N2PxG
         QdbzTSe91BpgncDvcM5typDKyUtzwndPRF/R8YG/RnSOxvpljXTvINFD7WZtNUjhwl92
         qo+S6BAmHuJxOuAzMSvmYTQNyfcujkL9i/qzFApep4AsXpB5eBbe5NWcoHApKUDPielr
         fq3GJsvtMd+rJoemWWoPgsU8ic6KHFfim+L3lqHwD9BldESvDW0xNLYSLifISySeXJTL
         l4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0OMEC4oyzo/0r4GlCsMtRRADIfS+cnnJZeKT3qLLCs=;
        b=EhXIl2qVq92FVL4ImjqBK9DDpJbnkKcQfXc7xOgyaIDEl/kUZrMkVlKc3XObnMOJ0q
         3iF2AdmB91UTf6u09lMkVYbE2zhWmjTKSOWwzfR9AROyVBbIkMaOcC4Lc957RBOCGH4v
         Jiv3xcBOM5PG2iD9W44+/csTC8u18/I7Co7PVtsaLBpf0YoVDwP9VHXVFyWA2jh5voIx
         LP/wx/KDrfcypXNfQWWZyIpsKPzYJD3COhtrO3gGVf90dtM23Ho/0fpQyhx4CFqnIHyz
         xLGpWN20V2IMOCS01mVOvibwuizQOYRnO0pRTaMUale2xsMntEJ+V66X15409UZP8NlT
         1JVg==
X-Gm-Message-State: AOAM531vYqpOfiDTVtkqm9OZTTYJtEZgy1CHLtDBQYy/qTTb/+pdURZp
        22ywrPLm0yd70QmFxfbp+YuKP3gUVLrkpNpBUppnXpTmj4iCgg==
X-Google-Smtp-Source: ABdhPJzau0oYTPfXZnK6vCso7RgAqFmroynNSeYdhLO/MrEx2wYVXy3CCV74fx3Euq7/ifeQ1TkC8dOuGMK7lWtGlqQ=
X-Received: by 2002:a62:d44d:0:b029:152:ebc:77f8 with SMTP id
 u13-20020a62d44d0000b02901520ebc77f8mr931500pfl.14.1603485600562; Fri, 23 Oct
 2020 13:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201015152348.65147-1-andriy.shevchenko@linux.intel.com> <20201015152348.65147-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201015152348.65147-2-andriy.shevchenko@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 23 Oct 2020 13:39:49 -0700
Message-ID: <CAFd5g4765bmZ1rKW2DeWwSAM6VQgknv0tsye5NwTPbyFhke57g@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] kunit: Do not pollute source directory with
 generated files (test.log)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 15, 2020 at 8:23 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When --build_dir is provided use it and do not pollute source directory
> which even can be mounted over network or read-only.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
