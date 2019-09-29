Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE52C13C2
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2019 09:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfI2HW7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 29 Sep 2019 03:22:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43050 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfI2HW7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 29 Sep 2019 03:22:59 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4F774E8AC
        for <linux-kselftest@vger.kernel.org>; Sun, 29 Sep 2019 07:22:58 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id z4so5281244pfn.0
        for <linux-kselftest@vger.kernel.org>; Sun, 29 Sep 2019 00:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tq9QKVVyZ/72sVEVQmQqdNZ2HQdDsVrKco2ZVmW51Zg=;
        b=OXZ6DTpsI2smqdkZePOB7iYvTCkhxYDA6kRxgnpHNAtA3Qt+31fJ9RNCNePUIkUjlB
         +M1ZCDvV4/p3rANdpQCNNSrGR1LI98X/N8nvQg2lSrAUj3ET3E9K20KSqjHTR21uazCY
         6noeQFcVa+uN2M2l/A0d3udw8GfBPUYHC7oQG5QYEzcnGZJ/r7FbSGwn6B52g57XcyZb
         VFRAFhgKdZ5kBYaSkqrOA0+0PK9KNNzTiCYoMMEuj6CGBWi3PTRCw1waSd61ziSKieE4
         6aZSAJJsCrGXgLspC8LmTxES5yJJArw5Cgj4V1uIJlS6RCNuBx5fsPiBuYuXOlTre0pz
         LsDQ==
X-Gm-Message-State: APjAAAU5GQOfBgpuHwvzMdSzz4QGmUt0ePk7FddoozKKlww+tpiRtdci
        j290u0UrvvuZZzqbqTchmxocbYxUM9aHbhNVX1qAaN3PCMIWnNfiztau/0ORrsoU/2rvkGwM47v
        lVHUNloqWIJnrK5cpO+7I9LPIeUs5
X-Received: by 2002:aa7:920d:: with SMTP id 13mr14485848pfo.17.1569741778430;
        Sun, 29 Sep 2019 00:22:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw8zWZgWxpe6G0fAn8DdXv3XI4/+BNsO/Sp4UI+XXDBHz0fEHd4N9jTra0+vFTF3jXiNtTgxA==
X-Received: by 2002:aa7:920d:: with SMTP id 13mr14485829pfo.17.1569741778250;
        Sun, 29 Sep 2019 00:22:58 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q14sm19802775pgf.74.2019.09.29.00.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 00:22:57 -0700 (PDT)
Date:   Sun, 29 Sep 2019 15:22:48 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 0/9] Create a userfaultfd demand paging test
Message-ID: <20190929072248.GB8903@xz-x1>
References: <20190927161836.57978-1-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190927161836.57978-1-bgardon@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 27, 2019 at 09:18:28AM -0700, Ben Gardon wrote:
> When handling page faults for many vCPUs during demand paging, KVM's MMU
> lock becomes highly contended. This series creates a test with a naive
> userfaultfd based demand paging implementation to demonstrate that
> contention. This test serves both as a functional test of userfaultfd
> and a microbenchmark of demand paging performance with a variable number
> of vCPUs and memory per vCPU.
> 
> The test creates N userfaultfd threads, N vCPUs, and a region of memory
> with M pages per vCPU. The N userfaultfd polling threads are each set up
> to serve faults on a region of memory corresponding to one of the vCPUs.
> Each of the vCPUs is then started, and touches each page of its disjoint
> memory region, sequentially. In response to faults, the userfaultfd
> threads copy a static buffer into the guest's memory. This creates a
> worst case for MMU lock contention as we have removed most of the
> contention between the userfaultfd threads and there is no time required
> to fetch the contents of guest memory.

Hi, Ben,

Even though I may not have enough MMU knowledge to say this... this of
course looks like a good test at least to me.  I'm just curious about
whether you have plan to customize the userfaultfd handler in the
future with this infrastructure?

Asked because IIUC with this series userfaultfd only plays a role to
introduce a relatively adhoc delay to page faults.  In other words,
I'm also curious what would be the number look like (as you mentioned
in your MMU rework cover letter) if you simply start hundreds of vcpu
and do the same test like this, but use the default anonymous page
faults rather than uffd page faults.  I feel like even without uffd
that could be a huge contention already there.  Or did I miss anything
important on your decision to use userfaultfd?

Thanks,

-- 
Peter Xu
