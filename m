Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3046CCB96
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 22:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjC1Unw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 16:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjC1Unw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 16:43:52 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977831721
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 13:43:50 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-545ce8e77fcso176773527b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 13:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680036230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa0LfFSjVxiVuRv97x/zQwaxJI/K9lza1arifqvGksw=;
        b=O/2GpUlj5wwbEi1Kekelt0BSM8jT3q6K9BPbeFRL/HOLPyzBwut4I7tfHO4vMde8Vp
         fxLILFCiGZolEDUb9SNUHf6mT3LOusPAB/rbryqkJ5fdK03sVWQB5e09K6W2Tg2dW6eU
         0NW6+NJhFwGEt+hboYzSw4xMrCFtiaIm+0AtP0tt0qRm9JbCnFS7rLBUMiRXzy+mB3W7
         MbBy+RgQz8rzixGuilnbiPl3tMM8xV+U0e4B2ZQ/XwrrDE1HrkOIqg/FCvUlmPHT7X+4
         BWgCpCsUVEsIToMaIkXjoaYSVJtS1UFITQdsn25qWYujXhnY4K5cuRTtETOJ7YVJLG/E
         msbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680036230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wa0LfFSjVxiVuRv97x/zQwaxJI/K9lza1arifqvGksw=;
        b=RS0lGJW1PxRan/oPmbSzCo00dX2Wh6g9ylf8BLDKwdG/Wi2H3zVxYLDCijoVZQIXgd
         tk7Wi22KIDAZo4awZtUPDKiU91D4Eu/luO/iqkI3iFoMQYBrm5ASOXWYk+69go/5fQD2
         rjlY6Zjdcp2H+lvkKhuqtUxedUjTunNSQNSdy2NYARP2qX0v+lBovlTfv+76Y8IZTvoC
         6rAr2+BVPVsafExKNxPwe+CB4D4fDqhjPFQff82lXDiv9/QywotfojKK9O142QfcOkKU
         QI6GyX2yutEmgRDVw9rhUZcoOQzxC07Lqu9GYSe2O6rST0L11lh1k2nTuMvdmey6WTrW
         FZXA==
X-Gm-Message-State: AAQBX9fL6EsgO0r+88asbJQxkvp0GYIdv07rwnfaLbsZcJE3+87ZYc8z
        HEQyk7hyTv0GR30FOzYyCKF0MQZb+QdL+veac9vgBA==
X-Google-Smtp-Source: AKy350aw2E9VYrmeTnJprBZcBOtblePseGi0OF0lUoBNJrLP0cQxQckQ7y4WztgnEs8YWj52AgFk7vsmlyozuICsg8o=
X-Received: by 2002:a81:ad5d:0:b0:540:e744:13ae with SMTP id
 l29-20020a81ad5d000000b00540e74413aemr7016748ywk.3.1680036229542; Tue, 28 Mar
 2023 13:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230326062039.341479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAAYXXYxC++kRW_Kg0jieaxuwzTC2hu-9SxRjsHH_kqZW_DTE7Q@mail.gmail.com> <CAAH4kHZWW6QsMcLCLYwRo25i6d6Uhg+=rTeoVV7yrGHqUWwFUQ@mail.gmail.com>
In-Reply-To: <CAAH4kHZWW6QsMcLCLYwRo25i6d6Uhg+=rTeoVV7yrGHqUWwFUQ@mail.gmail.com>
From:   Chong Cai <chongc@google.com>
Date:   Tue, 28 Mar 2023 13:43:37 -0700
Message-ID: <CALRH0ChZ7dtJ9ST-mbjVz7Q2jY9QQm6mor5137YyFtSX4td-bw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] TDX Guest Quote generation support
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     Erdem Aktas <erdemaktas@google.com>,
        Kuppuswamy Sathyanarayanan 
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

On Tue, Mar 28, 2023 at 12:59=E2=80=AFPM Dionna Amalie Glaze
<dionnaglaze@google.com> wrote:
>
> +Chong Cai
>
> Adding a colleague per his request since he's not subscribed to the list =
yet.
>
> On Mon, Mar 27, 2023 at 10:36=E2=80=AFAM Erdem Aktas <erdemaktas@google.c=
om> wrote:
> >
> > On Sat, Mar 25, 2023 at 11:20=E2=80=AFPM Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> > >
> > > Hi All,
> > >
> > > In TDX guest, the attestation process is used to verify the TDX guest
> > > trustworthiness to other entities before provisioning secrets to the
> > > guest.
> > >
> > > The TDX guest attestation process consists of two steps:
> > >
> > > 1. TDREPORT generation
> > > 2. Quote generation.
> > >
> > > The First step (TDREPORT generation) involves getting the TDX guest
> > > measurement data in the format of TDREPORT which is further used to
> > > validate the authenticity of the TDX guest. The second step involves
> > > sending the TDREPORT to a Quoting Enclave (QE) server to generate a
> > > remotely verifiable Quote. TDREPORT by design can only be verified on
> > > the local platform. To support remote verification of the TDREPORT,
> > > TDX leverages Intel SGX Quoting Enclave to verify the TDREPORT
> > > locally and convert it to a remotely verifiable Quote. Although
> > > attestation software can use communication methods like TCP/IP or
> > > vsock to send the TDREPORT to QE, not all platforms support these
> > > communication models. So TDX GHCI specification [1] defines a method
> > > for Quote generation via hypercalls. Please check the discussion from
> > > Google [2] and Alibaba [3] which clarifies the need for hypercall bas=
ed
> > Thanks Sathyanarayanan for submitting patches again.
> >
> > I just wanted to reiterate what I said before that having a clean
> > TDVMCALL based interface to get TDX Quote without any virtio/vsock
> > dependency  is critical for us to support many use cases.
>
> +1 to Erdem's point. A simple TDVMCALL interface could make it much
> easier for user cases that can not depend on virtio and vsock.
> Without the TDVMCALL, it will largely limit those user cases to adopt TDX=
.
> Thanks Sathyanarayanan for submitting this patch.
> --
> -Dionna Glaze, PhD (she/her)
