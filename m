Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA2C159DB2
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2020 00:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgBKXyJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 18:54:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35019 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgBKXyJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 18:54:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so207755plt.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2020 15:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BDlxFx20QE0gAgkEMA+u4mAwlJYSDizranolCfN6FSU=;
        b=XB7DUxrOlRWKCxIVzsmwUiozIyPNm+XipqRy+ojNQXQ4il5NSGcySle4DA3copkxR0
         txpPB/fPke36xIv/qe2phszSj0yMMBhZ7SSIKgC8wlYAX/nwLnydJ9528PktuoKka0Xo
         FIQk6kwnmb94p+mMQF56OxOJi3mG8ahbOTuU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BDlxFx20QE0gAgkEMA+u4mAwlJYSDizranolCfN6FSU=;
        b=VrZhsStgrqgFkd7qDdnO3IXLbV/GBUeaN2hMlcFHOlthgTQKgmswPLug0C1l+b6mQF
         qreBb7CkinP6ZD8b+wK5sHCCLj7/Yn2F8FNUcT+d6AhE+GwnlNMkvQA/aGFrLHYVLTmq
         YemK2+1kP8Y3W3bn1JX77nhDFxLbvobIU2rFcBSic1tvMtmRTAv0VCAy0y50LluIKVSO
         eDxLwNW/t4yrzW1hJBwMc6hUws7njmdcHtbtIi32KJOnMoslZv+fBewL1diqvJ0JfEPW
         aEulRIK0zQNA3+g5h4i19bkrtlKOg0oxpgX+WXQhMcIRnf28LooypKlB6U9jfN0kjZcz
         j3GA==
X-Gm-Message-State: APjAAAWoeN90mdDHXiNdCa+9dGXgxHSGrRoOwOq0nWiO8baiYHXtnPKy
        yqurGfqSEtLE1FB1uRzTzDE7rg==
X-Google-Smtp-Source: APXvYqwqQSXGq4Fmc5d6MiCNIFPhP1UefR6VzsmHhkS/fi/pcrd5lNid2Jli/7N0q+/799PEFAxbdw==
X-Received: by 2002:a17:902:708b:: with SMTP id z11mr5645748plk.121.1581465248817;
        Tue, 11 Feb 2020 15:54:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l13sm4513339pjq.23.2020.02.11.15.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 15:54:08 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:54:06 -0800
From:   Kees Cook <keescook@chromium.org>
To:     shuah <shuah@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jann Horn <jannh@google.com>,
        Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 7/7] selftests/exec: Add READ_IMPLIES_EXEC tests
Message-ID: <202002111549.CF18B7B3B@keescook>
References: <20200210193049.64362-1-keescook@chromium.org>
 <20200210193049.64362-8-keescook@chromium.org>
 <4f8a5036-dc2a-90ad-5fc8-69560a5dd78e@kernel.org>
 <202002111124.0A334167@keescook>
 <c09c345a-786f-25d2-1ee5-65f9cb23db6d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c09c345a-786f-25d2-1ee5-65f9cb23db6d@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 11, 2020 at 02:06:53PM -0700, shuah wrote:
> On 2/11/20 12:25 PM, Kees Cook wrote:
> > On Tue, Feb 11, 2020 at 11:11:21AM -0700, shuah wrote:
> > > On 2/10/20 12:30 PM, Kees Cook wrote:
> > > > In order to check the matrix of possible states for handling
> > > > READ_IMPLIES_EXEC across native, compat, and the state of PT_GNU_STACK,
> > > > add tests for these execution conditions.
> > > > 
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > 
> > > No issues for this to go through tip.
> > > 
> > > A few problems to fix first. This fails to compile when 32-bit libraries
> > > aren't installed. It should fail the 32-bit part and run other checks.
> > 
> > Do you mean the Makefile should detect the missing compat build deps and
> > avoid building them? Testing compat is pretty important to this test, so
> > it seems like missing the build deps causing the build to fail is the
> > correct action here. This is likely true for the x86/ selftests too.
> > 
> > What would you like this to do?
> > 
> 
> selftests/x86 does this already and runs the dependency check in
> x86/Makefile.
> 
> 
> check_cc.sh:# check_cc.sh - Helper to test userspace compilation support
> Makefile:CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC)
> trivial_32bit_program.c -m32)
> Makefile:CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC)
> trivial_64bit_program.c)
> Makefile:CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC)
> trivial_program.c -no-pie)
> 
> Take a look and see if you can leverage this.

I did before, and it can certainly be done, but their stuff is somewhat
specific to x86_64/ia32. I'm looking at supporting _all_ compat for any
64-bit architecture. I can certainly write some similar build tooling,
but the question I have for you is one of coverage:

If a builder is 64-bit, it needs to be able to produce 32-bit compat
binaries for testing, otherwise the test is incomplete. (i.e. the tests
will only be able to test native behavior and not compat). This doesn't
seem like an "XFAIL" situation to me, and it doesn't seem right to
silently pass. It seems like the build should explicitly fail because
the needed prerequisites are missing. Do you instead want me to just
have it skip building the compat binaries if it can't build them?

-- 
Kees Cook
