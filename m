Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE1C29D769
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Oct 2020 23:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbgJ1WYE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Oct 2020 18:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732853AbgJ1WYD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Oct 2020 18:24:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85749C0613CF
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 15:24:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n15so740631wrq.2
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Oct 2020 15:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OhXbzz0jUd2ouNJ1702kQcn1I79hMZdbasdGII6+h5c=;
        b=J+qnhlZSZCGqciGOVRu8UXOc5yQJ29bhxTt7RSiOhmCifYU1PKHZCXpB1FBcxdFz2p
         Ed/r1YxqFraYaFSJPi3eywD5yqxq7FuGKtUlqSTCA+MKYJ3A+b6nAO8HLl/Hqxkva6Lk
         7X5yX828znMMHRwhaB3fE6jRLs9TEq5MbG/sffZB6P/26cRNV0quiAVCXwEbfcFih/e2
         mBGv3fOev51hKNDHSzUFxt9ObKpbs/m5i2k3sHPBOu0ln5M8yliSXSO+MCIaJmeMCCDA
         jVxPqGGFsnzYWn6lHzGdBk37o7xQMdIvkTFjn1IiNm9b68bIaRfFzt68NGkQaV5S/qoO
         Fx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OhXbzz0jUd2ouNJ1702kQcn1I79hMZdbasdGII6+h5c=;
        b=hAoxkWcQNLw3ZnPvd41Wce5J0RsKiPCRyJfVT0yXxUv9vRhc64xxMT/2XoTIBmIe01
         8dsiXfN/7vbyg6iaLqQ0T367uQkiyFaffL9bCxijShK/qvgiHMvMSaGhGWCK5uCluMnM
         V7oPj7u3n/7vAEAsW0L0a9FxMlNnVjwh1pirJX0479fy94Wjfi4lJS40WNZ8aChtt7RZ
         5Zf1D/vMvYh99DI306sKj8BTXorpEI2+jeNAeHtJ2G77eFPLK6QNPArOR/oT1zhJRfVW
         cF13cPk6KvsuIxe79pm126hP+w3WDVTIXyXuKSkwKFRI+JZXekIjberCA0moJlDR5dZO
         zZ0Q==
X-Gm-Message-State: AOAM530dT/x0gKX96XDvYJCeenNL94MUrV6s+gQ/MPJMPE1ZdadfhN/W
        ebhvYGHNvcHK9LbRgI2GFV9sH45wKFuRF01OYEbiayLNJpMcHw==
X-Google-Smtp-Source: ABdhPJy9hdrKih3/vRFFidKj98rZEPTvPBdg5+TSPoXdegSBjJdPRD5dmnhatqK8xsL/a8GhM8JT6nGOQbpt7j58Yok=
X-Received: by 2002:ac2:561a:: with SMTP id v26mr1920118lfd.167.1603854058688;
 Tue, 27 Oct 2020 20:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201027184909.20881-1-rdunlap@infradead.org>
In-Reply-To: <20201027184909.20881-1-rdunlap@infradead.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 28 Oct 2020 11:00:47 +0800
Message-ID: <CABVgOSmtTK=V8EFL8KTmN+e+pP6HKZQo+LMsmqG3PnxuhFtZ9A@mail.gmail.com>
Subject: Re: [PATCH] KUnit: Docs: style: fix some Kconfig example issues
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 28, 2020 at 2:49 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix the Kconfig example to be closer to Kconfig coding style.
> (Except that it still uses spaces instead of tabs for indentation;
> I guess that Sphinx wants it that way.)
>
> Also add punctuation and a trailing slash ('/') to a sub-directory
> name -- this is how the text mostly appears in other Kconfig files.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Gow <davidgow@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> ---

Thanks for fixing this!

For what it's worth, I _think_ we could get away with tabs for
indentation in the file without Sphinx actually complaining, but it
does annoy some of the editors, and as far as I can tell, Sphinx
converts them back to spaces in its output. I'm far from an expert,
though...

Regardless, this is:

Reviewed-by: David Gow <davidgow@google.com>

-- David
