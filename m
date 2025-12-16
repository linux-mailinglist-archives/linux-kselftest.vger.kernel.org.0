Return-Path: <linux-kselftest+bounces-47615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 82039CC50BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 20:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E29F33008EFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 19:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD813358BE;
	Tue, 16 Dec 2025 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYfJABa4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0720032F765
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765914903; cv=none; b=XUoW8mgKDoOcLiQj3cRtM3LdfJi/Zd3Y6pSAWhMWdg1dD4llvC1A5bp/+Pm5uGsRj1eAwcJiesRvaEU8J7xXu9M/zZmJX8CjuvJ9YLb6ckc0D3Q2pJEfTOa1ohLp5oAEPrEkSfVv0ffprVs8jsYlGYKOUbgagAogmn74iLSYjdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765914903; c=relaxed/simple;
	bh=MfqDH4/O8KDzWjnyDBeFxR8tAnjUXaceNmNX3aeJYhE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uV+KQpVMel6MU3aVA6sRbzvLxOBbqmBrazXD5vHJcIIxOz0Ch3AIyPcCk5wNGTae93CDuChwIoOy2ztfaZKPlSjIHN3EA5oJdrtHf2DiGi4LyJKDgmHxNZwEesQzoTZD5ibKib1qb/AdQDbiHFQMBRFULssn7bLO/M88CwAdJsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYfJABa4; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-787da30c50fso49758657b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 11:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765914899; x=1766519699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=be7JUAAiM3hDUesPFCNkuJpo8VlqDg0Gc+p9llIp0js=;
        b=AYfJABa48t0H317KhfFy5O3tHj6oi+LPM9OYatXKr2FGi/O4RgNokgbSm1m4dI6XzR
         e2EUa6RTUxjexvT0W37OKnJ3mw064PSkj/87dbCRNm7qJIlUi7gg9V0mGLX2AGHhiz1P
         E7hwZYT6H+1v2jHCG04vyEBv4X+1/IlpZDXeZKS2pvq9Dp8EQqh+iLxOu22cN7qBy6Ra
         UDHeTZMDY2hHspiASXoVovMLg27UcSm037cGxVX+5OzQKrcz3NGGx/v86r2rFjU67lZR
         nmifE+L2FVDE0TVySD/vOvmrbf8izbi6wOO32HKpdCeBWCgnfuVz0KAcROMbbSn92Sri
         KuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765914899; x=1766519699;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=be7JUAAiM3hDUesPFCNkuJpo8VlqDg0Gc+p9llIp0js=;
        b=YaUCLcd68DljFu9fdHNgG/gHAOUFb+m+1lWpbYHFcvN7f4Rvs54RV8tWOF46NSxKVY
         heoVBMD6Le5gRytQQPz4NBRaj6KFVMliOeceofvd48UNxg9l3kDl95V7NP2lUnybhpiz
         c498o25aWhYYAlB6oo6VU3fRomnPeq5nsC6vs16ytP0A4Ag4KPFJQawonZgmYEt0lL+Q
         YpcyfL7Ii4zLifJQHlP9z6sicrQd9YsQoNti2VCQ4S5VSv1UWMQo5Fs3tEB3A3epTGUX
         /ExIxur2HAfn681OobZ4AQ8412blzjjoaB/SQ/ztlqs4GS78krtnE9LPYjO1TVs7XD+k
         b+yg==
X-Gm-Message-State: AOJu0Ywxmt3F8AkLuu46lsHIb6XK3/8DnKVaye35AvLwNbnCazIurooQ
	fB5ANHRcLp5+5XNCOT0KuQ0the8brW707q/HyGsLWGPk5R7em8bUVqL3
X-Gm-Gg: AY/fxX7wVg/zqfu2SzAgV9p9ooGIKTuILZBaMeNFo52ALQ0+ZkrTEmZl7GOexpUxREl
	2uszyaVieAB519mb7XhwbhWdHBST0V8HDe+p+E6EY0Vnodb/0eD3oaZ37Ssqd9xvuYNU3wiAM17
	GmGC0jwIXPkNLiISDvmthjRwpsSnXQc+h017kHPq9WS4X5ytazglXoTnVeR4I5ou42G4GJOlIw+
	jmBp5qoqX4YpQD+mwxSnAFISDBpvV0jcqi8Nr1YivW+5SMbOmqV7Ws0iDfb38iSTWAU1S8PlksO
	0DBZrfMlteiqfO+LzTogAOd5mcEuoiwdv++Vvhe3Lkuns43f/QK4Tyxz4DvKifZRuVOdMDqzZxV
	+ajeSvtEr3so53uvzy68Ht8TmVTptXGnaSRpV2UNmfL+rIWp/SZRKok7upr/4gM7cIO0TSx3EWg
	yKg3cv+RfOP5Aa0JhXp8Lf2B37eBgbLaS/pLhoDwqEET64g/QWNWGgfV0ThoXKjhfs6mkluRTCp
	Q1MbA==
X-Google-Smtp-Source: AGHT+IEuqpeuP1UDy+6XnjcNYN1ogGOeKRu57NupIJPcHrmfdc0of+efEM03iL2q5TAnMgXbrad84Q==
X-Received: by 2002:a05:690c:3581:b0:78e:1aa5:e98a with SMTP id 00721157ae682-78e66dc9157mr271655907b3.37.1765914898696;
        Tue, 16 Dec 2025 11:54:58 -0800 (PST)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64477dab686sm8053046d50.16.2025.12.16.11.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 11:54:58 -0800 (PST)
Date: Tue, 16 Dec 2025 14:54:57 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Alice C. Munduruca" <alice.munduruca@canonical.com>, 
 netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, 
 "Alice C. Munduruca" <alice.munduruca@canonical.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Cengiz Can <cengiz.can@canonical.com>, 
 cbulinaru@gmail.com
Message-ID: <willemdebruijn.kernel.311f094b4d393@gmail.com>
In-Reply-To: <20251216170641.250494-1-alice.munduruca@canonical.com>
References: <20251216170641.250494-1-alice.munduruca@canonical.com>
Subject: Re: [PATCH net v3] selftests: net: fix "buffer overflow detected" for
 tap.c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alice C. Munduruca wrote:
> When the selftest 'tap.c' is compiled with '-D_FORTIFY_SOURCE=3',
> the strcpy() in rtattr_add_strsz() is replaced with a checked
> version which causes the test to consistently fail when compiled
> with toolchains for which this option is enabled by default.
> 
>  TAP version 13
>  1..3
>  # Starting 3 tests from 1 test cases.
>  #  RUN           tap.test_packet_valid_udp_gso ...
>  *** buffer overflow detected ***: terminated
>  # test_packet_valid_udp_gso: Test terminated by assertion
>  #          FAIL  tap.test_packet_valid_udp_gso
>  not ok 1 tap.test_packet_valid_udp_gso
>  #  RUN           tap.test_packet_valid_udp_csum ...
>  *** buffer overflow detected ***: terminated
>  # test_packet_valid_udp_csum: Test terminated by assertion
>  #          FAIL  tap.test_packet_valid_udp_csum
>  not ok 2 tap.test_packet_valid_udp_csum
>  #  RUN           tap.test_packet_crash_tap_invalid_eth_proto ...
>  *** buffer overflow detected ***: terminated
>  # test_packet_crash_tap_invalid_eth_proto: Test terminated by assertion
>  #          FAIL  tap.test_packet_crash_tap_invalid_eth_proto
>  not ok 3 tap.test_packet_crash_tap_invalid_eth_proto
>  # FAILED: 0 / 3 tests passed.
>  # Totals: pass:0 fail:3 xfail:0 xpass:0 skip:0 error:0
> 
> A buffer overflow is detected by the fortified glibc __strcpy_chk()
> since the __builtin_object_size() of `RTA_DATA(rta)` is incorrectly
> reported as 1, even though there is ample space in its bounding
> buffer `req`.
> 
> Additionally, given that IFLA_IFNAME also expects a null-terminated
> string, callers of rtaddr_add_str{,sz}() could simply use the
> rtaddr_add_strsz() variant. (which has been renamed to remove the
> trailing `sz`) memset() has been used for this function since it
> is unchecked and thus circumvents the issue discussed in the
> previous paragraph.
> 
> Fixes: 2e64fe4624d1 ("selftests: add few test cases for tap driver")
> Signed-off-by: Alice C. Munduruca <alice.munduruca@canonical.com>
> Reviewed-by: Cengiz Can <cengiz.can@canonical.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Cc: original author cbulinaru@gmail.com in case we're overlooking a
reason for the split between rtattr_add_str and rtattr_add_strsz.

the first avoids the \0 and is used for IFLA_NAME. Device names are
guaranteed to fit into IFNAMSIZ, including the terminating \0.
> ---
>  tools/testing/selftests/net/tap.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/net/tap.c
> index 247c3b3ac1c9..51a209014f1c 100644
> --- a/tools/testing/selftests/net/tap.c
> +++ b/tools/testing/selftests/net/tap.c
> @@ -56,18 +56,12 @@ static void rtattr_end(struct nlmsghdr *nh, struct rtattr *attr)
>  static struct rtattr *rtattr_add_str(struct nlmsghdr *nh, unsigned short type,
>  				     const char *s)
>  {
> -	struct rtattr *rta = rtattr_add(nh, type, strlen(s));
> +	unsigned int strsz = strlen(s) + 1;
> +	struct rtattr *rta;
>  
> -	memcpy(RTA_DATA(rta), s, strlen(s));
> -	return rta;
> -}
> -
> -static struct rtattr *rtattr_add_strsz(struct nlmsghdr *nh, unsigned short type,
> -				       const char *s)
> -{
> -	struct rtattr *rta = rtattr_add(nh, type, strlen(s) + 1);
> +	rta = rtattr_add(nh, type, strsz);
>  
> -	strcpy(RTA_DATA(rta), s);
> +	memcpy(RTA_DATA(rta), s, strsz);
>  	return rta;
>  }
>  
> @@ -119,7 +113,7 @@ static int dev_create(const char *dev, const char *link_type,
>  
>  	link_info = rtattr_begin(&req.nh, IFLA_LINKINFO);
>  
> -	rtattr_add_strsz(&req.nh, IFLA_INFO_KIND, link_type);
> +	rtattr_add_str(&req.nh, IFLA_INFO_KIND, link_type);
>  
>  	if (fill_info_data) {
>  		info_data = rtattr_begin(&req.nh, IFLA_INFO_DATA);
> -- 
> 2.48.1
> 



