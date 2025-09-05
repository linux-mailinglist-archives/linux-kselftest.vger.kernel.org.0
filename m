Return-Path: <linux-kselftest+bounces-40839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B41B45953
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 15:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CC917C10D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 13:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E934352FFF;
	Fri,  5 Sep 2025 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wxi1ofR0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654EA352FFD
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Sep 2025 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079589; cv=none; b=X0EAUolTwth6PelioW9S68jACP5Uham+GGQjvenBI8C37fI+/LryRM5O5uMcWmi2SvFkpAtDYSTuD07JBlTQaiHsjkqbQdD+0hRpkw0JqshA9l0oMKtnLMzCRcRj9Hg30HIUYedWbqe4Cnvy1SD1ZmRF4ECSajyC0D82Ooh9EgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079589; c=relaxed/simple;
	bh=lV34fd5T2IMvnubZ0pRZL16dgEnAyXl4YiUZPOjRgaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nj72ZSOtkiR/x5fDRwBTvwnwL1c4NOAlFalCL98om7nWncl+bPzFySwbLjGSB44TFpBBL8o0sOuRbLMFoX+ggp8DtRPENgL4mJFBcbs7FFJgOllWrbIcvEVfkS8te7r2n6Vs+Xfvi/Mq2AQzTco5DxxH+UfrX6WSbWc1MbfjzVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wxi1ofR0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so307927966b.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Sep 2025 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757079586; x=1757684386; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgk2eeEIZzHXEjQEMvfN8nURnzUH0fSlJ4fPZDNKG2k=;
        b=Wxi1ofR0Udlbq0ZchEOtKbx86DXHF7fcpHPEavN++IxBCQxLIufO2T25iWvo5nVtG4
         s1wsCvgKdrohIrFrA8vroRatHj7k+vmLWkzPjnVx5iwAWhGRYFS/XPB1vXqF1fo9YQAd
         5U5g/xp/isqlulUCvca1vpVoimX88x0E9oYwvU4DulaEV+yH5QbBMNcD/dtKNZOBO4t6
         kN5vARk4cUDAIFX39Q8kDW7QyftVtWps32zefVT61H1llN0v4r4CA61+JCJibnvkDLzL
         CBggcIXAFZP6sAEPS7BxIWL521JWGGI0fiRV8XxHiT0Re0TxoDbQEbn+8wynE2eO6eoe
         ue7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757079586; x=1757684386;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgk2eeEIZzHXEjQEMvfN8nURnzUH0fSlJ4fPZDNKG2k=;
        b=rhQba8tHrqcIsCTgkibYEXrafo3+d7P0aSalspM6X3s48mDBVYnTm3rhuZHIzJPJ3J
         hMvdQBbIFkV6Z3svhsjGgh4JAbIRMfykqrw0/m3xXL7LHN9h+jbayuRJjzECPWVtvdXw
         Z8tLN1z/e1YgtGVwWL3NHsiHzQ3qI5W8CShYC/A35AqrJiNaNXT5qrpl04ERwuygki+0
         6Y7k5/MHYz4ggy+uGoLgGffD4gXNHHPTYa20H9hxXspyARhT+odqtYU8WNP1X5MzckY3
         CN70lZH6p/2+eqsicl3emIlkmP13ydP8HdbkiEUVW876voTVmbJjFwgxZCncSAx5WiNf
         jLxA==
X-Forwarded-Encrypted: i=1; AJvYcCUkVM3CLQH6b27zMbGdKI5Eosf8zIMJisYxy86fHC9kLUij9iPaVtf3rWp3tvfqOxiClEZ99BCkxsObueVqkyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPujYSEDaCHgeGggo55QyWTON8baznriaY0MqG2n4e5Beuy451
	4w0UFT4EHRACw9XMBByF2TI6TMn5wCTtvCJPsmPRyz7srd9iNPOgfAAk
X-Gm-Gg: ASbGncvsHkKJVei/s3x/4gxAw7IsskqLDdSRhUWun0/rPGJ9gfG8V2cOKDnOFBOQv0Y
	6sqPoql89KwKJSz6J7OwiEzajKhitzWNtaY0w/bwhWLE9XzTaKowoepZHIN45EQ0+7u1j/xU9cM
	FFiiB1wcN+6d+0LbI7sbUCb8mrkRWsaLyUApGEp17fOF1XtWxGDpJGZ6QZXp83fvXRq5o7eiB5G
	SMKLGFXkAyHof9Kp6NXUT6DcKQcb3jU87KPzFg9xu4ngkye29UBS68hD1zLniclCj4yTcModPA6
	ZQ0N0cEHE1qECgEV3mg3JcJ/QVth/QT+gR9eRvdwIm76+AhmU9pHr3QgW4fRr+qmMJ2fh/KdpKu
	floMBRvHHA8FHNHIOm1vo9rZ4BoH4qG0zmZMJ
X-Google-Smtp-Source: AGHT+IFI2No3TID5oH/4T0G9aA3arCZ0pnQDj+i2QnHXsj/89Z8bWCZxKfZhcwf4aAg3mb0r1QvbmA==
X-Received: by 2002:a17:907:7245:b0:b04:76ed:3ff5 with SMTP id a640c23a62f3a-b0476ed442bmr906627566b.40.1757079585368;
        Fri, 05 Sep 2025 06:39:45 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042523ee7bsm1318657066b.109.2025.09.05.06.39.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Sep 2025 06:39:44 -0700 (PDT)
Date: Fri, 5 Sep 2025 13:39:44 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH] selftests/mm: refactore split_huge_page_test with
 kselftest_harness
Message-ID: <20250905133944.dxwa6l5acd2w7mgj@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250905032431.22179-1-richard.weiyang@gmail.com>
 <720957f8-c50e-428e-952a-9616e9f610b8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <720957f8-c50e-428e-952a-9616e9f610b8@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Sep 05, 2025 at 05:03:26PM +0530, Donet Tom wrote:
[...]
>> +FIXTURE(split_pmd_thp_to_order) {
>> +};
>> +
>> +FIXTURE_VARIANT(split_pmd_thp_to_order) {
>> +	int order;
>> +};
>> +
>> +FIXTURE_SETUP(split_pmd_thp_to_order)
>> +{
>> +	if (variant->order >= pmd_order)
>> +		SKIP(return, "order %d is not supported", variant->order);
>
>
>On a 64 KB page size system, the page order is 5, so the remaining tests
>are getting skipped. On such systems, these tests are effectively invalid.
>Instead of skipping them, would it be better to simply not account those
>tests?
>
> # PASSED: 64 / 64 tests passed.
> # 30 skipped test(s) detected. Consider enabling relevant config options to
>improve coverage.
> # Totals: pass:34 fail:0 xfail:0 xpass:0 skip:30 error:0
>
>
>Here, the 30 skipped tests are invalid, and the total valid tests are 34.
>Would it make sense to exclude the 30 invalid tests entirely for 64KB page
>size systems?
>

Yes, this is a little annoying. But I don't find a way to achieve what you
mentioned with kselftest_harness. :-(


-- 
Wei Yang
Help you, Help me

