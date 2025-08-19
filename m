Return-Path: <linux-kselftest+bounces-39262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26491B2B545
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 02:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64A3622A75
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 00:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8201C146593;
	Tue, 19 Aug 2025 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WmcTXBzW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5C2557A
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 00:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755562817; cv=none; b=Pj6QTmz1VSKqr0zemuYYh6kQIbALlI8P7BrH8zxVg24DXbBvvUbDSuIvewd3ukeYQdoCXGO7ti7AiwPpU9dZ+ZSf7JNFirLmjfDkt0RvoAJ/3cooeZWIph+ya/N/t+goCokeqri00IqdAKbjYn8Ekh+9UaUXF4YlN4CKvSsEFGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755562817; c=relaxed/simple;
	bh=mZMZhGaVq/vWI5oXFpI0Xm6xIG/9/Nt2UIqIzXiWNdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mc/72ShtzGucJvlZjTx1DIWd12HyQqzV4Atd941Cjxpfb6YSqxP0iYB6JyT9zCwmOFwvefye2hnSv8vvLNJNXggK2H4pDbOuZJMNv48axG9Rqv44eZizdry7XQzQ6+XmtOisC1iJmLPIuvQLAPmiJcgkfIf9h9EnGIeCCwO2e0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WmcTXBzW; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e86faa158fso577049285a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 17:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755562814; x=1756167614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CAPvksbcJ/XXOJoTp6wZAG7UHW44uE+Uh92CsDXqVTw=;
        b=WmcTXBzWtGEdMWYodoW1DMygb+yx0dpeCdNVCV6YdAoG+NUysl0FIkIk4FbXFaqWKm
         6/qnW4JZjSYIXm8NydiH+AzDYsdizt1TElRgYdlBG6FulECeFxbbfzGZVYSTaq/OjEgL
         LP1Y8A4/fX6njVw6zlgwDL2B7cAz6vN5nti4Adp+nucHPlWQVJcBKnYLl/Dwl3ivvG6W
         0HmZ9494YF+i57UTbBLWwJgY0tI1AxqKZjdsvJ/hiaHetAOO3wRwgISJ5aDYjGrelWud
         Tvmtwh10w1XSOxcknHq5mE+Vi9eWIbjWPO25TihANiAfZIoMr4xCEfkSgViotgkUvpnj
         c0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755562814; x=1756167614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAPvksbcJ/XXOJoTp6wZAG7UHW44uE+Uh92CsDXqVTw=;
        b=Yd3oyK8mUmbiDQqS5v5rRuleGpL1LNdbFpgvwfwztT0s4Z5nzSGZWVVZlf3n8RVSZB
         PovLTS1KxvebwVOVOIjX73MTtIk9ouk7nkOnWET4wbK29sbfBpM/92hFlg4CeEPzZcs4
         HJ8DuZp3t9a8dKE11CuY5XbhBZkUAMjPLMmW9zD4GreqgiziggzBKn2iHxg2c1vdU+Ky
         ZdE0I/IFc3AndfoG8/VvuN95xVPuM2a9r4614HkYtknqv/1Mk8jtO5gMhbb4j3rl38uc
         jN3axmM3/z+uidMq6xU8KqoAg1FyKUjJ9Zp/kNiuvE32/FUsCNYf3loq6hC4cGSY+Kic
         P1Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWIZlTEVdWndIZi2C/syS+ZjazRQsnVyymnGy6qrXMfE7BFjSV4M1FFkCrPwQW7ECm7jCdu7MRNhGCsezthL38=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHIscQi6lK2xioPlJyO0JmHXXnVx2BV7CCDf503UvGxp+PmUks
	AgkCkLTh+eyE5qBHLMJ2pPUYEkbvBQOTm+QbXp+iiOWLqbN3XL7dSuSHqHRBPLC1ujk=
X-Gm-Gg: ASbGncsFYFjXazAelgaxZzCeM6xlduOYZKSBHR1eDsoPsqYvr7en2xKYxz/klZ5cr8/
	mTLUC3I8bGKBQ/DzCwvUqbt2SAtyhNXtVBNlUsNoyXJJrBbjT1OHBMSFEBO0HJ6b9QnkA+Lo+tj
	UjRrN0xThmBv/UzI4cxnfLfLt3rQadYS/VxW3OSVblQVe2OBdVk8HIm9sXTBG8a5z/a0HZx35Nx
	ZfXwVOeETd7e2jjU/neoj1q8soNKj/rnzOoUADQlxp4Wsfpc9FkWQNyRcGs2IgD32ahasLudX43
	JxVLbbgUbfjRx2piGXSHZg52U9IJrcGMAx6/FY8mE3w/aCYa3veelAAHfQedm6A+zgflcuAH3YA
	V7T2w6xopa8GzpXy9UQHm/V5Z+LEHicsoHA==
X-Google-Smtp-Source: AGHT+IEHUvZuJexFz6BBeX3fk5mL3wBIkel2sx8apDNHbc6BvCRU44PVFegJAXdrEJBt21NGRDXlng==
X-Received: by 2002:a05:620a:7205:b0:7e8:8f35:1d2b with SMTP id af79cd13be357-7e9f43067b8mr62262585a.2.1755562814479;
        Mon, 18 Aug 2025 17:20:14 -0700 (PDT)
Received: from localhost ([173.23.183.85])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e05477fsm685766085a.22.2025.08.18.17.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 17:20:13 -0700 (PDT)
Date: Mon, 18 Aug 2025 19:20:12 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: dayss1224@gmail.com
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Quan Zhou <zhouquan@iscas.ac.cn>
Subject: Re: [PATCH v2 1/3] KVM: riscv: selftests: Add common supported test
 cases
Message-ID: <20250818-59fc63b56f8f2da1acb7d9f6@orel>
References: <cover.1754308799.git.dayss1224@gmail.com>
 <09544c24d724a0e9d01c34b3d7599d860919ccb6.1754308799.git.dayss1224@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09544c24d724a0e9d01c34b3d7599d860919ccb6.1754308799.git.dayss1224@gmail.com>

On Thu, Aug 07, 2025 at 10:59:28PM +0800, dayss1224@gmail.com wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> Some common KVM test cases are supported on riscv now as following:
> 
>     access_tracking_perf_test
>     dirty_log_perf_test
>     memslot_modification_stress_test
>     memslot_perf_test
>     mmu_stress_test
>     rseq_test

I gave these a light testing after pulling together an appropriate config
(we should probably better document needed config symbols...) The tests
seemed to mostly work for me, so ack for including them.

> 
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Dong Yang <dayss1224@gmail.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
> index 38b95998e..3a7186551 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -197,6 +197,12 @@ TEST_GEN_PROGS_riscv += arch_timer
>  TEST_GEN_PROGS_riscv += coalesced_io_test
>  TEST_GEN_PROGS_riscv += get-reg-list
>  TEST_GEN_PROGS_riscv += steal_time
> +TEST_GEN_PROGS_riscv += access_tracking_perf_test
> +TEST_GEN_PROGS_riscv += dirty_log_perf_test
> +TEST_GEN_PROGS_riscv += memslot_modification_stress_test
> +TEST_GEN_PROGS_riscv += memslot_perf_test
> +TEST_GEN_PROGS_riscv += mmu_stress_test
> +TEST_GEN_PROGS_riscv += rseq_test

Please integrate into the current list in alphabetical order.

Thanks,
drew

>  
>  TEST_GEN_PROGS_loongarch += coalesced_io_test
>  TEST_GEN_PROGS_loongarch += demand_paging_test
> -- 
> 2.34.1
> 
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

