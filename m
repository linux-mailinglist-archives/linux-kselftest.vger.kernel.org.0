Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15933ABF26
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 01:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhFQXFq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 19:05:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36360 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhFQXFn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 19:05:43 -0400
Received: from mail-oo1-f72.google.com ([209.85.161.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth.forshee@canonical.com>)
        id 1lu12q-000772-7H
        for linux-kselftest@vger.kernel.org; Thu, 17 Jun 2021 23:03:32 +0000
Received: by mail-oo1-f72.google.com with SMTP id c25-20020a4ad7990000b029020e67cc1879so4714484oou.18
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 16:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OkOjqJxD0z2koDXpHJI7UZUHHI+CEV8nA90EeoMOpKs=;
        b=fxUgCbkuSqOX72HrTy3lHxMpDXQxqpC8mkTzVHtuzsw7InTlUFWjHL8sI1eqqniwNa
         a+CB0KDcidpar/7zpciXsuK0NehyAC1CW7HcIJC7eFy1H93ErNOQcxNyfydRjdqNScN7
         /CG5JbxrGVXQrNUAVTlcN0SfyV3Jrt8N/m6Gj9E+c82GIBpEZYm2HwNzIadTznZqm2IU
         94qjwfKWfvYxLGoHuUBn4Js40Tae5oYQl3MYTn2p1YftyDJAY8nMyV1OVDyFsDrxOglh
         pXn8h4lmBBnzVHm6ooZEbEOBjNWPNmfwUfI2btA2DqMDx1kcnObXsHMaI3S+aYOIY0UI
         yNAw==
X-Gm-Message-State: AOAM530ow7P1dpjSmTlwqPJLIiUX3On3YUYzeKMrzBnfWDp7XG1olj4k
        p0dJSLTE2fg/bqqYPbl2/RHJjxLB1cIVmu7bKqIntTAvY22yd1jPvVq+YrywW55Q0dRkjMyBE8f
        9gTefElfWFS1/JYzbHsza40ytSpazMk4uWO6mzvVWVE8Qqg==
X-Received: by 2002:aca:af42:: with SMTP id y63mr12370935oie.119.1623971011202;
        Thu, 17 Jun 2021 16:03:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDiTg+Y4j0hQ3bdU6IkDKIwKk8ZbqFkka3mLb3akP9nl6lPOsoFHzTgBPK77GK8cl7ZiURTQ==
X-Received: by 2002:aca:af42:: with SMTP id y63mr12370920oie.119.1623971010978;
        Thu, 17 Jun 2021 16:03:30 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:8210:d9c3:c7eb:5ca4])
        by smtp.gmail.com with ESMTPSA id w22sm1231956oou.36.2021.06.17.16.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 16:03:30 -0700 (PDT)
Date:   Thu, 17 Jun 2021 18:03:29 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Pooja Trivedi <pooja.trivedi@stackpath.com>,
        Josh Tway <josh.tway@stackpath.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: Hangs during tls multi_chunk_sendfile selftest
Message-ID: <YMvUwVcOSkuBDxdg@ubuntu-x1>
References: <YMumgy19CXCk5rZD@ubuntu-x1>
 <20210617142234.272cc686@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617142234.272cc686@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 17, 2021 at 02:22:34PM -0700, Jakub Kicinski wrote:
> On Thu, 17 Jun 2021 14:46:11 -0500 Seth Forshee wrote:
> > I've observed that the tls multi_chunk_sendfile selftest hangs during
> > recv() and ultimately times out, and it seems to have done so even when
> > the test was first introduced. 
> 
> It hangs yet it passes? I lost track of this issue because the test
> does pass on my system:
> 
> # PASSED: 183 / 183 tests passed.
> # Totals: pass:183 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> $ uname -r
> 5.12.9-300.fc34.x86_64

It doesn't pass with Ubuntu kernels:

 #  RUN           tls.12_gcm.multi_chunk_sendfile ...
 # multi_chunk_sendfile: Test terminated by timeout
 #          FAIL  tls.12_gcm.multi_chunk_sendfile
 not ok 6 tls.12_gcm.multi_chunk_sendfile
 ...
 #  RUN           tls.13_gcm.multi_chunk_sendfile ...
 # multi_chunk_sendfile: Test terminated by timeout
 #          FAIL  tls.13_gcm.multi_chunk_sendfile
 not ok 51 tls.13_gcm.multi_chunk_sendfile
 ...
 #  RUN           tls.12_chacha.multi_chunk_sendfile ...
 # multi_chunk_sendfile: Test terminated by timeout
 #          FAIL  tls.12_chacha.multi_chunk_sendfile
 not ok 96 tls.12_chacha.multi_chunk_sendfile
 ...
 #  RUN           tls.13_chacha.multi_chunk_sendfile ...
 # multi_chunk_sendfile: Test terminated by timeout
 #          FAIL  tls.13_chacha.multi_chunk_sendfile
 not ok 141 tls.13_chacha.multi_chunk_sendfile
 ...
 # FAILED: 177 / 183 tests passed.
 # Totals: pass:177 fail:6 xfail:0 xpass:0 skip:0 error:0

 $ uname -r
 5.13.0-7-generic

The results are the same with 5.12, etc. Maybe some difference in
configs.

> > Reading through the commit message when
> > it was added (0e6fbe39bdf7 "net/tls(TLS_SW): Add selftest for 'chunked'
> > sendfile test") I get the impression that the test is meant to
> > demonstrate a problem with ktls, but there's no indication that the
> > problem has been fixed.
> 
> Yeah, the fix was discussed here:
> 
> https://lore.kernel.org/netdev/1591392508-14592-1-git-send-email-pooja.trivedi@stackpath.com/
> 
> IDK why it stalled to be honest :S

Hopefully it can make some progress now.

Thanks,
Seth
