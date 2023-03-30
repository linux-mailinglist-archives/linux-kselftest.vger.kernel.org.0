Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BBF6D0A98
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 18:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjC3QEN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 12:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjC3QEM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 12:04:12 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7E7900D;
        Thu, 30 Mar 2023 09:04:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so12096427wms.2;
        Thu, 30 Mar 2023 09:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680192250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yPmXfqw+A052dR5s4wTH1hoqmeQqq6jhBgzowzS8KJA=;
        b=nxcabEVlM62UvUMlzCel86Q58oA7A14BGYKtIaMAopyIRUs9QxXyWUdb50KiY9vbDL
         5lpau91M5hRRqCkrM8XRGMsrmI+KMG4aEQ+2fNq21Gl212OY4D4qf7dhpzEtLUGypJtY
         r+8usqQXHcY/jRmE6HRWzg+YVS6dihMD+/l6lk8EqYLtryDfE+jJ51jlqOeFNjAh6lXn
         mywCUK18EwHqsfpWGvgq1Meyu45ZiSgYSyMBPCIRWXq2j64dYYA7n+G3Bb5y/YBtQFRj
         6MsD9qu8u1UsMkW6yGIjd8FsNQ96+0JYzBt+I0vOaJhejjV8CDxJVlRXzQ18ld1uyinx
         BQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPmXfqw+A052dR5s4wTH1hoqmeQqq6jhBgzowzS8KJA=;
        b=k8Qf8bDyvj5PehY5N4Ih2IKrniqFUZdHuRU4FTjXwDf8tGa9U+MEY94trD4yBoHQaA
         eNwopBXopAeLLxtRqyKY5VvGkZPuXiocsiErKKWT3vqtlyexukmpfVfQg6WZpy23YpMb
         6uWIcGdhITMDMoQ6KCT9t7nT80BNMiE8nF5I/CAoWCAPbcvET3nKUL9ZvpzwiMU+WCbg
         a+3A3j+WiEVJ83Le9eqlCKC0n85FiMql1JbGNDRMRulwo1fukHy08qt9YlhXyoD5nz8C
         N7V4nx0H8auyBDay0hD5oVuZALT19i5dET/S6sH4VCAKPlL94BFlr25DkLiKKvx4lEz9
         7cfQ==
X-Gm-Message-State: AO0yUKVWjjg8KDnvFzczMRTeAepZP3jDwgdoO8lAZ8hDpwGQWxGsH996
        HXQxMwBpafwGcjtg0TRJoBA=
X-Google-Smtp-Source: AK7set+omi/5OJAJ14PXYkCqk7K+DIefJy9mVrO4FnldtXyAt0mk7bcbn+INQ0piKX5at/YpYVmkdA==
X-Received: by 2002:a05:600c:2114:b0:3ed:492f:7f37 with SMTP id u20-20020a05600c211400b003ed492f7f37mr17495580wml.10.1680192250278;
        Thu, 30 Mar 2023 09:04:10 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p2-20020a05600c204200b003ed2c0a0f37sm6224363wmg.35.2023.03.30.09.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:04:09 -0700 (PDT)
Date:   Thu, 30 Mar 2023 19:04:06 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [BUG] [PATCH RFC v2] selftests/firmware: copious kernel memory
 leaks in test_fw_run_batch_request()
Message-ID: <f2d1f0e1-9f0c-418c-ac6b-16ffbfee562d@kili.mountain>
References: <97e284be-5018-9d18-feb2-7ec4b08c06fd@alu.unizg.hr>
 <26fd581a-1b9f-4960-8457-61d725511cee@kili.mountain>
 <dce6ffbe-7580-db1a-dd24-798be27b3a26@alu.unizg.hr>
 <5b103196-68d0-4d42-aa66-779af4d78532@kili.mountain>
 <878rfekz2l.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rfekz2l.wl-tiwai@suse.de>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 30, 2023 at 06:01:54PM +0200, Takashi Iwai wrote:
> On Thu, 30 Mar 2023 17:44:42 +0200,
> Dan Carpenter wrote:
> > 
> > I admire your enthusiam.  :)  What about if we just did this?  Does it
> > help with the leaks?
> > 
> > regards,
> > dan carpenter
> > 
> > diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> > index 05ed84c2fc4c..626b836895f4 100644
> > --- a/lib/test_firmware.c
> > +++ b/lib/test_firmware.c
> > @@ -895,6 +895,9 @@ static ssize_t trigger_batched_requests_store(struct device *dev,
> >  
> >  	mutex_lock(&test_fw_mutex);
> >  
> > +	if (test_fw_config->reqs)
> > +		return -EBUSY;
> > +
> 
> This leaves the mutex locked.
> It should be the following instead, I suppose?
> 
> 	if (test_fw_config->reqs) {
> 		rc = -EBUSY;
> 		goto out_unlock;
> 	}

So embarrassing...  Yes.

regards,
dan carpenter

