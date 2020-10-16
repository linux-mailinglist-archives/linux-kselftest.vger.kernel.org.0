Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A780B28FD8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Oct 2020 07:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbgJPFHS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Oct 2020 01:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729462AbgJPFHS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Oct 2020 01:07:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93CFC061755
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 22:07:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n6so1170583wrm.13
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 22:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nvc2uQoe493sbi7a8PppCimyUGsff6C49TI5iNrVWYI=;
        b=lAGLCHgt+CGmP+gG0RqecRM9hKB3FLq5Mg3zBl9GTojbAEPZoU2Psi4TiWnBzZTcoy
         ztAvNZ4DhHLFlaUXTbZkY0UPmDbngUHRaPdSeuJwKwg/Ys6KNuThxQozx5F0phEGdfpy
         Gi2CIOlGKw0NEhrwMsbGfSrZco7sPdtRkAzYK66XoorjddWtoH3LIXhM9Vo5tp0H7pW7
         fLQab3qPLVZfniCvjMyg2mpYEu1was6zjwIgpdOyqrZrmdCoIb2/PRjzThrLnksizPuR
         YEi+VwR+9xFIYhB+YDA4f4v4qIxZlpadj2OvffGTy7n/nswG1I6+BYy6SbdjjMCSBpxC
         JKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nvc2uQoe493sbi7a8PppCimyUGsff6C49TI5iNrVWYI=;
        b=qq1FwlN1y8nMYeo+WCjg74C2yaMlB6miYE1md1nzxKe9yvZCdX7OipTwTIDNTXXRvR
         IDQs0JJ3Jv4jQNdbMr0LwsEvrHnOP5y+amEpqiIObooT2ax+yi+2sAAuUxWhS+mN+NoX
         8e+1W0xCrzo96TzXdc/FVNwotQv+RlgFM5me4b6U85wEvAzpifWoKCnUUbUKTwvqyS64
         SHahnyYuAjvTpfjdWzlQ23tbYJdkxiRRBdW5k/O2V2E0vOal3YGzKwqKfmslpqTjP3sE
         HjEOFwBw+hAEuM8MMvb/uG2T0fGDQn8QSAXglOdWkCJ+tKWZrDcepvx22/1oG72AAPDz
         O7QQ==
X-Gm-Message-State: AOAM533PN3EPd4HGq4UrQYY2Qdzdui4aNRY6GjX0VlaQP3O03BVusahm
        O6B1nvOCDBCc+eqe2PyB3HQUNY0IlOGBhoU7uCqnWw==
X-Google-Smtp-Source: ABdhPJwNxpqNNX4cbBNc7sJJuS9DcKLUu+4ChIfX4wnP0cj9pvBJ+fAAt+6PR+tGN6+ff544okOCJIOpAvIZjjIC8QI=
X-Received: by 2002:adf:f50c:: with SMTP id q12mr1816365wro.249.1602824836336;
 Thu, 15 Oct 2020 22:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201015184416.38999-1-andriy.shevchenko@linux.intel.com> <20201015184416.38999-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201015184416.38999-3-andriy.shevchenko@linux.intel.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 16 Oct 2020 13:07:05 +0800
Message-ID: <CABVgOSmxjoNjjn+a0i6Fwyw6hewJNH-dwximK2Fv-nYTDRhLNg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] lib/bits_kunit: Follow new file name convention
 for KUnit tests
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 16, 2020 at 2:44 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Follow new file name convention for the KUnit tests.
> Since we have lib/*test*.c in a few variations,
> use 'kunit' suffix to distinguish usual test cases
> with KUnit-based ones.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


Again, this worked and looks good to me. Apart from noting that the
module name will change (so if people are depending on that, it'll
break things), I'm all in favour of this.

For the record (since it's not quite upstream yet), the naming
documentation referenced is currently available here:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/tree/Documentation/dev-tools/kunit/style.rst?h=kunit

Anyway,
Reviewed-by: David Gow <davidgow@google.com>

Thanks,
-- David
