Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3A4872ED
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2019 09:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405567AbfHIH1z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Aug 2019 03:27:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43367 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfHIH1z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Aug 2019 03:27:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17so66643806ljk.10
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Aug 2019 00:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j5PzgqthqNRuPc/O6zjcnQFvUBq2ST4aJwKtYlkB6r0=;
        b=RiYyRscS8AoY2DF8UL5j6arJQEDjRLSdG5/XqqZNz4Wo4+ZCyBbSzF4inWxiDAU8ul
         qyFoWWGnH1ZXNJvu9J/kWnB7ExsLKsJq8N0KXEBvVyIbbbX5ENy1IKlVAlsC4QbxWLZl
         vS03VHu9dblAqsfuh4U3BZJtMySSuS/j41vhlfQb9knKb5DzPu//KSL0qGaaH873xiDi
         E1sGBP0xVFXzTLtQwCzCjStO+aVtLA0ZmBjLTu6GebHVtrXqX88z4/QaczEl3Rz8hIew
         Fod48liLXk6vvOncGcWBpuW9Fcsmw9lKfIzIL6QUYs96BCe5ITk+yShBvUX3PT4siYTM
         H8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j5PzgqthqNRuPc/O6zjcnQFvUBq2ST4aJwKtYlkB6r0=;
        b=U2yRvzqtMDecSyRsDH1I7noFZp2WoYD3UOzQoFFOU9XVTfl2C+5BVqCMiPVcO/+IAP
         jojpHMU8BzG8zoX7zVgmdGLTpOlxkpCH+om8AsybhfTcS4U/hOBu1YEux++iYsoNG+X5
         mf3R8LtJcLDfmJG7fp3i/npZbx/eGeT1jQxTHPdQPJwIFwvV6V7KObvDFmRZctig83MX
         Xp/gYiwK/9mXskGAart8oABMCAZ0l19GIkm/yMid5+zuFmL1mt9Kv/YSatrPicoXVN5c
         J0pvuv+ZRBTB//XnV02697Aiw6tEoPEplU7YAEsRP2HNF7ft2Qsw0l4Gz8MyG8Fe/Caq
         gZzg==
X-Gm-Message-State: APjAAAWjTReGeH2cnrO1HjDaunhFW/7QOfi32HKcrLHpRcbFZPa67Bea
        4SiDxnYm5b210ugDtKW/Oob9oRkxuZRFJX7ugrgiwQ==
X-Google-Smtp-Source: APXvYqyCuFeaq1a4/P9xx90As+UW4V6kMqDqpu95i79ahBuuEBrT/uchnIGIQvmzPWUXXhJlJxtGbqOmbZWadBPcaMk=
X-Received: by 2002:a2e:9b4a:: with SMTP id o10mr10632360ljj.137.1565335673522;
 Fri, 09 Aug 2019 00:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190808123140.25583-1-naresh.kamboju@linaro.org> <20190808151010.ktbqbfevgcs3bkjy@kamzik.brq.redhat.com>
In-Reply-To: <20190808151010.ktbqbfevgcs3bkjy@kamzik.brq.redhat.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Aug 2019 12:57:42 +0530
Message-ID: <CA+G9fYsj79w5t9F4P180DTFvcjxcoxVW5+SDhEK3DESvTGw4zQ@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: kvm: Adding config fragments
To:     Andrew Jones <drjones@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 8 Aug 2019 at 20:40, Andrew Jones <drjones@redhat.com> wrote:
>
> On Thu, Aug 08, 2019 at 01:31:40PM +0100, Naresh Kamboju wrote:
> > selftests kvm all test cases need pre-required kernel configs for the
> > tests to get pass.
> >
> > The KVM tests are skipped without these configs:
> >
> >         dev_fd = open(KVM_DEV_PATH, O_RDONLY);
> >         if (dev_fd < 0)
> >                 exit(KSFT_SKIP);
> >
> > Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > ---
> >  tools/testing/selftests/kvm/config | 3 +++
> >  1 file changed, 3 insertions(+)
> >  create mode 100644 tools/testing/selftests/kvm/config
> >
> > diff --git a/tools/testing/selftests/kvm/config b/tools/testing/selftests/kvm/config
> > new file mode 100644
> > index 000000000000..63ed533f73d6
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/config
> > @@ -0,0 +1,3 @@
> > +CONFIG_KVM=y
> > +CONFIG_KVM_INTEL=y
> > +CONFIG_KVM_AMD=y
> > --
> > 2.17.1
> >
>
> What does the kselftests config file do? I was about to complain that this
> would break compiling on non-x86 platforms, but 'make kselftest' and other
> forms of invoking the build work fine on aarch64 even with this config
> file. So is this just for documentation? If so, then its still obviously
> wrong for non-x86 platforms. The only config that makes sense here is KVM.
> If the other options need to be documented for x86, then should they get
> an additional config file? tools/testing/selftests/kvm/x86_64/config?

Addressed your comments and sent out v3 patch.
Thank for the review.

- Naresh
