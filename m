Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AC7757BC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 14:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGRM1E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 08:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjGRM1D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 08:27:03 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7B710FE
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 05:27:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbd33a57ddso51782395e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jul 2023 05:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689683219; x=1692275219;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q79BXzZcL1/WaOlmXCuMLYQAEHu/pqHCehrBeb7Pl/4=;
        b=zaEY7Jg2ljy7bLYJJpcG/cafWQjMPcRxcgsSEBoIVee9TbL8hWHzeAZgwfT31J19Oa
         p9Uv2hLsu0ugi5qbOCS1TDH+3ZKQjAjkt4M05uiORnA3Vor1eRwzbZ6W4t8buZR7MGBO
         f1FPxisJxS7u1UP6YcikIe0ve4ss999LTAmwz5RrhAyinBBtcE5AtJANcdb+2pLsj9EA
         LCNDffpydRfucJtZR0KX9PYtPVNAoPCtbJMLVEoJ6Y6yVR9wqtY6xWZ1+cPd/0xNKGpu
         qEX3Fjot02sQjxRLIkuCWBw2tZLOSoH5xWQEpkJo5k8DPTQPNnvtHu/bfxJcIbQtMkf1
         ILYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689683219; x=1692275219;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q79BXzZcL1/WaOlmXCuMLYQAEHu/pqHCehrBeb7Pl/4=;
        b=fk9bPHNZ4AbQtSn401EBGAb7Vgvq/Cy9IuVQZNIA/6xiV0/AkKbOH9dca9BfOy/5OY
         py2SiUFt7wCOZo5qzNepeJOI1PfgAmEjAxrmCfD9quY8KHHbkUBZRpu64ejKLWNYn/OP
         NqTBNuCPykOni4cDUy0cJP9JwSkJ84wzpH/n9+D8T6WtH4u8iJed7uV1EFFyesXRToEg
         pXHvThMkAbDfnMZM3nPMZb1jAPCV8kMGoDBORBY3kz0SjrKCsheQWST4g2ewuRobgsMP
         Pi6Zjk+3v20lG+9GwLQk3qbmUh3l1R9vW7zbcIrAepr+N1uIJvIUl5v5mlvF5oDg7nsM
         MCaA==
X-Gm-Message-State: ABy/qLYs9DJKEzhuAaBUENk/J6XGQbood17YZdNnoAvXFxUHD48vo330
        3vhOPXJlM5eaM1BdyIxIj9gxRg==
X-Google-Smtp-Source: APBJJlEN1HGaGjTSuncB/F+MBGsgjE96RqnQ9IFU0x+JE8AqkQvaJ3Z+IN0ogPis9xXdMGDdHRCe6A==
X-Received: by 2002:a1c:f710:0:b0:3f9:c0f2:e1a4 with SMTP id v16-20020a1cf710000000b003f9c0f2e1a4mr1743885wmh.34.1689683218907;
        Tue, 18 Jul 2023 05:26:58 -0700 (PDT)
Received: from [192.168.94.175] (140.red-95-127-46.staticip.rima-tde.net. [95.127.46.140])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c230c00b003f90b9b2c31sm10180325wmo.28.2023.07.18.05.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 05:26:58 -0700 (PDT)
Message-ID: <e324e61f-5fbf-4055-f570-63cb120c1bdc@linaro.org>
Date:   Tue, 18 Jul 2023 14:26:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/4] KVM: selftests: Rename the ASSERT_EQ macro
Content-Language: en-US
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     linux-kselftest@vger.kernel.org,
        David Matlack <dmatlack@google.com>
References: <20230712075910.22480-1-thuth@redhat.com>
 <20230712075910.22480-2-thuth@redhat.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230712075910.22480-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/7/23 09:59, Thomas Huth wrote:
> There is already an ASSERT_EQ macro in the file
> tools/testing/selftests/kselftest_harness.h, so we currently
> can't include test_util.h from the KVM selftests together with
> that file. Rename the macro in the KVM selftests to TEST_ASSERT_EQ
> to avoid the problem - it is also more similar to the other macros
> in test_util.h that way.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .../selftests/kvm/aarch64/aarch32_id_regs.c   |  8 +--
>   .../selftests/kvm/aarch64/page_fault_test.c   | 10 +--
>   .../testing/selftests/kvm/include/test_util.h |  4 +-
>   tools/testing/selftests/kvm/lib/kvm_util.c    |  2 +-
>   .../selftests/kvm/max_guest_memory_test.c     |  2 +-
>   tools/testing/selftests/kvm/s390x/cmma_test.c | 62 +++++++++----------
>   tools/testing/selftests/kvm/s390x/memop.c     |  6 +-
>   tools/testing/selftests/kvm/s390x/tprot.c     |  4 +-
>   .../x86_64/dirty_log_page_splitting_test.c    | 18 +++---
>   .../x86_64/exit_on_emulation_failure_test.c   |  2 +-
>   .../kvm/x86_64/nested_exceptions_test.c       | 12 ++--
>   .../kvm/x86_64/recalc_apic_map_test.c         |  6 +-
>   .../selftests/kvm/x86_64/tsc_msrs_test.c      | 32 +++++-----
>   .../vmx_exception_with_invalid_guest_state.c  |  2 +-
>   .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |  3 +-
>   .../selftests/kvm/x86_64/xapic_state_test.c   |  8 +--
>   .../selftests/kvm/x86_64/xen_vmcall_test.c    | 20 +++---
>   17 files changed, 101 insertions(+), 100 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

