Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69101E3280
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 May 2020 00:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389638AbgEZW3k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 18:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389482AbgEZW3k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 18:29:40 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A03C061A0F
        for <linux-kselftest@vger.kernel.org>; Tue, 26 May 2020 15:29:40 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id c3so17653361otr.12
        for <linux-kselftest@vger.kernel.org>; Tue, 26 May 2020 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5wqB25Ndtf7G896Xqr2DU1ONCjpaiNIvRfUkDhIp+o4=;
        b=ajCuuPdVNqJkiWUnn8o03t9TsMo7OEm3Qkfy9klzyZhl3i1I3ekfHr0s9Zn3xB8saQ
         KsS8XImoIfanBQsGd/FJI/5xiiDtBWFT7WfsF7PAbZAWWtlc37D0g9zX0Irm3bp5N0By
         533c/c/rF8H6sPab+sGruZq3Kx8M7fEalWda8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5wqB25Ndtf7G896Xqr2DU1ONCjpaiNIvRfUkDhIp+o4=;
        b=fez0DvZOO8MT08gp3JRS2ptjbI6GjSHAwcvyE49r3MV6/7kwsvK2vmvSMtSDCs32Aq
         wNI5PlQzjj7/L5AaVQqnRnWKYoktnombi95b0rss6OnPQaTZdyoxnpl/ead5JTizNgk4
         9mKsRZsgMPtneVpgpLljfcx5hyCNNtfbo2zb6U2m9aZ++oZ4z28Kttkr4BTRlUKcYU3n
         GJ+fpORfKpKj8QsIHT6G8b3xHAq0dbkAcOLT1CP76zEw5uzbkmIGQ0eGYkRp/Db/4WJv
         NjisOtr8zoAjdpcsx6DPAEsh6ShuBySuaSNMRjqSOBXhjpao10uFaJQQhLDm4UcDe3Zx
         1plA==
X-Gm-Message-State: AOAM530hioR0kA/mpQ6owX2Qj7EI2SCz78UeLZ7x+45n1j6ErpUM2qk7
        JJCW1oij4XbuDIq5/TInD6c4bw==
X-Google-Smtp-Source: ABdhPJw2UJGheVoQlPvhb7lYFGjKDjL07dSv/0TUE+bFEqIDtMMdHttQ9hsCTHmFNvxtgVQFW6OFrQ==
X-Received: by 2002:a9d:6092:: with SMTP id m18mr2402145otj.117.1590532179333;
        Tue, 26 May 2020 15:29:39 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d21sm282371otp.46.2020.05.26.15.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 15:29:38 -0700 (PDT)
Subject: Re: [fixup] kunit: use --build_dir=.kunit as default
To:     Vitor Massaru Iha <vitor@massaru.org>, kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
References: <20200526183436.47026-1-vitor@massaru.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ace26347-a78e-1bd1-86f5-f8e644aa93ec@linuxfoundation.org>
Date:   Tue, 26 May 2020 16:29:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200526183436.47026-1-vitor@massaru.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/26/20 12:34 PM, Vitor Massaru Iha wrote:
> To make KUnit easier to use, and to avoid overwriting object and
> .config files, the default KUnit build directory is set to .kunit
> 
>   * Related bug: https://bugzilla.kernel.org/show_bug.cgi?id=205221
> 
> Fixed up minor merge conflicts - Shuah Khan <skhan@linuxfoundation.org>
> 
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> version after merge on kunit brach:
>   * fix identation (tabs instead of spaces)

You mentioned spaces breaking python. Please include the python
errors and make it clear in the change log what is fixes.

thanks,
-- Shuah

