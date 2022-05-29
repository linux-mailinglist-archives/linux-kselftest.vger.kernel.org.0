Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFC55372B2
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 May 2022 23:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiE2VUp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 29 May 2022 17:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiE2VUo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 29 May 2022 17:20:44 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7392CDF4;
        Sun, 29 May 2022 14:20:43 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id l1so8805096qvh.1;
        Sun, 29 May 2022 14:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jx+weakhReTpBiyhpJMmr0fal0LRVyBY1kBAbquoL8I=;
        b=NR2lcqPICYi6a/ghlAaeu7f+fJNQildSlq6WQjlH0j2zdtMWIgvQDiZgwIG6ykc6Ro
         tktJh8E9RJM9iIizWnKbuwoIuZCFelc9PwFBPWc2Vg25Z+l7J0F0eUaR1Tw0Yd4kxFJp
         5n+F/jXm8PP98dxIte+YXGKT5eFyeBhdjnYIFiB6gezIYt7f2GMAZxZ0HRm+hT985zEK
         wEuMnxLH/f+T+zzlGXUumcv57fcU5frdOND3VctNAyLL6Oanx9aOKpHB43yOTAd91w48
         gCsE9jwX1ZhlKC5G+f0wuxqVzmPvPOF1HTXYWXk5OEi8VaXv29uhX50Tpt6ocf64QeKc
         KhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jx+weakhReTpBiyhpJMmr0fal0LRVyBY1kBAbquoL8I=;
        b=mVG8E4bWS2MqwYcgw3572XpSPMQ4fz0VBlrcgJK2oIKmwXXe2h4w3XfjPBaf8BzbhM
         gs2LocPaVjGa8VXb8rwx4iSlDUh0BHlH4ob1s1uevpTaqgEQu0D7Wt/FigJTyw8PMtK3
         86P+Amj0Mom0J7Wh1jmR5urRrw2g2siLoTZ70vh0uw3QkLbGb/kyZe+UXo9AYcUG8bS7
         H4n7k77yeaCEw2b34VFOvUfa81bwci7n+RlVpZQLZbe12GKd/dpI6uviyzu+YWjR4l6u
         HthO/n06YoDZqtFD5jIt53ciNE5ao58VQ+Kv5ZWZvs3nAhtHV+4bTOqrhzyJ65Czkzdn
         ZWrQ==
X-Gm-Message-State: AOAM530SfT2o4BF+aLThanqCX3lmSDjAM5jMs0lg36qljW5VQiLw9utx
        9+hw2MeqVvkz6AddBcfPgd0=
X-Google-Smtp-Source: ABdhPJwZJreQ+7Cv5dNnc7fZVvv4kOWOtmfezRij1nv08ZXpS6fqq7AHopyxCMblzo2uex6BwPdh/Q==
X-Received: by 2002:a05:6214:627:b0:461:f1be:50d9 with SMTP id a7-20020a056214062700b00461f1be50d9mr42790694qvx.40.1653859242613;
        Sun, 29 May 2022 14:20:42 -0700 (PDT)
Received: from shaak (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id u126-20020ae9d884000000b006a35ac236c4sm6615470qkf.113.2022.05.29.14.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 14:20:42 -0700 (PDT)
Date:   Sun, 29 May 2022 17:20:40 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Subject: Re: kbuild problem: ERROR: modpost: missing MODULE_LICENSE() in
 drivers/iio/afe/iio-rescale.o
Message-ID: <YpPjqC+kVLIBpNlq@shaak>
References: <18500f18-9cd5-a81c-4a55-14e999ed4496@infradead.org>
 <3ae306e0-c6c7-ed12-cacd-62b1c26dba3c@infradead.org>
 <6671de03-c09c-bfaf-e06c-e45af70d4354@infradead.org>
 <6601a387-de9a-a0d0-11b5-01e0cfa75657@infradead.org>
 <7a97bac3-6ade-8e1b-cf0c-4a05c83163a3@infradead.org>
 <Yo+lHSmeIsx144cv@shaak>
 <3b7ec693-f4a5-e1aa-3e07-b22a4008d4c9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b7ec693-f4a5-e1aa-3e07-b22a4008d4c9@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Randy,

On Thu, May 26, 2022 at 01:04:41PM -0700, Randy Dunlap wrote:
> 
> 
> On 5/26/22 09:04, Liam Beguin wrote:
> > Hi Randy,
> > 
> > On Thu, May 26, 2022 at 08:36:34AM -0700, Randy Dunlap wrote:
> >> Liam:
> >>
> >> Any comment on this?
> >> Otherwise I'll just send a formal patch like this (below).
> > 
> > Apologies for not answering earlier.
> > 
> > I wanted to look more into Masahiro's comment and try to fix the
> > Makefile, but that can be done after.
> > 
> > IMO your patch improves the current Kconfig, so I'd recommend sending
> > the patch. If it can wait a bit, I can look at the Makefile over the
> > weekend.
> > 
> 
> Liam,
> 
> I'll wait until next week to see if you come up with anything.
> 

The following patch fixes the issue while addressing Masahiro's comment.
I also considered `select IIO_RESCALE`, but I'm not sure what's usually
preferred.

diff --git a/drivers/iio/test/Kconfig b/drivers/iio/test/Kconfig
index 56ca0ad7e77a..4c66c3f18c34 100644
--- a/drivers/iio/test/Kconfig
+++ b/drivers/iio/test/Kconfig
@@ -6,7 +6,7 @@
 # Keep in alphabetical order
 config IIO_RESCALE_KUNIT_TEST
 	bool "Test IIO rescale conversion functions"
-	depends on KUNIT=y && !IIO_RESCALE
+	depends on KUNIT=y && IIO_RESCALE=y
 	default KUNIT_ALL_TESTS
 	help
 	  If you want to run tests on the iio-rescale code say Y here.
diff --git a/drivers/iio/test/Makefile b/drivers/iio/test/Makefile
index f15ae0a6394f..880360f8d02c 100644
--- a/drivers/iio/test/Makefile
+++ b/drivers/iio/test/Makefile
@@ -4,6 +4,6 @@
 #
 
 # Keep in alphabetical order
-obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o ../afe/iio-rescale.o
+obj-$(CONFIG_IIO_RESCALE_KUNIT_TEST) += iio-test-rescale.o
 obj-$(CONFIG_IIO_TEST_FORMAT) += iio-test-format.o
 CFLAGS_iio-test-format.o += $(DISABLE_STRUCTLEAK_PLUGIN)

I'll send a patch as soon as you confirm this works for you too.

Cheers,
Liam

> 
> > 
> >>
> >> Thanks.
> >>
> >> On 5/20/22 20:51, Randy Dunlap wrote:
> >>> Ok, one more.
> >>> [also adding Liam here]
> >>>
> >>> On 5/20/22 20:17, Randy Dunlap wrote:
> >>>>
> >>>>
> >>>> On 5/20/22 20:08, Randy Dunlap wrote:
> >>>>>
> >>>>>
> >>>>> On 5/20/22 19:40, Randy Dunlap wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> In March I reported that a randconfig build complained:
> >>>>>>
> >>>>>> ERROR: modpost: missing MODULE_LICENSE() in drivers/iio/afe/iio-rescale.o
> >>>>>>
> >>>>>> (https://lore.kernel.org/all/16509fb6-e40c-e31b-2c80-264c44b0beb9@infradead.org/)
> >>>>>>
> >>>>>> I am still seeing this problem so I tried to dig into it a bit.
> >>>>>> However, I don't see why get_next_modinfo() and friends don't find the
> >>>>>> MODULE_LICENSE() since it is in the iio-rescale.o file.
> >>>>>>
> >>>>>> (BTW, I see this build error on many different $ARCH [around 15 tested]
> >>>>>> and with 2 different versions of GCC.)
> >>>>>>
> >>>>>> Q1: Is modpost checking both vmlinux and iio-rescale.o for modinfo license
> >>>>>> strings?
> >>>>>>
> >>>>>> It looks like it is, because it appears (?) that modpost is looking at
> >>>>>> drivers/iio/test/iio-test-rescale.o (<<<<< a kunit test, which is builtin
> >>>>>> in my .config) and at drivers/iio/afe/iio-rescale.o (which is built as a
> >>>>>> loadable module).
> >>>>>>
> >>>>>> Is this confusing modpost?
> >>>>>> I renamed drivers/iio/afe/iio-rescale.c to afe-rescale.c and changed its
> >>>>>> Makefile entry accordingly and the MODULE_LICENSE error goes away.
> >>>>>
> >>>>> Oh well. This rename causes drivers/iio/test/iio-test-rescale.c to have
> >>>>> build errors, so that's not a solution, just some info...
> >>>>
> >>>> and that was due to not updating drivers/iio/test/Makefile.
> >>>> When that is done, the missing MODULE_LICENSE() is back in afe-rescale.o.
> >>>>
> >>>>>
> >>>>>> Is this a modpost error or is kunit messing things up?
> >>>>>>
> >>>>>> thanks for looking.
> >>>
> >>> Does this look OK? It allows afe/iio-rescale.o to build XOR
> >>> test/iio-rescale.o (not both of them).
> >>>
> >>> --- a/drivers/iio/test/Kconfig
> >>> +++ b/drivers/iio/test/Kconfig
> >>> @@ -6,7 +6,7 @@
> >>>  # Keep in alphabetical order
> >>>  config IIO_RESCALE_KUNIT_TEST
> >>>         bool "Test IIO rescale conversion functions"
> >>> -       depends on KUNIT=y && !IIO_RESCALE
> >>> +       depends on KUNIT=y && IIO_RESCALE=n
> >>>         default KUNIT_ALL_TESTS
> >>>         help
> >>>           If you want to run tests on the iio-rescale code say Y here.
> >>>
> >>>
> >>
> >> -- 
> >> ~Randy
> 
> -- 
> ~Randy
