Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1250570089F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 May 2023 15:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbjELNJo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 May 2023 09:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240471AbjELNJn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 May 2023 09:09:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F285D850
        for <linux-kselftest@vger.kernel.org>; Fri, 12 May 2023 06:09:42 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-306dbad5182so6592377f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 May 2023 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683896981; x=1686488981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tMHC1baICqbV/7IIejzzefa+PcpliFHn4ViPUWBkzwk=;
        b=nWdKOyt2/UbR8Uu1VEhhE0dtqojxGY5VLr2j4rxfWqEYlyoMQiirm9eeUQUileh9yP
         0xe9zumAgOQSRTbDDV4nipBC7G9wiQkNrFwXSavhsfJjC37gfftYnUN6e0vOKa7KabnY
         PyXDE4TKxk5eVWjC8SOrRiCj6RN9wOluBZdhJxkHzDDssOMy3ZZrRaYmDHmDBGMGvnUn
         kxSDKf9u/omSXSkHcCvnq6pTQct7ws0uCsOBcZ6eB3Vxeim+9O5uFPl5yfMLsl8ZPSfE
         0SGrN2xJMPi9LepKp+FRZmwiQ25F5BrWXuocFamnMgXEkpIHeR97ZrpTNt1FMTuP8RGG
         xa+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683896981; x=1686488981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMHC1baICqbV/7IIejzzefa+PcpliFHn4ViPUWBkzwk=;
        b=ehWttt0ktZXJliqcCSJoef+f19Up/5XfqvF1aQHstqGl0V5omxpZv8E2oiMTP1mhyO
         Yv9fURlS0BrbrNROTC4scXhXJnQaBm6V0zw6Cx3eRVhhuNe0YZ8HHZusTTx6s4Ltrook
         yXe3qxFtOWu73onWejuVtRAOMS01hf3KHI8XigDe6YC0o2j1kQeQyR44na4S0JpAiD2G
         cTfyR1cNzqA7c/aGuYo/bpYAulOETgyeYt6zoelWhXIFGnndMzWD42Apb7TVfxQXsgNM
         frNfU42sDM+bx4IH+55Eh66hZtHIXllIa4oNvAQvhJT2A30Xr8KJcBDWLsSVwtaSxiHY
         BgDg==
X-Gm-Message-State: AC+VfDxvZvDk6OVNbfQNImvs3pIX6Gn84JrQFTHv26MoNHY6KlKMqSXn
        zn1WwGiGMP0PPt3k7x6NHk+foQ==
X-Google-Smtp-Source: ACHHUZ59NczSqJnrxH1ndGi0y5Kc1/VmRGX7UGYYwolAm1YtFlu/EuyXwbF2gyTqfu3MM6wlfkq55A==
X-Received: by 2002:adf:e84e:0:b0:306:35fa:202b with SMTP id d14-20020adfe84e000000b0030635fa202bmr16017563wrn.6.1683896980871;
        Fri, 12 May 2023 06:09:40 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d58c1000000b00306c5900c10sm23226447wrf.9.2023.05.12.06.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:09:39 -0700 (PDT)
Date:   Fri, 12 May 2023 16:09:33 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
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
Message-ID: <f9212fd0-0a52-4076-a97a-c5af8de194cf@kili.mountain>
References: <20230509084746.48259-1-mirsad.todorovac@alu.unizg.hr>
 <20230509084746.48259-2-mirsad.todorovac@alu.unizg.hr>
 <256bc822-ba20-c41a-1f3b-5b6aacead32e@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <256bc822-ba20-c41a-1f3b-5b6aacead32e@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 12, 2023 at 02:34:29PM +0200, Mirsad Todorovac wrote:
> > @@ -1011,6 +1016,11 @@ ssize_t trigger_batched_requests_async_store(struct device *dev,
> >   	mutex_lock(&test_fw_mutex);
> > +	if (test_fw_config->reqs) {
> > +		rc = -EBUSY;
> > +		goto out_bail;
> > +	}
> > +
> >   	test_fw_config->reqs =
> >   		vzalloc(array3_size(sizeof(struct test_batched_req),
> >   				    test_fw_config->num_requests, 2));
> 
> I was just thinking, since returning -EBUSY for the case of already allocated
> test_fw_config->reqs was your suggestion and your idea, maybe it would be OK
> to properly reflect that in Co-developed-by: or Signed-off-by: , but if I
> understood well, the CoC requires that I am explicitly approved of those?
> 

If everyone else is okay, let's just apply this as-is.  You did all the
hard bits.

regards,
dan carpenter

