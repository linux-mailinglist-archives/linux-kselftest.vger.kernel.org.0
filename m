Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C345F723AB9
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbjFFH4Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbjFFH4J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:56:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC661996;
        Tue,  6 Jun 2023 00:53:10 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2D2976602242;
        Tue,  6 Jun 2023 08:52:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686037956;
        bh=j1EWBkFi5Oo0lOidCccc2BK+myhe5O4akpfx+JJKX5w=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=jAkAVrqqkEVUG4RS2qY/e+bX8HSWovJ0itQPLLCnQTTV8XSYfkJ0AOhoy2iNN6hd9
         QZXzXI5Vu/85VC/90uXOVfla310N38RyQ996QWYcArunSk31It54pXO4wwy4EajeKg
         zRfNhTam7yxdjgs5rSaLjpiIeHTR7Ly6RzewU3iSF3hbB+2DBsJUfdhFSI/TAySMi4
         Z82/muRQJBDqsEYgiL6xRxBqpcq6j/PpLkc6xtGzjzEOjVbJmhxdECUW0whT1oOo/1
         8wihCTZbCQgXraNqbB0f7kmPnqG6kyTobInJYwlow22n7tYdxfP9iD5dW/IWksEk1y
         c92Ephgj4Pk8A==
Message-ID: <2195e1c9-1e0e-cad9-2f9c-34a43a8d0bba@collabora.com>
Date:   Tue, 6 Jun 2023 12:52:30 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/11] selftests/mm: .gitignore: add mkdirty,
 va_high_addr_switch
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-6-jhubbard@nvidia.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230606071637.267103-6-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/6/23 12:16 PM, John Hubbard wrote:
> These new build products were left out of .gitignore, so add them now.
I'd added to the instructions that object files should be added to
.gitignore. But still sometimes people forget.

> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index 8917455f4f51..ab215303d8e9 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -39,3 +39,5 @@ local_config.h
>  local_config.mk
>  ksm_functional_tests
>  mdwe_test
> +mkdirty
> +va_high_addr_switch
> \ No newline at end of file

-- 
BR,
Muhammad Usama Anjum
