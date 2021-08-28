Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDB63FA3F5
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Aug 2021 08:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhH1GLE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Aug 2021 02:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhH1GLD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 28 Aug 2021 02:11:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EBCC0613D9
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Aug 2021 23:10:13 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d3-20020a17090ae28300b0019629c96f25so3647986pjz.2
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Aug 2021 23:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HExQExRnC/Ml8jsHTDEfsEBp2y/T7jRvmLtZYOP/Gv4=;
        b=LkL2Xz4aS7N4gy+2F/ClPL/p+K0mEva/TUi+uiMT/lxEzA44EQczgUtsxGr4oPXYPr
         7TFSVcgD/bBc1Ta86H5zwpbuJf0jmxDdHGnIWWpxepcmZqRMgRP/qg9BkoErPRxEnx2w
         rXAp4P2ECcxQ5k/SA+IfF+It5qxSm6Kwi9ea8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HExQExRnC/Ml8jsHTDEfsEBp2y/T7jRvmLtZYOP/Gv4=;
        b=PG7S6G7wg9pIOM5kLlcCpXQBkLtI2IZCE2x/9R+DWgmtADiS9z3GQlWx7Z6/xMcHEf
         7oqUuQ7U1r2ITg+cww003m3iPORWkJKV0IyIsWVU9GZ5ZOvXYrvQEPS3+BNS+qcAFM1o
         mJ5ouh7tVInrGGlgjq8Aqf1egmBhKeQwNj/fS2fqzHn7j6luKezhiV3E20twobLqegS9
         DesengBQZW7VhJHL3Ee2xQB+rmMdtBRI9ndCKLxaZGkN31O8w6U9rXCHSlxHWkGgmlqh
         L0qAwQib0vyF7TMQZUEnEYyyv+AwqQifsZZfMNRWjG6ZF23IXTrUwHfwhOq+Sy1EmFiW
         b0iA==
X-Gm-Message-State: AOAM533tSZLcmwVv+DXc1BzC1fJ3Z0vBG0dKHNtprawL/xlkBsE7L06K
        cKbIf1PIYCm7yv7I3Px9GY72+g==
X-Google-Smtp-Source: ABdhPJyh0zBZePl7+jvdMSGVo1XXeY5ux4yfWim74LsVuX3ZtoFMFfapNGI0tA0NRBq6wlc7inCynA==
X-Received: by 2002:a17:902:e0cc:b0:134:7191:f39 with SMTP id e12-20020a170902e0cc00b0013471910f39mr12287059pla.36.1630131013383;
        Fri, 27 Aug 2021 23:10:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x12sm7865915pfu.21.2021.08.27.23.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 23:10:12 -0700 (PDT)
Date:   Fri, 27 Aug 2021 23:10:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, shuah@kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests: tool: update format of kselftest TAP
 results to improve compatibility with KTAP
Message-ID: <202108272303.F659107A@keescook>
References: <20210827225812.3247919-1-rmoar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827225812.3247919-1-rmoar@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 27, 2021 at 10:58:10PM +0000, Rae Moar wrote:
> This series of patches updates the format of kselftest TAP results to improve
> compatibility with the proposed KTAP specification
> (https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/).
> 
> Three changes:
> - Change from "# " to "  " for indentation of nested tests

This seems like subtests would need to have a known global nesting
tracking again. That was removed to simplified various aspects of
kselftest.

> - Add subtest header line at start of tests with subtests. Line format
> is "# Subtest: [name of test]".

That would mean subtests are no longer individually parseable by
existing TAP parsers (i.e. when LAVA splits up kselftest output,
suddenly there is no TAP header).

> - Remove TAP header in nested tests

What benefit does this provide? This just makes things harder to machine
parse now.

> Standardizing TAP results would not only allow for clearer documentation and ease of reading but by standardizing the format across different testing frameworks, we could also share the use of tools.
> 
> As an example:
> 
> This is a truncated version of TAP results from the kselftest ptrace with the new format changes:
> 
> TAP version 13
> 1..1
> # selftests: ptrace: get_syscall_info
>   # Subtest: selftests: ptrace: get_syscall_info
>   1..1
>   # Starting 1 tests from 1 test cases.
>   #  RUN           global.get_syscall_info ...
>   #            OK  global.get_syscall_info
>   ok 1 global.get_syscall_info
>   # PASSED: 1 / 1 tests passed.
>   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> ok 1 selftests: ptrace: get_syscall_info

But this would mean changing every TAP parser to notice "# Subtest:"
instead of "TAP version ..." Why bother doing that? A parser aware of
subtests just needs to examine indentation level currently.

> 
> With the new patch to update the KUnit parser to improve compatibility with the proposed KTAP specification, (https://lore.kernel.org/linux-kselftest/20210826195505.3066755-1-rmoar@google.com/) the above TAP results would be parsed as the following:
> 
> [20:46:09] ============================================================
> [20:46:09] ===== selftests: ptrace: get_syscall_info (1 subtest) ======
> [20:46:09] [PASSED] global.get_syscall_info
> [20:46:09] ======= [PASSED] selftests: ptrace: get_syscall_info =======
> [20:46:09] ============================================================
> [20:46:09] Testing complete. Passed: 1, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0
> 
> Thus, the kunit parser could become a useful tool for kselftest users.
> 
> Rae Moar (2):
>   selftests: tool: Add subtest header line and change indentation format
>     in TAP results
>   Revert "selftests: Remove KSFT_TAP_LEVEL"
> 
>  tools/testing/selftests/Makefile            | 6 ++++++
>  tools/testing/selftests/kselftest/prefix.pl | 2 +-
>  tools/testing/selftests/kselftest/runner.sh | 7 ++++---
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> -- 
> 2.33.0.259.gc128427fd7-goog
> 

-- 
Kees Cook
