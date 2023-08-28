Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F279078B3F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 17:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjH1PEn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 11:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjH1PEX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 11:04:23 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BCD191
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 08:04:19 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5646e695ec1so3455131a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Aug 2023 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693235059; x=1693839859;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=44z04Upq456UQmw678VVBxGUGBJlGyeCqGamftbBzBI=;
        b=cfQqaL/IgFqjVPy1uxXhOnPoIcUzStfsVfY2XTS+f8qyN8I/TPlrLPkXMtnMHQL0hw
         eRs5YPhOyntfV3Yk919brYJIa7QFoPtF0o2OpVbSikSYVDq9EPtJUqothhsfbUdkTE2d
         vVf8C/aldP7zaxVLQ8/KYf3esHR2VLxdxCxVNdQ3NegLvf9K4sJ50aOOOYKGC0pqPae8
         +kGua2sD7Uxi312eA0eHodErjGJ6Vpl1tkgHI7l011Xdxvpy1+8XPLkzgxRjBWn5kgms
         pJVvOJlDlhCs25wlVGuNPOfw/+pVTHgUzV+T9ZpWWbvqZmxO1b4sGMNfGT2aRbUL8+XS
         IJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235059; x=1693839859;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44z04Upq456UQmw678VVBxGUGBJlGyeCqGamftbBzBI=;
        b=LKouormUss+QFC2kCaXUoIyFGSIY3PioMM3uA2XxAjRCbFPy0Gh4oHD1gn1legYh/X
         M/CodDHoRrXt6IZ1tYoYe7tp/j9nEquPM7fU/Tqc7KNf5qk9Knv6NAmMh/WS6ik8ffHt
         4gVJA+KTGptkoJEbUuMZYvP+VXXKMdvLejshiIgCtYioaF/tyqYk29V7BE+bZrrn/T3P
         UDeu8smaBkysn47vbTBFd1bxYkVf7CrKehuN+fvEEjkpikLO4M2DsTXkzG+KBUD1MpfW
         eKMui1Oghn1rlQc9v1fEW97pY6gQn8r4KxyE3a68Q/Xu8u7s9pURVl3DRWOo29eLl6Z+
         QXFA==
X-Gm-Message-State: AOJu0YydqDiDl2IK6xI8maV+Bhfjo8Jxdkg3Z5lATMj24xhYYJXp3Cpq
        SczS/ChOqHR3FntOxfq+69oGvLBHlHE=
X-Google-Smtp-Source: AGHT+IHx8QoPWXG0uiFs074kxBJ4wZlo7XAZfUZCF9qCl2ZpFWDd3rF0lIPdKRvJ34ciqAdr+HR2gVtKTXk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:6d83:0:b0:566:2d6:f720 with SMTP id
 i125-20020a636d83000000b0056602d6f720mr4944654pgc.7.1693235058652; Mon, 28
 Aug 2023 08:04:18 -0700 (PDT)
Date:   Mon, 28 Aug 2023 08:04:17 -0700
In-Reply-To: <20230826094523.bl6kbcwelj23cydu@mmaatuq-HP-Laptop-15-dy2xxx>
Mime-Version: 1.0
References: <20230824202415.131824-1-mahmoudmatook.mm@gmail.com>
 <ZOjIHo2A6HZ8K4Qp@google.com> <20230826094523.bl6kbcwelj23cydu@mmaatuq-HP-Laptop-15-dy2xxx>
Message-ID: <ZOy3cXUJld0FskSk@google.com>
Subject: Re: [PATCH v2 1/2] selftests: Provide local define of min() and max()
From:   Sean Christopherson <seanjc@google.com>
To:     keescook@chromium.org, edumazet@google.com,
        willemdebruijn.kernel@gmail.com, wad@chromium.org,
        luto@amacapital.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuba@kernel.org, shuah@kernel.org,
        pabeni@redhat.com, linux-kselftest@vger.kernel.org,
        davem@davemloft.net,
        linux-kernel-mentees@lists.linuxfoundation.org,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 26, 2023, Mahmoud Matook wrote:
> On 08/25, Sean Christopherson wrote:
> 
> > On Fri, Aug 25, 2023, Mahmoud Maatuq wrote:
> > > to avoid manual calculation of min and max values
> > > and fix coccinelle warnings such WARNING opportunity for min()/max()
> > > adding one common definition that could be used in multiple files
> > > under selftests.
> > > there are also some defines for min/max scattered locally inside sources
> > > under selftests.
> > > this also prepares for cleaning up those redundant defines and include
> > > kselftest.h instead.
> > > 
> > > Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> > > Suggested-by: David Laight <David.Laight@aculab.com>
> > > ---
> > > changes in v2:
> > > redefine min/max in a more strict way to avoid 
> > > signedness mismatch and multiple evaluation.
> > > is_signed_type() moved from selftests/kselftest_harness.h 
> > > to selftests/kselftest.h.
> > > ---
> > >  tools/testing/selftests/kselftest.h         | 24 +++++++++++++++++++++
> > 
> > Heh, reminds me of https://xkcd.com/927.
> > 
> > All of these #defines are available in tools/include/linux/kernel.h, and it's
> > trivially easy for selftests to add all of tools/include to their include path.
> > I don't see any reason for the selftests framework to define yet another version,
> > just fix the individual tests.
> 
> giving the reviews seems that patchset is useless.
> still a confusing point for me; after adding tools/include to the
> include path of selftes how we can differentaite between  #include
> <linux/kernel.h> that under tools/include and one under usr/include.

AFAIK, it's up to the individual selftest (or it's "local" framework) to declare
the tools/include path before usr/include, e.g. see tools/testing/selftests/kvm/Makefile.

The whole setup is definitely a bit kludgy, but IMO it's better than conditionally
providing selftests specific fallbacks and potentially ending up with multiple
definitions of min/max within a single test.
