Return-Path: <linux-kselftest+bounces-40531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01328B3F853
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70063ADD33
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5E62DE709;
	Tue,  2 Sep 2025 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZACu5Ah"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D3F27BF7C
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801739; cv=none; b=W2nl2hp1W8j98hfkkkdehfGi+GhxGL9LGNImM4VMxFIAsVrfhE11bk92NYLK4EiboQGXZVtouvaxxhDk3T9Q6NVTby9klBF0QIhH16JuiViR7MOBfMFpmmIYy7JQB1C7Qi+3QpUkJUTV6SDsol4TIWO1zTQTNnqpFTeoAjaAdm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801739; c=relaxed/simple;
	bh=sn7TbfL1MsmjGeB5OWwrQkYgz80Xiex0nj9HOVrK/+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaWhjeAEckUkA2qhxmeXWLRk40LeZeQh8Mt6PDz3ru4i85vFKn5edlFOsiZEh9OeroACIr+ac2gyDKcplwhMYdchMxVrcSzlxaDHYhzNAzHMzoAX/PNRfkgr0y5jAbZQX/413z6HcBeyb3xbwzDiwuAXgV13n8HAyd3MCiFhefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZACu5Ah; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so753720266b.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Sep 2025 01:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756801736; x=1757406536; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3P/CGRELA2cwqjSr7vg0wYPdyQiu1PsJ2peMY1heJU=;
        b=EZACu5AhYQXvvWG4ZaE3DS64tYB+zGGBye8iJEoniEqr0BSGBPjogm9Xf7r1MPG3GD
         yJUEyUSmGkeHQViSzMjgDNJBr/Xz8qRxVYvonX1r+Qbzw85gAakgXqRyar9m2xAFd7lT
         1rmAW+X1kTb09OJ939WhqzImzpGrizEUw2Ea/mriU+KPRI8ITHITWHNKWiLPiFhdC0VY
         BG3MJu67d8AWyLWIuUuenFbwKlZgh1LJZkd05KfYCvJ7bSKaETxnzJHBvvxxC2D5au7J
         L9dE65kGN9XNE7llj5qb6hJJOhwWNVWa4OsXiMKxzV6mZ8GjjOg2JAhJZDv+PDePx13S
         d1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756801736; x=1757406536;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U3P/CGRELA2cwqjSr7vg0wYPdyQiu1PsJ2peMY1heJU=;
        b=LLug2ocPIFhwsXyhP7xk69zgzraqQzHspzqHHOczxNNE4m6EY5iyg7CZS1yi2umo9g
         zVWVQVsgJLWMri8Tlr43ORpBUGwxP6UAKYUwUugxSL4qow2B/R2kixbwxfMO8ehhjvu6
         /U01/LL//zjPpq7hTh4yhT1bAECsJ/iPR8+QjAUgKyHyAb34kTuSS5+MaYB4gzYGrtU/
         nl61JucWj9f3U7YA/aKFE+S55gMM4REc89KGqtn1a3+2uMmepz/F+pl8TC8/AeDO5Q5c
         7lu+eEuCMY+7udATzeyUPJcC7jKS4Dr9HG7FZECFwR7cNVQFLPu0rEyrla8lWJYmuElf
         VB6A==
X-Forwarded-Encrypted: i=1; AJvYcCUI9iw9dbU1axDmMQktZ4W7WhfgRstbv+7rl1v0/l81oEY0cwV9EBo26QmBMMHrIR4yCEe8Oa22ogxqkIpFpYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXcHOLahfue8zlRPF5mj84jGWL1GFFy+ipCfN/TgNLq+cnL7U3
	iDpMO9PqGVs1HhaFusz4FGKffqGU1iSdOtMOkipFWpf7pvmj51+Ya50o
X-Gm-Gg: ASbGnctbu1wHF4SYHG0gxIDFnTI7MiDDigh7hT6hQdGCGqPs9UXx20Gdwa7CtRCWSSF
	pJuCQnlXgg3EB+RPTbv/32B+lOk8lXCWpNCcGQ/ZmB9Jrachijvg9FVK8ZiEwNZba1bSKzMLD6+
	TBS4Xztqj3s0w2H0T40rag+Q6vEj4zxKRW3eTnQCK03rQOfSXZgh0FMqVZo3RV4z6/MTJaydXDE
	xg2UsUbCoeroqd9roq3gsvo1811GoiBdnqSqafWGadmJrtGwPy6sQGDdhXcUivwliaquWF/q/X3
	phMf/ppvDPCXSRvT3VGohqNff0Cm7TMwdEsB1EFWgVvMutVgK1ZwUb9bad5Y3k1GdtNB9LaB8aX
	Tdtpvhf8XMgpkDr4Ag8AUvCQqUsz8wQizYC6uDX6b5+puynQ=
X-Google-Smtp-Source: AGHT+IFb9rOq27uofOw29r92S0PkBoN7HR7b+VmwnUYUoa6nyVqak5YoGAa9Gh2DOlkMJeWTVVZPVA==
X-Received: by 2002:a17:907:3e03:b0:b04:59d5:fb78 with SMTP id a640c23a62f3a-b0459d601aamr40455366b.62.1756801736121;
        Tue, 02 Sep 2025 01:28:56 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b00e4b740fesm818710466b.47.2025.09.02.01.28.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Sep 2025 01:28:55 -0700 (PDT)
Date: Tue, 2 Sep 2025 08:28:55 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, Zi Yan <ziy@nvidia.com>,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap
 corrupt data
Message-ID: <20250902082855.muyi3wlxbmkcwiu5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250831022701.2595-1-richard.weiyang@gmail.com>
 <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
 <61E58B7C-23D0-49FE-8D0C-CE0B672114E2@nvidia.com>
 <0a0b0018-9427-4201-bf53-6aeb251bc482@redhat.com>
 <1D88E773-C11E-4F28-A13A-1A681898198B@nvidia.com>
 <5a796574-0a3c-4040-b0bc-3ff757402759@redhat.com>
 <20250902025112.d2n3o4imeptppctd@master>
 <dd30710a-a210-44dc-93f9-1e7ddf096251@redhat.com>
 <20250902081342.rthx5sopowmg4hyb@master>
 <05f628ba-c24b-4180-87be-e5a577dc4e4d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05f628ba-c24b-4180-87be-e5a577dc4e4d@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Sep 02, 2025 at 10:23:51AM +0200, David Hildenbrand wrote:
>On 02.09.25 10:13, Wei Yang wrote:
>> On Tue, Sep 02, 2025 at 09:49:48AM +0200, David Hildenbrand wrote:
>> > > > +	/*
>> > > > +	 * To challenge spitting code, we will mremap page[x] of the
>> > > > +	 * thp[x] into a smaller area, and trigger the split from that
>> > > > +	 * smaller area. This will end up replacing the PMD mappings in
>> > > > +	 * the thp_area by PTE mappings first, leaving the THPs unsplit.
>> > > > +	 */
>> 
>> This confuse me a little. How about move "and trigger the split from that
>> smaller area" to the end? So that I know mremap convert to pte-mapping and
>> leave thp unsplit. Then we do the split.
>> 
>
>After spleeping over it, what about the following?
>
>+       /*
>+        * To challenge spitting code, we will mremap a single page of each
>+        * THP (page[i] of thp[i]) in the thp_area into page_area. This will
>+        * replace the PMD mappings in the thp_area by PTE mappings first,
>+        * but leaving the THP unsplit, to then create a page-sized hole in
>+        * the thp_area.
>+        * We will then manually trigger splitting of all THPs through the
>+        * single mremap'ed pages of each THP in the page_area.
>+        */
>

Much better, thanks :-)


-- 
Wei Yang
Help you, Help me

