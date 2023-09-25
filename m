Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAB17ACF6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 07:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjIYFWr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 01:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjIYFWq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 01:22:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3944CE8
        for <linux-kselftest@vger.kernel.org>; Sun, 24 Sep 2023 22:22:40 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a0c:5a83:9102:3700:bd4:e52c:2a6d:b605])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 814D766072FA;
        Mon, 25 Sep 2023 06:22:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695619358;
        bh=7iPw+lof6Y6viA/x8J5ZBg09te3O3iqr68ZPm8IIb6k=;
        h=From:To:Cc:Subject:References:In-reply-to:Date:From;
        b=mHyOfaPqH+jX6DE/zR7/zNmBLeK/0wK5xSKL4KP154mLCJhwNhZg5PUcNkJuP7D3Z
         i1CVZg9rs7AB9xSYaAQxArfk7PclFE0DxPJQrHhp4xJW/i9KrClf/ff8nWQbjYSEUH
         llNNScw1BHE1LXcjlOZNj9PBnFMvUCO7rOtffsAb4ymcS+7CMpLeGO2KjrCzQ+2H9l
         cDwTBlIuHkedHHiHrEQuwSwh88JXqD0o4XGjFNFirzQoeHECKF17M+gWqkejYMVGuo
         BvLMeCrYOqhI5ZbqB5fhQEK9+q3hQOzeOsj3jQtSXUclX8b1+9Q7ijDJrJUz4OwKYU
         iOWEx/cUcBZgQ==
From:   Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     shuah@kernel.org
Cc:     keescook@chromium.org, kernel@collabora.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests/lkdtm: Disable CONFIG_UBSAN_TRAP in test
 config
References: <20230802063252.1917997-1-ricardo.canuelo@collabora.com>
In-reply-to: <20230802063252.1917997-1-ricardo.canuelo@collabora.com>
Date:   Mon, 25 Sep 2023 07:22:35 +0200
Message-ID: <875y3yesis.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

Gentle ping for this, what's the merge status?

On mi=C3=A9, ago 02 2023 at 08:32:52, Ricardo Ca=C3=B1uelo <ricardo.canuelo=
@collabora.com> wrote:
> The lkdtm selftest config fragment enables CONFIG_UBSAN_TRAP to make the
> ARRAY_BOUNDS test kill the calling process when an out-of-bound access
> is detected by UBSAN. However, after this [1] commit, UBSAN is triggered
> under many new scenarios that weren't detected before, such as in struct
> definitions with fixed-size trailing arrays used as flexible arrays. As
> a result, CONFIG_UBSAN_TRAP=3Dy has become a very aggressive option to
> enable except for specific situations.
>
> `make kselftest-merge` applies CONFIG_UBSAN_TRAP=3Dy to the kernel config
> for all selftests, which makes many of them fail because of system hangs
> during boot.
>
> This change removes the config option from the lkdtm kselftest and
> configures the ARRAY_BOUNDS test to look for UBSAN reports rather than
> relying on the calling process being killed.
>
> [1] commit 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC")'
>
> Signed-off-by: Ricardo Ca=C3=B1uelo <ricardo.canuelo@collabora.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>
> Changelog:
>
> v2:
>   - Configure the ARRAY_BOUNDS lkdtm test to match UBSAN reports instead
>     of disabling the test
>
>  tools/testing/selftests/lkdtm/config    | 1 -
>  tools/testing/selftests/lkdtm/tests.txt | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftes=
ts/lkdtm/config
> index 5d52f64dfb43..7afe05e8c4d7 100644
> --- a/tools/testing/selftests/lkdtm/config
> +++ b/tools/testing/selftests/lkdtm/config
> @@ -9,7 +9,6 @@ CONFIG_INIT_ON_FREE_DEFAULT_ON=3Dy
>  CONFIG_INIT_ON_ALLOC_DEFAULT_ON=3Dy
>  CONFIG_UBSAN=3Dy
>  CONFIG_UBSAN_BOUNDS=3Dy
> -CONFIG_UBSAN_TRAP=3Dy
>  CONFIG_STACKPROTECTOR_STRONG=3Dy
>  CONFIG_SLUB_DEBUG=3Dy
>  CONFIG_SLUB_DEBUG_ON=3Dy
> diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/self=
tests/lkdtm/tests.txt
> index 607b8d7e3ea3..2f3a1b96da6e 100644
> --- a/tools/testing/selftests/lkdtm/tests.txt
> +++ b/tools/testing/selftests/lkdtm/tests.txt
> @@ -7,7 +7,7 @@ EXCEPTION
>  #EXHAUST_STACK Corrupts memory on failure
>  #CORRUPT_STACK Crashes entire system on success
>  #CORRUPT_STACK_STRONG Crashes entire system on success
> -ARRAY_BOUNDS
> +ARRAY_BOUNDS call trace:|UBSAN: array-index-out-of-bounds
>  CORRUPT_LIST_ADD list_add corruption
>  CORRUPT_LIST_DEL list_del corruption
>  STACK_GUARD_PAGE_LEADING
> --=20
> 2.25.1

Thanks,
Ricardo
