Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B432D7DDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 19:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388079AbgLKSQK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Dec 2020 13:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732856AbgLKSQB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Dec 2020 13:16:01 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D3BC0613D6
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Dec 2020 10:15:21 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f17so7662325pge.6
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Dec 2020 10:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=42ItSG5k6gilzvruP6vkWPKjQZf2ASbFaegJ8WBq46k=;
        b=nmV46k580IjN1OfSq0vmOLaHsDK3fE7kBSfRf6epModB0ISgPi0oSN4lTZBEqpbRo4
         1viTXR4MfyCO1GcGOMGSFPXvqIAauJYGnB6BJHdBZihZTm2u3IcXIP+kiRvdWzZ0Ts4g
         zl4rwBlkAlrOOZLqhru2v5OxVk0a6r1PsGfg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=42ItSG5k6gilzvruP6vkWPKjQZf2ASbFaegJ8WBq46k=;
        b=KefLMcPD1PLP73oWKmPQzs1F82n8vfMbOwrpZ05c+JloLy25sAxmyvc3v1qLGGiFTp
         IYxUip87OkR/ZHz+AoJd9/KHCOB3bDSN9oCB9OhAL69s3G6ooM4GNeO7tHStqVjAVLuy
         DEc1QNiI4GriefY+O+qUamiM6MtqwnOIZHyj+M0QSCpzAifx0Gjv5hpzLcyMlLw2bQOo
         fQO0/qI3pRyDBwsR6U+mikIV0ANblpC6WdA63n1zU1Hd5KXuPt2NHvD+4RnpMtZ63zHa
         oiuM0yUHVvrmU3JmRCGaEKliEABHaipvwjJ0YNvgQm1qMb2rBgPfNEynaRtTSkxoLuHT
         nA+g==
X-Gm-Message-State: AOAM530QlEdZjbDqubiwKWrTHUkn1IM4mfuRGp2Amt6KR+IxFoE79dX4
        w37P55PkLngsO3Mcc2ZsYqTreQ==
X-Google-Smtp-Source: ABdhPJw14RBWXvlZoXrfa6ytYeUXNUNxXJZTFSezlEgtDNxDopvtWHFM92C4Bm3UNHJ1SYRs3CRoSg==
X-Received: by 2002:a65:4642:: with SMTP id k2mr13110625pgr.338.1607710520652;
        Fri, 11 Dec 2020 10:15:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ck20sm11025821pjb.20.2020.12.11.10.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 10:15:19 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:15:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org, kuba@kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH] selftests/harness: pass variant to teardown
Message-ID: <202012111013.46FEA48C@keescook>
References: <20201210231010.420298-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210231010.420298-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 10, 2020 at 06:10:10PM -0500, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> FIXTURE_VARIANT data is passed to FIXTURE_SETUP and TEST_F as variant.
> 
> In some cases, the variant will change the setup, such that expections
> also change on teardown. Also pass variant to FIXTURE_TEARDOWN.
> 
> The new FIXTURE_TEARDOWN logic is identical to that in FIXTURE_SETUP,
> right above.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Thanks! This was on my TODO list. :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
