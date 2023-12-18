Return-Path: <linux-kselftest+bounces-2165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F339817AF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 20:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD17285FD6
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 19:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F64B72047;
	Mon, 18 Dec 2023 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WwC6rIZI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3D71477;
	Mon, 18 Dec 2023 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=DeGlvkmf7JbvE0tcyrLdxjYn4gMXVBumoPbNkhd0aQU=; b=WwC6rIZIejSiNehEe8vtqQOylB
	K7ljy/FKOjAygaJH2+58l37UR5BVxBeQ7Zw4CCftqsNXrT4TTFrVLnE8mBJ/NIKEtTjPt+yQ0BZGK
	F5fGCM9Xz+n7zUKVQDa3MTl2HN0HTbuVJwazhSQN7xcZ129cd//6hO4D04bnyB5Xxnfcfxt7aUdrn
	O2zqQSVNq4Oyr2fIOBsCt5mBiqaWpxDX7qpTr1iLauk1ag3zVlv+73YpMXnb6GFbvuRN47ZxbDSLw
	d90B8+SCVArMGtrkFbcbIBliBr58CNKpvHWjDzMn8791bg0L9eOBSl1SrwmWW/2+Nzsf/C6d18Wx1
	wi4C67HQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFJES-00BsrM-1g;
	Mon, 18 Dec 2023 19:24:52 +0000
Message-ID: <2b7964c1-3496-40de-bb61-a654d30b6fe6@infradead.org>
Date: Mon, 18 Dec 2023 11:24:51 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] selftests/net: Fix various spelling mistakes in
 TCP-AO tests
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231218133022.321069-1-colin.i.king@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231218133022.321069-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/18/23 05:30, Colin Ian King wrote:
> There are a handful of spelling mistakes in test messages in the
> TCP-AIO selftests. Fix these.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  tools/testing/selftests/net/tcp_ao/connect-deny.c      | 2 +-
>  tools/testing/selftests/net/tcp_ao/lib/proc.c          | 4 ++--
>  tools/testing/selftests/net/tcp_ao/setsockopt-closed.c | 2 +-
>  tools/testing/selftests/net/tcp_ao/unsigned-md5.c      | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/tcp_ao/connect-deny.c b/tools/testing/selftests/net/tcp_ao/connect-deny.c
> index 1ca78040d8b7..185a2f6e5ff3 100644
> --- a/tools/testing/selftests/net/tcp_ao/connect-deny.c
> +++ b/tools/testing/selftests/net/tcp_ao/connect-deny.c
> @@ -55,7 +55,7 @@ static void try_accept(const char *tst_name, unsigned int port, const char *pwd,
>  	err = test_wait_fd(lsk, timeout, 0);
>  	if (err == -ETIMEDOUT) {
>  		if (!fault(TIMEOUT))
> -			test_fail("timeouted for accept()");
> +			test_fail("timed out for accept()");
>  	} else if (err < 0) {
>  		test_error("test_wait_fd()");
>  	} else {
> diff --git a/tools/testing/selftests/net/tcp_ao/lib/proc.c b/tools/testing/selftests/net/tcp_ao/lib/proc.c
> index 2322f4d4676d..2fb6dd8adba6 100644
> --- a/tools/testing/selftests/net/tcp_ao/lib/proc.c
> +++ b/tools/testing/selftests/net/tcp_ao/lib/proc.c
> @@ -227,7 +227,7 @@ void netstat_print_diff(struct netstat *nsa, struct netstat *nsb)
>  		}
>  
>  		if (nsb->counters_nr < nsa->counters_nr)
> -			test_error("Unexpected: some counters dissapeared!");
> +			test_error("Unexpected: some counters disappeared!");
>  
>  		for (j = 0, i = 0; i < nsb->counters_nr; i++) {
>  			if (strcmp(nsb->counters[i].name, nsa->counters[j].name)) {
> @@ -244,7 +244,7 @@ void netstat_print_diff(struct netstat *nsa, struct netstat *nsb)
>  			j++;
>  		}
>  		if (j != nsa->counters_nr)
> -			test_error("Unexpected: some counters dissapeared!");
> +			test_error("Unexpected: some counters disappeared!");
>  
>  		nsb = nsb->next;
>  		nsa = nsa->next;
> diff --git a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
> index 7e4601b3f6a3..a329f42f40ce 100644
> --- a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
> +++ b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
> @@ -427,7 +427,7 @@ static void test_einval_del_key(void)
>  
>  	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
>  	del.set_current = 1;
> -	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, ENOENT, "set non-exising current key");
> +	setsockopt_checked(sk, TCP_AO_DEL_KEY, &del, ENOENT, "set non-existing current key");
>  
>  	sk = prepare_defs(TCP_AO_DEL_KEY, &del);
>  	del.set_rnext = 1;
> diff --git a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
> index 7cffde02d2be..14addfd46468 100644
> --- a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
> +++ b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
> @@ -72,7 +72,7 @@ static void try_accept(const char *tst_name, unsigned int port,
>  	err = test_wait_fd(lsk, timeout, 0);
>  	if (err == -ETIMEDOUT) {
>  		if (!fault(TIMEOUT))
> -			test_fail("timeouted for accept()");
> +			test_fail("timed out for accept()");
>  	} else if (err < 0) {
>  		test_error("test_wait_fd()");
>  	} else {

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

