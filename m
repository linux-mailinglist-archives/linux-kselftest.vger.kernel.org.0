Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D1F6F4CDE
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 May 2023 00:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjEBW2L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 18:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjEBW2J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 18:28:09 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457021FCF
        for <linux-kselftest@vger.kernel.org>; Tue,  2 May 2023 15:28:08 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b9dcd91a389so5495259276.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 May 2023 15:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683066487; x=1685658487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwFGIxh3mR4IxnfjO7Fh/+VSIOsZ1HZ3AsHMkzhJzVc=;
        b=LV4Xm+Pf/B+mhX6Eux2/d4iyrBd+wh5nhjdM+6mLRXMO0SKOeWUfAlVseraSM1dEGE
         zp84L/n/KBh/e0R29D/3dwDFGaI3EmTrw4gip9y8rvwrtj6zd510NLG9bCl8vpjqlLk6
         o2KkipHhztX/aduTGfL4R2o2kOeTZ9dixM84r1Sqyq6Qo6RT5YMk02pcMg+hrqkPPtkf
         btppu9GSiN7ZpCPLog7vQNKAz5X0GBqCYIc6rYgC6Xgwc7lFXuKzu5gZRkmivJTBYDGs
         RXlaV1cyEDnI8lJFyjWOkhHyQhdqvPPGPVyeXM4agzscC27+w9gcBgbcS8H8+y6pNjoT
         HrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683066487; x=1685658487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwFGIxh3mR4IxnfjO7Fh/+VSIOsZ1HZ3AsHMkzhJzVc=;
        b=O5kdUldj1yAW9z96igWlWS+boT08KXCHaC2ltlxMRUPV0GRCRZRxxyngBSI59eTvWT
         Fu7kQbkPdIVbvyEFNf0I4ViXiJ0OvZg7FcmuDObXP6BoSHF2pye/SHbiTCe4fNoEY6cE
         Qst3X1BLZ8hO1e7pzcyrI3KY40j6Axf7DvIIq1FXVXCln3RdoQGzWjmOHIJMgR5aKiJa
         KGs/0QABnRkvbRMd3ev9qt8JDd4X4jBTfbRu55xCdr1SZxV+loqU7n/8mqVLkbcgrzM7
         cixSSawXLFJ6W1qsemmVb5tR6v49s8TOeMJQTsZW0NfqFbnUEe1vKn1uBvRbIEyCDse4
         vO1A==
X-Gm-Message-State: AC+VfDza1UlxRduxdOV5/wffmGXO1FJV6vBWlIr+9hX0U8jI8O9MpcFK
        CRiM7/Vf5BArK4iwjKFmRgVgtEUxL+5HXDxSCka/1A==
X-Google-Smtp-Source: ACHHUZ429eSlqZEB+CY548Pp/dt5SSi39y/Hd6nprAFMirATPj3cxRLNBRv8xuZqzR4rjXejkS2Zjep2a9MBdAJUsCs=
X-Received: by 2002:a25:ad91:0:b0:b96:9160:8da4 with SMTP id
 z17-20020a25ad91000000b00b9691608da4mr17677838ybi.17.1683066487198; Tue, 02
 May 2023 15:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230413034108.1902712-3-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230413034108.1902712-3-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Chong Cai <chongc@google.com>
Date:   Tue, 2 May 2023 15:27:53 -0700
Message-ID: <CALRH0CjQhSzWhpjS2+Wp1xWswyK=eNmBGVpbVGr4sM0tMZT5pQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] virt: tdx-guest: Add Quote generation support
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Qinkun Bao <qinkun@apache.org>,
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 12, 2023 at 8:42=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> In TDX guest, the second stage in attestation process is to send the
> TDREPORT to QE/QGS to generate the TD Quote. For platforms that does
> not support communication channels like vsock or TCP/IP, implement
> support to get TD Quote using hypercall. GetQuote hypercall can be used
> by the TD guest to request VMM facilitate the Quote generation via
> QE/QGS. More details about GetQuote hypercall can be found in TDX
> Guest-Host Communication Interface (GHCI) for Intel TDX 1.0, section
> titled "TDG.VP.VMCALL<GetQuote>".
>
> Add support for TDX_CMD_GET_QUOTE IOCTL to allow attestation agent
> submit GetQuote requests from the user space using GetQuote hypercall.
>
> Since GetQuote is an asynchronous request hypercall, VMM will use
> callback interrupt vector configured by SetupEventNotifyInterrupt
> hypercall to notify the guest about Quote generation completion or
> failure. So register an IRQ handler for it.
>
> GetQuote TDVMCALL requires TD guest pass a 4K aligned shared buffer
> with TDREPORT data as input, which is further used by the VMM to copy
> the TD Quote result after successful Quote generation. To create the
> shared buffer, allocate the required memory using alloc_pages() and
> mark it shared using set_memory_decrypted() in tdx_guest_init(). This
> buffer will be re-used for GetQuote requests in TDX_CMD_GET_QUOTE
> IOCTL handler.
>
> Although this method will reserve a fixed chunk of memory for
> GetQuote requests during the init time, it is preferable to the
> alternative choice of allocating/freeing the shared buffer in the
> TDX_CMD_GET_QUOTE IOCTL handler, which will damage the direct map.

Thanks Sathyanarayanan for the work. The patch looks good. Reserving a fixe=
d
chunk of memory for GetQuote makes sense to me.

And just want to re-emphasize that the TDVMCALL approach is important for
many use cases that cannot depend on virtio/vsock.
