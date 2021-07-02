Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CB93B9D8C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jul 2021 10:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhGBId1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jul 2021 04:33:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhGBId0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jul 2021 04:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625214654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ebqrOg7XijUonFvzMVuLSVbgtaPdYEqUj8mLxx77yyo=;
        b=gYqBAmEJ1MxYRjABYjxST3xWZGGGZK2clHZIRECjMo69cGRyGq4FW2wNVLjyXJe6PXQYAP
        gA/33rRJ/yiQYmJwoAo2Y1X6fNXE7h6ngPSNLJIPeYWzncXVkUQHgHZX2rvl4PEQaMXhVL
        mDDTLH76QGpJXalZK1Vg1fzIZ+ZDxp8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-XvFPiOnHM3qE07vA4BCepA-1; Fri, 02 Jul 2021 04:30:53 -0400
X-MC-Unique: XvFPiOnHM3qE07vA4BCepA-1
Received: by mail-wm1-f70.google.com with SMTP id z127-20020a1c7e850000b02901e46e4d52c0so5950520wmc.6
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jul 2021 01:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ebqrOg7XijUonFvzMVuLSVbgtaPdYEqUj8mLxx77yyo=;
        b=b6WzWpubYlrJibt1U8XyDxovDN5gmrr7pj/yDoae4ZY2h71Vl7pEkQlXVwDGdQzM9K
         nqic3UuBkuuYeYKMShjl/J1njP9h46jPCxhflF+oeX1UEMSMjz7sxzKv3xzqzPys/9Co
         VBurel4NKedKIwaXvBL2DmoORwy3FkY97AkNRdurp5cDF+DO4FIWbCh+ouKwU3Ih1sTl
         k6uC7M5LW6hxfq8q3NCDPgZTODIDZuiHK6uHAYDsQGMVK5YpL0JlJfGKlVBneOJ5sp9c
         3HI8kuy06wZsPHzgyvsFpTuyBVor7QW6TR85R0auWax/vSo0mHawwHeQqXTSvcXqd4SV
         glCw==
X-Gm-Message-State: AOAM530VorFJPyqDjnS2SQhYs9LqyxadUOyzxhTtr1j8UCZzwIZP/upR
        0RzB3Njtq+qhOk4K8WjshrdypsCJ2YavtdGV6TsANq50jSLE+1XYtpLyIaKdd3mZWlcoSGqGqjY
        p0pM7DSbV2MH6+xBTb4tO1a6lVTsV
X-Received: by 2002:adf:e6c4:: with SMTP id y4mr1967231wrm.4.1625214652708;
        Fri, 02 Jul 2021 01:30:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8uIwBip3ssxhZ0C7gznIuoJUVg/I2BZmKaIPk2T4beqCdTMa/NQLxn0hIFA0PybOGMb40GA==
X-Received: by 2002:adf:e6c4:: with SMTP id y4mr1967207wrm.4.1625214652525;
        Fri, 02 Jul 2021 01:30:52 -0700 (PDT)
Received: from redhat.com ([2.55.143.136])
        by smtp.gmail.com with ESMTPSA id k6sm897496wrx.41.2021.07.02.01.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 01:30:51 -0700 (PDT)
Date:   Fri, 2 Jul 2021 04:30:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     Jason Wang <jasowang@redhat.com>, davem@davemloft.net,
        kuba@kernel.org, brouer@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, will@kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [PATCH net-next v3 1/3] selftests/ptr_ring: add benchmark
 application for ptr_ring
Message-ID: <20210702042838-mutt-send-email-mst@kernel.org>
References: <1625142402-64945-1-git-send-email-linyunsheng@huawei.com>
 <1625142402-64945-2-git-send-email-linyunsheng@huawei.com>
 <e1ec4577-a48f-ff56-b766-1445c2501b9f@redhat.com>
 <91bcade8-f034-4bc7-f329-d5e1849867e7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91bcade8-f034-4bc7-f329-d5e1849867e7@huawei.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 02, 2021 at 04:17:17PM +0800, Yunsheng Lin wrote:
> > Let's reuse ptr_ring.c in tools/virtio/ringtest. Nothing virt specific there.
> 
> It *does* have some virtio specific at the end of ptr_ring.c.
> It can be argued that the ptr_ring.c in tools/virtio/ringtest
> could be refactored to remove the function related to virtio.
> 
> But as mentioned in the previous disscusion [1], the tools/virtio/
> seems to have compile error in the latest kernel, it does not seems
> right to reuse that.
> And most of testcase in tools/virtio/ seems
> better be in tools/virtio/ringtest instead，so until the testcase
> in tools/virtio/ is compile-error-free and moved to tools/testing/
> selftests/, it seems better not to reuse it for now.


That's a great reason to reuse - so tools/virtio/ stays working.
Please just fix that.

-- 
MST

