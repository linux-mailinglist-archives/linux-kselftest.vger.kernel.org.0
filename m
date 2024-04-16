Return-Path: <linux-kselftest+bounces-8107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3E88A6791
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 11:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7971C217AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 09:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0988664A;
	Tue, 16 Apr 2024 09:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TiLZnJiM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2418624C
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261487; cv=none; b=bxFwVKXsYYgR/MrjlgtCeRBhHfRf9HiR4JpksZy+MSETHDH2pX36D0N2860cPlryykj/36ICjoNOE2OTlZiuAxkke6FWlRGeDSNPfrybLKT9k6jZnkY/RFeEUvlBqEdcUz0PgeNYzKHuV3l7l+oo6XnnP3vWhSaZVP2UXL/st6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261487; c=relaxed/simple;
	bh=KwZmFBYAqg+B+dbpT/j2cFN+N3E9//zZnas4MzkRbYI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K8zZIrly8QH41HLdIiZizt19LtlqlQtwX+2vccm9iFRAP/gI4fVk6jfIHXY0vGJZ3PkevU0zOtnQ5kdAJ8mt+KHBzclZWQYQE+Y2cyaG8raas52zyNair758WXLwBdHb62FyTGc4jAMmkeV/MjPMQKsgW5B8LOJxUtLVVc2ltEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TiLZnJiM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713261485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SFyR0xGSUlDFq4bRYadYqHqn2Ie/fiirEvayyMJ3GoA=;
	b=TiLZnJiMjeOTKA+72Ly0LVTxcnosFefycU+ikf3aOxSu9qM7KWfP5lpbf8RTR1euy5stWI
	CCDrhab8cOpkOLF0k9jng24xEW3q+iWYkEN5/X+vUixmx3W5/ymMTIDmyNkq1+cL6H18Og
	+5+/s/x4RYA6ttvvSn4aUajaX+rf1AQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-uj8hZ0ULM4GxPZGgaxKaFw-1; Tue, 16 Apr 2024 05:58:03 -0400
X-MC-Unique: uj8hZ0ULM4GxPZGgaxKaFw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3457b0dca26so179606f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 02:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261482; x=1713866282;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFyR0xGSUlDFq4bRYadYqHqn2Ie/fiirEvayyMJ3GoA=;
        b=YsdySrGRsRzjElUyWiF6r6jGTt0uEV1G5D9DxMIC3jE7hEIGWZTnyI0ScsNY2wSW0T
         M5+LMhMAuFtfGGraXyNf+ZoXIadUIPIYA/VaGF2IapbtB+LVmH22eDXxmXpPSmuPHz+O
         YLpwf37fw08i3ykCpPaGCuIu0OAt1VskY15jK01qt/IDhn45c30DWykSc2YG9QDcOu1Y
         lClFvicBn5bQ27WJhinjKu0pY6MLv6AMbcmQG+Q+XyaiIfaDOQQWvAespsP7gr9cb59L
         ee+0X59L/t/unhEJd74zxZLDMBaYyRcyJjPp3QpsE7DXjfIAocvsc7m/T+zllcqh2s3W
         ITeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+qjrKbtCtYrGD65ob52PN4P+1YcRGuwxBAsWLx8yJmDrRdM4u/9rPYJsMht7/JQKoGA2PMliSXoeXh531dsk/nmAus0I5gtpTVjXOfHO6
X-Gm-Message-State: AOJu0Yy2iYDwhwaWolkxGf4wFsJnPU9tkX2Qnm2VWqwL5PMrf2hrXAo9
	kFlTVKYYmOA8rOgPzWk+/qSrenlWFRkTRfZzDl2LXk/Vyf4YOdUffr14WErE6wqU0sJF0ldDfia
	NnrGSWtt7SfTUln5i7QTtjAms3BJD99QArzRHCXLAeU+ggy7j4vMmbbROJ7Bet/xtWQ==
X-Received: by 2002:a5d:4e0a:0:b0:33e:c97c:a24 with SMTP id p10-20020a5d4e0a000000b0033ec97c0a24mr8655150wrt.5.1713261482472;
        Tue, 16 Apr 2024 02:58:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+H5GtR4dSPDHt/X+BdOZkvjiofnARPzbWkG4xJmpYzugS0LVJxkMttR2eDMl8n/s2qgnC1g==
X-Received: by 2002:a5d:4e0a:0:b0:33e:c97c:a24 with SMTP id p10-20020a5d4e0a000000b0033ec97c0a24mr8655137wrt.5.1713261482092;
        Tue, 16 Apr 2024 02:58:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-31.dyn.eolo.it. [146.241.231.31])
        by smtp.gmail.com with ESMTPSA id di7-20020a0560000ac700b003439d2a5f99sm14291462wrb.55.2024.04.16.02.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 02:58:01 -0700 (PDT)
Message-ID: <469c26d112600bce3a7fe77131c62eae4ecae5d1.camel@redhat.com>
Subject: Re: [PATCH net-next v7 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
From: Paolo Abeni <pabeni@redhat.com>
To: Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, dsahern@kernel.org, 
	willemdebruijn.kernel@gmail.com, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Tue, 16 Apr 2024 11:58:00 +0200
In-Reply-To: <a36bf0b117f7786bbf028494d68185486025777d.camel@redhat.com>
References: <20240412155533.115507-1-richardbgobert@gmail.com>
	 <20240412155533.115507-3-richardbgobert@gmail.com>
	 <a36bf0b117f7786bbf028494d68185486025777d.camel@redhat.com>
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

On Tue, 2024-04-16 at 11:21 +0200, Paolo Abeni wrote:
> On Fri, 2024-04-12 at 17:55 +0200, Richard Gobert wrote:
> > {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> > iph->id, ...) against all packets in a loop. These flush checks are use=
d
> > currently in all tcp flows and in some UDP flows in GRO.
> >=20
> > These checks need to be done only once and only against the found p skb=
,
> > since they only affect flush and not same_flow.
> >=20
> > Leveraging the previous commit in the series, in which correct network
> > header offsets are saved for both outer and inner network headers -
> > allowing these checks to be done only once, in tcp_gro_receive and
> > udp_gro_receive_segment. As a result, NAPI_GRO_CB(p)->flush is not used=
 at
> > all. In addition, flush_id checks are more declarative and contained in
> > inet_gro_flush, thus removing the need for flush_id in napi_gro_cb.
> >=20
> > This results in less parsing code for UDP flows and non-loop flush test=
s
> > for TCP flows.
> >=20
> > To make sure results are not within noise range - I've made netfilter d=
rop
> > all TCP packets, and measured CPU performance in GRO (in this case GRO =
is
> > responsible for about 50% of the CPU utilization).
> >=20
> > L3 flush/flush_id checks are not relevant to UDP connections where
> > skb_gro_receive_list is called. The only code change relevant to this f=
low
> > is inet_gro_receive. The rest of the code parsing this flow stays the
> > same.
> >=20
> > All concurrent connections tested are with the same ip srcaddr and
> > dstaddr.
> >=20
> > perf top while replaying 64 concurrent IP/UDP connections (UDP fwd flow=
):
> > net-next:
> >         3.03%  [kernel]  [k] inet_gro_receive
> >=20
> > patch applied:
> >         2.78%  [kernel]  [k] inet_gro_receive
>=20
> Why there are no figures for
> udp_gro_receive_segment()/gro_network_flush() here?
>=20
> Also you should be able to observer a very high amount of CPU usage by
> GRO even with TCP with very high speed links, keeping the BH/GRO on a
> CPU and the user-space/data copy on a different one (or using rx zero
> copy).

To be more explicit: I think at least the above figures are required,=C2=A0
and I still fear the real gain in that case would range from zero to
negative.=20

If you can't do the TCP part of the testing, please provide at least
the figures for a single UDP flow, that should give more indication WRT
the result we can expect with TCP.

Note that GRO is used mainly by TCP and TCP packets with different
src/dst port will land into different GRO hash buckets, having
different RX hash.

That will happen even for UDP, at least for some (most?) nics include
the UDP ports in the RX hash.

Thanks,

Paolo


