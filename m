Return-Path: <linux-kselftest+bounces-3548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A751E83BAB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 08:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEF21F2485C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 07:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE0F11C92;
	Thu, 25 Jan 2024 07:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCn4OdhA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7994312E49
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Jan 2024 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706167968; cv=none; b=lzIQmu/si8mVqUCI5xULY1LpRpiScnc1leQ8qFoLFs2yqWOtvjv55QgWSNHJ1qsHZQXv17KHRI0qc9kQOhCNJnlbVL7Ioxk7eLQvoGR/tgHcXRAPBSdpHVqOMLN4hfv8wpVYfqKp0A68Y4qn/iBIyR1I7BMEG/h1/4OzjgyVQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706167968; c=relaxed/simple;
	bh=9JiXuMU8md6ZQDJL87iGFXGWLogt4Me1Dar0m3LEe6Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kjrPUhgAT4gdbfbl+gcTN8b3mdzOsELAA3PkJ2PZPGC7W7QIQhxSXVQ1jh6jmc9cqzKuQULT/iUZuX7GjaHDTpBKsrW6EB2FH+rl0Hd7UOr60hvtDo/Mwm9g86sQ5C1nqfzHlaPJUJIaRuwERgFACQatoKLDdAwTGXLL4ny0X3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCn4OdhA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706167965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n/eiPmT0rgKP1yTY7bjh9FIJTWMSTGjIYT2E0cASlmE=;
	b=iCn4OdhAJET7QpEK7vPcVLhSaFPP3pTc07MkYV6fNQmUjYgLUU5RLP4iu/UkNHq9vs9ROT
	VAmWfpAVPzbfzojtwmBUJhjW5KAJitcpn5vN3nknVMZhgqkA5bn5nNCa9vpNdIe57LAKlC
	ShzX1VmDP3KjdTojNecBMOmwl1n+Sr0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-0bybeAb-Omi2Rp-eTOEEkA-1; Thu, 25 Jan 2024 02:32:43 -0500
X-MC-Unique: 0bybeAb-Omi2Rp-eTOEEkA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50e93545a26so1247851e87.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 23:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706167961; x=1706772761;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n/eiPmT0rgKP1yTY7bjh9FIJTWMSTGjIYT2E0cASlmE=;
        b=ST77m7k8NZj1wzObiVM7NCc9EGvVhc8gR7s3nSwyU68BUPqp+THi6xfjghWTlGfSVI
         1P8kPyufkbZ0o68//IFnbGxRl6xFmrsVioHPuutRReTNR7m1oeW0hd1+7Jjf2UiJ6NtN
         ogoG7xygydFztvKD2nMlHw2/Z9HQdgsDhs4DAP9t43SgNRzzEerNV1mwQwCkS7nVp8ck
         ldyuiMqyUzjxsYoNQsAOE5W8cZeKptZwc4949QrEt0A1e7N8YSmJm5b1hknOiOK/gWcc
         DvqmUcmDraA5W38LpS7SIqhWOtHfG8/+xzhqRoCrJGcfMkY8cAHPKKgxv/4hIIML8pwM
         Fn6w==
X-Gm-Message-State: AOJu0Yz8fSoU71CdSws3QvX6PTN/mM2l2WaJTLl8j1mJKIMQDfTXusaA
	xCeG1ZFCN5MFErWePHw6nTHkZZPMW3djuhiB818y1nOBEeCpduup6S0nHvh1ATmePLA4pxvMgPC
	GrF5UQWNt3ofY+cOduZWT+zNbPxiN1qFE412uePhGtDmZrNzYxlnSBSWIvph/4VuV5Q==
X-Received: by 2002:a19:6405:0:b0:510:1469:f68 with SMTP id y5-20020a196405000000b0051014690f68mr588320lfb.0.1706167961724;
        Wed, 24 Jan 2024 23:32:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6NsIZts08TDIRCakE0XTuaTYSDvB2BldmTG0ykdCRh4xn/b59qjVkB+qxquyzJoWjbvhmbA==
X-Received: by 2002:a19:6405:0:b0:510:1469:f68 with SMTP id y5-20020a196405000000b0051014690f68mr588306lfb.0.1706167961359;
        Wed, 24 Jan 2024 23:32:41 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-244-75.dyn.eolo.it. [146.241.244.75])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c358d00b0040ea875a527sm1522057wmq.26.2024.01.24.23.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 23:32:40 -0800 (PST)
Message-ID: <49d15fe58d9cd415ca96739b08c59c7cde5c3422.camel@redhat.com>
Subject: Re: [PATCH net 1/3] selftests: net: remove dependency on ebpf tests
From: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>, Lucas Karpinski
 <lkarpins@redhat.com>,  linux-kselftest@vger.kernel.org
Date: Thu, 25 Jan 2024 08:32:39 +0100
In-Reply-To: <65b1b4e92df6_250560294f4@willemb.c.googlers.com.notmuch>
References: <cover.1706131762.git.pabeni@redhat.com>
	 <28e7af7c031557f691dc8045ee41dd549dd5e74c.1706131762.git.pabeni@redhat.com>
	 <65b1b4e92df6_250560294f4@willemb.c.googlers.com.notmuch>
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

On Wed, 2024-01-24 at 20:10 -0500, Willem de Bruijn wrote:
> Paolo Abeni wrote:
> > Several net tests requires an XDP program build under the ebpf
> > directory, and error out if such program is not available.
> >=20
> > That makes running successful net test hard, let's duplicate into the
> > net dir the [very small] program, re-using the existing rules to build
> > it, and finally dropping the bogus dependency.
> >=20
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  tools/testing/selftests/net/Makefile          |  5 +++--
> >  tools/testing/selftests/net/udpgro.sh         |  4 ++--
> >  tools/testing/selftests/net/udpgro_bench.sh   |  4 ++--
> >  tools/testing/selftests/net/udpgro_frglist.sh |  6 +++---
> >  tools/testing/selftests/net/udpgro_fwd.sh     |  2 +-
> >  tools/testing/selftests/net/veth.sh           |  4 ++--
> >  tools/testing/selftests/net/xdp_dummy.c       | 13 +++++++++++++
> >  7 files changed, 26 insertions(+), 12 deletions(-)
> >  create mode 100644 tools/testing/selftests/net/xdp_dummy.c
> >=20
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selft=
ests/net/Makefile
> > index 50818075e566..304d8b852ef0 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -84,6 +84,7 @@ TEST_PROGS +=3D sctp_vrf.sh
> >  TEST_GEN_FILES +=3D sctp_hello
> >  TEST_GEN_FILES +=3D csum
> >  TEST_GEN_FILES +=3D nat6to4.o
> > +TEST_GEN_FILES +=3D xdp_dummy.o
> >  TEST_GEN_FILES +=3D ip_local_port_range
> >  TEST_GEN_FILES +=3D bind_wildcard
> >  TEST_PROGS +=3D test_vxlan_mdb.sh
> > @@ -104,7 +105,7 @@ $(OUTPUT)/tcp_inq: LDLIBS +=3D -lpthread
> >  $(OUTPUT)/bind_bhash: LDLIBS +=3D -lpthread
> >  $(OUTPUT)/io_uring_zerocopy_tx: CFLAGS +=3D -I../../../include/
> > =20
> > -# Rules to generate bpf obj nat6to4.o
> > +# Rules to generate bpf objs
> >  CLANG ?=3D clang
> >  SCRATCH_DIR :=3D $(OUTPUT)/tools
> >  BUILD_DIR :=3D $(SCRATCH_DIR)/build
> > @@ -139,7 +140,7 @@ endif
> > =20
> >  CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG),$(CLANG_TARGET=
_ARCH))
> > =20
> > -$(OUTPUT)/nat6to4.o: nat6to4.c $(BPFOBJ) | $(MAKE_DIRS)
> > +$(OUTPUT)/nat6to4.o $(OUTPUT)/xdp_dummy.o: $(OUTPUT)/%.o : %.c $(BPFOB=
J) | $(MAKE_DIRS)
> >  	$(CLANG) -O2 --target=3Dbpf -c $< $(CCINCLUDE) $(CLANG_SYS_INCLUDES) =
-o $@
>=20
> is the "$(OUTPUT)/%.o :" intentional or a leftover from editing?

Is intentional and AFAICS required to let this rule being selected when
the output directory is not an empty string (the target and the pre-req
will be in different directories).

Cheers,

Paolo


