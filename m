Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332E0287CE4
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Oct 2020 22:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgJHUMK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Oct 2020 16:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbgJHUMK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Oct 2020 16:12:10 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91434C0613D3
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Oct 2020 13:12:10 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 34so5237094pgo.13
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Oct 2020 13:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WreWDI35pT37NfCuOvWMpspZ2aPXJW/j5j611lagGSs=;
        b=PZxUJluzIt1QggeTdkNp9OGJgg8XkikVmQtKopRptoci+IiyqJqGf+kVkFCc7cjq69
         ivlpz04pLJ09uusSJJ4LJMyd47n6LwU643lka2EaG7jq9Mau6Ss7URcohb2Qqly0mG0f
         trPTzA+vrmzueVq5pWh5d68dBmr+kkEQMWCG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WreWDI35pT37NfCuOvWMpspZ2aPXJW/j5j611lagGSs=;
        b=JBpFPs+OrX+pUFeiGyTbkqCuT0Mbh6Lb3pwtVFWVVCesdJk/3Db4b6Q4bYQDqyRhM9
         Nwv9CJeecF3I7WozMiveyh5DSNV+ykD5wTt58a8m6Sc7r7Q9T6hN/cFao7JZD5TswZMn
         ZQ80QFrU629JBZCj7pGwu3/oubT5pqpUIB1poc3Y90fSETssbGGi57YOuT4eOGIka4BO
         1yc4hbvZl7wcFHYRFpBnkkebMKQmhsIcFMvcKzI2Anl39E6fxHnp3qDVnABrriG7wbXO
         N8XUDZbYnMtU/2G7Qtq/Y87CRyh3NPrToasFPytRnyGppsZXkl3LqdF0CzKgGpzhFZFX
         L7OA==
X-Gm-Message-State: AOAM532xlJ6CjYo7uWejBRxPZOyuPv08dZV8xSF5423rrbOXSlXXdpau
        rfgm73kYoJWCSAFKTNmXHGQpikIM8J/QtKp7
X-Google-Smtp-Source: ABdhPJyGUn2XdCtbtFwE9c2ZDlXiVEtoo5s37rhpZqEX+8F+LyM3E7vOPmMHic1rOVByTegnMFuwvg==
X-Received: by 2002:a62:e104:0:b029:152:4f37:99da with SMTP id q4-20020a62e1040000b02901524f3799damr8922475pfh.17.1602187930094;
        Thu, 08 Oct 2020 13:12:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j12sm8341727pjd.36.2020.10.08.13.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:12:09 -0700 (PDT)
Date:   Thu, 8 Oct 2020 13:12:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tommi Rantala <tommi.t.rantala@nokia.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 02/13] selftests: pidfd: fix compilation errors due to
 wait.h
Message-ID: <202010081312.ACFDD219@keescook>
References: <20201008122633.687877-1-tommi.t.rantala@nokia.com>
 <20201008122633.687877-3-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008122633.687877-3-tommi.t.rantala@nokia.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 08, 2020 at 03:26:22PM +0300, Tommi Rantala wrote:
> Drop unneeded <linux/wait.h> header inclusion to fix pidfd compilation
> errors seen in Fedora 32:
> 
> In file included from pidfd_open_test.c:9:
> ../../../../usr/include/linux/wait.h:17:16: error: expected identifier before numeric constant
>    17 | #define P_ALL  0
>       |                ^
> 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
