Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D369FDC537
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 14:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633905AbfJRMnt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 08:43:49 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36655 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633904AbfJRMnt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 08:43:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id y22so3836557pfr.3
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2019 05:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QQzOsGAK4+NWRE1MfYzxWb4i0nQItqLfWq1omSmlY+M=;
        b=S4m2zamdEsmGWbOSp9a/obpn8N7A1A6sl+wRozGOI2P0jpnCWVx2CzSrz91lke5gKK
         6euGkvPUbS21lEoX4mZ1qQvvBY3lq9upUE+3rmSKji418eB+kUvtG7mZZCaiJLwRrOkg
         eOPu+NbeKxg7Y09nMnPLwmF36Bd2igrPeFZ7Lw1PFooBlgAXSj6mhhKdoAO/ieENuMU2
         W1kzpFeGPzRBil2qjVOx/x3qEvkqe8aMAT5teOycOg4Iel79fk6obf2QxMMTl8hNxU4x
         Iw6BxpIxmo/+Kp0DbFReDsOxZlvFYXerEn6DdSuYHZbIlzvcPmitQLsvWE4Gp49xjczl
         lRFA==
X-Gm-Message-State: APjAAAUR+x4r/isohrse1LS1ViJplVZJ1iQtwLNmUnvEXHH1mGBwAV4z
        lHD/eDCC2zpw7olvEy3FzNU=
X-Google-Smtp-Source: APXvYqw0l2AIHK35ndyzROwxrQboKcI8M2I/H805JYZoPs0fQhFkYoYOvMsYRq4xhzxcX0npnbinXw==
X-Received: by 2002:a63:6581:: with SMTP id z123mr10112023pgb.367.1571402628511;
        Fri, 18 Oct 2019 05:43:48 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v2sm5673459pgf.39.2019.10.18.05.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:43:47 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 8EF9D4042C; Fri, 18 Oct 2019 12:43:46 +0000 (UTC)
Date:   Fri, 18 Oct 2019 12:43:46 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Theodore Ts'o <theodore.tso@gmail.com>, shuah <shuah@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, David Gow <davidgow@google.com>
Subject: Re: kunit.py should default to --build_dir=.kunit
Message-ID: <20191018124346.GE11244@42.do-not-panic.com>
References: <c99604e5-2ea4-4075-9a39-470104298368@googlegroups.com>
 <CAFd5g46+OMmP8mYsH8vcpMpdOeYryp=1Lsab4Hy6pAhWjX5-4Q@mail.gmail.com>
 <551223d0-7712-41df-90f2-3ca3da301435@googlegroups.com>
 <CAFd5g44EE3A3kXOFQD5vMOXZoJ_PzD=h9dac+KJmgxeXUycJGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g44EE3A3kXOFQD5vMOXZoJ_PzD=h9dac+KJmgxeXUycJGQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 16, 2019 at 02:02:52PM -0700, Brendan Higgins wrote:
> Shuah's solution was just to use CONFIG fragments in the meantime
> similar to what kselftest already does. I was leaning in that
> direction since kselftest already does that and we know that it works.
> 
> Shuah, Luis, does this still match what you have been thinking?

I personally never use the selftest full config thing myself, however I
do use subcomponent selftests configs as hints to edit my .config to add
what I need and then run 'make menuconfig', in hopes that that leaves a
.config with all that is needed.

So indeed, I believe ethis works well for now, and it works for me.

I've hinted elsewhere that there is a difference between what kernel
features you have enabled Vs what components are needed / should we
built to test the current target kernel .config. And even then, what we
test in userspace is in my view different than what should be configured
in the kernel. To scale this I think a respective .config for userspace
and respective symbols for testing may be in order, this way the
userspace tests can only be visible say if you enabled certain features
in your kernel.  How this gets exposed, etc, is a separate question,
however I think this can be addressed later, and I believe Knut will
likely be dealing with it during the KTF merge to kunit work as
currently it addresses this via generic netlink, and we want something
simple to start off with.

   Luis
