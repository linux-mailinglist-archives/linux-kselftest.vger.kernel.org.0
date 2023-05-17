Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB50707231
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 21:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjEQTbB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 15:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjEQTa7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 15:30:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3192723
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 12:30:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f42769a0c1so12311955e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 12:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684351843; x=1686943843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kr6d+SVFbfwYxIPjljC34mJyItAu8XtQrptOaS6bxCg=;
        b=pTywBKfDEzxgMMRn1O7n7Bu7DpCtUMiUnA9TozAVvTcvnqgBngngXxxNzXmoYVgmgN
         UiIKIZ2nBAPofUsKGmMpILySj3BIeGh+Okto7boZE/LwpuLNFHFyZUwFyTWMUeeuBheU
         RCU54V52MfMOL/VMQvCaIGPeIYnG/7T3Vt1K8Q+NQ7VkengF/OGehsVi0PySozvS7Y0s
         rO6P24MntlSklmN00A2XNSMlPfG+9pr8dh8h9RNrlg+j8+rPiQ0oXTk5lf0M2HvNmGZ/
         /y5xRQi4Yw4tsHyqtWAKtwF8JVLbFXWghf35nw4NgxGkmPbFKJ/gmiOdoBdVglSTdvYJ
         wh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351843; x=1686943843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr6d+SVFbfwYxIPjljC34mJyItAu8XtQrptOaS6bxCg=;
        b=SPFpc/H7c6QX7sEn/N5xYPvdFUZaQ7VzGv81VRiVMCUt/BscI3vFR++FjGguyvifAt
         4KoHVcPXrtp2m+d6WwaDVjM2Uv7RFAgURXP4kPTVcujKfypq8wLvL2i2tL0WGPvCDosG
         1ZitUeGI0Umke4I3FwjVclFMt+FltsucDH4gz5qVDZhAQ8rIO35riDhr8NU5i85FSHwZ
         mkFw8yO5YuAzw04fawTxqzqcFhWBGzw4b48LwCSK3ePO+56jqzH1x43zQZNYQAJuHTjJ
         J31wAzk8hoXqllxsVYRY7U4dS7dvebm/kjjz3Zuuv6ztJDNAMoro3RxrRzhViiwJKMZj
         RuvQ==
X-Gm-Message-State: AC+VfDyfaPIz9Bw14Ia6l91LbhtfJR8mcuR3VwzTELrWB2XG33Nsnnk3
        ZFVqGpHhlcfmbc9r7EZoL7Z9Bw==
X-Google-Smtp-Source: ACHHUZ4FRheMWXHyKIux0JaXVWwYgCtMCMdH62mabjG8tjCmij2PXX4ulOpYJu1EOl9Ams43uo24FQ==
X-Received: by 2002:a7b:cd89:0:b0:3f4:247a:ddce with SMTP id y9-20020a7bcd89000000b003f4247addcemr24569698wmj.36.1684351843658;
        Wed, 17 May 2023 12:30:43 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p5-20020a7bcc85000000b003f4248dcfcbsm3074911wma.30.2023.05.17.12.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:30:42 -0700 (PDT)
Date:   Wed, 17 May 2023 22:30:29 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: arm64: fp-stress: BUG: KFENCE: memory corruption in
 fpsimd_release_task
Message-ID: <2d9a04d8-c09e-49aa-95eb-32b4679f7eba@kili.mountain>
References: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtU7HsV0R0dp4XEH5xXHSJFw8KyDf5VQrLLfMxWfxQkag@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

I don't know this code at all so probably this is dumb...  I don't
undestand how vec_set_vector_length() ensures that sme_state_size()
stays in sync with the actual size allocated in sme_alloc()

arch/arm64/kernel/fpsimd.c
   847  int vec_set_vector_length(struct task_struct *task, enum vec_type type,
   848                            unsigned long vl, unsigned long flags)
                                               ^^^
"vl" comes from the user and is 0-u16max.

   849  {
   850          if (flags & ~(unsigned long)(PR_SVE_VL_INHERIT |
   851                                       PR_SVE_SET_VL_ONEXEC))
   852                  return -EINVAL;
   853  
   854          if (!sve_vl_valid(vl))

valid values are '16-8192'

   855                  return -EINVAL;
   856  
   857          /*
   858           * Clamp to the maximum vector length that VL-agnostic code
   859           * can work with.  A flag may be assigned in the future to
   860           * allow setting of larger vector lengths without confusing
   861           * older software.
   862           */
   863          if (vl > VL_ARCH_MAX)
   864                  vl = VL_ARCH_MAX;

Now 16-256'

   865  
   866          vl = find_supported_vector_length(type, vl);

type is ARM64_VEC_SVE.  I've looked at this function for a while and
I don't see anything which ensures that "vl" is less than the current
value.

   867  
   868          if (flags & (PR_SVE_VL_INHERIT |
   869                       PR_SVE_SET_VL_ONEXEC))
   870                  task_set_vl_onexec(task, type, vl);
   871          else
   872                  /* Reset VL to system default on next exec: */
   873                  task_set_vl_onexec(task, type, 0);
   874  
   875          /* Only actually set the VL if not deferred: */
   876          if (flags & PR_SVE_SET_VL_ONEXEC)

Assume the PR_SVE_SET_VL_ONEXEC flag is not set.

   877                  goto out;
   878  
   879          if (vl == task_get_vl(task, type))

This checks if the flag is == and if so we are done.

   880                  goto out;
   881  
   882          /*
   883           * To ensure the FPSIMD bits of the SVE vector registers are preserved,
   884           * write any live register state back to task_struct, and convert to a
   885           * regular FPSIMD thread.
   886           */
   887          if (task == current) {
   888                  get_cpu_fpsimd_context();
   889  
   890                  fpsimd_save();
   891          }
   892  
   893          fpsimd_flush_task_state(task);
   894          if (test_and_clear_tsk_thread_flag(task, TIF_SVE) ||
   895              thread_sm_enabled(&task->thread)) {
   896                  sve_to_fpsimd(task);
   897                  task->thread.fp_type = FP_STATE_FPSIMD;
   898          }
   899  
   900          if (system_supports_sme() && type == ARM64_VEC_SME) {
   901                  task->thread.svcr &= ~(SVCR_SM_MASK |
   902                                         SVCR_ZA_MASK);
   903                  clear_thread_flag(TIF_SME);
   904          }
   905  
   906          if (task == current)
   907                  put_cpu_fpsimd_context();
   908  
   909          /*
   910           * Force reallocation of task SVE and SME state to the correct
   911           * size on next use:
   912           */
   913          sve_free(task);
   914          if (system_supports_sme() && type == ARM64_VEC_SME)
   915                  sme_free(task);
   916  
   917          task_set_vl(task, type, vl);

"vl" is set here.  This is fine if we are setting it to a smaller value,
but if we are setting it to a larger value then I think we need to
realloc the ->sme_state buffer.

When we call sme_alloc() it will say the buffer is already allocated
and just zero out what we need for "vl", but the existing buffer is too
small.

   918  
   919  out:
   920          update_tsk_thread_flag(task, vec_vl_inherit_flag(type),
   922  
   923          return 0;
   924  }

regards,
dan carpenter
