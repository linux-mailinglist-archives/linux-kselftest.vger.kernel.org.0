Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDD627494B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Sep 2020 21:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgIVTjF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Sep 2020 15:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgIVTjF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Sep 2020 15:39:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D069DC0613CF
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Sep 2020 12:39:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k133so8054527pgc.7
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Sep 2020 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cl+WO00Kizr4omooNzww9UPHhmmcnUeRH4hrmQ6UKdM=;
        b=SN3IEdv9DKs8YIAAClvTilYOYD+6BYnK5EIxvb5YteSFPi4IJ8WQVOl0JT2w8UYBCi
         kTPMlGyAECFOooThXIMqEJD1UrWSfJvddGLnyE15YglUlAfv5jrrGLk5iEUpPAmZWW6x
         S262k7mNa+eTKHeFPpYSoSeTbprnhPYBC6MwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cl+WO00Kizr4omooNzww9UPHhmmcnUeRH4hrmQ6UKdM=;
        b=nl93gJ8xkLZl7Kt46rm29PLmg7oYk3ktgXHBVh5g7liOlkRBEOZtIkbJ8qOU03FAFI
         SN6zIJ5LqXaEa7t4CJRQon3D+tkY7/7bW+TUP2cgqozvHCfeOUNX/cRhfR0hoBu6qQao
         93FMDoGe+7hsqOUqt5BIqxD/9DXBIgnVbKmZVeVfarvpCGhytGF4aiuO+C7ZlyBJQ5Wx
         Woysfq8fcI2iAJ8Krn/SU/Y8AR8u4smujW5yONevvqM+E7XLNhIYrQzMtggfx+uys9WX
         GYRLB99jS9hysEBmfmXFOqjJRiUggM1zjKNB510HuZgeX+VzwxpqH7Geeu3y9/fI7QLc
         jttw==
X-Gm-Message-State: AOAM530CemW9K0Hzn3oFYKkpw3+Zl6NkL4POoyq7LqUlNTp75typyq7G
        OFDB5mpJdSvut1Oa+1tBunU6sQ==
X-Google-Smtp-Source: ABdhPJzDEAChCs+Qx1Viv+taNVtjbQVUqkYi+3GXJZ+jiwSOYs8NZ8ewvBVyJ9+kszBz+qEOPJ9Rcg==
X-Received: by 2002:a17:902:7083:b029:d2:4ca:281a with SMTP id z3-20020a1709027083b02900d204ca281amr6006921plk.58.1600803544450;
        Tue, 22 Sep 2020 12:39:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q190sm16996666pfq.99.2020.09.22.12.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:39:03 -0700 (PDT)
Date:   Tue, 22 Sep 2020 12:39:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v6 4/9] signal: Expose SYS_USER_DISPATCH si_code type
Message-ID: <202009221238.66C17E34@keescook>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-5-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904203147.2908430-5-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 04, 2020 at 04:31:42PM -0400, Gabriel Krisman Bertazi wrote:
> SYS_USER_DISPATCH will be triggered when a syscall is sent to userspace
> by the Syscall User Dispatch mechanism.  This adjusts eventual
> BUILD_BUG_ON around the tree.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Yup, this looks good; seccomp is glad to have a new SIGSYS friend. ;)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
