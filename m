Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222684B147B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 18:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245292AbiBJRpM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 12:45:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238198AbiBJRpL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 12:45:11 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05E0192
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 09:45:12 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p6so2259185plf.10
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 09:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ygetL9EZuCFQPoKNeMK6/nbOJG24PUgQLTvCwbueOl0=;
        b=UjcPVqfYZN4M92rji0NMceX4ufLa9PXsp9CTK0g2BQ4YjM6OSLBcEej9kHKWNVlhpY
         vOOR18aiYY7qiBmAp4oe7dMQ20XSTrCKYsk6hgz7BoVfkCoSV+ceHTFBmkg6HmnedLbL
         YZ9ZIj9X0xpUiA7iDrTOrY9VKOPCdyIeJl6wU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ygetL9EZuCFQPoKNeMK6/nbOJG24PUgQLTvCwbueOl0=;
        b=i9FWExynnAD0080n677fXPcgJe06A22dVcir3O+nSoz3cD/mduh+aOmXD5RZY/mc2x
         aki2MxOrb6eWMGoDUeYQpMDRwdq5CKW4iPf/A+2ukLj1ukio72dPcf8jfrEXF4jZYe/R
         VAq8XRUyc1mWoHuP25zzo+egJWLEvqatLqYuDiO/k2K4UJLUyRr+/KT8dvfjEaVjnqTF
         SNGzbEvksNn+HQ69eRhuDTirJZl3RtDseOGRm9wbte+uYGa6YzzQLG5iLYDgsisc8QnU
         yFGQHDoTTuSlSa6ck0mDvG7WDdUtZn7uZIJQw0yoQom0PUDZqYslPI0BArZeYYbXolxs
         dAaQ==
X-Gm-Message-State: AOAM532SEZk3M1zQfaG0fZtEIG2edcD4Rtp+qtwF9rsamV+VnZSK8YwI
        x90llws0/RbGJ013bqvoiDxvbw==
X-Google-Smtp-Source: ABdhPJzyg+5zMDVS023vY42euVCMQaqOCR6JZEFLnxAkiaXx/BFi5MdU/ZKqJjSVTEaoFdoUFwNiFA==
X-Received: by 2002:a17:903:240b:: with SMTP id e11mr8402425plo.117.1644515112371;
        Thu, 10 Feb 2022 09:45:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e28sm17430897pgm.23.2022.02.10.09.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 09:45:12 -0800 (PST)
Date:   Thu, 10 Feb 2022 09:45:11 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, kernelci@groups.io,
        "kernelci.org bot" <bot@kernelci.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/exec: Add non-regular to TEST_GEN_PROGS
Message-ID: <202202100945.1A6C624A@keescook>
References: <20220210171323.1304501-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210171323.1304501-1-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 10, 2022 at 10:13:23PM +0500, Muhammad Usama Anjum wrote:
> non-regular file needs to be compiled and then copied to the output
> directory. Remove it from TEST_PROGS and add it to TEST_GEN_PROGS. This
> removes error thrown by rsync when non-regular object isn't found:
> 
> rsync: [sender] link_stat "/linux/tools/testing/selftests/exec/non-regular" failed: No such file or directory (2)
> rsync error: some files/attrs were not transferred (see previous errors) (code 23) at main.c(1333) [sender=3.2.3]
> 
> Fixes: 0f71241a8e32 ("selftests/exec: add file type errno tests")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Eek, thanks for fixing this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
