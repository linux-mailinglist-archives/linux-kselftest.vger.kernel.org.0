Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6522A1FC293
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jun 2020 02:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFQAGS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 20:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgFQAGS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 20:06:18 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13DEC06174E
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 17:06:17 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so367644pgk.4
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 17:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Inq0XQBIIBcPId4GeWe0hYOyBL6Kjr/fvT2V/zfqIFA=;
        b=NeOqkMoMzW+2UZHeiolI5YSbLKcTlTajnnATvK/mt1IPGh49KdGqILpQCc5xPgP/p2
         EPh2qLnoiPVCh17XGrXf4JEeW+ymWMpqrqjs0yvbHGbputGaUgV4JRKcQaAL4ywDsCcp
         BhF+p1LRINYtDID1h8WMghoMsMDGAz52oM+WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Inq0XQBIIBcPId4GeWe0hYOyBL6Kjr/fvT2V/zfqIFA=;
        b=phcexdHOYiBQxaanA9pZTc3P6FLuqpAF8M/8uUspcNMnER5Sjt4mcMmWUbffmuNujU
         sdU7wRd3a9de8+U5x7s8za5BcTyiqnSPxbXa5MgtRGO/LGFqNb8gbV5JkJ9T0rJiN34x
         qdQyQszDiWqwPMjz/gWeddurGxKCpg7Sef6EaT7R4/XJGE80Rz73HPMCEen7Y/jb7ED1
         qxnyDbCR9bEz7tLOEwU+QPGwTjO6Vgv2H7mf5yTCDr4fo5hXlt1+BaBAMV+6C/SYBkT2
         LZIgE7qmZ3Pd4ZtAVlVfD/sliug2+fRAlX2GR0mMWoNYVyH2KyYVpP6Mf04hecu+xDos
         seiA==
X-Gm-Message-State: AOAM5301aLh5l9ASZ7jDfPNlSd9LmKItwMHCf+lOU+CB29cbDAxXX52f
        PPNKofgjb0OYaBgQ8qHRaKXEhQ==
X-Google-Smtp-Source: ABdhPJxIBeSWhPSAUP+/5gdhsPaOcie+WqPquZ643kQ+mj51WBlMB4Zn/PmpKAAvt5w5+ate+ZxwWw==
X-Received: by 2002:a62:8c12:: with SMTP id m18mr4367140pfd.111.1592352377287;
        Tue, 16 Jun 2020 17:06:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id np5sm3913590pjb.43.2020.06.16.17.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 17:06:16 -0700 (PDT)
Date:   Tue, 16 Jun 2020 17:06:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Gow <davidgow@google.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
Message-ID: <202006161703.B2E51605@keescook>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200616204817.GA212825@google.com>
 <CY4PR13MB1175A71AE3937C0786721ABFFD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR13MB1175A71AE3937C0786721ABFFD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 16, 2020 at 09:16:01PM +0000, Bird, Tim wrote:
> So far, most of the CI systems don't parse out diagnostic data, so it doesn't
> really matter what the format is.  If it's useful for humans, it's valuable as is.
> However, it would be nice if that could change.  But without some formalization
> of the format of the diagnostic data, it's an intractable problem for CI systems
> to parse it.  So it's really a chicken and egg problem.  To solve it, we would have
> to determine what exactly needs to be provided on a consistent basis for diagnostic
> data across many tests.  I think that it's too big a problem to handle right now.
> I'm not opposed to migrating to some structure with yaml in the future, but free
> form text output seems OK for now.

For a CI system, if I see a test has failed, I expect to be able to
click a link to get the log of that test, which includes the diagnostic
lines. The other reason to have them there is to show progress during a
manual run.

> > Yeah, I think it would be nice if all test frameworks/libraries for the
> > kernel output tests in the same language.
> Agreed.

$ git grep "TAP version"
exec/binfmt_script:print("TAP version 1.3")
kselftest.h:            printf("TAP version 13\n");
kselftest/runner.sh:    echo "TAP version 13"
resctrl/resctrl_tests.c:        printf("TAP version 13\n");
size/get_size.c:        print("TAP version 13\n");

Looks like there are 2 tests to convert to kselftest.h, and then we can
just change the version to 14 in the header and the runner. ;)

-- 
Kees Cook
