Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A3C424D3E
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 08:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbhJGGYM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 02:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbhJGGYL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 02:24:11 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DB8C061755
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Oct 2021 23:22:18 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v17so15498917wrv.9
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Oct 2021 23:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iaq5nU4GLaIaZC0meQweypNii34zyivZ0fMvPt1tbnU=;
        b=kI7aZw6yORYbMtcxAl6QRwzFXWNiCvIA1hTkd3rfw4ZpgpmJo9xJdezhlLdHMM9U0t
         DwJ+/LqXxv6eXDT+lNE385nITwFkxe4VuuaCozoNYsWfjtoxFivWMHLzOtQq6+LwJ9ZO
         Ul88ZugDMVh2erdGjKcv7iM0+l9AlPEbLYwza7HGIbVreTw6NGX08GsVj2qoPQTCQGn/
         TQC2gdPbBwreC4H3pVC7sqPDDzUClrzeLW5azmYnUcpMRopgH/KljDCLIgp3IPSrK/dJ
         RV06xIPSokaNFA+FVKUjZEeBbX0/jUECn4Ttc1ib4ZL8AZ8ksFJuq3ZAxM8eQKGZmojD
         bp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iaq5nU4GLaIaZC0meQweypNii34zyivZ0fMvPt1tbnU=;
        b=RXwgFYkOaqV6v8+h1jKI+40fJcM2BCarXMAZqRRw6J8WK8d8xgvs+rXRoo3QgLKedh
         tqt2ZTLm9q7Kr4esrraIAGoAMzxIwok/5OtKq2yX+dbMnReMCR7d9RF1a8IsyYdVgOjv
         7JGCm4xyz+p4DTmgKuJu+tRN1tjGGho4vrYk/NyNmXWPACbW9KhPUp7TpNLgTXOQD4g7
         WIvZeaD9M7GI1M6CatMgvETZzYXSpnXsZQwN+uAypl1oXd6vxC65CHmq3JsGxzIlm9xy
         yKHp3wvuKBEBIda0cbeAersloNtnlUZMe8eIEB4EaN5aP87msHhqK5vBTcu9E/irO+hn
         EU8A==
X-Gm-Message-State: AOAM532PLx0r01W7ULCLwCkp9XCBpF87qnakXI+uPTN6a7sfWbKKXj6g
        nlORdEccvdjy/DSlqrRUW2pYcm8AlJi+wQVJcYiYoQ==
X-Google-Smtp-Source: ABdhPJxltkfELzP1Sj98wJJVPLf/rcHIL7//lDCPacy+UhPycFVG4s0SAFlkuXzufb7RwHHMsjR95a2Vafkfwx8PeCM=
X-Received: by 2002:a05:600c:284b:: with SMTP id r11mr2443559wmb.179.1633587736875;
 Wed, 06 Oct 2021 23:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211006170049.106852-1-dlatypov@google.com>
In-Reply-To: <20211006170049.106852-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 7 Oct 2021 14:22:05 +0800
Message-ID: <CABVgOS=Bvf_ESOZP_5FJxYe4rBOjR=VZ4bhwgLYOdLu5=-W4+g@mail.gmail.com>
Subject: Re: [PATCH v6] kunit: tool: improve compatibility of kunit_parser
 with KTAP specification
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 7, 2021 at 1:00 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> From: Rae Moar <rmoar@google.com>
>
> Update to kunit_parser to improve compatibility with KTAP
> specification including arbitrarily nested tests. Patch accomplishes
> three major changes:
>
> - Use a general Test object to represent all tests rather than TestCase
> and TestSuite objects. This allows for easier implementation of arbitrary
> levels of nested tests and promotes the idea that both test suites and test
> cases are tests.
>
> - Print errors incrementally rather than all at once after the
> parsing finishes to maximize information given to the user in the
> case of the parser given invalid input and to increase the helpfulness
> of the timestamps given during printing. Note that kunit.py parse does
> not print incrementally yet. However, this fix brings us closer to
> this feature.
>
> - Increase compatibility for different formats of input. Arbitrary levels
> of nested tests supported. Also, test cases and test suites are now
> supported to be present on the same level of testing.
>
> This patch now implements the draft KTAP specification here:
> https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/
> We'll update the parser as the spec evolves.
>
> This patch adjusts the kunit_tool_test.py file to check for
> the correct outputs from the new parser and adds a new test to check
> the parsing for a KTAP result log with correct format for multiple nested
> subtests (test_is_test_passed-all_passed_nested.log).
>
> This patch also alters the kunit_json.py file to allow for arbitrarily
> nested tests.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
> NOTE: this patch is now applied on top of
> https://lore.kernel.org/linux-kselftest/20210930222048.1692635-5-dlatypov@google.com/
> to resolve a conflict.
>
> Change log from v5:
> https://lore.kernel.org/linux-kselftest/20211006001447.20919-1-dlatypov@google.com/
> - Tweak commit message to reflect the KTAP spec is a draft
> - Add missing Signed-off-by
> - Tweak docstrings
>
> Change log from v3,4:
> https://lore.kernel.org/linux-kselftest/20210901190623.315736-1-rmoar@google.com/
> - Move test_kselftest_nested from LinuxSourceTreeTest => KUnitParserTest.
> - Resolve conflict with hermetic testing patches.
>   - max_status is no longer defined, so we need to use the TestCounts
>     type now. And to keep --raw_output working, we need to set this to
>     SUCCESS to avoid the default assumption that the kernel crashed.
>
> Ignore v4, was accidentally based on v2.
>
> Change log from v2:
> https://lore.kernel.org/linux-kselftest/20210826195505.3066755-1-rmoar@google.com/
> - Fixes bug of type disagreement in kunit_json.py for build_dir
> - Removes raw_output()
> - Changes docstrings in kunit_parser.py (class docstring, LineStream
>   docstrings, add_error(), total(), get_status(), all parsing methods)
> - Fixes bug of not printing diagnostic log in the case of end of lines
> - Sets default status of all tests to TEST_CRASHED
> - Adds and prints empty tests with crashed status in case of missing
>   tests
> - Prints 'subtest' in instance of 1 subtest instead of 'subtests'
> - Includes checking for 'BUG:' message in search of crash messages in
>   log (note that parse_crash_in_log method could be removed but would
>   require deleting tests in kunit_tool_test.py that include the crash
>   message that is no longer used. If removed, parser would still print
>   log in cases of test crashed or failure, which would now include
>   missing subtests)
> - Fixes bug of including directives (other than SKIP) in test name
>   when matching name in result line for subtests
>
>
> Change log from v1:
> https://lore.kernel.org/linux-kselftest/20210820200032.2178134-1-rmoar@google.com/
> - Rebase onto kselftest/kunit branch
> - Add tests to kunit_tool_test.py to check parser is correctly stripping
>   hyphen, producing correct json objects with nested tests, correctly
>   passing kselftest TAP output, and correctly deals with missing test plan.
> - Fix bug to correctly match test name in instance of a missing test plan.
> - Fix bug in kunit_tool_test.py pointed out by Daniel where it was not
>   correctly checking for a proper match to the '0 tests run!' error
>   message. Reverts changes back to original.
> - A few minor changes to commit message using Daniel's comments.
> - Change docstrings using Daniel's comments to reduce:
>   - Shortens some docstrings to be one-line or just description if it is
>     self explanatory.
>   - Remove explicit respecification of types of parameters and returns
>     because this is already specified in the function annoations. However,
>     some descriptions of the parameters and returns remain and some contain
>     the type for context. Additionally, the types of public attributes of
>     classes remain.
>   - Remove any documentation of 'Return: None'
>   - Remove docstrings of helper methods within other methods
> ---

Looks good to me, thanks!

This is still:
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
