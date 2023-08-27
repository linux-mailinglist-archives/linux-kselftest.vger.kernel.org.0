Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB1D789CAE
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Aug 2023 11:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjH0JgK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Aug 2023 05:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjH0JgG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Aug 2023 05:36:06 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B749E1;
        Sun, 27 Aug 2023 02:36:04 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31ad779e6b3so1821299f8f.2;
        Sun, 27 Aug 2023 02:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693128963; x=1693733763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fyYjmY98zomYavB/RlCzc0eyVUey0K4QOLVItcmvGAc=;
        b=Hvd0U2tvPIpgsz9Xf3eRylrJ25hItwSoK9O54JcTOFINLLgSA11Kt2K1sOAEFOg01/
         NkIHTVUJ6JTXbfRkr/M1qMIkCY3u0ehM90Xg1ZiSrjaM44kSK3weoqDBRRu4HrN4qR4h
         ZjbqlG2Qo8ey9kJXtCPHdv68aP2dkTPgKEatQ/xNZGzeYIlbasBggK0UlO0CCw+xsbBQ
         XCuN3HPspRtJQ70GPiLi+GyvL/JjFDfS/vtpPABISMNAzpsrLYFCWdNQS0P4KkhAOR54
         9QqCRYFYgdZOqUYTTJ6rRj+49VgkqmbN3RchLlenCAuQW06FBU6CqLk5nD3FPC5sD6xM
         fPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693128963; x=1693733763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyYjmY98zomYavB/RlCzc0eyVUey0K4QOLVItcmvGAc=;
        b=QleO1Qjzi00sXs9PEtVE9sXs9fXPqa/vTg9CgpXJfbr7wpW9oG93ihR5dF+/rP8Bj+
         LjWcqhLIlEkBUVNQVz1H0BPRY7xDOGb8E92T8LkFkwqBjoE5fUQFLwyXv3myREeOyK5e
         /5YDa7lKdrqb5ffUrqpsQjdqeTOhn4oYEhyR07xpjrmPDNT7g5APH3RePpVIKrZcL6qj
         tglxDHIPgpI1HjTRIyyfJJM3XYV6wsrmAVpJoPfOrYdcWpc/hHaFrzmbcPGuyGbvi6kE
         JCMKS6zcl6mGbH/fReMyr8I4WOjlKnJ8Kx1/sCQ6Z1E2rSOwO7gZreWNav5+jOpCBuBl
         mltg==
X-Gm-Message-State: AOJu0YwnyxBxpSI2uyZhJmsCqn6WF5y2S4lToZ7l6LdMdk2m2ZnVdSzW
        xEi9hNY3KQK8tMAnaj5BooS/3TsWX+o=
X-Google-Smtp-Source: AGHT+IEMWxi1eDxTy9m+kQuSIMn7V0I0RfSF7wi6LfJdtyy6Sa1BJ78Dz5FU+zo3YLeY8TIeZucwHg==
X-Received: by 2002:a5d:684b:0:b0:317:597b:9f92 with SMTP id o11-20020a5d684b000000b00317597b9f92mr17146099wrw.57.1693128962699;
        Sun, 27 Aug 2023 02:36:02 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id e8-20020a5d5948000000b003143add4396sm7083184wri.22.2023.08.27.02.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 02:36:01 -0700 (PDT)
Date:   Sun, 27 Aug 2023 10:36:00 +0100
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
Subject: Re: [PATCH v5 4/7] selftests: mm: Add a test for mutually aligned
 moves > PMD size
Message-ID: <fb29e16f-ed90-483a-a020-0e10a2ef58a1@lucifer.local>
References: <20230822015501.791637-1-joel@joelfernandes.org>
 <20230822015501.791637-5-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822015501.791637-5-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 22, 2023 at 01:54:57AM +0000, Joel Fernandes (Google) wrote:
> This patch adds a test case to check if a PMD-alignment optimization
> successfully happens.
>
> I add support to make sure there is some room before the source mapping,
> otherwise the optimization to trigger PMD-aligned move will be disabled
> as the kernel will detect that a mapping before the source exists and
> such optimization becomes impossible.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  tools/testing/selftests/mm/mremap_test.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
> index 6822d657f589..6304eb0947a3 100644
> --- a/tools/testing/selftests/mm/mremap_test.c
> +++ b/tools/testing/selftests/mm/mremap_test.c
> @@ -44,6 +44,7 @@ enum {
>  	_1MB = 1ULL << 20,
>  	_2MB = 2ULL << 20,
>  	_4MB = 4ULL << 20,
> +	_5MB = 5ULL << 20,
>  	_1GB = 1ULL << 30,
>  	_2GB = 2ULL << 30,
>  	PMD = _2MB,
> @@ -235,6 +236,11 @@ static void *get_source_mapping(struct config c)
>  	unsigned long long mmap_min_addr;
>
>  	mmap_min_addr = get_mmap_min_addr();
> +	/*
> +	 * For some tests, we need to not have any mappings below the
> +	 * source mapping. Add some headroom to mmap_min_addr for this.
> +	 */
> +	mmap_min_addr += 10 * _4MB;

To be super nitty, you _in theory_ can't necessarily rely on arbitrary VAs
being available even ones at a location that is the very opposite of where
mappings will go by default.

I guess the _ideal_ solution would be to PROT_NONE map a range to ensure
it's there then munmap() bits you don't want to exist, but that'd involve
reworking this whole test and yeah, not worth it.

>
>  retry:
>  	addr += c.src_alignment;
> @@ -434,7 +440,7 @@ static int parse_args(int argc, char **argv, unsigned int *threshold_mb,
>  	return 0;
>  }
>
> -#define MAX_TEST 13
> +#define MAX_TEST 14
>  #define MAX_PERF_TEST 3
>  int main(int argc, char **argv)
>  {
> @@ -500,6 +506,10 @@ int main(int argc, char **argv)
>  	test_cases[12] = MAKE_TEST(PUD, PUD, _2GB, NON_OVERLAPPING, EXPECT_SUCCESS,
>  				   "2GB mremap - Source PUD-aligned, Destination PUD-aligned");
>
> +	/* Src and Dest addr 1MB aligned. 5MB mremap. */
> +	test_cases[13] = MAKE_TEST(_1MB, _1MB, _5MB, NON_OVERLAPPING, EXPECT_SUCCESS,
> +				  "5MB mremap - Source 1MB-aligned, Destination 1MB-aligned");
> +
>  	perf_test_cases[0] =  MAKE_TEST(page_size, page_size, _1GB, NON_OVERLAPPING, EXPECT_SUCCESS,
>  					"1GB mremap - Source PTE-aligned, Destination PTE-aligned");
>  	/*
> --
> 2.42.0.rc1.204.g551eb34607-goog
>

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
