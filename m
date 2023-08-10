Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF47777AE0
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 16:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbjHJOiT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 10:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbjHJOiS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 10:38:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF1626B2
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 07:38:17 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so79165e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 07:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691678296; x=1692283096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/rSFSko1Ell2IsXnK0mfdf1tdTOfrdOtQZjuqb27Lh0=;
        b=wM+sRrw/HBGsyGvgkWXw59Ae3RTYS06bqzvnDTJ3/nQyK8WilBlKlisPIBC9HhwViS
         NFLonCbjpAMTtAgTxE3qYxo/k0XWceirR39a71qLsUz2PqhKMWZjfmFmoKMy4nkKwZjT
         TCGkfmPTeb6jQbKvku0AkY3XR/D/FqmC3PQadw3fyMqhTb1JDDFPORAt97HNn6r6URyv
         15fspW22goip0OqNaUya+xHeIjHdt3NXwHu+CePGCYEFQxVO4+WRZfWy4rEw7TIO/wt/
         blYlbP6L0gvel84dG6He55llEFGlS87whlcVXAUybgNjQKH1qAZ835uoLtXZMqxbGvZh
         9r2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691678296; x=1692283096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/rSFSko1Ell2IsXnK0mfdf1tdTOfrdOtQZjuqb27Lh0=;
        b=c7Q0y1sDrBnFxc78H2QBztuqIFPriDcLzIO3GaU8+/vZu//JjhtOsJJECZjYU4Xo8A
         vxIHxFncvEQzAVYXbApVyaCumOr6eTpGz2vGWJhvTjkxjYuCWTwTIOCr/U43Ez70Tvdo
         f+vDXXLJPMIC5qREW9VA6OeS8OzNf6xZkKgfHgrlA5c3TUosKnAbHNlTI/w9J5lb1z1G
         Lp//AL4BeuPQbsgCTfv6e2Xc+uptn3AoPLhKwnQab/+jA2uVbq3c4286Bf3bAiQEsKp8
         Nc8FxykEUZPfn3A5Mxi4YnxHNGd/hsvsfEmrgI+fCaeix9b47We271MGNvJ3xS70XMoX
         W37Q==
X-Gm-Message-State: AOJu0YwlN/6QrMp1GUzUX5TwPBeMgdcy+1Roc5NpfCrhRZ+/z5hRi73R
        Imnfppxuos+9VRjKOFVcXJaOjGvZeobHDk899v7tCA==
X-Google-Smtp-Source: AGHT+IEWHU2MSP5ol1gNkJqgzpntIOQ9O6rYbWbE1lhuDlmM3GwBEXnrRkel+YhQja2vdZSdhUSoht8NQEPhuc5GrL4=
X-Received: by 2002:a05:600c:3b8f:b0:3f1:70d1:21a6 with SMTP id
 n15-20020a05600c3b8f00b003f170d121a6mr237435wms.0.1691678295931; Thu, 10 Aug
 2023 07:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230809155438.22470-1-rf@opensource.cirrus.com> <20230809155438.22470-4-rf@opensource.cirrus.com>
In-Reply-To: <20230809155438.22470-4-rf@opensource.cirrus.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 10 Aug 2023 22:38:02 +0800
Message-ID: <CABVgOSn4PWT6+TobiJd+ppmPXsL+0qtLdazgjuQmfymUfkYhnA@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] kunit: Handle logging of lines longer than the
 fragment buffer size
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 9 Aug 2023 at 23:54, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Add handling to kunit_log_append() for log messages that are longer than
> a single buffer fragment.
>
> The initial implementation of fragmented buffers did not change the logic
> of the original kunit_log_append(). A consequence was that it still had
> the original assumption that a log line will fit into one buffer.
>
> This patch checks for log messages that are larger than one fragment
> buffer. In that case, kvasprintf() is used to format it into a temporary
> buffer and that content is then split across as many fragments as
> necessary.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---

I think this looks good (and is a long-overdue addition to the logging
functionality).

One thought I have (and I'm kicking myself for not thinking of it
earlier) is that this is starting to get very similar to the "string
stream" functionality in lib/kunit/string-stream.{h,c}. Now, I
actually think this implementation is much more efficient (using
larger fragments, whereas the string stream uses variable-sized ones).
Particularly since there are a lot of cases where string streams are
created, converted to a string, and then logged, there's almost
certainly a bunch of redundant work being done here.

My gut feeling is that we should stick with this as-is, and maybe try
to either work out some better integration between string streams and
logging (to avoid that extra string allocation) or find some way of
combining them.

Regardless, this seems good as-is to me. There are some minor comments
below, but nothing disastrous. I'll let Rae have a look over the
various strscpy and strlcat calls, though, as while I did check them
carefully (and KASAN hasn't complained), it's always best to have as
many eyes on C string code as possible. :-)

But in my eyes, this is
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/test.c | 65 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 61 insertions(+), 4 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index dfe51bc2b387..28d0048d6171 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -140,25 +140,82 @@ static struct kunit_log_frag *kunit_log_extend(struct list_head *log)
>         return frag;
>  }
>
> +static void kunit_log_append_string(struct list_head *log, const char *src)
> +{
> +       struct kunit_log_frag *frag, *new_frag;
> +       int log_len, bytes_left;
> +       ssize_t written;
> +       char *p;
> +
> +       frag = list_last_entry(log, struct kunit_log_frag, list);
> +       log_len = strlen(frag->buf);
> +       bytes_left = sizeof(frag->buf) - log_len;
> +
> +       written = strscpy(frag->buf + log_len, src, bytes_left);
> +       if (written != -E2BIG)
> +               goto newline;
> +
> +       src += bytes_left - 1;
> +       do {
> +               new_frag = kunit_log_extend(log);
> +               if (!new_frag)
> +                       goto newline;
> +
> +               frag = new_frag;
> +               written = strscpy(frag->buf, src, sizeof(frag->buf));
> +               src += sizeof(frag->buf) - 1;
> +       } while (written == -E2BIG);
> +
> +newline:
> +       if (written == -E2BIG)

I think that this can only be true if kunit_log_extend() fails. If the
do/while loop ends naturally, then written != -E2BIG, as is the case
with the strscpy goto above.

Do you think it's cleaner to move the 'written = strlen(frag->buf)
into the if (!new_frag) statement within the loop?

> +               written = strlen(frag->buf);
> +
> +       p = &frag->buf[written - 1];
> +       if (*p != '\n') {
> +               if (strlcat(frag->buf, "\n", sizeof(frag->buf)) >= sizeof(frag->buf)) {
> +                       frag = kunit_log_extend(log);
> +                       if (!frag) {

A comment here could be useful. Something like "If we can't extend the
log to add a newline, truncate the last message".

> +                               *p = '\n';
> +                               return;
> +                       }
> +
> +                       frag->buf[0] = '\n';
> +                       frag->buf[1] = '\0';
> +               }
> +       }
> +}
> +
>  /* Append formatted message to log, extending the log buffer if necessary. */
>  void kunit_log_append(struct list_head *log, const char *fmt, ...)
>  {
>         va_list args;
>         struct kunit_log_frag *frag;
>         int len, log_len, len_left;
> +       char *tmp = NULL;
>
>         if (!log)
>                 return;
>
> -       frag = list_last_entry(log, struct kunit_log_frag, list);
> -       log_len = strlen(frag->buf);
> -       len_left = sizeof(frag->buf) - log_len - 1;
> -
>         /* Evaluate length of line to add to log */
>         va_start(args, fmt);
>         len = vsnprintf(NULL, 0, fmt, args) + 1;
>         va_end(args);
>
> +       if (len > sizeof(frag->buf) - 1) {
> +               va_start(args, fmt);
> +               tmp = kvasprintf(GFP_KERNEL, fmt, args);
> +               va_end(args);
> +

Should we handle the case where kvasprintf() fails here and drop the
log message?


> +               kunit_log_append_string(log, tmp);
> +               kfree(tmp);
> +
> +               return;
> +       }
> +
> +       frag = list_last_entry(log, struct kunit_log_frag, list);
> +       log_len = strlen(frag->buf);
> +       len_left = sizeof(frag->buf) - log_len - 1;
> +
>         if (len > len_left) {
>                 frag = kunit_log_extend(log);
>                 if (!frag)
> --
> 2.30.2
>
