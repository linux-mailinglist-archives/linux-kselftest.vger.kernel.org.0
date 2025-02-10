Return-Path: <linux-kselftest+bounces-26144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B455A2E395
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 06:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64A0A3A2A9C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 05:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98AD18E361;
	Mon, 10 Feb 2025 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="f6qZ3e8i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A058118FDAB;
	Mon, 10 Feb 2025 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739165027; cv=pass; b=rC3xpK+TMdescZ099E6GUzpFifWlHkkfaWEvGjFEfGmO45yUWq8DhfJzScpfwH5oLSMEfZD0iJPXBkgDUOfBOwcrTIerA1ht8fgMVNWu0v2qBcExdfk9BHg/YWCCzxu/WTJVdvlXlVVUk3Zgwp1V0RK6hPqsPQK9XjvhnmdHvY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739165027; c=relaxed/simple;
	bh=DS2cZ7IzfJu06ktQH1G4cipsi/hGfyVObS1pJvei4rc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=piwGWJ8UF+JTY9r8AXqv45zSCKrRP2zpyCUFb8EpacXcmQ6OAzkiqP1iXOAUzF+49ASemMwuq2jRhwlYp9x0wSZ4AK+D6VPLsjkjVn/s6Xdqmg4YkNPIGtE7oTlImsRIr/FclTCobZW2r3L/3bPlFUQA011bO3eDtZz/9j2FPtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=f6qZ3e8i; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739164993; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JqR3KorCinvjHzPa8RdmHaKo/HGGZPs4Quon3J4LcuKW53paY2xrujdgyKyb0u/fvKNQNHOAEsR+IhyX2J6Shyqj054CajgskOyynsW2q9P9/FMvjRp1fFuB3krvcspyRAt6ox3XCD8aMkOyGknXwc1nbDzKnZqXVCGx/Qs/w/M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739164993; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/QIz911OMtcD5qVxILAnaTymBqCBQ0ocZbJLtR/PUXY=; 
	b=JavJ1/h08URD+qfQgBblFNzRNNCbdCTekR8HBb4VYEJrj9vVMsyC7qtuehWgCTVabiCmL2hqP7O0hwtqU74DZaqAT+wnT+uLyiEqSeowgBtvhvpgntqUnA9WFfJfEXIP4Lljrym5LSx+f4ICUsYSSKkJb8W7LRseT2oTfKoeCa8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739164993;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/QIz911OMtcD5qVxILAnaTymBqCBQ0ocZbJLtR/PUXY=;
	b=f6qZ3e8i8EEkCrdCw8Zh5Oz3CJuZoCruA6E8bWsMLoWPs0gdo4+AL/oP0evryGri
	n3+BKDk+INPt9staTbiJVc3MJZFQbHD3nmHBi71VcT1g8foyt/WCLnWTJdOqXPOHZfF
	KEckjYeSqMbMdKTem7j/U8TSML/74A1Y5Ups+O38=
Received: by mx.zohomail.com with SMTPS id 1739164990922906.1391036387133;
	Sun, 9 Feb 2025 21:23:10 -0800 (PST)
Message-ID: <47a8a72b-61a0-49e3-8ae8-668380b3b567@collabora.com>
Date: Mon, 10 Feb 2025 10:23:39 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] bitmap: break kunit into test cases
To: Tamir Duberstein <tamird@gmail.com>, David Gow <davidgow@google.com>,
 John Hubbard <jhubbard@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>,
 Kees Cook <kees@kernel.org>
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com>
 <20250207-bitmap-kunit-convert-v1-3-c520675343b6@gmail.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250207-bitmap-kunit-convert-v1-3-c520675343b6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/8/25 1:14 AM, Tamir Duberstein wrote:
> Move some tests into `bitmap_test_cases` and parameterize
> `test_bitmap_print_buf`. This gives us nicer output in the event of a
> failure.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
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
>  	KUNIT_FAIL(kunittest, fmt, ##__VA_ARGS__)
>  
> @@ -96,7 +94,7 @@ static const unsigned long exp3_1_0[] = {
>  
>  #define expect_eq_uint(x, y)		expect_eq_ulong((unsigned int)(x), (unsigned int)(y))
>  
> -static void test_zero_clear(void)
> +static void test_zero_clear(struct kunit *kunittest)
>  {
>  	DECLARE_BITMAP(bmap, 1024);
>  
> @@ -125,7 +123,7 @@ static void test_zero_clear(void)
>  	expect_eq_pbl("", bmap, 1024);
>  }
>  
> -static void test_find_nth_bit(void)
> +static void test_find_nth_bit(struct kunit *kunittest)
>  {
>  	unsigned long b, bit, cnt = 0;
>  	DECLARE_BITMAP(bmap, 64 * 3);
> @@ -166,7 +164,7 @@ static void test_find_nth_bit(void)
>  	}
>  }
>  
> -static void test_fill_set(void)
> +static void test_fill_set(struct kunit *kunittest)
>  {
>  	DECLARE_BITMAP(bmap, 1024);
>  
> @@ -195,7 +193,7 @@ static void test_fill_set(void)
>  	expect_eq_pbl("0-1023", bmap, 1024);
>  }
>  
> -static void test_copy(void)
> +static void test_copy(struct kunit *kunittest)
>  {
>  	DECLARE_BITMAP(bmap1, 1024);
>  	DECLARE_BITMAP(bmap2, 1024);
> @@ -234,7 +232,7 @@ static void test_copy(void)
>  	expect_eq_pbl("0-108,128-1023", bmap2, 1024);
>  }
>  
> -static void test_bitmap_region(void)
> +static void test_bitmap_region(struct kunit *kunittest)
>  {
>  	int pos, order;
>  
> @@ -259,7 +257,7 @@ static void test_bitmap_region(void)
>  
>  #define EXP2_IN_BITS	(sizeof(exp2) * 8)
>  
> -static void test_replace(void)
> +static void test_replace(struct kunit *kunittest)
>  {
>  	unsigned int nbits = 64;
>  	unsigned int nlongs = DIV_ROUND_UP(nbits, BITS_PER_LONG);
> @@ -300,7 +298,7 @@ static const unsigned long sg_scatter_exp[] = {
>  	BITMAP_FROM_U64(0x000000000000021aULL),
>  };
>  
> -static void test_bitmap_sg(void)
> +static void test_bitmap_sg(struct kunit *kunittest)
>  {
>  	unsigned int nbits = 64;
>  	DECLARE_BITMAP(bmap_gather, 100);
> @@ -421,7 +419,7 @@ static const struct test_bitmap_parselist parselist_tests[] = {
>  
>  };
>  
> -static void test_bitmap_parselist(void)
> +static void test_bitmap_parselist(struct kunit *kunittest)
>  {
>  	int i;
>  	int err;
> @@ -457,7 +455,7 @@ static void test_bitmap_parselist(void)
>  	}
>  }
>  
> -static void test_bitmap_printlist(void)
> +static void test_bitmap_printlist(struct kunit *kunittest)
>  {
>  	unsigned long *bmap = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> @@ -533,7 +531,7 @@ static const struct test_bitmap_parselist parse_tests[] = {
>  #undef step
>  };
>  
> -static void test_bitmap_parse(void)
> +static void test_bitmap_parse(struct kunit *kunittest)
>  {
>  	int i;
>  	int err;
> @@ -568,7 +566,7 @@ static void test_bitmap_parse(void)
>  	}
>  }
>  
> -static void test_bitmap_arr32(void)
> +static void test_bitmap_arr32(struct kunit *kunittest)
>  {
>  	unsigned int nbits, next_bit;
>  	u32 arr[EXP1_IN_BITS / 32];
> @@ -594,7 +592,7 @@ static void test_bitmap_arr32(void)
>  	}
>  }
>  
> -static void test_bitmap_arr64(void)
> +static void test_bitmap_arr64(struct kunit *kunittest)
>  {
>  	unsigned int nbits, next_bit;
>  	u64 arr[EXP1_IN_BITS / 64];
> @@ -626,7 +624,7 @@ static void test_bitmap_arr64(void)
>  	}
>  }
>  
> -static noinline void test_mem_optimisations(void)
> +static noinline void test_mem_optimisations(struct kunit *kunittest)
>  {
>  	DECLARE_BITMAP(bmap1, 1024);
>  	DECLARE_BITMAP(bmap2, 1024);
> @@ -669,7 +667,7 @@ static const unsigned char clump_exp[] = {
>  	0x05,	/* non-adjacent 2 bits set */
>  };
>  
> -static void test_for_each_set_clump8(void)
> +static void test_for_each_set_clump8(struct kunit *kunittest)
>  {
>  #define CLUMP_EXP_NUMBITS 64
>  	DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS);
> @@ -691,7 +689,7 @@ static void test_for_each_set_clump8(void)
>  		expect_eq_clump8(start, CLUMP_EXP_NUMBITS, clump_exp, &clump);
>  }
>  
> -static void test_for_each_set_bit_wrap(void)
> +static void test_for_each_set_bit_wrap(struct kunit *kunittest)
>  {
>  	DECLARE_BITMAP(orig, 500);
>  	DECLARE_BITMAP(copy, 500);
> @@ -716,7 +714,7 @@ static void test_for_each_set_bit_wrap(void)
>  	}
>  }
>  
> -static void test_for_each_set_bit(void)
> +static void test_for_each_set_bit(struct kunit *kunittest)
>  {
>  	DECLARE_BITMAP(orig, 500);
>  	DECLARE_BITMAP(copy, 500);
> @@ -738,7 +736,7 @@ static void test_for_each_set_bit(void)
>  	expect_eq_bitmap(orig, copy, 500);
>  }
>  
> -static void test_for_each_set_bit_from(void)
> +static void test_for_each_set_bit_from(struct kunit *kunittest)
>  {
>  	DECLARE_BITMAP(orig, 500);
>  	DECLARE_BITMAP(copy, 500);
> @@ -768,7 +766,7 @@ static void test_for_each_set_bit_from(void)
>  	}
>  }
>  
> -static void test_for_each_clear_bit(void)
> +static void test_for_each_clear_bit(struct kunit *kunittest)
>  {
>  	DECLARE_BITMAP(orig, 500);
>  	DECLARE_BITMAP(copy, 500);
> @@ -790,7 +788,7 @@ static void test_for_each_clear_bit(void)
>  	expect_eq_bitmap(orig, copy, 500);
>  }
>  
> -static void test_for_each_clear_bit_from(void)
> +static void test_for_each_clear_bit_from(struct kunit *kunittest)
>  {
>  	DECLARE_BITMAP(orig, 500);
>  	DECLARE_BITMAP(copy, 500);
> @@ -820,7 +818,7 @@ static void test_for_each_clear_bit_from(void)
>  	}
>  }
>  
> -static void test_for_each_set_bitrange(void)
> +static void test_for_each_set_bitrange(struct kunit *kunittest)
>  {
>  	DECLARE_BITMAP(orig, 500);
>  	DECLARE_BITMAP(copy, 500);
> @@ -842,7 +840,7 @@ static void test_for_each_set_bitrange(void)
>  	expect_eq_bitmap(orig, copy, 500);
>  }
>  
> -static void test_for_each_clear_bitrange(void)
> +static void test_for_each_clear_bitrange(struct kunit *kunittest)
>  {
>  	DECLARE_BITMAP(orig, 500);
>  	DECLARE_BITMAP(copy, 500);
> @@ -864,7 +862,7 @@ static void test_for_each_clear_bitrange(void)
>  	expect_eq_bitmap(orig, copy, 500);
>  }
>  
> -static void test_for_each_set_bitrange_from(void)
> +static void test_for_each_set_bitrange_from(struct kunit *kunittest)
>  {
>  	DECLARE_BITMAP(orig, 500);
>  	DECLARE_BITMAP(copy, 500);
> @@ -894,7 +892,7 @@ static void test_for_each_set_bitrange_from(void)
>  	}
>  }
>  
> -static void test_for_each_clear_bitrange_from(void)
> +static void test_for_each_clear_bitrange_from(struct kunit *kunittest)
>  {
>  	DECLARE_BITMAP(orig, 500);
>  	DECLARE_BITMAP(copy, 500);
> @@ -965,7 +963,7 @@ static struct test_bitmap_cut test_cut[] = {
>  	},
>  };
>  
> -static void test_bitmap_cut(void)
> +static void test_bitmap_cut(struct kunit *kunittest)
>  {
>  	unsigned long b[5], *in = &b[1], *out = &b[0];	/* Partial overlap */
>  	int i;
> @@ -986,8 +984,14 @@ struct test_bitmap_print {
>  	unsigned long nbits;
>  	const char *mask;
>  	const char *list;
> +	const char *name;
>  };
>  
> +static void param_to_desc(const struct test_bitmap_print *param, char *desc)
> +{
> +	strscpy(desc, param->name, KUNIT_PARAM_DESC_SIZE);
> +}
> +
>  static const unsigned long small_bitmap[] = {
>  	BITMAP_FROM_U64(0x3333333311111111ULL),
>  };
> @@ -1082,35 +1086,34 @@ static const char large_list[] = /* more than 4KB */
>  	"49,2552-2553,2556-2557\n";
>  
>  static const struct test_bitmap_print test_print[] = {
> -	{ small_bitmap, sizeof(small_bitmap) * BITS_PER_BYTE, small_mask, small_list },
> -	{ large_bitmap, sizeof(large_bitmap) * BITS_PER_BYTE, large_mask, large_list },
> +	{ small_bitmap, sizeof(small_bitmap) * BITS_PER_BYTE, small_mask, small_list, "small" },
> +	{ large_bitmap, sizeof(large_bitmap) * BITS_PER_BYTE, large_mask, large_list, "large" },
>  };
>  
> -static void test_bitmap_print_buf(void)
> +KUNIT_ARRAY_PARAM(test_print, test_print, param_to_desc);
> +
> +static void test_bitmap_print_buf(struct kunit *kunittest)
>  {
> -	int i;
> +	int n;
>  
> -	for (i = 0; i < ARRAY_SIZE(test_print); i++) {
> -		const struct test_bitmap_print *t = &test_print[i];
> -		int n;
> +	const struct test_bitmap_print *t = kunittest->param_value;
>  
> -		n = bitmap_print_bitmask_to_buf(print_buf, t->bitmap, t->nbits,
> -						0, 2 * PAGE_SIZE);
> -		expect_eq_uint(strlen(t->mask) + 1, n);
> -		expect_eq_str(t->mask, print_buf, n);
> +	n = bitmap_print_bitmask_to_buf(print_buf, t->bitmap, t->nbits,
> +					0, 2 * PAGE_SIZE);
> +	expect_eq_uint(strlen(t->mask) + 1, n);
> +	expect_eq_str(t->mask, print_buf, n);
>  
> +	n = bitmap_print_list_to_buf(print_buf, t->bitmap, t->nbits,
> +					0, 2 * PAGE_SIZE);
> +	expect_eq_uint(strlen(t->list) + 1, n);
> +	expect_eq_str(t->list, print_buf, n);
> +
> +	/* test by non-zero offset */
> +	if (strlen(t->list) > PAGE_SIZE) {
>  		n = bitmap_print_list_to_buf(print_buf, t->bitmap, t->nbits,
> -					     0, 2 * PAGE_SIZE);
> -		expect_eq_uint(strlen(t->list) + 1, n);
> -		expect_eq_str(t->list, print_buf, n);
> -
> -		/* test by non-zero offset */
> -		if (strlen(t->list) > PAGE_SIZE) {
> -			n = bitmap_print_list_to_buf(print_buf, t->bitmap, t->nbits,
> -						     PAGE_SIZE, PAGE_SIZE);
> -			expect_eq_uint(strlen(t->list) + 1 - PAGE_SIZE, n);
> -			expect_eq_str(t->list + PAGE_SIZE, print_buf, n);
> -		}
> +						PAGE_SIZE, PAGE_SIZE);
> +		expect_eq_uint(strlen(t->list) + 1 - PAGE_SIZE, n);
> +		expect_eq_str(t->list + PAGE_SIZE, print_buf, n);
>  	}
>  }
>  
> @@ -1118,7 +1121,7 @@ static void test_bitmap_print_buf(void)
>   * FIXME: Clang breaks compile-time evaluations when KASAN and GCOV are enabled.
>   * To workaround it, GCOV is force-disabled in Makefile for this configuration.
>   */
> -static void test_bitmap_const_eval(void)
> +static void test_bitmap_const_eval(struct kunit *kunittest)
>  {
>  	DECLARE_BITMAP(bitmap, BITS_PER_LONG);
>  	unsigned long initvar = BIT(2);
> @@ -1186,7 +1189,7 @@ static void test_bitmap_const_eval(void)
>  /*
>   * Helper function to test bitmap_write() overwriting the chosen byte pattern.
>   */
> -static void test_bitmap_write_helper(const char *pattern)
> +static void test_bitmap_write_helper(struct kunit *kunittest, const char *pattern)
>  {
>  	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
>  	DECLARE_BITMAP(exp_bitmap, TEST_BIT_LEN);
> @@ -1240,7 +1243,7 @@ static void test_bitmap_write_helper(const char *pattern)
>  	}
>  }
>  
> -static void test_bitmap_read_write(void)
> +static void test_bitmap_read_write(struct kunit *kunittest)
>  {
>  	unsigned char *pattern[3] = {"", "all:1/2", "all"};
>  	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
> @@ -1286,10 +1289,10 @@ static void test_bitmap_read_write(void)
>  	}
>  
>  	for (pi = 0; pi < ARRAY_SIZE(pattern); pi++)
> -		test_bitmap_write_helper(pattern[pi]);
> +		test_bitmap_write_helper(kunittest, pattern[pi]);
>  }
>  
> -static void test_bitmap_read_perf(void)
> +static void test_bitmap_read_perf(struct kunit *kunittest)
>  {
>  	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
>  	unsigned int cnt, nbits, i;
> @@ -1312,10 +1315,10 @@ static void test_bitmap_read_perf(void)
>  		}
>  	}
>  	time = ktime_get() - time;
> -	kunit_info(kunittest, "Time spent in %s:\t%llu\n", __func__, time);
> +	kunit_info(kunittest, "Time spent:\t%llu\n", time);
>  }
>  
> -static void test_bitmap_write_perf(void)
> +static void test_bitmap_write_perf(struct kunit *kunittest)
>  {
>  	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
>  	unsigned int cnt, nbits, i;
> @@ -1334,49 +1337,42 @@ static void test_bitmap_write_perf(void)
>  		}
>  	}
>  	time = ktime_get() - time;
> -	kunit_info(kunittest, "Time spent in %s:\t%llu\n", __func__, time);
> +	kunit_info(kunittest, "Time spent:\t%llu\n", time);
>  }
>  
>  #undef TEST_BIT_LEN
>  
> -static void bitmap_test(struct kunit *test)
> -{
> -	kunittest = test;
> -
> -	test_zero_clear();
> -	test_fill_set();
> -	test_copy();
> -	test_bitmap_region();
> -	test_replace();
> -	test_bitmap_sg();
> -	test_bitmap_arr32();
> -	test_bitmap_arr64();
> -	test_bitmap_parse();
> -	test_bitmap_parselist();
> -	test_bitmap_printlist();
> -	test_mem_optimisations();
> -	test_bitmap_cut();
> -	test_bitmap_print_buf();
> -	test_bitmap_const_eval();
> -	test_bitmap_read_write();
> -	test_bitmap_read_perf();
> -	test_bitmap_write_perf();
> -
> -	test_find_nth_bit();
> -	test_for_each_set_bit();
> -	test_for_each_set_bit_from();
> -	test_for_each_clear_bit();
> -	test_for_each_clear_bit_from();
> -	test_for_each_set_bitrange();
> -	test_for_each_clear_bitrange();
> -	test_for_each_set_bitrange_from();
> -	test_for_each_clear_bitrange_from();
> -	test_for_each_set_clump8();
> -	test_for_each_set_bit_wrap();
> -}
> -
>  static struct kunit_case bitmap_test_cases[] = {
> -	KUNIT_CASE(bitmap_test),
> +	KUNIT_CASE(test_zero_clear),
> +	KUNIT_CASE(test_fill_set),
> +	KUNIT_CASE(test_copy),
> +	KUNIT_CASE(test_bitmap_region),
> +	KUNIT_CASE(test_replace),
> +	KUNIT_CASE(test_bitmap_sg),
> +	KUNIT_CASE(test_bitmap_arr32),
> +	KUNIT_CASE(test_bitmap_arr64),
> +	KUNIT_CASE(test_bitmap_parse),
> +	KUNIT_CASE(test_bitmap_parselist),
> +	KUNIT_CASE(test_bitmap_printlist),
> +	KUNIT_CASE(test_mem_optimisations),
> +	KUNIT_CASE(test_bitmap_cut),
> +	KUNIT_CASE_PARAM(test_bitmap_print_buf, test_print_gen_params),
> +	KUNIT_CASE(test_bitmap_const_eval),
> +	KUNIT_CASE(test_bitmap_read_write),
> +	KUNIT_CASE(test_bitmap_read_perf),
> +	KUNIT_CASE(test_bitmap_write_perf),
> +
> +	KUNIT_CASE(test_find_nth_bit),
> +	KUNIT_CASE(test_for_each_set_bit),
> +	KUNIT_CASE(test_for_each_set_bit_from),
> +	KUNIT_CASE(test_for_each_clear_bit),
> +	KUNIT_CASE(test_for_each_clear_bit_from),
> +	KUNIT_CASE(test_for_each_set_bitrange),
> +	KUNIT_CASE(test_for_each_clear_bitrange),
> +	KUNIT_CASE(test_for_each_set_bitrange_from),
> +	KUNIT_CASE(test_for_each_clear_bitrange_from),
> +	KUNIT_CASE(test_for_each_set_clump8),
> +	KUNIT_CASE(test_for_each_set_bit_wrap),
>  	{}
>  };
>  
> 


-- 
BR,
Muhammad Usama Anjum

