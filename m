Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E632C58D39F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 08:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiHIGTF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 02:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbiHIGTE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 02:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A419C1F63F
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Aug 2022 23:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660025942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y89Epe8YZWt9n1WdqArIxaVxwXsnFyTQCv3vV90xjO4=;
        b=dm7FxVHWNpAXbiuZFGFLO3Y4mkh42LCyYSHKrJm8ZBoD8uvDIBdjcdiBkUEVPEFzghg4aG
        8FnDMryiO8mePQrJ+95pcGpCe6w/kZzO+uWokZiIW/jH3ImNhAsvZ7Ds3b16g+GxVUSAM3
        818zoN3RwX5Ze8jMumG+7PH5onx85YY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-8U-CvfAyNaSLQ6MiMT10HA-1; Tue, 09 Aug 2022 02:18:59 -0400
X-MC-Unique: 8U-CvfAyNaSLQ6MiMT10HA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1506101AA69;
        Tue,  9 Aug 2022 06:18:58 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.193.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B91CB141512B;
        Tue,  9 Aug 2022 06:18:56 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: tools/testing/selftests/kvm/rseq_test and glibc 2.35
References: <875yj2n2r0.fsf@oldenburg.str.redhat.com>
        <465d3599-2433-7f6e-66fc-b4018ba258cf@redhat.com>
Date:   Tue, 09 Aug 2022 08:18:54 +0200
In-Reply-To: <465d3599-2433-7f6e-66fc-b4018ba258cf@redhat.com> (Gavin Shan's
        message of "Tue, 9 Aug 2022 11:47:43 +1000")
Message-ID: <877d3indm9.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Gavin Shan:

> Hi Florian,
>
> On 8/9/22 2:01 AM, Florian Weimer wrote:
>> It has come to my attention that the KVM rseq test apparently needs to
>> be ported to glibc 2.35.  The background is that on aarch64, rseq is the
>> only way to get a practically useful sched_getcpu.  (There's no hidden
>> per-task CPU state the vDSO could reveal as the CPU ID.)
>> 
>
> Yes, kvm/selftests/rseq needs to support glibc 2.35. The question is
> about glibc 2.34 or 2.35 because kvm/selftest/rseq fails on glibc 2.34
>
> I would guess upstream-glibc-2.35 feature is enabled on downstream
> glibc-2.34?
>
> # ./rseq_test
> ==== Test Assertion Failure ====
>   rseq_test.c:60: !r
>   pid=112043 tid=112043 errno=22 - Invalid argument
>      1	0x0000000000401973: main at rseq_test.c:226
>      2	0x0000ffff84b6c79b: ?? ??:0
>      3	0x0000ffff84b6c86b: ?? ??:0
>      4	0x0000000000401b6f: _start at ??:?
>   rseq failed, errno = 22 (Invalid argument)
> # rpm -aq | grep glibc-2
> glibc-2.34-39.el9.aarch64

Yes, we have enabled it downstream.

  glibc: Restartable sequences interfaces and sched_getcpu accelerated
  by default
  <https://bugzilla.redhat.com/show_bug.cgi?id=2085529>

However,

  GLIBC_TUNABLES=glibc.pthread.rseq=0 ./rseq_test

should still work (we added the ability to disable rseq registration
precisely to enable scenarios like this), but tunables are an optional
glibc feature, so the upstream kernel should probably still be fixed.

> Mathieu and Florian, the fixes have been posted. It would be nice for you
> to review if you have free cycles :)
> 
> https://lore.kernel.org/kvmarm/20220809060627.115847-1-gshan@redhat.com/T/#t

Excellent.  I'm going to have a look.

Thanks,
Florian

