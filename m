Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C1A591B56
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Aug 2022 17:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbiHMPW5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 13 Aug 2022 11:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbiHMPW4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 13 Aug 2022 11:22:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C9EF14D2D
        for <linux-kselftest@vger.kernel.org>; Sat, 13 Aug 2022 08:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660404173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RVMwJe4+GMGVO5clzI02Ln4CTIby0mMjXhru50oXHBg=;
        b=ZGxTnAI1t88PjZ20xAZYNO+HyNL9x+vf4sMnXNORDrgeBaG92/uHudg+knQzg7miI+iZDH
        ifs15ED0DCGiJ2QaFZHjp4+4N55Rqwr6G+mIFHHBWEIJMjQMia+d0P4hHpNKhAt2JymltR
        B+3GnyIY0SchH4BjX7fnIDa0PXaaQUU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-218-cToLIcHrP8KtzyWiTtfkeQ-1; Sat, 13 Aug 2022 11:22:52 -0400
X-MC-Unique: cToLIcHrP8KtzyWiTtfkeQ-1
Received: by mail-pj1-f69.google.com with SMTP id o18-20020a17090aac1200b001f3252af009so5646432pjq.7
        for <linux-kselftest@vger.kernel.org>; Sat, 13 Aug 2022 08:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc;
        bh=RVMwJe4+GMGVO5clzI02Ln4CTIby0mMjXhru50oXHBg=;
        b=f+ZQxyFx0WGi7U68r9l2+D46izblHPCf4852vPPJy2vi09gj2vXiQwd6BnJ2ts4gFa
         ySX3cTqnUUjRyQWXBHmIR6Lxbb1OImcjgZAbamTLG8pALP7aZUEqss9waLMGHiwFMnMH
         b2NHddm+3Fnc6eFoV7EI+64scdkNwRdctI+0crVWXVUArWYcOS6aGd/Tb2f8jl2ZEv9w
         2gPJVzbGSU/cx2DlriVNH2dEjcXojNHNfsDczc2hargBLXeCvElZOqB5zcxXSOVB4pS5
         BJNcTdUTeAzkzlfbKrk7uAdNRE9trQwuLMdbC9zpUCXYLnK6qLDXiou2CyJC305NanMg
         rSLQ==
X-Gm-Message-State: ACgBeo2Al7QtIy9ntXXbok5A46uwouIyl7GtbzwkEoreOoNdYLxB0xb0
        hfLJ8yfTh+MTAAKhfeggKSnVi1gLNyioBu1PTcZCxctGF7QCjlhmAcVum7XhNQEr0eYTyV2xPac
        k9ue03xyiAf1+m3uUUectvNl66RLU
X-Received: by 2002:a63:9141:0:b0:41d:22d:1910 with SMTP id l62-20020a639141000000b0041d022d1910mr7173190pge.145.1660404170980;
        Sat, 13 Aug 2022 08:22:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5F7/5TrfFR/Qz9s2FhtlkoyVquAMHgc0VZZlNxvafI0TX82gPLJrFPw3NsTWIZZZorYBFWQw==
X-Received: by 2002:a63:9141:0:b0:41d:22d:1910 with SMTP id l62-20020a639141000000b0041d022d1910mr7173168pge.145.1660404170659;
        Sat, 13 Aug 2022 08:22:50 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902714400b0016ee26224a4sm3778222plm.305.2022.08.13.08.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 08:22:50 -0700 (PDT)
Date:   Sun, 14 Aug 2022 00:22:42 +0900 (JST)
Message-Id: <20220814.002242.1890726681929865782.syoshida@redhat.com>
To:     shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, syoshida@redhat.com
Subject: Re: [PATCH] selftests/proc: Add support for vsyscall=xonly
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20220806135749.47168-1-syoshida@redhat.com>
References: <20220806135749.47168-1-syoshida@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 28.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ping?

On Sat,  6 Aug 2022 22:57:49 +0900, Shigeru Yoshida wrote:
> There are 3 vsyscall modes: emulate, xonly, and none.  proc-pid-vm
> detects the existence of the vsyscall with memory load on the vsyscall
> page.
> 
> This works for emulate and none vsyscall modes, but fails for xonly
> because read permission is omitted with xonly vsyscall page, and it
> results in the following error:
> 
>   # ./proc-pid-vm
>   proc-pid-vm: proc-pid-vm.c:328: main: Assertion `rv == len' failed.
>   Aborted (core dumped)
> 
> This patch fixes this issue with introducing the following rule:
> 
>   1. vsyscall mode is emulate if it can load memory
>   2. vsyscall mode is xonly if it can call gettimeofday() on vsyscall
>   3. vsyscall mode is node otherwise
> 
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  tools/testing/selftests/proc/proc-pid-vm.c | 77 ++++++++++++++++++----
>  1 file changed, 65 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
> index 28604c9f805c..dffd263beef3 100644
> --- a/tools/testing/selftests/proc/proc-pid-vm.c
> +++ b/tools/testing/selftests/proc/proc-pid-vm.c
> @@ -211,10 +211,16 @@ static int make_exe(const uint8_t *payload, size_t len)
>  }
>  #endif
>  
> -static bool g_vsyscall = false;
> -
> -static const char str_vsyscall[] =
> -"ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
> +static enum { EMULATE, XONLY, NONE } g_vsyscall_mode;
> +
> +static const char * const str_vsyscall[] = {
> +	/* emulate */
> +	"ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n",
> +	/* xonly */
> +	"ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n",
> +	/* none */
> +	"",
> +};
>  
>  #ifdef __x86_64__
>  static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
> @@ -225,7 +231,33 @@ static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
>  /*
>   * vsyscall page can't be unmapped, probe it with memory load.
>   */
> -static void vsyscall(void)
> +static bool vsyscall_emulate(void)
> +{
> +	*(volatile int *)0xffffffffff600000UL;
> +	return true;
> +}
> +
> +/*
> + * vsyscall page can't be unmapped, probe it with calling gettimeofday().
> + */
> +static bool vsyscall_xonly(void)
> +{
> +	int ret;
> +	struct timeval tv;
> +	int (*f)(struct timeval *tv, struct timezone *tz);
> +
> +	/* Try to call gettimeofday() on vsyscall*/
> +	f = (void *)0xffffffffff600000UL;
> +	ret = f(&tv, NULL);
> +	if (ret < 0) {
> +		fprintf(stderr, "gettimeofday() on vsyscall, ret %d\n", ret);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static bool vsyscall_test(bool (*test)(void))
>  {
>  	pid_t pid;
>  	int wstatus;
> @@ -246,13 +278,27 @@ static void vsyscall(void)
>  		act.sa_sigaction = sigaction_SIGSEGV;
>  		(void)sigaction(SIGSEGV, &act, NULL);
>  
> -		*(volatile int *)0xffffffffff600000UL;
> +		if (!test())
> +			exit(1);
> +
>  		exit(0);
>  	}
>  	waitpid(pid, &wstatus, 0);
>  	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0) {
> -		g_vsyscall = true;
> +		return true;
>  	}
> +
> +	return false;
> +}
> +
> +static void vsyscall(void)
> +{
> +	if (vsyscall_test(vsyscall_emulate))
> +		g_vsyscall_mode = EMULATE;
> +	else if (vsyscall_test(vsyscall_xonly))
> +		g_vsyscall_mode = XONLY;
> +	else
> +		g_vsyscall_mode = NONE;
>  }
>  
>  int main(void)
> @@ -314,11 +360,14 @@ int main(void)
>  
>  	/* Test /proc/$PID/maps */
>  	{
> -		const size_t len = strlen(buf0) + (g_vsyscall ? strlen(str_vsyscall) : 0);
> +		size_t len = strlen(buf0);
>  		char buf[256];
>  		ssize_t rv;
>  		int fd;
>  
> +		if (g_vsyscall_mode != NONE)
> +			len += strlen(str_vsyscall[g_vsyscall_mode]);
> +
>  		snprintf(buf, sizeof(buf), "/proc/%u/maps", pid);
>  		fd = open(buf, O_RDONLY);
>  		if (fd == -1) {
> @@ -327,8 +376,10 @@ int main(void)
>  		rv = read(fd, buf, sizeof(buf));
>  		assert(rv == len);
>  		assert(memcmp(buf, buf0, strlen(buf0)) == 0);
> -		if (g_vsyscall) {
> -			assert(memcmp(buf + strlen(buf0), str_vsyscall, strlen(str_vsyscall)) == 0);
> +		if (g_vsyscall_mode != NONE) {
> +			assert(memcmp(buf + strlen(buf0),
> +				      str_vsyscall[g_vsyscall_mode],
> +				      strlen(str_vsyscall[g_vsyscall_mode])) == 0);
>  		}
>  	}
>  
> @@ -374,8 +425,10 @@ int main(void)
>  			assert(memmem(buf, rv, S[i], strlen(S[i])));
>  		}
>  
> -		if (g_vsyscall) {
> -			assert(memmem(buf, rv, str_vsyscall, strlen(str_vsyscall)));
> +		if (g_vsyscall_mode != NONE) {
> +			assert(memmem(buf, rv,
> +				      str_vsyscall[g_vsyscall_mode],
> +				      strlen(str_vsyscall[g_vsyscall_mode])));
>  		}
>  	}
>  
> -- 
> 2.37.1
> 

