Return-Path: <linux-kselftest+bounces-11645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA6B902F86
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 06:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEA031F234F3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 04:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7511170829;
	Tue, 11 Jun 2024 04:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LETOhCIo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F116FF5F
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 04:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718080072; cv=none; b=n1x8Deqv5NGHLwndxdZ5MekZD2jCFup51XzXmlH+RfLGGyfhfcXyHDvmiSmhYgQAtqiFCk1oONez6SAGGOxUnzkLOVnGh29lW8xgDIfhNfggMz8A6hEeFq4gCqOxyrBYPQlriF/3GgamBuXFrmXGPtFp637abc85LtIPVWcqc/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718080072; c=relaxed/simple;
	bh=R11Fz8CMWAdSmi2lcWYQk27qmS1GHLlt16YLGoG5YaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gM8Um648ZvZJ0Eys6htqRL7FDldyCaGiasUe2gKEF7heVpn1HuK8XXzEmdZLf94ubRrhtAmMZXVrbMdiVMhqnKNUY25WDU4NBww4W4bn1+70uUvSDvpepOXvoA+w1HWlS8faQcM+NMM0BqBqBZKMG/SFOvRZYcGgwAjBLJlst8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LETOhCIo; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-254c22faf4cso824968fac.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 21:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718080070; x=1718684870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tkT2r/H8bywOCL29jQ9dOiEqES2E4TnDM1Uu+21t2c=;
        b=LETOhCIoLtfI1D3itdfNcKXGqQZRgY0qeVa+hrjA5EEv2qVlHM/kf3qmROA+ImAYIl
         Six/SRUIcmT5RNUZrO8tHNriknG9K9eFzbZf69gkXa7Acg/Nd1n1tNmS9R6pUAz4+rGo
         qxKQwe0oSZvLJ3qwf/JNNybsl8xcNeLnYiHaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718080070; x=1718684870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tkT2r/H8bywOCL29jQ9dOiEqES2E4TnDM1Uu+21t2c=;
        b=dvoE34/CIK4OEJdzLhXo5i1Z54yUDb7WFJf0h9U71ASDROGNGYwFpUbveLCX5fHeWk
         ztjfCNh0oy5IWELI/Zgup4TmPuOEiu5KokeGlCRzM4VLCcVswxOvdwqiGE695G+m9Y+f
         PTmLxBLiygatMt1AM2+nCweEbz3+8MFOHP/MapE79z4CWTB/AVk/Exjxn7lb6BqADegt
         YhjFulPy3qWlLOZzoiT1TRv83aSfqDcRO2RRjV3mzorHuAY/ckpCWpdTQfx+ozq5a/7H
         hs64hNHxCeScDYD/kcGPIePS8CRNYb8ja6g24LrmN19MLtC5/l1gt2WMoodKz887DXiL
         6tRA==
X-Forwarded-Encrypted: i=1; AJvYcCWLbIcfn9BDyQ86R7xq7jz8crX7b4h3P5HQEXMnSVu5ZuM2+9+6mPc1Q74P+sGgU4lYPdCWjTyI42wizZJOZHNzCxkQ87EqD0PvmRqf2cNR
X-Gm-Message-State: AOJu0YyD3Z6loCzcdW6ZXyrxZX/pyMwWop7PXqeN5b6U1ravThXTAPxS
	OTlTglFTY/KYyXMsCFGfu128ya99bcWB6sStOdV6z2oJejCtuVoN0D1xqDGP93ZTc+WqxewUVtd
	2Di4bhRRi5zsGmgkSJB46afNDJZNZWLnoX0pB
X-Google-Smtp-Source: AGHT+IGvwQIkjiBkVYzpGSHTTqzmipObtEx9jWLxFxS1ErZDL3K0AvJpjFZrfUag8P1aiWtGde0J9gLS6s3SgZZN50Y=
X-Received: by 2002:a05:6871:729:b0:254:8a91:4b71 with SMTP id
 586e51a60fabf-2548a916a59mr10122918fac.56.1718080069954; Mon, 10 Jun 2024
 21:27:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608021023.176027-1-jhubbard@nvidia.com> <20240608021023.176027-6-jhubbard@nvidia.com>
In-Reply-To: <20240608021023.176027-6-jhubbard@nvidia.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 10 Jun 2024 21:27:39 -0700
Message-ID: <CABi2SkUnQQC4cXhwV6BN==umEFsNpFRptxMKy3bHthPUv+pXwA@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/mm: mseal, self_elf: rename TEST_END_CHECK
 to REPORT_TEST_PASS
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Andrei Vagin <avagin@google.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Peter Xu <peterx@redhat.com>, 
	Rich Felker <dalias@libc.org>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Jun 7, 2024 at 7:10=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> Now that the test macros are factored out into their final location, and
> simplified, it's time to rename TEST_END_CHECK to something that
> represents its new functionality: REPORT_TEST_PASS.
>
> Cc: Jeff Xu <jeffxu@chromium.org>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Jeff Xu <jeffxu@chromium.org>
Tested-by: Jeff Xu <jeffxu@chromium.org>

> ---
>  tools/testing/selftests/mm/mseal_helpers.h |  2 +-
>  tools/testing/selftests/mm/mseal_test.c    | 92 +++++++++++-----------
>  tools/testing/selftests/mm/seal_elf.c      |  2 +-
>  3 files changed, 48 insertions(+), 48 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/mseal_helpers.h b/tools/testing/s=
elftests/mm/mseal_helpers.h
> index 8c3bf77dcf19..65ece62fdd0c 100644
> --- a/tools/testing/selftests/mm/mseal_helpers.h
> +++ b/tools/testing/selftests/mm/mseal_helpers.h
> @@ -22,7 +22,7 @@
>                 }                                                       \
>         } while (0)
>
> -#define TEST_END_CHECK() ksft_test_result_pass("%s\n", __func__)
> +#define REPORT_TEST_PASS() ksft_test_result_pass("%s\n", __func__)
>
>  #ifndef PKEY_DISABLE_ACCESS
>  #define PKEY_DISABLE_ACCESS    0x1
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/self=
tests/mm/mseal_test.c
> index a29935d82027..f8e1c59f298e 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -240,7 +240,7 @@ static void test_seal_addseal(void)
>         ret =3D sys_mseal(ptr, size);
>         FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_unmapped_start(void)
> @@ -268,7 +268,7 @@ static void test_seal_unmapped_start(void)
>         ret =3D sys_mseal(ptr + 2 * page_size, 2 * page_size);
>         FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_unmapped_middle(void)
> @@ -300,7 +300,7 @@ static void test_seal_unmapped_middle(void)
>         ret =3D sys_mseal(ptr + 3 * page_size, page_size);
>         FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_unmapped_end(void)
> @@ -329,7 +329,7 @@ static void test_seal_unmapped_end(void)
>         ret =3D sys_mseal(ptr, 2 * page_size);
>         FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_multiple_vmas(void)
> @@ -360,7 +360,7 @@ static void test_seal_multiple_vmas(void)
>         ret =3D sys_mseal(ptr, size);
>         FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_split_start(void)
> @@ -385,7 +385,7 @@ static void test_seal_split_start(void)
>         ret =3D sys_mseal(ptr + page_size, 3 * page_size);
>         FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_split_end(void)
> @@ -410,7 +410,7 @@ static void test_seal_split_end(void)
>         ret =3D sys_mseal(ptr, 3 * page_size);
>         FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_invalid_input(void)
> @@ -445,7 +445,7 @@ static void test_seal_invalid_input(void)
>         ret =3D sys_mseal(ptr - page_size, 5 * page_size);
>         FAIL_TEST_IF_FALSE(ret < 0);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_zero_length(void)
> @@ -469,7 +469,7 @@ static void test_seal_zero_length(void)
>         ret =3D sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
>         FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_zero_address(void)
> @@ -495,7 +495,7 @@ static void test_seal_zero_address(void)
>         ret =3D sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
>         FAIL_TEST_IF_FALSE(ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_twice(void)
> @@ -515,7 +515,7 @@ static void test_seal_twice(void)
>         ret =3D sys_mseal(ptr, size);
>         FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mprotect(bool seal)
> @@ -539,7 +539,7 @@ static void test_seal_mprotect(bool seal)
>         else
>                 FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_start_mprotect(bool seal)
> @@ -569,7 +569,7 @@ static void test_seal_start_mprotect(bool seal)
>                         PROT_READ | PROT_WRITE);
>         FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_end_mprotect(bool seal)
> @@ -599,7 +599,7 @@ static void test_seal_end_mprotect(bool seal)
>         else
>                 FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mprotect_unalign_len(bool seal)
> @@ -628,7 +628,7 @@ static void test_seal_mprotect_unalign_len(bool seal)
>                         PROT_READ | PROT_WRITE);
>         FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mprotect_unalign_len_variant_2(bool seal)
> @@ -656,7 +656,7 @@ static void test_seal_mprotect_unalign_len_variant_2(=
bool seal)
>                         PROT_READ | PROT_WRITE);
>         FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mprotect_two_vma(bool seal)
> @@ -691,7 +691,7 @@ static void test_seal_mprotect_two_vma(bool seal)
>         else
>                 FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mprotect_two_vma_with_split(bool seal)
> @@ -738,7 +738,7 @@ static void test_seal_mprotect_two_vma_with_split(boo=
l seal)
>                         PROT_READ | PROT_WRITE);
>         FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mprotect_partial_mprotect(bool seal)
> @@ -764,7 +764,7 @@ static void test_seal_mprotect_partial_mprotect(bool =
seal)
>         else
>                 FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mprotect_two_vma_with_gap(bool seal)
> @@ -807,7 +807,7 @@ static void test_seal_mprotect_two_vma_with_gap(bool =
seal)
>         ret =3D sys_mprotect(ptr + 3 * page_size, page_size, PROT_READ);
>         FAIL_TEST_IF_FALSE(ret =3D=3D 0);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mprotect_split(bool seal)
> @@ -844,7 +844,7 @@ static void test_seal_mprotect_split(bool seal)
>         else
>                 FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mprotect_merge(bool seal)
> @@ -878,7 +878,7 @@ static void test_seal_mprotect_merge(bool seal)
>         ret =3D sys_mprotect(ptr + 2 * page_size, 2 * page_size, PROT_REA=
D);
>         FAIL_TEST_IF_FALSE(ret =3D=3D 0);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_munmap(bool seal)
> @@ -903,7 +903,7 @@ static void test_seal_munmap(bool seal)
>         else
>                 FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  /*
> @@ -943,7 +943,7 @@ static void test_seal_munmap_two_vma(bool seal)
>         else
>                 FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  /*
> @@ -981,7 +981,7 @@ static void test_seal_munmap_vma_with_gap(bool seal)
>         ret =3D sys_munmap(ptr, size);
>         FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_munmap_start_freed(bool seal)
> @@ -1021,7 +1021,7 @@ static void test_munmap_start_freed(bool seal)
>                 FAIL_TEST_IF_FALSE(size =3D=3D 0);
>         }
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_munmap_end_freed(bool seal)
> @@ -1051,7 +1051,7 @@ static void test_munmap_end_freed(bool seal)
>         else
>                 FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_munmap_middle_freed(bool seal)
> @@ -1095,7 +1095,7 @@ static void test_munmap_middle_freed(bool seal)
>                 FAIL_TEST_IF_FALSE(size =3D=3D 0);
>         }
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mremap_shrink(bool seal)
> @@ -1124,7 +1124,7 @@ static void test_seal_mremap_shrink(bool seal)
>
>         }
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mremap_expand(bool seal)
> @@ -1156,7 +1156,7 @@ static void test_seal_mremap_expand(bool seal)
>
>         }
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mremap_move(bool seal)
> @@ -1189,7 +1189,7 @@ static void test_seal_mremap_move(bool seal)
>
>         }
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mmap_overwrite_prot(bool seal)
> @@ -1217,7 +1217,7 @@ static void test_seal_mmap_overwrite_prot(bool seal=
)
>         } else
>                 FAIL_TEST_IF_FALSE(ret2 =3D=3D ptr);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mmap_expand(bool seal)
> @@ -1248,7 +1248,7 @@ static void test_seal_mmap_expand(bool seal)
>         } else
>                 FAIL_TEST_IF_FALSE(ret2 =3D=3D ptr);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mmap_shrink(bool seal)
> @@ -1276,7 +1276,7 @@ static void test_seal_mmap_shrink(bool seal)
>         } else
>                 FAIL_TEST_IF_FALSE(ret2 =3D=3D ptr);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mremap_shrink_fixed(bool seal)
> @@ -1307,7 +1307,7 @@ static void test_seal_mremap_shrink_fixed(bool seal=
)
>         } else
>                 FAIL_TEST_IF_FALSE(ret2 =3D=3D newAddr);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mremap_expand_fixed(bool seal)
> @@ -1338,7 +1338,7 @@ static void test_seal_mremap_expand_fixed(bool seal=
)
>         } else
>                 FAIL_TEST_IF_FALSE(ret2 =3D=3D newAddr);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mremap_move_fixed(bool seal)
> @@ -1368,7 +1368,7 @@ static void test_seal_mremap_move_fixed(bool seal)
>         } else
>                 FAIL_TEST_IF_FALSE(ret2 =3D=3D newAddr);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mremap_move_fixed_zero(bool seal)
> @@ -1400,7 +1400,7 @@ static void test_seal_mremap_move_fixed_zero(bool s=
eal)
>
>         }
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mremap_move_dontunmap(bool seal)
> @@ -1429,7 +1429,7 @@ static void test_seal_mremap_move_dontunmap(bool se=
al)
>
>         }
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
> @@ -1463,7 +1463,7 @@ static void test_seal_mremap_move_dontunmap_anyaddr=
(bool seal)
>
>         }
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>
> @@ -1556,7 +1556,7 @@ static void test_seal_merge_and_split(void)
>         FAIL_TEST_IF_FALSE(size =3D=3D  22 * page_size);
>         FAIL_TEST_IF_FALSE(prot =3D=3D 0x4);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_discard_ro_anon_on_rw(bool seal)
> @@ -1585,7 +1585,7 @@ static void test_seal_discard_ro_anon_on_rw(bool se=
al)
>         else
>                 FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_discard_ro_anon_on_pkey(bool seal)
> @@ -1632,7 +1632,7 @@ static void test_seal_discard_ro_anon_on_pkey(bool =
seal)
>         else
>                 FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_discard_ro_anon_on_filebacked(bool seal)
> @@ -1669,7 +1669,7 @@ static void test_seal_discard_ro_anon_on_filebacked=
(bool seal)
>                 FAIL_TEST_IF_FALSE(!ret);
>         close(fd);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_discard_ro_anon_on_shared(bool seal)
> @@ -1698,7 +1698,7 @@ static void test_seal_discard_ro_anon_on_shared(boo=
l seal)
>         else
>                 FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  static void test_seal_discard_ro_anon(bool seal)
> @@ -1728,7 +1728,7 @@ static void test_seal_discard_ro_anon(bool seal)
>         else
>                 FAIL_TEST_IF_FALSE(!ret);
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  int main(int argc, char **argv)
> diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selfte=
sts/mm/seal_elf.c
> index 0fd129259647..131fc13cd422 100644
> --- a/tools/testing/selftests/mm/seal_elf.c
> +++ b/tools/testing/selftests/mm/seal_elf.c
> @@ -127,7 +127,7 @@ static void test_seal_elf(void)
>         FAIL_TEST_IF_FALSE(ret < 0);
>         ksft_print_msg("somestr is sealed, mprotect is rejected\n");
>
> -       TEST_END_CHECK();
> +       REPORT_TEST_PASS();
>  }
>
>  int main(int argc, char **argv)
> --
> 2.45.2
>

