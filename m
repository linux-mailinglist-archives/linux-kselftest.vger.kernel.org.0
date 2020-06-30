Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B23920FC3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jun 2020 20:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgF3SxS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Jun 2020 14:53:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31308 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726982AbgF3SxS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Jun 2020 14:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593543197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mcg17qf3dJLPIXN0i+iFpN5cYHhiLw7/LkTl8zB+uyg=;
        b=KNs+P26EJtcGN3Y72PUnPm+E7O8TOGJFyjnhk/NNqrzAJp3xqGjcY+sIPpJY2ToxyWKudO
        tZZcqvJnqE+IhYsdWgcJF2dF3R+2+EU5IsqYVDuRC4OIzaxhJr47/vw5w2BUWcBBQ4yRVL
        xed99Hk0Q/RzEM5TY2d5dI3CE0aDAlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-2uAIi_0rPKaN7X5KnfLU5g-1; Tue, 30 Jun 2020 14:53:15 -0400
X-MC-Unique: 2uAIi_0rPKaN7X5KnfLU5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20B6F7BB0;
        Tue, 30 Jun 2020 18:53:13 +0000 (UTC)
Received: from redhat.com (ovpn-112-56.rdu2.redhat.com [10.10.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 36B15282E6;
        Tue, 30 Jun 2020 18:53:12 +0000 (UTC)
Date:   Tue, 30 Jun 2020 14:53:10 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/lkdtm: Use "comm" instead of "diff" for dmesg
Message-ID: <20200630185310.GA29805@redhat.com>
References: <202006261358.3E8AA623A9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006261358.3E8AA623A9@keescook>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 26, 2020 at 01:59:43PM -0700, Kees Cook wrote:
> Instead of full GNU diff (which smaller boot environments may not have),
> use "comm" which is more available.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Link: https://lore.kernel.org/lkml/CA+G9fYtHP+Gg+BrR_GkBMxu2oOi-_e9pATtpb6TVRswv1G1r1Q@mail.gmail.com
> Fixes: f131d9edc29d ("selftests/lkdtm: Don't clear dmesg when running tests")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/lkdtm/run.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
> index 8383eb89d88a..5fe23009ae13 100755
> --- a/tools/testing/selftests/lkdtm/run.sh
> +++ b/tools/testing/selftests/lkdtm/run.sh
> @@ -82,7 +82,7 @@ dmesg > "$DMESG"
>  ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
>  
>  # Record and dump the results
> -dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
> +dmesg | comm -13 "$DMESG" - > "$LOG" || true
>  
>  cat "$LOG"
>  # Check for expected output

I'm not familiar with running lkdtm tests, but I copied the same fixup
for the livepatching selftests and "comm" slides in nicely over there,
so,

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe

