Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF924A794A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 21:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiBBUQ0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 15:16:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235957AbiBBUQZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 15:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643832984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M34YrIYRx5HngPKL98NElbcSHiHeIbaZHCpXvZfxrIA=;
        b=O0jzB3E+CnfvehQTr9G4sX6i9rajV8lY3/moKL2N9PRvkct0bsyH8HEn+KhEjoLL8V2n0P
        frrDP3uQtI9keS02+46MnsiUExUOJiJy3BtVxhNzC5FpOiYVEViExtJcT6jJXsSOS72PpW
        uwKis3l9i4secZ9jIC0Nakhm1O2BfyY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-D8t5DQDAMhKknya7xx0hVw-1; Wed, 02 Feb 2022 15:16:23 -0500
X-MC-Unique: D8t5DQDAMhKknya7xx0hVw-1
Received: by mail-wr1-f71.google.com with SMTP id w19-20020adf8bd3000000b001df887ad0caso36444wra.18
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Feb 2022 12:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M34YrIYRx5HngPKL98NElbcSHiHeIbaZHCpXvZfxrIA=;
        b=Lc6aEEo7i1DjSIMYjEo46/BMwgiTkrgfaitCQrYMFqTgz6YC+kXaA1dKXpaWmT4zzp
         QCdh21dhvokuKF3Ftj8NLmX85iq0RNYc35HDS+t+iuocXImWDXUBt8LrzRibkDSyjFcA
         qzDScKcE6YcxkmRFSIDZuj8ypYx9MCNcum6kZYI3/FxrTi3lEZAuUB0lUEKfUF2OBrPt
         fT4g5aCu4OyUIuZY/IyqDRT9Ty+owevLgQx7cRI4SMa65OLdDcwAVUN11xnYnQsFfRCP
         9OaFoHEedv3KFd5mnQOIRrDYmfHIgf0oWzH3w9+wtwqovNO870fq+WhSaZpUJyGB4Esp
         NOGw==
X-Gm-Message-State: AOAM531QkBvallIlXT3I52zU3HtD3jAiVAtgaMa/geqWRwQ+yu7mQlMQ
        s7NLoOXjftI+Qyn7HeSSDNeq7OYo9QpuwnlGHgOU1JevpcPumeOjct9iKyl4Z2gBrdRLovRpSdT
        HLxjLipL5sUkvfyEBc1SPkFIBGTSK
X-Received: by 2002:a05:600c:219:: with SMTP id 25mr7491249wmi.68.1643832982401;
        Wed, 02 Feb 2022 12:16:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznM6hdgXQKcOhe6meRwxJx1EhhNNyS49Jthx0+vJQbr68vmdKFg7oX84c6XqbFBP9VWLPZeQ==
X-Received: by 2002:a05:600c:219:: with SMTP id 25mr7491233wmi.68.1643832982208;
        Wed, 02 Feb 2022 12:16:22 -0800 (PST)
Received: from pc-4.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id f16sm7475036wmg.28.2022.02.02.12.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 12:16:19 -0800 (PST)
Date:   Wed, 2 Feb 2022 21:16:14 +0100
From:   Guillaume Nault <gnault@redhat.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ido Schimmel <idosch@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>
Subject: Re: [PATCH net-next] selftests: fib offload: use sensible tos values
Message-ID: <20220202201614.GB15826@pc-4.home>
References: <5e43b343720360a1c0e4f5947d9e917b26f30fbf.1643826556.git.gnault@redhat.com>
 <54a7071e-71ad-0c7d-ccc4-0f85dbe1e077@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54a7071e-71ad-0c7d-ccc4-0f85dbe1e077@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 02, 2022 at 12:46:10PM -0700, Shuah Khan wrote:
> On 2/2/22 11:30 AM, Guillaume Nault wrote:
> > Although both iproute2 and the kernel accept 1 and 2 as tos values for
> > new routes, those are invalid. These values only set ECN bits, which
> > are ignored during IPv4 fib lookups. Therefore, no packet can actually
> > match such routes. This selftest therefore only succeeds because it
> > doesn't verify that the new routes do actually work in practice (it
> > just checks if the routes are offloaded or not).
> > 
> > It makes more sense to use tos values that don't conflict with ECN.
> > This way, the selftest won't be affected if we later decide to warn or
> > even reject invalid tos configurations for new routes.
> 
> Wouldn't it make sense to leave these invalid values in the test though.
> Removing these makes this test out of sync withe kernel.

Do you mean keeping the test as is and only modify it when (if) we
decide to reject such invalid values? Or to write two versions of the
test, one with invalid values, the other with correct ones?

I don't get what keeping a test with the invalid values could bring us.
It's confusing for the reader, and might break in the future. This
patch makes the test future proof, without altering its intent and code
coverage. It still works on current (and past) kernels, so I don't see
what this patch could make out of sync.

Or did I misunderstand something?

> thanks,
> -- Shuah
> 

