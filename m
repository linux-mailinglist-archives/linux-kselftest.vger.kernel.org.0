Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4934D1827F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Mar 2020 05:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbgCLEwO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Mar 2020 00:52:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42172 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387658AbgCLEwO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Mar 2020 00:52:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id x2so2242737pfn.9
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Mar 2020 21:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QBqC1JyaOiOUzcJrJ1ImRUkCFV/1q+WhF3WSrZ+wbGU=;
        b=EA0wVoixiY926zB14t/5ytht/QwlPqYDJ7Ro1fqCFKRqq4PFKOb+Z4wk76rFl8dyKn
         c4wr+z4+jTQufFXQL17EdlUiLnm9GbvvV4SgAPAhZyVyy4AIqqRoe/T8fIXXsDrX6GRX
         xavJimxJXP12pn0Gj3pTmyPzg6j/EAxRqkyCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QBqC1JyaOiOUzcJrJ1ImRUkCFV/1q+WhF3WSrZ+wbGU=;
        b=TU2QDW2ogbzHLt0FeFib2ayqNsRXbp0aOkmoJc4O0gMC7Ibc+HWqBuKiCSGJ2YPYIp
         gUZlQ1loz4tXllR0cbeUqRrialM9mqryP4BHeg7jHwosID8hU1QHo8HyxyHP7tXVTxQ2
         sPzqsEKLaTzx471WDqinVZ0xbeWd+m3SHna8CNTOMkUbThVovsjQfO6b7GsYDYvE12KB
         BoZH21ib43UsDoR9jilLi4bNtWgKoFAhPumFRNwZUmflLgj79v1JgwazjpaPZyD99pOL
         ky6d0H0oE6Cn56KNwcG1P9RGjNgy6WeavxPplppslJXb9lXk3RxWICNx3da06B0YaLLE
         q/cQ==
X-Gm-Message-State: ANhLgQ0Is+7qAdH4HVWzZQu/KghBMq0hh4VbIIX3QU5sSFo49Gc00rJO
        ztrNtArMcdApiPDRrD9pZAnroA==
X-Google-Smtp-Source: ADFU+vtvjkWZ5FnvODf77mKBcfFoGiAiNgB9YdmW+gqX3v7F8gWCM75Mpgcu/x6n+qT6RRyv41PJiw==
X-Received: by 2002:aa7:82d5:: with SMTP id f21mr6260022pfn.245.1583988733679;
        Wed, 11 Mar 2020 21:52:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h2sm6893317pjc.7.2020.03.11.21.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 21:52:12 -0700 (PDT)
Date:   Wed, 11 Mar 2020 21:52:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/seccomp: Move test child waiting logic
Message-ID: <202003112150.C2C5942DC3@keescook>
References: <20200311211733.21211-1-keescook@chromium.org>
 <20200311211733.21211-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311211733.21211-2-keescook@chromium.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 11, 2020 at 02:17:32PM -0700, Kees Cook wrote:
> ---
>  tools/testing/selftests/kselftest_harness.h | 93 +++++++++++----------
>  1 file changed, 49 insertions(+), 44 deletions(-)

Hrm, the Subject prefix is wrong here. It should be
"selftests/harness:". I can send a v2, or if everything is okay, can you
fix this up in your tree?

-Kees

-- 
Kees Cook
