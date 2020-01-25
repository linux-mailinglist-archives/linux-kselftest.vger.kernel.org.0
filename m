Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7BB7149237
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Jan 2020 01:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgAYACn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 19:02:43 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:37126 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbgAYACm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 19:02:42 -0500
Received: by mail-pl1-f181.google.com with SMTP id c23so1433513plz.4
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2020 16:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ynnd2SGOMXK9FL1OzGl6AxrSQz4LtuhsqKDnn7ScKAo=;
        b=wS2WUDV/7szOKx4WVC47xljWaVANkCKfZcuv4uHhbjYz8UVMGzJv/WtL/ZUOKDQdBT
         eYKLwXmid6jl1YRudXdCBMuqnvIseNtqbAjpFg1AAUB32FlW/sheZ1UyRwpm2Ae32/N0
         REx3X4Shn79Y4OBsMWBOIC6Ci9/Zwn9BYqS1hkbN86VMoVePiyaNzCteKN1JK0MWbm7u
         WkXiyWWM0y4updTQjFCJv2PU0aqyfDUWFH3MScocS5IBubO89Gzjl7AlpVBYiSN+qJyL
         8V87+5EtGpLiSJuC9XOx18ttmdsqMY/at42xiNqJ04q7X9QND3wLHDohtF8JFIZ1jQcK
         kvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ynnd2SGOMXK9FL1OzGl6AxrSQz4LtuhsqKDnn7ScKAo=;
        b=FtyBbnWtq9L+3qr2jPWFsuNv6pI3PsKnkvmBxZP7hAdijbLnehoh0LpqnmGvqhePd6
         yJ4y/Jr/1WAXgAsO55b2gLXb45ugrrWmtuCxRD7JguY4TDjElcCr+zSdOE5MQGev5BKa
         zeIrh5ddyELx/Oof+/0c+bXj5g/We85/J25PXtQXvJ/vhes8HKQuYETm4z9rwpRMxZ2C
         D3xsp+ahNF5qHIXJKpni/FEHedOQWJjFYOo7MnmZGps1Nz+HdSkxTJc5+DHJgMHwFdK+
         fgq8v1NoSHs4zdJ8P4/BsV9TiqntkGHWkw1oNdkrI3LZORI5tM4U0KCuxX/3ZQo6+Pqs
         k5Kg==
X-Gm-Message-State: APjAAAUfr8n9gWkgIGIW5y27P/wwp08t7e9G3hwss5bRbJ0cl62lGNLL
        iF3UwUHXaX7PTo9BG5U1apK+CRjgdU2TgCJs1CgBGQ==
X-Google-Smtp-Source: APXvYqyXmULqKveIYsTuaC/0YteujlFex6MeZFhH/+/P6TgnbeZ8qAKVrqmlm1erknjpKVF2xDqMtmfOVWrRbPLVHiU=
X-Received: by 2002:a17:90a:c390:: with SMTP id h16mr2010910pjt.131.1579910561819;
 Fri, 24 Jan 2020 16:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20200124194507.34121-1-davidgow@google.com> <CAFd5g46Jym_HX+QmX8ffVYfL1KATNjs9U6sR1Qv9SoVLx5GKDg@mail.gmail.com>
 <CABVgOSnVLyOAYMi2eFaOXtm96SdmrO8hmJ4f2gKbDJ7wS_8d5w@mail.gmail.com>
In-Reply-To: <CABVgOSnVLyOAYMi2eFaOXtm96SdmrO8hmJ4f2gKbDJ7wS_8d5w@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 24 Jan 2020 16:02:30 -0800
Message-ID: <CAFd5g45x3A2SdbUtZfGRGmpdEoe0BYsofRogyCXigR+xT_Jy=w@mail.gmail.com>
Subject: Re: [PATCH] Fix linked-list KUnit test when run multiple times
To:     David Gow <davidgow@google.com>
Cc:     shuah <shuah@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 24, 2020 at 3:13 PM David Gow <davidgow@google.com> wrote:
>
> On Fri, Jan 24, 2020 at 2:01 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> > Oh good, I am glad we are getting rid of those static variables. (I
> > thought we already dropped those - whoops.) I think this drops this
> > last of them, can you confirm David?
>
> Yeah, this is the last of them.
>
> I vaguely recall a suggestion that it may be worth testing that the
> LIST_HEAD() macro works with static, but as mentioned in the
> description, the for_each_entry_* tests probably aren't the best place
> to do that anyway...

Ah, I think I missed that. Makes sense.
