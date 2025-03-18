Return-Path: <linux-kselftest+bounces-29380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2884AA67D5D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 20:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE0419C5685
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF3D210F5A;
	Tue, 18 Mar 2025 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8f+d3ni"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4E41DE89D
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327675; cv=none; b=md7pvpdccr2OQki5e2iFAIXeXuwH9kyG2+4eBkYKAw8y3uAgtj7G4KgtezCRVQQkVlXPdeTRXFtlCbXofQw8Abve8t6SGo6X6iRztn8bD/OwzioT6td0qsNBaQDGjp5+fzw9mKVup1Ha7mc4Xq0brPzNeEeky5vt7iIBq1YBBnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327675; c=relaxed/simple;
	bh=JoTNH2FqYyc5LQLIAzMMJtHrLuRh0Z/dkiymOxL8YYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQAGKY7z/hT7uXmkXliJvCZWlIyLzOsUb1mappMNAt4C9PX897cAfNyn21xd/8x/9+bBWunuKVZE3boYO+A6fnGe63EcC9k3JNptJlhPWBJoAf2o6p5jRngA9kzuJuW4vTz4tZiFEjR8/1bd3cLMIUICb1QGcoKlcl4rANEgt5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8f+d3ni; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742327672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=asmhHq8i6L+nn6qMOR3aoqUZwBNi/F5FrrH2+8dZqWs=;
	b=K8f+d3niCLHp9SgKH+lgY8k40LySKj1z0DgQq2Eye47hDUBLUtGLJxA47uNnhtU2M7SbPs
	+k/ZkOgnHyCBuWyeLqmLDLtZacRIRVHdhsDfalFYOdgesyx/i6qbu58SYmZOb8SWi83BtE
	guE19ZDobQrY1o6/QJy6rqnkEh/iPkE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-XC2BngvIMH2FNW9vEU6Icg-1; Tue, 18 Mar 2025 15:54:31 -0400
X-MC-Unique: XC2BngvIMH2FNW9vEU6Icg-1
X-Mimecast-MFC-AGG-ID: XC2BngvIMH2FNW9vEU6Icg_1742327671
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e91a184588so185511136d6.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 12:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742327671; x=1742932471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asmhHq8i6L+nn6qMOR3aoqUZwBNi/F5FrrH2+8dZqWs=;
        b=B2sXJ8m2b2rP00d4VVrBtNYLmYiKRZbPnkbYDRGv0Cj7uC0nY6N5A/rbFaJ2tGDnjR
         UrP6vd1ANvocM3Ue89coDDpN4JPFuJ5pzj3hASd60ZTye2FRlX96mxylVKL/6iw9AexO
         Eqydo+ziZojdA9awXWBI/muFhWeh4Za7JaB3l7gYtTnd1k51InreRenDdWXYN313ekk6
         BuV88kAOUJxj/jEXnINaBXGf2kfv4u1Eqkj6ONiHWafck5W4nYUcDHZlG8c6yFWxFvfj
         9x9ptFc2L8kyvhWF3Z5r4Mq6Nksl566vsAKxhGMl7qvdYucIa6Kt5JHtMrZ1UlLtG78V
         lAMg==
X-Forwarded-Encrypted: i=1; AJvYcCWoRzkHzitpDGTr9olici8yKORF0JAaLKQ0D+5Q2khSpRnkPPk84d5Qud85vZs59YOLRDazYb1MQ5Dn8MOFXz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRAAZ6VV/4pIyyNq+spPQAkyF0s5Bnn2MdM6hBHyPsl4YWn686
	qeFf3ARs31OF6G2yZgfbvG3FlgmNot9a1NseSwtovJb3oMspZkN4SveQss6xF5igVyqJe+sj82R
	Hhb57O9XgzLj/HU9djeRnrmTYBUN939aKD86++7ovHCFvp0y/l6iAxNLKayaawWPDpA==
X-Gm-Gg: ASbGncslrZb5+sBhrdl/6dC1Ko0ucZGie8OE7au1XBzmt9o83+8//UdFpGKeFCii4cF
	DfXANjpZgy/dTgxZ6WB+AON3wnhjjfqEA/kFhR++zruf7WFVA/mHV/xymP7EmCdM+iG9f36B3+7
	7KS1daI9eb40/vzv0lzOKxdBqPWhjR7mxcrqMPlLrwwEVxDgcgGrtbUzbXVUzPMS+t35v4HoJd/
	I92NrQwnqctf2qc8KfzHB3c8Gj7R3oiPTqIpDX40XtoOirSrjLWEaaT9j5DvprM/qF7CpR4uW1p
	lbkZXcU=
X-Received: by 2002:a05:6214:f05:b0:6d4:dae:6250 with SMTP id 6a1803df08f44-6eb29428beamr1764216d6.34.1742327670840;
        Tue, 18 Mar 2025 12:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdWrfqZPT3Cscze64Kk4O7bgfCX1eO6rtfNSrfKwrt8NlWPtqGYeJZ5PC9d9TkD1v/NHhpZw==
X-Received: by 2002:a05:6214:f05:b0:6d4:dae:6250 with SMTP id 6a1803df08f44-6eb29428beamr1763886d6.34.1742327670506;
        Tue, 18 Mar 2025 12:54:30 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade34c51fsm70867106d6.109.2025.03.18.12.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 12:54:29 -0700 (PDT)
Date: Tue, 18 Mar 2025 15:54:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 2/3] selftests/mm: uffd-unit-tests support for
 hugepages > 2M
Message-ID: <Z9nPc5k22FJetBMP@x1.local>
References: <20250318174343.243631-1-ryan.roberts@arm.com>
 <20250318174343.243631-2-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318174343.243631-2-ryan.roberts@arm.com>

On Tue, Mar 18, 2025 at 05:43:40PM +0000, Ryan Roberts wrote:
> uffd-unit-tests uses a memory area with a fixed 32M size. Then it
> calculates the number of pages by dividing by page_size, which itself is
> either the base page size or the PMD huge page size depending on the
> test config. For the latter, we end up with nr_pages=1 for arm64 16K
> base pages, and nr_pages=0 for 64K base pages. This doesn't end well.
> 
> So let's make the 32M size a floor and also ensure that we have at least
> 2 pages given the PMD size. With this change, the tests pass on arm64
> 64K base page size configuration.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


