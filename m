Return-Path: <linux-kselftest+bounces-26098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDE7A2D526
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 10:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503433A5737
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 09:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEFA1ACEAB;
	Sat,  8 Feb 2025 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="12VATG/6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780CB1AF0CE
	for <linux-kselftest@vger.kernel.org>; Sat,  8 Feb 2025 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005650; cv=none; b=iyA5mnNtZv1IKCVT3MbHGN1jOta8XYFkOv9dJI2ah4LL1p1DwYb1fBhCaSkqt8Mfc2RKJY28zF/tWvUffI3kP8NedBwNVOQsLrxh3nnQk20EbduKxrGT8YLtUJTad1+or2NvzXiKO5t9/TGcsrSJv8V0EHmJbspCS2/GpP94qh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005650; c=relaxed/simple;
	bh=4EAbG4EfVsiW1f5N1GJAVoY5zlXCeipxBZKArCHAi70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UL2E/i8bb7paQ+OvdCq8w0N1liKH0pYcEX0TIMQ6qy+ghx7asGHbec2/LfG9i93YG0xSoblbwbvdtr0a/2u0Bc6mzazQB9Kk8vVhRQaS8mmmXbbghQZdbGF1q/xLyarW8QRv+G5eX/7CeDRxYGgIGJVhh9tSsXJahC0GRBxOFlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=12VATG/6; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e451fdcae2so4275096d6.1
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Feb 2025 01:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739005647; x=1739610447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bgJlm6SdoMx3Fzv1XPN7GLs/iwn8ugidpys+7cckMHE=;
        b=12VATG/6E6+rbm0GUFl23DPlBW7bBb+8lBSJs4HMi31dRrlnltRE5mMZUSk/5JIXPX
         f+A81lVCKHsrciFcSMJKifQLVQYScQ5d+5VWT9ATYUWoT2JYmSCLZyEhQYv0REDIau3a
         sBXIvhXaj6E7uRoCTTH9ew/r8HA4JNNMO0sL0PtFa7wsZcPG2FCPH7wV3W7HsboD+F1V
         m5KqiL1SRMk+Ua8F5Ly359SrnGd/jmp2tlSE+pqI/SgWZ3nAeFtL1wq6aCoySKaQQ2Zl
         myMzKOhmDL+lFoOnTUvrjTp3MZyEFyiQJaUahXfRU2gH/NBgDWmUB9OpsypCuE8UIito
         yJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739005647; x=1739610447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgJlm6SdoMx3Fzv1XPN7GLs/iwn8ugidpys+7cckMHE=;
        b=Tku6dnJt6bgBrihV41suwlVdo11LwS+VSLgBGzMwAoI4JH27Tihh9G95i94CGMolli
         dOty+QwD7ntbR1WvmSSINh3ZDMACQtp8rzZjPDQvMgBz6Gf69pRpOLtzyqwM6LwN7TzD
         +alrv+eWGYG/EVPorRvoEKY1VEAI6W6unuD6Z43L++TrxQNkcmeXdwjnHLKN7LDGlQgE
         qRFu9NIM9OR5xhZBVqbrKXN6KSiZ8cyAebx55E1HmrkI8+bDVKS962PuXhKrvz1zD7Lp
         A6MWGlOX1KdULq6aCbX+nzN8MHe8bWvuOmlyw2vE+s8S4XU3HYop5TLbPCDmkRXQYNvE
         aCFw==
X-Forwarded-Encrypted: i=1; AJvYcCUZI2d3HygmyPTrRwT5hymdb5V8dEcTuFE/OFrWbYYMF1Lqk6+z5FuHDcjcGVa4ey6C/gEgInJR/2iDFanXAPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG4gymRYcu8HXeOYFmscf186IL2kG++dIbv+EbniyQ+n/AiWLV
	EVlA7mGyN6yU5b+/38Nya/y6ybni2HThqYVL8IsBx0R5zi8sua1QM5DiKT+1CG/SkrxmP9vQbUl
	CT019zmSQV6Fgmzifj9D724QHrw4VMSlR7gRH
X-Gm-Gg: ASbGncugmMm5xvCoi3mP7x3BH6SE9lzvEqrWtHKb1YrW0lhO/6BZpZJK1O5WzmyJT0T
	OzCcy6ks3/BJXBE5Y3z2yp/tzd/utd/KcYkJEMlegE8dSdJkbzhOatrHEXczjl1tWCHTKFLroKA
	==
X-Google-Smtp-Source: AGHT+IEwAWBdNXNnenYw301s6tgUJrQCymVh5kAOIMP6trKA2Yy7KRRTbwrsjrPOe9VWfe9sOuVzgnsWo0lPFTebncQ=
X-Received: by 2002:a05:6214:c26:b0:6e4:4011:9df7 with SMTP id
 6a1803df08f44-6e4456460a4mr94596206d6.16.1739005647181; Sat, 08 Feb 2025
 01:07:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com> <20250207-bitmap-kunit-convert-v1-3-c520675343b6@gmail.com>
In-Reply-To: <20250207-bitmap-kunit-convert-v1-3-c520675343b6@gmail.com>
From: David Gow <davidgow@google.com>
Date: Sat, 8 Feb 2025 17:07:15 +0800
X-Gm-Features: AWEUYZl3VMG9bkYXWB7fczBGO0VmDpt5H8KKuEN000aRvGzzge7D_cTVYUm0dpk
Message-ID: <CABVgOS=W3Wny0q-Kpj6P1ZXyG1R_HYCrPLtnHiuruW9FxoHrfA@mail.gmail.com>
Subject: Re: [PATCH 3/3] bitmap: break kunit into test cases
To: Tamir Duberstein <tamird@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e5b326062d9dcddd"

--000000000000e5b326062d9dcddd
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Feb 2025 at 04:14, Tamir Duberstein <tamird@gmail.com> wrote:
>
> Move some tests into `bitmap_test_cases` and parameterize
> `test_bitmap_print_buf`. This gives us nicer output in the event of a
> failure.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---

I very much like this cleanup: the static global 'kunittest' was annoying me.

I think there's an argument to get rid of tc_err() entirely, and just
use KUNIT_FAIL directly, but I'm happy either way: it is a lot of
churn.

Reviewed-by: David Gow <davidgow@google.com>

Thanks,
-- David


>  lib/bitmap_kunit.c | 182 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 89 insertions(+), 93 deletions(-)
>
> diff --git a/lib/bitmap_kunit.c b/lib/bitmap_kunit.c
> index 0605228288d6..f7b90f6d5f49 100644
> --- a/lib/bitmap_kunit.c
> +++ b/lib/bitmap_kunit.c
> @@ -17,8 +17,6 @@
>  static char pbl_buffer[PAGE_SIZE];
>  static char print_buf[PAGE_SIZE * 2];
>
> -static struct kunit *kunittest;
> -
>  #define tc_err(fmt, ...) \
>         KUNIT_FAIL(kunittest, fmt, ##__VA_ARGS__)
>
> @@ -96,7 +94,7 @@ static const unsigned long exp3_1_0[] = {
>
>  #define expect_eq_uint(x, y)           expect_eq_ulong((unsigned int)(x), (unsigned int)(y))
>
> -static void test_zero_clear(void)
> +static void test_zero_clear(struct kunit *kunittest)
>  {
>         DECLARE_BITMAP(bmap, 1024);
>
> @@ -125,7 +123,7 @@ static void test_zero_clear(void)
>         expect_eq_pbl("", bmap, 1024);
>  }
>
> -static void test_find_nth_bit(void)
> +static void test_find_nth_bit(struct kunit *kunittest)
>  {
>         unsigned long b, bit, cnt = 0;
>         DECLARE_BITMAP(bmap, 64 * 3);
> @@ -166,7 +164,7 @@ static void test_find_nth_bit(void)
>         }
>  }
>
> -static void test_fill_set(void)
> +static void test_fill_set(struct kunit *kunittest)
>  {
>         DECLARE_BITMAP(bmap, 1024);
>
> @@ -195,7 +193,7 @@ static void test_fill_set(void)
>         expect_eq_pbl("0-1023", bmap, 1024);
>  }
>
> -static void test_copy(void)
> +static void test_copy(struct kunit *kunittest)
>  {
>         DECLARE_BITMAP(bmap1, 1024);
>         DECLARE_BITMAP(bmap2, 1024);
> @@ -234,7 +232,7 @@ static void test_copy(void)
>         expect_eq_pbl("0-108,128-1023", bmap2, 1024);
>  }
>
> -static void test_bitmap_region(void)
> +static void test_bitmap_region(struct kunit *kunittest)
>  {
>         int pos, order;
>
> @@ -259,7 +257,7 @@ static void test_bitmap_region(void)
>
>  #define EXP2_IN_BITS   (sizeof(exp2) * 8)
>
> -static void test_replace(void)
> +static void test_replace(struct kunit *kunittest)
>  {
>         unsigned int nbits = 64;
>         unsigned int nlongs = DIV_ROUND_UP(nbits, BITS_PER_LONG);
> @@ -300,7 +298,7 @@ static const unsigned long sg_scatter_exp[] = {
>         BITMAP_FROM_U64(0x000000000000021aULL),
>  };
>
> -static void test_bitmap_sg(void)
> +static void test_bitmap_sg(struct kunit *kunittest)
>  {
>         unsigned int nbits = 64;
>         DECLARE_BITMAP(bmap_gather, 100);
> @@ -421,7 +419,7 @@ static const struct test_bitmap_parselist parselist_tests[] = {
>
>  };
>
> -static void test_bitmap_parselist(void)
> +static void test_bitmap_parselist(struct kunit *kunittest)
>  {
>         int i;
>         int err;
> @@ -457,7 +455,7 @@ static void test_bitmap_parselist(void)
>         }
>  }
>
> -static void test_bitmap_printlist(void)
> +static void test_bitmap_printlist(struct kunit *kunittest)
>  {
>         unsigned long *bmap = kmalloc(PAGE_SIZE, GFP_KERNEL);
>         char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> @@ -533,7 +531,7 @@ static const struct test_bitmap_parselist parse_tests[] = {
>  #undef step
>  };
>
> -static void test_bitmap_parse(void)
> +static void test_bitmap_parse(struct kunit *kunittest)
>  {
>         int i;
>         int err;
> @@ -568,7 +566,7 @@ static void test_bitmap_parse(void)
>         }
>  }
>
> -static void test_bitmap_arr32(void)
> +static void test_bitmap_arr32(struct kunit *kunittest)
>  {
>         unsigned int nbits, next_bit;
>         u32 arr[EXP1_IN_BITS / 32];
> @@ -594,7 +592,7 @@ static void test_bitmap_arr32(void)
>         }
>  }
>
> -static void test_bitmap_arr64(void)
> +static void test_bitmap_arr64(struct kunit *kunittest)
>  {
>         unsigned int nbits, next_bit;
>         u64 arr[EXP1_IN_BITS / 64];
> @@ -626,7 +624,7 @@ static void test_bitmap_arr64(void)
>         }
>  }
>
> -static noinline void test_mem_optimisations(void)
> +static noinline void test_mem_optimisations(struct kunit *kunittest)
>  {
>         DECLARE_BITMAP(bmap1, 1024);
>         DECLARE_BITMAP(bmap2, 1024);
> @@ -669,7 +667,7 @@ static const unsigned char clump_exp[] = {
>         0x05,   /* non-adjacent 2 bits set */
>  };
>
> -static void test_for_each_set_clump8(void)
> +static void test_for_each_set_clump8(struct kunit *kunittest)
>  {
>  #define CLUMP_EXP_NUMBITS 64
>         DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS);
> @@ -691,7 +689,7 @@ static void test_for_each_set_clump8(void)
>                 expect_eq_clump8(start, CLUMP_EXP_NUMBITS, clump_exp, &clump);
>  }
>
> -static void test_for_each_set_bit_wrap(void)
> +static void test_for_each_set_bit_wrap(struct kunit *kunittest)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -716,7 +714,7 @@ static void test_for_each_set_bit_wrap(void)
>         }
>  }
>
> -static void test_for_each_set_bit(void)
> +static void test_for_each_set_bit(struct kunit *kunittest)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -738,7 +736,7 @@ static void test_for_each_set_bit(void)
>         expect_eq_bitmap(orig, copy, 500);
>  }
>
> -static void test_for_each_set_bit_from(void)
> +static void test_for_each_set_bit_from(struct kunit *kunittest)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -768,7 +766,7 @@ static void test_for_each_set_bit_from(void)
>         }
>  }
>
> -static void test_for_each_clear_bit(void)
> +static void test_for_each_clear_bit(struct kunit *kunittest)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -790,7 +788,7 @@ static void test_for_each_clear_bit(void)
>         expect_eq_bitmap(orig, copy, 500);
>  }
>
> -static void test_for_each_clear_bit_from(void)
> +static void test_for_each_clear_bit_from(struct kunit *kunittest)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -820,7 +818,7 @@ static void test_for_each_clear_bit_from(void)
>         }
>  }
>
> -static void test_for_each_set_bitrange(void)
> +static void test_for_each_set_bitrange(struct kunit *kunittest)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -842,7 +840,7 @@ static void test_for_each_set_bitrange(void)
>         expect_eq_bitmap(orig, copy, 500);
>  }
>
> -static void test_for_each_clear_bitrange(void)
> +static void test_for_each_clear_bitrange(struct kunit *kunittest)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -864,7 +862,7 @@ static void test_for_each_clear_bitrange(void)
>         expect_eq_bitmap(orig, copy, 500);
>  }
>
> -static void test_for_each_set_bitrange_from(void)
> +static void test_for_each_set_bitrange_from(struct kunit *kunittest)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -894,7 +892,7 @@ static void test_for_each_set_bitrange_from(void)
>         }
>  }
>
> -static void test_for_each_clear_bitrange_from(void)
> +static void test_for_each_clear_bitrange_from(struct kunit *kunittest)
>  {
>         DECLARE_BITMAP(orig, 500);
>         DECLARE_BITMAP(copy, 500);
> @@ -965,7 +963,7 @@ static struct test_bitmap_cut test_cut[] = {
>         },
>  };
>
> -static void test_bitmap_cut(void)
> +static void test_bitmap_cut(struct kunit *kunittest)
>  {
>         unsigned long b[5], *in = &b[1], *out = &b[0];  /* Partial overlap */
>         int i;
> @@ -986,8 +984,14 @@ struct test_bitmap_print {
>         unsigned long nbits;
>         const char *mask;
>         const char *list;
> +       const char *name;
>  };
>
> +static void param_to_desc(const struct test_bitmap_print *param, char *desc)
> +{
> +       strscpy(desc, param->name, KUNIT_PARAM_DESC_SIZE);
> +}
> +
>  static const unsigned long small_bitmap[] = {
>         BITMAP_FROM_U64(0x3333333311111111ULL),
>  };
> @@ -1082,35 +1086,34 @@ static const char large_list[] = /* more than 4KB */
>         "49,2552-2553,2556-2557\n";
>
>  static const struct test_bitmap_print test_print[] = {
> -       { small_bitmap, sizeof(small_bitmap) * BITS_PER_BYTE, small_mask, small_list },
> -       { large_bitmap, sizeof(large_bitmap) * BITS_PER_BYTE, large_mask, large_list },
> +       { small_bitmap, sizeof(small_bitmap) * BITS_PER_BYTE, small_mask, small_list, "small" },
> +       { large_bitmap, sizeof(large_bitmap) * BITS_PER_BYTE, large_mask, large_list, "large" },
>  };
>
> -static void test_bitmap_print_buf(void)
> +KUNIT_ARRAY_PARAM(test_print, test_print, param_to_desc);
> +
> +static void test_bitmap_print_buf(struct kunit *kunittest)
>  {
> -       int i;
> +       int n;
>
> -       for (i = 0; i < ARRAY_SIZE(test_print); i++) {
> -               const struct test_bitmap_print *t = &test_print[i];
> -               int n;
> +       const struct test_bitmap_print *t = kunittest->param_value;
>
> -               n = bitmap_print_bitmask_to_buf(print_buf, t->bitmap, t->nbits,
> -                                               0, 2 * PAGE_SIZE);
> -               expect_eq_uint(strlen(t->mask) + 1, n);
> -               expect_eq_str(t->mask, print_buf, n);
> +       n = bitmap_print_bitmask_to_buf(print_buf, t->bitmap, t->nbits,
> +                                       0, 2 * PAGE_SIZE);
> +       expect_eq_uint(strlen(t->mask) + 1, n);
> +       expect_eq_str(t->mask, print_buf, n);
>
> +       n = bitmap_print_list_to_buf(print_buf, t->bitmap, t->nbits,
> +                                       0, 2 * PAGE_SIZE);
> +       expect_eq_uint(strlen(t->list) + 1, n);
> +       expect_eq_str(t->list, print_buf, n);
> +
> +       /* test by non-zero offset */
> +       if (strlen(t->list) > PAGE_SIZE) {
>                 n = bitmap_print_list_to_buf(print_buf, t->bitmap, t->nbits,
> -                                            0, 2 * PAGE_SIZE);
> -               expect_eq_uint(strlen(t->list) + 1, n);
> -               expect_eq_str(t->list, print_buf, n);
> -
> -               /* test by non-zero offset */
> -               if (strlen(t->list) > PAGE_SIZE) {
> -                       n = bitmap_print_list_to_buf(print_buf, t->bitmap, t->nbits,
> -                                                    PAGE_SIZE, PAGE_SIZE);
> -                       expect_eq_uint(strlen(t->list) + 1 - PAGE_SIZE, n);
> -                       expect_eq_str(t->list + PAGE_SIZE, print_buf, n);
> -               }
> +                                               PAGE_SIZE, PAGE_SIZE);
> +               expect_eq_uint(strlen(t->list) + 1 - PAGE_SIZE, n);
> +               expect_eq_str(t->list + PAGE_SIZE, print_buf, n);
>         }
>  }
>
> @@ -1118,7 +1121,7 @@ static void test_bitmap_print_buf(void)
>   * FIXME: Clang breaks compile-time evaluations when KASAN and GCOV are enabled.
>   * To workaround it, GCOV is force-disabled in Makefile for this configuration.
>   */
> -static void test_bitmap_const_eval(void)
> +static void test_bitmap_const_eval(struct kunit *kunittest)
>  {
>         DECLARE_BITMAP(bitmap, BITS_PER_LONG);
>         unsigned long initvar = BIT(2);
> @@ -1186,7 +1189,7 @@ static void test_bitmap_const_eval(void)
>  /*
>   * Helper function to test bitmap_write() overwriting the chosen byte pattern.
>   */
> -static void test_bitmap_write_helper(const char *pattern)
> +static void test_bitmap_write_helper(struct kunit *kunittest, const char *pattern)
>  {
>         DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
>         DECLARE_BITMAP(exp_bitmap, TEST_BIT_LEN);
> @@ -1240,7 +1243,7 @@ static void test_bitmap_write_helper(const char *pattern)
>         }
>  }
>
> -static void test_bitmap_read_write(void)
> +static void test_bitmap_read_write(struct kunit *kunittest)
>  {
>         unsigned char *pattern[3] = {"", "all:1/2", "all"};
>         DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
> @@ -1286,10 +1289,10 @@ static void test_bitmap_read_write(void)
>         }
>
>         for (pi = 0; pi < ARRAY_SIZE(pattern); pi++)
> -               test_bitmap_write_helper(pattern[pi]);
> +               test_bitmap_write_helper(kunittest, pattern[pi]);
>  }
>
> -static void test_bitmap_read_perf(void)
> +static void test_bitmap_read_perf(struct kunit *kunittest)
>  {
>         DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
>         unsigned int cnt, nbits, i;
> @@ -1312,10 +1315,10 @@ static void test_bitmap_read_perf(void)
>                 }
>         }
>         time = ktime_get() - time;
> -       kunit_info(kunittest, "Time spent in %s:\t%llu\n", __func__, time);
> +       kunit_info(kunittest, "Time spent:\t%llu\n", time);
>  }
>
> -static void test_bitmap_write_perf(void)
> +static void test_bitmap_write_perf(struct kunit *kunittest)
>  {
>         DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
>         unsigned int cnt, nbits, i;
> @@ -1334,49 +1337,42 @@ static void test_bitmap_write_perf(void)
>                 }
>         }
>         time = ktime_get() - time;
> -       kunit_info(kunittest, "Time spent in %s:\t%llu\n", __func__, time);
> +       kunit_info(kunittest, "Time spent:\t%llu\n", time);
>  }
>
>  #undef TEST_BIT_LEN
>
> -static void bitmap_test(struct kunit *test)
> -{
> -       kunittest = test;
> -
> -       test_zero_clear();
> -       test_fill_set();
> -       test_copy();
> -       test_bitmap_region();
> -       test_replace();
> -       test_bitmap_sg();
> -       test_bitmap_arr32();
> -       test_bitmap_arr64();
> -       test_bitmap_parse();
> -       test_bitmap_parselist();
> -       test_bitmap_printlist();
> -       test_mem_optimisations();
> -       test_bitmap_cut();
> -       test_bitmap_print_buf();
> -       test_bitmap_const_eval();
> -       test_bitmap_read_write();
> -       test_bitmap_read_perf();
> -       test_bitmap_write_perf();
> -
> -       test_find_nth_bit();
> -       test_for_each_set_bit();
> -       test_for_each_set_bit_from();
> -       test_for_each_clear_bit();
> -       test_for_each_clear_bit_from();
> -       test_for_each_set_bitrange();
> -       test_for_each_clear_bitrange();
> -       test_for_each_set_bitrange_from();
> -       test_for_each_clear_bitrange_from();
> -       test_for_each_set_clump8();
> -       test_for_each_set_bit_wrap();
> -}
> -
>  static struct kunit_case bitmap_test_cases[] = {
> -       KUNIT_CASE(bitmap_test),
> +       KUNIT_CASE(test_zero_clear),
> +       KUNIT_CASE(test_fill_set),
> +       KUNIT_CASE(test_copy),
> +       KUNIT_CASE(test_bitmap_region),
> +       KUNIT_CASE(test_replace),
> +       KUNIT_CASE(test_bitmap_sg),
> +       KUNIT_CASE(test_bitmap_arr32),
> +       KUNIT_CASE(test_bitmap_arr64),
> +       KUNIT_CASE(test_bitmap_parse),
> +       KUNIT_CASE(test_bitmap_parselist),
> +       KUNIT_CASE(test_bitmap_printlist),
> +       KUNIT_CASE(test_mem_optimisations),
> +       KUNIT_CASE(test_bitmap_cut),
> +       KUNIT_CASE_PARAM(test_bitmap_print_buf, test_print_gen_params),
> +       KUNIT_CASE(test_bitmap_const_eval),
> +       KUNIT_CASE(test_bitmap_read_write),
> +       KUNIT_CASE(test_bitmap_read_perf),
> +       KUNIT_CASE(test_bitmap_write_perf),
> +
> +       KUNIT_CASE(test_find_nth_bit),
> +       KUNIT_CASE(test_for_each_set_bit),
> +       KUNIT_CASE(test_for_each_set_bit_from),
> +       KUNIT_CASE(test_for_each_clear_bit),
> +       KUNIT_CASE(test_for_each_clear_bit_from),
> +       KUNIT_CASE(test_for_each_set_bitrange),
> +       KUNIT_CASE(test_for_each_clear_bitrange),
> +       KUNIT_CASE(test_for_each_set_bitrange_from),
> +       KUNIT_CASE(test_for_each_clear_bitrange_from),
> +       KUNIT_CASE(test_for_each_set_clump8),
> +       KUNIT_CASE(test_for_each_set_bit_wrap),
>         {}
>  };
>
>
> --
> 2.48.1
>

--000000000000e5b326062d9dcddd
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
YE9NAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHgsCGkO2Hex
N6ybc+GeQEb6790qMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQAs
exV05yVDmPhHRqOq9lAbfWOUvEf8zydxabZUHna6bayb83jD2eb9nMGGEprfuNBRmFg35sgF1TyN
+ieuQakvQYmY8tzK49hhHa2Y3qhGCTqYTHO3ypHvhHsZiGbL0gmdgB9P8ssVIws//34ae99GUOxo
XKTxPwwsQ5Arq42besv3/HXAW+4nRAT8d3ht5ZWCHc5rjL/vdGzu7PaYo3u0da69AZ8Sh4Gf5yoc
QANr2ZkMrxXbLmSmnRvbkQrzlZp2YbTFnczx46429D6q75/FNFOL1vAjxtRAPzkyACvW0eKvchza
TMvvD3IWERLlcBL5yXpENc3rI8/wVjqgAWYxlFg1b/4b/TCgYe2MZC0rx4Uh3zTIbmPNiHdN6QZ9
oDiYzWUcqWZ5jCO4bMKNlVJXeCvdANLHuhcC8FONj5VzNgYXs6gWkp9/Wt6XnQPX4dF4JBa8JdL/
cT46RJIzoiJHEx/8syO5FparZHIKbkunoq6niPsRaQUGeqWc56H4Z1sQXuBJN9fhqkIkG0Ywfrwt
uFrCoYIRlx4rSVHpBIKgnsgdm0SFQK72MPmIkfhfq9Fh0h8AjhF73sLO7K5BfwWkx1gwMySyNY0e
PCRYr6WEVOkUJS0a0fui693ymMPFLQAimmz8EpyFok4Ju066StkYO1dIgUIla4x61auxkWHwnzGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg6bVG2zaLx17qfbhZQIxg7PVCO0Kx
zjvugs2VEmYB6n0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MjA4MDkwNzI3WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAIOEdhrlwFtXtXcnMn0WFRS+xZn7B8zPL2uBzALtOLvQsyUn
3ndC+ExZOLZlZDkScvOG1RJ5nrpQ7sOeLso/x8G/TV0Eg+sm2yWtxmNyVKc1F9hyzii3KbkVGxXI
SsEB73zlHugYnoni9hBWJLtczjKXqzsI0ahufSRoiV/PWs1BKeesTj0Fpn/Eo9r12YJ8atk+hCz1
ODXlKM0ipX/W0n6SBXh59VAnc/4SpBGAviMeluHaov3xhpsdqbIvXhZy3qweQZpnaVrE/iNHz2TN
dbbx45g80KMo2/QCnmUhsZVJz9hXKnKHoBV7UMKaC4NbA/25e7vMVHzzNcbBuR0zuUQ=
--000000000000e5b326062d9dcddd--

