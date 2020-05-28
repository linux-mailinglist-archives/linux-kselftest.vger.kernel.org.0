Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52161E68A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 19:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405598AbgE1R2a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 13:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405514AbgE1R22 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 13:28:28 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA26C08C5C7
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 10:28:28 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id a137so748138oii.3
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fHyYz6nP7wTksJQUG/djnUS6+jOyIk+f5n0ywhaKoDw=;
        b=MuSRtJI8VTGc0UCEzAz3cuwZDM2mqqIlSnl5vwZVEY+qBeK7LBTNAmhIB77xiHMlmK
         aJx4mbm4O7iNGqKCDbgCzCpTOttRxL774RYYI69d2wkxl4WK5OQfovvWFrs0W6ntR8h5
         /HN6NraT5wLOdz1a5pqfhH63Ig7NIhYPJPpuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fHyYz6nP7wTksJQUG/djnUS6+jOyIk+f5n0ywhaKoDw=;
        b=dOldBUyFYS/rMg8+6XlE33Cd8dpRHTy+rohbFFWRNYc7DwKxV/BDe1OEaq5/lv9Kmv
         2KlhyFzwZI5YJXVNOk8N8m1QP/b2sq383NE+q1jxoPKIuOdg+Fie3aM/xP56g6B5GQq7
         KsYy77qgXRWe/XYSeXBYkXUNfXBPzLk0Vtk5IA9la/v/ZTo2og3SHpqGGpGZ/BvnyyNW
         Khc+oYdRXzaiwy9Latlrhzr3bY0g44Z2s2oK0wLqbVq3nZRr77V/1yoTE2/wVBIFc/2K
         7Q3sl/B6fN1z5oFUhfeC70CS7RxZBABdsSKx+EDU5q5yv9eEAiPAecC5rn2/yshXx6St
         8IUw==
X-Gm-Message-State: AOAM530+nsUlUHCEt7i/6t9rkBbuLP60sXNVi74dAtzphayuy+maDWC5
        eXLbFtnwWKPYsUI8k3TGFD5B+A==
X-Google-Smtp-Source: ABdhPJz8K2qEpKSG8d/E96Ivi+1oX/z6t2E69KX04odQ/hKLRgeQYkcpMySfRzy/nyC+2t/bI1VHWA==
X-Received: by 2002:aca:ad45:: with SMTP id w66mr2974934oie.59.1590686907819;
        Thu, 28 May 2020 10:28:27 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e190sm1995327oib.5.2020.05.28.10.28.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 10:28:26 -0700 (PDT)
Subject: Re: [fixup v2] kunit: use --build_dir=.kunit as default
To:     Vitor Massaru Iha <vitor@massaru.org>, kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200527003420.34790-1-vitor@massaru.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9b12d44c-938e-b57f-d3ed-509b8e1b07bc@linuxfoundation.org>
Date:   Thu, 28 May 2020 11:28:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527003420.34790-1-vitor@massaru.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/26/20 6:34 PM, Vitor Massaru Iha wrote:
> To make KUnit easier to use, and to avoid overwriting object and
> .config files, the default KUnit build directory is set to .kunit
> 
> Fixed up minor merge conflicts - Shuah Khan <skhan@linuxfoundation.org>
> 
> Fixed this identation error exchanging spaces for tabs between lines
> 248 and 252:
> 
> tools/testing/kunit/kunit.py run --defconfig
> 
>    File "tools/testing/kunit/kunit.py", line 254
>      if not linux:
>                  ^
> TabError: inconsistent use of tabs and spaces in indentation
> 
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=205221

Vitor,

This patch doesn't apply. Can you change to subject to be unique
Fix TabError and do the patch on top of linux-kselftest kunit

I think you did this, but I can't apply this on top:

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit

thanks,
-- Shuah
