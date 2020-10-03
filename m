Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EFB282193
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Oct 2020 07:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgJCFXZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Oct 2020 01:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgJCFXZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Oct 2020 01:23:25 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505B8C0613D0;
        Fri,  2 Oct 2020 22:23:25 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id md26so4578170ejb.10;
        Fri, 02 Oct 2020 22:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=1SGTXRb4W2GeXcOMkx7sItuBro8o/9vcs+gJu2aYrQY=;
        b=lLlekOam2VLJeeTUJ2KuRAGO50dUm7Rz8jwPJLC5yRWmFYzkbJzCBOzMTmZRPOh2BR
         YLB0m46SIPmfOkFbh4BkyB0LXGkNiOn5cDT7ABlu+4cHoML7iy8Ep5+RhFg5gRZW00nr
         yB30hQsdreZEoZtMdyUCnRX+7k5WUtOLCAcOW5gpm4f+QXqWBk8kAO5K0bOddhDkwNVa
         xjfIb21EoPtH8eRfG3UWS2gma2iEz9+qSLrE3ZDKTu/UiPL78/Ym3bpFIIhCdf/6sweo
         /Lc3nZG+XTZTBN/wjWz4Ut97bqOMWxs8PFWAIkwOLEFQRtONc25Rv3A6Dz4I43bZKcYf
         e6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=1SGTXRb4W2GeXcOMkx7sItuBro8o/9vcs+gJu2aYrQY=;
        b=ZBYCrNHiaiT5crHqLzinRCilJG8fSKCmkcO0BcN0E3DmJtkMPhXgha+/bZs2y1Fr58
         nZyFlMY2mLI56kRaAIfjnbOaJAyrX7TdaPdQXKd+WiMseTIpwZfxN5AlFL3RHv0fdDH/
         ARdaiZC++s3sTUDRsnCCLHD3cppy3bG60OgiXsKGCf8l4+9HP2D7B+qwqExFd6fv3hhQ
         Vpu+MnwBwxFPmaYJEGvFWK6hnyXQW9KrOwow7xIT1YEU5cpZtSs4Vbed3pZGVRgGg8CM
         Oh/NbK0iwJagU0dnECQqEmfxQKL4QpDxhDvoY6PlwAja+jTNvzyJBGOW83j3NWW1PUmp
         CiCQ==
X-Gm-Message-State: AOAM532AN9iPoFWQq4Qr+O6IhXccRwvAA4plPYTuWP7MzTm7KiLOG8Av
        Dhhz0oOXBLPVbRHusmJ5hs4=
X-Google-Smtp-Source: ABdhPJxowrN3K2sPjrvpFL3w8CSuHI/73K0kbu/D5IsDEAplNIgE5/klO/jifujj9Nledm6aGPIQdg==
X-Received: by 2002:a17:906:3ad0:: with SMTP id z16mr5577080ejd.193.1601702604035;
        Fri, 02 Oct 2020 22:23:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:dc80:74e3:612d:b241])
        by smtp.gmail.com with ESMTPSA id q3sm3059309edt.1.2020.10.02.22.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 22:23:23 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH] selftests/vm: 10x speedup for hmm-tests
Date:   Sat,  3 Oct 2020 07:23:09 +0200
Message-Id: <20201003052309.30013-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201003011721.44238-1-jhubbard@nvidia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 2 Oct 2020 18:17:21 -0700 John Hubbard <jhubbard@nvidia.com> wrote:

> This patch reduces the running time for hmm-tests from about 10+
> seconds, to just under 1.0 second, for an approximately 10x speedup.
> That brings it in line with most of the other tests in selftests/vm,
> which mostly run in < 1 sec.
> 
> This is done with a one-line change that simply reduces the number of
> iterations of several tests, from 256, to 10.

Could this result in reduced test capacity?  If so, how about making the number
easily tweakable?


Thanks,
SeongJae Park

> Thanks to Ralph Campbell for suggesting changing NTIMES as a way to get the
> speedup.
> 
> Suggested-by: Ralph Campbell <rcampbell@nvidia.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> This is based on mmotm.
> 
>  tools/testing/selftests/vm/hmm-tests.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/vm/hmm-tests.c
> index 6b79723d7dc6..5d1ac691b9f4 100644
> --- a/tools/testing/selftests/vm/hmm-tests.c
> +++ b/tools/testing/selftests/vm/hmm-tests.c
> @@ -49,7 +49,7 @@ struct hmm_buffer {
>  #define TWOMEG		(1 << 21)
>  #define HMM_BUFFER_SIZE (1024 << 12)
>  #define HMM_PATH_MAX    64
> -#define NTIMES		256
> +#define NTIMES		10
>  
>  #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
>  
> -- 
> 2.28.0
