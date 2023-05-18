Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18117084C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 17:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjERPUt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 11:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjERPUr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 11:20:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760BD11D
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 08:20:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3078a3f3b5fso2122667f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 08:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684423243; x=1687015243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCPm1akb6BbLPko9px5lmXGBrzu2duK5lo70N69pAEE=;
        b=Ne/UPhCc9WQKSc787xomPdDYPwxg4W8c6tbZ07r9CzCj6EmksPg99DBwqaJF5NFBZC
         NUtAtVAyDGennyXYV2i4lOMiE4LyGgOtNc6eQHRnRZJxNy9rGOziVX04MAwyGUuS+yDA
         NZK+KlILJzqRYW0H4dcibgrXjn4R6VywPDywbiwTPLT74PoU7w8V8rfm8YMjII3kmE34
         Q0q5Lw3q9IAZgB4GKbAG4cLqN1tQdb2vW+TOLqCcrSKLFkYzBWl/BsBkBpY6BMhGRn/U
         /nVTjq8Q3iBxTo6DUALXQsu9CJiZKNlxKEVwVehG0/TB8gHPKJHTRlofJEyGj9y56V+L
         J+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684423243; x=1687015243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCPm1akb6BbLPko9px5lmXGBrzu2duK5lo70N69pAEE=;
        b=BFZ2nOFWutoC149cjpxx/jUhgWxdcCw8G/y1im9QF7I+gWyEai1WDRHiewxFxx8LA9
         rwLcHWce237xcmS3duxLgDR8f0e8shc4ML98YGdw6H5a9bux/bz5s01riiAGoXiXVAg8
         wWN30yT/1gS1ZXTOLsLq0l6dPWHSxTmEKgLHi27IY6ISDZiqftXx3DoDsvSD4swOnCsU
         VrXd96734H6gM//lSgtomaKab0WzKLhZPvnNBBaepETvtAW6UON+8zfI0p2nlCBchndO
         pcPTK3mYmfFFYkTN0xd6lbaTkoDHxSl9AqkkDM81g1EEIMLVp6SHKiUmuGblr1K6Fv2i
         duSg==
X-Gm-Message-State: AC+VfDzjdqIM1mXrfhfnMQYtyRPyYkzfZeAT7YB0ZdZr/QEqdc9wAT1N
        kXZlBfXLKiXXpzmODszAI4J0lg==
X-Google-Smtp-Source: ACHHUZ5xD/+MlJa8vEMmo2J+KEoOydoyk7Hm4U48l6iwhxmS0woFUxQD68+seOXHOXVH4m2UzG69+g==
X-Received: by 2002:a5d:4bcb:0:b0:306:2b56:d268 with SMTP id l11-20020a5d4bcb000000b003062b56d268mr1551443wrt.15.1684423242902;
        Thu, 18 May 2023 08:20:42 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o14-20020adfe80e000000b0030644bdefd8sm2479736wrm.52.2023.05.18.08.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 08:20:41 -0700 (PDT)
Date:   Thu, 18 May 2023 18:20:37 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [RESEND PATCH v5 2/3] test_firmware: fix a memory leak with reqs
 buffer
Message-ID: <828b1d4c-dac8-4a64-9f1d-452762dc07bd@kili.mountain>
References: <20230509084746.48259-1-mirsad.todorovac@alu.unizg.hr>
 <20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr>
 <256bc822-ba20-c41a-1f3b-5b6aacead32e@alu.unizg.hr>
 <f9212fd0-0a52-4076-a97a-c5af8de194cf@kili.mountain>
 <72257758-a0e6-1118-f397-431ac9ec3059@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72257758-a0e6-1118-f397-431ac9ec3059@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 12, 2023 at 08:58:58PM +0200, Mirsad Goran Todorovac wrote:
> On 12. 05. 2023. 15:09, Dan Carpenter wrote:
> > On Fri, May 12, 2023 at 02:34:29PM +0200, Mirsad Todorovac wrote:
> > > > @@ -1011,6 +1016,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
> > > >    	mutex_lock(&test_fw_mutex);
> > > > +	if (test_fw_config->reqs) {
> > > > +		rc = -EBUSY;
> > > > +		goto out_bail;
> > > > +	}
> > > > +
> > > >    	test_fw_config->reqs =
> > > >    		vzalloc(array3_size(sizeof(struct test_batched_req),
> > > >    				    test_fw_config->num_requests, 2));
> > > 
> > > I was just thinking, since returning -EBUSY for the case of already allocated
> > > test_fw_config->reqs was your suggestion and your idea, maybe it would be OK
> > > to properly reflect that in Co-developed-by: or Signed-off-by: , but if I
> > > understood well, the CoC requires that I am explicitly approved of those?
> > > 
> > 
> > If everyone else is okay, let's just apply this as-is.  You did all the
> > hard bits.
> > 
> > regards,
> > dan carpenter
> 
> If it is OK with you, then I hope I have your Reviewed-by:
>

Wow.  Sorry for all the delay on this.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

> I'm kinda still uncertain about the proper procedure.
> This certainly isn't "the perfect patch" :-)

Heh.

regards,
dan carpenter

