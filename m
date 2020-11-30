Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C56E2C90F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Nov 2020 23:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgK3WZD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Nov 2020 17:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbgK3WZD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Nov 2020 17:25:03 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B43CC0613CF
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 14:24:17 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id s2so7286333plr.9
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 14:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tP10auY5b/+hzNiyTCTFtYJxVIRMIAgFsrP2yx2Sg3Y=;
        b=fKA2uASNNmUSAdH8RvG4OeS9vDii9vjtJ+qPy6l79wdX0Bhc5GCox+clxnSNfQpv5Z
         rPk1xCj6/UQ1NuWfJU9U3gLdsaloMVIAB/Ew/H1Jy5xlXQNf26auNbfF9rOh6mqvc1MJ
         gXdzMmEDbcpK9xd0QgQi8Hs1dLExTrGkI64CH1qQn3ewgb2S/PjTRlXBEvbXwOrAKxfN
         5PbOpheLTUXENkl4qhw3fc6MMK62GwNDrzYeKNO9UXo9QoDdU9EHs24cCNP/+yJ2/mV2
         Q1aOf/HeL8HiNGq95TXtUkneTvfnhlea8rCm84CqNwXPxPcrW8/XMERy9Vyn52xu0tPg
         6Bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tP10auY5b/+hzNiyTCTFtYJxVIRMIAgFsrP2yx2Sg3Y=;
        b=XEdLu9g+N73e23bF92/c/3R1dCz8pZzXSqe4ZPRbcZBHkPSGcw29teaVpRT2Zfbb0F
         yssVEFco+K6xs/VRqjbrCL7zIIipDl82w954HBKyi3GiwuDriR/7G94B0r7osZSjo+Tq
         sgXv7oUmaSKE6N4692lAv1w31CQyd9dgCec/ho15IJY6iEebXljZk6WcFER9MIxVE/wM
         CM9En+CIiOa5VAEWf/nTj/PRESz1dZ6D1YxmsXGAZl3OMDl0IrDqdMkpqPMP1s5FwEHA
         GPTBOsGte9GHu2lAgYw1Nj7QPj+tl3rB884t4l9XR2KSf4vvYjdXPJjAhehwXiAYk/3c
         r6TQ==
X-Gm-Message-State: AOAM530BxvgIGnVDelTwXTGn00roczIVCBphZiuyyPBPzaGvuosR+9FO
        nYbQvmUZiIIcX1g8SYK19OHENUZRvVNY0UbXtaqu8g==
X-Google-Smtp-Source: ABdhPJwBW05dCKp6JwGQ8qZLyIPqU+sgllBKgG9WsgW8WuQeZ5sRlEKY2B/Pl3nXeVEzHxE+VL92fIImTrWF0SBiI7Y=
X-Received: by 2002:a17:902:bd09:b029:d9:f7c8:6210 with SMTP id
 p9-20020a170902bd09b02900d9f7c86210mr21302705pls.80.1606775056561; Mon, 30
 Nov 2020 14:24:16 -0800 (PST)
MIME-Version: 1.0
References: <20201115185759.169279-1-98.arpi@gmail.com>
In-Reply-To: <20201115185759.169279-1-98.arpi@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 30 Nov 2020 14:24:05 -0800
Message-ID: <CAFd5g46mV_BKC8JQkw0vTXzZfy-dQ=N0jO_DHe-nBrWZimYVCg@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Nov 15, 2020 at 10:58 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Implementation of support for parameterized testing in KUnit. This
> approach requires the creation of a test case using the
> KUNIT_CASE_PARAM() macro that accepts a generator function as input.
>
> This generator function should return the next parameter given the
> previous parameter in parameterized tests. It also provides a macro to
> generate common-case generators based on arrays. Generators may also
> optionally provide a human-readable description of parameters, which is
> displayed where available.
>
> Note, currently the result of each parameter run is displayed in
> diagnostic lines, and only the overall test case output summarizes
> TAP-compliant success or failure of all parameter runs. In future, when
> supported by kunit-tool, these can be turned into subsubtest outputs.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
