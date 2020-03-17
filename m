Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00EF9188EEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Mar 2020 21:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgCQUWy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Mar 2020 16:22:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46041 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgCQUWv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Mar 2020 16:22:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id m15so12331594pgv.12
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Mar 2020 13:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EAIJCbc9UnYGBhZAgTxjslTz10fA3gHJNpsPT5X0d/0=;
        b=jJwCjEtHgr13odNFCH9H9QGOK6qYtGJmi3Lff6ROgfMdrMnLhXjkrg29YHbzWopzmS
         02WMyKj3xIe8PhZaCZpLLVBE0XdXPKQtF/G5BDTxtU+8CD4Ixet9A3DgT/fPVZ7CrFBF
         rpsE+tU61HmBnrjEDwRzixtEsw65RA/HGhmhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EAIJCbc9UnYGBhZAgTxjslTz10fA3gHJNpsPT5X0d/0=;
        b=V1LRExMukMDdiMb0zU4NFIYOXtyXC4FX/vJVBfkfwBrQARBYRotBaQ7P/tLvaB41o0
         LwPrd157HjMC9wYr4SBqc/vls2jza6mQztMQA+Ucr1gDeuDX3+akoAm5mwql4Zs+iJ9V
         xwTf5KpIW7FmWGtN7FKGSEtMKBt+a2xOEqeymNMKVx4wgOIbatq9MzQllwPJbxm52tDs
         GkOjJcNtV2WrphIeR6BVvTrQDrYjwhgoWTjffx795sZcAXvfXaCC71B59CSIAzAQyZ5z
         N+X+3L/QxfRBQyievgkw327SCthQKVprEFx0uxNBMV5dJtbBEpIIEKHtyl/u4yB6MX/4
         2Zhg==
X-Gm-Message-State: ANhLgQ1Xnx90CyBekdv/TTLio2rlphJxlpdqbSshH4Zii1R727fgQdBx
        TUFKOm8vVUU8G2aeqpmWplW+0w==
X-Google-Smtp-Source: ADFU+vsgTPKpKOop85D3za3E34mi1V5jczJYrDVYLZp5wxLbhQu4/38ysB16lWDoiJeHKHqWdqEuEg==
X-Received: by 2002:a63:6944:: with SMTP id e65mr1017514pgc.406.1584476569477;
        Tue, 17 Mar 2020 13:22:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x189sm3965762pfb.1.2020.03.17.13.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 13:22:48 -0700 (PDT)
Date:   Tue, 17 Mar 2020 13:22:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, Tim.Bird@sony.com
Subject: Re: [PATCH v3 2/6] kselftest: factor out list manipulation to a
 helper
Message-ID: <202003171322.19433D7@keescook>
References: <20200316225647.3129354-1-kuba@kernel.org>
 <20200316225647.3129354-3-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316225647.3129354-3-kuba@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 16, 2020 at 03:56:42PM -0700, Jakub Kicinski wrote:
> Kees suggest to factor out the list append code to a macro,
> since following commits need it, which leads to code duplication.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/testing/selftests/kselftest_harness.h | 42 ++++++++++++---------
>  1 file changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 5336b26506ab..aaf58fffc8f7 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -631,6 +631,29 @@
>  	} \
>  } while (0); OPTIONAL_HANDLER(_assert)
>  
> +/* List helpers */
> +#define __LIST_APPEND(head, item) \
> +{ \
> +	/* Circular linked list where only prev is circular. */ \
> +	if (head == NULL) { \
> +		head = item; \
> +		item->next = NULL; \
> +		item->prev = item; \
> +		return;	\
> +	} \
> +	if (__constructor_order == _CONSTRUCTOR_ORDER_FORWARD) { \
> +		item->next = NULL; \
> +		item->prev = head->prev; \
> +		item->prev->next = item; \
> +		head->prev = item; \
> +	} else { \
> +		item->next = head; \
> +		item->next->prev = item; \
> +		item->prev = item; \
> +		head = item; \
> +	} \
> +}
> +
>  /* Contains all the information for test execution and status checking. */
>  struct __test_metadata {
>  	const char *name;
> @@ -665,24 +688,7 @@ static int __constructor_order;
>  static inline void __register_test(struct __test_metadata *t)
>  {
>  	__test_count++;
> -	/* Circular linked list where only prev is circular. */
> -	if (__test_list == NULL) {
> -		__test_list = t;
> -		t->next = NULL;
> -		t->prev = t;
> -		return;
> -	}
> -	if (__constructor_order == _CONSTRUCTOR_ORDER_FORWARD) {
> -		t->next = NULL;
> -		t->prev = __test_list->prev;
> -		t->prev->next = t;
> -		__test_list->prev = t;
> -	} else {
> -		t->next = __test_list;
> -		t->next->prev = t;
> -		t->prev = t;
> -		__test_list = t;
> -	}
> +	__LIST_APPEND(__test_list, t);
>  }
>  
>  static inline int __bail(int for_realz, bool no_print, __u8 step)
> -- 
> 2.24.1
> 

-- 
Kees Cook
