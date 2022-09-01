Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE015AA3DF
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 01:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiIAXon (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 19:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiIAXol (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 19:44:41 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C69261D4A
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Sep 2022 16:44:40 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11f34610d4aso1037780fac.9
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Sep 2022 16:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=X6a683iDz7ML2b6gQJ7MXVC/aDeAhx+QotiRauAFCC8=;
        b=XRcSB6A82/S7Wk7JvByhg9pXVGFOf/DvkMz8BsAF2qPDnq1QPyOQ7dh6nN6VMzNKtV
         Ec8dt6UAqTCWRTNTqnkMs8heo459+ZGQnNDKIDSrixZH9O5u6E/1siRYsnUWaSboaITU
         2CtHIWhkY+8UyHDyzZ+4mINr7CuCgffnhvCM8WjSx4ZiZeEdqxJPlRmou1saRKeYP7RA
         QL+dAnoAsuov9hhRe1UlA5ah3q5jGjQKJIMIbsGLVNDwkH2njhR1+Ly9tSJEUM/0vLCN
         tI1kS7POSxAf4QgBYcPgdySWvhbCHJBMnHu+yuMvA3j8JePMWZyT1DMiH5aPs8NOqE64
         vnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=X6a683iDz7ML2b6gQJ7MXVC/aDeAhx+QotiRauAFCC8=;
        b=JAPi4dQodPWwYkBsYUCMOpX76Uf7DTGXAn46vMMqSxF17Y8mk0GNbq/ca+9pVDG3bV
         fn9eC3uPd89p/OIQIyNQ1768WWea6JVyCK/Sk8KJZNWRXYaaN5NJKM+A6hoqMrP9WoW9
         oD99PxN3T2NavIYkvrjnXramduRqyNmtBVyvAspGjk9VlQwSK+izVY8pXzlpt9zGh5Ux
         UbT1j72dCseRUvJJhZFDX6gp4uHXcZMdJI4rsEL2deQAFzOXHBdmsEptUF9kQlVEtqwH
         iZXbTp+MRymy9I9WsmRim7bZQvgfpjhk1nYtw6k4o1LHXP8My2p2Q5Hb1eHuZvZmA+Hh
         M6cw==
X-Gm-Message-State: ACgBeo3JMzm8p2A6LDgCJWKVEyA2pqaqy8TsAV9NfC08LkmM71qhn+ET
        NamG1QnmD6mV+a0GAd6pvjqE9SB6TVd+T6iO5Q1YadI81g==
X-Google-Smtp-Source: AA6agR6O0cEeUyv5nUs5Xy4LsM1ZajObDzXeBBOEECGDx+tKhxY7MVmv8sBcN/a6QVEpRy2PQ3lUScEkxAY82lysvo4=
X-Received: by 2002:aca:3010:0:b0:343:91b:7f7 with SMTP id w16-20020aca3010000000b00343091b07f7mr733254oiw.51.1662075879854;
 Thu, 01 Sep 2022 16:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220824041933.822838-1-joefradley@google.com>
 <CABVgOSki72Yqb1DBSCgi-qk+FbNniL4GX+19MXwq=K9VEzAyoA@mail.gmail.com> <cb8b16a1-a7d6-1b04-c748-3f2d802b54e5@linuxfoundation.org>
In-Reply-To: <cb8b16a1-a7d6-1b04-c748-3f2d802b54e5@linuxfoundation.org>
From:   Joe Fradley <joefradley@google.com>
Date:   Thu, 1 Sep 2022 16:44:29 -0700
Message-ID: <CAF-60z1XC0GHNKAv79iomGBmVNSyo_MfZ=uYtxLGOxSiBFSweQ@mail.gmail.com>
Subject: Re: [PATCH v2] tools: Add new "test" taint to kernel-chktaint
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Jonathan Corbet <corbet@lwn.net>, kernel-team@android.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 1, 2022 at 11:57 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 8/23/22 22:41, David Gow wrote:
> > On Wed, Aug 24, 2022 at 12:19 PM Joe Fradley <joefradley@google.com> wrote:
> >>
> >> Commit c272612cb4a2 ("kunit: Taint the kernel when KUnit tests are run")
> >> added a new taint flag for when in-kernel tests run. This commit adds
> >> recognition of this new flag in kernel-chktaint.
> >>
>
> What happens without this change? It isn't clear what this change is
> fixing.

Without this change the correct reason will not be displayed if the kernel
is tainted because of a test.

>
> >> Reviewed-by: David Gow <davidgow@google.com>
> >> Signed-off-by: Joe Fradley <joefradley@google.com>
> >> ---
> >> Changes in v2:
> >> - based off of kselftest/kunit branch
> >> - Added David's Reviewed-by tag
> >>
> >
> > This still looks good to me.
> >
> > Unless anyone objects, I guess we'll take this through the KUnit
> > branch (which, after all, is where the taint was originally added).
> > I've added it to the list for 6.1, but it technically could be
> > considered a fix for 6.0 as well.
> >
>
> I can definitely take this for Linux 6.0 with additional information
> on the problems seen without this change.

Great, thank you very much.

>
> thanks,
> -- Shuah
>
