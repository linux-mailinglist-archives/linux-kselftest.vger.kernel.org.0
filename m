Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0E12953E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 23:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505587AbgJUVM1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Oct 2020 17:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505356AbgJUVM1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Oct 2020 17:12:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAACC0613CF
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 14:12:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b19so1886496pld.0
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 14:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OCU6tWIdopaiVv+58WWDommA6fymksvXM1Yi91pMvd4=;
        b=KMdjtGlHNR2a7z7DBuzUrrpqyNnWfv/OEsmeDLlwn+7pzE+rymVcwPM+k/TwonlLha
         js6srf9Ss9b+kDHCUWBOLnEWDWIwpVmoBpnTvFAWFGuvcoFMx0iCmoYytHb3zDufSmrR
         keqggjQIJzKflNiV0TaUJ6k8qzFC3e4BXC2RfDC/hKZB/r9w3h9OYuipkWkHlwkE65nN
         1Xfy6iH3GzDfjplGS4M1qcsh8n7dmPzS1YWKTsmCmpgZL8W4E2osUpQSI9biZHKv8QHa
         rCnjtnSW0ELtdukpDZRDtuW0kc1e5ZSi61i4v6GWDpZGsFCkfxqGFoMjbR25nXhTWE5q
         98LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OCU6tWIdopaiVv+58WWDommA6fymksvXM1Yi91pMvd4=;
        b=KYcOKeXxJuZkFoqxbrikLcURFU/eMJdstKX+gJsEpfu5zB/7DG+2ks5MFz2vT9kigi
         rCoUhaYcRFMZbTV3E/9SPdtMD55i8K67S7nk6LhcJwv90QUMrLRP+zOfKggAM81rDFJh
         KN77VXZlbFW/QfEzMhq6ngssF2xOWsdDV9edUjcZzb+wiiEWFx8fjA4hZJWIbow/J3yO
         VvXYifncdMQhvUYBAZ1hVgclIYDYIp/AooyEm+7wIDqB0Dycf57HlDs5d5L8fAzIN7+B
         q6/mBnHg2Ut5ELk16oPJZejkqdLIaNY+HHqdADlvJyicpQIwr1fg8ksFJ/qgvi2DkrPV
         PfNw==
X-Gm-Message-State: AOAM533gTVTQMYGAZSC9hm06oFl0TvQNOOy57vgwUMOSNYQOt204CG2O
        UENLh7ELPLqDhHGI7EoBUmowIhUHW0K+jRXJsbLg0Q==
X-Google-Smtp-Source: ABdhPJxr5dOe0lFEswg9i4kcGmddMd7ptohz6vXxVGc5KE6gmcsXkRzZ90TFtTcjP59cf+I4hsAgsT+HlQMx9cd6xBY=
X-Received: by 2002:a17:90a:3e4e:: with SMTP id t14mr5069350pjm.217.1603314745961;
 Wed, 21 Oct 2020 14:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603282193.git.mchehab+huawei@kernel.org> <1c36d295423c5c20c21a7edede0eb29e338dd62a.1603282193.git.mchehab+huawei@kernel.org>
In-Reply-To: <1c36d295423c5c20c21a7edede0eb29e338dd62a.1603282193.git.mchehab+huawei@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 21 Oct 2020 14:12:14 -0700
Message-ID: <CAFd5g47ZbyiXLMNJ6-BZH1rVpsjK4WSuUph4wS=W=3dVoLeSFQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] kunit: test: fix remaining kernel-doc warnings
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 21, 2020 at 5:17 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> test.h still produce three warnings:
>
>         include/kunit/test.h:282: warning: Function parameter or member '__suites' not described in 'kunit_test_suites_for_module'
>         include/kunit/test.h:282: warning: Excess function parameter 'suites_list' description in 'kunit_test_suites_for_module'
>         include/kunit/test.h:314: warning: Excess function parameter 'suites' description in 'kunit_test_suites'
>
> They're all due to errors at kernel-doc markups. Update them.
>
> It should be noticed that this patch moved a kernel-doc
> markup that were located at the wrong place, and using a wrong
> name. Kernel-doc only supports kaving the markup just before the
> function/macro declaration. Placing it elsewhere will make it do
> wrong assumptions.
>
> Fixes: aac35468ca20 ("kunit: test: create a single centralized executor for all tests")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
