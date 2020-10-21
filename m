Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD462952F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 21:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504943AbgJUT0P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Oct 2020 15:26:15 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:59109 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504940AbgJUT0P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Oct 2020 15:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1603308374; x=1634844374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=fFKxxCGbpTJspLKrpQWtvorN+UB7EaCdCZuZVGvPFIg=;
  b=NobhBe3yloaMDrrYDUXj67NxrdUWTlSJwU/dIcWh0YoFvmTA7ntkimRE
   MgICJYvrM+TbvrNK+an69ufYDfYLOxx4WjMmORybXa/FJmSFbY58y7PhC
   6q8KJYVuJd8eNn7NS2F6D6IdeyUGoaMKjMxOfd/tLWTZq4sHL6Sc8lRhE
   g=;
X-IronPort-AV: E=Sophos;i="5.77,401,1596499200"; 
   d="scan'208";a="78947680"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 21 Oct 2020 19:18:19 +0000
Received: from EX13D31EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id 76BB1A1E2D;
        Wed, 21 Oct 2020 19:18:18 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.25) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 21 Oct 2020 19:18:12 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     David Gow <davidgow@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        SeongJae Park <sjpark@amazon.de>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "KUnit Development" <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Documentation: kunit: Update Kconfig parts for KUNIT's module support
Date:   Wed, 21 Oct 2020 21:17:57 +0200
Message-ID: <20201021191757.29007-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CABVgOSm3RuJBrevk8W5T6fLVo=uCT5F0OUVLuVTu=TrPnPyxNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.25]
X-ClientProxiedBy: EX13D43UWA003.ant.amazon.com (10.43.160.9) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 21 Oct 2020 12:06:13 +0800 David Gow <davidgow@google.com> wrote:

> On Tue, Oct 13, 2020 at 2:38 PM 'SeongJae Park' via KUnit Development
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
> 
> Sorry for the delay in looking at this. Apart from another minuscule
> typo below, this looks good to me.
> 
> Reviewed-by: David Gow <davidgow@google.com>

Thanks!

> 
> Cheers,
> -- David
> 
> > ---
> >
> > Changes from v1
> > (https://lore.kernel.org/linux-kselftest/20201012105420.5945-1-sjpark@amazon.com/):
> > - Fix a typo (Marco Elver)
> >
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
> > index 3c3fe8b5fecc..b331f5a5b0b9 100644
> > --- a/Documentation/dev-tools/kunit/usage.rst
> > +++ b/Documentation/dev-tools/kunit/usage.rst
> > @@ -556,6 +556,11 @@ Once the kernel is built and installed, a simple
> >
> >  ...will run the tests.
> >
> > +.. note::
> > +   Note that you should make your test depends on ``KUNIT=y`` in Kconfig if the
> nit: Grammatically, this should technically be either "depend" (2nd
> person), or something like "make sure [that] your test depends".

Good eye!  I will fix this in the next version.


Thanks,
SeongJae Park
