Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AE05F02A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 04:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiI3COm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 22:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiI3COl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 22:14:41 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5481BEB9;
        Thu, 29 Sep 2022 19:14:39 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id bh13so2992382pgb.4;
        Thu, 29 Sep 2022 19:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date;
        bh=lLC8K4nRnsl5U/vNrB7tvUjtP1pEP3tJzxbKNOWOaa0=;
        b=l80gBuNO60aUcg0AEH+KBH1V+DmyxQ6FIQQ+f4pKfftJ5tZBNxgRmgrEpPZIG0bHZw
         sy+nWTKx7WoXrJ6REJjTVYUZt4981cNjM7LYUnIOHuP1ei89Z6hGxXe3eN1BKh00xY+O
         5BbxBCnn2DwuY+YI70waBPkLssQehPR4s3rKOqeUCiJFkUCyxIJwTxr+ie47NeNyn9m1
         ZV9uz5djRecQX8k2xfIqrng4/LHAmxBgwPzlWPWRK5jKhy7Y44odgpI4NfarQuWUEohP
         ZDwOx4Uhq5kHn0a2kbmZt9R++DyMfirfxlpBIYokNZEzfhzCfj5ZSKBqxdFW1PtngdxQ
         gchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=lLC8K4nRnsl5U/vNrB7tvUjtP1pEP3tJzxbKNOWOaa0=;
        b=Irbgn8R1ayAgWhGIqD8w8GNGeJKYnKcc6fhHCZ8+gfWaDamvmcqiLYRfAK2zUdLlIi
         rV5wiI1CdZLoa7Y5frkt4YrvhlMhb3AercljTc6fsLQvOUycTZeD3WWCI0nbvKOWrlZa
         plwFnwyDMC4a+RpUNaTYCyUDOCEBp01sUU5zJotsC0U3DoTzBe3YjJpqUI4xGq022cs1
         4i5DX+VxcUxCzg3zZhyQAdmFi6zneC3YSjQRprOLmx3KzzhccruIQkzUCkQawziyV7F3
         9ype5/GwGn2YwxkuWVwZyWvj653SKZBCKF4tskUqyeY1XPezLtAQSDSl+uIeUP1PqUQY
         7Y4w==
X-Gm-Message-State: ACrzQf2so9SZ5kjHa169CqFKm+dkZpaGAt9X+l9SP1PQEbGy5s34MeFS
        3Bu6OQymNXEzwULr2LtgTsOkdkJB+3A=
X-Google-Smtp-Source: AMsMyM4fpQEOKdgBJ/cptg5aRnU4TIPbMdcG7339U+6wxrvVI03Rn1XUFC8eWe+5iVdfRHiS5I3DSw==
X-Received: by 2002:a63:1a51:0:b0:43b:e496:f2f4 with SMTP id a17-20020a631a51000000b0043be496f2f4mr5703738pgm.99.1664504079257;
        Thu, 29 Sep 2022 19:14:39 -0700 (PDT)
Received: from localhost ([98.97.42.14])
        by smtp.gmail.com with ESMTPSA id 193-20020a6304ca000000b00438c0571456sm608904pge.24.2022.09.29.19.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 19:14:38 -0700 (PDT)
Date:   Thu, 29 Sep 2022 19:14:37 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <6336510da9fe_233df20894@john.notmuch>
In-Reply-To: <20220928221555.67873-1-colin.i.king@gmail.com>
References: <20220928221555.67873-1-colin.i.king@gmail.com>
Subject: RE: [PATCH] selftests/bpf: Fix spelling mistake "unpriviledged" ->
 "unprivileged"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Colin Ian King wrote:
> There a couple of spelling mistakes, one in a literal string and one
> in a comment. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  tools/testing/selftests/bpf/verifier/calls.c   | 2 +-
>  tools/testing/selftests/bpf/verifier/var_off.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> index 3fb4f69b1962..e1a937277b54 100644
> --- a/tools/testing/selftests/bpf/verifier/calls.c
> +++ b/tools/testing/selftests/bpf/verifier/calls.c
> @@ -284,7 +284,7 @@
>  	.result = ACCEPT,
>  },
>  {
> -	"calls: not on unpriviledged",
> +	"calls: not on unprivileged",
>  	.insns = {
>  	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 1, 0, 2),
>  	BPF_MOV64_IMM(BPF_REG_0, 1),
> diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
> index 187c6f6e32bc..d37f512fad16 100644
> --- a/tools/testing/selftests/bpf/verifier/var_off.c
> +++ b/tools/testing/selftests/bpf/verifier/var_off.c
> @@ -121,7 +121,7 @@
>  	BPF_EXIT_INSN(),
>  	},
>  	.fixup_map_hash_8b = { 1 },
> -	/* The unpriviledged case is not too interesting; variable
> +	/* The unprivileged case is not too interesting; variable
>  	 * stack access is rejected.
>  	 */
>  	.errstr_unpriv = "R2 variable stack access prohibited for !root",
> -- 
> 2.37.1
> 

Sure, but bpf-next.

Acked-by: John Fastabend <john.fastabend@gmail.com>
