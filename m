Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1897411DB8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2019 02:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731616AbfLMBME (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Dec 2019 20:12:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45472 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfLMBME (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Dec 2019 20:12:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so635639pgk.12
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2019 17:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OB/PpPf9DqYQf2Qw7tk2Kuy8kuD5wsJrhVi2dlqE7Sw=;
        b=B4QfLAbqAM/M4tT0D/uQ37jaQjF2YFpQR7QbFzgjVP1wMSrjvfxL+DT4sxickn293d
         pgaKxNvMbGrS9X2aVHL/W5rBxjeH7JPg/UAi0zUeUxSP7KPImmBYq+8Nf63RSlrZ8fN5
         ZqQvtgOVa1bBRAwhr1TSh/3FU85gmuZGU0tARN+s/bKlXCC8Mydbng0a1YJkd0wNy/ov
         9pcd6dLzTP7GXjagVVNyQla5nwJ74U9mOR8ii4Gi4R7LWQdGTIDjztuwrZ9w0PlU6W5I
         vOHEvyHmACYgub1FJK3zGtzCKug61Zwwnwz4iSUCsdeEsJlJLPQy2muUnw3Cg3PnMySd
         kBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OB/PpPf9DqYQf2Qw7tk2Kuy8kuD5wsJrhVi2dlqE7Sw=;
        b=sss6nuW/freFSuvImoWgWAN6tmOFNxv3J2C1sXQBYQdftPossszSLtSCq0fxTks0MM
         aXLMQAFS8LTAXTDlLOpNtFojXLn8hEwmLXD9qSVdeJAtTwDMTKNFOdo7Agx3c/Ofb2Va
         MxxvguwDpnRzEL7j1uDJOQADVowjsx7H+ROn/KPIhsZOFs1Sqz55HAZVsa8HdKucwzf4
         4E3owsftXJIHMFYN7vv2kfX2YLI6JDVeg/XHYQQloI0Erc9iknjCAcUOonKj7yOMhjq5
         BfyoXWjKWtLdiqT8tALPw3+daymVtRSinfITg2fDOkV+60nWxz7EVFk0kWlF2lETFI9p
         W9WQ==
X-Gm-Message-State: APjAAAV13c32opTw02QuuKcIBtIz0RkFQNObHDtaGusL2mICkH8RMlqz
        zQexynyG+0bQTcL76pqTcK4/wIrg5/StTUdznjPNPQ==
X-Google-Smtp-Source: APXvYqxWvzd3ydWQnsw8GTi9x1x/1qLazZpUOpXIcE70GeNhhVCT1RDLbbb0t/qplulkQg7PwzhEf/OQh6tEoY3p+k8=
X-Received: by 2002:a63:cc4f:: with SMTP id q15mr14061181pgi.159.1576199523237;
 Thu, 12 Dec 2019 17:12:03 -0800 (PST)
MIME-Version: 1.0
References: <1575473234-5443-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1575473234-5443-1-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 12 Dec 2019 17:11:52 -0800
Message-ID: <CAFd5g47KswC47H=0sDr+EFQUGJ3DSMSU2X=1dZc-5D_tZ3ZbOA@mail.gmail.com>
Subject: Re: [PATCH v6 linux-kselftest-test 0/6] kunit: support building
 core/tests as modules
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        catalin.marinas@arm.com, joe.lawrence@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com,
        Jonathan Corbet <corbet@lwn.net>,
        David Gow <davidgow@google.com>, adilger.kernel@dilger.ca,
        "Theodore Ts'o" <tytso@mit.edu>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 4, 2019 at 7:27 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> The current kunit execution model is to provide base kunit functionality
> and tests built-in to the kernel.  The aim of this series is to allow
> building kunit itself and tests as modules.  This in turn allows a
> simple form of selective execution; load the module you wish to test.
> In doing so, kunit itself (if also built as a module) will be loaded as
> an implicit dependency.
>
> Because this requires a core API modification - if a module delivers
> multiple suites, they must be declared with the kunit_test_suites()
> macro - we're proposing this patch set as a candidate to be applied to the
> test tree before too many kunit consumers appear.  We attempt to deal
> with existing consumers in patch 3.

Hey Alan,

I just wanted to make sure you're not in the dark and wondering what
happened in regards to this patchset. To my knowledge, I believe you
have all necessary acks/reviewed-bys. As far as I am concerned,
everything looks good here and is ready to go. The only remaining bit
is Shuah picking it up, and sending it out in a pull request. Based on
the nature of this series, it will have to wait until 5.6; however, I
think we can accept it into kselftest/test (we are planning on
renaming it to kunit-next or something like that) as soon as we cut
that, which should be pretty soon.

Feel free to poke us if you have any questions!

Thanks again for all your hard work on this! I think this is going to
be a valuable addition to KUnit.

Cheers
