Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1D01AEA77
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 09:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgDRHTI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Apr 2020 03:19:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33239 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgDRHTI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Apr 2020 03:19:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id c138so2235284pfc.0;
        Sat, 18 Apr 2020 00:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2tfGw4d3u9g+UFPVZL7i7ytHNA18syakdIUbMPCw9fk=;
        b=HzHlBUoziKV7IAShIZZsEWav/DMYjBrKBtYchLX3Fo0TPZZEKF9Ge4VSCqgOOlEXjU
         WDkV5DUMaepFrdsePtQbU47Z7ua3RG51ENgwMh8v96+2zIs83jD4BkKIp5HW6n9VGC9c
         LllGG18g7qouxPZGNaF4dPVhDFydaBJOTYkWA2mzjOC7GGbR83BYr9BpCe7r7dqZctdS
         oysofCc6KqIg0LoJgVUjd0pojQRGrPXd0uY3jXWJuuMyCE0dizxaGKl69dClvatMCqCq
         tZpR37qpWdffhQX0aD4NEIGHgsK6DYIJAwJBljmlUYnN6mPARR8H+tFXjAOI2ew/qlvw
         gu7g==
X-Gm-Message-State: AGi0PuZlh/9MPH2C5PIDa66Y3kvJdznbZtnhUImAaYIye1RqhCOF6u60
        0SFDxgfESWCZfw6mXZGNZqA=
X-Google-Smtp-Source: APiQypI+72yk06Cjr8OXYOo8eGUbph5RuNlA8q6scYKXCohp1d6WX75FGadX+ZCWl4kUqBub0DIRGA==
X-Received: by 2002:a63:585c:: with SMTP id i28mr6721801pgm.363.1587194347313;
        Sat, 18 Apr 2020 00:19:07 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 192sm3346445pfu.182.2020.04.18.00.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 00:19:06 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 68C5B4028E; Sat, 18 Apr 2020 07:19:05 +0000 (UTC)
Date:   Sat, 18 Apr 2020 07:19:05 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>, Jessica Yu <jeyu@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 3/4] kmod: Return directly if module name is empty in
 request_module()
Message-ID: <20200418071905.GE11244@42.do-not-panic.com>
References: <1587187200-13109-1-git-send-email-yangtiezhu@loongson.cn>
 <1587187200-13109-3-git-send-email-yangtiezhu@loongson.cn>
 <20200418054519.GX11244@42.do-not-panic.com>
 <CAB=NE6XD7XCmsTAg3+mw=b8WZnKJiwha5t4DBJFt5w+b_DsNkg@mail.gmail.com>
 <b9c6e6e6-571a-b957-755f-72f2b0f538c5@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9c6e6e6-571a-b957-755f-72f2b0f538c5@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Apr 18, 2020 at 01:58:45PM +0800, Tiezhu Yang wrote:
> On 04/18/2020 01:48 PM, Luis Chamberlain wrote:
> > On Fri, Apr 17, 2020 at 11:45 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > On Sat, Apr 18, 2020 at 01:19:59PM +0800, Tiezhu Yang wrote:
> > > > If module name is empty, it is better to return directly at the beginning
> > > > of request_module() without doing the needless call_modprobe() operation.
> > > > 
> > > > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > > > ---
> > > >   kernel/kmod.c | 5 +++++
> > > >   1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/kernel/kmod.c b/kernel/kmod.c
> > > > index 3cd075c..5851444 100644
> > > > --- a/kernel/kmod.c
> > > > +++ b/kernel/kmod.c
> > > > @@ -28,6 +28,8 @@
> > > > 
> > > >   #include <trace/events/module.h>
> > > > 
> > > > +#define MODULE_NOT_FOUND 256
> > > > +
> > > >   /*
> > > >    * Assuming:
> > > >    *
> > > > @@ -144,6 +146,9 @@ int __request_module(bool wait, const char *fmt, ...)
> > > >        if (ret >= MODULE_NAME_LEN)
> > > >                return -ENAMETOOLONG;
> > > > 
> > > > +     if (strlen(module_name) == 0)
> > > > +             return MODULE_NOT_FOUND;
> > > I'd rather we just use something standard like -EINVAL.
> > > What do we return if its not found? Then use that value.
> > Also, are we testing for this condition yet? If not can we add one?
> 
> Yes, kmod_test_0001_driver() in tools/testing/selftests/kmod/kmod.sh tests
> this case and expects result MODULE_NOT_FOUND which is 256.

OK I see now I had put:

errno_name_to_val()                                                             
{                                                                               
        case "$1" in                                                            
	# kmod calls modprobe and upon of a module not found                    
	# modprobe returns just 1... However in the
	# kernel we *sometimes* see 256... 
	MODULE_NOT_FOUND)                                                       
		echo 256;;

I found that through testing, however there was nothing set in stone,
nothing documented. While you are at it, can you find the places where
this is returned in the kernel code? We should clear this up and
se things straight. We cannot change what we gave userspace already
though.

  Luis
