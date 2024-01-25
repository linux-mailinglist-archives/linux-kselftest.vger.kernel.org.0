Return-Path: <linux-kselftest+bounces-3569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8C483C4AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 15:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FDA1F21D3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 14:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8366163418;
	Thu, 25 Jan 2024 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRswz3St"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABC7633F8;
	Thu, 25 Jan 2024 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192873; cv=none; b=mDQZgHe0N2d/I7m/DL/tinyJNcy+tHgZGrt1FAzd+kGcF5WIMY4JS3L9tqo+ds1h7EUOKl33AnD2m3Sq5zhzaGIztu+mM7DxcWCbmaSRsqc6T1/CUqkMwV5deY56oYQ7k+uBpSI1hx1y1waF0Xoi24xrM1F1CHvZUETHeIH17Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192873; c=relaxed/simple;
	bh=pn1ttRiCB3T62fLF7Yk/4dbLJNgue3vHQcDpuryZksk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PYz1EVYdah3Rfdb3fumJBOgPbNi9uwVorbaiHUL/W6iUAvH5nMpN/cSdrYYE86LSXtB4kKykwwLdGkiiztmcERwpMRe7eLaQEH11byKhXK3MqMgmZ6hP3XMTX+g/KRtbAcGCzK7cAJcmejUqmIfKgj+QYT5P8myMzbPrh7lZhO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRswz3St; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc239f84ba4so5885716276.3;
        Thu, 25 Jan 2024 06:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706192871; x=1706797671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezXZlwq89SJQWpRmFh+WSDEPjc1gF/PThwDrtXv1zJQ=;
        b=fRswz3St7NR8hdWWVrJDinB3H4BZmGvm2LoZIFGSL3t324yx9pmoP8IWBOja8ySalx
         5tH1NI94KOc+oP+GNDAJCLakVI+zNtwo7EMTf/dslETPm9CV/QaAyX5uLNj/6JLie1+a
         1+Hlfr1v+9xxYMG8wXrv6PpT/7cwBF80Huf2NUyiI5JQ7kXsyK9gUsXOegN/Zp5jGc+e
         5rbqo2vaCIimq0l856Xmv6Ncw+FTDuHxJq92+Gj2QjJxbFJDQlrH8cqQsuHidX8NqVyE
         JWDEpSb2spGbB0AVd61dV4oNP7sCgMlKu6dC0WyhmCsUUM8zy0m6Iagsg0nfdBIsRxuG
         3DMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706192871; x=1706797671;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ezXZlwq89SJQWpRmFh+WSDEPjc1gF/PThwDrtXv1zJQ=;
        b=CxfN2E01MjmJ/QU7ksREwEGzXYtYF20MOUGlv+44Y6tQW/YkAtcqULpW0qspGteBNd
         htB9rfIAKVEhd0ffVXA6IbDMzncg9VeOxc986stZLOYfF0sFvjkZRniKXZrTHEUMV1iE
         5RQbw/tjGdHNNoGAWHD6c/t8URagke4NnIHw0I8zr3F9Wr3nPfyidWYb0AcnkrMmsz88
         rvcgn+OUJeYhqFw2CW/zxlUTmOOCDcNjbJBs264b2bDsRJSkRQBfSvg8X0ZM0csSN+f7
         4q198d0fkr9/garsLIFGv4YpbikXQzcUhVQcTxmWL7urlsRaZWV9r0gJ+dMoYaHraE7g
         cLhA==
X-Gm-Message-State: AOJu0YzZBsOjwovyHHjO8A+B29uM7Wy4/z1+LnYV8/KEADkQVYeNJ/Ps
	9kH75016YQZZiMUGg872qUGGSdaHycqCJKVT7ZCwdw6P51PnMFiA
X-Google-Smtp-Source: AGHT+IEEdvGNE9BU91woD3drQtobl5gLLHKAajS9wGwKgmPqG7H6diUKug955SL5Tz11roVbE/laSA==
X-Received: by 2002:a05:6902:567:b0:dbd:b5a0:8494 with SMTP id a7-20020a056902056700b00dbdb5a08494mr1016673ybt.86.1706192870661;
        Thu, 25 Jan 2024 06:27:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVMeYgb1GZEgqu7dAzNrxR/AHBJL6BW0hZ1MGLwfEQ3nWNy+SSWJikGsuPtPtYiPS0zODQ/kRXy/RhnbPC/i5Pdju0FUEG+audAA4OrU6btOXpXBw+qlHvmuB8GFt2vqRMZbxklQpnDo2FwwhZMnA2r04rhUkyfeRmM9F+b8ijTFxGwBjuJ9R8qs0bIWIPWz7Qtnt2hBn/MGib0ZrQMy5kU0n5pPtHThd5SbYHNwzLK2+JrLxj03uGL4HATY3LMyGJNDioHieTyjuRwgOkNZql3MupQT3imkzjj34j5oI8BWWc7yXdNJSc5hg==
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id ld29-20020a056214419d00b006869647d106sm3565091qvb.5.2024.01.25.06.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:27:50 -0800 (PST)
Date: Thu, 25 Jan 2024 09:27:50 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Lucas Karpinski <lkarpins@redhat.com>, 
 linux-kselftest@vger.kernel.org
Message-ID: <65b26fe61346d_2b890a294b4@willemb.c.googlers.com.notmuch>
In-Reply-To: <49d15fe58d9cd415ca96739b08c59c7cde5c3422.camel@redhat.com>
References: <cover.1706131762.git.pabeni@redhat.com>
 <28e7af7c031557f691dc8045ee41dd549dd5e74c.1706131762.git.pabeni@redhat.com>
 <65b1b4e92df6_250560294f4@willemb.c.googlers.com.notmuch>
 <49d15fe58d9cd415ca96739b08c59c7cde5c3422.camel@redhat.com>
Subject: Re: [PATCH net 1/3] selftests: net: remove dependency on ebpf tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On Wed, 2024-01-24 at 20:10 -0500, Willem de Bruijn wrote:
> > Paolo Abeni wrote:
> > > Several net tests requires an XDP program build under the ebpf
> > > directory, and error out if such program is not available.
> > > 
> > > That makes running successful net test hard, let's duplicate into the
> > > net dir the [very small] program, re-using the existing rules to build
> > > it, and finally dropping the bogus dependency.
> > > 
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > >  tools/testing/selftests/net/Makefile          |  5 +++--
> > >  tools/testing/selftests/net/udpgro.sh         |  4 ++--
> > >  tools/testing/selftests/net/udpgro_bench.sh   |  4 ++--
> > >  tools/testing/selftests/net/udpgro_frglist.sh |  6 +++---
> > >  tools/testing/selftests/net/udpgro_fwd.sh     |  2 +-
> > >  tools/testing/selftests/net/veth.sh           |  4 ++--
> > >  tools/testing/selftests/net/xdp_dummy.c       | 13 +++++++++++++
> > >  7 files changed, 26 insertions(+), 12 deletions(-)
> > >  create mode 100644 tools/testing/selftests/net/xdp_dummy.c
> > > 
> > > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> > > index 50818075e566..304d8b852ef0 100644
> > > --- a/tools/testing/selftests/net/Makefile
> > > +++ b/tools/testing/selftests/net/Makefile
> > > @@ -84,6 +84,7 @@ TEST_PROGS += sctp_vrf.sh
> > >  TEST_GEN_FILES += sctp_hello
> > >  TEST_GEN_FILES += csum
> > >  TEST_GEN_FILES += nat6to4.o
> > > +TEST_GEN_FILES += xdp_dummy.o
> > >  TEST_GEN_FILES += ip_local_port_range
> > >  TEST_GEN_FILES += bind_wildcard
> > >  TEST_PROGS += test_vxlan_mdb.sh
> > > @@ -104,7 +105,7 @@ $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
> > >  $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
> > >  $(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
> > >  
> > > -# Rules to generate bpf obj nat6to4.o
> > > +# Rules to generate bpf objs
> > >  CLANG ?= clang
> > >  SCRATCH_DIR := $(OUTPUT)/tools
> > >  BUILD_DIR := $(SCRATCH_DIR)/build
> > > @@ -139,7 +140,7 @@ endif
> > >  
> > >  CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
> > >  
> > > -$(OUTPUT)/nat6to4.o: nat6to4.c $(BPFOBJ) | $(MAKE_DIRS)
> > > +$(OUTPUT)/nat6to4.o $(OUTPUT)/xdp_dummy.o: $(OUTPUT)/%.o : %.c $(BPFOBJ) | $(MAKE_DIRS)
> > >  	$(CLANG) -O2 --target=bpf -c $< $(CCINCLUDE) $(CLANG_SYS_INCLUDES) -o $@
> > 
> > is the "$(OUTPUT)/%.o :" intentional or a leftover from editing?
> 
> Is intentional and AFAICS required to let this rule being selected when
> the output directory is not an empty string (the target and the pre-req
> will be in different directories).

Thanks. I don't understand why. Sorry to harp on this small point, but
you've verified that the build fails without? Is it perhaps due to that
"$(MAKE_DIRS)" order-only-prerequisite? But nat6to4 on its own did not
need this.

Substition references could add a second colon in a rule, but
otherwise I cannot find a reference to this repeated colon syntax.

Don't waste time on my behalf if you're sure this is correct. I just
can't add a reviewed tag if I don't understand it -- but that tag is
hardly essential.


