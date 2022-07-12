Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9A7572898
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jul 2022 23:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiGLV1X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jul 2022 17:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiGLV1W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jul 2022 17:27:22 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FD2CB45D
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jul 2022 14:27:22 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id u6so8999653iop.5
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jul 2022 14:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m0YyLEzw3IkHIEc6hzXGbO7iGAv4+7wdnlnG9pY25FY=;
        b=FMJNqa++kuJpdQYJXjWWJcEWpD8+YWreVG7WugTc0ennaNQ4QR7g8pXILGxJlJ45Tv
         cB4XqYlFi6xnxR63ejBJexoF9BKMSG8ivgsWYOM6F3T9eOXrFw96hdTxCtFpg7cbuCUh
         gicIFv0swNlNJPJsLTNN5Zv1Y+5d49PtpDWn+lsVJ18QnUn7vApvzDoS48Tg2ffs/qQc
         1QdwHD3kSAX8nvdErP/G3gA9yj1QcMMoijpCESLcOKunlCtGyjrVyoQEwckhS71h9RFs
         4Dl/LY0JvOXaii8UM6oYj/xSqoywoU8cnGQuqLl5j/7qYIaB6loPcnbFqanDr59ekRr+
         V0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0YyLEzw3IkHIEc6hzXGbO7iGAv4+7wdnlnG9pY25FY=;
        b=mk3tXT7TszRfXYZRRrqzCPrQrFDRD5MKpch58JK5pF6nupAxA+qV2i+JfYeoaqe3p1
         xfXICKMwA+jdokkIMf0HLpjuKzJAj76wrt9sU3v21c+pNrEzKfA2zin+X2MmWG98JAQi
         fBlzRChVYiBzhqhOhjSuE32ZHywmk40Ql7qQsHPHy1SP+wsNxta/ajg7bYF3hNpZ7m1E
         yQQx0HTGyRPhF4V44UN8Uqy/q63ZFkQZjZuZZf1Ieyy1olFe8SJs4ezhyjpPq8qkiAUG
         9hGN6bgu/VjEIuXYJsZy7AyvNXf4tLWMWr0kHUVrs9iG1m1ubx6gnTJ9102OAT+m3XWj
         SEdg==
X-Gm-Message-State: AJIora/sd9Mx8gqMBM6JT0PSJfeFVRn3vPHuFGLb6PDKhqzt9hULzodK
        l4rIbF/MZXnbDhS8IFW99hnH2H/js6thF/szud8STg==
X-Google-Smtp-Source: AGRyM1tNjr8o/bDVFpbm8D9wO5b8kklpsyfdub1zcBTGrK8QXVgsSC8mlph3W82pJqOwau91MwVRx/tD9fxDqB4UnFQ=
X-Received: by 2002:a05:6602:340b:b0:67b:8189:23c5 with SMTP id
 n11-20020a056602340b00b0067b818923c5mr130294ioz.52.1657661241327; Tue, 12 Jul
 2022 14:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220712095627.1770312-1-davidgow@google.com>
In-Reply-To: <20220712095627.1770312-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 12 Jul 2022 14:27:10 -0700
Message-ID: <CAGS_qxrBGcz4gAtqu8QSJO8SP_a0n+18OiBVQaRXBQMwbL4w+Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: executor: Fix a memory leak on failure in kunit_filter_tests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, kernel test robot <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 12, 2022 at 2:56 AM David Gow <davidgow@google.com> wrote:
>
> It's possible that memory allocation for the copy will fail, but for the
> copy of the suite to succeed. In this case, the copy could be leaked.
>
> Properly free 'copy' in the error case for the allocation of 'filtered'
> failing.
>
> Note that there may also have been a similar issue in
> kunit_filter_subsuites, before it was removed in "kunit: flatten
> kunit_suite*** to kunit_suite** in .kunit_test_suites".
>
> This was reported by clang-analyzer via the kernel test robot, here:
> https://lore.kernel.org/all/c8073b8e-7b9e-0830-4177-87c12f16349c@intel.com/
>
> Fixes: a02353f49162 ("kunit: bail out of test filtering logic quicker if OOM")
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Thanks for taking care of this.
