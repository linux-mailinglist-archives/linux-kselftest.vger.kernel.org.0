Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301614B1780
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 22:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbiBJVQb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 16:16:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344552AbiBJVQa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 16:16:30 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB58C26D4
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 13:16:29 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 9so9649411pfx.12
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 13:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=56GxMSeC38DM7FjFScYhpGTuLwbWHwsMqi8kcAas7E4=;
        b=FDKenY6uG8aNafmFX+Zg+YrB5T4Ep6A1O3Fde4Ag43f5AMMXe9HR0HtDP4Ih0HvH+3
         SY41Qh0xwpNOR/NKw3xSVKjSRjB+SuAm+0uZpPu/J95DLbAkevEwN9+41pCKemI61p5a
         Rp1jHJIJqVsRIOYArqyB/pwspLyKPK1IeTWXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=56GxMSeC38DM7FjFScYhpGTuLwbWHwsMqi8kcAas7E4=;
        b=llcv1wfEC1IKx/+BPB0QNGikVT0u1ItWekMe+noVeP/3ZmkfuXZIMlsmBS3vqNM1vn
         Zmjmgtgw5BULjjaMppLru9QZEmCoaGTUOMpHlr5CoD6+G1RH4/Zg/bUUOxKO8Ctu95yi
         uLKUCBEIRrDu1k4ykpynJ70VwwAvMFiZnx5yQ6ggNJCdEWzyNLdvr7tNE/XZ8Zhran/y
         kkN/hwDV2p1IRShXnl+IN+NymocxchswIVQTnrYbc7ClzHlAwKW1+9Bj8oVXKWVx8aJw
         YfAJT3PuxSJJ43abR/dvhtX/74iKWFNv7bz666wTn9LsJzfJJjNN0DiPJ0g2bb/yfZTH
         sVJg==
X-Gm-Message-State: AOAM530SBtVBgYJKEOU/HFRcaOeQsvTAc6vQrzNqNIFqrAJhM5Rav+wa
        43Wgb2+4XAnntDxvYCoHyFELlQ==
X-Google-Smtp-Source: ABdhPJyEIEonG5UDKp6DdoNJBTiX1KgMJI7EkGIooEaffcNz/EsNH1tDm2q31M5y0fyxN0XpV0Gylw==
X-Received: by 2002:a63:da0b:: with SMTP id c11mr7643183pgh.436.1644527789466;
        Thu, 10 Feb 2022 13:16:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r11sm23537151pff.81.2022.02.10.13.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 13:16:29 -0800 (PST)
Date:   Thu, 10 Feb 2022 13:16:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sherry Yang <sherry.yang@oracle.com>
Cc:     skhan@linuxfoundation.org, shuah@kernel.org, luto@amacapital.net,
        wad@chromium.org, christian@brauner.io, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2] selftests/seccomp: Fix seccomp failure by adding
 missing headers
Message-ID: <202202101316.E38FEAFBCA@keescook>
References: <20220210203049.67249-1-sherry.yang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210203049.67249-1-sherry.yang@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 10, 2022 at 12:30:49PM -0800, Sherry Yang wrote:
> seccomp_bpf failed on tests 47 global.user_notification_filter_empty
> and 48 global.user_notification_filter_empty_threaded when it's
> tested on updated kernel but with old kernel headers. Because old
> kernel headers don't have definition of macro __NR_clone3 which is
> required for these two tests. Since under selftests/, we can install
> headers once for all tests (the default INSTALL_HDR_PATH is
> usr/include), fix it by adding usr/include to the list of directories
> to be searched. Use "-isystem" to indicate it's a system directory as
> the real kernel headers directories are.
> 
> Signed-off-by: Sherry Yang <sherry.yang@oracle.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
