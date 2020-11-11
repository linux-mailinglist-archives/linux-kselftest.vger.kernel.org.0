Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87182AF0B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 13:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgKKMep (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 07:34:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbgKKMep (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 07:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605098084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9UPteIZ4dDhB/+pPE2bQPs1AX/E6MYzd/3oM1Nc1Zh0=;
        b=bc15j/NOyoLPIUltfHr/y6TeGU2cM1Go93XtkYg8AiViaGYbcP0zMht/7B8s26oAx3Y0VN
        3fh9ryHE78zgN5MLu6LArG2rk4NY3wu74iVjzJ+ITP+stkbx7KnrNNBKkG8I128nhWtLl5
        VQH2iqldTQPITyLtvfdKTGWE3EEwi70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-LJ_6VosUOn6Q7fv7WCYtKw-1; Wed, 11 Nov 2020 07:34:42 -0500
X-MC-Unique: LJ_6VosUOn6Q7fv7WCYtKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D60B188C126;
        Wed, 11 Nov 2020 12:34:41 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.216])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EF9A1002C3E;
        Wed, 11 Nov 2020 12:34:34 +0000 (UTC)
Date:   Wed, 11 Nov 2020 13:34:31 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: [PATCH v2 0/5] Add a dirty logging performance test
Message-ID: <20201111123431.k5ta7enky6k4b66j@kamzik.brq.redhat.com>
References: <20201103234952.1626730-1-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103234952.1626730-1-bgardon@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 03, 2020 at 03:49:47PM -0800, Ben Gardon wrote:
> Currently KVM lacks a simple, userspace agnostic, performance benchmark for
> dirty logging. Such a benchmark will be beneficial for ensuring that dirty
> logging performance does not regress, and to give a common baseline for
> validating performance improvements. The dirty log perf test introduced in
> this series builds on aspects of the existing demand paging perf test and
> provides time-based performance metrics for enabling and disabling dirty
> logging, getting the dirty log, and dirtying memory.
> 
> While the test currently only has a build target for x86, I expect it will
> work on, or be easily modified to support other architectures.
> 
> This series was tested by running the following invocations on an Intel
> Skylake machine after apply all commits in the series:
> dirty_log_perf_test -b 20m -i 100 -v 64
> dirty_log_perf_test -b 20g -i 5 -v 4
> dirty_log_perf_test -b 4g -i 5 -v 32
> demand_paging_test -b 20m -v 64
> demand_paging_test -b 20g -v 4
> demand_paging_test -b 4g -v 32
> All behaved as expected.
> 
> v1 -> v2 changes:

Considering v1 got applied,

> (in response to comments from Peter Xu)
> - Removed pr_debugs from main test thread while waiting on vCPUs to reduce
>   log spam

I didn't look at this. Maybe you and Peter can decide if a pr_debug
cleanup patch needs to be sent.

> - Fixed a bug in iteration counting that caused the population stage to be
>   counted as part of the first dirty logging pass
> - Fixed a bug in which the test failed to wait for the population stage for all
>   but the first vCPU.

I didn't try to confirm that these fixes were in. I do see that Paolo
added 6d6a18fdde8b ("KVM: selftests: allow two iterations of
dirty_log_perf_test"), which sounds like it might be fixing the same thing
as your first "Fixed" bullet above. Anyway, you may want to check the 
current code to see if any additional fixes should be sent.

> - Refactored the common code in perf_test_util.c/h

I did this part in my "Cleanups, take 2" series

> - Moved testing description to cover letter
> - Renamed timespec_diff_now to timespec_elapsed

These two would have been nice, but oh well...

Thanks,
drew

