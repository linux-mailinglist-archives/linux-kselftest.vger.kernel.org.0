Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D30FEABCD
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2019 09:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfJaIvg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Oct 2019 04:51:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46591 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfJaIvg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Oct 2019 04:51:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id f19so3581833pgn.13
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2019 01:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ME3Ltsu28xY9FZ7FPzX/YEVGfUZBxiS82t6VZQlhtiQ=;
        b=tl8Hsb22yrpTp+aE+3bIye9K5uVkV4y8FxN7YPrbBnmCT+YfJ3AUC2cwuSlDicKCxu
         UDml6vdi71pvZSXoi5HfkSGyUpeBN4QTT/sBgk0cSnY1PpsPs2ib3+1pVot3g7+9VdSY
         Kod9TenRE541RA9FzpBG+XBTjSYvG94TZduK7Hu13F3Bl+UKIr5aV3qtKD+GxX6vJf/q
         kb5nkicEebV649v+z46H29loCCin+lqFILBZ6B2Vx0JktUqZk2IJNdSWiiDaKxt7KTlg
         7bvpBPipwLfBqCAkflDGM7f0Ywys3KYYrZ742cfFgzEYGZ1AvWz5xEbH8SlVWB4udvfW
         4ZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ME3Ltsu28xY9FZ7FPzX/YEVGfUZBxiS82t6VZQlhtiQ=;
        b=n4ZA8M4c9n1l4pqOUH2Wn6akpiVRz+fGZRH6P+a4R3BDy8pvkrpAcUE+xkVEBKJvi3
         1x1QezkLwqENAG4/j1x7mAV4G/JspGDIOAepben4eTZavSugrkez4PoiWqXtPc6GSwQ0
         3bbHR79JbpwIRNW4Ct5IwR+Y0QOfuHYsf7GF+OC1xPRQ2dzK89tb2gJm/AsmM0Eu2Hl+
         bJyAA/VXGXPGUppHRNBfX3Ziu3IGANI1iwKHZJUsC3XreuDbSO5KLUnWhiymVkbccH0l
         A+Ru9nXlTHwJkuURHMAJe3zG54Zr1d8pLlLg97gIIr6t93se6yTLEqAY3AHcZL0Tkhh8
         LG7Q==
X-Gm-Message-State: APjAAAVIQDCZqAy5YGVAB2jiAjLpmY6I9ZobjcA2LPI7dhcnsbpxLl1N
        OZWVgGfXB3kiBEUnd+VYs4y0yA==
X-Google-Smtp-Source: APXvYqzoFaeX5o55VyC/K9bIE1N04gxEQNyvlwlXslZU/q02UqRsAEQnjnAeFwmJW8iQtYVE6Fw2kA==
X-Received: by 2002:a17:90a:3651:: with SMTP id s75mr5830500pjb.30.1572511894912;
        Thu, 31 Oct 2019 01:51:34 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id m123sm2657852pfb.133.2019.10.31.01.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 01:51:34 -0700 (PDT)
Date:   Thu, 31 Oct 2019 01:51:29 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Joe Perches <joe@perches.com>
Cc:     shuah <shuah@kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for
 the 'list' doubly linked list
Message-ID: <20191031085129.GA217570@google.com>
References: <20191024224631.118656-1-davidgow@google.com>
 <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
 <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
 <20191030104217.GA18421@kadam>
 <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
 <CAFd5g47OZ8x9=etJUj4Sgsw38VQb0j=omOUsubc7+pb2rJi0bQ@mail.gmail.com>
 <fad58e4f48237894de0d511adf1d663a42a2eee7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fad58e4f48237894de0d511adf1d663a42a2eee7.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 30, 2019 at 10:18:44AM -0700, Joe Perches wrote:
> On Wed, 2019-10-30 at 09:35 -0700, Brendan Higgins wrote:
> > Agreed. I can see the point of not wanting to write an exception into
> > checkpatch for every exception of it's general rules; however, it
> > would be nice if there was a way to maybe have a special comment or
> > something that could turn off a checkpatch error. That way, a
> > checkpatch error/warning always means some action should be taken, and
> > if a rule is being ignored, there is always documentation as to why.
> 
> That couldn't work when a comment which may exist
> in a file is out of scope of the patch context.

Sorry, I don't understand exactly what you mean. Can you elaborate?

If it wasn't obvious, I am not proposing that David should make the
changed I described now for this patch. I know what I proposed would not
be an easy thing to implement, especially given the opinions that it is
likely to solicit.

Nevertheless, in the long term, I have seen other projects allow a
comment that would cause style checkers or static analysis tools to
ignore the designated line. Maybe we could implement this as a line
comment that suppresses a checkpatch warning of a certain kind on the
line. So here, we might have something like:

static void list_test_list_for_each_prev(struct kunit *test) /* checkpatch: disable=for-each-format */

We would also probably want to require an explanation either in the
checkpatch comment or the line above, but then you have to worry about
that comment not being included in a patch that only updates the
offending line.

Anyway, it's just an idea. I know that we don't currently assume that
all checkpatch errors/warnings require some action, but it might be cool
if they did.

Cheers
