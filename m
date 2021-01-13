Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283552F456E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 08:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbhAMHl3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jan 2021 02:41:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23089 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726406AbhAMHl2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jan 2021 02:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610523602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eIu5o0GBOvXP1rvJN72lDtnj2/36cMjeG3m4twLkzts=;
        b=Xm9gIydf1wtvpMIC+H5nKX1ytm/QdScq273VkJi1lxT2L4/YTSbAC5aF1USNPEuIsDEijk
        e+Em04qf89cjCBq+ovd1FTupJSSrmwj2Oe82wBPdZuJnZQ+2FBgCKJk/I5DGSGTmVHf5Zc
        AWqUqk82pfWQeYf7IZlikFZSPvZdSls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-T1d2lRqtMAqyBD-BnKBaDA-1; Wed, 13 Jan 2021 02:40:00 -0500
X-MC-Unique: T1d2lRqtMAqyBD-BnKBaDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0807FEC1A1;
        Wed, 13 Jan 2021 07:39:59 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-122.ams2.redhat.com [10.36.112.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A38AC7369F;
        Wed, 13 Jan 2021 07:39:53 +0000 (UTC)
Subject: Re: [PATCH 3/6] KVM: selftests: Convert iterations to int in
 dirty_log_perf_test
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>
References: <20210112214253.463999-1-bgardon@google.com>
 <20210112214253.463999-4-bgardon@google.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <e0f10f8a-795d-a878-0048-9da4d2a94518@redhat.com>
Date:   Wed, 13 Jan 2021 08:39:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210112214253.463999-4-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/01/2021 22.42, Ben Gardon wrote:
> In order to add an iteration -1 to indicate that the memory population
> phase has not yet completed, convert the interations counters to ints.
> 
> No functional change intended.
> 
> Reviewed-by: Jacob Xu <jacobhxu@google.com>
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>   .../selftests/kvm/dirty_log_perf_test.c       | 26 +++++++++----------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> index 15a9c45bdb5f..3875f22d7283 100644
> --- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
> @@ -28,8 +28,8 @@ static uint64_t guest_percpu_mem_size = DEFAULT_PER_VCPU_MEM_SIZE;
>   /* Host variables */
>   static u64 dirty_log_manual_caps;
>   static bool host_quit;
> -static uint64_t iteration;
> -static uint64_t vcpu_last_completed_iteration[KVM_MAX_VCPUS];
> +static int iteration;
> +static int vcpu_last_completed_iteration[KVM_MAX_VCPUS];

Wouldn't it be better to use signed 64-bit variables instead? I.e. "int64_t" ?

  Thomas

