Return-Path: <linux-kselftest+bounces-3571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF7483C662
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 16:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74291C2248E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 15:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C486EB54;
	Thu, 25 Jan 2024 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GpkiqwxD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A221F633E4
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195952; cv=none; b=Y2W3zI2cXtwsWR3jtLPSUnrorLna0rqMfYd/lD4J9Xi0p/rLeajEo7iQcd+f4ni7Ut3UyYSNdU0MdUPfAHfsq7flEapnVgs7R/iDyZQju6XsxmFTZB8joBehGU+8O7MpDUEWn2B5E98J4O0dq8fCMpRW5FoWuuOI1GC9VY5+dqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195952; c=relaxed/simple;
	bh=1pVPCaQjguS2ddE3kHNUXAUboEPMUgE+XH/jHQJP7dY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DfgtbkOVdiG8uyWluUCe2ZntQMA1RtSsbcAz/1wCpatuZuVTecJthQfrwXTPf9oWynfV5kzO7sJKTyK+PLo8P2Ohh05beOUmcVubbIWKMPXbATiyB/5Myd2/iAaGdZhKjhuoJ+oME1z6LFTiL3j5nSkvKSjWq7pGqvvRSeHqUMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GpkiqwxD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706195949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b3d5gwjI5z4xzTOWJFLPuYP72sgfCd1HOKH2J8/I/4I=;
	b=GpkiqwxD+foNr9rbVqUah1mc0mvJ3TAkhgDRMb4FxM21PbtFdX8HCpeVdhZG5Ulkf708da
	SyNeSOG0V8g4mJLen+84zYZ1P1WoDalLjmlHTA9JO8fhZZNBF5glf34JSJbyVlBF/jEwbB
	oi+06kOtrMdqM/GmG/Lab8kGgldrOqs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694--XGQZ0TmNAKlsLVDE6Bd2g-1; Thu, 25 Jan 2024 10:19:07 -0500
X-MC-Unique: -XGQZ0TmNAKlsLVDE6Bd2g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e703adab9so14752645e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 07:19:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706195946; x=1706800746;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3d5gwjI5z4xzTOWJFLPuYP72sgfCd1HOKH2J8/I/4I=;
        b=ZrXRtuht9AqX+pje9K+uaLesVf5MvQIFO9dXei4I5ukvXtxDb+MT5vlrsq92bVKVzE
         f7cMdbG6JtCAkuJu19duI8JS3o/1WjQ+V3MGM94Arj1ezpQ4Eg2ASvtMVjvPBwBQT/92
         77W0mtR42nIMqXC3h360BPeZMG9UbWcsShDs1KvEKWhDI5DYGJ+MYwT1HFLS0TVKPSFJ
         2L7EokBU8Ogj/L337el1RDrfnHiIZUhgUa+oKkh4Ni7l7iIczh7d2vSGsmXzV3pwRYNM
         k3Nsij6VFvLqMTh049lDDeq0SMDAeZkcgKIDMBp9rXvRA6umuL7PLtECq0ntH9KbRwLd
         7Ojw==
X-Gm-Message-State: AOJu0YxsrSxs+fdZVWfYEx9yEYPEHxqAwgDPAS7WincYGKHxwMdkePFC
	wta4bvosdSRhJjLYij4YBWmB3dULiu/RHMXumsMLotXecrSSAPCs/QRKQ198RX904H1TvmVj5ic
	7NT3c2atYB4PY2rlrxYaPZbX+lLE4y6v8ABNRNxo+qZlzv4wPAVm6ml/5Sm6gkEVa/A==
X-Received: by 2002:a05:600c:3b24:b0:40e:8e43:4995 with SMTP id m36-20020a05600c3b2400b0040e8e434995mr1467152wms.0.1706195946427;
        Thu, 25 Jan 2024 07:19:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IED8hr5tJTQTdN62soElTb1owUbbZsY5MVefC8+/0wfNsBZgWGNuCSxp5W9cqbLjBmX2BcvTg==
X-Received: by 2002:a05:600c:3b24:b0:40e:8e43:4995 with SMTP id m36-20020a05600c3b2400b0040e8e434995mr1467134wms.0.1706195946070;
        Thu, 25 Jan 2024 07:19:06 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-244-75.dyn.eolo.it. [146.241.244.75])
        by smtp.gmail.com with ESMTPSA id f16-20020a05600c155000b0040ebf5956absm2963931wmg.29.2024.01.25.07.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:19:05 -0800 (PST)
Message-ID: <6cb2ddf941698e2feb780dfae9325e98cd39d7a9.camel@redhat.com>
Subject: Re: [PATCH net 1/3] selftests: net: remove dependency on ebpf tests
From: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>, Lucas Karpinski
 <lkarpins@redhat.com>,  linux-kselftest@vger.kernel.org
Date: Thu, 25 Jan 2024 16:19:04 +0100
In-Reply-To: <65b26fe61346d_2b890a294b4@willemb.c.googlers.com.notmuch>
References: <cover.1706131762.git.pabeni@redhat.com>
	 <28e7af7c031557f691dc8045ee41dd549dd5e74c.1706131762.git.pabeni@redhat.com>
	 <65b1b4e92df6_250560294f4@willemb.c.googlers.com.notmuch>
	 <49d15fe58d9cd415ca96739b08c59c7cde5c3422.camel@redhat.com>
	 <65b26fe61346d_2b890a294b4@willemb.c.googlers.com.notmuch>
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

On Thu, 2024-01-25 at 09:27 -0500, Willem de Bruijn wrote:
> Paolo Abeni wrote:
> > On Wed, 2024-01-24 at 20:10 -0500, Willem de Bruijn wrote:
> > > Paolo Abeni wrote:
> > > > Several net tests requires an XDP program build under the ebpf
> > > > directory, and error out if such program is not available.
> > > >=20
> > > > That makes running successful net test hard, let's duplicate into t=
he
> > > > net dir the [very small] program, re-using the existing rules to bu=
ild
> > > > it, and finally dropping the bogus dependency.
> > > >=20
> > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > > ---
> > > >  tools/testing/selftests/net/Makefile          |  5 +++--
> > > >  tools/testing/selftests/net/udpgro.sh         |  4 ++--
> > > >  tools/testing/selftests/net/udpgro_bench.sh   |  4 ++--
> > > >  tools/testing/selftests/net/udpgro_frglist.sh |  6 +++---
> > > >  tools/testing/selftests/net/udpgro_fwd.sh     |  2 +-
> > > >  tools/testing/selftests/net/veth.sh           |  4 ++--
> > > >  tools/testing/selftests/net/xdp_dummy.c       | 13 +++++++++++++
> > > >  7 files changed, 26 insertions(+), 12 deletions(-)
> > > >  create mode 100644 tools/testing/selftests/net/xdp_dummy.c
> > > >=20
> > > > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/s=
elftests/net/Makefile
> > > > index 50818075e566..304d8b852ef0 100644
> > > > --- a/tools/testing/selftests/net/Makefile
> > > > +++ b/tools/testing/selftests/net/Makefile
> > > > @@ -84,6 +84,7 @@ TEST_PROGS +=3D sctp_vrf.sh
> > > >  TEST_GEN_FILES +=3D sctp_hello
> > > >  TEST_GEN_FILES +=3D csum
> > > >  TEST_GEN_FILES +=3D nat6to4.o
> > > > +TEST_GEN_FILES +=3D xdp_dummy.o
> > > >  TEST_GEN_FILES +=3D ip_local_port_range
> > > >  TEST_GEN_FILES +=3D bind_wildcard
> > > >  TEST_PROGS +=3D test_vxlan_mdb.sh
> > > > @@ -104,7 +105,7 @@ $(OUTPUT)/tcp_inq: LDLIBS +=3D -lpthread
> > > >  $(OUTPUT)/bind_bhash: LDLIBS +=3D -lpthread
> > > >  $(OUTPUT)/io_uring_zerocopy_tx: CFLAGS +=3D -I../../../include/
> > > > =20
> > > > -# Rules to generate bpf obj nat6to4.o
> > > > +# Rules to generate bpf objs
> > > >  CLANG ?=3D clang
> > > >  SCRATCH_DIR :=3D $(OUTPUT)/tools
> > > >  BUILD_DIR :=3D $(SCRATCH_DIR)/build
> > > > @@ -139,7 +140,7 @@ endif
> > > > =20
> > > >  CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG),$(CLANG_TA=
RGET_ARCH))
> > > > =20
> > > > -$(OUTPUT)/nat6to4.o: nat6to4.c $(BPFOBJ) | $(MAKE_DIRS)
> > > > +$(OUTPUT)/nat6to4.o $(OUTPUT)/xdp_dummy.o: $(OUTPUT)/%.o : %.c $(B=
PFOBJ) | $(MAKE_DIRS)
> > > >  	$(CLANG) -O2 --target=3Dbpf -c $< $(CCINCLUDE) $(CLANG_SYS_INCLUD=
ES) -o $@
> > >=20
> > > is the "$(OUTPUT)/%.o :" intentional or a leftover from editing?
> >=20
> > Is intentional and AFAICS required to let this rule being selected when
> > the output directory is not an empty string (the target and the pre-req
> > will be in different directories).
>=20
> Thanks. I don't understand why. Sorry to harp on this small point, but
> you've verified that the build fails without? Is it perhaps due to that
> "$(MAKE_DIRS)" order-only-prerequisite? But nat6to4 on its own did not
> need this.

I tried quite a bit of permutation (all others failing) before
selecting this one (shame on me, with a stackoverflow hint [!!!]).

But I finally found the relevant documentation reference:

https://www.gnu.org/software/make/manual/make.html#Static-Pattern

A simpler wildcard rule would not be enough, as the already existing
wildcard used to build plain c files will take precedence.

nat6to4 did not need this fancy syntax, as it was a simple, single
target single pre-req rule - that takes precedence on the mentioned
wildcard.

Please let me know if the above clarifies a bit the scenario.

Cheers,

Paolo


