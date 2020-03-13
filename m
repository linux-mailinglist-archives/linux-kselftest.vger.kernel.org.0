Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDA01185248
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Mar 2020 00:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgCMX0q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 19:26:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33977 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgCMX0q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 19:26:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id t3so5899184pgn.1
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Mar 2020 16:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nlUL7Q8I2iJ5jPudXrdaOgrxyrGBhdFIa//xZMcIhAU=;
        b=DamwIXh1ZVKDBre3Y4XmAHGr5oTQDdlscyfeG2900MjmAxYR/K+bJNIcZrTQ5MX8Mn
         mMniN6AlDkbkO6IhJSoVsQoXW02txd8kqpQlOXp/JeK2JWGqPNJT0bmpGFJ2R0PSF+BA
         14BmYkvJMK/NJO0Krb4i0Cg9BhxwU8CZow1M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nlUL7Q8I2iJ5jPudXrdaOgrxyrGBhdFIa//xZMcIhAU=;
        b=MiWydLhzhM3QK3bVEuRZjnhWh9P7Zm0H8YQOKiorb0RLvNWIbU7lDa2hAdT3upQe/h
         Bqz4VAS42RZuNlxDGsBO62/9jRMRe64FZmaWFtTolUygE7xV/pW8LaonDkWbM5NRRJ7r
         C7G0NVZTiASDg3pcMWDc6nWY3gQI4PchCHK775mmKAe2hBWvKtXgRqDUa71HYjgKFM7P
         rmJfCZZZXKXfmBiOlzSWFzwdCNJOL/GrjNtTtfK0qP69LkBe4s84IJqNmTdfwiyLP3S1
         rfAigT7mXm9SLOmWnEPwskLYGzvMglEDkngWVhmODU5nes7v1Lqcb2m2KFFTyOay6Zit
         TXNg==
X-Gm-Message-State: ANhLgQ1stCQl3TFqRbBYmRYsDXERR2ZnPVOMlEEJgrqAxGbo2n8wGzAj
        ePFhmRRDYzLdIfIPjm19FIX4JA==
X-Google-Smtp-Source: ADFU+vv+Psj2LxGAnvVhaqFOhyDsF8/04Uc9xGmW0Iao5vBArD3r7FNcmFkWoLPqY6mmAnAB1UAn1A==
X-Received: by 2002:a62:2a8d:: with SMTP id q135mr16987444pfq.220.1584142005020;
        Fri, 13 Mar 2020 16:26:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t11sm12598379pjo.21.2020.03.13.16.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 16:26:44 -0700 (PDT)
Date:   Fri, 13 Mar 2020 16:26:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 5/5] selftests: tls: run all tests for TLS 1.2 and TLS 1.3
Message-ID: <202003131626.9B7EFB607@keescook>
References: <20200313031752.2332565-1-kuba@kernel.org>
 <20200313031752.2332565-6-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313031752.2332565-6-kuba@kernel.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 12, 2020 at 08:17:52PM -0700, Jakub Kicinski wrote:
> TLS 1.2 and TLS 1.3 differ in the implementation.
> Use fixture parameters to run all tests for both
> versions, and remove the one-off TLS 1.2 test.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I really like the resulting effect here.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/testing/selftests/net/tls.c | 93 ++++++-------------------------
>  1 file changed, 17 insertions(+), 76 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
> index 0ea44d975b6c..63029728ac97 100644
> --- a/tools/testing/selftests/net/tls.c
> +++ b/tools/testing/selftests/net/tls.c
> @@ -101,6 +101,21 @@ FIXTURE(tls)
>  	bool notls;
>  };
>  
> +FIXTURE_PARAMS(tls)
> +{
> +	unsigned int tls_version;
> +};
> +
> +FIXTURE_PARAMS_ADD(tls, 12)
> +{
> +	.tls_version = TLS_1_2_VERSION,
> +};
> +
> +FIXTURE_PARAMS_ADD(tls, 13)
> +{
> +	.tls_version = TLS_1_3_VERSION,
> +};
> +
>  FIXTURE_SETUP(tls)
>  {
>  	struct tls12_crypto_info_aes_gcm_128 tls12;
> @@ -112,7 +127,7 @@ FIXTURE_SETUP(tls)
>  	len = sizeof(addr);
>  
>  	memset(&tls12, 0, sizeof(tls12));
> -	tls12.info.version = TLS_1_3_VERSION;
> +	tls12.info.version = params->tls_version;
>  	tls12.info.cipher_type = TLS_CIPHER_AES_GCM_128;
>  
>  	addr.sin_family = AF_INET;
> @@ -733,7 +748,7 @@ TEST_F(tls, bidir)
>  		struct tls12_crypto_info_aes_gcm_128 tls12;
>  
>  		memset(&tls12, 0, sizeof(tls12));
> -		tls12.info.version = TLS_1_3_VERSION;
> +		tls12.info.version = params->tls_version;
>  		tls12.info.cipher_type = TLS_CIPHER_AES_GCM_128;
>  
>  		ret = setsockopt(self->fd, SOL_TLS, TLS_RX, &tls12,
> @@ -1258,78 +1273,4 @@ TEST(keysizes) {
>  	close(cfd);
>  }
>  
> -TEST(tls12) {
> -	int fd, cfd;
> -	bool notls;
> -
> -	struct tls12_crypto_info_aes_gcm_128 tls12;
> -	struct sockaddr_in addr;
> -	socklen_t len;
> -	int sfd, ret;
> -
> -	notls = false;
> -	len = sizeof(addr);
> -
> -	memset(&tls12, 0, sizeof(tls12));
> -	tls12.info.version = TLS_1_2_VERSION;
> -	tls12.info.cipher_type = TLS_CIPHER_AES_GCM_128;
> -
> -	addr.sin_family = AF_INET;
> -	addr.sin_addr.s_addr = htonl(INADDR_ANY);
> -	addr.sin_port = 0;
> -
> -	fd = socket(AF_INET, SOCK_STREAM, 0);
> -	sfd = socket(AF_INET, SOCK_STREAM, 0);
> -
> -	ret = bind(sfd, &addr, sizeof(addr));
> -	ASSERT_EQ(ret, 0);
> -	ret = listen(sfd, 10);
> -	ASSERT_EQ(ret, 0);
> -
> -	ret = getsockname(sfd, &addr, &len);
> -	ASSERT_EQ(ret, 0);
> -
> -	ret = connect(fd, &addr, sizeof(addr));
> -	ASSERT_EQ(ret, 0);
> -
> -	ret = setsockopt(fd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
> -	if (ret != 0) {
> -		notls = true;
> -		printf("Failure setting TCP_ULP, testing without tls\n");
> -	}
> -
> -	if (!notls) {
> -		ret = setsockopt(fd, SOL_TLS, TLS_TX, &tls12,
> -				 sizeof(tls12));
> -		ASSERT_EQ(ret, 0);
> -	}
> -
> -	cfd = accept(sfd, &addr, &len);
> -	ASSERT_GE(cfd, 0);
> -
> -	if (!notls) {
> -		ret = setsockopt(cfd, IPPROTO_TCP, TCP_ULP, "tls",
> -				 sizeof("tls"));
> -		ASSERT_EQ(ret, 0);
> -
> -		ret = setsockopt(cfd, SOL_TLS, TLS_RX, &tls12,
> -				 sizeof(tls12));
> -		ASSERT_EQ(ret, 0);
> -	}
> -
> -	close(sfd);
> -
> -	char const *test_str = "test_read";
> -	int send_len = 10;
> -	char buf[10];
> -
> -	send_len = strlen(test_str) + 1;
> -	EXPECT_EQ(send(fd, test_str, send_len, 0), send_len);
> -	EXPECT_NE(recv(cfd, buf, send_len, 0), -1);
> -	EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
> -
> -	close(fd);
> -	close(cfd);
> -}
> -
>  TEST_HARNESS_MAIN
> -- 
> 2.24.1
> 

-- 
Kees Cook
