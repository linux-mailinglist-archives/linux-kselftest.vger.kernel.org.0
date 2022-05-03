Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DE7519152
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 00:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240794AbiECW1U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 May 2022 18:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiECW1T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 May 2022 18:27:19 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBEC427C3
        for <linux-kselftest@vger.kernel.org>; Tue,  3 May 2022 15:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651616625; x=1683152625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xnDs4fqABVmtbO8EfV302QSHZqoqwEJa0N8z1KcZxsw=;
  b=k7cPm54cuau9jG5/LUNvTy68mMyl258JJjBKDIBcsLab4CdGE8dxj3QW
   FgK0LTNWWMINlVJDeXOpjdJ/0FCcbT5EPOp7GyJaklZH6fnYNnV+Mkr4D
   LmSV76pNHg70xBk+1B+fLEtgvuN2MyYgQ+VUf6p1QzIPVOS/hP54KodGz
   Q=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 May 2022 15:23:45 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 15:23:45 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 3 May 2022 15:23:44 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 3 May 2022
 15:23:42 -0700
Date:   Tue, 3 May 2022 18:23:40 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kselftest@vger.kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        <kvmarm@lists.cs.columbia.edu>,
        "Salil Akerkar" <Salil.Akerkar@arm.com>,
        Luca Salabrino <luca.scalabrino@arm.com>
Subject: Re: [PATCH v14 00/39] arm64/sme: Initial support for the Scalable
 Matrix Extension
Message-ID: <YnGrbEt3oBBTly7u@qian>
References: <20220419112247.711548-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220419112247.711548-1-broonie@kernel.org>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 19, 2022 at 12:22:08PM +0100, Mark Brown wrote:
> This series provides initial support for the ARMv9 Scalable Matrix
> Extension (SME).  SME takes the approach used for vectors in SVE and
> extends this to provide architectural support for matrix operations.  A
> more detailed overview can be found in [1].

Set CONFIG_ARM64_SME=n fixed a warning while running libhugetlbfs tests.

        /*
         * There are several places where we assume that the order value is sane
         * so bail out early if the request is out of bound.
         */
        if (unlikely(order >= MAX_ORDER)) {
                WARN_ON_ONCE(!(gfp & __GFP_NOWARN));
                return NULL;
        }

 WARNING: CPU: 122 PID: 4025 at mm/page_alloc.c:5383 __alloc_pages
 CPU: 122 PID: 4025 Comm: brk_near_huge Not tainted 5.18.0-rc5-next-20220503 #79
 pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __alloc_pages
 lr : alloc_pages
 sp : ffff8000505470f0
 x29: ffff8000505470f0 x28: ffff40028b3535c0 x27: 0000000000000000
 x26: 1ffff0000a0a8ea2 x25: ffff800050547510 x24: 0000000000000dc0
 x23: ffff921ddb818000 x22: 000000000000000e x21: 1ffff0000a0a8e28
 x20: 0000000000040dc0 x19: ffffae1848c61ae0 x18: ffffae18357e7d24
 x17: ffffae182fb75778 x16: 1fffe8005166a7d8 x15: 000000000000001a
 x14: 1fffe8005166a7cb x13: 0000000000000004 x12: ffff70000a0a8e03
 x11: 1ffff0000a0a8e02 x10: 00000000f204f1f1 x9 : 000000000000f204
 x8 : dfff800000000000 x7 : 00000000f3000000 x6 : 00000000f3f3f3f3
 x5 : ffff70000a0a8e28 x4 : ffff40028b3535c0 x3 : 0000000000000000
 x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000040dc0
 Call trace:
  __alloc_pages
  alloc_pages
  kmalloc_order
  kmalloc_order_trace
  __kmalloc
  __regset_get
  regset_get_alloc
  fill_thread_core_info
  fill_note_info
  elf_core_dump
  do_coredump
  get_signal
  do_signal
  do_notify_resume
  el0_svc
  el0t_64_sync_handler
  el0t_64_sync
 irq event stamp: 28066
 hardirqs last  enabled at (28065):  _raw_spin_unlock_irqrestore
 hardirqs last disabled at (28066):  el1_dbg
 softirqs last  enabled at (27438):  fpsimd_preserve_current_state
 softirqs last disabled at (27436):  fpsimd_preserve_current_state
