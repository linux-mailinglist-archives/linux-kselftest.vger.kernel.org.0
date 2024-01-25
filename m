Return-Path: <linux-kselftest+bounces-3575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C794183C70A
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 16:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A591B21914
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 15:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2368E73162;
	Thu, 25 Jan 2024 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjU3KLuL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C56E224E8;
	Thu, 25 Jan 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197103; cv=none; b=KYFWHnRnWXNa56f0dYuwmUoQVrU3K9bnb6mEHdWsLXz/uvo3mQoZHuDQOPqnE32Xhrn+aLUMHU73XAFeR8cN/Ld9dt3XSpwW6SptBUWxuZKNgOZh2kvCCZyS2IROLzWnT566X0Fw9BIJ+ALPByNstNGcV0kdp/ZSpdqpYFvtFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197103; c=relaxed/simple;
	bh=byvDxAhUtvp7acMAGcMLskPCxqfTZAZ8QG5UuT/xtWQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Cg00KZRdFCohIrjC5h1WXZJEAeoAk56NaUlCXu6RqyuIQ6nFOabVP03Ks/Lowe3xcCzVAnQgBqo7rbOvbfRZPkMe9ePWr6Ya0SP0ccBiQNZ0nAbpCpEmQd9lpPOfLD5Hbph/qQLmKNWsHUJSBozHHLMNaNodriOwSAj0slvpTF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjU3KLuL; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7831806c527so590298085a.3;
        Thu, 25 Jan 2024 07:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706197100; x=1706801900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHrl0FaBSIFJYdqSiJ2PYmm8uRkpy7SOlEX5cSpoK4w=;
        b=UjU3KLuL1msLLQQU+fGkChorh8hQBVWt+jua+tof7JQ+GKeoL7w4YvlUTA1ds/CwDr
         LHqafHLjkZbTEnKYXFjRZkhI8XN3eZ7V9EqSSxv5AQGx72p+Ywv5dCmrv/f4SBkrfx65
         DKJElXXhhiQIfnKXlO0fH8wWsljGACg7jqt/mxR8xOaqzFBZzoaFDHk/0YAdczLau1nF
         FyvLjYtfiGFkMvbyfrmj5tLDa8TjH+2NP1YsZwtGe7qh7KYzuT1ykA4tTOTYjNeTvAbt
         teha90T8Z4oNi+kPQ7Y4ACWKoELdpNLKYdNGBjxiVzx0AXIfYFLequEfrjddFla2ZBzw
         zliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706197100; x=1706801900;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cHrl0FaBSIFJYdqSiJ2PYmm8uRkpy7SOlEX5cSpoK4w=;
        b=enbzCu8OlrJLlkzcgqvkXenvsV3QFK2hyUngYervZVusLeLFanhFt9fPjQRC307QnD
         O5albXIEFb0dXnEaarjObBfoymXLsIIC4st18zXccyOMuv1OQk/WK2wMq0M53NjNj56b
         C0EHMgHEgXIaAzCr1Rx10H7LSvBoVrBq2wk6J/kg/V3LKeeqgdugMzL1lkOHvTa3eTGJ
         ztqtwK+haYeFhuzuYVojW3zcwEkPBdukK3lNSk/RCHU3IaqF1OytaYxuz1TG/ouNRxub
         6TYNACNfMtoxi24fn6erIoNr2Q1PIpai2bXiAMmLNkwPrcZeAxTHhtdXHCA3HNCSvBZy
         a1FQ==
X-Gm-Message-State: AOJu0YzGKthRC0ebkijQ473atnkC40BZgaK4HGRxnB1HhzI7rikK6Azc
	Op5VchJ0Lc9h0Gs4JRs5QehQCOsYj+DlqzwvwqJJYC6g5YMTI7AM
X-Google-Smtp-Source: AGHT+IEAmp6uhSjfaws1nkmIP1IbMkRnpyXtx286q8qSh4COTLGG/s8Bvis/3eTDkY6BwhV/DMP0rg==
X-Received: by 2002:a05:6214:258d:b0:685:1ece:98e3 with SMTP id fq13-20020a056214258d00b006851ece98e3mr1457926qvb.53.1706197100223;
        Thu, 25 Jan 2024 07:38:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWD98V4GP+9OH3UmroasB4gtEeSKiX8odSaUE5aKF7224qZ/8bCSCJuCLD3LIJgwXchdMeOAfUW1lifq/wQK6AjJQ6JgUe5kHq90OLveuv2ZZ7OY+APejpo3D5hwr0uCv0rvyacyEZm5IpbGLsrY4HeWKb3kwtyWHmDjIwU5Lc/C6vdpkuJSFng3q061f/fJDwp7YoOhVaSchi0DGLHzbt+d9a/xvkANqveJ0TShMscU0JxXRS5rQRD2NMKZinUxE3Xke51bReq8gI+m+cc4LGdlyGRacIrWkEX1+QS2hkYSI4nJTcZhrHpQQ==
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id j7-20020a0ceb07000000b00681092cb7b4sm5519133qvp.103.2024.01.25.07.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:38:19 -0800 (PST)
Date: Thu, 25 Jan 2024 10:38:19 -0500
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
Message-ID: <65b2806b90b29_2bce412943c@willemb.c.googlers.com.notmuch>
In-Reply-To: <6cb2ddf941698e2feb780dfae9325e98cd39d7a9.camel@redhat.com>
References: <cover.1706131762.git.pabeni@redhat.com>
 <28e7af7c031557f691dc8045ee41dd549dd5e74c.1706131762.git.pabeni@redhat.com>
 <65b1b4e92df6_250560294f4@willemb.c.googlers.com.notmuch>
 <49d15fe58d9cd415ca96739b08c59c7cde5c3422.camel@redhat.com>
 <65b26fe61346d_2b890a294b4@willemb.c.googlers.com.notmuch>
 <6cb2ddf941698e2feb780dfae9325e98cd39d7a9.camel@redhat.com>
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
> On Thu, 2024-01-25 at 09:27 -0500, Willem de Bruijn wrote:
> > Paolo Abeni wrote:
> > > On Wed, 2024-01-24 at 20:10 -0500, Willem de Bruijn wrote:
> > > > Paolo Abeni wrote:
> > > > > Several net tests requires an XDP program build under the ebpf
> > > > > directory, and error out if such program is not available.
> > > > > 
> > > > > That makes running successful net test hard, let's duplicate into the
> > > > > net dir the [very small] program, re-using the existing rules to build
> > > > > it, and finally dropping the bogus dependency.
> > > > > 
> > > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > > > ---
> > > > >  tools/testing/selftests/net/Makefile          |  5 +++--
> > > > >  tools/testing/selftests/net/udpgro.sh         |  4 ++--
> > > > >  tools/testing/selftests/net/udpgro_bench.sh   |  4 ++--
> > > > >  tools/testing/selftests/net/udpgro_frglist.sh |  6 +++---
> > > > >  tools/testing/selftests/net/udpgro_fwd.sh     |  2 +-
> > > > >  tools/testing/selftests/net/veth.sh           |  4 ++--
> > > > >  tools/testing/selftests/net/xdp_dummy.c       | 13 +++++++++++++
> > > > >  7 files changed, 26 insertions(+), 12 deletions(-)
> > > > >  create mode 100644 tools/testing/selftests/net/xdp_dummy.c
> > > > > 
> > > > > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> > > > > index 50818075e566..304d8b852ef0 100644
> > > > > --- a/tools/testing/selftests/net/Makefile
> > > > > +++ b/tools/testing/selftests/net/Makefile
> > > > > @@ -84,6 +84,7 @@ TEST_PROGS += sctp_vrf.sh
> > > > >  TEST_GEN_FILES += sctp_hello
> > > > >  TEST_GEN_FILES += csum
> > > > >  TEST_GEN_FILES += nat6to4.o
> > > > > +TEST_GEN_FILES += xdp_dummy.o
> > > > >  TEST_GEN_FILES += ip_local_port_range
> > > > >  TEST_GEN_FILES += bind_wildcard
> > > > >  TEST_PROGS += test_vxlan_mdb.sh
> > > > > @@ -104,7 +105,7 @@ $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
> > > > >  $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
> > > > >  $(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
> > > > >  
> > > > > -# Rules to generate bpf obj nat6to4.o
> > > > > +# Rules to generate bpf objs
> > > > >  CLANG ?= clang
> > > > >  SCRATCH_DIR := $(OUTPUT)/tools
> > > > >  BUILD_DIR := $(SCRATCH_DIR)/build
> > > > > @@ -139,7 +140,7 @@ endif
> > > > >  
> > > > >  CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
> > > > >  
> > > > > -$(OUTPUT)/nat6to4.o: nat6to4.c $(BPFOBJ) | $(MAKE_DIRS)
> > > > > +$(OUTPUT)/nat6to4.o $(OUTPUT)/xdp_dummy.o: $(OUTPUT)/%.o : %.c $(BPFOBJ) | $(MAKE_DIRS)
> > > > >  	$(CLANG) -O2 --target=bpf -c $< $(CCINCLUDE) $(CLANG_SYS_INCLUDES) -o $@
> > > > 
> > > > is the "$(OUTPUT)/%.o :" intentional or a leftover from editing?
> > > 
> > > Is intentional and AFAICS required to let this rule being selected when
> > > the output directory is not an empty string (the target and the pre-req
> > > will be in different directories).
> > 
> > Thanks. I don't understand why. Sorry to harp on this small point, but
> > you've verified that the build fails without? Is it perhaps due to that
> > "$(MAKE_DIRS)" order-only-prerequisite? But nat6to4 on its own did not
> > need this.
> 
> I tried quite a bit of permutation (all others failing) before
> selecting this one (shame on me, with a stackoverflow hint [!!!]).
> 
> But I finally found the relevant documentation reference:
> 
> https://www.gnu.org/software/make/manual/make.html#Static-Pattern
> 
> A simpler wildcard rule would not be enough, as the already existing
> wildcard used to build plain c files will take precedence.
> 
> nat6to4 did not need this fancy syntax, as it was a simple, single
> target single pre-req rule - that takes precedence on the mentioned
> wildcard.
> 
> Please let me know if the above clarifies a bit the scenario.

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for looking that up!

So the wildcard is needed for the %.c in the new rule. Makes sense.


