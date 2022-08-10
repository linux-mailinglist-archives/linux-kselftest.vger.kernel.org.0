Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5D358EA26
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 11:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiHJJ7W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 05:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHJJ7V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 05:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DA106EF19
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 02:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660125559;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8foxS5OTM5HYev6CZ4Rcys+eRHI332c6y7bWUfe28UQ=;
        b=Vc8GwjkG18VgnnxTiA9VEWTa2sDHWXftAF9u5SPu04+M8ernJ5zEedYfJK0VGpMC0p3BWs
        298f2U6sZiWyw019aB/RvGjxM9MgRkHfU7byAfwuffyX1hKZ+t9HOociXVmNmjy7XQtr7Z
        OquxeQkUP/GwBYuWvBN+/Gt6pomnReo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-LYXixRy1MdShMhEGEMMVFg-1; Wed, 10 Aug 2022 05:59:16 -0400
X-MC-Unique: LYXixRy1MdShMhEGEMMVFg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F5AC811E81;
        Wed, 10 Aug 2022 09:59:15 +0000 (UTC)
Received: from [10.64.54.77] (vpn2-54-77.bne.redhat.com [10.64.54.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D98C02166B29;
        Wed, 10 Aug 2022 09:59:10 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 1/2] KVM: selftests: Make rseq compatible with glibc-2.35
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Florian Weimer <fweimer@redhat.com>, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org,
        oliver upton <oliver.upton@linux.dev>,
        andrew jones <andrew.jones@linux.dev>, seanjc@google.com,
        yihyu@redhat.com, shan gavin <shan.gavin@gmail.com>
References: <20220809060627.115847-1-gshan@redhat.com>
 <20220809060627.115847-2-gshan@redhat.com>
 <8735e6ncxw.fsf@oldenburg.str.redhat.com>
 <7844e3fa-e49e-de75-e424-e82d3a023dd6@redhat.com>
 <87o7wtnay6.fsf@oldenburg.str.redhat.com>
 <616d4de6-81f6-9d14-4e57-4a79fec45690@redhat.com>
 <797306043.114963.1660047714774.JavaMail.zimbra@efficios.com>
 <bb97efaf-4f58-c192-a489-e71ebbebce8c@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <5be21a93-8a28-0214-59f0-21b56b0946a2@redhat.com>
Date:   Wed, 10 Aug 2022 19:59:07 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <bb97efaf-4f58-c192-a489-e71ebbebce8c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Paolo,

On 8/10/22 7:14 PM, Paolo Bonzini wrote:
> On 8/9/22 14:21, Mathieu Desnoyers wrote:
>>> For kvm/selftests, there are 3 architectures involved actually. So we
>>> just need consider 4 cases: aarch64, x86, s390 and other. For other
>>> case, we just use __builtin_thread_pointer() to maintain code's
>>> integrity, but it's not called at all.
>>>
>>> I think kvm/selftest is always relying on glibc if I'm correct.
>> All those are handled in the rseq selftests and in librseq. Why duplicate all that logic again?
> 
> Yeah, rseq_test should reuse librseq code.  The simplest way,
> if slightly hackish, is to do something like
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 690b499c3471..6c192b0ec304 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -37,6 +37,7 @@ ifeq ($(ARCH),riscv)
>       UNAME_M := riscv
>   endif
> 
>   LIBKVM += lib/assert.c
>   LIBKVM += lib/elf.c
>   LIBKVM += lib/guest_modes.c
> @@ -198,7 +199,7 @@ endif
>   CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
>       -fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
>       -I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
> -    -I$(<D) -Iinclude/$(UNAME_M) -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
> +    -I$(<D) -Iinclude/$(UNAME_M) -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES) -I../rseq
> 
>   no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
>           $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)
> 
> 
> and just #include "../rseq/rseq.c" in rseq_test.c.
> 

Thank you. It's really a nice idea. I think it's best way to share
"../rseq/rseq.c". In this way, we needn't to rely on "../rseq/librseq.so",
which is compiled by "../rseq/Makefile".

I will modify the code accordingly in v2 :)

Thanks,
Gavin

