Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B03F261FEA
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Sep 2020 22:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbgIHUIF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Sep 2020 16:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbgIHUIA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Sep 2020 16:08:00 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1C7C061573
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Sep 2020 13:08:00 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z25so682096iol.10
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Sep 2020 13:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uaM8vUsFC56bK1f61nDas4I4sfPBn95e3OUH/QbJ7q0=;
        b=JU8Eo3SAZSpvZFivo74bcIxLxvbhmvpW9bsQuZKHtZ/P3PFj4ISG2HqIfo7MPTUWOG
         dn+1cLKJtqYCjk3DOnJelHE9KNVj8Sn2gkBEiqupXcGmPah1QjGCPfwFjoOXFNh6GYWn
         Us/xQ1r9EFANyxmzRNNGTQsWSjVWHjIyIBVzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uaM8vUsFC56bK1f61nDas4I4sfPBn95e3OUH/QbJ7q0=;
        b=cRbyxnKFiyXF/Rnlnqaq/ndjLdOW5KgYYLPfJ1IDixsCx8saLj/kZmVXInCkGWHZ+I
         R9RrxR1CMYNxSp6CJ1DPWlAh9+Ktnb51+uPRNwVh18Rv15y5zgqjljy/JxIClZllo1U5
         pSfnQjd1tjyfZOmRDgGFK/5fP/BsJAmv88SRI3sQVLVKn1uhBJ+umpK4zUkWwpqVKlQk
         FVXrh8/KCLZLGkX7EEYWBt6m4OJBxAW7Sm8Bjjkwern9CwN3XkxIvADntE1CykyzSFtO
         GxiR2ebK36j1HcTWco+QSRnz0NKcI70Z+WtUDzLZWGhTsUSTFcX6Bx5uCSv34Ys1uDYB
         aCDQ==
X-Gm-Message-State: AOAM532OxQsF04JV22nKfqeUBkoY9NMeuR+it9R/ZdcVxqzLxuK7WDDY
        ubtxHyjg9cb+lQy7jXBHJ8JPmA==
X-Google-Smtp-Source: ABdhPJxdJXco5oWWxCEmLUw9bkzoqXLBitkSsdbtacHo7fw6PgnUfniVyhJfviUHS65OCv7RhPMU7w==
X-Received: by 2002:a5e:9e0a:: with SMTP id i10mr492794ioq.41.1599595679503;
        Tue, 08 Sep 2020 13:07:59 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w15sm88442ilq.46.2020.09.08.13.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 13:07:58 -0700 (PDT)
Subject: Re: [PATCH] selftests/seccomp: Add test for unknown SECCOMP_RET kill
 behavior
To:     Kees Cook <keescook@chromium.org>, Rich Felker <dalias@libc.org>
Cc:     Kyle Huey <me@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <202009081232.92206075F7@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <486baf92-5051-e099-628a-ccee4eada6f3@linuxfoundation.org>
Date:   Tue, 8 Sep 2020 14:07:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202009081232.92206075F7@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/8/20 1:35 PM, Kees Cook wrote:
> While we testing for the behavior of unknown seccomp filter return
> values, there was no test for how it acted in a thread group. Add
> a test in the thread group tests for this.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> (This is going via the seccomp tree.)

Cool.

> ---
>   tools/testing/selftests/seccomp/seccomp_bpf.c | 43 ++++++++++++++++---
>   1 file changed, 37 insertions(+), 6 deletions(-)

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
