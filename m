Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D3C28FD7D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Oct 2020 06:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389428AbgJPEyA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Oct 2020 00:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgJPEyA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Oct 2020 00:54:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3366FC061755
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 21:54:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so1419956wmj.5
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 21:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xCFDF3DVHCNWznTDbb+upzGwWB3UE1kVzGqTIWmuE7k=;
        b=ilDz18AaX4piO95y+EymvytVoZn22Yrkc4WMWyNmte2mV/3tkSSWtLzg4+JOtgt+Ad
         /eC/wqQ8sM36SOR6D+TuIPqRrcrDX+/H2ERq5OvF6QX3qgwKnYGY+cQz1/xFJTUCa4d2
         zGvQwGkQer1BYo+nLmJN34CTzkQ2mk9paVwcFV/ywJXSgItLplDOV8++cbDDFw75ahqG
         eZWLpVVh7BhHtK0v4TIsvW1BsL9JycSi6izowAWVeoUzOrafXEAcDD5hS+Eulh2YFBT8
         2XXKXW9Uu/hQtjmjj5heWUA48Nrjy3EdBxePOtgK2vnBrY2t8X010WYAmEsWKTdalUgU
         Hpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xCFDF3DVHCNWznTDbb+upzGwWB3UE1kVzGqTIWmuE7k=;
        b=AprRrZRvbzyYNCUhLr1CqJK/9lLSWvvvmHrfvEpVRscprhnoVYQtr3nlb9HLNau99H
         vdtoiOP0HRzl9GTHh+6lUhMe+c/Zf7ylsHir3CIGXEyG6RuoTWE47VD6emt3VqGG9XxN
         IYDcEhXy30qpO7Y1HHxMPmeFTFj/yaCXKXKg98xqGOtBhejWFGykUuUyB67rqT9eal7H
         iWn2CWYnRYuFTuLsFhZi6Od493M1Vxu/MsbifwynnVjSKudVb1LRsUYWO9hrLRuVYGvf
         NyrG6WFWLy93djcXAkZR3BJjh+89YF9orRS12woJR0y9xrg++PZ+/32Bjb8wLjxArq6E
         iTOA==
X-Gm-Message-State: AOAM531rLpOZDYEAI9RX0w0wdM4Kz/NFtWTMr8GvTPjHh9iI1pL6NsLH
        hehHdjNNwCnoyKMTIHtKeMte83wZqI2yz5FtLVntlA==
X-Google-Smtp-Source: ABdhPJz7VXEyP5Lf+R1mrIYqICbW1xv6n+Tyaj6qSAi22wh2Y8VPBAOq/x+LEd7pX0TbZTs0M7bTmWCxeTFrTd9g/r8=
X-Received: by 2002:a05:600c:608:: with SMTP id o8mr1770298wmm.86.1602824038182;
 Thu, 15 Oct 2020 21:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201015184416.38999-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201015184416.38999-1-andriy.shevchenko@linux.intel.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 16 Oct 2020 12:53:46 +0800
Message-ID: <CABVgOSkKhpObfYPn2vYTcTdjDfmTyksWzUyRSuSShbkPCWLorA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] lib/list_kunit: Follow new file name convention
 for KUnit tests
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 16, 2020 at 2:44 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Follow new file name convention for the KUnit tests.
> Since we have lib/*test*.c in a few variations,
> use 'kunit' suffix to distinguish usual test cases
> with KUnit-based ones.
>
> Cc: David Gow <davidgow@google.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks! You've saved me the work of doing this myself. :-)

Reviewed-by: David Gow <davidgow@google.com>
