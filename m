Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E87DA10C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 00:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393037AbfJPWSn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 18:18:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38281 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbfJPWSm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 18:18:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id w3so71036pgt.5
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2019 15:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4BRWgTZya1nZDIoCje09OOB04mUi4yD3LZXSiPZRXc=;
        b=gQtiCWhXwZAPJNP14QljXpS7zSwRJyVTX/X/FO1M54FRZ8xESw54N3Uvodm1xbtQyx
         V80v1dBIwue6ycKJ5V8zc5nXOIQoSlMO+79aipdr2gcLdiyURDB934HJYAjGCvmM3NBL
         LDXj9kWXo2Y1AtTZITT76sXRQdpWb8tSoV453/yaIFE+M0XfCJ20JYoNoKbRVPRrwSFz
         /jenHs/60b1EQKnIWQ4C/SDCNWeivAmjx1kn/i3xAcXu4hOnk3qIcyeWXo/aM5N7+rh+
         abiMIZ4cSPzXujovV7eWj7eOBZbS3RlWiDUwI5pbYlQtKWVcik88bWbNEaTy5LkVoC+z
         3HAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4BRWgTZya1nZDIoCje09OOB04mUi4yD3LZXSiPZRXc=;
        b=WxAan1jIs0pq2Dih/oa5BFmM3IeeIHa8TrjK8TJODGS+DhBllYZ6gzTqirDmTqZyZX
         e5aNtfatzdIrJJ/cIh2+J/z5zJ6aeRVIjriZn2IGeKC5qrqETpMh1e75kav9EnvBoSJy
         75z+NAfevVEl7I6dGJKMDRKjRtXCLX4Mq464CVi5CIOCzHXY8FxKZHIcioyoKsYrUjjY
         qeUK7ImMXPJPyRPq6YrBYAYnzBWSN/cNx4oGyALIRviA0MmMO1xo3wqsSqNed4AJcJnV
         9jCW2Yy4kM+QklC5N8iBbWx+e35Je1IWYB5F8w0uLlAQqFO2umHzAEGbyOxSrfTiU1pP
         yCtA==
X-Gm-Message-State: APjAAAXImbdpvTND2cI5bnE2cILHvcoYqaNyyo4dlRzoN14PV5I0c0YM
        iv1Ejkmge2O1NYFN1QIYwE1vM0JZ2KCBllP4mCC88g==
X-Google-Smtp-Source: APXvYqyahxLgd4vSz3O0pDjBLSw7MCMeziOfMgl4hhj7MXL2y37z1NEzKj2mRZLC5Wqswd5/mvgYQ5LzESo+aQiGFs4=
X-Received: by 2002:a65:6091:: with SMTP id t17mr460943pgu.159.1571264321017;
 Wed, 16 Oct 2019 15:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191010023931.230475-1-yzaikin@google.com> <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com> <20191011131902.GC16225@mit.edu>
In-Reply-To: <20191011131902.GC16225@mit.edu>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 16 Oct 2019 15:18:29 -0700
Message-ID: <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Iurii Zaikin <yzaikin@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 11, 2019 at 6:19 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Oct 11, 2019 at 03:05:43AM -0700, Brendan Higgins wrote:
> > That's an interesting point. Should we try to establish a pattern for
> > how tests should be configured? My *very long term* goal is to
> > eventually have tests able to be built and run without any kind of
> > kernel of any kind, but I don't think that having a single config for
> > all tests in a subsystem gets in the way of that, so I don't think I
> > have a strong preference in terms of what I want to do.
> >
> > Nevertheless, I think establishing patterns is good. Do we want to try
> > to follow Ted's preference as a general rule from now on?
>
> As I suggested on another thread (started on kunit-dev, but Brendan
> has cc'ed in linux-kselftest), I think it might really work well if

For reference, that thread can be found here:
https://lore.kernel.org/linux-kselftest/CAFd5g46+OMmP8mYsH8vcpMpdOeYryp=1Lsab4Hy6pAhWjX5-4Q@mail.gmail.com/

> "make kunit" runs all of the kunit tests automatically.  As we add
> more kunit tests, finding all of the CONFIG options so they can be
> added to the kunitconfig file is going to be hard, so kunit.py really
> needs an --allconfig which does this automatically.
>
> Along these lines, perhaps we should state that as a general rule the
> CONFIG option for Kunit tests should only depend on KUINIT, and use
> select to enable other dependencies.  i.e., for the ext4 kunit tests,

I support this. Although I think that we will eventually find
ourselves in a position where it is not possible to satisfy all
dependencies for all KUnit tests, this may get us far enough along
that the problem may be easier, or may work well enough for a long
time. It's hard to say. In anycase, I think it makes sense for a unit
test config to select its dependencies. I also think it makes sense to
make each subsystem have a master config for all KUnit tests.

> it should look like this:
>
> config EXT4_KUNIT_TESTS
>         bool "KUnit test for ext4 inode"
>         select EXT4_FS
>         depends on KUNIT
> ...
>
> In the current patch, we use "depends on EXT4_FS", which meant that
> when I first added "CONFIG_EXT4_KUNIT_TESTS=y" to the kunitconfig
> file, I got the following confusing error message:
>
> % ./tools/testing/kunit/kunit.py  run
> Regenerating .config ...
> ERROR:root:Provided Kconfig is not contained in validated .config!
>
> Using "select EXT4_FS" makes it much easier to enable the ext4 kunit
> tests in kunitconfig.  At the moment requiring that we two lines to
> kunitconfig to enable ext4 isn't _that_ bad:
>
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_KUNIT_TESTS=y
>
> but over time, if many subsystems start adding unit tests, the
> overhead of managing the kunitconfig file is going to get unwieldy.

Agreed.

> Hence my suggestion that we just make all Kunit CONFIG options depend
> only on CONFIG_KUNIT.

That makes sense for now. I think we will eventually reach a point
where that may not be enough or that we may have KUnit configs which
are mutually exclusive; nevertheless, I imagine that this may be a
good short term solution for a decent amount of time.

Shuah suggested an alternative in the form of config fragments. I
think Ted's solution is going to be easier to maintain in the short
term. Any other thoughts?

[...]

Cheers
