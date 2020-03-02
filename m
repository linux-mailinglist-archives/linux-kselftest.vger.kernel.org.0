Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A0117645C
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Mar 2020 20:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCBTxU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Mar 2020 14:53:20 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33233 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgCBTxT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Mar 2020 14:53:19 -0500
Received: by mail-yw1-f68.google.com with SMTP id j186so1050824ywe.0;
        Mon, 02 Mar 2020 11:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cGLSsu89YwSGXsGLVjYTzgPcmvmOj0k8jfa+3OUZmz4=;
        b=GjjiT+/XlL3wmNr6FBO1wm+U7RhUuihrNi3KJhbC6ouk8uQzlXMdi0RuEJMdlCK92h
         aZoEuWfpflrHAMkelEVPQYb1vOTaNwff1T9eQi4AkHJJbbOhw3XYf0IIeN2Z03cT2bwa
         u29WNshVxVG+X4vFPOVIRRcQeiSoIeMudqi4bU2FMcBULZjNtf6T1lICYd41OL9e0g9M
         fazKjjCJzW7Y4lK0KBq8oQd4PhqnMhjzPZNaOqr/MoaKCVQj0LhIFzhP4KDtVm7GSkZx
         aHDCguGg28S3cSJvxoNnz2i+WkUISleaJtgi6P3W82g+fDppX+n+ULKtww3Rn0PrZ0Pq
         e+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cGLSsu89YwSGXsGLVjYTzgPcmvmOj0k8jfa+3OUZmz4=;
        b=GF0qMFjHqh57hiXJYZ0I/FWN62EaKv6Djnlq+JsynFDBRBWPH74Mq1mtg474aXih8B
         g3SCwLnWGlE+6/2QqhSfqbEASZHuAzo7MlHnZO8KjaoZyJivoJOe45/jmGSgHaZnaUqz
         jX1N5jUJ+guKWjjBV8UzSfyuwdFqmNARqb3ktZX1Ilr2DsdYiqG2BfNXvimTiQNfLB/y
         jAjE3XjSBOren8UDtGZz1xvBjeUFa6+Cw+jJ4YM1eOItFQ+4pTc8xgT5IAuBvbCp1glI
         hqvw3gh2MUUeM+fzFGPCQ7hqen5jb/KpA+pn6JZ38FkNKtoEsq7pYyhd/SiAPp+W9+d2
         t+Pw==
X-Gm-Message-State: ANhLgQ2qDPMN+df7wNw7levywHXagnqS8ymAaTZFabQWIRgWai4gh9ED
        nP1hOkQapnmipVQavpUcheU=
X-Google-Smtp-Source: ADFU+vvAuYQjhvPkkUnsogitbNWkioPE32dakfCx2+phZZ9zvzRt6m3vpuOPE378xJWay3ZJWHNB1g==
X-Received: by 2002:a81:4b43:: with SMTP id y64mr965433ywa.248.1583178798784;
        Mon, 02 Mar 2020 11:53:18 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id d4sm5557134ywb.67.2020.03.02.11.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 11:53:18 -0800 (PST)
Subject: Re: [PATCH v5 kunit-next 4/4] kunit: update documentation to describe
 debugfs representation
To:     Alan Maguire <alan.maguire@oracle.com>, brendanhiggins@google.com,
        gregkh@linuxfoundation.org, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org
References: <1582129030-22282-1-git-send-email-alan.maguire@oracle.com>
 <1582129030-22282-5-git-send-email-alan.maguire@oracle.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <3eb74fc3-1423-54d2-8381-0f9b9a8d79eb@gmail.com>
Date:   Mon, 2 Mar 2020 13:53:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1582129030-22282-5-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/19/20 10:17 AM, Alan Maguire wrote:
> Documentation should describe debugfs layout and semantics.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  Documentation/dev-tools/kunit/usage.rst | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 607758a..14b0236 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -591,3 +591,16 @@ able to run one test case per invocation.
>  
>  .. TODO(brendanhiggins@google.com): Add an actual example of an architecture
>     dependent KUnit test.
> +
> +KUnit debugfs representation
> +============================
> +When kunit test suites are initialized, they create an associated directory
> +in /sys/kernel/debug/kunit/<test-suite>.  The directory contains one file
> +
> +- results: "cat results" displays results of each test case and the results
> +  of the entire suite for the last test run.
> +
> +The debugfs representation is primarily of use when kunit test suites are
> +run in a native environment, either as modules or builtin.  Having a way
> +to display results like this is valuable as otherwise results can be
> +intermixed with other events in dmesg output.
> 

Given my corrected understanding of kunit_log():

  +The maximum size of each 'results' file is KUNIT_LOG_SIZE bytes.

Am I understanding this correctly?

-Frank
