Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4521AEA0C
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Apr 2020 07:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgDRFpY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 18 Apr 2020 01:45:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33688 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgDRFpX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 18 Apr 2020 01:45:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id c138so2159952pfc.0;
        Fri, 17 Apr 2020 22:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TlYz2PK5MXvRAFEYvsWdBeIsqwyb7mjoCnGHKrdEVCQ=;
        b=MAkxwCht/DckWQFexzv7j8sfSxkYOznHTrYBs1oR+mnBMuL2DsbPYnqMKGwR2AnHP7
         zTTYqYkJOo+2VFtr0YE/I8adkZeMpWppjP+45Z4xijdefhvGt3jyb2hDvi2vNIryeDik
         FwXfV/TmoKpKVuj+6j6elSm02REtdvSfEWJIZ1yNhj5E0+EjiaXi90/RUbnJHR9ffPzh
         ydIiJQqZXdNdVMRZC+qdD3I3QpX+Xfdbtgx8DZ0lTZzNKPGOKYSNDavnbNQj4as7X8Pg
         NPdTvMD5IX7dEwzjRFbnJTOAQzgs4l9/MsndY0FaQ9tvT71xwCWj6lW7/G7xZvteLnCP
         DDCQ==
X-Gm-Message-State: AGi0PuaYEiMGbVIPIEBNGAjJYGK+mvPDbAcjiu+1oNFnOakl0zFSdEHn
        AYxzKho78K3NlZlhUYrJyjWuqyUd0nU=
X-Google-Smtp-Source: APiQypLuOOOCgjF5AyNfkhPofM0QVO9zF/P5ScwbFYo+baECumfyKSNcjqHKN6cTXICi6Mna0bQFmw==
X-Received: by 2002:a63:6cc5:: with SMTP id h188mr6334764pgc.337.1587188721519;
        Fri, 17 Apr 2020 22:45:21 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y126sm15284065pgy.91.2020.04.17.22.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 22:45:19 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 3F0A34028E; Sat, 18 Apr 2020 05:45:19 +0000 (UTC)
Date:   Sat, 18 Apr 2020 05:45:19 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 3/4] kmod: Return directly if module name is empty in
 request_module()
Message-ID: <20200418054519.GX11244@42.do-not-panic.com>
References: <1587187200-13109-1-git-send-email-yangtiezhu@loongson.cn>
 <1587187200-13109-3-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587187200-13109-3-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Apr 18, 2020 at 01:19:59PM +0800, Tiezhu Yang wrote:
> If module name is empty, it is better to return directly at the beginning
> of request_module() without doing the needless call_modprobe() operation.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  kernel/kmod.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/kmod.c b/kernel/kmod.c
> index 3cd075c..5851444 100644
> --- a/kernel/kmod.c
> +++ b/kernel/kmod.c
> @@ -28,6 +28,8 @@
>  
>  #include <trace/events/module.h>
>  
> +#define MODULE_NOT_FOUND 256
> +
>  /*
>   * Assuming:
>   *
> @@ -144,6 +146,9 @@ int __request_module(bool wait, const char *fmt, ...)
>  	if (ret >= MODULE_NAME_LEN)
>  		return -ENAMETOOLONG;
>  
> +	if (strlen(module_name) == 0)
> +		return MODULE_NOT_FOUND;

I'd rather we just use something standard like -EINVAL.
What do we return if its not found? Then use that value.

> +
>  	ret = security_kernel_module_request(module_name);
>  	if (ret)
>  		return ret;
> -- 
> 2.1.0
> 
