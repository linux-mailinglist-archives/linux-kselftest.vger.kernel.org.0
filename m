Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 503E415928A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 16:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgBKPIk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Feb 2020 10:08:40 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45979 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbgBKPIk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Feb 2020 10:08:40 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so7228100lfa.12;
        Tue, 11 Feb 2020 07:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pO2EbLRpdWYcM5YTgS+KCUX0UTL+PsCuajujyYa2TIY=;
        b=nfQHUn1lCiGCfYkllmpp5Bw2fQeKVVfM6Uu3gMt9naAJljFzFrelduXS0upOE4w+mg
         qbzQutZTfzzD7VyrUgufso7yxg0OCPrkKdP5E/InvxV7nh3Nj7V7y7LAcWfGQxzqTmOZ
         V28VnH6yuKLyvhhNr1zxRwrKvo3yd2cZjZCCzoXkDgjjPpcaGR7MWOIST1VnBgnAm218
         0AKy/LY2AX1b1YzsMIL+dGpiviyoo1E7bOVm3E15BAp6T1+UVgWcrhZJMxl/yqZAAQnc
         H5E8O+sn/QqrHkMr4wHDtwEQSrKwzcG7jTUumkF2DD51L4CLYo0NoPgQ0USo4vAy1UaF
         lcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pO2EbLRpdWYcM5YTgS+KCUX0UTL+PsCuajujyYa2TIY=;
        b=FLalwLSHgc98FHM/ifeZuGtZVXeOKT6X5ezDdSTNX9FAp/0NHkwsmUwdAs7KsUFtVJ
         DiKk2m6XeL4XVTtROyBXqC9GO1uN8iPKwcnEb8EQtIAUa0slj0cPRPcTT+KuNoZPlsTp
         tdA/AB5ZMhQ+Y+/1tiKIckz5slGB+GA4ENIs1UMupSUorf+CXdS+ROrKYaM3fbYbC5Wo
         6yVS1Oh4U6qZjizsjA6CKsGD05zztLrJudnCCOVGzHDzpw/z8oTZfFnL3T3wWZbELX4h
         IFYAzH/m7cG9on2m7cStrMVgt4e7cL2i9Nkx6j4aHnCfBRp+Wgp/nukLu6MqhDUc5k6o
         OimQ==
X-Gm-Message-State: APjAAAWM9fBbJpKBQSKDcXFpSZ7yIibd6C24jGReY8rvW0cw8vhgDgXo
        QHEb5zPyMj5qWtycOZkibMYRT1tn/yMaIsY4PQMkV7c0
X-Google-Smtp-Source: APXvYqyD2p3SLGz0YbeyKsoXp8UNzT9RvMpuGjs/jGd0JYtvUPSizq6j6dhpFlLw5Sm7wsYjCFHZ5J9CJFpKgxNxt3c=
X-Received: by 2002:ac2:515b:: with SMTP id q27mr3668980lfd.119.1581433717965;
 Tue, 11 Feb 2020 07:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20200211113257.451781-1-isaac.young5@gmail.com>
In-Reply-To: <20200211113257.451781-1-isaac.young5@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 11 Feb 2020 07:08:26 -0800
Message-ID: <CAADnVQ+0WNHWR9P4062gjP7Ow0aPaccMzP=AK3-DjQ9FDf9UfA@mail.gmail.com>
Subject: Re: [PATCH] Removing a duplicate condition.
To:     Isaac Young <isaac.young5@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 11, 2020 at 5:26 AM Isaac Young <isaac.young5@gmail.com> wrote:
>
> Signed-off-by: Isaac Young <isaac.young5@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/select_reuseport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
> index 098bcae5f827..0954c7a8aa08 100644
> --- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
> +++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
> @@ -823,7 +823,7 @@ void test_select_reuseport(void)
>
>         saved_tcp_fo = read_int_sysctl(TCP_FO_SYSCTL);
>         saved_tcp_syncookie = read_int_sysctl(TCP_SYNCOOKIE_SYSCTL);
> -       if (saved_tcp_syncookie < 0 || saved_tcp_syncookie < 0)
> +       if (saved_tcp_syncookie < 0)
>                 goto out;

please resend this patch to bpf@vger and cc maintainers.
Also see bpf_devel_QA.rst
Thanks
