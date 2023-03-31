Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB3D6D196C
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 10:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjCaII6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Mar 2023 04:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjCaII5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Mar 2023 04:08:57 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358F61B7D6
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 01:08:54 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id h7so11147672ila.5
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Mar 2023 01:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680250134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4JrPnnlxGtgK3TxnRZx3p1rRWXhGmJ/tQJF9cCTKqL0=;
        b=qAZxrkJxtjF6XW9g2pBUWoleGtVEMWfSwM4IRMxnRZLPcS06/fRpYmoARmvlqZYm1m
         flAZeh3PWPHBhr1QybdbAld56weidp3eWkxNHdQpOSC4uys01XxVBLCgGjfvJJKsHjCg
         /aejgL2uviK8s0l8QvallS5OwXM4PU/GjYa6CxUk7+g+O8u9zUBvayr8Xbm+SNVt6Z+x
         SgdOUJQuqMhK/Oq5teQvERI7F12+Eq/mY1G+jOWE07S4IKA/i3ny/HUrb3gLztjWjh0s
         nf3p/cqUVIxyZQ4v/tBOGcITAh3HPvYFPIfWmnQkGE60WWVWot03XTspA4LioJ4tTYCf
         dWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680250134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4JrPnnlxGtgK3TxnRZx3p1rRWXhGmJ/tQJF9cCTKqL0=;
        b=ixn0qNR0axM5EdpizqN+agFQHUNzloikBQKQYoLhFATpVeIxteLO5+4sUeeGMWbv6G
         cAwx572ik9wcFc7sSf0R1QMElqRl7jP5EJQE0uae01+UqrCMcpjjerkKkw29cgpGAhvL
         j9xdfkj7dQcK8JqiRlBFGHKOZyoTwsSpVaow1e5LjUfU1lGrnHXgceODdwubsXGzMcKH
         glwfo7V0oUGZkz3Kizl0sxqeSkXlfBrC1ia7VxzsWXfo7Yfy461Mcxn6iSpjzBTZsp+B
         uTUgdeDk/eDOpggNguH3oBoQfYTjcFwAxOj3FZVQcCju1DH5iBBQx1uWIwMUJoY9FfqO
         Njwg==
X-Gm-Message-State: AAQBX9ewMb11MBf5R1pYImRqBCTOLceWAYV9qK0RwNq7vsfm8GlWu6Ei
        9qAtvcjVPZU3nsfHJbThlRm91lgjC7tYNvTdc6hrpA==
X-Google-Smtp-Source: AKy350aLGnhwlA6xGd1wCV7e2FwTACBbcnm5tTRc/zKzwBwOKecQZYKQJuam8DkwaJrhmRn0SErGxlXPq9nqNyQwAdU=
X-Received: by 2002:a05:6e02:de9:b0:313:fa72:d9aa with SMTP id
 m9-20020a056e020de900b00313fa72d9aamr13252138ilj.0.1680250134109; Fri, 31 Mar
 2023 01:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230331064528.3764174-1-sadiyakazi@google.com>
In-Reply-To: <20230331064528.3764174-1-sadiyakazi@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 31 Mar 2023 16:08:41 +0800
Message-ID: <CABVgOSnC5rcO-tf6GSwa4Pgkk0wZfhOdWJFdo4xy6Zjn66mULg@mail.gmail.com>
Subject: Re: [PATCH v2] list: test: Test the klist structure
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000067c03905f82db8ce"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000067c03905f82db8ce
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Mar 2023 at 14:45, Sadiya Kazi <sadiyakazi@google.com> wrote:
>
> Add KUnit tests to the klist linked-list structure.
> These perform testing for different variations of node add
> and node delete in the klist data structure (<linux/klist.h>).
>
> Limitation: Since we use a static global variable, and if
> multiple instances of this test are run concurrently, the test may fail.
>
> Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
> Thank you Brendan and David for reviewing this patch. I have addressed
> the review comments in this iteration.
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20230329110723.3458843-1-sadiyakazi@google.com/
>
> - Corrected the commenting style
> - Deleted the comment /* counts the number of nodes*/
> - Renamed last_node_count to last_node
>
>
> ---

Looks good now, thanks!

-- David

>  lib/list-test.c | 300 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 299 insertions(+), 1 deletion(-)
>
> diff --git a/lib/list-test.c b/lib/list-test.c
> index d374cf5d1a57..0cc27de9cec8 100644
> --- a/lib/list-test.c
> +++ b/lib/list-test.c
> @@ -8,6 +8,7 @@
>  #include <kunit/test.h>
>
>  #include <linux/list.h>
> +#include <linux/klist.h>
>
>  struct list_test_struct {
>         int data;
> @@ -1199,6 +1200,303 @@ static struct kunit_suite hlist_test_module = {
>         .test_cases = hlist_test_cases,
>  };
>
> -kunit_test_suites(&list_test_module, &hlist_test_module);
> +
> +struct klist_test_struct {
> +       int data;
> +       struct klist klist;
> +       struct klist_node klist_node;
> +};
> +
> +static int node_count;
> +static struct klist_node *last_node;
> +
> +static void check_node(struct klist_node *node_ptr)
> +{
> +       node_count++;
> +       last_node = node_ptr;
> +}
> +
> +static void check_delete_node(struct klist_node *node_ptr)
> +{
> +       node_count--;
> +       last_node = node_ptr;
> +}
> +
> +static void klist_test_add_tail(struct kunit *test)
> +{
> +       struct klist_node a, b;
> +       struct klist mylist;
> +       struct klist_iter i;
> +
> +       node_count = 0;
> +       klist_init(&mylist, &check_node, NULL);
> +
> +       klist_add_tail(&a, &mylist);
> +       KUNIT_EXPECT_EQ(test, node_count, 1);
> +       KUNIT_EXPECT_PTR_EQ(test, last_node, &a);
> +
> +       klist_add_tail(&b, &mylist);
> +       KUNIT_EXPECT_EQ(test, node_count, 2);
> +       KUNIT_EXPECT_PTR_EQ(test, last_node, &b);
> +
> +       /* should be [list] -> a -> b */
> +       klist_iter_init(&mylist, &i);
> +
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
> +       KUNIT_EXPECT_NULL(test, klist_next(&i));
> +
> +       klist_iter_exit(&i);
> +
> +}
> +
> +static void klist_test_add_head(struct kunit *test)
> +{
> +       struct klist_node a, b;
> +       struct klist mylist;
> +       struct klist_iter i;
> +
> +       node_count = 0;
> +       klist_init(&mylist, &check_node, NULL);
> +
> +       klist_add_head(&a, &mylist);
> +       KUNIT_EXPECT_EQ(test, node_count, 1);
> +       KUNIT_EXPECT_PTR_EQ(test, last_node, &a);
> +
> +       klist_add_head(&b, &mylist);
> +       KUNIT_EXPECT_EQ(test, node_count, 2);
> +       KUNIT_EXPECT_PTR_EQ(test, last_node, &b);
> +
> +       /* should be [list] -> b -> a */
> +       klist_iter_init(&mylist, &i);
> +
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
> +       KUNIT_EXPECT_NULL(test, klist_next(&i));
> +
> +       klist_iter_exit(&i);
> +
> +}
> +
> +static void klist_test_add_behind(struct kunit *test)
> +{
> +       struct klist_node a, b, c, d;
> +       struct klist mylist;
> +       struct klist_iter i;
> +
> +       node_count = 0;
> +       klist_init(&mylist, &check_node, NULL);
> +
> +       klist_add_head(&a, &mylist);
> +       klist_add_head(&b, &mylist);
> +
> +       klist_add_behind(&c, &a);
> +       KUNIT_EXPECT_EQ(test, node_count, 3);
> +       KUNIT_EXPECT_PTR_EQ(test, last_node, &c);
> +
> +       klist_add_behind(&d, &b);
> +       KUNIT_EXPECT_EQ(test, node_count, 4);
> +       KUNIT_EXPECT_PTR_EQ(test, last_node, &d);
> +
> +       klist_iter_init(&mylist, &i);
> +
> +       /* should be [list] -> b -> d -> a -> c*/
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &d);
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &c);
> +       KUNIT_EXPECT_NULL(test, klist_next(&i));
> +
> +       klist_iter_exit(&i);
> +
> +}
> +
> +static void klist_test_add_before(struct kunit *test)
> +{
> +       struct klist_node a, b, c, d;
> +       struct klist mylist;
> +       struct klist_iter i;
> +
> +       node_count = 0;
> +       klist_init(&mylist, &check_node, NULL);
> +
> +       klist_add_head(&a, &mylist);
> +       klist_add_head(&b, &mylist);
> +       klist_add_before(&c, &a);
> +       KUNIT_EXPECT_EQ(test, node_count, 3);
> +       KUNIT_EXPECT_PTR_EQ(test, last_node, &c);
> +
> +       klist_add_before(&d, &b);
> +       KUNIT_EXPECT_EQ(test, node_count, 4);
> +       KUNIT_EXPECT_PTR_EQ(test, last_node, &d);
> +
> +       klist_iter_init(&mylist, &i);
> +
> +       /* should be [list] -> b -> d -> a -> c*/
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &d);
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &c);
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
> +       KUNIT_EXPECT_NULL(test, klist_next(&i));
> +
> +       klist_iter_exit(&i);
> +
> +}
> +
> +/*
> + * Verify that klist_del() delays the deletion of a node until there
> + * are no other references to it
> + */
> +static void klist_test_del_refcount_greater_than_zero(struct kunit *test)
> +{
> +       struct klist_node a, b, c, d;
> +       struct klist mylist;
> +       struct klist_iter i;
> +
> +       node_count = 0;
> +       klist_init(&mylist, &check_node, &check_delete_node);
> +
> +       /* Add nodes a,b,c,d to the list*/
> +       klist_add_tail(&a, &mylist);
> +       klist_add_tail(&b, &mylist);
> +       klist_add_tail(&c, &mylist);
> +       klist_add_tail(&d, &mylist);
> +
> +       klist_iter_init(&mylist, &i);
> +
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
> +       /* Advance the iterator to point to node c*/
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &c);
> +
> +       /* Try to delete node c while there is a reference to it*/
> +       klist_del(&c);
> +
> +       /*
> +        * Verify that node c is still attached to the list even after being
> +        * deleted. Since the iterator still points to c, the reference count is not
> +        * decreased to 0
> +        */
> +       KUNIT_EXPECT_TRUE(test, klist_node_attached(&c));
> +
> +       /* Check that node c has not been removed yet*/
> +       KUNIT_EXPECT_EQ(test, node_count, 4);
> +       KUNIT_EXPECT_PTR_EQ(test, last_node, &d);
> +
> +       klist_iter_exit(&i);
> +
> +       /*
> +        * Since the iterator is no longer pointing to node c, node c is removed
> +        * from the list
> +        */
> +       KUNIT_EXPECT_EQ(test, node_count, 3);
> +       KUNIT_EXPECT_PTR_EQ(test, last_node, &c);
> +
> +}
> +
> +/*
> + * Verify that klist_del() deletes a node immediately when there are no
> + * other references to it.
> + */
> +static void klist_test_del_refcount_zero(struct kunit *test)
> +{
> +       struct klist_node a, b, c, d;
> +       struct klist mylist;
> +       struct klist_iter i;
> +
> +       node_count = 0;
> +       klist_init(&mylist, &check_node, &check_delete_node);
> +
> +       /* Add nodes a,b,c,d to the list*/
> +       klist_add_tail(&a, &mylist);
> +       klist_add_tail(&b, &mylist);
> +       klist_add_tail(&c, &mylist);
> +       klist_add_tail(&d, &mylist);
> +       /* Delete node c*/
> +       klist_del(&c);
> +
> +       /* Check that node c is deleted from the list*/
> +       KUNIT_EXPECT_EQ(test, node_count, 3);
> +       KUNIT_EXPECT_PTR_EQ(test, last_node, &c);
> +
> +       /* Should be [list] -> a -> b -> d*/
> +       klist_iter_init(&mylist, &i);
> +
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &d);
> +       KUNIT_EXPECT_NULL(test, klist_next(&i));
> +
> +       klist_iter_exit(&i);
> +
> +}
> +
> +static void klist_test_remove(struct kunit *test)
> +{
> +       /* This test doesn't check correctness under concurrent access */
> +       struct klist_node a, b, c, d;
> +       struct klist mylist;
> +       struct klist_iter i;
> +
> +       node_count = 0;
> +       klist_init(&mylist, &check_node, &check_delete_node);
> +
> +       /* Add nodes a,b,c,d to the list*/
> +       klist_add_tail(&a, &mylist);
> +       klist_add_tail(&b, &mylist);
> +       klist_add_tail(&c, &mylist);
> +       klist_add_tail(&d, &mylist);
> +       /* Delete node c*/
> +       klist_remove(&c);
> +
> +       /* Check the nodes in the list*/
> +       KUNIT_EXPECT_EQ(test, node_count, 3);
> +       KUNIT_EXPECT_PTR_EQ(test, last_node, &c);
> +
> +       /* should be [list] -> a -> b -> d*/
> +       klist_iter_init(&mylist, &i);
> +
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &a);
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &b);
> +       KUNIT_EXPECT_PTR_EQ(test, klist_next(&i), &d);
> +       KUNIT_EXPECT_NULL(test, klist_next(&i));
> +
> +       klist_iter_exit(&i);
> +
> +}
> +
> +static void klist_test_node_attached(struct kunit *test)
> +{
> +       struct klist_node a = {};
> +       struct klist mylist;
> +
> +       klist_init(&mylist, NULL, NULL);
> +
> +       KUNIT_EXPECT_FALSE(test, klist_node_attached(&a));
> +       klist_add_head(&a, &mylist);
> +       KUNIT_EXPECT_TRUE(test, klist_node_attached(&a));
> +       klist_del(&a);
> +       KUNIT_EXPECT_FALSE(test, klist_node_attached(&a));
> +
> +}
> +
> +static struct kunit_case klist_test_cases[] = {
> +       KUNIT_CASE(klist_test_add_tail),
> +       KUNIT_CASE(klist_test_add_head),
> +       KUNIT_CASE(klist_test_add_behind),
> +       KUNIT_CASE(klist_test_add_before),
> +       KUNIT_CASE(klist_test_del_refcount_greater_than_zero),
> +       KUNIT_CASE(klist_test_del_refcount_zero),
> +       KUNIT_CASE(klist_test_remove),
> +       KUNIT_CASE(klist_test_node_attached),
> +       {},
> +};
> +
> +static struct kunit_suite klist_test_module = {
> +       .name = "klist",
> +       .test_cases = klist_test_cases,
> +};
> +
> +kunit_test_suites(&list_test_module, &hlist_test_module, &klist_test_module);
>
>  MODULE_LICENSE("GPL v2");
> --
> 2.40.0.348.gf938b09366-goog
>

--00000000000067c03905f82db8ce
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDR
ZhDR1GkiWSb5Ytzh1OQoOucpJxCdscDJqCU+Rh35BTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMzEwODA4NTRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAXQLl5x2IdFNNPBnD4Btv
+wlLySLocKvQoeZwboTSNCJ5DKhQPSZDLijptSP3cMqJXyOWEqJpQ+6/L0ubwG0NcbhdZBFsF8H6
3qjW1CQcb9Q8OrGaP2vBQA+lXKW1uNyVa0uLfGgymTTuIt3PppUwLQ++szX5P08mDiHX1SqFN69I
zneB7qLZxkC1Ls7UaRlnAj9oCt815uHZhc39A5tnTDKqp1jN/7vqJPk/KlpikHojFjyHcZWRcBQ7
fSNroDmrQlJOEhZ9DEKQfc1A9uXlXMoPQ4UqJ/e9txYHrcx8C60gYp2ygqHm3Vw6HzEOCDNeNHYR
GR2LhkYnOVEK89vvjA==
--00000000000067c03905f82db8ce--
