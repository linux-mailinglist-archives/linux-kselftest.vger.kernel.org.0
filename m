Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750323B3B39
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 05:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhFYDi5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Jun 2021 23:38:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32830 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233085AbhFYDi4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Jun 2021 23:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624592196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n6YWGZCgKdORiyTIspLBMoxf3AjxZ1H1bG+LhjiRSD4=;
        b=Ek6o8ymkzxf+/v25xdnxUgHWqKmj9VdcJhLqOR1UlYAoEcLtgOmcq/Jdqiab0uHtB0zter
        Nux+z5R2LjKikDL+Q1s23lQAFOv1k3QFU7G4TF/qvcpWTKcXROwKcrOmHYLlE/tYydqlw6
        RJhnKJgW31KCpF9Rpltg+KjApiV8igk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-JaGBgziiPFW8se6VTkEkqg-1; Thu, 24 Jun 2021 23:36:32 -0400
X-MC-Unique: JaGBgziiPFW8se6VTkEkqg-1
Received: by mail-pj1-f69.google.com with SMTP id om5-20020a17090b3a85b029016eb0b21f1dso4750325pjb.4
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Jun 2021 20:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=n6YWGZCgKdORiyTIspLBMoxf3AjxZ1H1bG+LhjiRSD4=;
        b=fIdAaftXzbsS9VND5mHxTZWucKecxAci+Uc4uuZq40rwAlqBYFr+2/ezw+sJHbBbLy
         +7EJ9eWrFdWqMZJFBsy/yd4X1P4kz303S5wvsxyVwFbwZXOS7XBJlI/A4sfnzQ5cMuZq
         xFvcR0vBtn3XjDc4n/zYGGr/IjiG5p3F8fNQ7TezodxcWiblVMyff7iRvjCGs1gRo4Vi
         /o0ci+Rtu5JmTFPMVE6PR7ElhiTM3Hml9QqdWeeAujg7gs+vrIrdx5x/rHIbeG21EfzR
         Za5V1temmJZY5mziyDO9zxgBCOBA1qnIbmBGAMJidbL94Q337sliojMfW2y9XxI9i4bQ
         Wvxg==
X-Gm-Message-State: AOAM531mzKKSEnLPdOBPEM2XBbC6eFmENXvx5HDn+pD/G4nN3zVUMg4m
        DCKwGj5BzF7cFCuyWO8P2eFrfoXzdDxRxG3MXog+5Ws4vPFECBuidhMd7Cigr0u/HxuaxZUMemZ
        ZSlpPVsdMMm2w2snztcpzPfrTXHlF
X-Received: by 2002:a62:1914:0:b029:304:502e:8a4c with SMTP id 20-20020a6219140000b0290304502e8a4cmr8395207pfz.63.1624592191580;
        Thu, 24 Jun 2021 20:36:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoLNm1pYRdlFPxoooLwqhPAkuDyU5Xx85yhUXY44HZvMOs5voXOZZ4mcLAUSUMRHvm/vxt4g==
X-Received: by 2002:a62:1914:0:b029:304:502e:8a4c with SMTP id 20-20020a6219140000b0290304502e8a4cmr8395183pfz.63.1624592191332;
        Thu, 24 Jun 2021 20:36:31 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y206sm3980669pfb.3.2021.06.24.20.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 20:36:30 -0700 (PDT)
Subject: Re: [PATCH net-next v2 1/2] selftests/ptr_ring: add benchmark
 application for ptr_ring
To:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, mst@redhat.com
Cc:     brouer@redhat.com, paulmck@kernel.org, peterz@infradead.org,
        will@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linuxarm@openeuler.org
References: <1624591136-6647-1-git-send-email-linyunsheng@huawei.com>
 <1624591136-6647-2-git-send-email-linyunsheng@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ff47ed0b-332d-2772-d6e1-8277ac602c8c@redhat.com>
Date:   Fri, 25 Jun 2021 11:36:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1624591136-6647-2-git-send-email-linyunsheng@huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


ÔÚ 2021/6/25 ÉÏÎç11:18, Yunsheng Lin Ð´µÀ:
> Currently ptr_ring selftest is embedded within the virtio
> selftest, which involves some specific virtio operation,
> such as notifying and kicking.
>
> As ptr_ring has been used by various subsystems, it deserves
> it's owner's selftest in order to benchmark different usecase
> of ptr_ring, such as page pool and pfifo_fast qdisc.
>
> So add a simple application to benchmark ptr_ring performance.
> Currently two test mode is supported:
> Mode 0: Both enqueuing and dequeuing is done in a single thread,
>          it is called simple test mode in the test app.
> Mode 1: Enqueuing and dequeuing is done in different thread
>          concurrently, also known as SPSC(single-producer/
>          single-consumer) test.
>
> The multi-producer/single-consumer test for pfifo_fast case is
> not added yet, which can be added if using CAS atomic operation
> to enable lockless multi-producer is proved to be better than
> using r->producer_lock.
>
> Only supported on x86 and arm64 for now.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>   MAINTAINERS                                      |   5 +
>   tools/testing/selftests/ptr_ring/Makefile        |   6 +
>   tools/testing/selftests/ptr_ring/ptr_ring_test.c | 249 +++++++++++++++++++++++
>   tools/testing/selftests/ptr_ring/ptr_ring_test.h | 150 ++++++++++++++
>   4 files changed, 410 insertions(+)


Why can't you simply reuse tools/virtio/ringtest?

Thanks

