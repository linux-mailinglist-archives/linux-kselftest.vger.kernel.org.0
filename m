Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF367BC8B3
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Oct 2023 17:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343934AbjJGPn2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Oct 2023 11:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbjJGPn1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Oct 2023 11:43:27 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44B5BA;
        Sat,  7 Oct 2023 08:43:25 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c77449a6daso27020795ad.0;
        Sat, 07 Oct 2023 08:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696693405; x=1697298205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/XmnQ8BulCB8LjvQmFruCYlEAR5yQvD41aixSO30z8=;
        b=e/5qMkfcA8WoEgJ2BfnfymOgeHfE4M3jvRX5qKVz0UrPtvG5BvmRc0qweYVBWGd6cw
         mF4kFmODBZRowxTqvBTjgbsTuoxC/Cn9HHU8RgIl2B8lrzksZP9ObV94/RUaHZXbbOnW
         3aLQ1VCNr5uPIrILWOYyX4BR3eTTuwRVoZ4aYJJq4JZvdmkSNGJTAHQpn1EB3TaZrZZS
         OmQ3h1sXTlLo/vfjNtZ9CCigoEZp7T45dPBgO5y8CUN8DAG0r9Sw5HheXcP8R2gc0Z0c
         YkA0GHiSzXg2P1xNRp3oqsA4+RZgVgVafBDG4e/03tzyE6xelDJLlESzPTPP7kk7nguk
         jy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696693405; x=1697298205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/XmnQ8BulCB8LjvQmFruCYlEAR5yQvD41aixSO30z8=;
        b=tRjStFhqk4MIEyNbJt9OsbNu0jZGSCNXG92m67iAaaLjYe8LDAw5/7on98pdaMdhfg
         EzAfOxMGvRMYXlVQDLneoSCLuJyRm1zGmGn251GADlISCt4AMe/kVls43M5gOVFtIWZp
         P98YNBfNbj17b75UspLns5WpQMALt4gtVixfsNtuDekhdCv5oo+03Sny4+j2vkxxMn73
         /SbxozKElSRzG7nPq67tvBmRWOIQJs1GK2/XTvSJgRU8vCsdj9+w8HGG1sLqUyzdghEm
         aM7ZY8JPlVYaUl5bg70CKQE3k1OV5chMfcKadDH9w/wjQejgSJ9apY8E6/Rkpy/onkV6
         V64Q==
X-Gm-Message-State: AOJu0Yxs/UJM9NfUHCINvDhElKJznboptiATAvrx5OVw+6slO79C9BRT
        NoQvHKVP8Ur3HjFmSq6t/+U=
X-Google-Smtp-Source: AGHT+IHZV4+w0lDRBs5HTW4DdFO5OTdaorE0aKrM46lFABN999Y0bQFFk+WF6LoIW0B0OVpRzvXT1g==
X-Received: by 2002:a17:902:8f8b:b0:1c5:f0fd:51be with SMTP id z11-20020a1709028f8b00b001c5f0fd51bemr10068331plo.69.1696693405079;
        Sat, 07 Oct 2023 08:43:25 -0700 (PDT)
Received: from atom0118 ([2405:201:c009:52e1:f940:d30d:8b60:5b64])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902eb0400b001b9d7c8f44dsm6053629plb.182.2023.10.07.08.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 08:43:24 -0700 (PDT)
Date:   Sat, 7 Oct 2023 21:13:18 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     shuah@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] selftests: rtc: Fixes rtctest error handling.
Message-ID: <20231007154318.GC20160@atom0118>
References: <20230817091401.72674-1-atulpant.linux@gmail.com>
 <20230923173652.GC159038@atom0118>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923173652.GC159038@atom0118>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 23, 2023 at 11:06:58PM +0530, Atul Kumar Pant wrote:
> On Thu, Aug 17, 2023 at 02:44:01PM +0530, Atul Kumar Pant wrote:
> > Adds a check to verify if the rtc device file is valid or not
> > and prints a useful error message if the file is not accessible.
> > 
> > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > ---
> > 
> > changes since v5:
> >     Updated error message to use strerror().
> > 	If the rtc file is invalid, the skip the test.
> > 
> > changes since v4:
> >     Updated the commit message.
> > 
> > changes since v3:
> >     Added Linux-kselftest and Linux-kernel mailing lists.
> > 
> > changes since v2:
> >     Changed error message when rtc file does not exist.
> > 
> > changes since v1:
> >     Removed check for uid=0
> >     If rtc file is invalid, then exit the test.
> > 
> >  tools/testing/selftests/rtc/rtctest.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
> > index 630fef735c7e..27b466111885 100644
> > --- a/tools/testing/selftests/rtc/rtctest.c
> > +++ b/tools/testing/selftests/rtc/rtctest.c
> > @@ -15,6 +15,7 @@
> >  #include <sys/types.h>
> >  #include <time.h>
> >  #include <unistd.h>
> > +#include <error.h>
> >  
> >  #include "../kselftest_harness.h"
> >  #include "../kselftest.h"
> > @@ -437,7 +438,7 @@ int main(int argc, char **argv)
> >  	if (access(rtc_file, F_OK) == 0)
> >  		ret = test_harness_run(argc, argv);
> >  	else
> > -		ksft_exit_fail_msg("[ERROR]: Cannot access rtc file %s - Exiting\n", rtc_file);
> > +		ksft_exit_skip("%s: %s\n", rtc_file, strerror(errno));
> >  
> >  	return ret;
> >  }
> > -- 
> > 2.25.1
> > 
> 
> 	Hi Shuah, I have made the changes as per your comments. Can you please
> 	review the changes ?

	Hi Shuah, can you please review the changes and provide comments ?
	It has been quite sometime since I uploaded the change. If something
	is to be improved, I'll gladly do it.
