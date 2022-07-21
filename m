Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A1457C1D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 03:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiGUBJP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Jul 2022 21:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiGUBJM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Jul 2022 21:09:12 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B5E753B0;
        Wed, 20 Jul 2022 18:09:11 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id l124so338201pfl.8;
        Wed, 20 Jul 2022 18:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZYFWzKGzAB8/eYekT+g2mD9inXTQAbnlNbmq03r374=;
        b=eIkgq02SGpHqjd/pBkcMCeE3520yFITeIMJc/90z8VXljXIo4qfiYkmZ+fMPtYsC6f
         yV2VPXYh5GaxAlqdp0yq8g3dQvUZJQE8J16G3rV9i5ifGkWifL0M9CrluZqgghrxg6v7
         XVWbeATRteCsEsl8bPPfUn0OTyXZu5AHGGkDl12f8/dxDggTJwohmNpDyfL6dHidg6yp
         3PsNs1nb682zBeKHFR89ET4lwto5Qmk6SDa442wFTmcNq2kWCZF57ewHCIFyXygCWbkH
         fRHbu1z/R2/rSEfcLGBiXB2jRxG9cQpmUTn8Oiz+zPRAowIky0DRmUgLw4oIPCsaYRyc
         E2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZYFWzKGzAB8/eYekT+g2mD9inXTQAbnlNbmq03r374=;
        b=VhSMp+4BQxLMJqd7N51md085uvu3dzkyJI0fqPN7S04LxZTXis4jlAlY8Ae6jze+Vk
         tHAFyjn4FvQKyBi+4ZuctVXsUI1te7G4Za8MCXx4s2ZqJ8em59oVkROHaGy7yydA30Za
         JoGm6qahbyY81FBfsQAMrS/cRZtD4mDSTmQyewnH90dGcEOsxCpCUpOj21wwix7pcua/
         6VKRUwMN/ph28l4rCZH4L6gxa78n85sci5/ruDXGDpCwsuVoDMcCTTqYzdI/qCuFh6ue
         XYREjaP3e0WUOfz+k2E/od/r1faBSaHneObcnRvvftsbK1KkgNMcV2ekv5J05exQaHtA
         mdFQ==
X-Gm-Message-State: AJIora/tcSSN/M1iXBr3o9UjkCA+WFr1c301476SYoXJS+z3XjB7s3vP
        zbDUIGvEUEqXpF7n7vkbXdoJtDbRKSRWInoFtUM=
X-Google-Smtp-Source: AGRyM1vW48JwMh27yBs++6AUqzAGU9wpphasnTi/izAwOFDJ7JJHNjqPXx5rqT4NmpWrlMi0Y1qjad7oMKi97a8v+iM=
X-Received: by 2002:a63:481a:0:b0:411:7951:cbcd with SMTP id
 v26-20020a63481a000000b004117951cbcdmr35813300pga.66.1658365750467; Wed, 20
 Jul 2022 18:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <YtZ8mKJmktA2GaHB@kili>
In-Reply-To: <YtZ8mKJmktA2GaHB@kili>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 21 Jul 2022 06:38:59 +0530
Message-ID: <CAFqt6zY4+=LASCQRCEg_cjEeSw+gJtYMLJtJ1pWL6XPaPB0FOQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/vm: silence uninitialized variable warning
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 19, 2022 at 3:13 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> This code just reads from memory without caring about the data itself.

The caller has put an attempt to at least validate the address read
from mmap() before
passing it to read_fault_pages() which looks correct. I think this
line is not needed.

> However static checkers complain that "tmp" is never properly
> initialized.  Initialize it to zero and change the name to "dummy" to
> show that we don't care about the value stored in it.
>
> Fixes: c4b6cb884011 ("selftests/vm: add hugetlb madvise MADV_DONTNEED MADV_REMOVE test")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>

> ---
>  tools/testing/selftests/vm/hugetlb-madvise.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/vm/hugetlb-madvise.c b/tools/testing/selftests/vm/hugetlb-madvise.c
> index 6c6af40f5747..3c9943131881 100644
> --- a/tools/testing/selftests/vm/hugetlb-madvise.c
> +++ b/tools/testing/selftests/vm/hugetlb-madvise.c
> @@ -89,10 +89,11 @@ void write_fault_pages(void *addr, unsigned long nr_pages)
>
>  void read_fault_pages(void *addr, unsigned long nr_pages)
>  {
> -       unsigned long i, tmp;
> +       unsigned long dummy = 0;
> +       unsigned long i;
>
>         for (i = 0; i < nr_pages; i++)
> -               tmp += *((unsigned long *)(addr + (i * huge_page_size)));
> +               dummy += *((unsigned long *)(addr + (i * huge_page_size)));
>  }
>
>  int main(int argc, char **argv)
> --
> 2.35.1
>
>
