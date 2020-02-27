Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 922DA172303
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2020 17:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgB0QRo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Feb 2020 11:17:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36475 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbgB0QRo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Feb 2020 11:17:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id i13so62211pfe.3
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2020 08:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vtq0s3tQnCqURKTOAldGkoKbYrI0rQodXXv9xIVTT3Y=;
        b=YDIG629tX7x9Pmb6sOmczh6ju+bZ3q+dGbK7sBRcVdlqc0F739Ir2LJfcrSO7KrD8p
         calXeJ+GMbO9XewuL7HizNgGs/JA+ljTxX/tVQ9yMZ5GWuvmuwGMBVduj+CIScUSXBtj
         UyGuooe9zEJNdNmNz1GrIjjcFKI0T/Zrkmnkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vtq0s3tQnCqURKTOAldGkoKbYrI0rQodXXv9xIVTT3Y=;
        b=lrTcmjd6ZXTno4b8fcN5GQkBwj8urVdEKS1piFEFrzq1IEPep+OTrhXm2Yph3u+1ua
         3zdNnzvlvKz7MAMFBFKYiT6znzmf+C7+9hWr1fJqi6dV9nbamPM0B4fU7woNzxtkH/2h
         s89oYbaqddKgN3xLPaYg7vbK6x4ebCX2o1cwZDyQPFZNWiOD7vPNNmbUiYlr2qEZQu+A
         9H2GAkUY9vcYY9Pf4JHOJMGv7y5Y1YNVteQX4dWVgM7xr44PKj9SNYwovNwCKiYNU3lC
         wvrI5aYevWUThDU2lJggKuVlHIsRYvNc5cobB/VSmKHN1eJMtrTZGTLid2fa3taARJyj
         aMFQ==
X-Gm-Message-State: APjAAAWF9KrN3I9p8uChKRu6Ir6f+AeLoxy/ucjskTmXVaCSrJI53+vh
        gbjK5WNwMKjPA2IK2yebh/9PLQ==
X-Google-Smtp-Source: APXvYqwJAwotmy024gEz2pgQK+lDCNvJc7X5WXUKZHZ3LEAhFZZwS2O/ca0qkaW45CWAD2FYKcCGrw==
X-Received: by 2002:aa7:9f90:: with SMTP id z16mr4879847pfr.161.1582820262963;
        Thu, 27 Feb 2020 08:17:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z30sm7726657pff.131.2020.02.27.08.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 08:17:42 -0800 (PST)
Date:   Thu, 27 Feb 2020 08:17:41 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftest/lkdtm: Use local .gitignore
Message-ID: <202002270817.1C32C98@keescook>
References: <e4ba4f716599d1d66c8bc60489f4b05764ea8470.1582812034.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4ba4f716599d1d66c8bc60489f4b05764ea8470.1582812034.git.christophe.leroy@c-s.fr>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 27, 2020 at 02:07:10PM +0000, Christophe Leroy wrote:
> Commit 68ca0fd272da ("selftest/lkdtm: Don't pollute 'git status'")
> introduced patterns for git to ignore files generated in
> tools/testing/selftests/lkdtm/
> 
> Use local .gitignore file instead of using the root one.
> 
> Fixes: 68ca0fd272da ("selftest/lkdtm: Don't pollute 'git status'")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Yeah, that's better. Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  .gitignore                               | 4 ----
>  tools/testing/selftests/lkdtm/.gitignore | 2 ++
>  2 files changed, 2 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/lkdtm/.gitignore
> 
> diff --git a/.gitignore b/.gitignore
> index bb05dce58f8e..b849a72d69d5 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -100,10 +100,6 @@ modules.order
>  /include/ksym/
>  /arch/*/include/generated/
>  
> -# Generated lkdtm tests
> -/tools/testing/selftests/lkdtm/*.sh
> -!/tools/testing/selftests/lkdtm/run.sh
> -
>  # stgit generated dirs
>  patches-*
>  
> diff --git a/tools/testing/selftests/lkdtm/.gitignore b/tools/testing/selftests/lkdtm/.gitignore
> new file mode 100644
> index 000000000000..f26212605b6b
> --- /dev/null
> +++ b/tools/testing/selftests/lkdtm/.gitignore
> @@ -0,0 +1,2 @@
> +*.sh
> +!run.sh
> -- 
> 2.25.0
> 

-- 
Kees Cook
