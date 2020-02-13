Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E53E15B7B7
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2020 04:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgBMDZK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Feb 2020 22:25:10 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37194 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgBMDZK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Feb 2020 22:25:10 -0500
Received: by mail-yw1-f65.google.com with SMTP id l5so1976807ywd.4;
        Wed, 12 Feb 2020 19:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=85T29TIdnCRWIMaQON0n5Vh93aDWlCffiOsL4ntYFjQ=;
        b=UlVFfhkHuvCy1lNFg/A9hpGn9IWIYgngmPTZyQK9oM3FOlwBjSkvVx3bLooMvOIljn
         CoRY01vLefpRLJAw/h2yFeBbq95cz8AIlx2sCP/J8eQT29oi3h3OWanSvvpjnu/sWvTw
         B1QmAn1hsbrNcHQ3z3LZ+4k4CZypRms453oBb0cNydSLjZPhCKaXcVjm+2NK4Z9hTzLH
         ARoRG38YYpylXvyOieVL4sotkq9XKZA/GE5U5js9egQqXTlRomgytRY4F2gRWQvDCmQd
         o5I73oL/N3XuueI9qGEllAyIqzyHBIbow+lgT0t1vAQPXdzGbe6AWx+6ScGTmej2STrA
         PpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=85T29TIdnCRWIMaQON0n5Vh93aDWlCffiOsL4ntYFjQ=;
        b=Or8qHb8dEGKNoOvYIlAPIeL5Jc225M3xRXRSq756yeYLeaSfGQuRehhQ5ACASYUYH/
         81leZLvKH8Ea7j3oiqr01nXjSoXJroTZWBl6SVNtVIxLwu4Zxby9POrThQoa0/wdW+a7
         2ZBU43yQlLExMh5pxXiHZfd0jEb2F18ieDVO/HqAfMSSIQYRQ1lr5XGXmsCa1iV6XdNH
         SbD6aAdl+5M9A2Ve/hTl0ekLM9xwwValcO5u6UpxzoC7SBM5LpFWWBJkUFrxyQyuwGF3
         T7tGSgn6Fkd4+TbePOpY8SWlz3Vsf8uMLXH0WY3WtWlnt/gny2QtlQyz8Wk8OIpFfPr1
         3xzQ==
X-Gm-Message-State: APjAAAUFBxKaL+RhLb3OEgAiWzQ1uRAGZAds/s2exaIAUuwgCFF6duU7
        Qtd38SSCEksF8tWPA7GL/ZzMdCTJ
X-Google-Smtp-Source: APXvYqxH7WWGJb2oRDYa9cizq/zJkXYb6t3GFGeuIjdDwgVrLyg7OOxgiWRXhqwPZKO5miDilp9XCQ==
X-Received: by 2002:a81:11d7:: with SMTP id 206mr13703483ywr.150.1581564308986;
        Wed, 12 Feb 2020 19:25:08 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id p6sm568105ywi.63.2020.02.12.19.25.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 19:25:08 -0800 (PST)
Subject: Re: [PATCH v3 kunit-next 2/2] kunit: update documentation to describe
 debugfs representation
To:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        gregkh@linuxfoundation.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, davidgow@google.com
References: <1581094694-6513-1-git-send-email-alan.maguire@oracle.com>
 <1581094694-6513-3-git-send-email-alan.maguire@oracle.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <aee3079c-a626-dadf-da57-3ae8c13a8935@gmail.com>
Date:   Wed, 12 Feb 2020 21:25:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1581094694-6513-3-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/7/20 10:58 AM, Alan Maguire wrote:
> Documentation should describe debugfs layout and semantics.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  Documentation/dev-tools/kunit/usage.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 7cd56a1..b2b958a 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -590,3 +590,15 @@ able to run one test case per invocation.
>  
>  .. TODO(brendanhiggins@google.com): Add an actual example of an architecture
>     dependent KUnit test.
> +
> +KUnit debugfs representation
> +============================
> +When kunit test suites are initialized, they create an associated directory
> +in /sys/kernel/debug/kunit/<test-suite>.  The directory contains one file
> +
> +- results: "cat results" displays results of last test run

s/last test run/each test case and the result of the entire suite for the last test run/

> +
> +The debugfs representation is primarily of use when kunit test suites are
> +run in a native environment, either as modules or builtin.  Having a way
> +to display results like this is valuable as otherwise results can be
> +intermixed with other events in dmesg output.
> 

+The maximum size of each 'results' file is KUNIT_LOG_SIZE bytes.
