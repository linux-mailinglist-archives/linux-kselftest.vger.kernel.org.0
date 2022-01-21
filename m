Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4942D496732
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 22:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiAUVR0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jan 2022 16:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiAUVRZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jan 2022 16:17:25 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79E7C06173B
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jan 2022 13:17:24 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 133so9185089pgb.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jan 2022 13:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M3K++L21eAAGax/pSMy5EBlZVR5zLAnwUutfX/mqIwg=;
        b=NQcQ8UpCXpOLyII/9JmSEQluwwUdz9q05AFW+6DPA4aGKuQ3WFEJe2sqpCXU9SO3q+
         SpSrkDoOfmiK2emvM5Xm1hgSxVI00jWi/D+uZ/LWo+4LI1VwDn8sJ2d5Psv574mhKBu7
         OCULoXe6PfGtjyes2tVk9swHBcr/4pdbaIt48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M3K++L21eAAGax/pSMy5EBlZVR5zLAnwUutfX/mqIwg=;
        b=SQ0Lo1f58ig2UFNDqzHWkbu+iX2Ko0gJOIeUnp2DLQ58bNjMngFJiFdjO2MpteEN73
         98qsEvhkx28wwLLR81SPTcMSCfnqt1jfZpSPw3Uj4LINZUkyLWXpavO33vMM9FZvdJqB
         jF4B2c2xtjMbfufh5fUW9qR/e415H0N/hdV/18GhmezBJkWS5xRproZPYBtGpaID6eLT
         n/YPSG2vhQmRxS5CvR2fnsJHfUERwMXGOG1DiLsFW/Oxz4yuL4Pevkuiskad7e6fWmY6
         M3TPSBRhB/JYxEH4S8V0vMglNQ/mqexL2cWuza3COo9yUH0udoq4y3ApBHDhLxFiBq6C
         owjA==
X-Gm-Message-State: AOAM533MuP5I/Wg5vyi2+t2ebyKHkKSWXdmKD49hX4zyKsETQ0id8a1O
        QiRgAHOTlzrU/kQzX1u2673MsA==
X-Google-Smtp-Source: ABdhPJw/3FsWKdvpsKr+B39WTtS6+P3O84HImapzklzj/9fzxJv3DZ9xsoVqXoV9Mn5oXpxerJcqAw==
X-Received: by 2002:a05:6a00:234e:b0:4ae:2e0d:cc68 with SMTP id j14-20020a056a00234e00b004ae2e0dcc68mr5471597pfj.60.1642799843921;
        Fri, 21 Jan 2022 13:17:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w1sm7275940pfg.162.2022.01.21.13.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:17:23 -0800 (PST)
Date:   Fri, 21 Jan 2022 13:17:22 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests/lkdtm: Remove dead config option
Message-ID: <202201211317.93CCC271@keescook>
References: <20220121145154.1795447-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121145154.1795447-1-usama.anjum@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 21, 2022 at 07:51:52PM +0500, Muhammad Usama Anjum wrote:
> CONFIG_HARDENED_USERCOPY_FALLBACK config option has been removed in
> commit 53944f171a89 ("mm: remove HARDENED_USERCOPY_FALLBACK"). Remove it
> from the lkdtm selftest config.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
