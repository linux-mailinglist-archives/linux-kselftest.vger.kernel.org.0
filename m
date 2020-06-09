Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C721F47A1
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jun 2020 21:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgFIT7I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Jun 2020 15:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFIT7H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Jun 2020 15:59:07 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D80CC05BD1E
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Jun 2020 12:59:07 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id m2so1870299pjv.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jun 2020 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JYzHVam3aoxA7E3Nf+mPqLW8Cnq9QYwGHyougBUIUM=;
        b=AUTUaWX5mOdyWQvV9aN3Fs0Fise7Hqja4tWkV/PiRtUIxNvqLKLYiphFbWB7b/O6aO
         uTR5rgofmlKNCQOkMsJaV6qZKZ2Gp+SxhXIoDMZPSsdV235fIHAuLEULkHuqXXrY1a17
         msFy9ZV9xEoWbKlBjUrq75XEbUgFscR2TyaC9FxQUDaJC+dDXdbPUGxnWd+UTif5RKF1
         8kwGGgfPh7GOQCiHqMDZd6KdYBbJWbibjNxQGA8YcQKBG7yjZdqz3GVDh61izcnneGGz
         EEcoQys1jUziFulDUbSmEfzY5XN054YMd5xR2VOnw9mB/ddLUI0nPhhAv/TI0tbUZ20P
         LteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JYzHVam3aoxA7E3Nf+mPqLW8Cnq9QYwGHyougBUIUM=;
        b=NdSBqxRmyfzUEB7lhOKiCOKr7fLbyuc0jfslTCRqq16NYQCLHXY9JKrABzUOjwKYvv
         SKZvW4trAHpBPQnbZ6CtyRZlVzy44LclgQEKtk1GCaM3eXhQaBnjdNVDZItt3iBJdRzQ
         IF2QFrNzInIkSA32YUV80uwVaEjPQreZEo8dExU6KoKr/cx1jTz34V0FJ/gzqKt8f1Ym
         hqrDyEMdReQkg1yVKMUERUX5HalNrq8PchNcnba4fFLqs40pUumN3reet4DFkUhhX2Qr
         mUiSB2zIDytcenJ3qphrMkiSz9dP2Wy5C2O7OI525rszn6qsB4cqqaxdTnAX3oYKnRN5
         oKDg==
X-Gm-Message-State: AOAM533NDI9EigFpQHrShsHzHrehA+Rsah0E0+MFnaVd/n6b3wz5Qatk
        SrusfSJTxYnzJ80fMiTzGslxuKsG67hufrJ1LN8yfg==
X-Google-Smtp-Source: ABdhPJyhIu51fF1v8j4WHe7KZoGUQ+bTlaj2cYc7LVrH9vXLcLmlmmjSgAmDDa08jaWlaEbvPxkacC+s+dNbo9o8Qt4=
X-Received: by 2002:a17:902:8d97:: with SMTP id v23mr12174plo.297.1591732746497;
 Tue, 09 Jun 2020 12:59:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200607215715.90981-1-rikard.falkeborn@gmail.com>
In-Reply-To: <20200607215715.90981-1-rikard.falkeborn@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 9 Jun 2020 12:58:55 -0700
Message-ID: <CAFd5g44csNR6=-YcVNOPa-vshEC+=nd+OY95BMveRsifCXf+Vw@mail.gmail.com>
Subject: Re: [PATCH] kunit: kunit_config: Fix parsing of CONFIG options with space
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jun 7, 2020 at 2:57 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> Commit 8b59cd81dc5e ("kbuild: ensure full rebuild when the compiler is
> updated") introduced a new CONFIG option CONFIG_CC_VERSION_TEXT. On my
> system, this is set to "gcc (GCC) 10.1.0" which breaks KUnit config
> parsing which did not like the spaces in the string.
>
> Fix this by updating the regex to allow strings containing spaces.
>
> Fixes: 8b59cd81dc5e ("kbuild: ensure full rebuild when the compiler is updated")
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for the patch! I had been meaning to send out a fix for this
for a while, but never got around to it. :-)
