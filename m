Return-Path: <linux-kselftest+bounces-29381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B148DA67D67
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 20:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074A319C09D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 19:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1861F09AD;
	Tue, 18 Mar 2025 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qq26zGI7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2E1DE89D
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327689; cv=none; b=p30yPHnuUViVIZMA1P2icBagRkC2s/Rv/N+5fGY6eBMuaO+4xuF9RGPZPkqJBOf/KtsoZ8Ltv688t9kb7QP7dURTQBYshU9YhYUczlX1wOu6E2ekSS8qW61lmGeLOiCjShf+y70T0NHAx69E90Kqq+ov19BNb/I7sdCLL/rQPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327689; c=relaxed/simple;
	bh=VrlJ3A/OO54Db8N4rdrzXfrOYZxuwLvtzEkpR1geLW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0wh/O76SMuL2bMxbR9g6HUoA49/jJ8B+zwtAsk8e0amNnWJiiTgeTtWs30f/btWSHqBs6S7wPrz924A33DsPYCLEKDn77HfeaYgHk9CEsaVjdyuUAJOcbhpKq6gL4Y2kl7LP6Z3GL9mhp4VpYuxvrpKpiaOqRBUobZXiib7FOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qq26zGI7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742327683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fx/udxou9t4pcLYg6KzQ6jS3G17qvHPgBox/VxbY1DM=;
	b=Qq26zGI7iCJO5Rs1Yj90zW6f9KlaM5njTnBMcAvX3lZ1hVUhTe6UBlNJuY04YfX/BylXbc
	2J6H43fxO3wZ5cQ+Tm3F7qrbPi6b9ZoXk/toJxqzFpxt+IOFLOpeTISFwoUD71Ami6PRm/
	CooPJA8iHGPksVwEmdvQFTeIvDNUvPQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-XZRGaIhJMeKiF2rezq0P8Q-1; Tue, 18 Mar 2025 15:54:39 -0400
X-MC-Unique: XZRGaIhJMeKiF2rezq0P8Q-1
X-Mimecast-MFC-AGG-ID: XZRGaIhJMeKiF2rezq0P8Q_1742327679
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-476b2179079so120958841cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 12:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742327679; x=1742932479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx/udxou9t4pcLYg6KzQ6jS3G17qvHPgBox/VxbY1DM=;
        b=njg0aQiuXwSAkF+lSv5WCYU9Ofdl0LzsD5sfNKg5vwprrl7KGxKW8H6lnZ/JtfGMdD
         D/VdcKD5W1WU1cTBTyGjTNPa6saFn2hE1v4rsCyMyUB55cRK78c1g9L/VuSJQAeD2skW
         +rMuWXdA8qaNfwlnTUM5CRNQi8VrUtGHeDIVkSWB4p/M5e3SBLPOvBqxmaYWJobEAcL5
         +GWlehjY+3gGnIQ4eBcBOrKjs0YrnhnTapiRjPByBz/gsA5jhSBR9yU0wPq6SmHlDYgL
         61ySu3oEe8MP4GAZofvr2tGlRxcO5jwpBmO2/CMoHedM+M1rJYHXaMwp+aNkLwrtekiA
         +juw==
X-Forwarded-Encrypted: i=1; AJvYcCWNrSjZRfk3mT5InHuop7dUuJKBgfD3WJXhi82V1Xom2QGg4KgxPSMgRIDc9HgzKHChkM6gIa0p+ZVaBer4+FY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPspQFyVKdExrAXk4eniiwaAniq4sOWDDylKN7Y8q+OBd2bNV8
	3iDYyNE7UQ+/Q/V8LEB79zGcThd7mA4iVjijwn2ZG5kgR9Byr2stsy+e1Tt9wAM4DbBIV3CWknk
	uY9Mik/LR5ph4/Sur0q+HrVhyCOufEkpQ+rxf307xfZx5eKVh0Gc+URB8DifpjtLxqw==
X-Gm-Gg: ASbGncs9fk3hkBivojhFY/hMcMdhqjZVeyuwY5fJkKaKzZEvb7uF4bdRPqJDJsPnYdd
	Kl5PJYWoTO6OeL7kUYIcAqIM0xWNCwicrBdNVng2nmEzeMY475+F0Sqb96hsTMN6rNst2+HLmvh
	E6/ZGNuhzsmMdoxE+lONJLXAntAhgJoF18HYxBh9qAPqUbItplWAGwXU5lGxVnT0IPyMGO8Z7E2
	a5WjFfGC1fUzLJdoe/Pu+a+egYKKw6NpU2rE6MTStZlms31nOa2QLcn7IMb6Alb4u8tI7rgoNDH
	oacZ/jo=
X-Received: by 2002:a05:622a:5e15:b0:476:afd2:5b5c with SMTP id d75a77b69052e-47708383ec9mr3437421cf.30.1742327679326;
        Tue, 18 Mar 2025 12:54:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9LWb1VzYkNj6s/jeDxGd0TKIru2xNP92VxrllNTEJD5uJF/UCPS2GEX9AjyO3i+Wo9EOo7Q==
X-Received: by 2002:a05:622a:5e15:b0:476:afd2:5b5c with SMTP id d75a77b69052e-47708383ec9mr3437251cf.30.1742327679070;
        Tue, 18 Mar 2025 12:54:39 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb669f72sm72825171cf.42.2025.03.18.12.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 12:54:38 -0700 (PDT)
Date: Tue, 18 Mar 2025 15:54:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 3/3] selftests/mm: Speed up split_huge_page_test
Message-ID: <Z9nPe2DBWaxNyhI-@x1.local>
References: <20250318174343.243631-1-ryan.roberts@arm.com>
 <20250318174343.243631-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318174343.243631-3-ryan.roberts@arm.com>

On Tue, Mar 18, 2025 at 05:43:41PM +0000, Ryan Roberts wrote:
> create_pagecache_thp_and_fd() was previously writing a file sized at
> twice the PMD size by making a per-byte write syscall. This was quite
> slow when the PMD size is 4M, but completely intolerable for 32M (PMD
> size for arm64's 16K page size), and 512M (PMD size for arm64's 64K page
> size).
> 
> The byte pattern has a 256 byte period, so let's create a 1K buffer and
> fill it with exactly 4 periods. Then we can write the buffer as many
> times as is required to fill the file. This makes things much more
> tolerable.
> 
> The test now passes for 16K page size. It still fails for 64K page size
> because MAX_PAGECACHE_ORDER is too small for 512M folio size (I think).
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


