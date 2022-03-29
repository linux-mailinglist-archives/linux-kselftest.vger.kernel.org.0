Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309B54EB545
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Mar 2022 23:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiC2V3T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Mar 2022 17:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbiC2V3T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Mar 2022 17:29:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BF6239307
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 14:27:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b24so22157683edu.10
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 14:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5Kf4tIOrW+TXVLfToUnNnc77oMmkd7cGdwQs3kzn5E=;
        b=Q3rNjLjzz3gs978QUv6jP8uCoY3jVNFRY6pnshB6MtmFG7vA2Sit1U7E5MPSfa+Rk0
         PErHcuDYc+mDXNrdrGyszuN/0nv0rvy09XmBqsXB/DHm2IZuXJ8mPtXBgkBehaqEWEYG
         v+yBtAMI+fTI1jRF+prEPRxTl0p1KNh94oJR9EV/+L1uYi5tK+3jpNcIIHLzqdgPr7CN
         74ClmqXbHJ/6wmIWI4aPsMGSc5zEGoyPIMHa1cj9j1r98GjRjR8/x2ol1P3hXRPcrkaL
         GOvpeCZ42Vvca2n0XnRINkbQSgiJd1Ure4ABlhBUbklR+ZgCr3Om3sP/7mW7UsGZUqWT
         zs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5Kf4tIOrW+TXVLfToUnNnc77oMmkd7cGdwQs3kzn5E=;
        b=vEE2IBP5yJyq8HgG4L93eeGXBhvZCVWetz7b2FfoHXXZNHytMA9Fc3VxpMksjjU/0u
         Jp64G79dGvjI1mjc+A3LjL9XnI0gwCS+bM7nZTEfwSXO7E8sDwg9PClW5ZV87SkCMaz8
         9cTZuEFAXFqh3ItLFoAyAEp/XR1Z7+qbbCNzeeYjD7FQCof5Bcc3/WCl217wB627Oap6
         VyJcHVDrqxv+UKYJcMXrDLkoXW/hoTAoruyoVZs8N4319k/HwVDmP6MhHXeGWNu1FsMo
         CXd4BIq1egpnNeNg3S+L+JoBTclsdr+f6hcNPm7rAhzy2U/PtjRaozyh4NRWg5Vr+mn/
         c9bw==
X-Gm-Message-State: AOAM531sBITNpJRCnXKA+prs5M850pcEborn3ktzqKJNy2Ie4uYug8kH
        6FxZrDluhQxTAleUEeqevh4gd12xkWUtoSltkb9/zwqUJx7yBQ==
X-Google-Smtp-Source: ABdhPJxLl4nDWjhDn9MDxFoq2paLjPe4jmT3iGnfqwDbvQcl0/wz7iO0WhBwZrKB8nf8+weeT8q+yjqELi4kBzuJ8+s=
X-Received: by 2002:a05:6402:1cc1:b0:413:2b12:fc49 with SMTP id
 ds1-20020a0564021cc100b004132b12fc49mr7190427edb.118.1648589253782; Tue, 29
 Mar 2022 14:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220131212341.1082577-1-dlatypov@google.com>
In-Reply-To: <20220131212341.1082577-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 29 Mar 2022 17:27:22 -0400
Message-ID: <CAFd5g46z_RBMWRTfJB5h_sdkaEaJCOwnnkUER0fPSPQ6ac5_6A@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: kunit: fix path to .kunitconfig in start.rst
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Yifan Yuan <alpc_metic@live.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 31, 2022 at 4:23 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit ddbd60c779b4 ("kunit: use --build_dir=.kunit as default") changed
> the default --build_dir, which had the side effect of making
> `.kunitconfig` move to `.kunit/.kunitconfig`.
>
> However, the first few lines of kunit/start.rst never got updated, oops.
>
> Fix this by telling people to run kunit.py first, which will
> automatically generate the .kunit directory and .kunitconfig file, and
> then edit the file manually as desired.
>
> Reported-by: Yifan Yuan <alpc_metic@live.com>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
