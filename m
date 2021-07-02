Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE313BA20C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jul 2021 16:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhGBOTj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jul 2021 10:19:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232877AbhGBOTi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jul 2021 10:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625235426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tMi3Gk50S6QZZwLtEEJLIX5NTGVI5NnqlaPba/zer+Y=;
        b=i10Hs7jmeSCkdjUfQ3tb01ghgCr5WyR7iqgndYso0yWiNpBt9AG8q0hrUrZbC9539IViWJ
        wru4eAPo8ekGK6LpAfAaNA6yCHVdaGHgnemb7vKRSGws+HpuQ2Mr4v6cKF/g9R0gSMD3Cb
        rOVujCSX31dEO4uuJPgbTHUgIFiuzbg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-wyKjrHe5Mwa-_BvoSxFBFA-1; Fri, 02 Jul 2021 10:17:04 -0400
X-MC-Unique: wyKjrHe5Mwa-_BvoSxFBFA-1
Received: by mail-wm1-f71.google.com with SMTP id z4-20020a1ce2040000b02901ee8d8e151eso6320934wmg.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jul 2021 07:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tMi3Gk50S6QZZwLtEEJLIX5NTGVI5NnqlaPba/zer+Y=;
        b=jp+GMiaqiBDFCwYDB0p/D2/C0L2BJBDUbFjgHP3hWW3T0OI3CTNfwFTHMikwee86yf
         TGXPMtwwkcDkgJTC+Qjw/6yfEsPazKseSBfQmL+ge8p0F2g82eyuBbf63au5DnhXatoZ
         FLbAgbZZSFD5Zqin27Bu0DM2yqic0Hi6sCfc6Zetv8keUgW+jJAOb4UaQ0BcelX+3lOE
         EUdOJJfMboJimwuJUVJKMBd7VjxXhiJ1ZytYA/I7hMbXWG4nzoUD6cMNvzP4taeSF9wu
         IerKdBxDiwWjgI4XK6ax6e8QPnV+qYGcFY5nP3cqJBSC4MxnaQIm1WlIPpjrXe8kN9lw
         C25Q==
X-Gm-Message-State: AOAM5318XwDUrbLLv1dOPoFxXjrBUtfBygcy8guo01t8wf+pjO2766ix
        V1m2qLFYu46AAWgdsX90gDqYjycH3H78q/0PtZ4jCZlLtueW+I56N7vLcKjli8r0pJ3RebD0+Ft
        KEfurVNzDuTGj7FYyTWhplXufINue
X-Received: by 2002:a7b:cc15:: with SMTP id f21mr16950280wmh.5.1625235423802;
        Fri, 02 Jul 2021 07:17:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrh1/hjcg1OWzXPbxCg3r0hNQaEsZsCiNHdC/uGI6Y/nvLWRP1RZMOQ1p54xZGzuFs5lDeYw==
X-Received: by 2002:a7b:cc15:: with SMTP id f21mr16950257wmh.5.1625235423626;
        Fri, 02 Jul 2021 07:17:03 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
        by smtp.gmail.com with ESMTPSA id k6sm1897319wrx.41.2021.07.02.07.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 07:17:01 -0700 (PDT)
Date:   Fri, 2 Jul 2021 10:16:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, brouer@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, will@kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH net-next v3 1/3] selftests/ptr_ring: add benchmark
 application for ptr_ring
Message-ID: <20210702100935-mutt-send-email-mst@kernel.org>
References: <1625142402-64945-1-git-send-email-linyunsheng@huawei.com>
 <1625142402-64945-2-git-send-email-linyunsheng@huawei.com>
 <e1ec4577-a48f-ff56-b766-1445c2501b9f@redhat.com>
 <91bcade8-f034-4bc7-f329-d5e1849867e7@huawei.com>
 <20210702042838-mutt-send-email-mst@kernel.org>
 <661a84bc-e7c5-bc21-25ac-75a68efa79ca@huawei.com>
 <1fed53f1-f882-ca67-8876-ca6702dcd9cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fed53f1-f882-ca67-8876-ca6702dcd9cd@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 02, 2021 at 05:04:44PM +0800, Jason Wang wrote:
> 
> 在 2021/7/2 下午4:46, Yunsheng Lin 写道:
> > On 2021/7/2 16:30, Michael S. Tsirkin wrote:
> > > On Fri, Jul 02, 2021 at 04:17:17PM +0800, Yunsheng Lin wrote:
> > > > > Let's reuse ptr_ring.c in tools/virtio/ringtest. Nothing virt specific there.
> > > > It *does* have some virtio specific at the end of ptr_ring.c.
> 
> 
> They are just wrappers to make ptr ring works like a virtio ring. We can
> split them out into another file if necessary.
> 
> 
> > > > It can be argued that the ptr_ring.c in tools/virtio/ringtest
> > > > could be refactored to remove the function related to virtio.
> > > > 
> > > > But as mentioned in the previous disscusion [1], the tools/virtio/
> > > > seems to have compile error in the latest kernel, it does not seems
> > > > right to reuse that.
> > > > And most of testcase in tools/virtio/ seems
> > > > better be in tools/virtio/ringtest instead，so until the testcase
> > > > in tools/virtio/ is compile-error-free and moved to tools/testing/
> > > > selftests/, it seems better not to reuse it for now.
> > > 
> > > That's a great reason to reuse - so tools/virtio/ stays working.
> > > Please just fix that.
> 
> 
> +1
> 
> 
> > I understand that you guys like to see a working testcase of virtio.
> > I would love to do that if I have the time and knowledge of virtio,
> > But I do not think I have the time and I am familiar enough with
> > virtio to fix that now.
> 
> 
> So ringtest is used for bench-marking the ring performance for different
> format. Virtio is only one of the supported ring format, ptr ring is
> another. Wrappers were used to reuse the same test logic.
> 
> Though you may see host/guest in the test, it's in fact done via two
> processes.
> 
> We need figure out:
> 
> 1) why the current ringtest.c does not fit for your requirement (it has SPSC
> test)
> 2) why can't we tweak the ptr_ring.c to be used by both ring_test and your
> benchmark
> 
> If neither of the above work, we can invent new ptr_ring infrastructure
> under tests/
> 
> Thanks

For me 1) is not a question.

All the available/used terminology is not an ideal fit for ptr ring.
With virtio buffers are always owned by driver (producer) so producer
has a way to find out if a buffer has been consumed.  With ptr ring
there's no way for producer to know a buffer has been consumed.
The test hacks around that but it is very reasonable
not to want to rely on that.

However 2) is very much a question. We can split ptr_ring
to the preamble and virtio related hacks.
So all the portability infrastructure for building
kernel code from userspace, command line parsing,
run-on-all.sh to figure out affinity effects,
all that can and should IMHO be reused and not copy-pasted.

> 
> > 
> > 

