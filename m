Return-Path: <linux-kselftest+bounces-17138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D64896C1F0
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 17:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F617B23FCF
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD271DCB27;
	Wed,  4 Sep 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PabtsFi/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3FC1DB94D;
	Wed,  4 Sep 2024 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462778; cv=none; b=r7w711SPJQx+2a02OvU+V8deLPzUmgeQ5dxsKXxG8mUgg74/b+qkqHG0SSXeWn4gQQKouJ1I7BuOblOdmBkTmYACBoYrIO7Ipk/eGz/EYPiMWhBvrO0ex6YTcdz91eqI4/Ibgi2wX3rWIbJKG10Y+ev0MizpLJYcmYTFJVLsyus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462778; c=relaxed/simple;
	bh=kh8RTaRVZ/bzPiXFHU1eSBiytlZ/8/MrWF9+zRKngEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XH9e+dWb6gCQ7XVUVxqq4LxVNrbFxgZnsbHEnF0GyBLoiOr8lY61B2Q0rFrkJxMZ5B9DsnltpXgEa7+rsNQWE8NgKcY9jSDO5+f0/WFhNmsMkeg8kTPa5I4zMAvzqJcKVJe/qRTO0tKKyZDEhNW6/R/J/2bgZKSfWymHMbMGydU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PabtsFi/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bb81e795bso54831025e9.1;
        Wed, 04 Sep 2024 08:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725462775; x=1726067575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txNXksKNnr5CcQmhvZpAfXPbym/UdfLQWjik9aFGQpg=;
        b=PabtsFi/3LGU0NL/SphGpMdVDmlo9Su3RumXGMj7WEWNlYmtzjyNOYZzls7T/6LjFl
         rL/Yn+14KYdKp600z2IxCV6Bpj7epwhNrXBKwmWm+xTOjUXMec1a1YdfEZDLaxQ90wIL
         iVaR5iXybVPIt4zOS5DhKP4RBZb2ziu06K6Ow9qrsw+xX8Th2UdNuQvqcPfVkT4oiXer
         IkE3VLjovvR1eBEqVDjz3U3rGJEcmo3nEokeeF3nxjQFeVqb+Rgm6wL+Cn2G3EJxrRNV
         IJ0bt9kYpPgwAcBBMzCFaqADRtza2IQZtoR5OxY+UYz6bQ2Ik2EQUGbMTXo9oTGTq29L
         ZMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462775; x=1726067575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txNXksKNnr5CcQmhvZpAfXPbym/UdfLQWjik9aFGQpg=;
        b=AUgAgcIfklw0djgls5FBPaoKhCr2YJ4Le0vBaU3t1SNRfXqtNYvgI4395SPVm8NUl1
         sVVo9tlBiXv53RLBE6zKxDNS/AbKfVSmfVpqx2zVQ7kdGOe0HfGZwcbCofL8p/luDs4z
         wTwP3Ce4FoweT10Fdd4Z2NRhkBZxrd6/4bfFbEf6CTWgTgS7C9zEOgfgUnVDQy5Jfrmz
         0s9ZQphFdb3TKuf5bjHlEHBbIshoU94OTp/0EtjqiWd4xrjJjnTSs5gg7Ng7LUVvek14
         KRQ8/MDN7cij17QOevaH12Es33U0UZfOtUF54lf/teE8d7PyOXuxZmOKI2z6oJgWLi5v
         4N6g==
X-Forwarded-Encrypted: i=1; AJvYcCV2XErtyuWj7rOTytBmNQX72sgUVFOTJn94RETe02JPr8JxgpyHakrAa8CrR7Wo37nqGBH9q+HEmlCCMEZXERnk@vger.kernel.org, AJvYcCXTOqyYPvDbKiVawZ1s8My/p6KaiP37Fzqeq0qb0LMy8LXTIMHzQ/YM1Ax/zTAk/tI8tJq0gJpnGhJOE+Q=@vger.kernel.org, AJvYcCXpVjjE977e8XqnB1KIllrXWIcAP5M+p6RLVrBQeGh362fftOtMUVkkDWkAPMPqRlF2Mqwp2u7D@vger.kernel.org
X-Gm-Message-State: AOJu0YxeK6SYJrECbD4ShNySPquCj/smmkwfET4ReRZaNtfq92EICi3q
	Ea6JjMS+xsJa5ch8LKKes3I9lmcKe8biqnDJbI92ZMVuwDLbRca5mEeUeTFSYNSprgIKfEnZA6m
	aT4PmdsiOBADdw6X/tBYkxINfCi7eVsXj
X-Google-Smtp-Source: AGHT+IFgy1TZEAQFZHztxlV15qG5NfTjA0UR0zIDatCD8i3rg2377HVbpyopn1HUD2u1Kv2zYWf5Z5LZrhRvSK8H1GU=
X-Received: by 2002:a5d:5ccc:0:b0:374:cd3e:7d98 with SMTP id
 ffacd0b85a97d-374cd3e8008mr5730376f8f.19.1725462775162; Wed, 04 Sep 2024
 08:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902120314.508180-1-linyunsheng@huawei.com> <20240902120314.508180-2-linyunsheng@huawei.com>
In-Reply-To: <20240902120314.508180-2-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 4 Sep 2024 08:12:17 -0700
Message-ID: <CAKgT0UfvFT=qznn_CAM1fN5AqrcOUjfTTu4qHzXioXfNG_ViFg@mail.gmail.com>
Subject: Re: [PATCH net-next v17 01/14] mm: page_frag: add a test module for page_frag
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 5:09=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> The testing is done by ensuring that the fragment allocated
> from a frag_frag_cache instance is pushed into a ptr_ring
> instance in a kthread binded to a specified cpu, and a kthread
> binded to a specified cpu will pop the fragment from the
> ptr_ring and free the fragment.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  tools/testing/selftests/mm/Makefile           |   3 +
>  tools/testing/selftests/mm/page_frag/Makefile |  18 ++
>  .../selftests/mm/page_frag/page_frag_test.c   | 170 +++++++++++++++++
>  tools/testing/selftests/mm/run_vmtests.sh     |   8 +
>  tools/testing/selftests/mm/test_page_frag.sh  | 171 ++++++++++++++++++
>  5 files changed, 370 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/page_frag/Makefile
>  create mode 100644 tools/testing/selftests/mm/page_frag/page_frag_test.c
>  create mode 100755 tools/testing/selftests/mm/test_page_frag.sh
>

...

> diff --git a/tools/testing/selftests/mm/test_page_frag.sh b/tools/testing=
/selftests/mm/test_page_frag.sh
> new file mode 100755
> index 000000000000..d2b0734a90b5
> --- /dev/null
> +++ b/tools/testing/selftests/mm/test_page_frag.sh
> @@ -0,0 +1,171 @@

...

> +check_test_requirements()
> +{
> +       uid=3D$(id -u)
> +       if [ $uid -ne 0 ]; then
> +               echo "$0: Must be run as root"
> +               exit $ksft_skip
> +       fi
> +
> +       if ! which insmod > /dev/null 2>&1; then
> +               echo "$0: You need insmod installed"
> +               exit $ksft_skip
> +       fi
> +
> +       if [ ! -f $DRIVER ]; then
> +               echo "$0: You need to compile page_frag_test module"
> +               exit $ksft_skip
> +       fi
> +}
> +
> +run_nonaligned_check()
> +{
> +       echo "Run performance tests to evaluate how fast nonaligned alloc=
 API is."
> +
> +       insmod $DRIVER $NONALIGNED_PARAM > /dev/null 2>&1
> +       echo "Done."
> +       echo "Ccheck the kernel ring buffer to see the summary."

Typo, should be "Check".

> +}
> +
> +run_aligned_check()
> +{
> +       echo "Run performance tests to evaluate how fast aligned alloc AP=
I is."
> +
> +       insmod $DRIVER $ALIGNED_PARAM > /dev/null 2>&1
> +       echo "Done."
> +       echo "Check the kernel ring buffer to see the summary."
> +}
> +

Other than the one typo it looks fine to me.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

