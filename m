Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038CA3F35ED
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 23:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbhHTVP2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 17:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbhHTVP2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 17:15:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC709C061575
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 14:14:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bo18so8264103pjb.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sqivqGiZbtT3bHnPqaZ77QHGz4DhlbspECZeNfhdNXs=;
        b=cpgnvjbRqzen+enbSUfeRNsKSrhYHo0lBkvpQ/e+Hfoueiy3Ux/3D3mGHmGf1vPSfN
         W3xyZoaKRLJyp2W920JWOtspZC3D6czP6z6TEL+pVRmw/dQ8M+FYInE3FrrLS+T6tAWL
         ibU8AeNp96jta/F/Dn8J+PCXlfwR3ks8iZo2kFsuhZYRKIplaEzBjr8tSHI5gAHXNaYF
         Gh3yT3iqRCuRgJt/2ObYI0x1kT7dLbS3BRW49VriRljjkAyhgVz4jZpCxmCb4dNYKzHu
         P8q90DxpDyX5fquCkL01EQ6kTfnZ8WSFIzxnCQiZBfCb7PM/g8yn78W+ujX7dbCHa+0V
         JAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sqivqGiZbtT3bHnPqaZ77QHGz4DhlbspECZeNfhdNXs=;
        b=LDNxJpxTZnHPyAfJWQi/LO/BPET+oLdaki3MRH1COmGqh8JWcyCXEyfGFV0qbnEbAb
         pbjjdpwCBBX/tVxRLcDDyD4Z1vJTGl4vywgV2ROcUWhlNHviu9IY0JGwxBNpYWjsh6gj
         lSkHx3RVPOxgdublWwxaIl/qgE14G55FI2a5t/1++QFLzW3JSmwIM7xCxPnJ9Bk0zMhf
         5unmmVC1ECsZZXE8LyYFaxOkDpTE60hITlxviCXuowv7n1nGm+cA/RK/SdRk3o1m//d9
         ljVntkyoU6nkvIgAWUEYux8tgG7CcihC+u2F3okieSJ9hhiQc9aOZ5d/ck3i24IUBPDR
         vHWA==
X-Gm-Message-State: AOAM53279VSWbDtNka9OO42VFnkvDSlBlY+z+pa00O5qf2tjJP9hzLCb
        VV8Td5RT7Diz7wV++Lntxl81Qv/pQZZG+TYig0oezw==
X-Google-Smtp-Source: ABdhPJyHzo9ZZTde9sOEGhzO/2ASdklPFXG/UIdMwqy//evdOkVK3TbCzcEp/WIYgNeG1wWkB+rbxWhgEbcq909f2Uw=
X-Received: by 2002:a17:902:c406:b0:12d:d0ff:4a9 with SMTP id
 k6-20020a170902c40600b0012dd0ff04a9mr17895286plk.65.1629494089179; Fri, 20
 Aug 2021 14:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210820200032.2178134-1-rmoar@google.com>
In-Reply-To: <20210820200032.2178134-1-rmoar@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 20 Aug 2021 14:14:38 -0700
Message-ID: <CAFd5g45vKkpHhm0X3N+mRCAH8RNEXJTnFm2Dk9sPKzZY+qmMXQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: improve compatibility of kunit_parser with
 KTAP specification
To:     Rae Moar <rmoar@google.com>
Cc:     davidgow@google.com, dlatypov@google.com, shuah@kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 20, 2021 at 1:01 PM Rae Moar <rmoar@google.com> wrote:
>
> Update to kunit_parser to improve compatibility with KTAP
> specification including arbitrarily nested tests. Patch accomplishes
> three major changes:
>
> - Use a general Test object to represent all tests rather than TestCase
> and TestSuite objects. This allows for easier implementation of arbitrary
> levels of nested test and promotes the idea that both test suites and test
> cases are tests.
>
> - Print errors incrementally rather than all at once after the
> parsing finishes to maximize information given to the user in the
> case of the parser given invalid input and to increase the helpfulness
> of the timestamps given during printing.
>
> - Increase compatibility for different formats of input. Arbitrary levels
> of nested tests supported. Also, test cases and test suites are now
> supported to be present on the same level of testing.
>
> This patch now implements the KTAP specification as described here:
> https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/.
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

One minor question/potential issue below, otherwise:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

[...]
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 75045aa0f8a1..ca760ee32096 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -106,10 +106,10 @@ class KUnitParserTest(unittest.TestCase):
>                 with open(log_path) as file:
>                         result = kunit_parser.extract_tap_lines(file.readlines())
>                 self.assertContains('TAP version 14', result)
> -               self.assertContains('   # Subtest: example', result)
> -               self.assertContains('   1..2', result)
> -               self.assertContains('   ok 1 - example_simple_test', result)
> -               self.assertContains('   ok 2 - example_mock_test', result)
> +               self.assertContains('# Subtest: example', result)
> +               self.assertContains('1..2', result)
> +               self.assertContains('ok 1 - example_simple_test', result)
> +               self.assertContains('ok 2 - example_mock_test', result)
>                 self.assertContains('ok 1 - example', result)

Do you have any test cases which accept "ok/not ok" lines without a
"-"? (Or tests for any other KTAP compliant Kselftest output?)

>         def test_output_with_prefix_isolated_correctly(self):

Cheers!
