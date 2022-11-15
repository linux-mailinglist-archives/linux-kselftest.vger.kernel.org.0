Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E25962A10E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 19:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiKOSHV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 13:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiKOSHQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 13:07:16 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5C413F28
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 10:07:15 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3691e040abaso144462797b3.9
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 10:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dloXDD6CiDCziJT2tHzl/Z+qUNepzcAu8WiV9q7UGjY=;
        b=JYgZvPF0ht9E2Q56igI2aIXCY5xA0bGmnckBjD/RIFHLRkjtv+/pzXCHaKmZK8RC7T
         6nUGxAAbze5gI9EG7y5ZeS91Bjcq/ugdpKVdvkPU8iQZyglm6cX4SR3aE4ZsaCVXLqMP
         zZhIz9hAmeTrQ7lJfst/DoWgh42xSvNNX6OE5Up7hw/mziRWidAHgSkSxaNbKcw93dtd
         1y+zFP3GPZTnVy6MQz9QEAbvl7MaC0lbNSm6CLtg/0DJc7RIt5bOGrTNMbeif4XsbXPu
         MBuJ26Zik/sPd/TWdYNnzMdJ/ofCt5U6qktYv7fHZIzqh+IUBTqpxihgAGdnGMxfKRLO
         nUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dloXDD6CiDCziJT2tHzl/Z+qUNepzcAu8WiV9q7UGjY=;
        b=hqS3EikOztZ1WO9kv88RBTNqiovmII7yfI9tnbTYUiUYsMS67SDpdOqLtux9IBJXCn
         xHai16JAwv1/C1Grp1JnPapODf0YLntydB0v0MkLhin2eQGPAEky9aZH0M0PXinKLJ0l
         7CxX0JpAmfNYKWZWZkfHWt50vz/WYbYpiM+eOIzyyC4BCk2sGeXQAMJfQlziuv5VGTcs
         OkNQl50Fx7OAUqC0RvKzlhbNjRXXaBCHsMqtYNeFCw63TY/HP/ltR2+gKLjaLp0kxjDb
         3rEgu4B8g78uKDan2wyNa7mYnlDsujd0qu1AGmqzNAvzUfvq4oiOR67FkFn9MiFQP0A1
         rPFg==
X-Gm-Message-State: ANoB5pkhDXPdxjRmuIfPdOpNdj8NHk2KmcC2NTd/d8P0CXyHw2/m6d6K
        9RxGlonq6+8EkhK+AO/ITZgSIcFVbsiojIG4OVoH3A==
X-Google-Smtp-Source: AA0mqf4eWcPEGrD/dKTwKKb8SfJskKxs+GrsMWE7+Jy0X4Q+pH06qzBSv/lfxAmwZDszEFO8l9OxBl9MHikt764urVs=
X-Received: by 2002:a81:351:0:b0:344:ff29:4526 with SMTP id
 78-20020a810351000000b00344ff294526mr18583621ywd.63.1668535634314; Tue, 15
 Nov 2022 10:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20221109003618.3784591-1-dlatypov@google.com> <20221109003618.3784591-2-dlatypov@google.com>
 <CAO2JNKUTiVM8YPgy0nz7W1GJtSVURhc1YkMgUWgs-rShNY0Zaw@mail.gmail.com>
 <CAGS_qxqPUHWyJ4nNQRdm79sMwHwysHV=99WXzMsY=g_WzSjZaw@mail.gmail.com> <CABVgOSkJGoyMrv-=Zd+8sveH0+04G4twmae+p+TJWdpB6SJ+FQ@mail.gmail.com>
In-Reply-To: <CABVgOSkJGoyMrv-=Zd+8sveH0+04G4twmae+p+TJWdpB6SJ+FQ@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 15 Nov 2022 10:07:03 -0800
Message-ID: <CAGS_qxodbGhwrGD-dHmCW7gWdrhFgCxQbrFPvNYMrXU67_ZryQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Documentation: KUnit: reword description of assertions
To:     David Gow <davidgow@google.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>, brendanhiggins@google.com,
        rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 14, 2022 at 11:45 PM David Gow <davidgow@google.com> wrote:

<snip>

> +1 for the patch from me (modulo the "we" typo Sadiya mentioned).
>
> I otherwise also prefer Daniel's original here (though I'd possibly
> merge it into one sentence, personally).
> Maybe:
> "In this example, as we need to be able to allocate an array in order
> to test the sort function, we use ``KUNIT_ASSERT_NOT_ERR_OR_NULL()``
> to abort the test if there's an allocation error."
> or
> "In this example, we need to allocate an array to test the sort
> function. We therefore use ``KUNIT_ASSERT_NOT_ERR_OR_NULL()``, which
> will automatically abort the test if there's an allocation error."
>
> But any of the above wordings are fine for me.
>
> The note about ASSERT() working in any function is useful, though
> there are definitely some "gotcha"s caused by killing the kthread
> we'll need to resolve. (If there are any dangling references to things
> on the stack, for example.) Still, not an issue for this bit of
> documentation.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> (Once the "we" typo is fixed.)

v3 is here, PTAL
https://lore.kernel.org/all/20221111182906.1377191-2-dlatypov@google.com/

Copying the relevant section here:
+In this example, we need to be able to allocate an array to test the ``sort()``
+function. So we use ``KUNIT_ASSERT_NOT_ERR_OR_NULL()`` to abort the test if
+there's an allocation error.
+
+.. note::
+   In other test frameworks, ``ASSERT`` macros are often implemented by calling
+   ``return`` so they only work from the test function. In KUnit, we stop the
+   current kthread on failure, so you can call them from anywhere.

Daniel
