Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C97F3C40
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 00:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfKGXdo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 18:33:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43750 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfKGXdo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 18:33:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id 3so3469601pfb.10
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Nov 2019 15:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U9LCQzLECFkJez50E4J6R+X6khDWEPIZnHrW73R9i5E=;
        b=VCSF0q3YAX7JfT36ea1mW70HVF+YkyVrrVNTW2SZ4JLxyAeawqVF5Rdh/9rH2i6SAG
         FoQiW4BL2Au/RpCOeuFpBTfOXv4RQtMPCBLk6e6QZxC/urZTkrbpLiC+YEq9NmzAG5cv
         F+3JZZa34J+jp5deo2+K4zBb9HUa7wRMlJQsvk8KX9STNPJBMoHbGn/Q46TMgSZ3qeLo
         ngTvyzyK3mDIAm6PbpO9h1Beh1EI6Xb9/jJ3eovQN+C9cXnxaZQ1izArK9tovZRpWLOD
         tLEtBET4eAM8hFBHeMHotaYpbI6I69R5joMhIlXZrcEQGsztakOvy2J+1ogM7Gq4/lfG
         d6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U9LCQzLECFkJez50E4J6R+X6khDWEPIZnHrW73R9i5E=;
        b=AdhOXJwWMwuv0oHszRi2njQrvmIfK1Lol+w0q8R+ZOcL/252R7PmkMhLXfeCHCwoB0
         MnrPYm564PWc20n19LMzFo293SPlzvqjc/LopFEIGZnNCBOzdIJ4zGxRi+nrmFMZojXZ
         IFL5qafO/c/vylCY8rCe5k0NSgHBl3wTbImk0Qp315y6QdH78r4qhielvEv6z2jDGA5u
         pesH29Fn3DXtFSBK4U0zy/TATV2fiy9n8v33GKSjfZudcTJTrfcqpul4pV1itGpT9pIS
         aIjzgMO6DdcNqzo8TGBOFL/Y6agH7uwr2dVw2uOTg8YGLV3SfeomZsUqFr8gGwlSXIRN
         ehyw==
X-Gm-Message-State: APjAAAUZkY7Bi8jY5QV1xv1WWoEubGPoZIX/PSWFLbZMEs3vUrjU8fHO
        KDlpAE13AmDlLchy/hqmY7iSug==
X-Google-Smtp-Source: APXvYqxZsw+8wS5vW5TZg88AZWSvd3uOCaJzI81XZmIohq0NEHnExqON51fuwGRb5S8Qgc5fO9qnzg==
X-Received: by 2002:aa7:9aa9:: with SMTP id x9mr7834759pfi.207.1573169622713;
        Thu, 07 Nov 2019 15:33:42 -0800 (PST)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id u3sm3438966pgp.51.2019.11.07.15.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 15:33:41 -0800 (PST)
Date:   Thu, 7 Nov 2019 15:33:37 -0800
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     shuah@kernel.org, john.johansen@canonical.com, jmorris@namei.org,
        serge@hallyn.com, alan.maguire@oracle.com, yzaikin@google.com,
        davidgow@google.com, mcgrof@kernel.org, tytso@mit.edu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Mike Salvatore <mike.salvatore@canonical.com>
Subject: Re: [PATCH linux-kselftest/test v2] apparmor: add AppArmor KUnit
 tests for policy unpack
Message-ID: <20191107233337.GA191231@google.com>
References: <20191106004329.16991-1-brendanhiggins@google.com>
 <201911060916.AC9E14B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911060916.AC9E14B@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 06, 2019 at 09:18:27AM -0800, Kees Cook wrote:
> On Tue, Nov 05, 2019 at 04:43:29PM -0800, Brendan Higgins wrote:
> > From: Mike Salvatore <mike.salvatore@canonical.com>
> > 
> > Add KUnit tests to test AppArmor unpacking of userspace policies.
> > AppArmor uses a serialized binary format for loading policies. To find
> > policy format documentation see
> > Documentation/admin-guide/LSM/apparmor.rst.
> > 
> > In order to write the tests against the policy unpacking code, some
> > static functions needed to be exposed for testing purposes. One of the
> > goals of this patch is to establish a pattern for which testing these
> > kinds of functions should be done in the future.
> > 
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Mike Salvatore <mike.salvatore@canonical.com>
> > ---
> >  security/apparmor/Kconfig              |  16 +
> >  security/apparmor/policy_unpack.c      |   4 +
> >  security/apparmor/policy_unpack_test.c | 607 +++++++++++++++++++++++++
> >  3 files changed, 627 insertions(+)
> >  create mode 100644 security/apparmor/policy_unpack_test.c
> > 
> > diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
> > index d8b1a360a6368..78a33ccac2574 100644
> > --- a/security/apparmor/Kconfig
> > +++ b/security/apparmor/Kconfig
> > @@ -66,3 +66,19 @@ config SECURITY_APPARMOR_DEBUG_MESSAGES
> >  	  Set the default value of the apparmor.debug kernel parameter.
> >  	  When enabled, various debug messages will be logged to
> >  	  the kernel message buffer.
> > +
> > +config SECURITY_APPARMOR_KUNIT_TEST
> > +	bool "Build KUnit tests for policy_unpack.c"
> > +	depends on KUNIT && SECURITY_APPARMOR
> > +	help
> > +	  This builds the AppArmor KUnit tests.
> > +
> > +	  KUnit tests run during boot and output the results to the debug log
> > +	  in TAP format (http://testanything.org/). Only useful for kernel devs
> > +	  running KUnit test harness and are not for inclusion into a
> > +	  production build.
> > +
> > +	  For more information on KUnit and unit tests in general please refer
> > +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> > +
> > +	  If unsure, say N.
> > diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> > index 8cfc9493eefc7..37c1dd3178fc0 100644
> > --- a/security/apparmor/policy_unpack.c
> > +++ b/security/apparmor/policy_unpack.c
> > @@ -1120,3 +1120,7 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
> >  
> >  	return error;
> >  }
> > +
> > +#ifdef CONFIG_SECURITY_APPARMOR_KUNIT_TEST
> > +#include "policy_unpack_test.c"
> > +#endif /* CONFIG_SECURITY_APPARMOR_KUNIT_TEST */
> 
> To make this even LESS intrusive, the ifdefs could live in ..._test.c.

Less intrusive, yes, but I think I actually like the ifdef here; it
makes it clear from the source that the test is only a part of the build
when configured to do so. Nevertheless, I will change it if anyone feels
strongly about it.

> Also, while I *think* the kernel build system will correctly track this
> dependency, can you double-check that changes to ..._test.c correctly
> trigger a recompile of policy_unpack.c?

Yep, just verified, first I ran the tests and everything passed. Then I
applied the following diff:

diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
index 533137f45361c..e1b0670dbdc27 100644
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -161,7 +161,7 @@ static void policy_unpack_test_unpack_array_with_name(struct kunit *test)
 
 	array_size = unpack_array(puf->e, name);
 
-	KUNIT_EXPECT_EQ(test, array_size, (u16)TEST_ARRAY_SIZE);
+	KUNIT_EXPECT_EQ(test, array_size + 1, (u16)TEST_ARRAY_SIZE);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos,
 		puf->e->start + TEST_ARRAY_BUF_OFFSET + sizeof(u16) + 1);
 }

and reran the tests (to trigger an incremental build) and the test
failed as expected indicating that the dependency is properly tracked.

Cheers!
