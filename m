Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80CC2A35F0
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Nov 2020 22:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgKBVYE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Nov 2020 16:24:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725833AbgKBVYD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Nov 2020 16:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604352242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5krEaljvyrhzNRqKb50IcCPttqpfwQ2VdU+VnjlUbEw=;
        b=M0L+uqsFa3JXR8oBrwpsU+NODhRqxIyxJ3FSPiZkD8/mYEgpjEeZHLkIu4kDFUKJ4U1Jfi
        j0UHussuTJTbGocRcdnO6NUT75Phnis5MXu1fbcwlyMXDvgW1sBUbCqbWqfzXDuv6TDZjW
        Yx/26AHdZ4Rj07fERFfNx/gIz5YWhNg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-tAozdFFYMD--73xT5ZEZfA-1; Mon, 02 Nov 2020 16:24:00 -0500
X-MC-Unique: tAozdFFYMD--73xT5ZEZfA-1
Received: by mail-qt1-f200.google.com with SMTP id e19so8842589qtq.17
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Nov 2020 13:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5krEaljvyrhzNRqKb50IcCPttqpfwQ2VdU+VnjlUbEw=;
        b=sLKjHUyoFyKdSdvhbzP4NwQEp8ivoel8GYl6uCVDnhtrIDPJbTGMSxuZmOPZKVLT3A
         7SKAo/mD7MPUoYXzBO6sz09A8a/dlKmfsCcD+85xKiF4d2qN+ei4UtslFreFzKnbJe7l
         nUwkDvQ7NgMReGL6iBpToTMaJrfaMQFWkjXIue2xmv3J1vX+4aaPTiUQp8JrGG/64fWU
         sMEK5y1+5obB5x/yfn0HeuIrfrQ5pNUHZD6/77IXmXPcWbe1tMrBxejZcLa4vHaLJkt2
         qEb78aUSPVPeBOQk5lkgiePxvY5ymH0kKltnBpr3qzkcnQ5PFPiSyTrIYyVIFkpiSrcO
         kjOg==
X-Gm-Message-State: AOAM532ghpT03K6PRtC5FgPlScg9+CEf2H9pBm0x2eToJD0zQmGPlciR
        4mu/0rV1NjQuYZpVNGCxVFQ/Z/p1M2TxryJ1f+xz/1+Q8RqPh0yt+7hM3LpvGfn6GyI9DPqCVUK
        N6zV2MLkTbuqiaLlDkVGjIQj/PcGI
X-Received: by 2002:ac8:51cd:: with SMTP id d13mr16561572qtn.148.1604352240473;
        Mon, 02 Nov 2020 13:24:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVZNW9d1dBhPMDwDQjUbkTYH74maXUmC/a3NMkduqNhkNQs5W808H/I9luHcDXbPi93/dC1A==
X-Received: by 2002:ac8:51cd:: with SMTP id d13mr16561552qtn.148.1604352240251;
        Mon, 02 Nov 2020 13:24:00 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
        by smtp.gmail.com with ESMTPSA id 69sm9012776qko.48.2020.11.02.13.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 13:23:59 -0800 (PST)
Date:   Mon, 2 Nov 2020 16:23:58 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: [PATCH 1/5] KVM: selftests: Factor code out of demand_paging_test
Message-ID: <20201102212358.GB20600@xz-x1>
References: <20201027233733.1484855-1-bgardon@google.com>
 <20201027233733.1484855-2-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027233733.1484855-2-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 27, 2020 at 04:37:29PM -0700, Ben Gardon wrote:
> Much of the code in demand_paging_test can be reused by other, similar
> multi-vCPU-memory-touching-perfromance-tests. Factor that common code
> out for reuse.
> 
> No functional change expected.

Is there explicit reason to put the common code in a header rather than
perf_test_util.c?  No strong opinion on this especially this is test code,
just curious.  Since iiuc .c file is still preferred for things like this.

> 
> This series was tested by running the following invocations on an Intel
> Skylake machine:
> dirty_log_perf_test -b 20m -i 100 -v 64
> dirty_log_perf_test -b 20g -i 5 -v 4
> dirty_log_perf_test -b 4g -i 5 -v 32
> demand_paging_test -b 20m -v 64
> demand_paging_test -b 20g -v 4
> demand_paging_test -b 4g -v 32
> All behaved as expected.

May move this chunk to the cover letter to avoid keeping it in every commit
(btw, you mentioned "this series" but I feel like you meant "you verified that
after applying each of the commits").

Thanks,

-- 
Peter Xu

