Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9036CCB23
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 22:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjC1UAm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 16:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjC1UAl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 16:00:41 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDA140DA
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 13:00:06 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id fb38so8809534pfb.7
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 13:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680033571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/yvlhEoGf4lYD0w5w4illgGKFOLps9NjXpDI+7ErcQ=;
        b=Kj4ahUJ17/TklSj8P4aYyhNWSNUggUnfHpq42Yf2/g2G1VGWGWrewPLvp9vsLX/JEg
         Bo8mZjMkfy7Ctlho2KRKOpKqTbOfwp+ZKHRKs6VdamQXWlk+XXleJft4Oz61Oo6NQ4pw
         KGYJwhnhB3/D0jfIu8miCDACYf921OreR3HQSswBQW4rpuJCq8+F+dboOuddBBTNRJ7Q
         VAjey0lem6IOqAD6Q/8oNVUFh4Oe+mz5d1NunBWyGOByo8e7HkQXRnaO9wXGbSxcVuOU
         k+XH0lQKF/eHBchip2FdOmhmF1eQBFBUO8i0IDxZ9EOdGZNFd8SUBL8dWE5arhzeF1Al
         3IIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680033571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/yvlhEoGf4lYD0w5w4illgGKFOLps9NjXpDI+7ErcQ=;
        b=Js1OHaq1IKQjpagm2T6CpAyVdDRJKmFbZhs9eCUqXINYel/7A404Cr4gAsc6GCgA0R
         /6Yx2mi0ogA+397t/536snEbneemHXpfLWL/EBwinLaaMlWRqqBQ95vZEniuqvXagY81
         XFnaPrqc9wQmq1B7rt5J6MGmiEPkuXM5FJZQbq9hRb8arO/HSiKgg9Rgoqy2tQxcM5vg
         622g9MTlnxUnu/s5b6/G9uZfL8OjlQQcwn9wq4KyBpJR/mAS5QGT4JgCiXAqBz0Kltzg
         a5BalwpvejIbX/rwUHoNrZ2C6PIZzaAnkmX3Lms8OmO3ohXx2A+3qmwU/Y3r5JNmtAFn
         DFGQ==
X-Gm-Message-State: AAQBX9fcQZlWfSsDvre86KAl3JfS9c9A6iSsz+gIEF+jwcaxSz07vf/Q
        gQEHmmmbUEVNentpG8/ESNuyvILEHvQCVRf5l3nvHw==
X-Google-Smtp-Source: AKy350a02nhWjZJNaefPpoZ0AZzLMqgU+rjEYIaK5jw3IZfaHRS4Bp2uRB/lOVaXyN/t2Dcrapc37Bok73ZdIIbqPUU=
X-Received: by 2002:a63:5a47:0:b0:513:2523:1b5f with SMTP id
 k7-20020a635a47000000b0051325231b5fmr4363099pgm.3.1680033570922; Tue, 28 Mar
 2023 12:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230326062039.341479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAAYXXYxC++kRW_Kg0jieaxuwzTC2hu-9SxRjsHH_kqZW_DTE7Q@mail.gmail.com>
In-Reply-To: <CAAYXXYxC++kRW_Kg0jieaxuwzTC2hu-9SxRjsHH_kqZW_DTE7Q@mail.gmail.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 28 Mar 2023 12:59:18 -0700
Message-ID: <CAAH4kHZWW6QsMcLCLYwRo25i6d6Uhg+=rTeoVV7yrGHqUWwFUQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] TDX Guest Quote generation support
To:     Erdem Aktas <erdemaktas@google.com>, Chong Cai <chongc@google.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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

+Chong Cai

Adding a colleague per his request since he's not subscribed to the list ye=
t.

On Mon, Mar 27, 2023 at 10:36=E2=80=AFAM Erdem Aktas <erdemaktas@google.com=
> wrote:
>
> On Sat, Mar 25, 2023 at 11:20=E2=80=AFPM Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >
> > Hi All,
> >
> > In TDX guest, the attestation process is used to verify the TDX guest
> > trustworthiness to other entities before provisioning secrets to the
> > guest.
> >
> > The TDX guest attestation process consists of two steps:
> >
> > 1. TDREPORT generation
> > 2. Quote generation.
> >
> > The First step (TDREPORT generation) involves getting the TDX guest
> > measurement data in the format of TDREPORT which is further used to
> > validate the authenticity of the TDX guest. The second step involves
> > sending the TDREPORT to a Quoting Enclave (QE) server to generate a
> > remotely verifiable Quote. TDREPORT by design can only be verified on
> > the local platform. To support remote verification of the TDREPORT,
> > TDX leverages Intel SGX Quoting Enclave to verify the TDREPORT
> > locally and convert it to a remotely verifiable Quote. Although
> > attestation software can use communication methods like TCP/IP or
> > vsock to send the TDREPORT to QE, not all platforms support these
> > communication models. So TDX GHCI specification [1] defines a method
> > for Quote generation via hypercalls. Please check the discussion from
> > Google [2] and Alibaba [3] which clarifies the need for hypercall based
> Thanks Sathyanarayanan for submitting patches again.
>
> I just wanted to reiterate what I said before that having a clean
> TDVMCALL based interface to get TDX Quote without any virtio/vsock
> dependency  is critical for us to support many use cases.



--=20
-Dionna Glaze, PhD (she/her)
