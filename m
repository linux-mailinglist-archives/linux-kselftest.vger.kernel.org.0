Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A728358E95E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 11:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiHJJOp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 05:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiHJJO3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 05:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBAB086C22
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 02:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660122867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BrnJHJ9Mo9d6LF8fLd160jO7vgau2DqXTrpWN+Q+1lI=;
        b=V7m6Ek5juphGldT+tKh1lJ8HSlWLnF81YR8Ao+8PS9nJ62UbhgGOGL0bENZQB+Q2od0AoS
        7eMMUthVqtRJM8nhxU5Y2lXWrV2baicKxrgaakMjnVd73cwgVuTWwBPznfWvBZv92AxO2F
        zaV/mpBum9QjhA03c5lX3zanU1OWDQ4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-N6Xgnw7NMLq3i6zbHm2jjg-1; Wed, 10 Aug 2022 05:14:26 -0400
X-MC-Unique: N6Xgnw7NMLq3i6zbHm2jjg-1
Received: by mail-ej1-f72.google.com with SMTP id qb27-20020a1709077e9b00b0073160a55fd7so2382274ejc.17
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 02:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=BrnJHJ9Mo9d6LF8fLd160jO7vgau2DqXTrpWN+Q+1lI=;
        b=Wn08Iap7cbIQXWqRc4IHA57riroso3UmA1in5GXY8RnxKDsXGTm9lquzolHhUjFm7W
         ueA36/okzUly0brx2h2ChKgvDUo8stHlEdwe7vxeys+OTtV+Vxc/nRET9luRV3hZX5Sj
         YQfbiw3uAkg3Cev/0htR3AxJWlkxHCJsHyFiS9yCRhh9xlvZcsy2zP2gfUiZ4LMqR9U8
         3YVUVcezCVWWXjPXyewZ1x0pBFmglVKPDA4eQYmmEBQjyyT9b5uUwdsXqTU5OjbeJ6V5
         JHZckkMElXVhISTbeVd1z/r7HHIcnkXvm5iBbyYrXJlx+9v5BGSALNoVUf/4mQ7kpcSo
         l01Q==
X-Gm-Message-State: ACgBeo0xeFfV30ukocv/d7BRMjqUnPNmpx9GjWmXMfaIVu/MmxeHQTFE
        P0cBCOP9siJ/L2REWdu2qC+R6unH8SVo+8EM+z49m8HECDWo/uaQzcU/wnUawEo6Ir9SZMksCae
        KNMIbWWMKJ1Cz5HBZCVcn7xDDAfcf
X-Received: by 2002:a05:6402:1cc4:b0:440:5af8:41c9 with SMTP id ds4-20020a0564021cc400b004405af841c9mr17458854edb.339.1660122865384;
        Wed, 10 Aug 2022 02:14:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4bQLwz0ay5kkw96DxJDx6+n/9y/Y6jEQ5yxdYJMMBH3d4Jv3191+PBY5JzY9jgLVspgmOkjg==
X-Received: by 2002:a05:6402:1cc4:b0:440:5af8:41c9 with SMTP id ds4-20020a0564021cc400b004405af841c9mr17458830edb.339.1660122865199;
        Wed, 10 Aug 2022 02:14:25 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id r17-20020a17090609d100b0073145afd156sm162913eje.80.2022.08.10.02.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 02:14:24 -0700 (PDT)
Message-ID: <bb97efaf-4f58-c192-a489-e71ebbebce8c@redhat.com>
Date:   Wed, 10 Aug 2022 11:14:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Gavin Shan <gshan@redhat.com>
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] KVM: selftests: Make rseq compatible with glibc-2.35
In-Reply-To: <797306043.114963.1660047714774.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/9/22 14:21, Mathieu Desnoyers wrote:
>> For kvm/selftests, there are 3 architectures involved actually. So we
>> just need consider 4 cases: aarch64, x86, s390 and other. For other
>> case, we just use __builtin_thread_pointer() to maintain code's
>> integrity, but it's not called at all.
>>
>> I think kvm/selftest is always relying on glibc if I'm correct.
> All those are handled in the rseq selftests and in librseq. Why duplicate all that logic again?

Yeah, rseq_test should reuse librseq code.  The simplest way,
if slightly hackish, is to do something like

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 690b499c3471..6c192b0ec304 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -37,6 +37,7 @@ ifeq ($(ARCH),riscv)
  	UNAME_M := riscv
  endif
  
  LIBKVM += lib/assert.c
  LIBKVM += lib/elf.c
  LIBKVM += lib/guest_modes.c
@@ -198,7 +199,7 @@ endif
  CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
  	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
  	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
-	-I$(<D) -Iinclude/$(UNAME_M) -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
+	-I$(<D) -Iinclude/$(UNAME_M) -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES) -I../rseq
  
  no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
          $(CC) -Werror -no-pie -x c - -o "$$TMP", -no-pie)


and just #include "../rseq/rseq.c" in rseq_test.c.

Thanks,

Paolo

