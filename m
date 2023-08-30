Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD4278DACA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjH3ShJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243723AbjH3Lfx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 07:35:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E02132;
        Wed, 30 Aug 2023 04:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693395350; x=1724931350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h3ZazSER22rib2B9TYZzPIsIlIRyHDfzHJ5qdZQmJFY=;
  b=jvcdbe2CrJhKIHfOiQIwPBxJsnLKt9D2hugknRyumlv4mzF0tdW5tiyq
   C8cqm4diCGsCNTTgaCMMBM27vQTFxPg23jpNoJ24YEJ+i6WU9Ws9oaw29
   xQgp29uRPaau4Irh3inYPJG8d230779wlyQLcmCBbqIhdMC+Oa95SvFVW
   Jss2hFQ5EtjoP7Uan7QOSHBtBSKV+6wstnZm0wJnYYmQSCWWiG9tvcmia
   jPjGpZqn+8xHHj7ddK+VXxh2KlDNBt2LiBpvS6ibc3rUX5iXUqxuSEfTi
   UMSIiRw9mkzCc4vJJbM4spfZiPmuAqWP3uAtXdQqOG/SYtzeN9ztR6GbI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="441981272"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="441981272"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 04:35:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="732585103"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="732585103"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.213.15.207])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 04:35:47 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] kunit: Fix test log size limit too low for some tests
Date:   Wed, 30 Aug 2023 13:35:45 +0200
Message-ID: <4506938.LvFx2qVVIh@jkrzyszt-mobl2.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <CABVgOSmZ56p8BBFHNXqigNrH95O_YjMZxfpbhWcZJFrSMS3CDA@mail.gmail.com>
References: <20230830075419.26484-2-janusz.krzysztofik@linux.intel.com>
 <CABVgOSmZ56p8BBFHNXqigNrH95O_YjMZxfpbhWcZJFrSMS3CDA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wednesday, 30 August 2023 11:23:43 CEST David Gow wrote:
> On Wed, 30 Aug 2023 at 15:55, Janusz Krzysztofik
> <janusz.krzysztofik@linux.intel.com> wrote:
> >
> > Now we have memory space available to a kunit test case log exposed via
> > debugfs limited to 2048 bytes, while some parametrized test cases, e.g.,
> > drm_framebuffer.drm_test_framebuffer_create, need more.  For this reason,
> > debugfs results from affected test cases get truncated silently, and
> > external tools that rely on parsing of debugfs results can fail.
> >
> > Increase kunit test case log size limit to 4096 bytes.
> >
> > Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> > ---
> 
> There's a patch series we're hoping to take for 6.7 which allows the
> log to grow to fit whatever's written into it, which should make this
> patch obsolete:
> https://lore.kernel.org/linux-kselftest/20230828104111.2394344-1-rf@opensource.cirrus.com/T/
> 
> Would that work for you?

Yeah, that's going to work perfectly for us, thank you.

Janusz

> 
> -- David
> 
> >  include/kunit/test.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index d33114097d0d0..d20eb1884edfa 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -34,7 +34,7 @@ DECLARE_STATIC_KEY_FALSE(kunit_running);
> >  struct kunit;
> >
> >  /* Size of log associated with test. */
> > -#define KUNIT_LOG_SIZE 2048
> > +#define KUNIT_LOG_SIZE 4096
> >
> >  /* Maximum size of parameter description string. */
> >  #define KUNIT_PARAM_DESC_SIZE 128
> > --
> > 2.41.0
> >
> 




