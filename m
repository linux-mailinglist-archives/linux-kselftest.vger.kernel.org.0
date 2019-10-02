Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7733EC93D6
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2019 23:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfJBVx5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Oct 2019 17:53:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35696 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfJBVx5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Oct 2019 17:53:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so366108pfw.2
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2019 14:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=78WP2Dv09wS4CrHxcmN8PyVj+nafJCWKcIC/S/IibVI=;
        b=bcwvlWqz3iUPmd8kNAVv0WvcWcbB7QMcgTJZJKu+faizIPNeVrI8ZtuN8AhRbe2RyC
         bZk7+VPGJ3fhFkRHSA2a9Ev6in/u1igyQSdB8mxyXjKPoZg7DYw+a1Gnm+OfD1Wox4PI
         qtD/vFlmd3B4C27b21EA6KCSNEcyF1HZdrE4dgtdf/MIqf3BsJcchtsZwOBguXzSvcqE
         r3ql6llgnORLlj93XIVfK0DHUAmdCkakm2VyN+LKmhrhrLAHH6Ij1r6TDgTSNow/Mr9B
         jZbsuOeIGo/97J4hXBgCqz3t1bnRebyo5cutlvekfzW4hhKpynSzd/uN0uRdNyiHoh+f
         8G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=78WP2Dv09wS4CrHxcmN8PyVj+nafJCWKcIC/S/IibVI=;
        b=h0xi403TTNtyEmJo13veHzVVihP8hhOKw+olXnGdmRqBGPOpuFP1CwnK/DbBePhDk2
         fwqXDgCvbcp++/tnFMgaJkJbNaAnSzx/ZygAWpjKedidFEh7ZW5px6GL47INibimBZrw
         R9YubCdb7/qZ3fSf6pvTPtc8JeWyJiuBtK5W6j0oeWbGl3RT5r68hgvJlAU/Z7OwrHww
         mh4yG3uTNx6KfdxrQXD7WY5Cg60CKOtxlRm5EP6yGqHM8Ya/Blm5C3xVmaQfCGoGQG4e
         uCSnjCfmmHFQmFoJ47sZXQ87lp1/7ZEjvoevwR7Oo4nv7Luld8uE1BMHegUnxfosRUis
         QUfg==
X-Gm-Message-State: APjAAAXPikgFIi03eLt6gB26wqcWPprVVWPRPWWLkn3GC9Ovyaq3Zifj
        QXy4mM1FIX6mHPR0imZGB/QA0A==
X-Google-Smtp-Source: APXvYqxEUtdPca07fpB2lWdw+zEZyBIPte2vS8Yce3J7WM+kE1MxZf06cCoBmJxshbZErfyjaLkGwQ==
X-Received: by 2002:a63:7b16:: with SMTP id w22mr6032156pgc.328.1570053236171;
        Wed, 02 Oct 2019 14:53:56 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id l189sm334998pgd.46.2019.10.02.14.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 14:53:55 -0700 (PDT)
Date:   Wed, 2 Oct 2019 14:53:51 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     helpdesk@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Subject: Bugzilla Component for KUnit?
Message-ID: <20191002215351.GA177672@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

I am thinking about requesting a Bugzilla component for my kernel
project KUnit. I am not sure if this is the right place for it.  Some
background on KUnit: We are working on adding unit testing for the Linux
kernel[1][2]. We have our initial patchset that introduces the subsystem
in the process of being merged (Linus sent our PR back to us for a minor
fix[3], so it should be in either 5.4-rc2 or 5.5, but is nevertheless in
linux-next). However, we also have a staging repo that people are using
and some supporting code that lives outside of the kernel.

So I am trying to figure out:

 1. Is it appropriate to request a Bugzilla component before our
    subsystem has been merged into torvalds/master? I would just wait,
    but I have some users looking to file issues, so I would prefer to
    provide them something sooner rather than later.

 2. Is it appropriate to use the kernel's Bugzilla to track issues
    outside of the Linux kernel? As I mention above, we have code that
    lives outside of the kernel; is it appropriate to use kernel.org's
    Bugzilla for this?

 3. Does Bugzilla match my planned usage model? It doesn't look like
    Bugzilla get's much usage aside from reporting bugs. I want to use
    it for tracking feature progress and things like that. Is that okay?

If kernel.org's Bugzilla is not a fit for what I want to do, that's
fine. I just want to make sure before I go off and potentially fracture
a central bug repository by creating my own somewhere else.

Thanks!

[1] https://lwn.net/Articles/780985/
[2] https://google.github.io/kunit-docs/third_party/kernel/docs/index.html
[3] https://lore.kernel.org/lkml/be8059f4-8e8f-cd18-0978-a9c861f6396b@linuxfoundation.org/
