Return-Path: <linux-kselftest+bounces-17331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A81A596E46F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 22:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3889B1F234B3
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 20:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B381A4F14;
	Thu,  5 Sep 2024 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nftJfdQU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B911A4F13
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Sep 2024 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569492; cv=none; b=Bg5MDK+sgRx3I8rZY+OFQA5Hwi9kpQgpk8nJtLwx8ubKDOyFs4TOrLg7DwMojV6yAwB5caA7W8z5XG0ElCMh72s2+ZDd6bdmcgUK341p/Fl5f7r4BjbYKEwejfkbQiUHGtPyQ81XjsFpH5BK4PeLYxI/LIVL456ocfoi09sDpMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569492; c=relaxed/simple;
	bh=aHCKN+uFTlS4Ro2488jVZdgIUGWhcY26L/AKMoZpZWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sy/5oqztjamt9TPhEQYq9uwhtC2k/4WXBv0Yi4Nf4k0oQBxJUvqIcaJMsQbPDgoHw4MqOWJwqJGWdurua+xOluD8tFsEYzfygSa4Jop2wdO6tcPKnbif3LXO3UCFBGOiiY00EESM3aM2BTXo7WfgO/Y3t8RJFVf9U9UIEqaQ4ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nftJfdQU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2068a7c9286so12500255ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Sep 2024 13:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725569488; x=1726174288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F33YSQnuZYPeljqM4rutMIlrPkVJHZGOX8c/cjeo/LE=;
        b=nftJfdQU2kv2Vp08m3Y4mA3mJyd54Bve0DyoZY/paa8hkO5mez8ZpsX8dk48BJ2i5f
         C1aYVLGCOCzaC1qCRLMXhXE40tZVIXtmK5Ugef5tqOKgLd9YY4o07ivF5gzkFgTyuHJI
         nGrqUyJF/oqZCeh70piyPiJF4wLbrSDE/9fJpj2369fTMR5T48isW+C42M2MBlJBVinP
         WEjZ1id0betffPdBbHt3xC6bKUoB+sqfQBMi0P6cPrbh3+jI8GUjPg4xE31GQa474Med
         jojyzJY/S7visp2CpildWQ41YWcHF6NY9jg7T+s7OCMS+6RyfW5Xb5wGkQcDSEzqG0gQ
         EepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725569488; x=1726174288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F33YSQnuZYPeljqM4rutMIlrPkVJHZGOX8c/cjeo/LE=;
        b=GZYGWHvqlhAYV+o7jG+ZpdJ2N0ksLXEWDFKUsGteH8jxQTyLwctkeBEL8AqO5/qvlw
         c1yjPD1l5JLitUOGU0kgOa25X0+ZiSOkkPpUO7tXIkCrynqom9EJSFJfnUEQe7ZY5ehH
         K1At1AaTUwt0sS+eT+Uqe9+z8grdiy1+8SJ9vDR06lQDo2/vnsLHgYOPsVctQMcOCAMV
         dBZdF76N9mJia37r+T5bSJRWp0QIax4DjRXwHqBujG94p18N6M6fmRqRSEHhlix9Ba48
         krSvDkExFCput1J9VIrbgEXvSvJxOCKdRn5LwKpKHDfr7HAsZGphbX93PO5vDosjAM0S
         qRWA==
X-Forwarded-Encrypted: i=1; AJvYcCXgTYIDLSE6UzXW4WUXkgIpaUnQYSMYZ7+E9mhdu/vGWzCEbVGmllCbJ8eNOm7A0O8+t3yw9WiRUcrP+R+PLCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEJQd/Z1axh9q33vcb9ICJVJEndDRxwd8hqnyBTz/1feZNLOQt
	Q3pp8xRkxcO8DwcYJTJ0DmjsD1iwewGXW8BsmaAcFHI+Hhh7XJBV+boInqOCZw0ubZsUek+yG6n
	ZunkgYy1W352DTpA+FCstIq6/imGyj0JLrH79
X-Google-Smtp-Source: AGHT+IEEq/BjGu3FKjTY9wg98+0umF6hB356dS+sjM2gWqEzafBJp1HqFQu8jX8BmmiPdydRKuyOniEcMhJBwoPs7wA=
X-Received: by 2002:a17:902:e882:b0:205:5eaf:99e7 with SMTP id
 d9443c01a7336-206f05b330cmr3072895ad.38.1725569488031; Thu, 05 Sep 2024
 13:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903214027.77533-1-arturacb@gmail.com> <20240903214027.77533-2-arturacb@gmail.com>
In-Reply-To: <20240903214027.77533-2-arturacb@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Thu, 5 Sep 2024 16:51:15 -0400
Message-ID: <CA+GJov4cAdvmVCHh4xcSVWKg0e3Drs7GB7jMW0btciwCUEJFgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] lib/llist_kunit.c: add KUnit tests for llist
To: Artur Alves <arturacb@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, n@nfraprado.net, 
	andrealmeid@riseup.net, vinicius@nukelet.com, 
	diego.daniel.professional@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 5:40=E2=80=AFPM Artur Alves <arturacb@gmail.com> wro=
te:
>
> Add KUnit tests for the llist data structure. They test the vast
> majority of methods and macros defined in include/linux/llist.h.
>
> These are inspired by the existing tests for the 'list' doubly
> linked in lib/list-test.c [1]. Each test case (llist_test_x)
> tests the behaviour of the llist function/macro 'x'.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/lib/list-test.c?h=3Dv6.11-rc6
>
> Signed-off-by: Artur Alves <arturacb@gmail.com>

Hello!

Thanks for creating this new test! It looks really good and is passing
all the tests.

My main comment is that this patch is causing some checkpatch warnings:

  WARNING: Prefer a maximum 75 chars per line (possible unwrapped
commit description?)
  #13:
  [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/lib/list-test.c?h=3Dv6.11-rc6

It's probably fine to ignore this warning as it is a link. But I might
remove the link because it is not absolutely necessary in this case.

  WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
  #58:
  new file mode 100644

  ERROR: that open brace { should be on the previous line
  #306: FILE: lib/llist_kunit.c:249:
  +static void llist_test_for_each_safe(struct kunit *test)
  +{

  ERROR: that open brace { should be on the previous line
  #325: FILE: lib/llist_kunit.c:268:
  +static void llist_test_for_each_entry(struct kunit *test)
  +{

  ERROR: that open brace { should be on the previous line
  #346: FILE: lib/llist_kunit.c:289:
  +static void llist_test_for_each_entry_safe(struct kunit *test)
  +{

These checkpatch errors are mistaken since the open brace should be
where it is. I believe this is getting picked up because of the
"for_each" in the test name. This was fixed for me by rewriting the
test names: from "llist_test_for_each_safe" -> to
"llist_test_safe_for_each", and so on for the other tests with errors.
Sorry it's a pain to change this but I think it is a better fix than
changing the checkpatch script.

> ---
>  lib/Kconfig.debug       |  11 ++
>  lib/tests/Makefile      |   1 +
>  lib/tests/llist_kunit.c | 361 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 373 insertions(+)
>  create mode 100644 lib/tests/llist_kunit.c
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a30c03a66172..b2725daccc52 100644
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
> +         This option builds the "llist_kunit" test module that
> +         helps to verify the correctness of the functions and
> +         macros defined in (<linux/llist.h>).

Also, I think I would prefer if this description was a bit tweaked.
Saying it builds the "module" is confusing since this test might be
run built-in instead. So maybe something more similar to :

This builds the llist (lock-less list) KUnit test suite. It tests the
API and basic functionality of the macros and functions defined in
<linux/llish.h>.

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
> @@ -34,4 +34,5 @@ CFLAGS_stackinit_kunit.o +=3D $(call cc-disable-warning=
, switch-unreachable)
>  obj-$(CONFIG_STACKINIT_KUNIT_TEST) +=3D stackinit_kunit.o
>  obj-$(CONFIG_STRING_KUNIT_TEST) +=3D string_kunit.o
>  obj-$(CONFIG_STRING_HELPERS_KUNIT_TEST) +=3D string_helpers_kunit.o
> +obj-$(CONFIG_LLIST_KUNIT_TEST) +=3D llist_kunit.o
>
> diff --git a/lib/tests/llist_kunit.c b/lib/tests/llist_kunit.c
> new file mode 100644
> index 000000000000..f273c0d175c7
> --- /dev/null
> +++ b/lib/tests/llist_kunit.c
> @@ -0,0 +1,361 @@
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
> +       struct llist_head llist1 =3D LLIST_HEAD_INIT(llist1);
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
> +       llist4 =3D kzalloc(sizeof(*llist4), GFP_KERNEL | __GFP_NOFAIL);
> +       init_llist_head(llist4);
> +       KUNIT_EXPECT_TRUE(test, llist_empty(llist4));
> +       kfree(llist4);
> +
> +       llist5 =3D kmalloc(sizeof(*llist5), GFP_KERNEL | __GFP_NOFAIL);
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
> +       struct llist_node *llist =3D &test_struct.node;
> +
> +       aux =3D llist_entry(llist, struct llist_test_struct, node);
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
> +       struct llist_head llist =3D LLIST_HEAD_INIT(llist);
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
> +       c =3D llist_del_first(&llist);
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
> +       b =3D llist_del_first_init(&llist);
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
> +       struct llist_node entries[ENTRIES_SIZE] =3D { 0 };
> +       struct llist_node *pos, *deleted_nodes;
> +       LLIST_HEAD(llist);
> +       int i =3D 0;
> +
> +       for (int i =3D ENTRIES_SIZE - 1; i >=3D 0; i--)
> +               llist_add(&entries[i], &llist);
> +
> +       /* before [List] -> entries[0] -> ... -> entries[ENTRIES_SIZE - 1=
] */
> +       llist_for_each(pos, llist.first) {
> +               KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
> +       }
> +
> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
> +
> +       i =3D 0;

This is super nitpicky but I think I would prefer if you set two
variables to zero at the beginning rather than reusing "i". So: int i
=3D 0, j =3D 0;

> +
> +       /* traversing deleted nodes */
> +       deleted_nodes =3D llist_del_all(&llist);
> +
> +       llist_for_each(pos, deleted_nodes) {
> +               KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
> +       }
> +
> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
> +}
> +
> +static void llist_test_for_each_safe(struct kunit *test)
> +{
> +       struct llist_node entries[ENTRIES_SIZE] =3D { 0 };

I'm not sure if it is necessary to initialize this to be zeros.

> +       struct llist_node *pos, *n;
> +       LLIST_HEAD(llist);
> +       int i =3D 0;
> +
> +       for (int i =3D ENTRIES_SIZE - 1; i >=3D 0; i--)
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
> +static void llist_test_for_each_entry(struct kunit *test)
> +{
> +       struct llist_test_struct entries[ENTRIES_SIZE], *pos;
> +       LLIST_HEAD(llist);
> +       int i =3D 0;
> +
> +       for (int i =3D ENTRIES_SIZE - 1; i >=3D 0; --i) {
> +               entries[i].data =3D i;
> +               llist_add(&entries[i].node, &llist);
> +       }
> +
> +       i =3D 0;
> +
> +       llist_for_each_entry(pos, llist.first, node) {
> +               KUNIT_EXPECT_EQ(test, pos->data, i);
> +               i++;
> +       }
> +
> +       KUNIT_EXPECT_EQ(test, ENTRIES_SIZE, i);
> +}
> +
> +static void llist_test_for_each_entry_safe(struct kunit *test)
> +{
> +       struct llist_test_struct entries[ENTRIES_SIZE], *pos, *n;
> +       LLIST_HEAD(llist);
> +       int i =3D 0;
> +
> +       for (int i =3D ENTRIES_SIZE - 1; i >=3D 0; --i) {
> +               entries[i].data =3D i;
> +               llist_add(&entries[i].node, &llist);
> +       }
> +
> +       i =3D 0;
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
> +       struct llist_node entries[3], *pos, *reversed_llist;

Rather than using the "3" here I would prefer using the ENTRIES_SIZE.

> +       LLIST_HEAD(llist);
> +       int i =3D 0;
> +
> +       llist_add(&entries[0], &llist);
> +       llist_add(&entries[1], &llist);
> +       llist_add(&entries[2], &llist);
> +
> +       /* before [List] -> entries[2] -> entries[1] -> entries[0] */
> +       reversed_llist =3D llist_reverse_order(llist_del_first(&llist));
> +
> +       /* should be [List] -> entries[0] -> entries[1] -> entrires[2] */

Small typo in this comment: "entries"

> +       llist_for_each(pos, reversed_llist) {
> +               KUNIT_EXPECT_PTR_EQ(test, pos, &entries[i++]);
> +       }
> +
> +       KUNIT_EXPECT_EQ(test, 3, i);

Same here with the use of the "3".

> +}
> +
> +static struct kunit_case llist_test_cases[] =3D {
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
> +       KUNIT_CASE(llist_test_for_each_safe),
> +       KUNIT_CASE(llist_test_for_each_entry),
> +       KUNIT_CASE(llist_test_for_each_entry_safe),
> +       KUNIT_CASE(llist_test_reverse_order),
> +       {}
> +};
> +
> +static struct kunit_suite llist_test_suite =3D {
> +       .name =3D "llist",
> +       .test_cases =3D llist_test_cases,
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
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20240903214027.77533-2-arturacb%40gmail.com.

