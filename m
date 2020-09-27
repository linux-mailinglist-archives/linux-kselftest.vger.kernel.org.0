Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD081279D94
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Sep 2020 04:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgI0Csw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Sep 2020 22:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgI0Csw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Sep 2020 22:48:52 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D29C0613CE;
        Sat, 26 Sep 2020 19:48:52 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d9so6392032pfd.3;
        Sat, 26 Sep 2020 19:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6HrXb1MRMvuJZH4Tlpi5gzDu5KYeDDOzm0HgEkkBYnc=;
        b=P8p38Uh0M80AclAJil+aZs0bsoQUwKBs/CvXvg57k+SD1vZ64Mau3AmLwV96njcKBk
         aOLWH6njnMM1LPcjD1IAcgnmW4LkuGuiGTDlpbIW4ovlFYJZPBoY/rj5KQeWYi93W4cG
         7qUryz98BvNsh809BUO6WiAHzt5AhIin5p3H1hgYA8AWBNMTwt2S3teC+EOJ6r/4UVyK
         gUNgl4VK6wmG+1wRAzsG7piJXq0WwZ5tp35NcaE//lazeITOQu7XkV/rrERyVOZu5Pan
         gB8YFbyf0pVitwKNOBlm+9XTmSqholVHsJWIajan42vBlTccAn35C6WTck0zXriEg424
         oQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6HrXb1MRMvuJZH4Tlpi5gzDu5KYeDDOzm0HgEkkBYnc=;
        b=rVgqGvkfmIMwr9X3MQ8NzAY5hwZ2gJYoZCxLpWWOSMXh10/YTx2Mw0jJHn0+tPi+Tb
         o77PXJUFg8Rqol9VrqrrbfaOEWwnrevYXzPp/gWxVMKivfbXcW5Dnnu52drw/4rxoyh3
         e78jGpN1+kmUmaPtbCWPP2HqUSd5bv/l5rnXIhecl0YVOFO6XP69f107kJqe1L4wSedh
         bNASRfNSiyZX39lAsA2HRi8eMoIIu47s8XJGxk8IWerNx7HX51FyYAjDb0qjJZ7iRr95
         l7kq6fzgbqirepRMZEwvOhiTwfsQw5wbXAwO8LT4KxvYMpkZzchIiwPo+IMVavbxw0sv
         OqMQ==
X-Gm-Message-State: AOAM532Smti1LthEhaXIWD8CVb+WskslV90HfGVfBTnFDts1XH550DvP
        KJLcP9qtdkRdrGdsv8nYTDY=
X-Google-Smtp-Source: ABdhPJw3GNw6X+0Py5NQJgfZnzf3OC+XoXwuyLrsfv8EKJ0VsHvNRwlgyGJHk6V0d23sfuUmvlRiPg==
X-Received: by 2002:a62:fb1a:0:b029:142:2501:39f9 with SMTP id x26-20020a62fb1a0000b0290142250139f9mr4801639pfm.72.1601174932142;
        Sat, 26 Sep 2020 19:48:52 -0700 (PDT)
Received: from dhcp-12-153.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b15sm6682050pft.84.2020.09.26.19.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 19:48:51 -0700 (PDT)
Date:   Sun, 27 Sep 2020 10:48:40 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Tim.Bird@sony.com, lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Justin Cook <justin.cook@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/run_kselftest.sh: Make each test
 individually selectable
Message-ID: <20200927024840.GD2531@dhcp-12-153.nay.redhat.com>
References: <20200925234527.1885234-1-keescook@chromium.org>
 <20200925234527.1885234-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925234527.1885234-3-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 25, 2020 at 04:45:27PM -0700, Kees Cook wrote:
> Currently with run_kselftest.sh there is no way to choose which test
> we could run. All the tests listed in kselftest-list.txt are all run
> every time. This patch enhanced the run_kselftest.sh to make the test
> collections (or tests) individually selectable. e.g.:
> 
> $ ./run_kselftest.sh -c seccomp -t timers:posix_timers -t timers:nanosleep
> 
> Additionally adds a way to list all known tests with "-l", usage
> with "-h", and perform a dry run without running tests with "-n".

This is better than my previous patch and we can modify run_kselftest.sh
easily. The Documentation/dev-tools/kselftest.rst should also be update.

Thanks
Hangbin
