Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD453B3CC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 08:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhFYGnG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 02:43:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56042 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231406AbhFYGnF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 02:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624603244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BgQR4KroY2qcE0hxHye5QCDIev7Z92b6jYJGgm2HZ+U=;
        b=GNJBaY8TYPjkhEGn5FvpXDXJVQ4G6dMR6cRxKcHCnNe+rHZP8GTzC+hPY0r7YkrKwgUAMF
        Je+h8sS6wOU/DmA7lswOLfZ+GnpXuEdASSONAa6Bio89Uu/FQbfL8tl/JdxCoiChfcecz2
        TGSvuYozkSCZ7sWn1RYufuYZB/guyzQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-KFxUoKNPP1S00l2TuBdWZg-1; Fri, 25 Jun 2021 02:40:43 -0400
X-MC-Unique: KFxUoKNPP1S00l2TuBdWZg-1
Received: by mail-wm1-f70.google.com with SMTP id f11-20020a05600c154bb02901e0210617aaso1727600wmg.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Jun 2021 23:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BgQR4KroY2qcE0hxHye5QCDIev7Z92b6jYJGgm2HZ+U=;
        b=Aez0fTeEv4/OLG8CPtx37jDRF6VWxkGsJmi1++4q0HUR7WwA7mIQ/3Mfm5uAd/8F1D
         QXEe1RNKi0tyVm5J4SKcd7Mxq6EEOfyWFFswibtupRuVLEwwu4DEFIGMNhwg6JA+eDxo
         HgZFZ3+DW9xuuolmmIlHEDoS3DDp32fWvuKC6uem4zt48VNpxv3SgvX/6kOXBcmDM/48
         eJ0vf6j/zWdAr1Cc36o95MlmcmlKb06NOMLEcDCIHv+kPx7BSFsl9nTwMHaM6xHwHd25
         11o5ERLpS+yF48I4EcGaQk5LOLK7SlOjlEfYb4Yu2g7rAnOPLlaxHFRhG/2UYw2O6Spl
         aEVw==
X-Gm-Message-State: AOAM532wXTK7zHeOi0m3ehZhZG4ExMVUuaVjOz8EtGr7inmzeiSe0JoA
        ylXoiyISHmemvS2dLjlj+FNPmKuyyMzhZ79Iv77cNQpY3gPykFamaZ+mmsVXPP9iZR4GP+eZqYK
        tLoaE2zjCqrBWbh7iuab7BdxrnCOk
X-Received: by 2002:a05:600c:4fc6:: with SMTP id o6mr1705783wmq.158.1624603242320;
        Thu, 24 Jun 2021 23:40:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySERSuOqEfei9V/7lsM519nZZT4SUQswsw+X+YcCnoxzcNAgLXlt/amBl31Gi9K1O8lRULBA==
X-Received: by 2002:a05:600c:4fc6:: with SMTP id o6mr1705768wmq.158.1624603242173;
        Thu, 24 Jun 2021 23:40:42 -0700 (PDT)
Received: from redhat.com ([77.124.79.210])
        by smtp.gmail.com with ESMTPSA id k16sm5387589wrn.96.2021.06.24.23.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 23:40:41 -0700 (PDT)
Date:   Fri, 25 Jun 2021 02:39:34 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, jasowang@redhat.com,
        brouer@redhat.com, paulmck@kernel.org, peterz@infradead.org,
        will@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linuxarm@openeuler.org
Subject: Re: [PATCH net-next v2 2/2] ptr_ring: make __ptr_ring_empty()
 checking more reliable
Message-ID: <20210625023749-mutt-send-email-mst@kernel.org>
References: <1624591136-6647-1-git-send-email-linyunsheng@huawei.com>
 <1624591136-6647-3-git-send-email-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624591136-6647-3-git-send-email-linyunsheng@huawei.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 25, 2021 at 11:18:56AM +0800, Yunsheng Lin wrote:
> Currently r->queue[] is cleared after r->consumer_head is moved
> forward, which makes the __ptr_ring_empty() checking called in
> page_pool_refill_alloc_cache() unreliable if the checking is done
> after the r->queue clearing and before the consumer_head moving
> forward.
> 
> Move the r->queue[] clearing after consumer_head moving forward
> to make __ptr_ring_empty() checking more reliable.
> 
> As a side effect of above change, a consumer_head checking is
> avoided for the likely case, and it has noticeable performance
> improvement when it is tested using the ptr_ring_test selftest
> added in the previous patch.
> 
> Using "taskset -c 1 ./ptr_ring_test -s 1000 -m 0 -N 100000000"
> to test the case of single thread doing both the enqueuing and
> dequeuing:
> 
>  arch     unpatched           patched       delta
> arm64      4648 ms            4464 ms       +3.9%
>  X86       2562 ms            2401 ms       +6.2%
> 
> Using "taskset -c 1-2 ./ptr_ring_test -s 1000 -m 1 -N 100000000"
> to test the case of one thread doing enqueuing and another thread
> doing dequeuing concurrently, also known as single-producer/single-
> consumer:
> 
>  arch      unpatched             patched         delta
> arm64   3624 ms + 3624 ms   3462 ms + 3462 ms    +4.4%
>  x86    2758 ms + 2758 ms   2547 ms + 2547 ms    +7.6%

Nice but it's small - could be a fluke.
How many tests did you run? What is the variance?
Did you try pinning to different CPUs to observe numa effects?
Please use perf or some other modern tool for this kind
of benchmark. Thanks!

> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
> V2: Add performance data.
> ---
>  include/linux/ptr_ring.h | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index 808f9d3..db9c282 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -261,8 +261,7 @@ static inline void __ptr_ring_discard_one(struct ptr_ring *r)
>  	/* Note: we must keep consumer_head valid at all times for __ptr_ring_empty
>  	 * to work correctly.
>  	 */
> -	int consumer_head = r->consumer_head;
> -	int head = consumer_head++;
> +	int consumer_head = r->consumer_head + 1;
>  
>  	/* Once we have processed enough entries invalidate them in
>  	 * the ring all at once so producer can reuse their space in the ring.
> @@ -271,19 +270,27 @@ static inline void __ptr_ring_discard_one(struct ptr_ring *r)
>  	 */
>  	if (unlikely(consumer_head - r->consumer_tail >= r->batch ||
>  		     consumer_head >= r->size)) {
> +		int tail = r->consumer_tail;
> +
> +		if (unlikely(consumer_head >= r->size)) {
> +			r->consumer_tail = 0;
> +			WRITE_ONCE(r->consumer_head, 0);
> +		} else {
> +			r->consumer_tail = consumer_head;
> +			WRITE_ONCE(r->consumer_head, consumer_head);
> +		}
> +
>  		/* Zero out entries in the reverse order: this way we touch the
>  		 * cache line that producer might currently be reading the last;
>  		 * producer won't make progress and touch other cache lines
>  		 * besides the first one until we write out all entries.
>  		 */
> -		while (likely(head >= r->consumer_tail))
> -			r->queue[head--] = NULL;
> -		r->consumer_tail = consumer_head;
> -	}
> -	if (unlikely(consumer_head >= r->size)) {
> -		consumer_head = 0;
> -		r->consumer_tail = 0;
> +		while (likely(--consumer_head >= tail))
> +			r->queue[consumer_head] = NULL;
> +
> +		return;
>  	}
> +
>  	/* matching READ_ONCE in __ptr_ring_empty for lockless tests */
>  	WRITE_ONCE(r->consumer_head, consumer_head);
>  }
> -- 
> 2.7.4

