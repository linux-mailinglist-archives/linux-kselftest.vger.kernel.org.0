Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6C34B1483
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 18:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245316AbiBJRqW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 12:46:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245320AbiBJRqT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 12:46:19 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ECF21B7
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 09:46:20 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id w20so2436641plq.12
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 09:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BFHj0bDE2ql3swAY1JvHUYSQUDfeEnWV/5IfYHYgHQc=;
        b=chrTi4R50FWzgvjlFK2MFw9uDWaTu3Qv5Ws+vcrV3YJbwXchR0OMrLp/7G0dmHhh2x
         el2004Nm4t/fHKLgSqiN6BplN4CtdC1/asamqd2BTjCEq9uDdP4dyWiwHBYlF1THpAHE
         2cy64j8f94rGFTPOz48TApd78v4dMBfbPAiIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BFHj0bDE2ql3swAY1JvHUYSQUDfeEnWV/5IfYHYgHQc=;
        b=fgpWKlkpshBo5sVLy4NA02ifVPBRE+i2gdUAzVIblkw6IBvlfFun3ldEMmVBq7PUY0
         pa2t8ltFbCj4+FkVN1Tws2pbvzRRtlI8aCspL/BXEBBjb732fwg1If75o32GpTF2FTmr
         U/04VacMpBcrJxIhOWYCts780Rf6LctkP5iwQmslhNEjNrCQYnYtfCrSq/+/Doon/ePQ
         QeXy/JfD/bEJAxL8ccGQ5vjvPaDFysGbaNY/KRoBK/7HnqiMUMe9Ye2kkwxTtESG833T
         9JbXTBe+HFYym2cGWRIbxPjnFlT79AY10vIvNQ07xbyGhMymNv3z8yt4zSI5nB7qO3PU
         WQHA==
X-Gm-Message-State: AOAM5302JM1bHliDY3p7mpFamn+Q3arv8eVtHJdPiTPr1IvtV6pRoHAe
        Wjfi63XhaKxgeGR8OW9dBd0RBQ0EAiS0eQ==
X-Google-Smtp-Source: ABdhPJxXVFMp4ezn09RLQRL8c/uZAcMjnJwFTlA+URTm0Ctuctnk3TM4LrefUXOC5PB3isHCOp/osg==
X-Received: by 2002:a17:902:d510:: with SMTP id b16mr8653125plg.152.1644515179460;
        Thu, 10 Feb 2022 09:46:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u18sm2847762pjn.49.2022.02.10.09.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 09:46:18 -0800 (PST)
Date:   Thu, 10 Feb 2022 09:46:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, kernelci@groups.io,
        "kernelci.org bot" <bot@kernelci.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/exec: Add non-regular to TEST_GEN_PROGS
Message-ID: <202202100945.BCDDA1BE3D@keescook>
References: <20220210171323.1304501-1-usama.anjum@collabora.com>
 <e8397c75-32df-b1d2-c3c3-21c5c0943ef6@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8397c75-32df-b1d2-c3c3-21c5c0943ef6@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 10, 2022 at 10:34:20AM -0700, Shuah Khan wrote:
> On 2/10/22 10:13 AM, Muhammad Usama Anjum wrote:
> > non-regular file needs to be compiled and then copied to the output
> > directory. Remove it from TEST_PROGS and add it to TEST_GEN_PROGS. This
> > removes error thrown by rsync when non-regular object isn't found:
> > 
> > rsync: [sender] link_stat "/linux/tools/testing/selftests/exec/non-regular" failed: No such file or directory (2)
> > rsync error: some files/attrs were not transferred (see previous errors) (code 23) at main.c(1333) [sender=3.2.3]
> > 
> > Fixes: 0f71241a8e32 ("selftests/exec: add file type errno tests")
> > Reported-by: "kernelci.org bot" <bot@kernelci.org>
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > ---
> >   tools/testing/selftests/exec/Makefile | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
> > index 551affb437fe1..a89ba6de79870 100644
> > --- a/tools/testing/selftests/exec/Makefile
> > +++ b/tools/testing/selftests/exec/Makefile
> > @@ -3,8 +3,8 @@ CFLAGS = -Wall
> >   CFLAGS += -Wno-nonnull
> >   CFLAGS += -D_GNU_SOURCE
> > -TEST_PROGS := binfmt_script non-regular
> > -TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216
> > +TEST_PROGS := binfmt_script
> > +TEST_GEN_PROGS := execveat load_address_4096 load_address_2097152 load_address_16777216 non-regular
> >   TEST_GEN_FILES := execveat.symlink execveat.denatured script subdir
> >   # Makefile is a run-time dependency, since it's accessed by the execveat test
> >   TEST_FILES := Makefile
> > 
> 
> This change looks good to me. regular is a binary and TEST_GEN_PROGS is
> where it belongs.
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> Also binfmt_script could be renamed to clearly identify that it is python
> script. This can be done in a separate patch.

Yeah, I agree: that would help with skimming the Makefile for
correctness.

-- 
Kees Cook
