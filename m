Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764FC55953D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jun 2022 10:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbiFXIUe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jun 2022 04:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiFXIUd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jun 2022 04:20:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1676F78F;
        Fri, 24 Jun 2022 01:20:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56E15B827BF;
        Fri, 24 Jun 2022 08:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D12DC341CC;
        Fri, 24 Jun 2022 08:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656058830;
        bh=FcLlyPrf+AWrPxtRYAiOsrBgwpm9O+rmChbmP3sd0wY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XNpqqTnFiQiQJZzBEufwWE28MJ0aOsyAy2KEUHaB1BH4s8HTiMq2VnpCOYcK2uiHt
         6hPcr6jSaPU8AKFcBlCVQienOkPhBpHdVcc57fh5OJQIyYFinFgrD8zjPcxZBbvub4
         poU+y/NSsVc/kPHU/LIXPFWx6CgZ18on+MHP3ZuIWOgiaLsBGSwpk35dMgNiTKKT4p
         hPncKazS4R645pBJdBVdX5PYEfw1nyXKLQo+enzFQ6kJYxS3gDLVPxXjC00euYose6
         1TFpC2K4GZ353AtZOF/iceCHYjbm6myWzpEdkR1JHm0kjnr26L5UOgnkFibV+skVfh
         h5a8ZcHfygaCQ==
Received: by mail-oi1-f182.google.com with SMTP id u9so2655872oiv.12;
        Fri, 24 Jun 2022 01:20:29 -0700 (PDT)
X-Gm-Message-State: AJIora915IUXubE2wCPuKAmnXrbLERiq7Ts9quA86XeZ0a69AQ6KD7wJ
        Y+rcxZe/Sz1qUiSQUpwdFq3hQVSwFSMHL7AAJsU=
X-Google-Smtp-Source: AGRyM1vD+QRApq+BxH0OZkrLfEtJbkX9khKKuqalP0FlAmgF7yLvq3N4ZOo0N3wmIU1EpYhYOZVcip/2Pl3XtJb7Zyk=
X-Received: by 2002:a05:6808:13c6:b0:335:3e54:94bc with SMTP id
 d6-20020a05680813c600b003353e5494bcmr1174367oiw.228.1656058829220; Fri, 24
 Jun 2022 01:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220616124740.580708-1-ardb@kernel.org> <20220616124740.580708-2-ardb@kernel.org>
 <dba0cbb3e516ce715939be3638d2b5639608f2c1.camel@linux.ibm.com>
In-Reply-To: <dba0cbb3e516ce715939be3638d2b5639608f2c1.camel@linux.ibm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 24 Jun 2022 10:20:18 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEvhtpF45R7-d6Q2ROhZRJ9i7JsSj3tScJk6b=TmG_kgQ@mail.gmail.com>
Message-ID: <CAMj1kXEvhtpF45R7-d6Q2ROhZRJ9i7JsSj3tScJk6b=TmG_kgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] selftests/kexec: remove broken EFI_VARS secure
 boot fallback check
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 17 Jun 2022 at 05:51, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Thu, 2022-06-16 at 14:47 +0200, Ard Biesheuvel wrote:
> > Commit b433a52aa28733e0 ("selftests/kexec: update get_secureboot_mode")
> > refactored the code that discovers the EFI secure boot mode so it only
> > depends on either the efivars pseudo filesystem or the efivars sysfs
> > interface, but never both.
> >
> > However, the latter version was not implemented correctly, given the
> > fact that the local 'efi_vars' variable never assumes a value. This
> > means the fallback has been dead code ever since it was introduced.
> >
> > So let's drop the fallback altogether. The sysfs interface has been
> > deprecated for ~10 years now, and is only enabled on x86 to begin with,
> > so it is time to get rid of it entirely.
> >
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Thanks, Ard.
>
> Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>
>

Thanks Mimi, I've queued this up in efi/next.
