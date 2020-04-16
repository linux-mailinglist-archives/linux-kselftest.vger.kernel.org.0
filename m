Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B851AB4C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Apr 2020 02:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391723AbgDPA3P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 20:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729382AbgDPA3M (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 20:29:12 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0364C061A0C
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Apr 2020 17:29:12 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 8so4960199oiy.6
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Apr 2020 17:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GeXd8f9J30PgVFJ7Z+WgbUhdu7rs2z9sqFP5jQ5Rms4=;
        b=fkzxHgIOqEjwuIosHr9XmQjcVbxGyuyyncMmIKtBRy2n1ATDf9hSL8qMF8+8CCdDyA
         wououMrcJsN/rDXNRAzh59RbkXQpLrJ0BNFC4X1fEwtKE8izrLemCYJZsVeRrPfxJITu
         wkI5ti8qldm3gUdm95Zq5S+B6IleEGfxZ31au8kCUg+w39Fq8riSYOHkd1CyGMzPjQXL
         9l9Z8YgX35Q1cIQgH0i9nYi0TXXTbgLFEsAd4/mId92Z6HWufi2SVoucENSPZOK5Z30q
         HiErD0IrYQ8+hAlaLCpqdV/U/1SEpWoRWOsgu4IzMphWBg7nJRo5hw6Td0LQDZ3PdnUh
         5dNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GeXd8f9J30PgVFJ7Z+WgbUhdu7rs2z9sqFP5jQ5Rms4=;
        b=bWgT6zzhf1ACoiRjohnmFE7vqbjxtHdp3R/zVnvqP8GE6LKsF42osg8icakwe6o7Dh
         bsz9aw6oDb69hg+bjPGgq3yUZtVAbTcqO4BzGRM1S7HKVVctEP/9R+EMiyJLnQgeSP1Z
         E089xvu3oI36tSkVq87GNNlCQVWjLF18xdLG9aVfZNBnF4hMVp56PdZc5HnA2iim0lK9
         G9sL+wi6isRHeFJBp0Q5MsysX8rDq2uCZcEuieJS1/ec7mPfHLNfBndhAhYINE+C+f5N
         nrjevfJoaGujkh4gx8dX4RaV1PhzGCpReYkSWWApMBYP7yPawV+UxA1BxTBE1wVkksSQ
         VBHw==
X-Gm-Message-State: AGi0PualjcIyAnf/wiI1cqpTA5wqvmaaacGJfWwtvbkDpeFQyjCHpB0B
        rpqKLAt+CzFW5D/HGoCkmfNmKX/soaEclP1H+/EeTtJn
X-Google-Smtp-Source: APiQypKqxX1Fl3V2SnfLeZZgj6SmNm3X1EEdrsgQfCYgSGa09GLLNNURx+AKzwqwjs7SlbDusY22alHpQpyRzJdkTLk=
X-Received: by 2002:aca:5d83:: with SMTP id r125mr1414954oib.8.1586996951792;
 Wed, 15 Apr 2020 17:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200416002616.1456-1-rcampbell@nvidia.com>
In-Reply-To: <20200416002616.1456-1-rcampbell@nvidia.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 15 Apr 2020 17:29:00 -0700
Message-ID: <CAHS8izNenS4ZW3fxFtJ-jzZ9QwP192N3KPB7n6qQrVcoP8PNgg@mail.gmail.com>
Subject: Re: [PATCH] hugetlb_cgroup: remove unused variable 'i'
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-kselftest@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 15, 2020 at 5:26 PM Ralph Campbell <rcampbell@nvidia.com> wrote=
:
>
> Compiling tests in tools/testing/selftests/vm/ results in a C compiler
> warning:
>
> write_to_hugetlbfs.c: In function =E2=80=98main=E2=80=99:
> write_to_hugetlbfs.c:77:16: warning: unused variable =E2=80=98i=E2=80=99
>    77 |  unsigned long i;
>
> Delete the unused variable.
>
> Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation test=
s")
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Whoops, sorry about that.

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  tools/testing/selftests/vm/write_to_hugetlbfs.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/write_to_hugetlbfs.c b/tools/test=
ing/selftests/vm/write_to_hugetlbfs.c
> index 110bc4e4015d..6a2caba19ee1 100644
> --- a/tools/testing/selftests/vm/write_to_hugetlbfs.c
> +++ b/tools/testing/selftests/vm/write_to_hugetlbfs.c
> @@ -74,8 +74,6 @@ int main(int argc, char **argv)
>         int write =3D 0;
>         int reserve =3D 1;
>
> -       unsigned long i;
> -
>         if (signal(SIGINT, sig_handler) =3D=3D SIG_ERR)
>                 err(1, "\ncan't catch SIGINT\n");
>
> --
> 2.25.2
>
