Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E7F46C481
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 21:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbhLGU0b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 15:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241418AbhLGU0N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 15:26:13 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8019BC0698C8
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 12:22:37 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 71so112600pgb.4
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 12:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BuZi8W2JMWBI7OZmmzAsfSQRB8lWtAPFIf9TzyCgjPc=;
        b=pFziUuf9Otzx2mSNKwUIVr9EwMijpHwk1Z4Tpo1BlSaIBQfOtvqmlOG7hX7P8eAnxq
         aA1LwjgSySGu4mBbnhqCO6EHvNveO7QI7fIuqV4wPfWJ2sVSFe8ld11eeZ0aXSfkY/oQ
         kHHNMzmT4B4o5bo77zg+x77WKXsy2+BdVKXRLvf/aBDsI0GGsyB1odZBVC1Hmn5E1zws
         SKmhe1IAN1hq9ZP1F5YqvfBCbxDCx/7q7Jrk92TAry3Y8LRUpL8Vm4XweGhZBKPDyBsY
         Wsauufusk6Gyt9dTzi11uPkQtZkPqlERWkgHiPDMijup7wJDa8cZVDCLcoASTAHNu3Wq
         sCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BuZi8W2JMWBI7OZmmzAsfSQRB8lWtAPFIf9TzyCgjPc=;
        b=W+5ACw1LhdxV1Y1KmvQPO0sok69Npt4EgnkfAJdUrvsUG1Oio59GecmXshYzpbRD2a
         tFXjKhBbjhdTMUhj/a9OGKjTSsPjR2Jah79bP1RVrPCOS2Vvr5Q6Klfe5M0bNF8Kw1yj
         R0IUtRIlEEh4oAnleQH1pHnzYjS4kqOCkLfDB72FLii3euDBwhV7q6O+wmaYbNT0sBN3
         LGYX8rdnZ6sy2hnLvECCSE08KKEvOJ8WTM0A9Okqrz4kGAWmNSUxuUPvWpHz3RNh4XGk
         chGDUwGpvTC22oEyY6Gd3BXTqIaa3ozSV0+urxYAXuX64lPn8djuRijqeRScO8UZ33oq
         PM0Q==
X-Gm-Message-State: AOAM532Ij4Ot5vIKl+m+dYMGjzMJOzuvs4ymNG0qz0p4ermI3kTYJkvW
        lZdgXxjVkinhg6WwOxw2XNdnx/Rm2YmDsuu/RE/z+A41dzjo4Q==
X-Google-Smtp-Source: ABdhPJz9CFD3Kz++IH5OLNaBYyX1cpvFD5lBRIL1XhMchRv47Ww1lKlRAtJDrB1ZD9Y4yFcFE1n8emIiuo2TuOetVGY=
X-Received: by 2002:a63:f91b:: with SMTP id h27mr25230303pgi.12.1638908556741;
 Tue, 07 Dec 2021 12:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20211102073014.2901870-1-davidgow@google.com> <20211102073014.2901870-2-davidgow@google.com>
In-Reply-To: <20211102073014.2901870-2-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 15:22:25 -0500
Message-ID: <CAFd5g46HyBJxnu1=iG-v3Vh6UApajJjo6j13+OJ8K6bS--S+OA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] kunit: tool: Report an error if any test has no subtests
To:     David Gow <davidgow@google.com>
Cc:     Rae Moar <rmr167@gmail.com>, Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 2, 2021 at 3:30 AM David Gow <davidgow@google.com> wrote:
>
> It's possible for a test to have a subtest header, but zero valid
> subtests. We used to error on this if the test plan had no subtests
> listed, but it's possible to have subtests without a test plan (indeed,
> this is how parameterised tests work).
>
> Tests with 0 subtests now have the result NO_TESTS, and will report an
> error (which does not halt test execution, but is printed in a scary red
> colour and is noted in the results summary).
>
> Signed-off-by: David Gow <davidgow@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
