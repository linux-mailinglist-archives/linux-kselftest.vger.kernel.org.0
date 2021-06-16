Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC473A91B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jun 2021 08:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhFPGPh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Jun 2021 02:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhFPGPg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Jun 2021 02:15:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B68061369;
        Wed, 16 Jun 2021 06:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824011;
        bh=VaE0S1kf77O5EbvMHJFmsXcTIFViX82c9LKFOtIeQLc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U5DXn7x7P8VwcFuJj/NuGjAlN6uazR2O2iUk41SK0I4HCcgGWxMDFpDgVHxDSMk02
         VEbozYODhbClLFSplS9whycdKRm6ICigFH1YsskeexaKJU4emxiFVSf4EPtej5HjiK
         jdHDRX3CkZTiVgtomUdKUHBZ19MgwvFyakkvhD2XpEf8EoNyMj3jHlFDHahKEJzB/7
         3jrDTKthRxz5wLVe94TXVVGNNs/joHbvoWafZN1ABWUN9gc9qVXb/qwds0hXM74x6a
         Eyr7xagmo1c8Cpc4bQES3Cp9jqz7fQwgk1RO03SdVpq4hW62jZqsFua3JKvSpA1otH
         SMp4ZrP1nVy4Q==
Date:   Wed, 16 Jun 2021 08:13:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 14/34] docs: dev-tools: kunit: avoid using ReST
 :doc:`foo` markup
Message-ID: <20210616081326.39a73ad0@coco.lan>
In-Reply-To: <20210616080034.335f3e75@coco.lan>
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
        <a3ad84108a5b254e545f88e58d411f5fe2e25c7e.1622898327.git.mchehab+huawei@kernel.org>
        <CABVgOSnz_94ZO2Sa8Vf70eV_tf0gksDBUhZXYXX1VS=qFR=zPw@mail.gmail.com>
        <20210616080034.335f3e75@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Em Wed, 16 Jun 2021 08:00:34 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Sat, 5 Jun 2021 23:44:41 +0800
> David Gow <davidgow@google.com> escreveu:
> 
> > On Sat, Jun 5, 2021 at 9:18 PM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> > >
> > > The :doc:`foo` tag is auto-generated via automarkup.py.
> > > So, use the filename at the sources, instead of :doc:`foo`.
> > >
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---  
> > 
> > This is much better, thanks! Do note that there's a merge conflict
> > (and another :doc:`` tag which needs updating) in the kunit-fixes
> > branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=11dbc62a73a7da9f3697e8ce83d07503c11dcabb
> 
> Ok, thanks for the warning. I'm folding the enclosed patch:

Err... ended adding a wrong diff there...

I guess I'm missing my morning dosage of caffeine ;-)

The diff I appended is this one:

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index ee21e482a0de..63ef7b625c13 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -236,5 +236,5 @@ Next Steps
 ==========
 *   Check out the Documentation/dev-tools/kunit/tips.rst page for tips on
     writing idiomatic KUnit tests.
-*   Optional: see the Documentation/dev-tools/kunit/usage.rst page for a more
+*   Optional: see the :doc:`usage` page for a more
     in-depth explanation of KUnit.

It basically reverts a change in order to avoid merge conflicts at
linux-next when this patch gets merged via docs-next.

I'll submit later a followup patch against 5.14-rc1.

Thanks,
Mauro
