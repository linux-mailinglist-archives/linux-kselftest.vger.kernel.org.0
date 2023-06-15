Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE301732051
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 21:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjFOTao (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jun 2023 15:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFOTan (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jun 2023 15:30:43 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D152949;
        Thu, 15 Jun 2023 12:30:43 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7747cc8bea0so66756439f.1;
        Thu, 15 Jun 2023 12:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686857442; x=1689449442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SuvfqCGUiUMCqXPTVDeqjI2KbfZcmdWtMrUhTm7vC+4=;
        b=ZElvyo4Ba0xb/7VIHEbiKnOs+W0DLSzzwZS18uz4ydqmEdWcmbkhEuCgAKkGW6usFm
         BqlIAkdXFQxfJUTuGV+MRfbIQfLtvB9nw8Z5fZhO8g3g48Istcs9xY6Fahf1o+REuzkH
         vP7R06yse6aGBoEmM+GjsQomw6R/BwuylrFLUqJDU7LluqWEnBq//O4F44QV7/HTwf+m
         vGIjawg9iTMoP5PD08otgT9VpmlCiqFP7MWYCmBLQAj89IQDHnPTVeWip5rv+McS+mzL
         +1tNRGWpsflrBT9wQ6G9rIXmEmH+LvxVN1hSIsNR7BcKvjwFUH3WlUoI7v6+q1mmSqKk
         mzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686857442; x=1689449442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuvfqCGUiUMCqXPTVDeqjI2KbfZcmdWtMrUhTm7vC+4=;
        b=VzCG96pN8xuIM2mdovpacwutniMyO/4YhusGVwVWNwHNh25cMV+8T188mIHko8g5u2
         w4/QjNTcfn1zH1RyjmHoPKESdLrwqXgUOpQMYdjs6Hv7GNYNUrLVxC/UOa86rbwaIa47
         iudbGxt2DOt/DDpsuPoAiXYvRWiUdHl5PKqgaLJMTK7ySG1MVHGQw4mfQoCMbaTcdb+u
         nQ3b3hfKSLJ6lJojlYObeUhQ9W1wiIqiRvWPhrJ2vFdDnovZJaldPeDdC3qrGlLw9IJ1
         NGTaW4uvGcL73TAuTVRpE4oq7o0Sc1DCpMPzCz2Wo2s72pZQTTBWwR01AYUANe/hbJZ+
         skWA==
X-Gm-Message-State: AC+VfDzT9uSDLTvMCR7LLRSDpkDdOF4EhBtr/CfxHjj/CL/vhAyPKDZA
        Ib3Ku4VAR8+t77fX2dp+FLPEJXCo+X8=
X-Google-Smtp-Source: ACHHUZ7q6SbiAmgNQR95DVbQmxy3A+/ikCui8Cd/gPfu2cJHil+nCdQqsLS9kIyyRbLCCroNjJOZqA==
X-Received: by 2002:a05:6e02:1207:b0:32a:8792:7248 with SMTP id a7-20020a056e02120700b0032a87927248mr390255ilq.2.1686857442392;
        Thu, 15 Jun 2023 12:30:42 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8200:e:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id w15-20020a63474f000000b0054fdb351718sm3097733pgk.29.2023.06.15.12.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 12:30:41 -0700 (PDT)
Date:   Thu, 15 Jun 2023 12:30:40 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Alex Maftei <alex.maftei@amd.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] selftests/ptp: Fix timestamp printf format for
 PTP_SYS_OFFSET
Message-ID: <ZItm4OCrMjm56RH0@hoboy.vegasvil.org>
References: <20230615083404.57112-1-alex.maftei@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615083404.57112-1-alex.maftei@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 15, 2023 at 09:34:04AM +0100, Alex Maftei wrote:
> Previously, timestamps were printed using "%lld.%u" which is incorrect
> for nanosecond values lower than 100,000,000 as they're fractional
> digits, therefore leading zeros are meaningful.
> 
> This patch changes the format strings to "%lld.%09u" in order to add
> leading zeros to the nanosecond value.
> 
> Fixes: 568ebc5985f5 ("ptp: add the PTP_SYS_OFFSET ioctl to the testptp program")
> Fixes: 4ec54f95736f ("ptp: Fix compiler warnings in the testptp utility")
> Fixes: 6ab0e475f1f3 ("Documentation: fix misc. warnings")
> Signed-off-by: Alex Maftei <alex.maftei@amd.com>

Acked-by: Richard Cochran <richardcochran@gmail.com>
