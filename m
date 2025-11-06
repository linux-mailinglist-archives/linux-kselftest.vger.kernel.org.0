Return-Path: <linux-kselftest+bounces-44955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 16124C3AC25
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 13:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B64D4343D6E
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 12:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D032320CB6;
	Thu,  6 Nov 2025 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cpd9riAB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6823C39A
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430578; cv=none; b=HtGCPGbnbABjzrhpT04EZ3LtTlDBdNKg+XEHcIu/3oSR5tRUUUj/7V9A1JrIOinT+OvqioPsY8HhK1huTXCspBdYb9XknJBmlIzoMZVTi8A7UDWrpD8nYExgmKYH6Td5Qf15BF3L8YTD+spVVPAFRUjOvl+U8tlXB7go2fZtUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430578; c=relaxed/simple;
	bh=4OKASdibq+nZZqna0+9/1+D9HntGbdAc7VcS0PAJtNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSQ9QuYmpww6G5Xa29UG68zIHcp/NaKnKUOkhodyeTrypwwaEZF9shLCHYkEoXSRAJBoMReUtXtIsyNA70POLo8uxkWvMHRXRl9pqw/j8mR/pjTdBoZKXh8pMR71Fclep2DauDveP1APpQQaj+jda+kbPkjPow1O2U0/d1LUqKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cpd9riAB; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2955623e6faso8816055ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 04:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762430576; x=1763035376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jPtGSfOGi/keSSlURDQLQTcDjTM2nCUWyB1gbbtP/wo=;
        b=Cpd9riAB2a42RL1ElR128D1/rKifGtmTS0piEz/pL4YtGQXacgEXBUtFN6UFeqXlVi
         iuskks8k/bF+htjMmENY7+mWVmo1qv5NuDw1FSNyohRUvQzhCHB9pPO8JvXxyHCZqNP2
         gsydaWe8HHnqEMsOqRjHJMzcXRq/47x3J3fJ1EHg5WKa4ZnwULIpSYiohVWNtpsy+KzW
         txpeKN9D+aV5+tQwN9yvfH9s+19vQA0EKKqO8vUypJLgRWA+jhste/UMZ06KiNry3V5g
         IFsBeHwZNNoj7M6nliajrATXQgFnSsS2Of+spxq8rDAaUG7m71F5bTnXfwooxGzSpIKp
         Arzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762430576; x=1763035376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPtGSfOGi/keSSlURDQLQTcDjTM2nCUWyB1gbbtP/wo=;
        b=S99QETN5uPF5QSmewrqlB1kz03lMyAROTvnhqD610ZSBZiVyYy1DZ67+W4GBk2gRMS
         hsEYkt7Af0jFH30d6CgHJgYLhq1uZUaFZbWxDhf9ZG8vbpaxrQXyX1O74gzRs5d/1aoa
         jGpacg0fIEIW/jb4vvD3wEhoqsoMYLNLGTboG+u7Hj3pqJxKRtMZa3fXbSJrTlybbEkX
         WFRMw+usAgBt7hAYFylKKruD7t6OjJLCrGAmYFIv2rUjGp/kdV/qnRIXm97+QPFeO6Ps
         jaTkkvpumrHQj7YLN0E1sMuPhtDSB2qwCSUMFRIB3qOAQnB6C5EVreydMzNt+4EwjLx4
         yzig==
X-Forwarded-Encrypted: i=1; AJvYcCXj1d+puWDHJDhEpT4+8PJlycaSL1UF0/QJtthzFftNKCJ2RfhOiXf1imLJnZMKEpFgv7J8jVf/v9ZZRQF9/9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGcHEu8beUIcqZk8b11qM9WaQt5RFNBm4ASaCLQB6h1VUOmZpC
	uZgPKFG1EOiAEh2ff1gExh54k5zgL3wplARjsUXuvh0v9NB6riB4ae63
X-Gm-Gg: ASbGnct0JLmYHY1GoEDZcGZXMYqzDzQpwO0xDoH+E5qaCd8uLqeUL05y2AY+WrfBIIV
	aW2dzrWqVoahZheCfUZYP06EOXQYgwHUI1aiCEWCIEvYWJSw+cflix+W5eSlEnT/hydqFVuLqiU
	wIIMCCuwhOMapRUHXBAIGdMVoX+fSmTwkgIvYKzSpBTGl73H77ux9BR/vXqwR6gTmepZJft2k3q
	ruLi8EOy+9+eBzXRpddDrxuhjFqzeSp0dVie61VW/T5YujAVrbteya2qdwjHnMkbiFGnznBlJeM
	mbBO8Y4d7WpSFe/sAaOdOnowwt5ZKik9DKEx8i2SYeZ1K2ib1t7TuGIonMfBblgKoMa6L6YPtUE
	qNhx+1UaSWGCB+C7R+2pBtfdaa1nYtfwiMgAcoaKyNptvEx0SmItjW4G5QcsGSc/0P6FY69Ba/o
	aL6aKmyMPfqc39VtarRYOHp/1Yy1+Bgw==
X-Google-Smtp-Source: AGHT+IFg4ppP6vi/pJwmzK9YEs7d/wlWubuW638khXVc5Pb/3DX1F1asOgyJ4kSWyBkD8lMqiRUGDQ==
X-Received: by 2002:a17:903:287:b0:295:738f:73fe with SMTP id d9443c01a7336-2962ae4fc1emr78620125ad.30.1762430575766;
        Thu, 06 Nov 2025 04:02:55 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af82afbb45sm2582114b3a.65.2025.11.06.04.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:02:55 -0800 (PST)
Date: Thu, 6 Nov 2025 17:32:47 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest/mm: fix pointer comparison in mremap_test
Message-ID: <aQyOZ6eYng-IjxS_@fedora>
References: <20251106104917.39890-1-ankitkhushwaha.linux@gmail.com>
 <fc051006-5cb2-49e1-bb27-7839837439cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc051006-5cb2-49e1-bb27-7839837439cd@kernel.org>

On Thu, Nov 06, 2025 at 12:18:57PM +0100, David Hildenbrand (Red Hat) wrote:
> On 06.11.25 11:49, Ankit Khushwaha wrote:
> > Pointer arthemitic with 'void * addr' and 'unsigned long long dest_alignment'
> > triggers following warning:
> > 
> > mremap_test.c:1035:31: warning: pointer comparison always evaluates to
> > false [-Wtautological-compare]
> >   1035 |                 if (addr + c.dest_alignment < addr) {
> >        |                                             ^
> > 
> > typecasting 'addr' to 'unsigned long long' to fix pointer comparison.
> 
> With which compiler are you seeing this?

Hi David,

clang version 20.1.8 (Fedora 20.1.8-4.fc42) raised this warning.

To reproduce:
	make -C tools/testing/selftests/mm CC=clang

Thanks,
-- 
Ankit

