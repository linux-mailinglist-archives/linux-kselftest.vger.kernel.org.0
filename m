Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6A521893FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Mar 2020 03:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCRCTp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Mar 2020 22:19:45 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33987 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgCRCTp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Mar 2020 22:19:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id f3so8751234lfc.1;
        Tue, 17 Mar 2020 19:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+VfuB29bj2H8QrZo10ASzsk+M2zZbRzyQjPcMMzwV4=;
        b=T89vFjMXgz577doE0CXCapQR3nnlT34DYxkvP8owAxarl2u8Ugp/gO2BWu8ZhjYhud
         FvM0erR2Vd8I7CFJtw/8wNxC4LyznUteEbs2FMElFVKoITWmscb+dVDGL8m7nFitUuaa
         KQH58lbj+ETX2wNm3C80QAjU962ghiyEewfzCf9MJsWXAhHyWfn5/UzejTaUqnvWuArh
         UpCZ5NIxbXvZMAgueHerOK3kw+WX4ICjzeLY+Vbez0XvummtXUN3WOIJWUsiAhbPqlHM
         DictrMEoiaSsyo6b5hDtTkNlq0uKh5zRXlwsd0njP37fqO5UQXo+AfArZxNzJkjku+qI
         tOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+VfuB29bj2H8QrZo10ASzsk+M2zZbRzyQjPcMMzwV4=;
        b=J4cqyLwr0axPsE/lWLXrpixfiypWQPZCkISNhG7qTG1Bv0OoffZ6jN8Cy3sxB/RvEk
         aqtT2qWIaNL1W0BBO7PtkqDt7FrZn29D/rNlcg2C7IyL416phhs/Na1ijFNhT6K6E2n6
         CEhx0TtqIwP/eokNup9wwzJ6L1mlGmxf8J8qKG8oStOp4w6/LznDJ6amxsABiwJbaIGS
         akf+qaIPZ2GHUneVcTgZnh/mTgcNgT6ttavBXThAiivXpP6uDoO3pIQWg2eX+XYba9tF
         XtinUCI2okgRWvGl5WWLVDCiAvXNJoFsuB7cebTRkWPutOD1OH94QAIcPd/hQQ/I/yHb
         aTEQ==
X-Gm-Message-State: ANhLgQ0ppbIk1kuBImajIC4QVOhAdZWOnlPtXSvFy/6XsZAXYMvtkn25
        A+JYB1o/5Y68Z51EP4dUWhEBRsYpcaI7YQ0JDGg=
X-Google-Smtp-Source: ADFU+vvpU0kyxySDVrSQPRlOHLgNV3BJCSJ95MCdS4ihBCkxWEsR6ymOk2rRF3KseI9E+Lu10U20qB1TnPzWKh04oJY=
X-Received: by 2002:ac2:4191:: with SMTP id z17mr115723lfh.73.1584497983022;
 Tue, 17 Mar 2020 19:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <1583300076-28392-1-git-send-email-leon.he@unisoc.com> <9be2873c-79c2-2d02-f15a-1e6e0ff7e898@kernel.org>
In-Reply-To: <9be2873c-79c2-2d02-f15a-1e6e0ff7e898@kernel.org>
From:   xiaolong he <hexiaolong2008@gmail.com>
Date:   Wed, 18 Mar 2020 10:19:22 +0800
Message-ID: <CAN9aa7qfmY6nuVf7CLYLn4i5h28pDOMceup4vFNQmKM1gLdPqA@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: heaps: bugfix for selftest failure
To:     shuah <shuah@kernel.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, Leon He <leon.he@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>
> On 3/3/20 10:34 PM, Leon He wrote:
> > If the 'name' array in check_vgem() was not initialized to null, the
> > value of name[4] may be random. Which will cause strcmp(name, "vgem")
> > failed.
>
> Nit: "to fail" instead of "failed"

OK, thanks!

>
>
> >
> > Signed-off-by: Leon He <leon.he@unisoc.com>
> > ---
> >   tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> > index cd5e1f6..21f3d19 100644
> > --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> > +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> > @@ -22,7 +22,7 @@
> >   static int check_vgem(int fd)
> >   {
> >       drm_version_t version = { 0 };
> > -     char name[5];
> > +     char name[5] = { 0 };
> >       int ret;
> >
> >       version.name_len = 4;
> >
>
> return !strcmp(name, "vgem");
>
> While you are at it, why not change strcmp() to strncmp()?
>

OK, I'll change it in patch v3.

thanks,
-- Leon
