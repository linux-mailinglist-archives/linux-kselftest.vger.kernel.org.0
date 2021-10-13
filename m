Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64ED042C160
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Oct 2021 15:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhJMN2O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 09:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhJMN2L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 09:28:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B4DC061570
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Oct 2021 06:26:08 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r7so8383748wrc.10
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Oct 2021 06:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4ZBC969FVok1eY2w7nMmmgvhC6HvUOJiXWHVhHaFOwU=;
        b=SQ0Rp6hvlW7gN0NVEBBstW2sqB4by4Ckf7kjf5i337dhcKAKP3eMkso5odE6ceCR+k
         5YUwti+PFCzR2dzDtdtC21eNr5SMfNESb0MnJ4DmfoRDqWwRDLU5o3F2NxOH1Fhz6wd9
         F5oSY29oFS5nyChuGBjeNjvkIRcBATGB3hZbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4ZBC969FVok1eY2w7nMmmgvhC6HvUOJiXWHVhHaFOwU=;
        b=a9PEh/tEfXrUCC4XkS6P/M38iKEDIsgjWt14+58fUvsgiKDROflQrZUGuqxbr7qnkv
         6O4Wrf18ODZmFjL3NM3kLeKgbu9KQShOFVY08Dnqw2X/TeUqGe3vXrV7AfP+XnWsd/wQ
         K50rdHdYouYXb75Lp6XhvpIwJ9a2eyHolQ0aMqrlQufb52eTnna0G3PUwEruPIgvXtxb
         oa5egk5d/B5Aj8K4PWeom+GBTwxwazv6M6Rd7hPPOvEfl8BSdf1meDX27k51HMD0HOaJ
         nDynJJgGblWMMwMIZ8XbyYRcyjcL15WNqt+oRkB/HK3i40tvs56OY6QMvk21WjOjhHt5
         LcBw==
X-Gm-Message-State: AOAM5327QxcaPmhi5xzkD/KA8Be3ZWCMxGNflqIIryl5eQaEYz3O4O4c
        X8BsqeTzck1xGnmp1eH74BHkAQ==
X-Google-Smtp-Source: ABdhPJxLknOsY+y5dglY3Mf+URYIj8Yvxtch0BAmgkFvyiT4UmA4TlWStXR+IldJYABbavd4nNE9fg==
X-Received: by 2002:a1c:7f56:: with SMTP id a83mr13368905wmd.20.1634131566597;
        Wed, 13 Oct 2021 06:26:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y191sm5963420wmc.36.2021.10.13.06.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:26:05 -0700 (PDT)
Date:   Wed, 13 Oct 2021 15:26:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <n@nfraprado.net>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@riseup.net>,
        Leandro Ribeiro <leandrohr@riseup.net>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Pedro Sader Azevedo <pedro.saderazevedo@protonmail.com>,
        isinyaaa <isabellabdoamaral@gmail.com>,
        ~lkcamp/discussion@lists.sr.ht
Subject: Re: DRM KUnit hackathon
Message-ID: <YWbea0x7i+z3N3gC@phenom.ffwll.local>
References: <20211011152333.gm5jkaog6b6nbv5w@notapiano>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211011152333.gm5jkaog6b6nbv5w@notapiano>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 11, 2021 at 10:23:33AM -0500, Nícolas F. R. A. Prado wrote:
> Hello,
> 
> We belong to a student group, LKCAMP [1], which is focused on sharing kernel and
> free software development knowledge and mentoring newcomers to become
> contributors to these projects.
> 
> As part of our efforts, we'll be organizing a hackathon to convert the drm
> selftests in drivers/gpu/drm/selftests/ (and possibly the ones in
> drivers/dma-buf too) to the KUnit framework. It will take place on October 30.
> 
> So please expect to receive some patches from our mentees on that date. It
> probably won't be a big volume (experience tells it'll be around half a dozen
> patches). We'll also make sure to do an internal review beforehand to catch
> common first-timer mistakes and teach the basics.
> 
> We're already working on making sure that the converted KUnit tests can still be
> run by IGT.
> 
> Please let us know if there's any issue with this date. Otherwise we look
> forward to helping a few newcomers get their patches in the kernel on the 30th
> :).

Welcome all, looking forward to cool stuff!

Cheers, Daniel

> 
> Thanks!
> 
> [1] - https://lkcamp.dev/

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
