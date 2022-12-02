Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390D6640C08
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 18:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiLBRWR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 12:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiLBRWL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 12:22:11 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79D7E7864
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 09:22:03 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r18so4879604pgr.12
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Dec 2022 09:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nAc9Ui5FDUiek1r3Ck1fS7WTbV+aLgSqwss523muYTk=;
        b=Hesf4Q5brm36uJX3MEKcbGHrBL3g6VJA4t6P1O4r21kyQ+SXDRhZoqBvQAszLuC4az
         1AyHP6c6OrwskWd44Vpqp8dBDzowKxdJHuoV4a6EviwOXax84doqhj+TH6WQjMSNjDfJ
         4E0wk3E2LEXYUvYjnhKN9yHVCPd9TT3Bv6OkbES3PPIHEPhHD2GAR2Ituic7qtcNCPBv
         wAMaRX33IGTJSxTTc9sDJv/frwj7Y91TR1GyRMjhbFONoRofpSJDgnn/hIcmXntNOrx0
         w/N1FJlZ5tm9vbPmXYVg/u8o6iNfmatY+lN0LgpprUnqJpuQJkhUOtXICTGDU9dL1R7M
         Mc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAc9Ui5FDUiek1r3Ck1fS7WTbV+aLgSqwss523muYTk=;
        b=Xmd0DPg6wedKU3j74TXIbEyxNyckKDFeLxzvgn3oSkEVU2IkeQ2zDjmOK0AXt6kbfm
         IttCMp7KwdCC4ow/ol1/wvLQh/pHrYIp5MSXKZhBTXZILUr7NnXKsLfIB24cNW8P6aa0
         sIAi+Dfw4sIYcVlwAK5MyRuOckNORufVIBWL8SjQppWDfCmk9xDXfSUN9kpsukZxkGSU
         r9t7kzcrcd4VacMomHssu7gAB04MW8yCFxj5qLQC+PUFcDbdAs0L+VmSZyLtXk0+z5+i
         v7EUtBNlObhJsKYEKnNJnrPugLOAbf/2f6nlfpOLn73QeqK9hGUpZGASc8UwhEajCXOM
         szJw==
X-Gm-Message-State: ANoB5pk80GYG+HuPmPU7aEN9+N2gy7ApGyR9A5RSvWmlYfzj5EKXgQ0y
        lLWs28CuYfp3IOmVqQ2x4EgJFA==
X-Google-Smtp-Source: AA0mqf5m4zXkdiVg7X1oUF/in3uAi1adGUciP0lbBTNgQCH9BYJcAzGmMa6mLTtbviUw1JXWglFLJA==
X-Received: by 2002:a05:6a00:414e:b0:575:7968:f546 with SMTP id bv14-20020a056a00414e00b005757968f546mr18387843pfb.30.1670001723093;
        Fri, 02 Dec 2022 09:22:03 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l4-20020a17090a384400b00212c27abcaesm6898955pjf.17.2022.12.02.09.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:22:02 -0800 (PST)
Date:   Fri, 2 Dec 2022 17:21:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] KVM: selftests: Fix spelling mistake
 "probabalistic" -> "probabilistic"
Message-ID: <Y4o0Nq4SKGZgDOxi@google.com>
References: <20221201091354.1613652-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201091354.1613652-1-colin.i.king@gmail.com>
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

On Thu, Dec 01, 2022, Colin Ian King wrote:
> There is a spelling mistake in some help text. Fix it.

I assume you have a script/tool of some form to do spell checking?  If so, can
you point me at it?  I'd love to incorporate something like that into my workflow.

Thanks!

> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
