Return-Path: <linux-kselftest+bounces-44848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D432C3814D
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 22:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AD784E1F5A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 21:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37372DFA40;
	Wed,  5 Nov 2025 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="SnfRqlJG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF872DF3DA
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379077; cv=none; b=Yv55cdRK4jAgcAI8Nq7MLZYE0nOY3z7xWH83GBta8HtG2u71z6Guk3gUiLXnZcubB7RjtF7ERCfgAvBEgz6Vx5bBFhsfsjA5Fh4uAlmfGFjSwvb6Y+wmgKM3GIkKIfyEXShS4OzLISfVJ38wX9VrFnHiPciCjGGh2BTtkmfIFiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379077; c=relaxed/simple;
	bh=B6+nsdGT18NH1NE7AX6pjoBR3M3Xcnw+DDIVghMfGrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2op6YKdf/MVLNg06b8leg6LBODOI1jGRV2dfiDOzhtTsMx5CnLB7l5G2pv5RgLMbndc9z+54GvTaqTvbl83aNqHSXp6oc0ch9+Ty53cuDguXlI6SEqQ7x2PD2n94+TXvFx/EVtfOqEHl13u7ptm92umcKbx7jz0qAiynJ+YDCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=SnfRqlJG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29470bc80ceso3564295ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 13:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762379075; x=1762983875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rVWjaBUX/7qo8BA7ZtqqS8rCRLhaeeey8yCwyWWpyLA=;
        b=SnfRqlJGOgKT3+bxUU7kyzbiIMHh0B1TqQeDgYLUDpSV+IMmK8FBayXeg1lr1aRnyc
         mb8v6Eusr+kFO2/ZDh13Et3/RpY0j4Tf5B1tlNqGWEPTUzdY/8HhLkUeboMzoaH4Sz1k
         z5Nu7ogzDuMzwzzMTJoktpRAKUtPRFQGe71adkK6XLvSJ4+tursLa32iMmbF2/jzSRKx
         YjdM6iWxEAS2olx7bHYbxSPavrZyK58Vg8RggHGdXTWGdHQI9hklfBEJ5x10F4zd1KM+
         mNYCPMHlVG5vSAIwshJuEpkCG2qyzgDCc4+ZaSbMFUkwbM4lSYegCmspdzzIn8+8DaTr
         +aLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762379075; x=1762983875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVWjaBUX/7qo8BA7ZtqqS8rCRLhaeeey8yCwyWWpyLA=;
        b=RmXrkd0T0xlHMKyHwSpfR1AVzyU3qc7UTDm6veW2ilXGHCSOiCF4AEgzRyF4KeKnpy
         wAcCc8/hgGeHn8Rzrtjb6sHXlefTUExwdv6/1wDe37IAew/A7pQqQzb7LgdzZSdi9WMu
         Tia6IvhTigMyPQ2Jo2DOgmvYI65Sv7OkmgOwEnkcLciexKRu+QApNxDtSYh+fArDW/Te
         JZdavTsL7qCc0mvQJVDRxDNseCUFiNHKmG7dRmRC8gCKjIRhp7rhpsM80QMyYoBcaXGW
         w1Cvtj93ld7G6YoWetjkkmcOxTxXg5AUGjsPnY8c5JCNl5DuNC/T4s+SgjQziLOpIkS+
         UW1g==
X-Forwarded-Encrypted: i=1; AJvYcCWLRJGyAlBje8ID3xGuR3I1uw9Wl1eUCHNDjo8zKMRx1En8Y/jGyZDP5EAOmiWlKM1zf7QQOl32u6iAG1VQEx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxavIkoMhkUUDoze6eQZNFFwteAchcQ85vjpL+z7oDViyHfkfiz
	0RYFU50ZaNovRnuBjNk2WGxLlrVU3IdLydIFA0D0QqrjVWTd1RVddSyXzP/WTMrm8oA=
X-Gm-Gg: ASbGncvHeBKs0fZjyBFXHw85xN6hxXU/UhYdEyNl75UJIeFLzg6qLGCxfG4Hi7ayCbA
	+ts36vGLeRUWX0P2DWlqFv1W8lnoM554/qPxYjb979fEidOJoJZkjZBOyaegLiDyEGMvHc4mq87
	xbYbS5lr3hTr/jeW4zYvMiK03eOVd/HDNg4AF9l9LpYj9X3AcqhvpffJF6xJoPvrPIAkpemGduD
	cBUu59J7jgjoLtcdW8TtQGlypZKVzTV462wA8sACXVzq/ZTz5CZlPNXpAb9fJCAT8YJPj3M0ygK
	INrHG5VvEbS1dgZ8U8BxaG5pwjCXk3yVJtLwLerXUbYxlX0DPl5nC7ho2v0he+DBGykrCPa3E3x
	ryizmKB9KA5ZVmVxepnmklwubS41x+lLZvSC39z8YE1k9C6VJ27ZkKqDjSsv4sMQWwfVHSRQ9UP
	MQRkywAOKPqsUu0z7F+TP1
X-Google-Smtp-Source: AGHT+IGUXuJp7B/Bqhn1WfKPsfAi2Zuz9PdCJSW9ZJXrA1YTaDItIRj/GRCMIgOV8doaMwcDTo+VDg==
X-Received: by 2002:a17:903:2f87:b0:295:57cc:cf9e with SMTP id d9443c01a7336-2964e9de802mr11033895ad.0.1762379075518;
        Wed, 05 Nov 2025 13:44:35 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096dbe4sm5273375ad.11.2025.11.05.13.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:44:35 -0800 (PST)
Date: Wed, 5 Nov 2025 13:44:32 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Joel Stanley <joel@jms.id.au>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com,
	richard.henderson@linaro.org, jim.shu@sifive.com,
	andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com,
	atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
	alexghiti@rivosinc.com, Michael Ellerman <mpe@tenstorrent.com>
Subject: Re: [PATCH v22 28/28] kselftest/riscv: kselftest for user mode cfi
Message-ID: <aQvFQM38u0iwSlJ8@debug.ba.rivosinc.com>
References: <20251023-v5_user_cfi_series-v22-0-1935270f7636@rivosinc.com>
 <20251023-v5_user_cfi_series-v22-28-1935270f7636@rivosinc.com>
 <CACPK8Xcm2SeSStk2EBEcUoyiUc0=d6ce_MfnP=ce3z6MMXyuiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACPK8Xcm2SeSStk2EBEcUoyiUc0=d6ce_MfnP=ce3z6MMXyuiw@mail.gmail.com>

On Tue, Nov 04, 2025 at 05:42:04PM +1030, Joel Stanley wrote:
>On Fri, 24 Oct 2025 at 03:33, Deepak Gupta via B4 Relay
><devnull+debug.rivosinc.com@kernel.org> wrote:
>
>> diff --git a/tools/testing/selftests/riscv/cfi/Makefile b/tools/testing/selftests/riscv/cfi/Makefile
>> new file mode 100644
>> index 000000000000..55165a93845f
>> --- /dev/null
>> +++ b/tools/testing/selftests/riscv/cfi/Makefile
>> @@ -0,0 +1,16 @@
>> +CFLAGS += -I$(top_srcdir)/tools/include
>> +
>> +CFLAGS += -march=rv64gc_zicfilp_zicfiss -fcf-protection=full
>> +
>> +ifeq ($(shell $(CC) $(CFLAGS) -nostdlib -xc /dev/null -o /dev/null > /dev/null 2>&1; echo $$?),0)
>> +TEST_GEN_PROGS := cfitests|
>
>I hacked this up a bit to get it working for me.
>
>I added this at the top to use the local headers from a `make
>headers`. Without this the selftest lacked the required ptrace
>changes:
>
>+CFLAGS += $(KHDR_INCLUDES)

hmm weird. In my case it picks it from location where headers get placed as part
of build (or make headers_install). I wonder why it's not happening in your
case. In any case, I think this can be added.

>
>I needed this before the ifeq so it used the cross compiler to perform
>the test, otherwise the test was always false:
>
>+# Check for zicfli* extensions needs cross compiler
>+# which is not set until lib.mk is included
>+ifeq ($(LLVM)$(CC),cc)
>+CC := $(CROSS_COMPILE)gcc
>+endif
>+#nedif
>
>Findally, a cosmetic one. If we set the name of the main test file to
>be the same as the test, the rule from lib.mk will give us neat
>output:

Sure, make sense. Will do that.
>
>     make[2]: Entering directory 'tools/testing/selftests/riscv/cfi'
>       CC       cfitests
>
>--- a/tools/testing/selftests/riscv/cfi/Makefile
>+++ b/tools/testing/selftests/riscv/cfi/Makefile
>@@ -12,12 +12,11 @@ endif
> ifeq ($(shell $(CC) $(CFLAGS) -nostdlib -xc /dev/null -o /dev/null >
>/dev/null 2>&1; echo $$?),0)
> TEST_GEN_PROGS := cfitests
>
>-include ../../lib.mk
>+$(OUTPUT)/cfitests: cfitests.c shadowstack.c
>
>-$(OUTPUT)/cfitests: riscv_cfi_test.c shadowstack.c
>-       $(CC) -o$@ $(CFLAGS) $(LDFLAGS) $^
> else
>-include ../../lib.mk
>
> $(shell echo "Toolchain doesn't support CFI, skipping CFI kselftest." >&2)
> endif
>+
>+include ../../lib.mk
>
>I can push up a branch with my changes if you'd like.

Sure, please point me to that and I'll pick it up. Test locally and send it out.


