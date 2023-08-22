Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243BE784BC5
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 23:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjHVVHG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 17:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjHVVHG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 17:07:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA29CEE
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Aug 2023 14:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692738377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eozuvkXZf7lt2j4GJR5fEMVPoz5joKAi735jAZphMzo=;
        b=Vrsh0ntw9UDNTvm7I2EJ+VRwN88hm2Mfc6ldba94pc3KYv9gAUKTpx6Mgw+6D3/CmJKyL+
        pBXAE6PzOXJLaUwJPEAOzlVTON7IiDXm6HpCbETW6vHMZ1xOQI8/Aahxe7ql3srifTC2Vn
        DhbhabENSE/1h4EhwBsrhfRXsUhBSoo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Pcliy4T0PVaV2iHnn6T8IQ-1; Tue, 22 Aug 2023 17:06:15 -0400
X-MC-Unique: Pcliy4T0PVaV2iHnn6T8IQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4ff75f3239aso5245908e87.3
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Aug 2023 14:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692738374; x=1693343174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eozuvkXZf7lt2j4GJR5fEMVPoz5joKAi735jAZphMzo=;
        b=SnxeFnNYY5rgNdJEaGbusLkJd/q82Qa0vKxbZsl7seik8gRKTarryqhijz7dbNxu09
         WMK7btOEdspYNSh27ZgQUT1ZGOXoncKD4cD0dE1TCqTu2XdiGfWjpDIGRzofoyQn/u94
         b2qNd+rnIW1SjViE9pJjn1A99JyrByGsd99H+kW1p9K+CPyNZpBXSs27EDjh7NyzUOMp
         CaC6EsKBNb7OlSXMqoYwbYIn5FPWo/SahHPZcFRKp9AnTNTZXBfpDaU2dXekyxc6Dkkg
         pwGwZuMmzsh+d0f3myjLyx7eI9KrOuqDWiagIK+NVlFpd6fbB7j8Y/sYTMAyt9hqEAQ7
         2EGg==
X-Gm-Message-State: AOJu0YwdXwx3HTWfRpW//+jGokIDskgK/T9V33dcs8G5UzLEIgXz5IIz
        zZ25gAWZDDGwSxobEZ3lH5SfIgERxeDgRLsQE+Ivv4mpdXVQv5gxMd29AwUg5bxMFebZK95WoqW
        F7CWlOOKV/ezPJVmIT4MeRukb3gl2NOXRsTliJMEJoqS5
X-Received: by 2002:ac2:55a7:0:b0:500:8fcd:c3b5 with SMTP id y7-20020ac255a7000000b005008fcdc3b5mr1464012lfg.12.1692738374175;
        Tue, 22 Aug 2023 14:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeNyF1wlvbOJcWPDTAWORFiO3zXf51SnVR8DhrtgaVaRfNn3Wuj/OWqV2eXbAGJfYHTm1809Rq9Jm3OA9QzNg=
X-Received: by 2002:ac2:55a7:0:b0:500:8fcd:c3b5 with SMTP id
 y7-20020ac255a7000000b005008fcdc3b5mr1464006lfg.12.1692738373861; Tue, 22 Aug
 2023 14:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
 <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
 <CAO-hwJLio2dWs01VAhCgmub5GVxRU-3RFQifviOL0OTaqj9Ktg@mail.gmail.com> <CAFhGd8qmXD6VN+nuXKtV_Uz14gzY1Kqo7tmOAhgYpTBdCnoJRQ@mail.gmail.com>
In-Reply-To: <CAFhGd8qmXD6VN+nuXKtV_Uz14gzY1Kqo7tmOAhgYpTBdCnoJRQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 22 Aug 2023 23:06:02 +0200
Message-ID: <CAO-hwJJ_ipXwLjyhGC6_4r-uZ-sDbrb_W7um6F2vgws0d-hvTQ@mail.gmail.com>
Subject: Re: selftests: hid: trouble building with clang due to missing header
To:     Justin Stitt <justinstitt@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 22, 2023 at 10:57=E2=80=AFPM Justin Stitt <justinstitt@google.c=
om> wrote:
>
[...]
> > > > Here's the invocation I am running to build kselftest:
> > > > `$ make LLVM=3D1 ARCH=3Dx86_64 mrproper headers && make LLVM=3D1 AR=
CH=3Dx86_64
> > > > -j128 V=3D1 -C tools/testing/selftests`
> >
> > I think I fixed the same issue in the script I am running to launch
> > those tests in a VM. This was in commit
> > f9abdcc617dad5f14bbc2ebe96ee99f3e6de0c4e (in the v6.5-rc+ series).
> >
> > And in the commit log, I wrote:
> > ```
> > According to commit 01d6c48a828b ("Documentation: kselftest:
> > "make headers" is a prerequisite"), running the kselftests requires
> > to run "make headers" first.
> > ```
> >
> > So my assumption is that you also need to run "make headers" with the
> > proper flags before compiling the selftests themselves (I might be
> > wrong but that's how I read the commit).
>
> In my original email I pasted the invocation I used which includes the
> headers target. What are the "proper flags" in this case?
>

"make LLVM=3D1 ARCH=3Dx86_64 headers" no?

But now I'm starting to wonder if that was not the intent of your
combined "make mrproper headers". I honestly never tried to combine
the 2. It's worth a try to split them I would say.

Cheers,
Benjamin

