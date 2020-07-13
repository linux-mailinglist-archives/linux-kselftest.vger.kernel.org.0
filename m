Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0CA21D650
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jul 2020 14:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgGMMva (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jul 2020 08:51:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21116 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729494AbgGMMva (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jul 2020 08:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594644688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YjOX0+qMsr0MZ2n7yEIvNR1la6gfCqgxiam2qlcsRPU=;
        b=H9pbEBLVe/orSI4qPJD4iDl0fMb0FMKGswKkFgoBVgSnQLPNDGlU8mSEHyu3lO4OyUCxh3
        BpqFjuZ8BcD97fkpdTv5WSZdp3yrIhT9hFQVh4DLtfWW/fIKAape9rXlUSnbytUNXraHLq
        TCuxCaXG4Jyrvl8LaBfwxMMykuWgzNk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-_uypYKDCNNmHosexGv-YjA-1; Mon, 13 Jul 2020 08:51:27 -0400
X-MC-Unique: _uypYKDCNNmHosexGv-YjA-1
Received: by mail-qv1-f69.google.com with SMTP id v20so7338594qvt.15
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jul 2020 05:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YjOX0+qMsr0MZ2n7yEIvNR1la6gfCqgxiam2qlcsRPU=;
        b=rrwKvN1+RmIOxBUJQCQThrbF61XriBSL3umfEHOxSq5YOCvGQndsZtSkkvjmB5BPkV
         Y0TuVDaRzF84AwWMXE/z/jbP5wNviQE1ZAZ6Ksp85WXmstE7ogvzDOMwQNnKm/lynBTF
         u0tQWMTvsbC3edlZcWuqKU5jX/hhwnfAi6wPtMuiBFOXelbP6UpkqFHK3/7M75zHfmYh
         DRQt+EGE9JbCn7MWjDpFy3EQKVs33dfJliUUJaoz0Z5EDdQXph0qUSTgcZBnIyenD0dw
         ectEvuTT21VZdwms46ahlHbN4c3Ezee7xMMR/pP8qdLYyd9nwVzS1a2IIRWUVVuPF1Fh
         MyEQ==
X-Gm-Message-State: AOAM533vsMpfkKFwfyaYBBli1Jyx6Lfyn5t9SX+XBamOQtvDH6m0SemJ
        6ai05tfv6vdyG7sm16D4hMXNTJAjZuAo9i8Nhng7eY1lSGLzniI+FyxtCapGIPi1mA1A2wGBrNs
        1nSsNg/hLtc+Rw/z3H1S0wXEydYLr7G9tS3tBjLQnW5X8
X-Received: by 2002:a37:5b81:: with SMTP id p123mr79713626qkb.150.1594644686658;
        Mon, 13 Jul 2020 05:51:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxekftooSxa1u1VC3aPSrNHxSTGnX+9e052hcG04Me+8Z6Np01h076NBmbFLdN/2WyjobuC1GlPp9SslA84gNU=
X-Received: by 2002:a37:5b81:: with SMTP id p123mr79713605qkb.150.1594644686341;
 Mon, 13 Jul 2020 05:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200710183745.19730-1-joe.lawrence@redhat.com>
In-Reply-To: <20200710183745.19730-1-joe.lawrence@redhat.com>
From:   Yannick Cote <ycote@redhat.com>
Date:   Mon, 13 Jul 2020 08:51:15 -0400
Message-ID: <CAKMMXfb0kuynAjA76fnB+BWX+wRVY2NQ+hPs4nSJi3YgbEnsew@mail.gmail.com>
Subject: Re: [PATCH] selftests/livepatch: Use "comm" instead of "diff" for dmesg
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 10, 2020 at 2:39 PM Joe Lawrence <joe.lawrence@redhat.com> wrote:
>
> BusyBox diff doesn't support the GNU diff '--LTYPE-line-format' options
> that were used in the selftests to filter older kernel log messages from
> dmesg output.
>
> Use "comm" which is more available in smaller boot environments.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>
> based-on: livepatching.git/for-5.9/selftests-cleanup
> merge-thru: livepatching.git
>
>  tools/testing/selftests/livepatch/functions.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index 36648ca367c2..408529d94ddb 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -277,7 +277,7 @@ function check_result {
>         # help differentiate repeated testing runs.  Remove them with a
>         # post-comparison sed filter.
>
> -       result=$(dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$SAVED_DMESG" - | \
> +       result=$(dmesg | comm -13 "$SAVED_DMESG" - | \
>                  grep -e 'livepatch:' -e 'test_klp' | \
>                  grep -v '\(tainting\|taints\) kernel' | \
>                  sed 's/^\[[ 0-9.]*\] //')
> --
> 2.21.3
>

Reviewed-by: Yannick Cote <ycote@redhat.com>

