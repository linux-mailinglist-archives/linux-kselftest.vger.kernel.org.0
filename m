Return-Path: <linux-kselftest+bounces-43487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D63BED28D
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 17:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC2619A4458
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 15:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1A51DF246;
	Sat, 18 Oct 2025 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="R+2LR/ps"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D175840855
	for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 15:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760801331; cv=none; b=oVm7mhCOaesKcWEfE3Dgn2HUq9PzbmfNQi6ZGCadhzizqAcjQMZTV7QaKv0DP6zhYIUZFZE7s20wcKO/fe56L5Qx2jZGGQDxDqbgYzYy4rYQOQk5L3f2DqvH61qApTCbyTb6ga1FJHuEepftyvi9hPjeOjptTFp4NGFcXt6jC1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760801331; c=relaxed/simple;
	bh=Jp9qkiE962EqU6AuwTutKC7YuQQ5b1pauuoLKIDWLOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Peb1NYwDhwdSAI9HUiusUX08R/ucQJmKXDglWDE3tcdWP6fIoL9BgBAkhnbCfW0kPlhGM8ifnZ4nehznQS1QcA1Z1haJtXeYAlpHSqaSGVI0NiKEOBFjpBSDMsr26LfbK1UUs+DOIGuOuX5RN+QJdU0p8rcKVIxS7/dGgAPJf44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=R+2LR/ps; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c12ff0c5eso5731528a12.0
        for <linux-kselftest@vger.kernel.org>; Sat, 18 Oct 2025 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760801328; x=1761406128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jp9qkiE962EqU6AuwTutKC7YuQQ5b1pauuoLKIDWLOA=;
        b=R+2LR/psxUR8y/nMybdUNZLtDGmVeVO0lTySF+1grod7fQgCk/SLqbD+ZGw8MZfgjU
         8pvDFxV5x1GC7iREGB3Hbz/0QIY/LggFAXHZJwuR3mZO14Zs9ijl2MxCVYRyYOVdNiwL
         ZZ+bDIlbeK5aXQ8Lm3OZFOZP+uAYRO9v9ozIwTkPtEE9/FMfvN7CCRY2DpipFYhYHqiB
         Pu47SorntMYwq1f/A1Req17yif1WG+TxzmTQ2QxLcJ7NTnf4nZ/59+lW6amXi1ryIJvV
         jmSYk92kgvB6vS0Ucc7lWL69XuLedpa+kCzEm4Isv8/EqoA98U/sigh+CTbkbP7NR50T
         LguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760801328; x=1761406128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jp9qkiE962EqU6AuwTutKC7YuQQ5b1pauuoLKIDWLOA=;
        b=P3tNTHylGZA845fzSXkV4uBEJO5eHS+6gKoZchJS3QS1kEtIJ4MOvKe7QWesvllQM3
         btdABHyng8OFxHXUKNLftwxhM0fTv5SeKqk1E/uIriw43ki7Q5AOJXXmILYVE6ULC1ht
         Wr03BLWj8U64BfgokIpqwM0pxh59l1vTmEu9ZUpDQfBsHegaN2MBuuGMYUuLtez1Jugt
         D5xGN9lSr0a9Fsdacm51gAaSsf4Vks4j07PZoek+ZbIUaPQbTeo2h+hKpSp50wmch51u
         /12ZasqJC1ZQfzffQJ1QoA4emuwmAa40HemsyaLUB2ZKoJ2CmpwkAXWkEqKwF2WK7y/2
         jbmA==
X-Forwarded-Encrypted: i=1; AJvYcCVYb1nfzwlnf0KcrjLldpgOYa1t1Bdf0u6eJgmdBCa083sohp/rlygm4oai71HGfybd6DPIE+jI4nh2dqsNpzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfMsgx/RdWvqjgyGzf+D3zIvFXut5Mj8T6y+IK1K4ZnNwaRYTn
	LfmQRtK8sgXMUEkMccmbc3acUlz2J8QzfDzF+XIr3RNjiHewyiXom/ccJ1zP/QqgjBkL5xyAwbx
	MU6AVbHA/xg6Cj+uK1/4oAHfEt//0m0zLzTV8hQAU2Q==
X-Gm-Gg: ASbGnctooq907pno43tjfYmZZ2e7R0I17ZT4jC3Xi/wAA31PZiBEyG5EWyElv2K7Jin
	QBWG8OjQc1kfQ4z+K06Gtc30U7eK5PUjOAs9GpSZWF1vrw6NCUr3REqLJqDo+wUor6J05BOR/9w
	puLtghEs1NWwM/ZRg1yl0YOqUqAtuzWUdh1XXpj1swClWDTMQSjs4/q2CkwI72t2UE1LZB2zVvX
	whHUgCp0zCx4rCKEHjxLy4TQS3uW4pq85FVyt6/RMPWfW8gDpiEgnk/3b9Zv9vIWIp88E81OHLe
	AsoHp8tA3PTOl/Y5
X-Google-Smtp-Source: AGHT+IGD+GIZ6cxCDQx+cpZ1B+6x/CWUhSAiqtZJo+SqncV9lu3xa66p7nHm+gyAAx9koD78PZnXe2MMWr42HEQvxQw=
X-Received: by 2002:a05:6402:2713:b0:639:e5da:637e with SMTP id
 4fb4d7f45d1cf-63c1e1f212fmr6981739a12.6.1760801328092; Sat, 18 Oct 2025
 08:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-2-pasha.tatashin@soleen.com> <aO9ZiERHff7vQiBL@kernel.org>
 <CA+CK2bA5Eyz6TUMTy3pa5HBvZ7KkiHX3EHn17T=d6LX_X5i3bg@mail.gmail.com>
In-Reply-To: <CA+CK2bA5Eyz6TUMTy3pa5HBvZ7KkiHX3EHn17T=d6LX_X5i3bg@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 18 Oct 2025 11:28:11 -0400
X-Gm-Features: AS18NWC5SixWaTv6tISYyRfabBu0M2TA5NSlq-EJV7berBAV8wLpo3xmXCWe7Kw
Message-ID: <CA+CK2bA=g3r7V92NCYZDWNKPguCM5EYdroqHxEH2YxUy68iDyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

> > Can't we check this in __kho_preseve_order() and not duplicate the code?
>
> Yes, that is possible, I will move it in the next version.

Actually, I decided against this. The check might be expensive
depending on how sparse scratch area. Why make it even more expensive
for kho_preserve_pages() case, which might be calling
__kho_preserve_order() multiple times.

Pasha

