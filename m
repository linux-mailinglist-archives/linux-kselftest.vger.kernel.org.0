Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50783216029
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jul 2020 22:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgGFUSd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Jul 2020 16:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgGFUSd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Jul 2020 16:18:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0B2C061755
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Jul 2020 13:18:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md7so2363268pjb.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Jul 2020 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kH+JcTGSZq1IaKf+7a5y8xpXE6P2p/YmqDxscyJtTF0=;
        b=HuNn966m+ekn7j32VIF+2PaEsLSVoU8AbREQ3KujZX2sg0iaaxuUqC/sJ0pC/m1ndS
         SYZfhGq4S4TRC4+LFuJ+gRy0OcHxcGDlT5xX9vnzCGlFBHucY2wx8FFpDtB85Ba8pL+b
         qqv9HkwiqXGfGVM63KlB0kHmdoL3tKJgy7xiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kH+JcTGSZq1IaKf+7a5y8xpXE6P2p/YmqDxscyJtTF0=;
        b=WfH6Xv2DO+W3u97C+ptgc6SyaDJiqRpOZG9LErNLB+yBKMYHw/DcqWNkNLML4xLsEX
         aIpiQMA++DcuZaJBbklYYDXTfwdAo1J8oHWPHOopAYqOOuGaZ9lY6g6sTBonn2XDOvbH
         nqn/jONo9uEh7ucVcCVmCh6oQ+1rT0NrIPd0IEUG+FElPii8b6ohtngoFcw2hOFbZWSK
         ckG5m84L5sLeOTPX2alZGI9DSNVeHny6nVutLIjUCEF98OM9A3Qg7jRSqGVmya/LVRiM
         Jj9HsP3nEdUdNovVkWbWX9Nyx5u9GS/HHAMIAk3Mcv81lewOGU9Z1u9ehtElLUrmvLpR
         ASqg==
X-Gm-Message-State: AOAM531p+zWHh9tNIAi5YqSc3CbOzf4Y8Epst357WCv0rjEfL9gr26Dc
        GkGVnHE/XGcBXysUsuAxBgqDLg==
X-Google-Smtp-Source: ABdhPJzt4rTgm2BYV08YGvM9tpMf4XxwVel/3LKMdtZcXsPgjzGrEQudgSQHsicb9CJx2isUr3Fa4g==
X-Received: by 2002:a17:90a:e987:: with SMTP id v7mr845528pjy.56.1594066712687;
        Mon, 06 Jul 2020 13:18:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7sm275141pjy.54.2020.07.06.13.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 13:18:31 -0700 (PDT)
Date:   Mon, 6 Jul 2020 13:18:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] selftests/harness: Switch to TAP output
Message-ID: <202007061318.9868E4321D@keescook>
References: <20200622181651.2795217-1-keescook@chromium.org>
 <202007042245.BCC693126@keescook>
 <026732c2-5713-eeba-0706-b533ea488db1@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <026732c2-5713-eeba-0706-b533ea488db1@linuxfoundation.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 06, 2020 at 01:57:19PM -0600, Shuah Khan wrote:
> I will pull them in today. OSS+ELC set me back with getting ready for

Thanks!

> the talks and presenting. July 4th holiday didn't help.

Heh, yeah, I'm in the same boat. :)

-- 
Kees Cook
