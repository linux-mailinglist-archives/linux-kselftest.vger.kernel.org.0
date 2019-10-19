Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64920DDA83
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2019 20:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfJSSox (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Oct 2019 14:44:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36030 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfJSSox (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Oct 2019 14:44:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id j11so4482868plk.3
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Oct 2019 11:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r/P/9gjKXByrgJIBzuB+JRS7LPY4d6mkIypKNMQXW+I=;
        b=VLw5AbU9Xn9QzsKrFHjbQvRNU/aaJhuwP431NVd4Bf73bh5H4KNo0WS2gFoPTuz6k0
         6X6fCyT7PSdyBZc2EUTLU2k1gybGb0lHQ3DiM6fa68V/Ak1AayMzRb4uACLYlkxcl3RW
         /BmKRnDXGjyQM8A/O5VB2dpl6HE8wVj6wWM694ybmCrOh8+snK8E3VLIdNGfArGrmIXh
         erzhfOig7w1SNRNAcFkz/ciPK8kzLo300f486iOmF/iZwlgDNorPnLHKr1A7r/+uJnwm
         CLAkYKCaSEk6PwyPO4V8pvI2yQgWw8ALdBCwXLdqMH6nMOixg3M8gzYEgPmh/QacUZUs
         vS8Q==
X-Gm-Message-State: APjAAAXqqZ0My16lofjLbmrZD6yI/hYzvtLQC8nsY/oczPxCeWFiNyet
        jJx9RRFWFQiCy2+eZGiEJ5U=
X-Google-Smtp-Source: APXvYqxlaj6Cst28rVIVJBlR3dgB+Pn3YrsRH5vCgRMS2JoR/4eoQSEUYcPaU68LIbNfkNdmlUfLoA==
X-Received: by 2002:a17:902:b94b:: with SMTP id h11mr16288539pls.21.1571510692749;
        Sat, 19 Oct 2019 11:44:52 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r18sm12225876pfc.3.2019.10.19.11.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 11:44:51 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E216340256; Sat, 19 Oct 2019 18:44:50 +0000 (UTC)
Date:   Sat, 19 Oct 2019 18:44:50 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Knut Omang <knut.omang@oracle.com>, shuah <shuah@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: Plan for hybrid testing
Message-ID: <20191019184450.GH11244@42.do-not-panic.com>
References: <20191014104243.GD16384@42.do-not-panic.com>
 <9212e0fb58683df4781c52e6ad0abd8eb496a452.camel@oracle.com>
 <869165ea-f7d6-10cf-c74a-14a33b584938@kernel.org>
 <40941b19855134b5032379ab4b8023a3299bd06a.camel@oracle.com>
 <20191016130857.GJ16384@42.do-not-panic.com>
 <345333a20601355202749b1e7de23360dc93126c.camel@oracle.com>
 <20191018094738.GA11244@42.do-not-panic.com>
 <CAFd5g46GXwUGYNe==-JN9duRfArQDrgXgepGOGXsmO5SQYo3HQ@mail.gmail.com>
 <20191018192257.GF11244@42.do-not-panic.com>
 <CAFd5g459xmO+=QPhnnXVO8+dB_t1PViXxK-Fz6Zp+sp5suJZ2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g459xmO+=QPhnnXVO8+dB_t1PViXxK-Fz6Zp+sp5suJZ2w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 18, 2019 at 12:58:01PM -0700, Brendan Higgins wrote:
> On Fri, Oct 18, 2019 at 12:23 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > Do we really want to focus on this point now? I think it's better to
> > > start off with something simple and evolve it.
> >
> > Addressing it can help simplfiy things long term, as perhaps we really
> > don't need something like generic netlink to orchestrate.
> 
> Sure, I just think it sounds like we don't need it for a lot of
> things, so if something significantly simpler exists, maybe we should
> just start there. But yeah, starting that discussion here and now
> doesn't hurt as long as we don't lose sight of something concrete in
> the short term.
> 
> Cool, sounds like we are on the same page then.

Indeed.

  Luis
