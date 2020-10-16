Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE34128FD88
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Oct 2020 07:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgJPFCd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Oct 2020 01:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgJPFCd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Oct 2020 01:02:33 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194F2C061755
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 22:02:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so1200938wrv.7
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 22:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Yg0zO3FoxdCiBdS6sRMMUbHRX5WgeqbMnpmtbAHEtQ=;
        b=GEeBGO4f+taAcEMQQ85DrncdlK2dJYmUGukW3HAHhZBdrOkDjxt5tNi1JOXg1XnGWR
         4p76T9a4fvq1bG1EgUkAVB6bhb7D7tGU+znT+jwNXlwtHY7Z0Ohf9+qM56++eyetvfDu
         grwxqYQIRvJb/JIn9gloYT4WRi/NaT8ccRQeAx2E88V3swm5f5xr8F5w/Ag4oT8WgCw8
         NSvwE24g/XTD8sPFbcD0d4KvtofX3R3/n9lRp5BCJw+fcS2f5HBycmb5jR+Gfc+LkWI+
         XaGqoAdFqeSr7pgVBjwSY56seUa/tRmkvFlRA8pXkBttqnZQ2je0R8uZnlvRNn58XNE/
         WEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Yg0zO3FoxdCiBdS6sRMMUbHRX5WgeqbMnpmtbAHEtQ=;
        b=Oqg62/3a6rzI3wopFTnZrUemOiVFghInS49dvF1GKZOhTOYM9Cwb61330GbSeGbZzp
         GIW4E40F44NYusk6zc8EFCEbhnddaNCMYrUdpIro+ileSFfq0k81dWbV6kxeaoFpL8C9
         gzMqnhmdqpwF08LCuIbxtg63vVU36q8P/g7YozM/ldd6A6bTgKvZECGpIJtjxJP7InSZ
         VDOi7FKrO+QRgO3Pc1AGZ7IfHqZQZR8m4Hnc01otH36fNhBrLV49J17FOHgMt9XImjKx
         UdEWFfDiXHIo6thLbx7ztzMKkoVvitCXyBhjcoWxF/B6PHm3nwZ+oL/wpfI+qbvMxXCG
         iD5w==
X-Gm-Message-State: AOAM531KNq10yurAnHNtdGjJZ3lvJdZv1/64Ls/uayKLcFWDTjSxBWgk
        sCVsRav+Jz5IOZThJgc7AL/KaQIo5UrUqSOXo7TvOZ1Gmv4m5+XP
X-Google-Smtp-Source: ABdhPJzPjULLgz9fVF55L6zu/UOw6zghst6/dARkEUWSlP5XW+bhkvBDtcSB4ovV1xVcS1S1m6m5vy8UffbETM9v+Vw=
X-Received: by 2002:adf:fb0d:: with SMTP id c13mr1666040wrr.19.1602824551669;
 Thu, 15 Oct 2020 22:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201015184416.38999-1-andriy.shevchenko@linux.intel.com> <20201015184416.38999-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201015184416.38999-2-andriy.shevchenko@linux.intel.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 16 Oct 2020 13:02:20 +0800
Message-ID: <CABVgOSkA2mTpH7nXnL21zrAyi38xW_K=YnD85995u0+MLoDt5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] lib/linear_ranges_kunit: Follow new file name
 convention for KUnit tests
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
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
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks. This looks good to me from an "I tested it and it worked" and
a "matches the naming guidelines" point of view.

(Since the naming documentation isn't actually in Linus' branch yet,
I'll drop a link to it here:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/tree/Documentation/dev-tools/kunit/style.rst?h=kunit
)

I'm not the test author though, and the naming doc does explicitly
leave the possibility of keeping the old filenames for tests if
there's a particularly good reason to (e.g., a lot depending on the
module name). I'm not aware of any such thing, and so am in favour of
the rename, but will defer to the test authors on that point if they
object.

Either way,
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
