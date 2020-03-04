Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE7B17994F
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 20:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgCDTvy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 14:51:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52776 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728512AbgCDTvx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 14:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583351512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ra5c/deVBpeBf2yDXKORW+EsDATadMRlpq+nR2VPF8g=;
        b=f7Km3cQ4pSUxDVHnTLDDaZnsxzdewnva77C8oYyCSuOzc2QU1HpgUWEneuhZEIOeXsxG6r
        vcd7hVehNpjQwSfuVlvAUKB8aTCU1bsQRGgCjLtPmmMn/Xj4EKZox8ea6TSOu8DN93u8rz
        JXhbM1EOPpBbgw/Z6iPCnKYgY+GNQyk=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-lpSd5DHlMJy1RWDgayagIQ-1; Wed, 04 Mar 2020 14:51:51 -0500
X-MC-Unique: lpSd5DHlMJy1RWDgayagIQ-1
Received: by mail-il1-f198.google.com with SMTP id v14so2450811ilq.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Mar 2020 11:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ra5c/deVBpeBf2yDXKORW+EsDATadMRlpq+nR2VPF8g=;
        b=QAU7m7sVi21nVa5EDsGxgkamJd0jUKPpKINh956HQfWb8I2ut8oo2M49CAveujmmIG
         F/kczNmYg92J/rNR73r2HlX0/KQ7mYzlICzZM29+YJqeaIPq7P9v1tY093rpcCFhnH8y
         jZldyT6M0ozoJx8gMsiA8ZTXOlxT12JfS1Ex9eQPPTSbJZchRYq9MaoHEXsLiJeWVC3t
         en5SKEk7bJ7PAZNTi3Ff9c3OHxwF1flBdJtKYS7BK1voMI4b7wGZAcpDRB4h30TqdkgX
         Y1qnVUd4XgzIb9RtwZGL45RtNewl5AmdxGJRWuh75J5ZQwXz03PVZJhnTep6IaoamTGd
         SVGw==
X-Gm-Message-State: ANhLgQ1Hr21oDF/+LJzRUxpu6QgUSMFvpJdYXCIwhc71M99ztzq6RFoQ
        gcqdj4RSaa2ACeaCHCFs3VeHxI3DtZ5azZlqkn0+LM6G+dlkhsO7lXJ4Usb1Jwz/rSDe+JvOnnS
        ILemu4NKvRfIe4wkj3HWEdGh6M3FDwM/uWeX9PeUKwSGq
X-Received: by 2002:a02:86:: with SMTP id 128mr4197980jaa.3.1583351510745;
        Wed, 04 Mar 2020 11:51:50 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuy4R3WkHiT3ty4P0Jvz03EvpoMWk78M0iocJAbdZEkBb/I6Emb6ZcdDRdLsaS/8iLbqomC7mabXhiUazbqKOw=
X-Received: by 2002:a02:86:: with SMTP id 128mr4197956jaa.3.1583351510519;
 Wed, 04 Mar 2020 11:51:50 -0800 (PST)
MIME-Version: 1.0
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com> <20200303233609.713348-15-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20200303233609.713348-15-jarkko.sakkinen@linux.intel.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Wed, 4 Mar 2020 14:51:39 -0500
Message-ID: <CAOASepNLGDGZ=9Rx5Pne5oK7QdQ0deonrSsdUKRsv0fzZtx1Eg@mail.gmail.com>
Subject: Re: [PATCH v28 14/22] selftests/x86: Add a selftest for SGX
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Neil Horman <nhorman@redhat.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        "Svahn, Kai" <kai.svahn@intel.com>, bp@alien8.de,
        Josh Triplett <josh@joshtriplett.org>, luto@kernel.org,
        kai.huang@intel.com, rientjes@google.com, cedric.xing@intel.com,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 3, 2020 at 6:39 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> diff --git a/tools/testing/selftests/x86/sgx/sgx_call.S b/tools/testing/selftests/x86/sgx/sgx_call.S
> new file mode 100644
> index 000000000000..ca4c7893f9d9
> --- /dev/null
> +++ b/tools/testing/selftests/x86/sgx/sgx_call.S
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/**
> +* Copyright(c) 2016-18 Intel Corporation.
> +*/
> +
> +       .text
> +
> +       .macro ENCLU
> +       .byte 0x0f, 0x01, 0xd7
> +       .endm
> +
> +       .text
> +
> +       .global sgx_call_eenter
> +sgx_call_eenter:
> +       push    %rbx
> +       mov     $0x02, %rax
> +       mov     %rdx, %rbx
> +       lea     sgx_async_exit(%rip), %rcx
> +sgx_async_exit:
> +       ENCLU
> +       pop     %rbx
> +       ret

You need to push and pop all the callee-saved registers here since the
enclave zeros them. This code works today by accident. A future
compiler may emit different register allocation which will cause this
to break.

We might consider making it part of the Linux enclave ABI that the
enclave has to save and restore these registers. This would have a
slight performance advantage in a critical code-path compared to
zeroing and then restoring them. But the VDSO code will need to know
what the expectation is.

