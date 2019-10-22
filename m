Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4224DFC4C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2019 05:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbfJVDwi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Oct 2019 23:52:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38061 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387535AbfJVDwh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Oct 2019 23:52:37 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so18660723iom.5
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2019 20:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FxtP6LHW6dqlss4EwQUZ1wXN2G3RpiQ3MS6NIo0dknE=;
        b=E3pvzofUR8jbkd6Cf5EjS720xDvKqbPCki8egQnEhlPQ3g1A6HO/aJSnOY9/H7oFsp
         rqNEIvOE06i9Hkv3QbDwt7Mrl+DKNQ3was1B4q/+wPc/2Ct3PairkLjbugJLNevL/2X2
         mIXQ4cjYCkK0nHot+7rzfGf8PeIsE0W9fBH4/lJFPC1ww0Ue8hBtEGsnaUJ9Gqn31gZp
         mSEYbT8KECqjLq5d6J/AsZwhH9LYL3OtL+VDmpSZ/RSNXt77jBPPqPbU51TRPXRn6Yj6
         CiWZ7CeB6qtMEqp5yWHNkhQb49fl3p7/rA1xdQ7pJLjl1UYr8DulJ9DO+kCtQVVwYqKD
         XFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxtP6LHW6dqlss4EwQUZ1wXN2G3RpiQ3MS6NIo0dknE=;
        b=IvrFVZgYVrvPD6vWpl5gXlSCkAhfldD5FC35wdVnfeHpAhcqvz/MaOc5ioH2qLlwf8
         4iTcMDAm6UPcJ0zAOZkwah1evdKuozbqp0yrPiTIGfMbKjsDkapI/lPiiOwhRWrMFPyw
         2cJJ+AJNCPjCvNmJyMC8sTaM+EoKF/PhISq1w5wOfENn/muoKNcHPN78vnmtaj7xvns7
         kJnemBo/v1xqlNoDDHfCHRqab2fssM6N36dfAboqGIy4wdtZnJVou9oUKYzxZLeSt5Wh
         YxtJoUyQIhbbyikxYUCnu3V7i8olGdriSxv5gsESpg9b5VBmhW6JCC0z0FdpFXMEh/Ve
         AjOg==
X-Gm-Message-State: APjAAAW/wBe170xQwK2JFt8/mMjpfWhcP/UMlpbuMF4tZGIZSU32u4Cy
        6xRX/mHiVfutRUnfNXjnTXx0hXU7EyFkjs/SM3E=
X-Google-Smtp-Source: APXvYqxr6ujhlwYycsD/1DFkuLfSPKGd0cD8Fx7AsG52cgnE6UUtL6p0JMVeQ2C6m4lOdQJCzjZ4aB0Fhn9ZdqdIzI4=
X-Received: by 2002:a02:77c4:: with SMTP id g187mr1684888jac.83.1571716355529;
 Mon, 21 Oct 2019 20:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191020122452.3345-1-prabhakar.pkin@gmail.com> <09db8f9d-98b9-e3ae-9eea-ae45e94d3053@arm.com>
In-Reply-To: <09db8f9d-98b9-e3ae-9eea-ae45e94d3053@arm.com>
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date:   Tue, 22 Oct 2019 09:22:24 +0530
Message-ID: <CAJ2QiJ+PORAhUQHnbnG3mKKU6WAF6rxrWZhLrQ2_1fYeOxv-9A@mail.gmail.com>
Subject: Re: [PATCH] kselftest: Fix NULL INSTALL_PATH for TARGETS runlist
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Dear Cristian,

On Mon, Oct 21, 2019 at 4:15 PM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> Hi
>
> On 20/10/2019 13:24, Prabhakar Kushwaha wrote:
> > As per commit 131b30c94fbc ("kselftest: exclude failed TARGETS from
> > runlist") failed targets were excluded from the runlist. But value
> > $$INSTALL_PATH is always NULL. It should be $INSTALL_PATH instead
> > $$INSTALL_PATH.
> >
> > So, fix Makefile to use $INSTALL_PATH.
> >
>
> I was a bit puzzled at first since I never saw the NULLified value while testing
> the original patch. Looking at it closely today, I realized that I used to test it
> like:
>
> $ rm -rf $HOME/KSFT_TEST && make -C tools/testing/selftests/ INSTALL_PATH=$HOME/KSFT_TEST install
>
> which in fact causes INSTALL_PATH to be exported down to the subshell in the recipe, so that even
> referring it as $$INSTALL_PATH from the recipe line make it work fine.
>
> Instead, using the default Makefile provided value (unexported) by invoking like:
>
> $ rm -rf $HOME/KSFT_TEST && make -C tools/testing/selftests/ install
>
> exposes the error you mentioned, being INSTALL_PATH not accessible form the subshell and so NULL.
> Moreover it's anyway certainly better to refer with $(INSTALL_PATH) being it a strict Makefile var.
> So it's fine for me, thanks to have spotted this.
>
> Reviewed-by: cristian.marussi@arm.com
>

Thanks for Reviewing.

I have to send v2 patch with author mail id fix. I will keep your Reviewed-by.

--prabhakar (pk)


>
> > Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> > Signed-off-by: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
> > CC: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  tools/testing/selftests/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> > index 4cdbae6f4e61..612f6757015d 100644
> > --- a/tools/testing/selftests/Makefile
> > +++ b/tools/testing/selftests/Makefile
> > @@ -213,7 +213,7 @@ ifdef INSTALL_PATH
> >       @# included in the generated runlist.
> >       for TARGET in $(TARGETS); do \
> >               BUILD_TARGET=$$BUILD/$$TARGET;  \
> > -             [ ! -d $$INSTALL_PATH/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
> > +             [ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
> >               echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
> >               echo "cd $$TARGET" >> $(ALL_SCRIPT); \
> >               echo -n "run_many" >> $(ALL_SCRIPT); \
> >
>
