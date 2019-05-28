Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1436B2CE27
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2019 20:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfE1SDG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 May 2019 14:03:06 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39155 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfE1SDG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 May 2019 14:03:06 -0400
Received: by mail-lf1-f65.google.com with SMTP id f1so15305865lfl.6;
        Tue, 28 May 2019 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wfGXrN4EQ5suIjo/YRXyzyfXioxjZfnHxqzJZSsYcQ0=;
        b=COeg1GNYb9LEdxwJHJOB0zvMn0apyp+YCV73tVNcFrSnuolMa4SG59OVTMLBH0eucI
         sHjlc9MUF7rT5yXo6iIl1tqMdGxrokqMlfuXpifi7kz+bfgJMiwp+XnFDzaw1wBfktOM
         6udam2tBLuW7M9KGHhBy7+5tPwhpW3W7D6CG8CGk5vS7gG3ymvlB7ZKTuMgh6TOdsYAD
         2S7yimcjQYIFNkRpJJFThZ0xz7zXX19/n5IrlHSCYrHaJGmOI8HftK4TSd6Gonv7kLBI
         MrJLGAjB8Ic2t8xDfgAt7xG3/3ABgsR4kdwqwGexDfj6nN+wi1suOLAzlWnhBmSncC22
         HMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wfGXrN4EQ5suIjo/YRXyzyfXioxjZfnHxqzJZSsYcQ0=;
        b=by4roPtIhAPWptmme7hP9sFKqWlKgS/podYFFPC9SwW73sPrwhvRZseX1kpOksk6Cc
         yPtPz9TnuXMW/K8V1unXlA/3Uu47nIrFpXOOzbNlhje1sdsBJz1Cm3f59dSXpyULvVH9
         TQi1l9lmycU5Yn2weLqIYD/8KEQMmLKs6yBdt7lpCDLEPy6XgSQSt+vB1kJWFS4SCeTl
         IsE/3lrHSMVfA00wZSnDMisCdoQh4igFQw4J4Ad2dNa8A519aI0hTVL2Mh01Hv3ftJsX
         7Pf4NFXoOXnax8GNVA71yhCxTmj3x4Tmf+GHnKj5PpMK0kYP9W7UzyBD4BXCUScCBvPS
         JTAg==
X-Gm-Message-State: APjAAAU/qmd+WSyXx3rcNLZQadU2xlrCPyaG6r99oiJ9BsovZg62Mh7g
        cFnsseFUoA/x6J4tqYWOOAE=
X-Google-Smtp-Source: APXvYqwdhl+n24uT5uwqOJG8J15RrNkuRRWcfucy3b/03fihY7juOf7oWPnTKlykra5mOVZHyfTOrA==
X-Received: by 2002:ac2:528f:: with SMTP id q15mr45362716lfm.37.1559066584506;
        Tue, 28 May 2019 11:03:04 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id f20sm3108341ljj.96.2019.05.28.11.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 11:03:03 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 28 May 2019 20:02:56 +0200
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-kselftest@vger.kernel.org, urezki@gmail.com,
        shuah@kernel.org, keescook@chromium.org, willy@infradead.org,
        mhocko@suse.com, oleksiy.avramchenko@sonymobile.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: vm: install test_vmalloc.sh for run_vmtests
Message-ID: <20190528180256.vwp23xoz7fow6huu@pc636>
References: <20190528121809.29389-1-naresh.kamboju@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528121809.29389-1-naresh.kamboju@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 28, 2019 at 01:18:09PM +0100, Naresh Kamboju wrote:
> Add test_vmalloc.sh to TEST_FILES to make sure it gets installed for
> run_vmtests.
> 
> Fixed below error:
> ./run_vmtests: line 217: ./test_vmalloc.sh: No such file or directory
> 
> Tested with: make TARGETS=vm install INSTALL_PATH=$PWD/x
> 
> Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> ---
>  tools/testing/selftests/vm/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index e13eb6cc8901..05306c58ff9f 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -25,6 +25,8 @@ TEST_GEN_FILES += virtual_address_range
>  
>  TEST_PROGS := run_vmtests
>  
> +TEST_FILES := test_vmalloc.sh
> +
>  KSFT_KHDR_INSTALL := 1
>  include ../lib.mk
>  
> -- 
> 2.17.1
> 
I missed that point during integrating with selftests.
Anyway the patch looks good to me.

Thank you for fixing it!

--
Vlad Rezki
