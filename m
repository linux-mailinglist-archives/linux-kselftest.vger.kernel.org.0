Return-Path: <linux-kselftest+bounces-4458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4055B84F9F8
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 17:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C7AB21C61
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 16:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6E27C0A9;
	Fri,  9 Feb 2024 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehkFeSbN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E817B3F3
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Feb 2024 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497135; cv=none; b=FOc2hLJjq1wy8yJ58yH73fQIiwKt78MswNv1FxlEUmQ9ZNUuY6tE+NId/XEFXq/3f7HezXfdIx6vFQNI2t2/fVs1Y4kr0hMKG6nEbkVd7RS6T/an3XPbb/KEKFMDPSXKsdg4Vb/jzwPfcZqyfwiUnOpGoxvXNRyJ3XxbpBwpJyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497135; c=relaxed/simple;
	bh=fOr7xFvfM4rd/02JsZAgF/8VCH/+1220k69orXmDPo8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SNYYSyr3o3KjdRyyyVokGHOIlUY/bJ6qEG4HkMVsPRzfxzWxnyQKDzyClgtuqNdJEgauSdlFDFjpTMbOR5mHSBPRq9mWFbps3/YL8TuK44heqkvHiPey8dCt5avSpagihvsWPvb0LegIchSuCZKySIwJbyaJAkOTMk63JlXR3rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehkFeSbN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707497133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y8IUz/WHM9+M3AF6O/llN6R76VK+QIIm7K5QCYPk/1Y=;
	b=ehkFeSbNgxEfFcdWcxJEMq3Cw9lVMPLjwjH/HL4bQ+3IFmpTDoZULa6pkzOHHD2jcsTSg+
	WRcpgCBrI+Zfa/UVe66wWjd4W4m7lbQyZ1Sai8duTOgj9gJ/VvrbUKRPEvpmpr0ooA1MY1
	0d+8n23Az74oGsgSD3moKp5odiyvnGk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-Vq3MwSuxPra1Y0dFKcw5Rw-1; Fri, 09 Feb 2024 11:45:32 -0500
X-MC-Unique: Vq3MwSuxPra1Y0dFKcw5Rw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3377bf95b77so94073f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Feb 2024 08:45:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707497131; x=1708101931;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8IUz/WHM9+M3AF6O/llN6R76VK+QIIm7K5QCYPk/1Y=;
        b=gCMx/YoKxj3A3v8ah/sP+yHvECObnIPpho4BRZfy0VJKT4u0qC521QsibOV3K03mz9
         3Wu/xqKat62HdyU37x04DHvzOD0xAELtzzGuGCbRzJjHmCrxIFzVBTC3oCtDSSHwFKb9
         W2l59iD6TsAeX8ihMIzEJBrPie5UBPn7HDnggwTbQVdqiHpBWQW8EyBC4S5hJz9rpmpf
         hLZCy9kvrr9PfrnDQdGuCwImQBIm1ng+ROla8QoDe8Ipf4rXYAKO93boWJtyVKb2I2w6
         gB18BYyNw0kqeVLSRNyijyeRkgjx5Du6LOG8YoKul/Tkfmas+B+a3P2GhM3n1wJM+EJo
         uUZw==
X-Forwarded-Encrypted: i=1; AJvYcCXghuH+8TsIeEM72IL9gzSjm8aWOgY8X24sflIteoewsj8FSa9V5wS9lVy5DGBrl6VGkRbhQaIg7SXhHEpGhNe9LOarlNnay1nWYoZEe6wK
X-Gm-Message-State: AOJu0YxSibcKY5uBpMn/QhsO4W4PnZSgxCnT10oCXdc1GGe2MRkH4pIR
	HzKG8nmKlKziaFlrEYdKQCPN701GbYa0Nkd796FX+oRcfdDYNuC9Gl9HleDaR7Z2USiQBo+cevp
	MlInyV1snktgS+xxeEXNzFIfPV3Ok/k+swt4MC3K/1s/oB2ilFnuA9brLDSjmzU+uJQ==
X-Received: by 2002:a05:6000:3cb:b0:33b:49da:5f27 with SMTP id b11-20020a05600003cb00b0033b49da5f27mr1832827wrg.1.1707497130730;
        Fri, 09 Feb 2024 08:45:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEvCJJlndPkjei3/7GOG8/YYBOrqkwvyHOuioq8DS51khP1dKywMY+YGkDvQK2oK2nI/HnSA==
X-Received: by 2002:a05:6000:3cb:b0:33b:49da:5f27 with SMTP id b11-20020a05600003cb00b0033b49da5f27mr1832814wrg.1.1707497130393;
        Fri, 09 Feb 2024 08:45:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJmo3n564UEjJfDhs0TCLa5VkqFjuqGV/4K5bOmdklnoc0C7kKlv3gHLVEDT7FSzgvWdFt0C8j9ciO8OIAn0KJJNqbQcCvtc2T05N2G2qOKIQXEKNgkGMOElDrfeQ0oA4SZYFeOS9dlwdFf2J3XuRAMbKU3CtvoG3dZgxJCjE10MVtVDDDFo2Q3QILseSRAcH0JrbrzAhBUNOrTlOhCgStyClGe4O/wFmWkgntVRyzHvBSBsoWumYLSg==
Received: from gerbillo.redhat.com (146-241-228-88.dyn.eolo.it. [146.241.228.88])
        by smtp.gmail.com with ESMTPSA id bk14-20020a0560001d8e00b0033b11e91c0bsm2236407wrb.81.2024.02.09.08.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:45:29 -0800 (PST)
Message-ID: <ee9d2e224d063dc66070b060f716219c976759cd.camel@redhat.com>
Subject: Re: [PATCH net] selftests: net: wait for receiver startup in
 so_txtime.sh
From: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemb@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 linux-kselftest@vger.kernel.org,  netdev@vger.kernel.org
Date: Fri, 09 Feb 2024 17:45:28 +0100
In-Reply-To: <5b768c89eb2992c22ca7016de9f90ff7d4eecd5f.camel@redhat.com>
References: 
	<53a7e56424756ef35434bc15a90b256bcf724651.1707407012.git.pabeni@redhat.com>
	 <5b768c89eb2992c22ca7016de9f90ff7d4eecd5f.camel@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-09 at 15:51 +0100, Paolo Abeni wrote:
> On Thu, 2024-02-08 at 16:45 +0100, Paolo Abeni wrote:
> > The mentioned test is failing in slow environments:
> >=20
> >   # SO_TXTIME ipv4 clock monotonic
> >   # ./so_txtime: recv: timeout: Resource temporarily unavailable
> >   not ok 1 selftests: net: so_txtime.sh # exit=3D1
> >=20
> > The receiver is started in background and the sender could end-up
> > transmitting the packet before the receiver is ready, so that the
> > later recv times out.
> >=20
> > Address the issue explcitly waiting for the socket being bound to
> > the relevant port.
> >=20
> > Fixes: af5136f95045 ("selftests/net: SO_TXTIME with ETF and FQ")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > Note that to really cope with slow env the mentioned self-tests also
> > need net-next commit c41dfb0dfbec ("selftests/net: ignore timing
> > errors in so_txtime if KSFT_MACHINE_SLOW"), so this could be applied to
> > net-next, too
>=20
> Oops... CI is saying the above is not enough...
>=20
> > @@ -65,6 +70,7 @@ do_test() {
> > =20
> >  	local readonly START=3D"$(date +%s%N --date=3D"+ 0.1 seconds")"
> >  	ip netns exec "${NS2}" "${BIN}" -"${IP}" -c "${CLOCK}" -t "${START}" =
-S "${SADDR}" -D "${DADDR}" "${RXARGS}" -r &
> > +	wait_local_port_listen "${NS2}" 8000 "${PROTO}"
> >  	ip netns exec "${NS1}" "${BIN}" -"${IP}" -c "${CLOCK}" -t "${START}" =
-S "${SADDR}" -D "${DADDR}" "${TXARGS}"
>=20
> The binary explicitly waits up to $START time, and that conflicts with
> the wait_local_port_listen, something different is needed. Apparently I
> was just "lucky" during my local testing.

I experimented a few different solutions and so far the only option
that gave some positive result is increasing start delay and the etf
delta by an order of magnitude, see below.

But I'm pretty sure that even with that there will be sporadic failures
in slow enough environments.

When the host-induced jitter/delay is high enough, packets are dropped
and there are functional failures. I'm wondering if we should skip this
test entirely when KSFT_MACHINE_SLOW=3Dyes.

Do you see any other options?

Paolo

---
diff --git a/tools/testing/selftests/net/so_txtime.sh b/tools/testing/selft=
ests/net/so_txtime.sh
index 3f06f4d286a9..6445580f0a66 100755
--- a/tools/testing/selftests/net/so_txtime.sh
+++ b/tools/testing/selftests/net/so_txtime.sh
@@ -63,7 +63,9 @@ do_test() {
 		exit 1
 	fi
=20
-	local readonly START=3D"$(date +%s%N --date=3D"+ 0.1 seconds")"
+	local delta=3D0.1
+	[ -n "${KSFT_MACHINE_SLOW}" ] && delta=3D1
+	local readonly START=3D"$(date +%s%N --date=3D"+ ${delta} seconds")"
 	ip netns exec "${NS2}" "${BIN}" -"${IP}" -c "${CLOCK}" -t "${START}" -S "=
${SADDR}" -D "${DADDR}" "${RXARGS}" -r &
 	ip netns exec "${NS1}" "${BIN}" -"${IP}" -c "${CLOCK}" -t "${START}" -S "=
${SADDR}" -D "${DADDR}" "${TXARGS}"
 	wait "$!"
@@ -76,7 +78,9 @@ do_test 6 mono a,10 a,10
 do_test 4 mono a,10,b,20 a,10,b,20
 do_test 6 mono a,20,b,10 b,20,a,20
=20
-if ip netns exec "${NS1}" tc qdisc replace dev "${DEV}" root etf clockid C=
LOCK_TAI delta 400000; then
+delta=3D400000
+[ -n "${KSFT_MACHINE_SLOW}" ] && delta=3D$((delta*10))
+if ip netns exec "${NS1}" tc qdisc replace dev "${DEV}" root etf clockid C=
LOCK_TAI delta "${delta}"; then
 	! do_test 4 tai a,-1 a,-1
 	! do_test 6 tai a,0 a,0
 	do_test 6 tai a,10 a,10


