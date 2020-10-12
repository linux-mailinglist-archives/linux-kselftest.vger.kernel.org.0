Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4BB28BF8C
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Oct 2020 20:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbgJLSUM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 14:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387583AbgJLSUM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 14:20:12 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15113C0613D0;
        Mon, 12 Oct 2020 11:20:12 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a3so24470749ejy.11;
        Mon, 12 Oct 2020 11:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=zKR9KbIkinjPzqJD1ltq5DuEQ4lH3nYSPjUa+vf7uVg=;
        b=OFXOwfvc/nyJT3C6V7aZzJjdeu59DoQMuQZoSOtGc3bLesxHvZmy3dEyJLZ73P9Y/w
         7oCoMUkzceseBVLu0gQ3xhEQNeiUZNLNTC1KaqVNeUzn/a9zZsMxN+8kj2rrn27BB4Hg
         EcKJzG1Ad+PIK66lBQxnbdgxb2ckmutN8kTdEvFnggZntydZAW3f2pLOWDJI5fesrFf6
         wxH7flaAzKjK+CHy/P3VG6hf8Idh2JyUehQvTDsR2OTG7jPHBOeTaCR/niGG+LTGviv8
         VjQws/Z6rl2kWQIeuSj4xxHMUunlMkia43Ywnh4K8YIGztFmpUpJcAcRhrhnb/HBnXzN
         uN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=zKR9KbIkinjPzqJD1ltq5DuEQ4lH3nYSPjUa+vf7uVg=;
        b=q1PPh4jIDYmDAGyGBIfiZGsro+5TCe49CLV+cu/dt5MtebdvU7DKfW6qpMhnjjwwXt
         sbsYe1ocx6S0apBZMasGQVcCW1yZFQP8bsUFK6tCtpytlHFNNF4dRlcccNA9WX+vEytf
         7fvIbD+ui73/idx8XM0wE+B6WQ0oSdJNb+TQrQ19BHQYQem32IgKl+xwDdYVZYB9XaTn
         VMIQSL8CgSeewChmT0y84Dsj3zkTCrlgQwbLFRf/Rv2khpUkhm6NIvFEWvBmpPuOI1CM
         7hjTEyyy59izN8DiHZPZ8FoNZv3MBXsbg3sYHNHBXoIJILqyBhNYC65muUz6RrTRcvuz
         4faQ==
X-Gm-Message-State: AOAM533W14bp2dscXARrwiTOeZQbLXNjXcSkpvF6U2pXLvzZ41k4DFz8
        zhIDFXMt3upqwGzNNB69Xls=
X-Google-Smtp-Source: ABdhPJxuoj1awCfPte30yIGodd2SIxl+1sPPHRD4hqdHcmhUGgbZUL5GPvZgz76WioXAz8ehwFuFJw==
X-Received: by 2002:a17:906:d292:: with SMTP id ay18mr29949820ejb.244.1602526810678;
        Mon, 12 Oct 2020 11:20:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:d57e:4a0f:cbf8:37db])
        by smtp.gmail.com with ESMTPSA id ok21sm4581528ejb.96.2020.10.12.11.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 11:20:09 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     Marco Elver <elver@google.com>
Cc:     SeongJae Park <sjpark@amazon.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        SeongJae Park <sjpark@amazon.de>,
        Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: kunit: Update Kconfig parts for KUNIT's module support
Date:   Mon, 12 Oct 2020 20:19:48 +0200
Message-Id: <20201012181948.1459-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CANpmjNP3oZZsOkE4sP---sXoa-K8yBB9fBXc8JzqQNXs2MwKUg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 12 Oct 2020 13:28:42 +0200 Marco Elver <elver@google.com> wrote:

> On Mon, 12 Oct 2020 at 12:54, 'SeongJae Park' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > If 'CONFIG_KUNIT=m', letting kunit tests that do not support loadable
> > module build depends on 'KUNIT' instead of 'KUNIT=y' result in compile
> > errors.  This commit updates the document for this.
> >
> > Fixes: 9fe124bf1b77 ("kunit: allow kunit to be loaded as a module")
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  Documentation/dev-tools/kunit/start.rst | 2 +-
> >  Documentation/dev-tools/kunit/usage.rst | 5 +++++
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> > index d23385e3e159..454f307813ea 100644
> > --- a/Documentation/dev-tools/kunit/start.rst
> > +++ b/Documentation/dev-tools/kunit/start.rst
> > @@ -197,7 +197,7 @@ Now add the following to ``drivers/misc/Kconfig``:
> >
> >         config MISC_EXAMPLE_TEST
> >                 bool "Test for my example"
> > -               depends on MISC_EXAMPLE && KUNIT
> > +               depends on MISC_EXAMPLE && KUNIT=y
> >
> >  and the following to ``drivers/misc/Makefile``:
> >
> > diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> > index 3c3fe8b5fecc..410380fc7fb4 100644
> > --- a/Documentation/dev-tools/kunit/usage.rst
> > +++ b/Documentation/dev-tools/kunit/usage.rst
> > @@ -556,6 +556,11 @@ Once the kernel is built and installed, a simple
> >
> >  ...will run the tests.
> >
> > +.. note::
> > +   Note that you should make your test depends on ``KUNIT=y`` in Kcofig if the
> > +   test does not support module build.  Otherwise, it will trigger compile
> > +   errors if ``CONFIG_KUNIT`` is ``m``.
> 
> s/Kcofig/Kconfig/

Thanks, I will fix this in the next version of this patch.


Thanks,
SeongJae Park
