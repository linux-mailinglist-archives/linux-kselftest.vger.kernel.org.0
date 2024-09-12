Return-Path: <linux-kselftest+bounces-17869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB67E9772DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 22:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9579F2860FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 20:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D441C1753;
	Thu, 12 Sep 2024 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="W8nJKsdp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E361BFDE5
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 20:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174047; cv=none; b=N53gmwwI+VJXlRQOn2yWMqO1VcolRncWvsp1p6RFIhkPSZbJ/6aLibUooBDPAsNim3fB7oVekldKK97wneis1IQobxiGjSwc+ULIsiRmCaJTxY5rC1ViOxlPN+qw4SWZEBlHOnIz/QB/526+qtQkx6j9omTTOrpiWmow7zdbxuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174047; c=relaxed/simple;
	bh=UeKDIfl46B0MjAeHHAOJysv7+DcyldeuRzbyODT/6Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ln0sfi6BomV5q6e9PKXTObmkuBAkog68+3H+oSibCs/QpoWJGbwEr0kvXqTmLVfk7PvaPst4IA7WEvaU7f9HUqJYMf0JmWGaW9e3pajYHL7aWSJmYBCWrP8YOs12me1HnFnSOwQ+4/vfGerCPfJN/VljVYfKbb2H30KDmWd4u6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=W8nJKsdp; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d82b0ebd51so52207a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726174043; x=1726778843; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QkYEDgSUi+q4cC1mKbyRLPDEigMYGApwN1eBhMPthC4=;
        b=W8nJKsdpI8iv3NLyLAEaFtnhAZlR/I8zVU7hEdlE9lWIbzTWLQRhrwW9P03gQKm7ol
         yNNbwmpfuZlHuV4ZvnxHGCXu1cy4v+IqK6qsaoIF0sSVQepg4A9tO+byMrA9IURBAceb
         nIsDGJbJuLHeJpJ0p98izj6ts6NL4dQBGYmN4+e4/IvLbAgaQQZOz0yZ9F3wnyNzEnRW
         tA7HfYHwwitRTHdq4ABm+gzfZTMYPhUt94phP9Hn7hzZXOf3rSaO2hKZFsZWeqiXNmg+
         Ea1nUO1MFIiVWR5uyRGGv19KjGcNOcCc8KKRgyHqsTUXkUGLFUVAuqVNtxcAmGtoSFC2
         8L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726174043; x=1726778843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkYEDgSUi+q4cC1mKbyRLPDEigMYGApwN1eBhMPthC4=;
        b=g/Yps+3pSKebRdnY9gOap9kS+p1jjUXoErK2WUCbwW5rRl/VVsC1y45GUTv1juYwjW
         aXYEp1U8h1iVZFaUujOBQcmCCucJkngC7WmZDWvjDkr+EGTylhMsRiEXoExVtGfzHFcH
         Uq7twqNGR52JumlSyKo6oB6mu1RmmqaS+9W8iNVcKwWM1aQxiTHCgqkryF2Tm9b38Y5p
         J7a0bFWV1bQWIUVUBv6pFlDn3rABsl5VzgydWs4iT2G+8P7Pr6ctshQ2aICoPZBhb2Pu
         TxQSca1IbNEQfx/VTvF1bZCdR5YirzyBGbo82mrWZO/38JtGuzpW5lfbMSwXdLSCpOuF
         GM9g==
X-Forwarded-Encrypted: i=1; AJvYcCVrFPi5Tv4qnMv5tjLm0jIBBk2X2mLru4oewbe+eriyFD0Us89M9tCM8xqTlnoVOFTYuXVpuLx14MmbxYd8Fs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaiN0bbxiQHitYggfAVE/hjMWiNSP+s6JUujiYJyIyuCkm1SR3
	jsBjqzU7QA+RF/ELdWb1pTvKd+zwU4hoAFUQmmY/rZYWh7Ypoon1xptI9GWhkOk=
X-Google-Smtp-Source: AGHT+IHY1ulWf8xIoYCgymvFfMz7AvIjbgg3u2pIVYFSwdjBxA8LW0bzDtVMfKaopkm+QTibJTkj8w==
X-Received: by 2002:a05:6a21:e90:b0:1cf:6d67:fe5a with SMTP id adf61e73a8af0-1d112edc9b4mr484866637.50.1726174043300;
        Thu, 12 Sep 2024 13:47:23 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fddd1c4sm2128722a12.63.2024.09.12.13.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 13:47:22 -0700 (PDT)
Date: Thu, 12 Sep 2024 13:47:20 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH] selftest/mm: Do not use hint for riscv mmap
Message-ID: <ZuNTWCsPPLTm1zdX@ghost>
References: <20240912100018.736447-1-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912100018.736447-1-zhangchunyan@iscas.ac.cn>

On Thu, Sep 12, 2024 at 06:00:18PM +0800, Chunyan Zhang wrote:
> When the virtual address range selftest is run on RISC-V platforms,
> it is observed that using the hint address when calling mmap cannot
> get the address in the range of that validate_addr() checks, also
> that will cause '/proc/self/maps' have gaps larger than MAP_CHUNK_SIZE.
> 
> Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> ---
>  tools/testing/selftests/mm/virtual_address_range.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index 4e4c1e311247..25f3eb304999 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -64,6 +64,14 @@
>  #define NR_CHUNKS_HIGH  NR_CHUNKS_384TB
>  #endif
>  
> +#if defined(__riscv) && (__riscv_xlen == 64)
> +static char *hind_addr(void)

This is not a typo by you since this is the name of the original
function but this should be "hint_addr" right?

> +{
> +	return NULL;
> +}
> +
> +static void validate_addr(char *ptr, int high_addr) { }
> +#else

This is something that I am trying to solve over at
https://lore.kernel.org/lkml/20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com/
(the solution is still in flux). Since riscv doesn't currently have this
behavior of restricting the virtual address space, I think it is more
reasonable to disable this test entirely. After we have a longer-term
solution with the patch I have up we can adjust the test and re-enable
it. What do you think?

- Charlie

>  static char *hind_addr(void)
>  {
>  	int bits = HIGH_ADDR_SHIFT + rand() % (63 - HIGH_ADDR_SHIFT);
> @@ -81,6 +89,7 @@ static void validate_addr(char *ptr, int high_addr)
>  	if (addr > HIGH_ADDR_MARK)
>  		ksft_exit_fail_msg("Bad address %lx\n", addr);
>  }
> +#endif
>  
>  static int validate_lower_address_hint(void)
>  {
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

