Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE57147A51
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 10:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgAXJUX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 04:20:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45904 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgAXJUX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 04:20:23 -0500
Received: by mail-lj1-f196.google.com with SMTP id j26so1627050ljc.12
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2020 01:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=uG7t3jslEN8tdpr4DfSysZ3Zpcar1VFu1RAq/nI6AK8=;
        b=INVsKmNPnDXJ2ztsp0CSMP0e4/utMnWG+G7IPGUwvJcAvT5bir0Y476JHNWNOlB9xc
         lT98tBsFhEm3AQaozXtOVo6D5xddtwwhmBrxCwJs/JYQlC3oUidfz4aYbOxuArE/xtlJ
         eFpXg8dgHTie35eXSLEUvTXLw+z0o40T7rFc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=uG7t3jslEN8tdpr4DfSysZ3Zpcar1VFu1RAq/nI6AK8=;
        b=QWSq05EVg7MRqftOh5SlMsK+H9Of5ts5FdUXIVRcVOqlLm2Kt0YcvHmy18DZvmgCo1
         Z0Axtol6P5ZkDQZzuN8sip2zk2HvmamSjH9vR5UCh5a7Un8Xphh+Cz1lKYluyLdYHTwn
         7529bAxuVLsRJis81N5QX08ervCfztGzpgmVEFDo+35jhS6KshFsjTWBnQY6a0qehiKE
         Z4qanIPXYZza3WNN83aLAIzgWjkBBbVRZfAicxSC8NcOGnx3awarDTNBA65hHmH3QRWL
         nfKLeEbSNee3khkpwC2p2STB7z+uV/Hvd3ORGhEGcZp/CP/TX8g93MJ8gP+FRDdV3aeD
         kp6Q==
X-Gm-Message-State: APjAAAUNJZwPIGc0uFiGEbYncDo4qr8EdLkimDH+EEd65SzPRuolCiQM
        jeoAtnmR8DHuRWzx/Hoc87NMrg==
X-Google-Smtp-Source: APXvYqyk4mVgbZ8jfN0g6kiY3Ge+BUikFmJOvxBISROw9psGF8GsMlY6LM7AIYb2A5HHNmMknAZEHg==
X-Received: by 2002:a2e:7a13:: with SMTP id v19mr1609631ljc.43.1579857621405;
        Fri, 24 Jan 2020 01:20:21 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id t20sm2615608ljk.87.2020.01.24.01.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 01:20:20 -0800 (PST)
References: <20200123165934.9584-1-lmb@cloudflare.com> <20200123165934.9584-2-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf 1/4] selftests: bpf: use a temporary file in test_sockmap
In-reply-to: <20200123165934.9584-2-lmb@cloudflare.com>
Date:   Fri, 24 Jan 2020 10:20:19 +0100
Message-ID: <8736c52oto.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 23, 2020 at 05:59 PM CET, Lorenz Bauer wrote:
> Use a proper temporary file for sendpage tests. This means that running
> the tests doesn't clutter the working directory, and allows running the
> test on read-only filesystems.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  tools/testing/selftests/bpf/test_sockmap.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index 4a851513c842..779e11da979c 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -331,7 +331,7 @@ static int msg_loop_sendpage(int fd, int iov_length, int cnt,
>  	FILE *file;
>  	int i, fp;
>
> -	file = fopen(".sendpage_tst.tmp", "w+");
> +	file = tmpfile();
>  	if (!file) {
>  		perror("create file for sendpage");
>  		return 1;

memfd_create() would be an alternative that doesn't clutter anything.

[...]
