Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A4E597524
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 19:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbiHQReu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 13:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbiHQRer (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 13:34:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED419F0E5;
        Wed, 17 Aug 2022 10:34:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gp7so13087473pjb.4;
        Wed, 17 Aug 2022 10:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=284A91xJpS6nwRvx67VF7YSoP83e6JuEnTUJYB3raPg=;
        b=bYb4QUNP3jcTW6w5gDojVQgeXieFUswJifAM9vhjd5FVyK6aT/pZ1TVAJ5dVh0bdGC
         aXbTIhrFz+1A2lDCIfmBaGWPy8SxJvhCvjNoezyYG4Mxudr+RR03FBD6SfcLo2zT+jxd
         bOzysazjUG8D7hoyV8Wfb3h+0ZUi+pi/+pb3NqUns1qH2tYAbaoUi/xMg2KnOaV6HIwl
         wF7ggN2pke5cdFaWc1/ty05TbtcDMG4kSYFLdAWr9uCNaZNKf3y65ww6hZPkZvMVi5Rx
         2cuBoB1OrziAclyREuyqHWWBhEsrhutWB0p7R6xLN54BMQf6fnHp5yV3xuzvmyCEhqwh
         0GRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=284A91xJpS6nwRvx67VF7YSoP83e6JuEnTUJYB3raPg=;
        b=30oH6tvq8eCxVXJirTuaQYp7WLN0zMOtRadKL5F2ztr8Ye9fZjoxKQrfkxdFuvej+Y
         FMlE5U0Zl5OX2/R6oOrghZItLLIhtBJ53D8jfUwPKONo/r5G4MIX4L0GOHa+s+RkK+Jk
         zUBY3huinCGJjAO5KrwOAzQl+XTz8nJ6zXBlDANMk6I+nkaOnXNIGHV5LZ4FNn9t/mvg
         HG1TzTB/BV1unCqwqDoSJfM5S3VPgNiUWuyQdYRUrsHrTqAGLAAQRQKmQEAjxkKGC4hA
         SFjw7fst5O3Bt5GNXEv6a6F2V/BBuoyVoetGXhDNm6QeC/iyZX5yDL+x4sh609HcYnDZ
         oi3A==
X-Gm-Message-State: ACgBeo3xqpqLXsK2QOVMeiuMMV1KKI3KramEiO3A838AsNVWKo3R7pDL
        oEZ4DedyvtYksNXM5Iz3rMohYxSQGZo=
X-Google-Smtp-Source: AA6agR77E6Bi90PS6CwHLsHj14t+4aZgUalGnRDUpaOb2EZ4IhtQuUC4Pu11YPiVtnY2Q5XTCJifMg==
X-Received: by 2002:a17:90a:5517:b0:1f8:a7ce:ac33 with SMTP id b23-20020a17090a551700b001f8a7ceac33mr4870074pji.83.1660757686216;
        Wed, 17 Aug 2022 10:34:46 -0700 (PDT)
Received: from biggie ([103.230.148.189])
        by smtp.gmail.com with ESMTPSA id i190-20020a6254c7000000b0052d4f2e2f6asm10696208pfb.119.2022.08.17.10.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 10:34:45 -0700 (PDT)
Date:   Wed, 17 Aug 2022 23:04:39 +0530
From:   Gautam Menghani <gautammenghani201@gmail.com>
To:     chenxiang66@hisilicon.com, shuah@kernel.org, liaoyu15@huawei.com
Cc:     song.bao.hua@hisilicon.com, tiantao6@hisilicon.com,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/dma: Add a .gitignore file containing name of
 executable
Message-ID: <Yv0mr+vGANGYcxio@biggie>
References: <20220724145931.32556-1-gautammenghani201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724145931.32556-1-gautammenghani201@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jul 24, 2022 at 08:29:31PM +0530, Gautam Menghani wrote:
> The dma tests in kselftests are missing a .gitignore file, which leads
> to the dma_map_benchmark executable file showing up in "git status".
> This patch adds a .gitignore file containing the executable name.
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
>  tools/testing/selftests/dma/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/testing/selftests/dma/.gitignore
> 
> diff --git a/tools/testing/selftests/dma/.gitignore b/tools/testing/selftests/dma/.gitignore
> new file mode 100644
> index 000000000000..668e2f8be2f7
> --- /dev/null
> +++ b/tools/testing/selftests/dma/.gitignore
> @@ -0,0 +1 @@
> +dma_map_benchmark
> -- 
> 2.34.1
> 
Hi,

Please review the above patch and let me know if any changes are required.

Thanks,
Gautam
