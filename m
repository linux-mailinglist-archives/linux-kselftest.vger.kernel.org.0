Return-Path: <linux-kselftest+bounces-39264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3B1B2B550
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 02:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A465E7F12
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 00:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E1C4207A;
	Tue, 19 Aug 2025 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jwPZHbEC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B5D347B4
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563448; cv=none; b=eW65bEPnedMDVyeavI+1Knzmdg7QlKFY08sKsUkfZ7XV1RyKae6Cwvw7ZdQp7lWbmeY1OKD8ZzxsM5A+yEWLjb61dWTlMASO662kYh5yd3qHWftVSNgf9TDLxnr+MEbc1/tC8FzcmIsc5pTNydCHu3Z6zixI/HRVXQ/M3u8BnB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563448; c=relaxed/simple;
	bh=7cSAwm8Mpm474gJFqJTDSfYjShfJlHAUKQHNp9cO/CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoLFAnNEGukD4CnzWU9KC6zynTKFTh7TVeSnvvAEhsrUH/5INtmjzJ0RstN3GgWaF9To/hmZlw6UpVQeYyuipzv2sCaEhAyNIn1BrtfoOv+ZHWk2tLbURb14qO6wtDqi44GEzNejlU6bTADFXs6yHZvHBovSKOF92cqRRicVoJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jwPZHbEC; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b109c5ac7bso49261541cf.3
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 17:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755563446; x=1756168246; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hLw3Ly5lBpwG37igk8nIXvrjC9WRvilq8gEy55nQz4Q=;
        b=jwPZHbECeV+xOkYEcU+z1HIZtR6xcdUSyjRWedKpftrEJFHr41eUThABrxS2BmG+EE
         0HQIz2xY/Vx4O95K2ZGsU9pkOL1ONpTXqZdOY2kCgknY0cHgifEsXZ+Do9zeM/dGLevg
         LbQFFFTKxyBRLP4VvDwd2RWmsWptbxsD23B3RKzx/0YHOZm9aSoYsVj9Z/wuhIwTB8at
         2cUTJAV/H/HOD7TilX7at3nETQ+dDaizDMTuRqqhEIEy6gQ+Liv1xk6bIfZVFJlWovT2
         tGFOgFYgkp4SP/QOG7O1eQLUOthO47spiTiV7YYb2nVdYsJsTrN7vJWgXjUj3DQlpteP
         yvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755563446; x=1756168246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLw3Ly5lBpwG37igk8nIXvrjC9WRvilq8gEy55nQz4Q=;
        b=F8etIYCuvZM2/ZmqFEha3R3MvDV8+fgqJKDWm8lku1zolrcyF4aDFuLJOajTmo30BZ
         fXq6lq2Jgfnx1RTuVmO+cLhdJoLwlN89LAwQAzqeeZm2INGb2dWhkclSkNUk0vo04sqP
         YKEeRNfyrpfxoqaeNFATPPkPr6XzNHd7YIB/vTdbG3n+GUZHaqYKwTShAjWwlHiBtsG2
         XW/jLzKHmeoAnSLRtTLoM5ygfYztshRsG6TZn2EYa1gEVF9ji3AT/U0bGLOqoqxhuRH3
         9EO1+2jighOb85PWP61pKOhQApLzYCNNWsAa28bhj03MYll6zlvA620VOQNWgrDT3SRp
         uvvg==
X-Forwarded-Encrypted: i=1; AJvYcCWhHQ+02nOa+ShIkm8A3jLzbaTUdXV4P0LTSTBoWWYH6b3gChDK67Owb/2W773k8nw4OOhRoXBLvNsc70By/q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ufXH3gyhdZh8VR7WKrZm4DeXRNSqeMg1grZLZf4DYErCASDS
	gfrj6NCPsFMYQ3jKRMgqJeD2kGiqeGSzMIMRsKtv45FCVDCcQIzynHdwmWGEUu6TEUE=
X-Gm-Gg: ASbGncuMsiseBDwEpR54huvN2hwwg9XYj996AHYx7UBVFGTqXlgwwaL6s9lAYeg0UB2
	Nnen/1Wl6xJD5wqYL0uqbTgmQQr+seCiRf/I9ClZRkRZTwfjIl64PEtIqK+8GPv3opRaVir9jYG
	0XxG9mcUpFL/Cc7F6Zl75zY+MAboYpxsYKjnCzGUDGlry1tiFLN72ne3y9iu7anUsLq1L62/BL7
	RAocTOrww/8uNYXKQtu9sRY1O1ukSP+QLuKMKED2x58O0FG0SlU0sC/CV/1NLjYuAyNsarLWzs/
	5eo6mc3SNdCeLss1BkypTA2CgsU09VmY430zW9D2BwmpWvMUTfl8wrKRs8jCOSJksHfO/JrwiRp
	mqHigJDgASezpzPSdxEl6I8M=
X-Google-Smtp-Source: AGHT+IGBQbFzX0nYDgxxHDXJuUpwrISyNXTFy2dbw5LSBC5tG74mcZCK5FKwm3AQdhXjEGg8m2Q7VA==
X-Received: by 2002:a05:622a:312:b0:4ae:f1c4:98fe with SMTP id d75a77b69052e-4b286e216edmr8455701cf.34.1755563445791;
        Mon, 18 Aug 2025 17:30:45 -0700 (PDT)
Received: from localhost ([173.23.183.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc584c3sm58679171cf.17.2025.08.18.17.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 17:30:45 -0700 (PDT)
Date: Mon, 18 Aug 2025 19:30:44 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Dong Yang <dayss1224@gmail.com>, pbonzini@redhat.com, shuah@kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chenhaucai@kernel.org, Quan Zhou <zhouquan@iscas.ac.cn>
Subject: Re: [PATCH] KVM: loongarch: selftests: Remove common tests built by
 TEST_GEN_PROGS_COMMON
Message-ID: <20250818-2e6cf1b89c738f0fb1264811@orel>
References: <20250811082453.1167448-1-dayss1224@gmail.com>
 <11d1992d-baf0-fc2f-19d7-b263d15cf64d@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11d1992d-baf0-fc2f-19d7-b263d15cf64d@loongson.cn>

On Mon, Aug 11, 2025 at 06:49:07PM +0800, Bibo Mao wrote:
> Hi Dong,
> 
> Thanks for you patch.
> 
> On 2025/8/11 下午4:24, Dong Yang wrote:
> > Remove the common KVM test cases already added to TEST_GEN_PROGS_COMMON
> >   as following:
> > 
> > 	demand_paging_test
> > 	dirty_log_test
> > 	guest_print_test
> > 	kvm_binary_stats_test
> > 	kvm_create_max_vcpus
> > 	kvm_page_table_test
> > 	set_memory_region_test
> > 
> > Fixes: a867688c8cbb ("KVM: selftests: Add supported test cases for LoongArch")
> > Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> > Signed-off-by: Dong Yang <dayss1224@gmail.com>
> > ---
> >   tools/testing/selftests/kvm/Makefile.kvm | 7 -------
> >   1 file changed, 7 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> > index 38b95998e1e6..d2ad85a8839f 100644
> > --- a/tools/testing/selftests/kvm/Makefile.kvm
> > +++ b/tools/testing/selftests/kvm/Makefile.kvm
> > @@ -199,17 +199,10 @@ TEST_GEN_PROGS_riscv += get-reg-list
> >   TEST_GEN_PROGS_riscv += steal_time
> TEST_GEN_PROGS_loongarch = $(TEST_GEN_PROGS_COMMON) is missing.
> 
> BTW irqfd_test in TEST_GEN_PROGS_COMMON fails to run on LoongArch, does this
> test case pass to run on Riscv?

It appears to. It outputs the vm mode created and then exits with a zero
exit code.

Thanks,
drew

> 
> Regards
> Bibo Mao
> >   TEST_GEN_PROGS_loongarch += coalesced_io_test
> > -TEST_GEN_PROGS_loongarch += demand_paging_test
> >   TEST_GEN_PROGS_loongarch += dirty_log_perf_test
> > -TEST_GEN_PROGS_loongarch += dirty_log_test
> > -TEST_GEN_PROGS_loongarch += guest_print_test
> >   TEST_GEN_PROGS_loongarch += hardware_disable_test
> > -TEST_GEN_PROGS_loongarch += kvm_binary_stats_test
> > -TEST_GEN_PROGS_loongarch += kvm_create_max_vcpus
> > -TEST_GEN_PROGS_loongarch += kvm_page_table_test
> >   TEST_GEN_PROGS_loongarch += memslot_modification_stress_test
> >   TEST_GEN_PROGS_loongarch += memslot_perf_test
> > -TEST_GEN_PROGS_loongarch += set_memory_region_test
> >   SPLIT_TESTS += arch_timer
> >   SPLIT_TESTS += get-reg-list
> > 
> 

