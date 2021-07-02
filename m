Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7C93BA20F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jul 2021 16:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhGBOV3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jul 2021 10:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232835AbhGBOV2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jul 2021 10:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625235536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Tmnk6NTqIwQaw9HO12m6EJuJudAO8fFlW1SWYpJaZU=;
        b=UObia4gWuxmNFTkchUrywcFcQbJuUW4XDuRHzmX/2V5wUqeXUzkSfSHhxwuSVIKkLMk7Sc
        zK33mL+C5DmYb3QrPYBYEErTbWsrEqpafMSyd7H9g1g5KS6UVWBXvOt+hkztBjabwYSReR
        BSw9KmZfSCY4DOHgtvyr+j2MEwJ1rhU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-VjUVCsp4OYOXpcgJud6odw-1; Fri, 02 Jul 2021 10:18:55 -0400
X-MC-Unique: VjUVCsp4OYOXpcgJud6odw-1
Received: by mail-wm1-f71.google.com with SMTP id u64-20020a1cdd430000b02901ed0109da5fso6312599wmg.4
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jul 2021 07:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Tmnk6NTqIwQaw9HO12m6EJuJudAO8fFlW1SWYpJaZU=;
        b=jhdsXm6PRstDFliwigRi0393nklSKQlawDTzu2cc3Td5kv/TgA8j+eaJNnAQOqYt2r
         AyjVWsU9gLzCYtG7KxIcC6sKHytmClaz45hfw9yKGjoV2xFUJm1i+npspcgkIm1ZPeOO
         1nCiy+9I4ateW+kODcdIB0yk+AN6f7lV6nJ9BEgBS4h8sGVo6QTXHawVImfWigiQLBYK
         GNA9Pmi7xchbUiATfELVM09fKvXnZVFZMYmuYSKdOM08sUxB6Y2/MFxtse4PMbLHYFxe
         Fudru/hZKlPEM9PJFM3z6WHynerwV2t6KdVLluPkv+Q+H52P7HLcfKgT9VkNAc8hwMEK
         9Omg==
X-Gm-Message-State: AOAM530XnR4/mDm1MZqJZojFlrdzCFUC7Cb62Wp5eCURu6OyrkHYfc9H
        QlVi1Y8o6LPMI8MFkNs8/jVCpGiSqWM3CUZAsY2xzcj96cpA13N/Ff1s8qKqEtaB9ql5TUXRdfm
        Iox07nMMeSBglZ1s3LM4wfCZVZr+N
X-Received: by 2002:a5d:6cca:: with SMTP id c10mr6354684wrc.166.1625235533951;
        Fri, 02 Jul 2021 07:18:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOrt5j3Tz6hpHgUZechMmvug4vqpFGOeg7tNyylDFDYJIBJWiPhZTe1usBN5qw3c9nmrTYww==
X-Received: by 2002:a5d:6cca:: with SMTP id c10mr6354671wrc.166.1625235533812;
        Fri, 02 Jul 2021 07:18:53 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
        by smtp.gmail.com with ESMTPSA id w13sm3653960wrl.47.2021.07.02.07.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 07:18:41 -0700 (PDT)
Date:   Fri, 2 Jul 2021 10:18:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Jason Wang <jasowang@redhat.com>, davem@davemloft.net,
        kuba@kernel.org, brouer@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, will@kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH net-next v3 1/3] selftests/ptr_ring: add benchmark
 application for ptr_ring
Message-ID: <20210702101730-mutt-send-email-mst@kernel.org>
References: <1625142402-64945-1-git-send-email-linyunsheng@huawei.com>
 <1625142402-64945-2-git-send-email-linyunsheng@huawei.com>
 <e1ec4577-a48f-ff56-b766-1445c2501b9f@redhat.com>
 <91bcade8-f034-4bc7-f329-d5e1849867e7@huawei.com>
 <20210702042838-mutt-send-email-mst@kernel.org>
 <661a84bc-e7c5-bc21-25ac-75a68efa79ca@huawei.com>
 <1fed53f1-f882-ca67-8876-ca6702dcd9cd@redhat.com>
 <06f0dc67-d614-30d3-6dcc-f2446cb6030b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06f0dc67-d614-30d3-6dcc-f2446cb6030b@huawei.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 02, 2021 at 05:54:42PM +0800, Yunsheng Lin wrote:
> On 2021/7/2 17:04, Jason Wang wrote:
> > 
> 
> [...]
> 
> > 
> > 
> >> I understand that you guys like to see a working testcase of virtio.
> >> I would love to do that if I have the time and knowledge of virtio,
> >> But I do not think I have the time and I am familiar enough with
> >> virtio to fix that now.
> > 
> > 
> > So ringtest is used for bench-marking the ring performance for different format. Virtio is only one of the supported ring format, ptr ring is another. Wrappers were used to reuse the same test logic.
> > 
> > Though you may see host/guest in the test, it's in fact done via two processes.
> > 
> > We need figure out:
> > 
> > 1) why the current ringtest.c does not fit for your requirement (it has SPSC test)
> 
> There is MPSC case used by pfifo_fast, it make more sense to use a separate selftest
> for ptr_ring as ptr_ring has been used by various subsystems.
> 
> 
> > 2) why can't we tweak the ptr_ring.c to be used by both ring_test and your benchmark
> 
> Actually that is what I do in this patch, move the specific part related to ptr_ring
> to ptr_ring_test.h. When the virtio testing is refactored to work, it can reuse the
> abstract layer in ptr_ring_test.h too.

Sounds good. But that refactoring will be up to you as a contributor.

> > 
> > If neither of the above work, we can invent new ptr_ring infrastructure under tests/
> > 
> > Thanks
> > 
> > 
> >>
> >>
> > 
> > .
> > 

