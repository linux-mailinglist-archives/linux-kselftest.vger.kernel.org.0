Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990F0647454
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Dec 2022 17:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiLHQak (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Dec 2022 11:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiLHQab (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Dec 2022 11:30:31 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAE270B98
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Dec 2022 08:30:30 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id g10so1976331plo.11
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Dec 2022 08:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k4tmfXAitcgkSlUsd80rpXrMdUZPjLhK1NcCQ+49+g8=;
        b=IfAhwPlyRtM85i8rguQOmP7CnTCezl5zNw1zvLw2K9t/3snzqJ13XzN33EuGXVmdL7
         kuGJCxBQ0DAIKjAwY35ZND7i0UIklkDsfJ1LCwZaoQB3sJw5qQRG9YGF/gn42W4DMLem
         DkKozVqyjHBsuR1CAhF3Xu981CEhsvXZWHGPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4tmfXAitcgkSlUsd80rpXrMdUZPjLhK1NcCQ+49+g8=;
        b=xngKxz5/ovtPPXc5jZwDrlNZqpmYUy2/LWlM0olboODRssYgv62Y9JUoqi0nxke2Ek
         R7gLJ8c66FIJAn0hNSFRcvADcBwFdkc71+0p+HKZTvG2ras0sxP3xADzno5fouCL5092
         k5ThDQzl4i4KBhB7PkOfIhkYaAGDb7nxgJfEMf5qBKt3pGh/xFM+aB53zbc9dTeaxQf2
         OO9jkVec+FsLcO8xSAlqkPkBiQWLIRg72s479oEJggRJAIaiLFFv5NMnnupzZoAhPyb7
         ZX9w/Jdv/uaRsAbMKqarf7SgUc9qoWMI8glXKrYOA7i1V9cpkcTMTRtKTu99RrB4UtR9
         DoBw==
X-Gm-Message-State: ANoB5plaNiu+1qbQjkqdb430MvtPgtg55u3L5L+/x9HtjhKA4lYRekZm
        fFtnpEBWcu7Wk2u81ShZlZqCHg==
X-Google-Smtp-Source: AA0mqf57k6PyE3EokGT1H+zjRGQDn0VQYsc/0IIGVvGFWMnZS6uaAnbVF+b/XI2sHwbsUpcdDciiPQ==
X-Received: by 2002:a17:902:a505:b0:189:e149:a1a6 with SMTP id s5-20020a170902a50500b00189e149a1a6mr14708502plq.58.1670517029595;
        Thu, 08 Dec 2022 08:30:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902680f00b00186cd4a8aedsm16697608plk.252.2022.12.08.08.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:30:29 -0800 (PST)
Date:   Thu, 8 Dec 2022 08:30:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 5/6] selftests/memfd: add tests for MFD_NOEXEC_SEAL
 MFD_EXEC
Message-ID: <202212080830.EB9070F758@keescook>
References: <20221207154939.2532830-1-jeffxu@google.com>
 <20221207154939.2532830-6-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207154939.2532830-6-jeffxu@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 07, 2022 at 03:49:38PM +0000, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> Tests to verify MFD_NOEXEC, MFD_EXEC and vm.memfd_noexec sysctl.
> 
> Co-developed-by: Daniel Verkamp <dverkamp@chromium.org>
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
