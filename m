Return-Path: <linux-kselftest+bounces-9805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0AB8C142C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 19:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02ABA281EAA
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 17:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F1B54FA5;
	Thu,  9 May 2024 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WgkBUypT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730E85477C
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715276385; cv=none; b=hS9G60u49wvKH6JUtQZOA/ZhXEnV2yoFIXyJBKA93XPjzhfPPjHPQHleREUR5qqs9Pimw6EVCxUduzMiZQQW0wTsMQhcog1Zvbv7mpnnsNz+hRrtfeMDY0gVqgBzkItPFOtKgPmftrmhkqEGHmPF2nnmd4jfMSmZcxbiaQeZlcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715276385; c=relaxed/simple;
	bh=uaNuxkbzdgHihbQ6NpVrvKhs9dxn4ioblyHHcHj3RQ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qEAC7GL3FANCC69j4fIA5hP+l6uhwaOad6CDmB9Ql/4enkgw4AAkD8Rkln5acVLr8TuhTN6uip+kgM1iagwzIlbaP3xqHAyvBrsw+6szoqnuBRp5PD8FZSVvFWdMAfzIjHvL5CUpnhHUfdaUBvWoWKxsNTiDri/8xrcD613efic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WgkBUypT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715276382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vo2RN8rDO3gH+oTYUY95UXyQf/SX3wrcQE13vlpNQus=;
	b=WgkBUypTtLM+AkPEnAc/nXHUwOwf3XJoL0K3I0ZTIJlH+CSidx2dnB1687HFwhMvteDsrE
	qyMLsWEkCdiAONCIiJ19cRf2cvFG712p1nXdAhq2SHMJwIbiwdymZhBKHyMc3sXnY0bSTL
	QOi1AwwvNYICeguzZOa0sth+muG57GA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-yFKFpWZzPES0sN6iEPjyDQ-1; Thu, 09 May 2024 13:39:40 -0400
X-MC-Unique: yFKFpWZzPES0sN6iEPjyDQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34eaba0b1ddso115001f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 10:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715276379; x=1715881179;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vo2RN8rDO3gH+oTYUY95UXyQf/SX3wrcQE13vlpNQus=;
        b=Gy1H/9ft5uNYtoxuJZO6qrLMV1FS/WmU+aur2fMOPDHagwgyIPRI7OUcaHTz+hMPpx
         m6ct9UgLBjv9HmZgibrzkLSIy8/KmUjeNdp/jChUvK7M4khx5fTlL0TAHuYNzJhNnYiV
         9OHrYghBlxy13oY/YxNwb7XrMfUr/s89TaO8pzg8obBp/Hab6OHgwS+h9P7dhhk9vB8n
         5yUfhLCKnHOT34waKF/5IpBlZve2bwodcLxpUlFOZKK3bxWgJuglk9c7yrUChEdJyqYV
         iuMQV12olSFFfohI52rsC7sd71oPhVZYKWLVfNk9k6PBqkfLu0tjYUaZmOMmlM4c+TA3
         1sGA==
X-Forwarded-Encrypted: i=1; AJvYcCXUPHP+sEnQM4+X/O//kbpjGdHwSzGkJL7g+XZcYECo1b8Wag43pbfjx9ym7qrVj/dp6oLLASgj6uHJhMQ9MmHSJEWCYBRoIkC2Tx9hw3IR
X-Gm-Message-State: AOJu0Yyh2bho5ZcDM+phZTomkqHCtUb568vTGxt/uoDE60lDxYbhKiSI
	aRokeViF6TNA7120xTFaLRldF+dwHkp06OZQdzpPxGjqyrnExUrsZ62wOewSeqxk+HMx6vFbidh
	4rvfcAR0vnKfKK+pnYtwFW74rtuDaO1emrhc3by8uBOLYjaaE12eyJU5R6CbvR1b3uw==
X-Received: by 2002:adf:c049:0:b0:350:4c83:d654 with SMTP id ffacd0b85a97d-3504c83d800mr73849f8f.1.1715276379775;
        Thu, 09 May 2024 10:39:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVTFwvk2oj4zaevdbFu34SDlX5q0ayYND1P8eJw88PQSBx20uDhCN4uS+pbrZw72ty2wCi6Q==
X-Received: by 2002:adf:c049:0:b0:350:4c83:d654 with SMTP id ffacd0b85a97d-3504c83d800mr73841f8f.1.1715276379369;
        Thu, 09 May 2024 10:39:39 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b68:1b10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a781asm2260415f8f.60.2024.05.09.10.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 10:39:38 -0700 (PDT)
Message-ID: <0bf4989c10917b2351636a2f19794e47f3d336e9.camel@redhat.com>
Subject: Re: [PATCH net] selftests: net: move amt to socat for better
 compatibility
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, shuah@kernel.org, 
	ap420073@gmail.com, linux-kselftest@vger.kernel.org
Date: Thu, 09 May 2024 19:39:36 +0200
In-Reply-To: <20240509161952.3940476-1-kuba@kernel.org>
References: <20240509161952.3940476-1-kuba@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-09 at 09:19 -0700, Jakub Kicinski wrote:
> The test seems to expect that nc will exit after the first
> received message. This is not the case with Ncat 7.94.
> There are multiple versions of nc out there, switch
> to socat for better compatibility.
>=20
> Tell socat to exit after 128 bytes and pad the message.
>=20
> Since the test sets -e make sure we don't set exit code
> (|| true) and print the pass / fail rather then silently
> moving over the test and just setting non-zero exit code
> with no output indicating what failed.
>=20
> Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: ap420073@gmail.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/amt.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests=
/net/amt.sh
> index 75528788cb95..5175a42cbe8a 100755
> --- a/tools/testing/selftests/net/amt.sh
> +++ b/tools/testing/selftests/net/amt.sh
> @@ -210,8 +210,8 @@ check_features()
> =20
>  test_ipv4_forward()
>  {
> -	RESULT4=3D$(ip netns exec "${LISTENER}" nc -w 1 -l -u 239.0.0.1 4000)
> -	if [ "$RESULT4" =3D=3D "172.17.0.2" ]; then
> +	RESULT4=3D$(ip netns exec "${LISTENER}" timeout 15 socat - UDP4-LISTEN:=
4000,readbytes=3D128 || true)
> +	if echo "$RESULT4" | grep -q "172.17.0.2"; then
>  		printf "TEST: %-60s  [ OK ]\n" "IPv4 amt multicast forwarding"
>  		exit 0
>  	else
> @@ -222,8 +222,8 @@ test_ipv4_forward()
> =20
>  test_ipv6_forward()
>  {
> -	RESULT6=3D$(ip netns exec "${LISTENER}" nc -w 1 -l -u ff0e::5:6 6000)
> -	if [ "$RESULT6" =3D=3D "2001:db8:3::2" ]; then
> +	RESULT6=3D$(ip netns exec "${LISTENER}" timeout 15 socat - UDP6-LISTEN:=
6000,readbytes=3D128 || true)
> +	if echo "$RESULT6" | grep -q "2001:db8:3::2"; then

The patch LGTM:

Acked-by: Paolo Abeni<pabeni@redhat.com>

As a minor note, shell variable expansion should already trim all the
trailing/leading spaces from the socat command output, so it should not
be necessary replace the string comparison with the grep command:

	RESULT6=3D$(ip netns exec "${LISTENER}" timeout 15 socat - UDP6-LISTEN:600=
0,readbytes=3D128 || true)
	if [ "$RESULT6" =3D=3D "2001:db8:3::2" ]; then

Should work

Cheers,

Paolo


