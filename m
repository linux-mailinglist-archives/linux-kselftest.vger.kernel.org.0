Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20C050C3DB
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Apr 2022 01:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiDVWrZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Apr 2022 18:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbiDVWrP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Apr 2022 18:47:15 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6169239210E
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Apr 2022 15:07:44 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h83so9997009iof.8
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Apr 2022 15:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNHylfXe0yuI3nWPKEVPbWc3jAVoQ9y+hq0D/Seu+wY=;
        b=lZeOnkWJfpNbpL47S03ry8Z3kSVOMOveo/jk2nJZUCVzPXBnjFkIA5qcm5wo/j9wal
         dToQD7czP+VDPM078c7el16Q1aZe6nbNwzGDLS1XDXYwpVkpsNJqwJypOn7+to3xdWR8
         3oKX/drZ7bmJalyV/wnad3jVhzCaQtJWOxf3Bm0ia6JFeq+CqiBT5j8Fw1M2JQ+4ETxm
         QXwZMqup8qvcM15nXfDB1he5rvr4FY7BMBGzR2W4HvnyM4XtqFs6HzlCI7+q84UnMcKm
         6XhvjRcKaCUidgoN7Z7ZOSeAKGYbwmIvKM8UEM2menTjD9cXKxT3sYopxGDu0HM62RIb
         sEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNHylfXe0yuI3nWPKEVPbWc3jAVoQ9y+hq0D/Seu+wY=;
        b=1rq0hJqbaR/E8eoAEt2lPSE5bSYPfFSmAt3IKIkVlyKDSgWnqJaKyYhQ3S+dPMx6/8
         Z5Ic9K8d5MXU/WbYGoozfVcl++OicwiOmQHtEzrg9U6bKwKTf+IHcs4Wvra+yN3wzSui
         FjgL1N6wy9OGflBbXDrWmsE76zR4aaZZucJxsTodoNftk4CAtsYcgnHdamfsUUczuDAi
         gIrzDJ2+yPj89It0ZmeYuQ7xRSfG9MdABtreI9d4dcWiPLoNluD0sWCxBlTN5pW3EtjP
         1VeonOJ1B1IXgFbZeL+I2Lk3d9m4wR83QQbYUmLbxU2SQ8g8Bz2bPKG3PqnriKNzbZRD
         lxIA==
X-Gm-Message-State: AOAM530U+s3fG3uhEIXTYWEH6uVlBdh0Kqgfq9cdsdw6eBAUY4JhI53E
        L921xUAYgYbnmpgFqyoNg3UW6H1tVGiP37LzrLOHh1akmp4=
X-Google-Smtp-Source: ABdhPJwo+ze5pPYHakIgsi/peB9ZO2hJVC0Rs6hOgkZCZ+dBJmbZPicpRp+7K8Orccv9dtaFx0imB8ejZX4fb+fg/c8=
X-Received: by 2002:a05:6638:12cb:b0:323:da89:2caa with SMTP id
 v11-20020a05663812cb00b00323da892caamr2971436jas.314.1650665246174; Fri, 22
 Apr 2022 15:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220421224928.1848230-1-axelrasmussen@google.com> <20220422145456.1e9f22220b1ad502aa56628d@linux-foundation.org>
In-Reply-To: <20220422145456.1e9f22220b1ad502aa56628d@linux-foundation.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 22 Apr 2022 15:06:49 -0700
Message-ID: <CAJHvVciPBM7vRnruDZ3iuYMgwqapB2U6TBtD74s1P-40ZNRy6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests: vm: refactor run_vmtests.sh to reduce boilerplate
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since this is a revert, I guess the diff is "backwards" -- meaning,
others were proposing *adding* $ksft_skip handling to some tests?

if that's the case, then I agree none of those diffs are needed, my
change should properly handle $ksft_skip for all tests now and in the
future.

On Fri, Apr 22, 2022 at 2:55 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 21 Apr 2022 15:49:27 -0700 Axel Rasmussen <axelrasmussen@google.com> wrote:
>
> > Previously, each test printed out its own header, dealt with its own
> > return code, etc. By just putting this standard stuff in a function, we
> > can delete > 300 lines from the script.
> >
> > This also makes adding future tests easier. And, it gets rid of various
> > inconsistencies that already exist:
> >
> > - Some tests correctly deal with ksft_skip, but others don't.
> > - Some tests just print the executable name, others print arguments, and
> >   yet others print some comment in the header.
> > - Most tests print out a header with two separator lines, but not the
> >   HMM smoke test or the memfd_secret test, which only print one.
> > - We had a redundant "exit" at the end, with all the boilerplate it's an
> >   easy oversight.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  tools/testing/selftests/vm/run_vmtests.sh | 459 +++-------------------
> >  1 file changed, 64 insertions(+), 395 deletions(-)
>
> Well that's nice.
>
> There were a bunch of changes already pending in this file but I think
> with this patch, they become unneeded.  So I just reverted them all.
> please double check?
>
>
> --- a/tools/testing/selftests/vm/run_vmtests.sh~revert-1
> +++ a/tools/testing/selftests/vm/run_vmtests.sh
> @@ -162,32 +162,22 @@ echo "----------------------------------
>  echo "running: gup_test -u # get_user_pages_fast() benchmark"
>  echo "------------------------------------------------------"
>  ./gup_test -u
> -ret_val=$?
> -
> -if [ $ret_val -eq 0 ]; then
> -       echo "[PASS]"
> -elif [ $ret_val -eq $ksft_skip ]; then
> -        echo "[SKIP]"
> -        exitcode=$ksft_skip
> -else
> +if [ $? -ne 0 ]; then
>         echo "[FAIL]"
>         exitcode=1
> +else
> +       echo "[PASS]"
>  fi
>
>  echo "------------------------------------------------------"
>  echo "running: gup_test -a # pin_user_pages_fast() benchmark"
>  echo "------------------------------------------------------"
>  ./gup_test -a
> -ret_val=$?
> -
> -if [ $ret_val -eq 0 ]; then
> -       echo "[PASS]"
> -elif [ $ret_val -eq $ksft_skip ]; then
> -        echo "[SKIP]"
> -        exitcode=$ksft_skip
> -else
> +if [ $? -ne 0 ]; then
>         echo "[FAIL]"
>         exitcode=1
> +else
> +       echo "[PASS]"
>  fi
>
>  echo "------------------------------------------------------------"
> @@ -195,16 +185,11 @@ echo "# Dump pages 0, 19, and 4096, usin
>  echo "running: gup_test -ct -F 0x1 0 19 0x1000 # dump_page() test"
>  echo "------------------------------------------------------------"
>  ./gup_test -ct -F 0x1 0 19 0x1000
> -ret_val=$?
> -
> -if [ $ret_val -eq 0 ]; then
> -       echo "[PASS]"
> -elif [ $ret_val -eq $ksft_skip ]; then
> -        echo "[SKIP]"
> -        exitcode=$ksft_skip
> -else
> +if [ $? -ne 0 ]; then
>         echo "[FAIL]"
>         exitcode=1
> +else
> +       echo "[PASS]"
>  fi
>
>  echo "-------------------"
> @@ -306,16 +291,11 @@ echo "-------------------"
>  echo "running mremap_test"
>  echo "-------------------"
>  ./mremap_test
> -ret_val=$?
> -
> -if [ $ret_val -eq 0 ]; then
> -       echo "[PASS]"
> -elif [ $ret_val -eq $ksft_skip ]; then
> -        echo "[SKIP]"
> -        exitcode=$ksft_skip
> -else
> +if [ $? -ne 0 ]; then
>         echo "[FAIL]"
>         exitcode=1
> +else
> +       echo "[PASS]"
>  fi
>
>  echo "-----------------"
> _
>
