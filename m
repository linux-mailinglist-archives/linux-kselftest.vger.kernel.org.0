Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08851115E01
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Dec 2019 19:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfLGSnt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Dec 2019 13:43:49 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46285 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbfLGSnt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Dec 2019 13:43:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so4974927pgb.13
        for <linux-kselftest@vger.kernel.org>; Sat, 07 Dec 2019 10:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+L6zFZiOCC6s3vVJPWB84wzcdkOdhFhHtQ1nLq0bpuM=;
        b=afa0lMSHFh5UdI7/EvynqigpiWpQv8YcNdjWR9JtTBnJnTlbJZOjOF9Wg1zSHo9Uot
         5lLyfKLiSrAhdvK4K5ORn6aZfdiK8adgOgJvEQo0xOqasU3beTze35tkM8CNtrRlRLmp
         KCzy2gUrA3+omILuqCl2TyDE0lPjt81hUC5xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+L6zFZiOCC6s3vVJPWB84wzcdkOdhFhHtQ1nLq0bpuM=;
        b=S2gF9oUsZTZR7owZkx7IkWY01ojJdTBOYRk39+JLi8ZVYk8ORBPfPNZ8/T4a0BDfNx
         tUwrQAV5nFneWRIvF5Dv8B8pxGwmuXQ7oC8eW9Mt4AYGj0zZRSs3akkAhHptgrM7Z9rj
         JsxbTPCr58ejvl3vDDnqYO+Imb5JMqlZNAzp+YJ9HJu4YgD6mblTSOurE67Rl7lWEIjh
         Dyh+iHa8MHYtiBJZceRmPyX9NDZLmtX4LTXseb2N0vB76tWw7BVAurDUJoDLwhCiJIzE
         nojo6Go8gam3wXPhPWTQlKG40Ru0quE/5R567ViYO+pdXOhrcapAoyhEdM+6CSTvXlfx
         a02w==
X-Gm-Message-State: APjAAAVff0sCl1FeVdnOntRc+esZVJmOlA9QJnPLP4NVFgcDe6Jmdyhy
        /HOOEPTtifSE8KT6c4xgiGd0f50bViQ=
X-Google-Smtp-Source: APXvYqx/EaUOrmTLzrGwRxgfNmy4XTVfSP1F7Ul7mDLQJV0oQcs9ZIxOJl+lEsqQZgGd6Hj8SL8zKQ==
X-Received: by 2002:a65:56c6:: with SMTP id w6mr10593574pgs.167.1575744228706;
        Sat, 07 Dec 2019 10:43:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s19sm4146691pgs.42.2019.12.07.10.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 10:43:47 -0800 (PST)
Date:   Sat, 7 Dec 2019 10:43:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: Fix dangling documentation references to
 kselftest_module.sh
Message-ID: <201912071043.748BB5A6@keescook>
References: <20191206031738.29641-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206031738.29641-1-mpe@ellerman.id.au>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Dec 06, 2019 at 02:17:38PM +1100, Michael Ellerman wrote:
> Commit c78fd76f2b67 ("selftests: Move kselftest_module.sh into
> kselftest/") moved kselftest_module.sh but missed updating a few
> references to the path in documentation.
> 
> Fixes: c78fd76f2b67 ("selftests: Move kselftest_module.sh into kselftest/")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Whoops! Thank you! :)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  Documentation/dev-tools/kselftest.rst       | 8 ++++----
>  tools/testing/selftests/kselftest/module.sh | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index ecdfdc9d4b03..61ae13c44f91 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -203,12 +203,12 @@ Test Module
>  Kselftest tests the kernel from userspace.  Sometimes things need
>  testing from within the kernel, one method of doing this is to create a
>  test module.  We can tie the module into the kselftest framework by
> -using a shell script test runner.  ``kselftest_module.sh`` is designed
> +using a shell script test runner.  ``kselftest/module.sh`` is designed
>  to facilitate this process.  There is also a header file provided to
>  assist writing kernel modules that are for use with kselftest:
>  
>  - ``tools/testing/kselftest/kselftest_module.h``
> -- ``tools/testing/kselftest/kselftest_module.sh``
> +- ``tools/testing/kselftest/kselftest/module.sh``
>  
>  How to use
>  ----------
> @@ -247,7 +247,7 @@ Example Module
>  
>     #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> -   #include "../tools/testing/selftests/kselftest_module.h"
> +   #include "../tools/testing/selftests/kselftest/module.h"
>  
>     KSTM_MODULE_GLOBALS();
>  
> @@ -276,7 +276,7 @@ Example test script
>  
>      #!/bin/bash
>      # SPDX-License-Identifier: GPL-2.0+
> -    $(dirname $0)/../kselftest_module.sh "foo" test_foo
> +    $(dirname $0)/../kselftest/module.sh "foo" test_foo
>  
>  
>  Test Harness
> diff --git a/tools/testing/selftests/kselftest/module.sh b/tools/testing/selftests/kselftest/module.sh
> index 18e1c7992d30..fb4733faff12 100755
> --- a/tools/testing/selftests/kselftest/module.sh
> +++ b/tools/testing/selftests/kselftest/module.sh
> @@ -9,7 +9,7 @@
>  #
>  #   #!/bin/sh
>  #   SPDX-License-Identifier: GPL-2.0+
> -#   $(dirname $0)/../kselftest_module.sh "description" module_name
> +#   $(dirname $0)/../kselftest/module.sh "description" module_name
>  #
>  # Example: tools/testing/selftests/lib/printf.sh
>  
> -- 
> 2.21.0
> 

-- 
Kees Cook
