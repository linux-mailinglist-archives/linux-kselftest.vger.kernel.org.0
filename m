Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D3570ED24
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 07:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbjEXFe1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 01:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjEXFe0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 01:34:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2B7B3;
        Tue, 23 May 2023 22:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7NBHbi9ILV5K2XOPA/YNxTHAVu54oCQY3AF1O0ytJMY=; b=d+K7gCAJK1eLJgkGXUen+xrbON
        qO+cHEwFKx29uga6UbywQj9jby9fFfIKE4u0iPTwmRkduhqqZkjF1f5tN2xSUB6tsXIdpfwm15VNx
        I1NoKopB78eFxNkxxCE4GYWOjKa5zdbXbyYL1bvV6a7HC519N97DvkaduZynnd+wmGO/fn+Pn2Xgd
        HZnpuhvnEqgl3605xe2OKUr4ptcGIi5MWqx4DxbALYc+7AacE+0+hlxJAtDwlCY8ZY+XWua+l09QJ
        bs9P18D9zFXcZJh5ums0CGh3pqtv+GvJHTy+BdKlJuJPDe39IpWO79B/cq88BvQOITQO+XfGW3W95
        RWsNe0iA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1h8h-00CPie-17;
        Wed, 24 May 2023 05:34:23 +0000
Date:   Tue, 23 May 2023 22:34:23 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-kernel@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [RESEND PATCH v5 2/3] test_firmware: fix a memory leak with reqs
 buffer
Message-ID: <ZG2h34KzhQWONNec@bombadil.infradead.org>
References: <20230509084746.48259-1-mirsad.todorovac@alu.unizg.hr>
 <20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr>
 <256bc822-ba20-c41a-1f3b-5b6aacead32e@alu.unizg.hr>
 <f9212fd0-0a52-4076-a97a-c5af8de194cf@kili.mountain>
 <72257758-a0e6-1118-f397-431ac9ec3059@alu.unizg.hr>
 <828b1d4c-dac8-4a64-9f1d-452762dc07bd@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <828b1d4c-dac8-4a64-9f1d-452762dc07bd@kili.mountain>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 18, 2023 at 06:20:37PM +0300, Dan Carpenter wrote:
> On Fri, May 12, 2023 at 08:58:58PM +0200, Mirsad Goran Todorovac wrote:
> > On 12. 05. 2023. 15:09, Dan Carpenter wrote:
> > > On Fri, May 12, 2023 at 02:34:29PM +0200, Mirsad Todorovac wrote:
> > > > > @@ -1011,6 +1016,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
> > > > >    	mutex_lock(&test_fw_mutex);
> > > > > +	if (test_fw_config->reqs) {
> > > > > +		rc = -EBUSY;
> > > > > +		goto out_bail;
> > > > > +	}
> > > > > +
> > > > >    	test_fw_config->reqs =
> > > > >    		vzalloc(array3_size(sizeof(struct test_batched_req),
> > > > >    				    test_fw_config->num_requests, 2));
> > > > 
> > > > I was just thinking, since returning -EBUSY for the case of already allocated
> > > > test_fw_config->reqs was your suggestion and your idea, maybe it would be OK
> > > > to properly reflect that in Co-developed-by: or Signed-off-by: , but if I
> > > > understood well, the CoC requires that I am explicitly approved of those?
> > > > 
> > > 
> > > If everyone else is okay, let's just apply this as-is.  You did all the
> > > hard bits.
> > > 
> > > regards,
> > > dan carpenter
> > 
> > If it is OK with you, then I hope I have your Reviewed-by:
> >
> 
> Wow.  Sorry for all the delay on this.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> 

Thanks for doing this work! It looks much better now split up!

For all 3 patches:

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

Greg, can you pick these up?

  Luis
