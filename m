Return-Path: <linux-kselftest+bounces-39229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA2AB2AC4A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 17:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898BD176FD7
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 15:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876F524C07A;
	Mon, 18 Aug 2025 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do2EUE0J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E224A06B;
	Mon, 18 Aug 2025 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529951; cv=none; b=IXmXPhLyimdYiY0N9uK9kcjxbRm2K6OiJ5387Sllp/fqvv2MF3xTiSS3ettcvzuc8r2E2dW+MiAyv9yUDJmVsdSqEd5K6GYTOI1mttilOeLLlr7m/UsMXDjcuhhLrN6PVIxN2uwEUQ9ZkhQcQoO4f9KL8lOOSCbImIK2uT2xGGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529951; c=relaxed/simple;
	bh=IxYK9K0S71oezsvoOFfcN8q9uErJLq9q2+fZop8JFYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tsq5LWMonWcxuV1BZlDe0sMRTqz/g6mwRIURYXlv+lE8pEhfY6nUvySNscpYTOB4gFXxd+xx0oC2ilafwzz8Pq62or6Dfi+j1z3gE9SrJd8YhznMI1jgJzKVHUeZKol3omWFyXz+BrI91tmVZSx2CXOK+jthVMknVbEWKsz63B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do2EUE0J; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-32326de9cb4so3314186a91.2;
        Mon, 18 Aug 2025 08:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755529949; x=1756134749; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9m9pQoC9vcCwtF5PRiYn/LcCfxSsshrCPaxc14j1Gs0=;
        b=Do2EUE0JXI3IJvVCAe4/GO8HICf6dpHj7JodBfQbCWuI9uIJ3FLYbSd9S6dOfHzrzm
         Ds7/q6DccCR1u7+yKE8+Z2ZST/Tz5KC03kpcy45ib4qJHBE8UoBS6nci5Cvc6yGzwy/b
         qI9QiUud4r2U2BYqyWFKKa+eu1xaZO21sUYjfGQJuMOxp+WqM63K2E56Le/Y/ksUF3Pi
         knqpkavuXW3O9WFB5T+SuupOT4GmFbBv/Ap2CkaNLoGHE6TkisCiCarOe5k9PxphXM7+
         /5JU7UKAmr9hQNWpafd19blLwoBVoagU58ivKiS4bgghoGBD/hROPNPkqunQNXP3GA2m
         WyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755529949; x=1756134749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9m9pQoC9vcCwtF5PRiYn/LcCfxSsshrCPaxc14j1Gs0=;
        b=RGwA8aF+GwdbSSniOnPVN+3rs0qHOxlrw2FfJUz4iqoz55PhvMlJBOA4gCvENDa0AY
         aJEnOUS/da4EgBbVB0Ii0gXWpNB5ydreWJk3eFT4f4sV6o+y4F7OcRrj12wnEwy5Kpnu
         qItGr7MXINYczL1VvF9+e0GjPUFIuVxDf2hImAAOXYQcEPQVgozbY7w7n9xpJyq/YSC5
         5M5GCZJwwQTwb53wYMsBLUvGIE/QqbEm/IUqgp5r3vXuErZP0+h1Z2FJabyIN90byjvq
         C3wWEz8UFWxC6JYtsHXw8eGdFtprGZFxVK1+Truw1APYuksiXsgQkhcXOMkMYs1H/RAH
         vFJw==
X-Forwarded-Encrypted: i=1; AJvYcCVPpcmzx0Wnxn/XrKxQfn8nu0sX35OKWnNW+nygZZQXYJzBJ4V5rPx03OTXzx2FBwEOq6S/afbIYQonWGNx@vger.kernel.org, AJvYcCVUWueKufN8QSG/rmn5uVlXfnFzqWTvDeTPjLeyNQCGhSFrD8+Q307xy+v9N19pceby6L0=@vger.kernel.org, AJvYcCXZL7fNrDgrpDe8IaszwUJ3NdskgjEXEMrKQB3xlrELNJmM/cg3QMqGvWjwLdQwK3BegtiMSELZMVu2s9H1x8Dx@vger.kernel.org
X-Gm-Message-State: AOJu0YxtfKG72dG/srgwOUUd59hQ5m2zWOUYbDqzBMSd5/Dxe8f5d9JH
	oT/TvFCaVF640J0kql99ZWA5Nb3Y+IKT/qldwWda+jUrgDO5vWtfalnK
X-Gm-Gg: ASbGnctivOkb9IHS1RnmYXj6WtPSttc+yxBpd+J8e26YMsiq/CS5iioibcxniwVCWP4
	VbeMZPckftc9g1HZ9JBsnwlL/4G+0yGpAzesTPEEUTU8axjG8w5I4C21ubWbwwRXx1h4A3yiSkm
	w8vPc2vq8mxhsYc86s3vPe/jGJqpirQJ3AnFzPSBIWvx5S96oGwBBiEdRZxcv6EG1MmHB21w42J
	DnF5IYyQbREa/9OydC3oRiJuk9J9HwG7g6jNeafBxL0hlbp25d/aWHnjUf2r4B+2wBhX5/PEL0t
	7yrfd3M5GdRKge+Mw0qmLwSTHcpR62TWSMyrgZhFNRsflISE/2Iqk/P2VkdqVHwX+d8g3UsVMFm
	byHkHoaZmwhi/6Sc0XQLcYvwT
X-Google-Smtp-Source: AGHT+IG/N30/4l0jCarPWTtC7iuNzES5mY/a+EOCManL8eAkBrZhKd0+EkTzj7tnZQKrDa0bkftdcg==
X-Received: by 2002:a17:90b:55c4:b0:2ee:d371:3227 with SMTP id 98e67ed59e1d1-3234213f760mr19632503a91.17.1755529948987;
        Mon, 18 Aug 2025 08:12:28 -0700 (PDT)
Received: from days-ASUSLaptop ([50.7.253.114])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d76f1casm8183222a12.42.2025.08.18.08.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 08:12:28 -0700 (PDT)
Date: Mon, 18 Aug 2025 23:12:20 +0800
From: Dong Yang <dayss1224@gmail.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: pbonzini@redhat.com, shuah@kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	chenhaucai@kernel.org, Quan Zhou <zhouquan@iscas.ac.cn>
Subject: Re: [PATCH] KVM: loongarch: selftests: Remove common tests built by
 TEST_GEN_PROGS_COMMON
Message-ID: <aKNC1H4dB2M0TJiJ@days-ASUSLaptop>
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

Hi Bibo,

Thanks for your review and for catching this mistake.

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

You are absolutely right. I will add this line and send a v2 patch.

> 
> BTW irqfd_test in TEST_GEN_PROGS_COMMON fails to run on LoongArch, does this
> test case pass to run on Riscv?

I have tested it, and irqfd_test in TEST_GEN_PROGS_COMMON passes on the RISC-V.

Thanks,
Dong Yang

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

