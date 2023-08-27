Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC58789C96
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 11:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjH0JXb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 05:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjH0JW6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 05:22:58 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE01103;
        Sun, 27 Aug 2023 02:22:53 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so33278681fa.1;
        Sun, 27 Aug 2023 02:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693128172; x=1693732972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qNhqWs/d0zkyUeFSgfgWVmmoGxegzXBKnT08Gh1c21U=;
        b=TRDcu2p6lschq1Tr9TYlFU3kqmn4ckpf4LNGfD0jskd8xacu5jBlJ+sbTrzYJQ7RJT
         J2LW5SvXE0C6PMS8Wwfh7Q/Cf/hdapvji53XkkAlkeHIUVSAMlBONfkvjBJ0gg9jkA+6
         5W8xt9C1PZ7BRkU2pFkHP+d7e0oceBP/GzwxF2apDsZ1vVnZIy+skBfxDEhp5xarqBfJ
         YVw0Gaf8RZtwNlfz8IHue7LsbDXXTjymWRp3xXtfVoDTb+igvJhGIEwPgDu92DQk/9c+
         tFiTNl8GfhSbmdG2NbpR1wZH8e5OCwcSAmSrxvupqcrK4OxgUvVPQcRoRvgy9RhAJ09f
         2qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693128172; x=1693732972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNhqWs/d0zkyUeFSgfgWVmmoGxegzXBKnT08Gh1c21U=;
        b=bWrylO6d2eJyQ8pNor1rRaA6Q4NbXKYVKpktcyXFsqvL/Z8ieZLgBHTMFReWCizNkA
         B/g+0iKbXJAsDCso4eJRPD7ZBf/XU6hknLU2Ik9PbPZLyPn1F/Rh/Li5SUSUkFvMoNAU
         XyjrlQVIyrg3Zj2urdgaTY976rUNbIH+MaEZAjG1/hScKewWqMK2MzZjFFlHSmDCQA4+
         UTqiCyFffDYGev7ZyEnRGVRBzmrocvWWvpbCUA1+dl68rm/HzrqKrkzQGC62+8SxLPze
         5/fNCgPWdVBngQ375KWKU1NlpFauBhn4F4mQT/hp9f41n1OomDwF53f0S5ZZrpKUZgAS
         tGmw==
X-Gm-Message-State: AOJu0YwiolgrGp2wnbOMQb93vdBKMh7EcnaoC0yIJPq2DMMWevbvBs4x
        6f143mSdcgdKaHzx2Uw3zn5/YVfrgyY=
X-Google-Smtp-Source: AGHT+IHA9IBI45SyYxSnIrWkF9Z0Z+HdS3NdyqFb7QvWI1T4E18iK8P2Qo8KEi8w/Y/UINyHKwJLQQ==
X-Received: by 2002:a2e:a201:0:b0:2b5:9d78:213e with SMTP id h1-20020a2ea201000000b002b59d78213emr16430998ljm.22.1693128171815;
        Sun, 27 Aug 2023 02:22:51 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id y1-20020adff6c1000000b00317e77106dbsm7013798wrp.48.2023.08.27.02.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 02:22:50 -0700 (PDT)
Date:   Sun, 27 Aug 2023 10:22:50 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: Re: [PATCH v5 3/7] selftests: mm: Fix failure case when new remap
 region was not found
Message-ID: <b7a1b930-2b02-4fd0-861b-cf0465c8d141@lucifer.local>
References: <20230822015501.791637-1-joel@joelfernandes.org>
 <20230822015501.791637-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822015501.791637-4-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 22, 2023 at 01:54:56AM +0000, Joel Fernandes (Google) wrote:
> When a valid remap region could not be found, the source mapping is not
> cleaned up. Fix the goto statement such that the clean up happens.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  tools/testing/selftests/mm/mremap_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
> index 5c3773de9f0f..6822d657f589 100644
> --- a/tools/testing/selftests/mm/mremap_test.c
> +++ b/tools/testing/selftests/mm/mremap_test.c
> @@ -316,7 +316,7 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
>  		if (addr + c.dest_alignment < addr) {
>  			ksft_print_msg("Couldn't find a valid region to remap to\n");
>  			ret = -1;
> -			goto out;
> +			goto clean_up_src;
>  		}
>  		addr += c.dest_alignment;
>  	}
> --
> 2.42.0.rc1.204.g551eb34607-goog
>

Nice spot!

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
