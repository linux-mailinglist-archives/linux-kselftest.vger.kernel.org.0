Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5797D1F9F6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jun 2020 20:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgFOShv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 14:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729842AbgFOShv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 14:37:51 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C15C05BD43
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 11:37:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y18so7150342plr.4
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 11:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BXOExHlseDR5lyHBcXzOZz/wvry3WqelFft9LO6SFUk=;
        b=dpaWrqr3z78F+xpH0gnmbE6vvjL2dNQiiHQAgD5yKHAMh27qX8+aCvXaXKOUToLdIQ
         sh6A1RfFFvXRlslq5iAHx0a6Zv8quHnCskDIV9U6gjU/arpkc0c7br21WbGk78B6ho1g
         7YcMndA5241LA3xc2qlIfpxX1dol0YzIPnDHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BXOExHlseDR5lyHBcXzOZz/wvry3WqelFft9LO6SFUk=;
        b=nnfGDvi+C/HJwWI4BbPsPlpUdg1mun4nfsWCjhr697PnvobYTx4qrTBh7q9Ct3CA2c
         Go3agS/XCPmESYEcsT0y8S0cTVK6lt44Yrk7NiyutOymW5YCsVzpX7Xx6azpYCmppysw
         kZb2ZrOOJC5D/zky+AW0GAdeuqXYT7zej5Q9h89MqmHQ2+bqbSwaBveY1FtaW9Q7/Pn/
         YDRoyugHb/CWVwx5a51Q6q4Z1+xIVP4+yu6yfjEsgGNe+x1hlmA6ykms3aS9P/NbAK23
         HYNK+sat6zB0k/iH9ycQFzD6bl8Vg267hNlH35iOewkYlo7iVHnvsu75VyGrVREzigEN
         /ZEQ==
X-Gm-Message-State: AOAM532MiAkuyLqyyZov836wxc+YyKwQYPC+uEmQPSotR56aFyHGKA+Q
        29YnaVMqzigd5dZo62zWTE9Jew==
X-Google-Smtp-Source: ABdhPJzOmBD8Hz6oTM7AnVhELxZHQ6n3SqTyEwjfJ4bmPUbdCEr5ZOSF2osjWYz/O569gQqlA9YE7A==
X-Received: by 2002:a17:902:710e:: with SMTP id a14mr23411950pll.199.1592246270133;
        Mon, 15 Jun 2020 11:37:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i22sm14427227pfo.92.2020.06.15.11.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 11:37:49 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:37:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     kunit-dev@googlegroups.com, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH] lib: kunit_test_overflow: add KUnit test of
 check_*_overflow functions
Message-ID: <202006151134.36BAA57@keescook>
References: <20200611215501.213058-1-vitor@massaru.org>
 <202006121403.CF8D57C@keescook>
 <0c9d09065dca0b71466600e68b64142402a98d24.camel@massaru.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c9d09065dca0b71466600e68b64142402a98d24.camel@massaru.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 15, 2020 at 01:30:42PM -0300, Vitor Massaru Iha wrote:
> On Fri, 2020-06-12 at 15:36 -0700, Kees Cook wrote:
> > Why drop the __initconst?
> 
> I removed __initconst because of these warnings below, as it is used
> for the kernel during the module initialization, and I do not use the
> module initialization in this tests. Does this have any side effects in
> these tests?
> 
> WARNING: modpost: vmlinux.o(.text.unlikely+0x131b7): Section mismatch
> in reference from the function test_s8_overflow() to the variable
> .init.rodata:s8_tests
> The function test_s8_overflow() references
> the variable __initconst s8_tests.
> This is often because test_s8_overflow lacks a __initconst 
> annotation or the annotation of s8_tests is wrong.

Ah, right. I assume there are build modes where the tests don't only
live in the __init section any more due to how Kunit does its runtime?
(Before all the tests ran from __init via module_init(), IIRC.)

> > So, yes! I like it. :) Most of my comments here have nothing to do with
> > specifically this patch (sorry)! But I'd love to see a v2.
> > 
> > Thanks for doing this! I'm glad to see more TAP output. :)
> 
> Thanks Kees, I'm learning a lot from you, and as I said privately with
> Brendan, I've never seen so much macro in a code. I learned a lot from
> it.

Heh, yes, for that I must beg forgiveness. ;) The macros are rather
wild, but it seemed the best way to avoid a ton of cut/paste code
duplication.

-- 
Kees Cook
