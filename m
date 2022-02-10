Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB7F4B1474
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 18:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245272AbiBJRnN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 12:43:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245269AbiBJRnM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 12:43:12 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F435192
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 09:43:13 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id l9so841761plg.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Feb 2022 09:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RfVaSD5Jbl1UCapkvwTHkbWqS8zVw2iOHKCAwa9H0bo=;
        b=mPRxMXX+y3f90qS/gIUi3DqSuIu88IQgUnYn/CtI8oUWe8L9TD1H0WXBI064iWvs9x
         0sURffRFCyyd9vSBECvmcKMtKeYwQRctxSOoQfnBkzNdynfh7tnSgBmffK6bbr4gp+/c
         kq58WyJkxkzQnHmbGDTtGDYBGOvGAN2PIO5RM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RfVaSD5Jbl1UCapkvwTHkbWqS8zVw2iOHKCAwa9H0bo=;
        b=oy4+CluqzqqgAZLvseqCvrKT8ycSslBU66IFzY7ktmlR/bOr7+DDa4O339FGDUO7wE
         AokM3mW/grnyrfOA1PHtvieX3l6nsuLqOmvjv0dKXw5J4o0k9DtAltC95bjbYAIGDbV0
         NJQcuWo/af1kzuy1ysFRQpkFhBPgGQTT0h8+++lSIymtPSIruuiECFl/7998tVRwHbzF
         /YSTCJu+Epb2J3wPt2ZveYHB85tVA3xM1NsfIfqjWvpVUnz56CPlgscDHZppduT5Hbfm
         zJw/MYLD/6st3S/k2L+7d4w4/Gvl7oi472C/dlGvi4i6jSp20dj04El8dhbW8d0FSBRL
         539Q==
X-Gm-Message-State: AOAM532tDe3hcwvQCvm69q7ZjT7paR2or81czxC4QurAIclNJh5dSCu8
        7yyz69QjAQzkBC2nEhOOPUBeWw==
X-Google-Smtp-Source: ABdhPJyEmB34sogZs6Rj+2bZzHJh+ef5Kc026LQokIFwesK8wdexB1XeGvWkY1tS4FM6JSfJeUjC1g==
X-Received: by 2002:a17:902:b90a:: with SMTP id bf10mr8691668plb.36.1644514993117;
        Thu, 10 Feb 2022 09:43:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 204sm24336775pfu.91.2022.02.10.09.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 09:43:12 -0800 (PST)
Date:   Thu, 10 Feb 2022 09:43:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     frowand.list@gmail.com
Cc:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@groups.io, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Documentation: dev-tools: clarify KTAP
 specification wording
Message-ID: <202202100942.A8206C0@keescook>
References: <20220210023519.3221051-1-frowand.list@gmail.com>
 <20220210023519.3221051-2-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210023519.3221051-2-frowand.list@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 09, 2022 at 08:35:18PM -0600, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Add the spec version to the title line.
> 
> Explain likely source of "Unknown lines".
> 
> "Unknown lines" in nested tests are optionally indented.
> 
> Add "Unknown lines" items to differences between TAP & KTAP list
> 
> Reviewed-by: Tim Bird <Tim.Bird@sony.com>
> Reviewed-by: David Gow <davidgow@google.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>

Thanks for nailing this down!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
