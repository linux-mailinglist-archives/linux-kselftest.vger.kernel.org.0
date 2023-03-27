Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A206CABE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 19:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjC0Rgb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 13:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjC0Rga (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 13:36:30 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1411D10DB
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Mar 2023 10:36:30 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id g23so6945730uak.7
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Mar 2023 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679938589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEz3U669eusarpdOhYY7KYApKyeHC+XWqMsT7FRhmXs=;
        b=X/+I64ySwrBmfuGZEe53ScuVQe0B8Ih9lH+keHrzFe3gwrkz0E83XPgyzDjUMjjiDD
         g+bTo3+UwEwRHu81T6msOPGw/9FqE1f42194QiqP9/OqZiR1R34PhndLQMcrAMwVLC6N
         LPfNvhr1c113OCgxM2WojAz+Q+Kez3ZKZPWa/8h/5uSFmVfw0K9GniowrUMt2OAfWXp1
         bVALLmglOD1zHZPnG/jU7IhCa09JAxCudhOxX/pIpQ8Tq5BfTWK6uQXHczqCIVdXG2yc
         ebR608LLiKgkkwaarNjccCwreBwrPeSPEdEZIjxeA90eqtFG/BF07eNL1/nEg7n3AuHl
         ajhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679938589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEz3U669eusarpdOhYY7KYApKyeHC+XWqMsT7FRhmXs=;
        b=QS3Ek0dq/pnuhdmK3EfcYq42ewJ8zTL0Ljj/w1XA8sjqcd04ZYVmIif5rg5KCrzMVH
         UrTuO/oe7QI0/RFklr7xlsoUdemadfIAhB3yBfilL/U26Zr9uvdSYfzOkhkNcGP2ZFs/
         CShW/jTqjNJQEjXXh5qHFNy35FFfw0jonoJL6oJrhTmXLlzmFpe8VaxGnJx8AFnm/jbz
         iT5SO3bAD4RSea3JxjUP+I+cLlxQKno1Jv5jVjGIaA/DU14GW/nm8djweQ7fGJ9coaJU
         ezSKy3EYSDP0fMUskipo9dahfNtP81znGI3twxUK2zHi3qCREa6gY2pkdjx7iS/RWAVc
         KVQA==
X-Gm-Message-State: AAQBX9dgr8vUVvHkwFPr3koiJnV4uHUgiNpDg4+3k7t2PCksMeCDDNjW
        OgOzhak2tjhT9xHo2pXsTiT6Ap9rnzK8CuCM4F9UKA==
X-Google-Smtp-Source: AKy350YbDMi2uGWPOd3bHOIwEjCKN7d/pdSlcBAJGKrIOUa6ARnClHJ058kfsjjEkkbOnvGFbJbs4whviQpqhVvD2WU=
X-Received: by 2002:a1f:2dce:0:b0:436:4a89:bb11 with SMTP id
 t197-20020a1f2dce000000b004364a89bb11mr7016521vkt.0.1679938588828; Mon, 27
 Mar 2023 10:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230326062039.341479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230326062039.341479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Erdem Aktas <erdemaktas@google.com>
Date:   Mon, 27 Mar 2023 10:36:17 -0700
Message-ID: <CAAYXXYxC++kRW_Kg0jieaxuwzTC2hu-9SxRjsHH_kqZW_DTE7Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] TDX Guest Quote generation support
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
        Guorui Yu <GuoRui.Yu@linux.alibaba.com>,
        Du Fan <fan.du@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 25, 2023 at 11:20=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi All,
>
> In TDX guest, the attestation process is used to verify the TDX guest
> trustworthiness to other entities before provisioning secrets to the
> guest.
>
> The TDX guest attestation process consists of two steps:
>
> 1. TDREPORT generation
> 2. Quote generation.
>
> The First step (TDREPORT generation) involves getting the TDX guest
> measurement data in the format of TDREPORT which is further used to
> validate the authenticity of the TDX guest. The second step involves
> sending the TDREPORT to a Quoting Enclave (QE) server to generate a
> remotely verifiable Quote. TDREPORT by design can only be verified on
> the local platform. To support remote verification of the TDREPORT,
> TDX leverages Intel SGX Quoting Enclave to verify the TDREPORT
> locally and convert it to a remotely verifiable Quote. Although
> attestation software can use communication methods like TCP/IP or
> vsock to send the TDREPORT to QE, not all platforms support these
> communication models. So TDX GHCI specification [1] defines a method
> for Quote generation via hypercalls. Please check the discussion from
> Google [2] and Alibaba [3] which clarifies the need for hypercall based
Thanks Sathyanarayanan for submitting patches again.

I just wanted to reiterate what I said before that having a clean
TDVMCALL based interface to get TDX Quote without any virtio/vsock
dependency  is critical for us to support many use cases.
