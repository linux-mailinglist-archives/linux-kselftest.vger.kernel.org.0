Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 722DC172CE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2020 01:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgB1ASq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Feb 2020 19:18:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36365 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbgB1ASq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Feb 2020 19:18:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id f19so1422513wmh.1
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2020 16:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=Ru4d08QosRwi5UKUDayggsg8+1o9m63515MgXLmokW8=;
        b=IWzNQosQnTNRg6JwrMWL8cZg//T1NJyh5SlPHUMjTe2PM6DLQR3MGn7AS2eR7BUekk
         VA5Nn/uF2v8nLIeXOf69a/ZxfAiw3Rs/JjYdpQIUz/d7HAqD5lncZpjXlzxYzn2L9+qT
         kT4TzRbKGFnLcLbXXRDaBz6IpOR5/C8cejdOg+NXuJZ9ccdt0ZLb9HcKn4iAu+zZs0N7
         fTXfOomi2231KPYtLEHe2GLuZCOO/IlMiLTIDujwkoIrOC/L+M9v7tzG4cHQQhp0VN7n
         /erES7+A7Wi0za13WP78xe5GPjBJoByVFEb4hAo47CWJO42AtkiEG4vfxJN45019f3X9
         ovjw==
X-Gm-Message-State: APjAAAW2zfTCZzgswtNrgrG8jmRgofD6mFYHI/r/I/rnKw/07f+0Z/WO
        QZcxVA+wxlJ7L99bwY3rn4eKdA==
X-Google-Smtp-Source: APXvYqy+BY8r4CAlQjGnmuK0o8k329k009mLT7m3y33mtID+0H5FRuAG3RePEOUn51L+FOrcaJrpKA==
X-Received: by 2002:a05:600c:291d:: with SMTP id i29mr1383321wmd.39.1582849124239;
        Thu, 27 Feb 2020 16:18:44 -0800 (PST)
Received: from Google-Pixel-3a.fritz.box (ip5f5bf7ec.dynamic.kabel-deutschland.de. [95.91.247.236])
        by smtp.gmail.com with ESMTPSA id d17sm9543105wmb.36.2020.02.27.16.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 16:18:43 -0800 (PST)
Date:   Fri, 28 Feb 2020 01:18:44 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <966567c7dbaa26a06730d796354f8a086c0ee288.1582847778.git.christophe.leroy@c-s.fr>
References: <966567c7dbaa26a06730d796354f8a086c0ee288.1582847778.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] selftests: pidfd: Add pidfd_fdinfo_test in .gitignore
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Christian Kellner <christian@kellner.me>,
        Shuah Khan <skhan@linuxfoundation.org>
CC:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <DB631DFB-DF8B-4B95-AC50-74F1ED733CAE@ubuntu.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On February 28, 2020 1:00:08 AM GMT+01:00, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>The commit identified below added pidfd_fdinfo_test
>but failed to add it to .gitignore
>
>Fixes: 2def297ec7fb ("pidfd: add tests for NSpid info in fdinfo")
>Cc: stable@vger.kernel.org
>Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>---
> tools/testing/selftests/pidfd/.gitignore | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/tools/testing/selftests/pidfd/.gitignore
>b/tools/testing/selftests/pidfd/.gitignore
>index 3a779c084d96..39559d723c41 100644
>--- a/tools/testing/selftests/pidfd/.gitignore
>+++ b/tools/testing/selftests/pidfd/.gitignore
>@@ -2,4 +2,5 @@ pidfd_open_test
> pidfd_poll_test
> pidfd_test
> pidfd_wait
>+pidfd_fdinfo_test
> pidfd_getfd_test

Thanks for spotting this.
I'll pick this up along with other fixes I have waiting.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
