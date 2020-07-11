Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7D721C503
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jul 2020 18:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgGKQFj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 Jul 2020 12:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgGKQFi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 Jul 2020 12:05:38 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566ABC08C5DD
        for <linux-kselftest@vger.kernel.org>; Sat, 11 Jul 2020 09:05:38 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h13so6442909otr.0
        for <linux-kselftest@vger.kernel.org>; Sat, 11 Jul 2020 09:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+LkgDW+3gIJtk7mm/Y9qIk0uuyU/YB6D7m7lleX0tAk=;
        b=lewDDpjYY3aI6m3Fk+7xv26vrCgPvjXN39l0ZZuhJ7NiQ9MJit1P3Snd/j0fryjS2n
         jp4R72eU8T6I6lkIK6BYkzqRvECKYB1/WO/EJcpcgF7Di33TT18VAx0g72tgJCwFtQdh
         59WzRRhFnFA4xJHkDLryT97L3d7Zy9K44CZpVye3mzDft/chF78E6mRJ5GVQC1hhzDgN
         DPmSKT+XDBwGUX3w3sqs1Ooj7oW6nFEnuZYI+oID1AOfnijJNixu4khI511IFWv2ioGQ
         WHdQp+AXGpY8NbYRR8a3qLZlTJKEJFXZIC/MhQ3/cn9IYzuWBj116qmNU16dvWP7ohwp
         sMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+LkgDW+3gIJtk7mm/Y9qIk0uuyU/YB6D7m7lleX0tAk=;
        b=LO9D9OHwgzX6zWwuBaennzRDVztZC0Ip/mOW3q8ssTjlor3lMKZnRVFwSphU+IZo+G
         Cart0XEmoy8ns5OE+zXKc9qwxOA0p9XiBRaM96L4EEmXcqvJfrco2+zyfYORgNg8vp1u
         Zlveqau1jS+9B4Zc53eijLZGpbNzZ+ulg/9wYffFEZkZiAGaCbQ80x5qUaw0olvk7gnm
         pdGfnuy6Za1gFlv8FDJ5EC/ScnZfVBkQTcYL46U+v58tWBncY87afe+NM7HDKYgYzzIS
         z0Z8VXG4w7PZM5JWINR8/hUU6qsqUMnblyRr6GbMTbhKI/IOzQBXsjRf7YtXP9B9R3zj
         DqIw==
X-Gm-Message-State: AOAM533T3G3NjoLvxUeaZjffBw/+NBW3ZQ8bBqAxTWqG1PNBsRV+wgao
        /SqGJPXL9SWERWNeBAUDA507kg==
X-Google-Smtp-Source: ABdhPJyrFrNh6HZ2yy8Tl8bJuu4YnMbS6DS1PdCicIfEJ2Qe518NX6e71b7bATtMraox+VDJS+QWdQ==
X-Received: by 2002:a9d:6c09:: with SMTP id f9mr44206479otq.362.1594483537599;
        Sat, 11 Jul 2020 09:05:37 -0700 (PDT)
Received: from cisco ([2601:282:b02:8120:dd70:9e19:5b5e:7f32])
        by smtp.gmail.com with ESMTPSA id j27sm1764696ots.7.2020.07.11.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 09:05:36 -0700 (PDT)
Date:   Sat, 11 Jul 2020 10:05:35 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next/seccomp v2 1/2] selftests/seccomp: Add SKIPs for
 failed unshare()
Message-ID: <20200711160535.GG2700617@cisco>
References: <20200710230107.2528890-1-keescook@chromium.org>
 <20200710230107.2528890-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710230107.2528890-2-keescook@chromium.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 10, 2020 at 04:01:06PM -0700, Kees Cook wrote:
> Running the seccomp tests as a regular user shouldn't just fail tests
> that require CAP_SYS_ADMIN (for getting a PID namespace). Instead,
> detect those cases and SKIP them. Additionally, gracefully SKIP missing
> CONFIG_USER_NS (and add to "config" since we'd prefer to actually test
> this case).
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/seccomp/config        |  1 +
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 10 ++++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/config b/tools/testing/selftests/seccomp/config
> index db1e11b08c8a..64c19d8eba79 100644
> --- a/tools/testing/selftests/seccomp/config
> +++ b/tools/testing/selftests/seccomp/config
> @@ -1,2 +1,3 @@
>  CONFIG_SECCOMP=y
>  CONFIG_SECCOMP_FILTER=y
> +CONFIG_USER_NS=y
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index c0aa46ce14f6..14b038361549 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -3439,7 +3439,10 @@ TEST(user_notification_child_pid_ns)
>  	struct seccomp_notif req = {};
>  	struct seccomp_notif_resp resp = {};
>  
> -	ASSERT_EQ(unshare(CLONE_NEWUSER | CLONE_NEWPID), 0);
> +	ASSERT_EQ(unshare(CLONE_NEWUSER | CLONE_NEWPID), 0) {
> +		if (errno == EINVAL)
> +			SKIP(return, "kernel missing CLONE_NEWUSER support");
> +	};
>  
>  	listener = user_trap_syscall(__NR_getppid,
>  				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
> @@ -3504,7 +3507,10 @@ TEST(user_notification_sibling_pid_ns)
>  	}
>  
>  	/* Create the sibling ns, and sibling in it. */
> -	ASSERT_EQ(unshare(CLONE_NEWPID), 0);
> +	ASSERT_EQ(unshare(CLONE_NEWPID), 0) {
> +		if (errno == EPERM)
> +			SKIP(return, "CLONE_NEWPID requires CAP_SYS_ADMIN");
> +	}
>  	ASSERT_EQ(errno, 0);

For this one, I think we can just put an unshare(CLONE_NEWUSER) at
the top so the test still runs. This seems works for me unprivileged:

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 252140a52553..65e3642539f9 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3482,6 +3482,11 @@ TEST(user_notification_sibling_pid_ns)
 		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
 	}
 
+	ASSERT_EQ(unshare(CLONE_NEWUSER), 0) {
+		if (errno == EINVAL)
+			SKIP(return, "kernel missing CLONE_NEWUSER support");
+	};
+
 	listener = user_trap_syscall(__NR_getppid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
 	ASSERT_GE(listener, 0);
