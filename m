Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE36864E172
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Dec 2022 20:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiLOTBP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Dec 2022 14:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLOTBP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Dec 2022 14:01:15 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0B014D04
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Dec 2022 11:01:14 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id k79so229138pfd.7
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Dec 2022 11:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+2yoWKUdi8Gixa0ECv6JehIbofin/LQeXYv9L9TZ4S8=;
        b=PBbDJFPADcRfessRbJP5OnkMHouy75YkhMGgTLTXyDtiQ3uOWmZLQkU/n/EJgM630q
         y8I/gzzgXwn/Qlxe4rFEiQpy21l9B69Ei0Cx3WoLYwNi8hQriXSHAcpW7fT++aeBl+rq
         VIHf17QHGd4HPTbgFHQj4RZxcMDGr7UnRPXdruWwVxufbJHRyY43LDDRQ5fsxWgmgdUL
         szyh+pT8uHeNkALMZET6VkZaYf5IQmMK+/KaBO/UyudEasUKm7RbAgL6u8eLUt4QyufQ
         SZoC81/uXWDOiVFs80K8hgE7s+Pr1+xhxQDV4cziH9hhB/kFBNu0Xy6BJB7lhEBwiY8f
         aP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2yoWKUdi8Gixa0ECv6JehIbofin/LQeXYv9L9TZ4S8=;
        b=mUQff1Mcy03Qyws/xfnHby+yTahVgHil+F3+IJKtUk6ycnf30k4ZY9BvmezbU/qIwm
         FB4hNUrQcwFD2PtbjweRBzkhKLNk67plkwbIQJbaxIRji4CmCtC8042FMtd6EIJgq8NN
         niapTmnCAx2i97oNLIVFvBRyV2254P0sN1Y0B1FxYiKdqjC+f1dKwAAGC8STIalz6U9m
         cwxgbVI6na6tu7YG3e8KP/PgAclXrDsozBZmElDOmtWMTarLORmJHNFKzYMYbKPbN2jw
         q04igL2Oo9ZreXXxDMyqwQXHcRX6i6FqOORS2qErKiyHX99vqHflYP0Te/FritpoyvBt
         KhYg==
X-Gm-Message-State: ANoB5pmrKQd4Nhp47vVcmXZs89LVoKD0JY+K3DB2KsZFVTdDqG9bXU++
        NFt45kcr/rP+bzo8lMZkRq/X1LhX9s/miL3DFg8Yww==
X-Google-Smtp-Source: AA0mqf4H+Y1H3y34btVtzJqiGedZOLMvgXeRUAJ90TEidbL7bhLR7R1wUJr8x6ZPlXUZ2Lx6sRwZH23ZM2/uZoXvNW0=
X-Received: by 2002:a63:592:0:b0:478:ab04:f293 with SMTP id
 140-20020a630592000000b00478ab04f293mr20331351pgf.345.1671130873339; Thu, 15
 Dec 2022 11:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20221208061841.2186447-1-davidgow@google.com> <20221208061841.2186447-3-davidgow@google.com>
 <Y5G3SVt+oQvLjW1e@debian.me>
In-Reply-To: <Y5G3SVt+oQvLjW1e@debian.me>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 15 Dec 2022 11:01:02 -0800
Message-ID: <CAGS_qxry-php+k7QvgsBVxRna=896O8AdLph+Je5GjNXa2q9HA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation: Add Function Redirection API docs
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Fradley <joefradley@google.com>,
        Steve Muckle <smuckle@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 8, 2022 at 2:07 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Thu, Dec 08, 2022 at 02:18:41PM +0800, David Gow wrote:
> > From: Sadiya Kazi <sadiyakazi@google.com>
> >
> > Added a new page (functionredirection.rst) that describes the Function
> > Redirection (static stubbing) API. This page will be expanded if we add,
> > for example, ftrace-based stubbing.
>
> s/Added/Add
>
> > diff --git a/Documentation/dev-tools/kunit/api/functionredirection.rst b/Documentation/dev-tools/kunit/api/functionredirection.rst
> > new file mode 100644
> > index 000000000000..fc7644dfea65
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kunit/api/functionredirection.rst
> > @@ -0,0 +1,162 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +========================
> > +Function Redirection API
> > +========================
> > +
> > +Overview
> > +========
> > +
> > +When writing unit tests, it's important to be able to isolate the code being
> > +tested from other parts of the kernel. This ensures the reliability of the test
> > +(it won't be affected by external factors), reduces dependencies on specific
> > +hardware or config options (making the test easier to run), and protects the
> > +stability of the rest of the system (making it less likely for test-specific
> > +state to interfere with the rest of the system).
>
> Test reliability is test independence, right?

Just my 2c, but I'd disagree.

E.g. a test can depend on CONFIG_FOO being built-in, even though it
doesn't really need it.
Having an extra kconfig dependency doesn't necessarily make the test
less reliable.

You could define "test independence" wrt shared runtime state (e.g.
multiple tests touching the same global var), but this text
specifically says "hardware or config options."

Daniel
