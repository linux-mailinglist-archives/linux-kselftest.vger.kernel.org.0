Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8261AEA15
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 07:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgDRFsz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Apr 2020 01:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgDRFsz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Apr 2020 01:48:55 -0400
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C33520732;
        Sat, 18 Apr 2020 05:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587188934;
        bh=dOdY+J5C981RrgT/SYvhJjQp0bshmGYrWdQLG/0vgXg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1Vn3JEkGaf3JjLsfg8rnpTqOUCoj5vbJMIctCZIV7AFV35Qdl3isia7lZNj4NaDZg
         0qZoj8uSeR+qxD8/5wxHcOQi5lAfyE95m0zM5pjo4A+FyKHyC95uNYyh+ORBsCXa3p
         MLdkTS+f+Fn9YRdzbFBeRsfCMeV7FutDQXQ5XHpI=
Received: by mail-vk1-f182.google.com with SMTP id g129so1146125vkh.9;
        Fri, 17 Apr 2020 22:48:54 -0700 (PDT)
X-Gm-Message-State: AGi0PuZazpA0RrKMRQHWBvBKlNRlcfEBbrT8gODxNODNjRo1yhkpO21F
        XTbfRrGoSdD+a5HL0uMEzlDTKBqw0vBWEP6bc2g=
X-Google-Smtp-Source: APiQypKsJnilGzBuRttAT91iKdk55UyLniT28c6HqO6aqA1obYO1PSs79HwC74xzWdd8HfuznSIcSn9JVXOCPQw09n4=
X-Received: by 2002:ac5:c3ce:: with SMTP id t14mr5399450vkk.60.1587188933522;
 Fri, 17 Apr 2020 22:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <1587187200-13109-1-git-send-email-yangtiezhu@loongson.cn>
 <1587187200-13109-3-git-send-email-yangtiezhu@loongson.cn> <20200418054519.GX11244@42.do-not-panic.com>
In-Reply-To: <20200418054519.GX11244@42.do-not-panic.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Fri, 17 Apr 2020 23:48:46 -0600
X-Gmail-Original-Message-ID: <CAB=NE6XD7XCmsTAg3+mw=b8WZnKJiwha5t4DBJFt5w+b_DsNkg@mail.gmail.com>
Message-ID: <CAB=NE6XD7XCmsTAg3+mw=b8WZnKJiwha5t4DBJFt5w+b_DsNkg@mail.gmail.com>
Subject: Re: [PATCH 3/4] kmod: Return directly if module name is empty in request_module()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 17, 2020 at 11:45 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Sat, Apr 18, 2020 at 01:19:59PM +0800, Tiezhu Yang wrote:
> > If module name is empty, it is better to return directly at the beginning
> > of request_module() without doing the needless call_modprobe() operation.
> >
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  kernel/kmod.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/kmod.c b/kernel/kmod.c
> > index 3cd075c..5851444 100644
> > --- a/kernel/kmod.c
> > +++ b/kernel/kmod.c
> > @@ -28,6 +28,8 @@
> >
> >  #include <trace/events/module.h>
> >
> > +#define MODULE_NOT_FOUND 256
> > +
> >  /*
> >   * Assuming:
> >   *
> > @@ -144,6 +146,9 @@ int __request_module(bool wait, const char *fmt, ...)
> >       if (ret >= MODULE_NAME_LEN)
> >               return -ENAMETOOLONG;
> >
> > +     if (strlen(module_name) == 0)
> > +             return MODULE_NOT_FOUND;
>
> I'd rather we just use something standard like -EINVAL.
> What do we return if its not found? Then use that value.

Also, are we testing for this condition yet? If not can we add one?
