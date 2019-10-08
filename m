Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C29DD0090
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 20:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfJHSPR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 14:15:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41891 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfJHSPR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 14:15:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id t3so4865299pga.8
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2019 11:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LZNljN/AkdZhmtnZA8uLQ3poagOBASW7ZSNDsz+/4TI=;
        b=kwoc3wm2rR3CIvUhtdBdlhmWm/YevOQgX/fD++B9Iejzidcl2fLkhoXtCuWqKWjo+S
         etvhAve6tI2G+/U4buEu4yBSn3NIaEdAQ6/qvHF6ACUEeg/y29D4conmgY4TJt7WSRN4
         PInLB3D9DEiqS2yAkJkKAn4CjlIW7sxlBqDBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LZNljN/AkdZhmtnZA8uLQ3poagOBASW7ZSNDsz+/4TI=;
        b=FBISvFsMmhD5IGH05j4LlyWvzDayhupYcoou3VA0ckPpGnkO346HQBZJPWOHeReYmP
         nvk45JwdlLlBzN4xAuSEY2XYbcGUvDDhpixxBfpfZGxlt0x4fUYmpVWu6KUW4P8FrYtT
         IMB0zV/s62RmrTt5m7dSDkEX4G+BG1Hm5gpTOCujkWDaYEeFOLe/DeeHaY4IEE/OywHE
         7jePLY+fw/PgXPzoLv5eKbuZGiu1sLNx7rpkhaC/kliJDoij0YQG//7r7Px+CqZRdkyF
         Je2u4vTo7e6bUUvqH0kAtIi7raNTLBQ/hgAY4wZKBFfuRZJWbn73CKD7/6zmy9riMqtA
         YuzA==
X-Gm-Message-State: APjAAAWROlDVS+3VULOktIcxGyETroYoH3wQnx04vQ59WLBpohV07mB2
        f+JVfZC5SlwgOR8WOnFu1PPN0g==
X-Google-Smtp-Source: APXvYqzYjnU+6t/eIHObkAKBvtTJwWuCd0pBBXRV6LW14MPtb06wVjGqmQ3hz203J6/CQf9wDdhylQ==
X-Received: by 2002:a17:90a:1150:: with SMTP id d16mr7594707pje.2.1570558516852;
        Tue, 08 Oct 2019 11:15:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p189sm20549336pfp.163.2019.10.08.11.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 11:15:15 -0700 (PDT)
Date:   Tue, 8 Oct 2019 11:15:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>, shuah@kernel.org,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/list-test: add a test for the 'list' doubly linked
 list
Message-ID: <201910081110.C2C582408F@keescook>
References: <20191007213633.92565-1-davidgow@google.com>
 <20191008174837.GA155928@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008174837.GA155928@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 08, 2019 at 10:48:37AM -0700, Brendan Higgins wrote:
> On Mon, Oct 07, 2019 at 02:36:33PM -0700, David Gow wrote:
> > This change adds a KUnit test for the kernel doubly linked list
> > implementation in include/linux/list.h
> > 
> > Note that, at present, it only tests the list_ types (not the
> > singly-linked hlist_), and does not yet test all of the
> > list_for_each_entry* macros (and some related things like
> > list_prepare_entry).
> > 
> > This change depends on KUnit, so should be merged via the 'test' branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=test
> > 
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >  lib/Kconfig.debug |  12 +
> >  lib/Makefile      |   3 +
> >  lib/list-test.c   | 711 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 726 insertions(+)
> >  create mode 100644 lib/list-test.c
> 
> Also, I think it might be good to make a MAINTAINERs entry for this
> test.

Another thought, though maybe this is already covered and I missed the
"best practices" notes on naming conventions.

As the "one-off" tests are already named "foo_test.c" it seems like
KUnit tests should be named distinctly. Should this be lib/kunit-list.c,
lib/list-kunit.c, or something else?

For internal naming of structs and tests, should things be
named "kunit_foo"? Examples here would be kunit_list_struct and
kunit_list_test_...

When testing other stuff, should only exposed interfaces be tested?
Many things have their API exposed via registration of a static structure
of function pointers to static functions. What's the proposed best way
to get at that? Should the KUnit tests is IN the .c file that declares
all the static functions?

-- 
Kees Cook
