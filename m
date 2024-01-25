Return-Path: <linux-kselftest+bounces-3502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBCD83B668
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 02:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C60287740
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 01:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6426B7E1;
	Thu, 25 Jan 2024 01:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQ1PD0xm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69821876;
	Thu, 25 Jan 2024 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706145004; cv=none; b=HhgEDQNLNOS8vV3c3LFKz4anaMDy2YNim0chM6JaytQ3dnw3T1nGeG7jhxjF+VeLhLyZFFITaUVhXDQqucIVOjKvlVYt+QfobVznAYvbRj892oqYGw+aol/GxMoUp62IjUWzYJFZWqIvD/IIpNUKPmhp9X6GVi9DJ6I3N6qgMIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706145004; c=relaxed/simple;
	bh=EhAKI9eiBq0gVJSGIRudoRo6FVBttXkbVU4efFddmmQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=i6T3Y3p4RbGcqIMD+l67zB4lbqFOmG64l2/ZwwwTL6mxSLJV6ngqgBL659srZ94sNW1ej01NVCP90pjqF51Tn51O+wBDxPzqllkYGOis9icnER+2BlZpr8X+vJXQaXrbnNKRfcy81ZzbL4ed2FrSNu9nTpTcePvbq8yA3fVgxIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQ1PD0xm; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-680b1335af6so2035376d6.1;
        Wed, 24 Jan 2024 17:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706145001; x=1706749801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWGR9D7tvSupMpMpShRdPXhb0QN56THrpI4AZwGcDlI=;
        b=bQ1PD0xm2I9/0gMfiEb0TRLtoTDe2NYSAhs0f9uboaUeNdd4IJWkohPyJ00odThOpF
         b/SfkJCH/CF3/jYzJhHt2ynRJS3QHJMlMr9dOB0tUNBxfV52wuygA42cGMadr4HNHaJS
         bTgMOJlDjioTuRfYvai8+DfMEWe63Q93OAByOSEBpFGVzve2Esp7YhoQFYdkiy3ytPRo
         XFEgufvpzwk3I5qai8KmcaI3CJHUk5uMfI4rPs3m+sVtkhXuImnA7kq9XOXHIp8cjlhl
         X2AiZWOpzsD/oodeu6JUiIRVc1xVgnL+AIABbKXDHKkRnU31gz3Da75Z7ozLIu2/ged1
         9X9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706145001; x=1706749801;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LWGR9D7tvSupMpMpShRdPXhb0QN56THrpI4AZwGcDlI=;
        b=Obb8X7IIIwqS+KT4spkLA+BKVVYLu4onouarjX3WGAdvFzSihLq+qDuV+oJoycfFO4
         s2G03fajgt0rOTCBovActi3DHI9rxsVtqXDKJ1mdrNrjHpbFI98bivGDp3/WrK/JyVFU
         3ejLIq79PmoghsYZOH3Y0Gl3VQbiFxwAdfq2BOLyxZcnDtXsfCu9poDwP970byEPdEVU
         gTrTjYRwRd4XQLH/K9KpReEnfKFQLzBqnsppPoJtYk55U6T5UMSYXOeJ9fMVkxCKEF9c
         Jwn1rADPNJhV0fgrfD0G/Lt1HLJwo6MzjxqrDG2AsyyILeE5VWyPUHv2rgZ1GKbdD3wL
         u/9w==
X-Gm-Message-State: AOJu0YxaSIsjxRejb7NaJs6ESlwMVdkEW3Byzfa9vHAItcnuA9RDrvBl
	sZKpThFwwPpm31FqOj41DnpUmleQPrlf0sa4U15OsQTE2yM+5WB0feYfURiV
X-Google-Smtp-Source: AGHT+IHWpz+ZJxaXEbaFCVEcEGauzX4IXzSbK2ZwRM/Q1vTJCV0xO+ssXNqYZNbbDfnzgPGOx4ApxA==
X-Received: by 2002:a0c:e403:0:b0:683:bafc:c6eb with SMTP id o3-20020a0ce403000000b00683bafcc6ebmr889823qvl.8.1706145001548;
        Wed, 24 Jan 2024 17:10:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVvB/KHQ0P5R3RHwfp6R6gMPa3k6qtlD0h9EtLkf6ssd4m8pDEzxnBGz7FFiLLwrqT/v9559kmS70sYq40rQLxLJns9GBuUStitiGFYNrkrUvKZKP/29Tz/xL6p293fA+NVwIaU7SjMn443WCD2wO2Mafj5HAvt2NXPHSWDL6NjSRuUJHo7eftN5i176dN4nhcTjX7VM+aWbHzzdycM91h/yqYyFoMKNlqTPTjLlS5Eg1eGr3AhamNN9xH0e7ed7Ab925ii0B03IQ==
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id y20-20020ad445b4000000b006816ffc7113sm4939937qvu.63.2024.01.24.17.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 17:10:01 -0800 (PST)
Date: Wed, 24 Jan 2024 20:10:01 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Lucas Karpinski <lkarpins@redhat.com>, 
 linux-kselftest@vger.kernel.org
Message-ID: <65b1b4e92df6_250560294f4@willemb.c.googlers.com.notmuch>
In-Reply-To: <28e7af7c031557f691dc8045ee41dd549dd5e74c.1706131762.git.pabeni@redhat.com>
References: <cover.1706131762.git.pabeni@redhat.com>
 <28e7af7c031557f691dc8045ee41dd549dd5e74c.1706131762.git.pabeni@redhat.com>
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
> Several net tests requires an XDP program build under the ebpf
> directory, and error out if such program is not available.
> 
> That makes running successful net test hard, let's duplicate into the
> net dir the [very small] program, re-using the existing rules to build
> it, and finally dropping the bogus dependency.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  tools/testing/selftests/net/Makefile          |  5 +++--
>  tools/testing/selftests/net/udpgro.sh         |  4 ++--
>  tools/testing/selftests/net/udpgro_bench.sh   |  4 ++--
>  tools/testing/selftests/net/udpgro_frglist.sh |  6 +++---
>  tools/testing/selftests/net/udpgro_fwd.sh     |  2 +-
>  tools/testing/selftests/net/veth.sh           |  4 ++--
>  tools/testing/selftests/net/xdp_dummy.c       | 13 +++++++++++++
>  7 files changed, 26 insertions(+), 12 deletions(-)
>  create mode 100644 tools/testing/selftests/net/xdp_dummy.c
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 50818075e566..304d8b852ef0 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -84,6 +84,7 @@ TEST_PROGS += sctp_vrf.sh
>  TEST_GEN_FILES += sctp_hello
>  TEST_GEN_FILES += csum
>  TEST_GEN_FILES += nat6to4.o
> +TEST_GEN_FILES += xdp_dummy.o
>  TEST_GEN_FILES += ip_local_port_range
>  TEST_GEN_FILES += bind_wildcard
>  TEST_PROGS += test_vxlan_mdb.sh
> @@ -104,7 +105,7 @@ $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
>  $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
>  $(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
>  
> -# Rules to generate bpf obj nat6to4.o
> +# Rules to generate bpf objs
>  CLANG ?= clang
>  SCRATCH_DIR := $(OUTPUT)/tools
>  BUILD_DIR := $(SCRATCH_DIR)/build
> @@ -139,7 +140,7 @@ endif
>  
>  CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
>  
> -$(OUTPUT)/nat6to4.o: nat6to4.c $(BPFOBJ) | $(MAKE_DIRS)
> +$(OUTPUT)/nat6to4.o $(OUTPUT)/xdp_dummy.o: $(OUTPUT)/%.o : %.c $(BPFOBJ) | $(MAKE_DIRS)
>  	$(CLANG) -O2 --target=bpf -c $< $(CCINCLUDE) $(CLANG_SYS_INCLUDES) -o $@

is the "$(OUTPUT)/%.o :" intentional or a leftover from editing?

