Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14A358D45D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 09:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbiHIHRd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 03:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238934AbiHIHRX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 03:17:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9859721253
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Aug 2022 00:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660029431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=guDnNs6GIE6VYYfJC3LF3y7xxWcKYPW4yEpvV6OunCc=;
        b=MU6XGvUbYv7Tnd09dtaXcpNo7Y2rM1pFHJCxVGdeWoImyjMYZJ7LbO0wAFCpk5DvTVihj9
        tVS0nn2MDVvN8mJdg8v1nA8rADQiCqlH9M10pPhSKX7UZqHHbN+VP9kuWglEGNolbuByz5
        hXN8rfW/ptX9fNjParJtfuzG+hmViQM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-135-I1YrsPXbNI-JfbNgRuspjg-1; Tue, 09 Aug 2022 03:17:06 -0400
X-MC-Unique: I1YrsPXbNI-JfbNgRuspjg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE1AA1019C8E;
        Tue,  9 Aug 2022 07:17:05 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.193.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D89D9945D0;
        Tue,  9 Aug 2022 07:17:02 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
        andrew.jones@linux.dev, seanjc@google.com,
        mathieu.desnoyers@efficios.com, yihyu@redhat.com,
        shan.gavin@gmail.com
Subject: Re: [PATCH 2/2] KVM: selftests: Use getcpu() instead of
 sched_getcpu() in rseq_test
References: <20220809060627.115847-1-gshan@redhat.com>
        <20220809060627.115847-3-gshan@redhat.com>
        <87y1vxncv1.fsf@oldenburg.str.redhat.com>
Date:   Tue, 09 Aug 2022 09:17:01 +0200
In-Reply-To: <87y1vxncv1.fsf@oldenburg.str.redhat.com> (Florian Weimer's
        message of "Tue, 09 Aug 2022 08:35:14 +0200")
Message-ID: <87mtcdnaxe.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

* Florian Weimer:

> * Gavin Shan:
>
>> sched_getcpu() is glibc dependent and it can simply return the CPU
>> ID from the registered rseq information, as Florian Weimer pointed.
>> In this case, it's pointless to compare the return value from
>> sched_getcpu() and that fetched from the registered rseq information.
>>
>> Fix the issue by replacing sched_getcpu() with getcpu(), as Florian
>> suggested. The comments are modified accordingly.
>
> Note that getcpu was added in glibc 2.29, so perhaps you need to perform
> a direct system call?

One more thing: syscall(__NR_getcpu) also has the advantage that it
wouldn't have to be changed again if node IDs become available via rseq
and getcpu is implemented using that.

Thanks,
Florian

