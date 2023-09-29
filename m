Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31217B2AB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Sep 2023 05:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjI2DtL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 23:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjI2DtJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 23:49:09 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673FE1AE
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 20:49:05 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7742be66bd3so656829985a.3
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 20:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695959344; x=1696564144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNSXAAGAWzfjZ8B3Y6lB+Lau8VDFKMg7uOankBJ5jh4=;
        b=eMxxIvxPl6uH0l2l1PuCY71Kpxo+7eZOgbGmVcl/vLk4upVmAdTmMocgMENFRCO3d2
         LJxV21UaVHaHo+/RpvwPsOiiegxxd7I3nNykDQbCfQzEBu/pEKyRr350hIiiVl8AlLLW
         qHotkpPRFBLJ9zYeyGnyAbSMFCw0IkRooy0YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695959344; x=1696564144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNSXAAGAWzfjZ8B3Y6lB+Lau8VDFKMg7uOankBJ5jh4=;
        b=ck6q8dbzbEtSgO/KEmbiXT+lXaOVvFGo8RwZ8VpoE79E7dv6CAuzL/FfQVPXD6EsZX
         MMJzlg+qPV0xxSRBMtBF4FfWH1WEUzHs2Qdu8tyK2DD0V2Gv91xchJn8jM34MRxa81v2
         yD/psMPx2k0BEzBzqeqb21OE1IIBC/4GWowTVc/AjmDq5nfSZO7Wh5Sf9H0xo24UrDWd
         MC2SUroa8OahsaE2tEGIfjBmPrXRnA6EAnegZyxvY2aFpadaRfHzv+OTQg9UOGAV2syI
         TlrtDnaBYh9VW1X2xbnBda4/SyfNW8dRRPPxf8ZEGErNjEk0c1tTBzwOnO68c2ShKTR6
         x8Kg==
X-Gm-Message-State: AOJu0YywLFf3fNjRUjerHjzTIZsYMCjDPLaUV62APDpqldyrctpcyLkV
        MfL8MJrVc8JgVnaCEAMmrF8MHM/JHNGPs77rptM=
X-Google-Smtp-Source: AGHT+IFe6RVd12uwV33Kq35S412L+c1W/V78fMpX9SCcxHSRycyjSn9RNdW6/qwMtOYovhyI14rnQA==
X-Received: by 2002:a05:620a:12f1:b0:774:13e:71cd with SMTP id f17-20020a05620a12f100b00774013e71cdmr2766118qkl.56.1695959344459;
        Thu, 28 Sep 2023 20:49:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b20-20020aa78114000000b006930db1e6d1sm5622071pfi.203.2023.09.28.20.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 20:49:03 -0700 (PDT)
Date:   Thu, 28 Sep 2023 20:49:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        tony.luck@intel.com, gpiccoli@igalia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/5] pstore: add tty frontend and multi-backend
Message-ID: <202309282030.8CE179EBB@keescook>
References: <20230928024244.257687-1-xiangzao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928024244.257687-1-xiangzao@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 28, 2023 at 10:42:39AM +0800, Yuanhe Shu wrote:
> In public cloud scenario, if kdump service works abnormally,
> users cannot get vmcore. Without vmcore, user has no idea why the
> kernel crashed. Meanwhile, there is no additional information
> to find the reason why the kdump service is abnormal.
> 
> One way is to obtain console messages through VNC. The drawback 
> is that VNC is real-time, if user missed the timing to get the VNC
> output, the crash needs to be retriggered.
> 
> Another way is to enable the console frontend of pstore and record the
> console messages to the pstore backend. On the one hand, the console
> logs only contain kernel printk logs and does not cover
> user-mode print logs. Although we can redirect user-mode logs to the
> pmsg frontend provided by pstore, user-mode information related to
> booting and kdump service vary from systemd, kdump.sh, and so on which
> makes redirection troublesome. So we added a tty frontend and save all
> logs of tty driver to the pstore backend.

This is a clever solution!

> Another problem is that currently pstore only supports a single backend.
> For debugging kdump problems, we hope to save the console logs and tty
> logs to the ramoops backend of pstore, as it will not be lost after
> rebooting. If the user has enabled another backend, the ramoops backend
> will not be registered. To this end, we add the multi-backend function
> to support simultaneous registration of multiple backends.

Ah very cool; I really like this idea. I'd wanted to do it for a while
just to make testing easier, but I hadn't had time to attempt it.

> Based on the above changes, we can enable pstore in the crashdump kernel
> and save the console logs and tty logs to the ramoops backend of pstore.
> After rebooting, we can view the relevant logs by mounting the pstore
> file system.

So, before I do a line-at-a-time review of this code, I'd like to
address some design issues first.

I really don't want to make behavioral differences when we don't have
to:

- The multi-backend will enable _all possible_ backends, and that's a
  big change that will do weird things for some pstore users. I would
  prefer a pstore option to opt-in to enabling all backends. Perhaps
  have "pstore.backend=" be parsed with commas, so a list of backends
  can be provided, or "all" for the "all backends" behavior.

- Moving the pstorefs files into a subdirectory will break userspace
  immediately (e.g. systemd-pstore expects very specifically named
  files). Using subdirectories seems like a good idea, but perhaps
  we need hardlinks into the root pstorefs for the "first" backend,
  or some other creative solution here.

Then some technical thoughts about the TTY frontend's behavior:

- That 2 pstore records are created for every line of TTY output
  feels kind of inefficient, though I don't have a better idea.
  This is really only doable as you have it because the ramoops
  and zone backends treat the single prz as a circular buffer.
  I wonder about supporting this on other backends like EFI, but
  perhaps it's just not going to happen.

- I'd like to check with the TTY folks to see if this is the "right"
  place to hook to get a copy of what's being written.

Thanks and let me know what you think!

-Kees

-- 
Kees Cook
