Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958686CFB5B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 08:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjC3GPj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 02:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjC3GPi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 02:15:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A7D40DD
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 23:15:36 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so10981810wms.2
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Mar 2023 23:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680156935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RIJDUVO0m8Cv5zLAcz05YzJtBwOHUS69WkPj4QU2/Uc=;
        b=q8XOrHpgYTzo7j2z6TdpRJNFVXiWCDV0dYJosb6kilBvbwdReh3NOZzOSH2KQLb0Dp
         6bvxaxYPTIwihvlhrrult/g2XPSmRhbdkAY0TE0l2mpPdr4t2i+5gp+znds30ejRM7j6
         GnRjkgLmjYR18zwMlU+twMCpAwPMYkbQ2qD57q99NRYV6zqTAvpKGQ+3WHUn02onAiI9
         UJuCelgrE09tYKwuQkhXXcMdC7S5hdSF3dTzrfyOiNGVwFO+EB5JzmynojfeL2mDEpYO
         mJjnvF54zrUxRHD2/FtDNQtglNwPg4wbOUSxkZBu0XgQEjRcOERW1Vckk5CTnYInEYxP
         j5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680156935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIJDUVO0m8Cv5zLAcz05YzJtBwOHUS69WkPj4QU2/Uc=;
        b=2dYBDh4/m70+I8E0LhxR5K0pvsl6WzYKCrKFiKnx7XuIw30yWW1ffXdcMA3uFSW/xL
         lPnl5ZHUIsPzxPYu/ESjynS7+QUk8A95ynPgXr4e9je4sJcpIB3mHO4AWjSFixX/mBg6
         GymAXYg0breH5hh1lpOYmn6cDGqJWATnEhkDO3jRpvxINGWRP0VNZFmcBWSizPQc/r+L
         Dq6lZ9vABremYgdpomE+pB9WvR97cw+o76gNe7Dbl1zYEhdxQxfNmzdtDSjrfuu1udR2
         Nb6wKxGyyUBv6MTRiW1pEI+GgcR16J05rawr5pObzDFQ9gIT2r1V7RC9bfxkQqXOHJxQ
         9hmA==
X-Gm-Message-State: AAQBX9djtFxsWaDe12HHMt6I0194TBTRJ+mcDUdYu9DN49TzWeW7nh3u
        ShwZpC/LbkKp+oxK8iyjk6QTm/2KsGtndvuLDnWL01F3izqmlnQzLiT6nM3M
X-Google-Smtp-Source: AKy350atIttQju6EGral441ZvbRBLspnqbHHxW+eNiNG5+EpvxoFjzJbIvPACjNvrC44k4/QWYWkC+o25FF/w7RTfFw=
X-Received: by 2002:a05:600c:1ca2:b0:3ed:dc54:5c18 with SMTP id
 k34-20020a05600c1ca200b003eddc545c18mr1883435wms.3.1680156934861; Wed, 29 Mar
 2023 23:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230329110723.3458843-1-sadiyakazi@google.com>
In-Reply-To: <20230329110723.3458843-1-sadiyakazi@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 30 Mar 2023 14:15:22 +0800
Message-ID: <CABVgOS=Vhigp8bHVij9kRyEZDzDzLafz2O6LT471RSLHctRsGg@mail.gmail.com>
Subject: Re: [PATCH v1] list: test: Test the klist structure
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004bd63005f81805ee"
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

--0000000000004bd63005f81805ee
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Mar 2023 at 19:07, Sadiya Kazi <sadiyakazi@google.com> wrote:
>
> Add KUnit tests to the klist linked-list structure.
> These perform testing for different variations of node add
> and node delete in the klist data structure (<linux/klist.h>).
>
> Limitation: Since we use a static global variable, and if
> multiple instances of this test are run concurrently, the test may fail.
>
> Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
> ---

Thanks very much! This will be a great addition to the list tests (and
the device model tests).

A couple of super-minor suggestions re: comment formatting, otherwise
good-to-go.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/list-test.c | 298 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 297 insertions(+), 1 deletion(-)
>
> diff --git a/lib/list-test.c b/lib/list-test.c
> index d374cf5d1a57..af651cacb8f4 100644
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
> @@ -1199,6 +1200,301 @@ static struct kunit_suite hlist_test_module = {
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
> +/* counts the number of nodes*/

This comment doesn't really add anything,

> +static int node_count;
> +static struct klist_node *last_node_count;

This isn't a count... can we rename it?

> +
> +static void check_node(struct klist_node *node_ptr)
> +{
> +       node_count++;
> +       last_node_count = node_ptr;
> +}
> +
> +static void check_delete_node(struct klist_node *node_ptr)
> +{
> +       node_count--;
> +       last_node_count = node_ptr;
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
> +       KUNIT_EXPECT_PTR_EQ(test, last_node_count, &a);
> +
> +       klist_add_tail(&b, &mylist);
> +       KUNIT_EXPECT_EQ(test, node_count, 2);
> +       KUNIT_EXPECT_PTR_EQ(test, last_node_count, &b);
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
> +       KUNIT_EXPECT_PTR_EQ(test, last_node_count, &a);
> +
> +       klist_add_head(&b, &mylist);
> +       KUNIT_EXPECT_EQ(test, node_count, 2);
> +       KUNIT_EXPECT_PTR_EQ(test, last_node_count, &b);
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
> +       KUNIT_EXPECT_PTR_EQ(test, last_node_count, &c);
> +
> +       klist_add_behind(&d, &b);
> +       KUNIT_EXPECT_EQ(test, node_count, 4);
> +       KUNIT_EXPECT_PTR_EQ(test, last_node_count, &d);
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
> +       KUNIT_EXPECT_PTR_EQ(test, last_node_count, &c);
> +
> +       klist_add_before(&d, &b);
> +       KUNIT_EXPECT_EQ(test, node_count, 4);
> +       KUNIT_EXPECT_PTR_EQ(test, last_node_count, &d);
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
> +/* Verify that klist_del() delays the deletion of a node until there
> + * are no other references to it
> + */

These comments are in the wrong style:
https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting

They should be of the form:
/*
 * Text
 * More text
 */
(with the empty line at the top)

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
> +       KUNIT_EXPECT_PTR_EQ(test, last_node_count, &d);
> +
> +       klist_iter_exit(&i);
> +
> +       /* Since the iterator is no longer pointing to node c, node c is removed
> +        * from the list
> +        */

Nit: comment formatting. The comment above ("Verify that node c...") looks good.

> +       KUNIT_EXPECT_EQ(test, node_count, 3);
> +       KUNIT_EXPECT_PTR_EQ(test, last_node_count, &c);
> +
> +}
> +
> +/* Verify that klist_del() deletes a node immediately when there are no
> + * other references to it.
> + */

As above, comment formatting.

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
> +       KUNIT_EXPECT_PTR_EQ(test, last_node_count, &c);
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
> +       KUNIT_EXPECT_PTR_EQ(test, last_node_count, &c);
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

--0000000000004bd63005f81805ee
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
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCZ
Eg3aLG7p2QcWXYlTFMcwmNtIsVQMZyeF/RsRqjiwejAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMzAwNjE1MzVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAHKOqELkVurbBaZXF4xSm
ZsHHDANXAH6bHr/1lfZBcvjH9FTGFMYl+cibYcK3wLXT3lSZBrdl3Zbc0EIoBQp0ADXxLMoZDsEi
kT80NjIWpcAR+7fTis5qgGPJS9LaBN3eFfsggdlVwx58ovZM6WowTPCLzUn7wYESqK5feUFh85jw
4QRvt0aeEArXwMuE0jKYCnJp77HbeDKHTz7TknjtryEQrEmJTN9crul0HlZTCtOqvVe6M54BlwKS
6DaSRuAXf4bGdyB/LyEryBXPXw1Vs3pC5rJ4fPFctmRQUYnE80Xwu9ByUKt2fXLGYcvqWBQvATJd
ZwW3VGhptUcLJNguHA==
--0000000000004bd63005f81805ee--
