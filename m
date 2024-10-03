Return-Path: <linux-kselftest+bounces-18956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF5498E9E2
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 08:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 537EEB2118D
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 06:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D62823DF;
	Thu,  3 Oct 2024 06:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lj0eTTki"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357B28063C
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 06:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938581; cv=none; b=OfYmSsC/0/vZH7wYWIajN7CnBjcP3x3P0D6Marxt7hFCvouePNcjqxSBo1C474BfhxOvgViQCVutrJc7hrwn7T1Q1UYGoS3MHENjjd5U+IlCJ5nTKEHWbb4UZYUTV32hLHyQcF8qZ1uvUuo7GSBEl/2i0TQMPtqbZ6EapGnkDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938581; c=relaxed/simple;
	bh=5K68wsnaTvwk6apo6pDHtLDll/RXB7gaE0U+4SojQ4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+wP6pAmjpcboFR+s1LbCfY1W7y77YGTWrkJSXutppNFri7Z6QWHpIKmYDKl5YZWzd4ynIS5tU7YcoveC4WBzXQ5574NF9625KDHpKZEi00Kwz2Y/nmMfuMW5IeVbb2VAY0A5IqDV1wlRnGi25C7VErlcxNsbx7L7zQGNOGEnxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lj0eTTki; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4581e0ed0f2so13832751cf.1
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 23:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727938577; x=1728543377; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WPJbhw6j0Y8oi8Zgv4WESRwZSrekvRA4egWDCpY0XbY=;
        b=Lj0eTTkiI/LoghXUvqvDI+unudDXpD2PO55PKFUtgBHsw1wIwUz5dsSGuTbYCBBPpw
         m/NVW6ZsV3aUrX8kl4BitUFcJVx5YJyIniUByMQEIs6oF11SEJWw1UgUgNmJLQbqTaRp
         AKTg1mpjoRq9yixKPlTwAm15lvZcPE7ZxFLPnT/XzRIz20pQqW1gvsUr/98gCr5TzkQz
         eV6kHV/JYaGqv4+uuyFoxqkzEasszoebQBal0K3i+tlG8sQcyMUjXxCR1oQ5Va1mjRkw
         w3moyAQLMfnWfyBvRVj3JCHDoa84IaAv9eFUmyR4hpbvX0adMDeHBoVOYhPNNCsnqxQ2
         HAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938577; x=1728543377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPJbhw6j0Y8oi8Zgv4WESRwZSrekvRA4egWDCpY0XbY=;
        b=NItuMdRjXQXeu/RCUF3rTIFFMzaB2NiCLFgfhZ12dXlTTsTqXlccPufMb2oRnwm/fc
         56v5v0ftRA9zRZ+DqURvFW1ISdCz3IanwSgGgLLuYJY8r1x8BuGNgH9b/DUg1beI40GV
         1+paGmLArjlDiHcx3rDvHdLc+VUljdt6Q2TwaUgSbiZOWovuxfXj9XMpVmp2vtPRBw2W
         R4JdvuMlMmJc9RYxAacumuxcKZQC+f9oLA1hF6/VKehRi3eLIhQ48W6rquLqciskhE/q
         ZejMkuckc1K5359Fq+zWZ0jwjLR/JkqJFvHJmdNsAli3CyWlgc9K8Gguy36z92uZnxGO
         FC2A==
X-Forwarded-Encrypted: i=1; AJvYcCVdLlKCMHGYAe2F/a4L/CfQPwE5IcyN/82fewgxdEl5RRqHCNQXhNN0mjOYpYKnjaBqPOENeUm9+48594RcY98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8zEb4fAFWAX5M+BSzBRec8Q8I9vSj0d1HsZt09iq6OZsfdTn6
	/pYRbNbvqDbNZQJjF1fNrqnTzf3rNNtICCEEts6sucnmvcgtsrDGdM4HfRpyj6WORJ5DA/wBIBo
	wveYHnjAVJlc2aoHlD95uu+lCu1JYaS1/L21YTTw6yWRtaAGgqlgG
X-Google-Smtp-Source: AGHT+IGUiohT/U5YlOmXlzdJpxHCdyp6c9HCXwlNVFJ2yE5Ia0BabKZFdL3kV4+wgM8iSHlXF1CudIKNkyh06IwJq2U=
X-Received: by 2002:a05:6214:5a07:b0:6c7:c646:4b7f with SMTP id
 6a1803df08f44-6cb900ad4c5mr32541406d6.3.1727938576872; Wed, 02 Oct 2024
 23:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917005116.304090-1-arturacb@gmail.com> <20240917005116.304090-2-arturacb@gmail.com>
In-Reply-To: <20240917005116.304090-2-arturacb@gmail.com>
From: David Gow <davidgow@google.com>
Date: Thu, 3 Oct 2024 14:56:05 +0800
Message-ID: <CABVgOSm50-QiygxEGzwXp0QbEPdHJLSA8h5RGr-1MaiovB_4cA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] lib/llist_kunit.c: add KUnit tests for llist
To: Artur Alves <arturacb@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, n@nfraprado.net, 
	andrealmeid@riseup.net, vinicius@nukelet.com, 
	diego.daniel.professional@gmail.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001b014c06238d0d72"

--0000000000001b014c06238d0d72
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Sept 2024 at 08:51, Artur Alves <arturacb@gmail.com> wrote:
>
> Add KUnit tests for the llist data structure. They test the vast
> majority of methods and macros defined in include/linux/llist.h.
>
> These are inspired by the existing tests for the 'list' doubly
> linked in lib/list-test.c. Each test case (llist_test_x) tests
> the behaviour of the llist function/macro 'x'.
>
> Signed-off-by: Artur Alves <arturacb@gmail.com>
> ---

Always nice to see more list tests!

Acked-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/Kconfig.debug       |  11 ++
>  lib/tests/Makefile      |   1 +
>  lib/tests/llist_kunit.c | 358 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 370 insertions(+)
>  create mode 100644 lib/tests/llist_kunit.c
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index b5696659f027..f6bd98f8ce2b 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2813,6 +2813,17 @@ config USERCOPY_KUNIT_TEST
>           on the copy_to/from_user infrastructure, making sure basic
>           user/kernel boundary testing is working.
>
> +config LLIST_KUNIT_TEST
> +       tristate "KUnit tests for lib/llist" if !KUNIT_ALL_TESTS
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This option builds the llist (lock-less list) KUnit test suite.
> +         It tests the API and basic functionality of the macros and
> +         functions defined in <linux/llist.h>.
> +
> +         If unsure, say N.
> +
>  config TEST_UDELAY
>         tristate "udelay test driver"
>         help
> diff --git a/lib/tests/Makefile b/lib/tests/Makefile
> index c6a14cc8663e..8d7c40a73110 100644
> --- a/lib/tests/Makefile
> +++ b/lib/tests/Makefile
> @@ -34,4 +34,5 @@ CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
>  obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
>  obj-$(CONFIG_STRING_KUNIT_TEST) += string_kunit.o
>  obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) += string_helpers_kunit.o
> +obj-$(CONFIG_LLIST_KUNIT_TEST) += llist_kunit.o
>
> diff --git a/lib/tests/llist_kunit.c b/lib/tests/llist_kunit.c
> new file mode 100644
> index 000000000000..817bb2948697
> --- /dev/null
> +++ b/lib/tests/llist_kunit.c
> @@ -0,0 +1,358 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the Kernel lock-less linked-list structure.
> + *
> + * Author: Artur Alves <arturacb@gmail.com>
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/llist.h>
> +
> +#define ENTRIES_SIZE 3
> +
> +struct llist_test_struct {
> +       int data;
> +       struct llist_node node;
> +};
> +
> +static void llist_test_init_llist(struct kunit *test)
> +{
> +       /* test if the llist is correctly initialized */
> +       struct llist_head llist1 = LLIST_HEAD_INIT(llist1);
> +       LLIST_HEAD(llist2);
> +       struct llist_head llist3, *llist4, *llist5;
> +
> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist1));
> +
> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist2));
> +
> +       init_llist_head(&llist3);
> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist3));
> +
> +       llist4 = kzalloc(sizeof(*llist4), GFP_KERNEL | __GFP_NOFAIL);
> +       init_llist_head(llist4);
> +       KUNIT_EXPECT_TRUE(test, llist_empty(llist4));
> +       kfree(llist4);
> +
> +       llist5 = kmalloc(sizeof(*llist5), GFP_KERNEL | __GFP_NOFAIL);
> +       memset(llist5, 0xFF, sizeof(*llist5));
> +       init_llist_head(llist5);
> +       KUNIT_EXPECT_TRUE(test, llist_empty(llist5));
> +       kfree(llist5);
> +}
> +
> +static void llist_test_init_llist_node(struct kunit *test)
> +{
> +       struct llist_node a;
> +
> +       init_llist_node(&a);
> +
> +       KUNIT_EXPECT_PTR_EQ(test, a.next, &a);
> +}
> +
> +static void llist_test_llist_entry(struct kunit *test)
> +{
> +       struct llist_test_struct test_struct, *aux;
> +       struct llist_node *llist = &test_struct.node;
> +
> +       aux = llist_entry(llist, struct llist_test_struct, node);
> +       KUNIT_EXPECT_PTR_EQ(test, &test_struct, aux);
> +}
> +
> +static void llist_test_add(struct kunit *test)
> +{
> +       struct llist_node a, b;
> +       LLIST_HEAD(llist);
> +
> +       init_llist_node(&a);
> +       init_llist_node(&b);
> +
> +       /* The first assertion must be true, given that llist is empty */
> +       KUNIT_EXPECT_TRUE(test, llist_add(&a, &llist));
> +       KUNIT_EXPECT_FALSE(test, llist_add(&b, &llist));
> +
> +       /* Should be [List] -> b -> a */
> +       KUNIT_EXPECT_PTR_EQ(test, llist.first, &b);
> +       KUNIT_EXPECT_PTR_EQ(test, b.next, &a);
> +}
> +
> +static void llist_test_add_batch(struct kunit *test)
> +{
> +       struct llist_node a, b, c;
> +       LLIST_HEAD(llist);
> +       LLIST_HEAD(llist2);
> +
> +       init_llist_node(&a);
> +       init_llist_node(&b);
> +       init_llist_node(&c);
> +
> +       llist_add(&a, &llist2);
> +       llist_add(&b, &llist2);
> +       llist_add(&c, &llist2);
> +
> +       /* This assertion must be true, given that llist is empty */
> +       KUNIT_EXPECT_TRUE(test, llist_add_batch(&c, &a, &llist));
> +
> +       /* should be [List] -> c -> b -> a */
> +       KUNIT_EXPECT_PTR_EQ(test, llist.first, &c);
> +       KUNIT_EXPECT_PTR_EQ(test, c.next, &b);
> +       KUNIT_EXPECT_PTR_EQ(test, b.next, &a);
> +}
> +
> +static void llist_test_llist_next(struct kunit *test)
> +{
> +       struct llist_node a, b;
> +       LLIST_HEAD(llist);
> +
> +       init_llist_node(&a);
> +       init_llist_node(&b);
> +
> +       llist_add(&a, &llist);
> +       llist_add(&b, &llist);
> +
> +       /* should be [List] -> b -> a */
> +       KUNIT_EXPECT_PTR_EQ(test, llist_next(&b), &a);
> +       KUNIT_EXPECT_NULL(test, llist_next(&a));
> +}
> +
> +static void llist_test_empty_llist(struct kunit *test)
> +{
> +       struct llist_head llist = LLIST_HEAD_INIT(llist);
> +       struct llist_node a;
> +
> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
> +
> +       llist_add(&a, &llist);
> +
> +       KUNIT_EXPECT_FALSE(test, llist_empty(&llist));
> +}
> +
> +static void llist_test_llist_on_list(struct kunit *test)
> +{
> +       struct llist_node a, b;
> +       LLIST_HEAD(llist);
> +
> +       init_llist_node(&a);
> +       init_llist_node(&b);
> +
> +       llist_add(&a, &llist);
> +
> +       /* should be [List] -> a */
> +       KUNIT_EXPECT_TRUE(test, llist_on_list(&a));
> +       KUNIT_EXPECT_FALSE(test, llist_on_list(&b));
> +}
> +
> +static void llist_test_del_first(struct kunit *test)
> +{
> +       struct llist_node a, b, *c;
> +       LLIST_HEAD(llist);
> +
> +       llist_add(&a, &llist);
> +       llist_add(&b, &llist);
> +
> +       /* before: [List] -> b -> a */
> +       c = llist_del_first(&llist);
> +
> +       /* should be [List] -> a */
> +       KUNIT_EXPECT_PTR_EQ(test, llist.first, &a);
> +
> +       /* del must return a pointer to llist_node b
> +        * the returned pointer must be marked on list
> +        */
> +       KUNIT_EXPECT_PTR_EQ(test, c, &b);
> +       KUNIT_EXPECT_TRUE(test, llist_on_list(c));
> +}
> +
> +static void llist_test_del_first_init(struct kunit *test)
> +{
> +       struct llist_node a, *b;
> +       LLIST_HEAD(llist);
> +
> +       llist_add(&a, &llist);
> +
> +       b = llist_del_first_init(&llist);
> +
> +       /* should be [List] */
> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
> +
> +       /* the returned pointer must be marked out of the list */
> +       KUNIT_EXPECT_FALSE(test, llist_on_list(b));
> +}
> +
> +static void llist_test_del_first_this(struct kunit *test)
> +{
> +       struct llist_node a, b;
> +       LLIST_HEAD(llist);
> +
> +       llist_add(&a, &llist);
> +       llist_add(&b, &llist);
> +
> +       llist_del_first_this(&llist, &a);
> +
> +       /* before: [List] -> b -> a */
> +
> +       // should remove only if is the first node in the llist
> +       KUNIT_EXPECT_FALSE(test, llist_del_first_this(&llist, &a));
> +
> +       KUNIT_EXPECT_TRUE(test, llist_del_first_this(&llist, &b));
> +
> +       /* should be [List] -> a */
> +       KUNIT_EXPECT_PTR_EQ(test, llist.first, &a);
> +}
> +
> +static void llist_test_del_all(struct kunit *test)
> +{
> +       struct llist_node a, b;
> +       LLIST_HEAD(llist);
> +       LLIST_HEAD(empty_llist);
> +
> +       llist_add(&a, &llist);
> +       llist_add(&b, &llist);
> +
> +       /* deleting from a empty llist should return NULL */
> +       KUNIT_EXPECT_NULL(test, llist_del_all(&empty_llist));
> +
> +       llist_del_all(&llist);
> +
> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
> +}
> +
> +static void llist_test_for_each(struct kunit *test)
> +{
> +       struct llist_node entries[ENTRIES_SIZE] = { 0 };
> +       struct llist_node *pos, *deleted_nodes;
> +       LLIST_HEAD(llist);
> +       int i = 0, j = 0;
> +
> +       for (int i = ENTRIES_SIZE - 1; i >= 0; i--)
> +               llist_add(&entries[i], &llist);
> +
> +       /* before [List] -> entries[0] -> ... -> entries[ENTRIES_SIZE - 1] */
> +       llist_for_each(pos, llist.first) {
> +               KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
> +       }
> +
> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
> +
> +       /* traversing deleted nodes */
> +       deleted_nodes = llist_del_all(&llist);
> +
> +       llist_for_each(pos, deleted_nodes) {
> +               KUNIT_EXPECT_PTR_EQ(test, pos, &entries[j++]);
> +       }
> +
> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, j);
> +}
> +
> +static void llist_test_safe_for_each(struct kunit *test)
> +{
> +       struct llist_node entries[ENTRIES_SIZE];
> +       struct llist_node *pos, *n;
> +       LLIST_HEAD(llist);
> +       int i = 0;
> +
> +       for (int i = ENTRIES_SIZE - 1; i >= 0; i--)
> +               llist_add(&entries[i], &llist);
> +
> +       llist_for_each_safe(pos, n, llist.first) {
> +               KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
> +               llist_del_first(&llist);
> +       }
> +
> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
> +}
> +
> +static void llist_test_entry_for_each(struct kunit *test)
> +{
> +       struct llist_test_struct entries[ENTRIES_SIZE], *pos;
> +       LLIST_HEAD(llist);
> +       int i = 0;
> +
> +       for (int i = ENTRIES_SIZE - 1; i >= 0; --i) {
> +               entries[i].data = i;
> +               llist_add(&entries[i].node, &llist);
> +       }
> +
> +       i = 0;
> +
> +       llist_for_each_entry(pos, llist.first, node) {
> +               KUNIT_EXPECT_EQ(test, pos->data, i);
> +               i++;
> +       }
> +
> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
> +}
> +
> +static void llist_test_entry_safe_for_each(struct kunit *test)
> +{
> +       struct llist_test_struct entries[ENTRIES_SIZE], *pos, *n;
> +       LLIST_HEAD(llist);
> +       int i = 0;
> +
> +       for (int i = ENTRIES_SIZE - 1; i >= 0; --i) {
> +               entries[i].data = i;
> +               llist_add(&entries[i].node, &llist);
> +       }
> +
> +       i = 0;
> +
> +       llist_for_each_entry_safe(pos, n, llist.first, node) {
> +               KUNIT_EXPECT_EQ(test, pos->data, i++);
> +               llist_del_first(&llist);
> +       }
> +
> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
> +       KUNIT_EXPECT_TRUE(test, llist_empty(&llist));
> +}
> +
> +static void llist_test_reverse_order(struct kunit *test)
> +{
> +       struct llist_node entries[ENTRIES_SIZE], *pos, *reversed_llist;
> +       LLIST_HEAD(llist);
> +       int i = 0;
> +
> +       for (int i = 0; i < ENTRIES_SIZE; i++)
> +               llist_add(&entries[i], &llist);
> +
> +       /* before [List] -> entries[2] -> entries[1] -> entries[0] */
> +       reversed_llist = llist_reverse_order(llist_del_first(&llist));
> +
> +       /* should be [List] -> entries[0] -> entries[1] -> entries[2] */
> +       llist_for_each(pos, reversed_llist) {
> +               KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
> +       }
> +
> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
> +}
> +
> +static struct kunit_case llist_test_cases[] = {
> +       KUNIT_CASE(llist_test_init_llist),
> +       KUNIT_CASE(llist_test_init_llist_node),
> +       KUNIT_CASE(llist_test_llist_entry),
> +       KUNIT_CASE(llist_test_add),
> +       KUNIT_CASE(llist_test_add_batch),
> +       KUNIT_CASE(llist_test_llist_next),
> +       KUNIT_CASE(llist_test_empty_llist),
> +       KUNIT_CASE(llist_test_llist_on_list),
> +       KUNIT_CASE(llist_test_del_first),
> +       KUNIT_CASE(llist_test_del_first_init),
> +       KUNIT_CASE(llist_test_del_first_this),
> +       KUNIT_CASE(llist_test_del_all),
> +       KUNIT_CASE(llist_test_for_each),
> +       KUNIT_CASE(llist_test_safe_for_each),
> +       KUNIT_CASE(llist_test_entry_for_each),
> +       KUNIT_CASE(llist_test_entry_safe_for_each),
> +       KUNIT_CASE(llist_test_reverse_order),
> +       {}
> +};
> +
> +static struct kunit_suite llist_test_suite = {
> +       .name = "llist",
> +       .test_cases = llist_test_cases,
> +};
> +
> +kunit_test_suite(llist_test_suite);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("KUnit tests for the llist data structure.");
> --
> 2.46.0
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20240917005116.304090-2-arturacb%40gmail.com.

--0000000000001b014c06238d0d72
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
erg7AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKFQnbTpSq0q
cOYnlrbegXJIIvA6MFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBR
nRJBmUP+IpudtmSQ/R55Sv0qv8TO9zHTlIdsIf2Gc/zeCi0SamUQkFWb01d7Q+20kcpxNzwV6M7y
hDRk5uuVFvtVxOrmbhflCo0uBpD9vz/symtfJYZLNyvSDi1PIVrwGNpyRrD0W6VQJxzzsBTwsO+S
XWN3+x70+QDf7+zovW7KF0/y8QYD6PIN7Y9LRUXct0HKhatkHmO3w6MSJatnqSvsjffIwpNecUMo
h10c6Etz17b7tbGdxdxLw8njN+UnfoFp3v4irrafB6jkArRfsR5TscZUUKej0ihl7mXEKUBmClkP
ndcbXHFxS6WTkpjvl7Jjja8DdWJSJmdEWUnFjnQnDrqLqvYjeVMS/8IBF57eyT6yEPrMzA+Zd+f5
hnM7HuBSGvVHv+c/rlHVp0S364DBGXj11obl7nKgL9D59QwC5/kNJ1whoKwsATUSepanzALdOTn3
BavXUVE38e4c90il44T1bphqtLfmHZ1T5ZwxjtjzNMKy0Mb9j/jcFxfibCISYbnk661FBe38bhYj
0DhqINx2fw0bwhpfFGADOZDe5DVhI7AIW/kEMHuIgAJ/HPgyn1+tldOPWiFLQbTNNBnfGv9sDPz0
hWV2vSAXq35i+JS06BCkbGfE5ci6zFy4pt8fmqMGKFH/t3ELCTYo116lqUTDcVC8DAWN8E55aDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAZ6Vqszmp/3gGFW0sCFu
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgd5/lB4eHvQR0jhT3J2rfBWsuGoKF
n5OMhxVrs0eX1t4wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MDAzMDY1NjE3WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAJveUwMTF5NE5QloYGUHDjiM1jqQI1V80xXWM5e41nZ1CcoF
3jD6/fmRD/PY6ZjneedffIj0XzKrfkh6aMigRfkEx42a+2T9Wu4Ahy8sMpQNK/ID8kJ7fO+IrE1w
Bn4qqmDcCS35+/PXhx89KNcHqTjSTqpXcxKYOxqorw7a0yw1QVl5PFIQ+2qHy4bWJONx0Tcd3cGv
LD9Z0HbLIPLQ8+I/RztTEHVIRX6lXevt0gc6GluU+FTf0UbUCJwNOxA2Lu7hR/qa9hbU3ATxaAbD
JcDJOJURAfUahfDPTpWS84D29w0jcF81rCl85f0N+HJ/RiV/m5vg+A91Su97U1tt0vM=
--0000000000001b014c06238d0d72--

