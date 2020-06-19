Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6BB201AED
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 21:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgFSTLT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 15:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgFSTLS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 15:11:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9D3C06174E
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 12:11:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id j4so4284337plk.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 12:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VScT64RtDzbmtFTIPPkA4G9jZecLisLc5YoK422OgPY=;
        b=Q7SusNor1JfS/KxsOYlgqfU+dHe6cO5vzSZYYuf4g9fxPcu7RJC+J6bbzyZEKjfvoh
         HgqGPKMMErEwR99taI9kg5v+zpP88fIYK8c8XyHCjBPOTgV1GGs1NRKusApUtSenOltS
         8Q9aS8qZr4oVmmRHMB/fNc6dHY5KYijpLqjDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VScT64RtDzbmtFTIPPkA4G9jZecLisLc5YoK422OgPY=;
        b=Ko/+Q9oboqPWUwXlDcdG4pI/5gTZt3vYkgrKpHX2mecbOUv2GrxRMergY/hnNq8Na0
         zpK29FcwLKuVKOy5OQj42x5URRky6YH7v55MDoDqbCGHd64+rRaQWl38rm4wTwt9JY//
         r7PP9CfUmoIIyBT5CDcwEWM84xYF35+LyDmlhYaqTU6SKlilAd4jLZlVKodKI7diHKGL
         jn7Yk3qPZzTE9dhqkHnMjTiJpQOqb/IF0LtkQknyA/2STz3uwC2Ws8YnBQRdFB1rZ7TG
         xPqEtWATTLRY5S8pGvMkRhTt5wcjuHhZkgDo9T4HBGQLCkgt7m9gkPghUkYvzUc2b1Vt
         AxuQ==
X-Gm-Message-State: AOAM530egETqEdA99s53PyFY0n3km8ViPQoafxas1HMdAlom4QkoRpMP
        COz5AikelFqV6VdtOkLrHHwZtw==
X-Google-Smtp-Source: ABdhPJx6PQHraOqgQ+KQVtVVOrs8OFQ3RHzYra6b4IA1L3O9ughAGqU2dHrt1zJCUXnaZwQrOdPRyQ==
X-Received: by 2002:a17:90a:6808:: with SMTP id p8mr4378913pjj.81.1592593877289;
        Fri, 19 Jun 2020 12:11:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v66sm6696796pfb.63.2020.06.19.12.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 12:11:16 -0700 (PDT)
Date:   Fri, 19 Jun 2020 12:11:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
Message-ID: <202006191208.BF995C82F5@keescook>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook>
 <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <7161fadb-45ba-c4c0-8bbb-cb47d2dd0265@redhat.com>
 <CY4PR13MB11755F5A6879CA3FFD005426FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CAFd5g454n4ZPgCdWaAxezFueG47TztqBx4L7x4oYwgPAR3BZNA@mail.gmail.com>
 <202006161653.15C278A5@keescook>
 <398200b2-f8bc-894d-6d6f-366ff98a490e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398200b2-f8bc-894d-6d6f-366ff98a490e@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 19, 2020 at 01:47:29PM -0500, Frank Rowand wrote:
> On 2020-06-16 18:58, Kees Cook wrote:
> > I proposed fixing that recently[1]. seccomp uses XFAIL for "I have
> > detected you lack the config to test this, so I can't say it's working
> > or not, because it only looks like a failure without the config."
> 
> Based on that description, the case sounds like it should be a skip.

hrm hrm. Yeah. Thinking more about this, I agree. I think it came about
this way because the kselftest_harness.h API (not TAP output) is different from the
kselftest.h API (TAP output), and so the tests were written with what
was available in kselftest_harness.h which has no "SKIP" idea.

The series linked was mostly built to bring kselftest_harness.h into the
TAP output universe, so the XFAIL -> SKIP mapping needs to be included
as well.

> Or if the entire test depends on the missing config then Bail out might
> be appropriate.
> 
> > [1] https://lore.kernel.org/lkml/20200611224028.3275174-7-keescook@chromium.org/

I will rework this series.

-- 
Kees Cook
