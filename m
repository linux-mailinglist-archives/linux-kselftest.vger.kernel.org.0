Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED14977F30D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 11:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbjHQJQm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 05:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349432AbjHQJQT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 05:16:19 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEA62D64;
        Thu, 17 Aug 2023 02:15:47 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf092a16c9so7013095ad.0;
        Thu, 17 Aug 2023 02:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692263747; x=1692868547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kDdelgcBIspY6F/EUKlzdqvBROSrX1RLzAT7W5Jq5UM=;
        b=TIXIGbZPfAjdo6JM5jW25YTR0j7hyAKmCeKK9hB5bETehnsdJG579fwuE8YjAH1Q+j
         vo3AyXAFIXu1ZLtbeHSnmdPoCJF7tIaD2A+ubh5PNNc8sec5sdIRLkUH6ESW6lWvVs6D
         YYdHfNULjVGNRCkvPl92RvD3oNvvObDtuQ49dnq4p91cjcj/g7EgGhUFzoHI5BM25zKl
         oldknnF3iBNtpK/viriWeWgpSB5KH98RkO5KCMerXgsO0cvF4LNGdBYER7ZRN2UbYmTM
         UgvaXEHBlnixshbPJfd9yftfH2Osf24czY2EKjPWgNCDqmr2YN0Q1kDSiVLtfLttUM6x
         iklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692263747; x=1692868547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDdelgcBIspY6F/EUKlzdqvBROSrX1RLzAT7W5Jq5UM=;
        b=V45NNPp/EHWEksKNoTsRyXOKirizpQV+JTPtjldNVwC/3L3X7epA+PMF05CO8Whq4k
         bpcgDuBZTz2TUuAqeKKZ8vu/nZQllhpRhu/YGfRlCMfUJKFUvj6IwckRcuwGRrM1FNqD
         zaP0vjvPewDLLYvp9eUyieVRDDLKZFO1245NCGPKKVCiz9a3VLlnkHrm4yRS58anSrpI
         78D6OZaqSLL7C6e+TXoZJj7nZ/JQ/fgDOccrfytxa2ufdPPxjgNb5I76z90AfVC8QpzY
         st4q2diUDuPnRhyDxD9HS8oIJXi9uGHT0Bm3uEXDX+0ysYR9V4BNBNBBWdDhaCzer777
         3zEA==
X-Gm-Message-State: AOJu0YyUwKJAXbuD0tEt4IbTmAvp4dNe9v0ysBci98A9EPQCrK3G/48J
        ebDXfp56OwxKKuexik3I6gynwCMSlo0=
X-Google-Smtp-Source: AGHT+IF8J9cddTtCDqAxUl5VVLq6EIkCrZpwO/rZwtzXEcKwqC3GePgGQrB+qyU+9ko3IfmjCku0eQ==
X-Received: by 2002:a17:902:f546:b0:1bb:97d0:c628 with SMTP id h6-20020a170902f54600b001bb97d0c628mr5146054plf.31.1692263746743;
        Thu, 17 Aug 2023 02:15:46 -0700 (PDT)
Received: from atom0118 ([2405:201:c009:58e9:1afa:cf81:3a3:6ec8])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902bd9700b001b03f208323sm14635208pls.64.2023.08.17.02.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 02:15:46 -0700 (PDT)
Date:   Thu, 17 Aug 2023 14:45:40 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        a.zummo@towertech.it, shuah@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] selftests: rtc: Fixes rtctest error handling.
Message-ID: <20230817091540.GA72739@atom0118>
References: <20230717175251.54390-1-atulpant.linux@gmail.com>
 <202307172115223bd0669f@mail.local>
 <8d0c3075-22a0-bd13-45fe-f8c052e50588@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d0c3075-22a0-bd13-45fe-f8c052e50588@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 16, 2023 at 09:59:30AM -0600, Shuah Khan wrote:
> On 7/17/23 15:15, Alexandre Belloni wrote:
> > On 17/07/2023 23:22:51+0530, Atul Kumar Pant wrote:
> > > Adds a check to verify if the rtc device file is valid or not
> > > and prints a useful error message if the file is not accessible.
> > > 
> > > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > 
> > Please collect and keep the tags you got on previous versions
> > 
> > > ---
> > > 
> > > changes since v4:
> > >      Updated the commit message.
> > > 
> > > changes since v3:
> > >      Added Linux-kselftest and Linux-kernel mailing lists.
> > > 
> > > changes since v2:
> > >      Changed error message when rtc file does not exist.
> > > 
> > > changes since v1:
> > >      Removed check for uid=0
> > >      If rtc file is invalid, then exit the test.
> > > 
> > >   tools/testing/selftests/rtc/rtctest.c | 11 ++++++++++-
> > >   1 file changed, 10 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
> > > index 63ce02d1d5cc..630fef735c7e 100644
> > > --- a/tools/testing/selftests/rtc/rtctest.c
> > > +++ b/tools/testing/selftests/rtc/rtctest.c
> > > @@ -17,6 +17,7 @@
> > >   #include <unistd.h>
> > >   #include "../kselftest_harness.h"
> > > +#include "../kselftest.h"
> > >   #define NUM_UIE 3
> > >   #define ALARM_DELTA 3
> > > @@ -419,6 +420,8 @@ __constructor_order_last(void)
> > >   int main(int argc, char **argv)
> > >   {
> > > +	int ret = -1;
> > > +
> > >   	switch (argc) {
> > >   	case 2:
> > >   		rtc_file = argv[1];
> > > @@ -430,5 +433,11 @@ int main(int argc, char **argv)
> > >   		return 1;
> > >   	}
> > > -	return test_harness_run(argc, argv);
> > > +	// Run the test if rtc_file is valid
> > > +	if (access(rtc_file, F_OK) == 0)
> > > +		ret = test_harness_run(argc, argv);
> > > +	else
> > > +		ksft_exit_fail_msg("[ERROR]: Cannot access rtc file %s - Exiting\n", rtc_file);
> 
> This should be skip not a fail. access() could for a number of reasons.
> Since the test isn't run when access() returns error, this would be a
> skip. Also the new message could be improved to use strerror() to
> print message with details on why access() failed.
> thanks,
> -- Shuah

	Thank for the feedback. I have made the changes based on above
	comments and updated the patch.
