Return-Path: <linux-kselftest+bounces-44145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8933AC11E6F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 23:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6F5580510
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 22:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35C9332ECD;
	Mon, 27 Oct 2025 22:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUievGYk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D8334370
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605090; cv=none; b=cwv8vVxUuzw0Dv3NgQqF55gLOhIpNHfzP2Uuro7St2x9oAK8468c3t8URmRKu6cXjZZfQqYx1w2iwMJruLJswVXBXcoU36q3sN+kd4rUp3f4aHakdsHNLtiko4MDDuws+bCB6tOOEaictl9lfEBYn1LKIXKLefb/lOGh+i1fRs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605090; c=relaxed/simple;
	bh=mpFgcIdHbFI/F7QbErGEpVQ+1+4Natrjp8cskIzQExM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFXCMgNEf06I78dOwKJHOeDn3jqlHo8JpH2J8DLf5eMfhUHCFy+xTDNvnB3G7EZT11OGS54cQ6IJ0xf/f+y09yuhuPICEbPn6y+mm0y4R/zQseIGTS7JYZjXHRCq6twcL38JOblnU+izzchL3AVSuaZTkAllMAik4GR0maPrj4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XUievGYk; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5db24071011so5716608137.1
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 15:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761605088; x=1762209888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpFgcIdHbFI/F7QbErGEpVQ+1+4Natrjp8cskIzQExM=;
        b=XUievGYkrGiE0sHUbJ8sPRwbOntBSBv59mlf82qg0knx8X5xWKiHUX4tHaMAOZOWq+
         TfwspFMAjCcc461Ao9h4L7bYStuX24aqWk0rNTV+pkKiAXz6RdIMOPf8Aee7aps1Q2IV
         njKTn4GkidWb3hNKU/XzO1TcqPTxWvTteSuKMvFnNrJMOqdQSyWrT+clT5bagXLHbNx3
         1xcNUleY/4yZC+7gjuMv4zHMb4mQUdOyccXwBREztFu/dsJsH43n6hHOqpySQPf1tOJ7
         AjsSb2qOUwOk9Ny+ScBSYkuPUWENytx2irXYLonqdozL7zq4b+E0aRH56gF86Xt0jAFp
         fFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761605088; x=1762209888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpFgcIdHbFI/F7QbErGEpVQ+1+4Natrjp8cskIzQExM=;
        b=QFKXLUL0W/YqhKgIzFA8IvwSdMZ4BcxibhrqKMevZ6Ubt1rzZmkyLU0GO5THyd9OK6
         tmLDPgr0tsSM6Yucdw3ZTxx9sACm6vq7chKWZ6lfiqbpUMnkW2vVUh+RMiOjWeUdbyZp
         aIoyBNZLMrCTRQiaoaGyaBivb09VYD5X+j23dXNatO1jV65lo6jrbKP+BNF7mtn+FdnQ
         PG+1PA7XytsF9EOIMSlNqjsMKedFRo8/EBXZFmzAhtQ6FWopYCThRhwL2Cl/k8OZ//ut
         Nn0PxBSYAt34ROtb1NlrkoMmljTwZpy7JAQ2W2q/HhmAuQOdWTnUxN8GlSWxKrch7+ov
         QDYg==
X-Forwarded-Encrypted: i=1; AJvYcCXNLebtY7rXrPfa4sNa203vUo0xRr9c6nI/MocC02y0P1Au1xbBqsjZOPltgl6kZsPCrBRdWpoDX85ba0kKv1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxyyKFB3kfv5Hihgq2coPuW5Q+jNycNnUr5PswAk9UVM+/56Ie
	Y8oWiwMjeQPH1SEE/XlupBTw9L+7czMKS8ZEnkhEdomp3QBfcQgpZEbVb+wAQqWxcZHj+IOspw2
	NMqAP7Ukf1FwQ9/O38b46UICoe2fuDsD1Nzv+mYUj
X-Gm-Gg: ASbGncszCU99FBxBlXUuHY7S0ZTrslm2Yf9YtXDFDXFsLbP2ot9GO3LdPtP0qghBwAD
	LQC5ci2SxpToMUuROujYMx9SEyx1fCl/x0KNrvvMzdBJRy5txSiM702ZKkiIPsLTOpr0FBCP6g5
	x1UfGrGcIvNrpCGPKTaiCkZtvUbqjCe8YSKOxDBiqBZzSZmgy/F6699gFlzRxNvlGjawcUnM/oN
	O8VZOdJ6tJkAqaHZteUZdPSLqIT40GEMFbiQVJCjEtamPC/xbTX0oCYrqNYDVxholbiAQU=
X-Google-Smtp-Source: AGHT+IG8Ejwp50BSLB3roZMqzNKK3fdMxgSprm5enFcaaSJHsvTJPOSCN+WzTYJlIeeVTdHuRCAFpYySmA/1mTyvWxw=
X-Received: by 2002:a05:6102:458f:b0:5cd:e513:384d with SMTP id
 ada2fe7eead31-5db7ddfd811mr330196137.0.1761605087687; Mon, 27 Oct 2025
 15:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com> <20251021000852.2924827-3-pasha.tatashin@soleen.com>
In-Reply-To: <20251021000852.2924827-3-pasha.tatashin@soleen.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 27 Oct 2025 15:44:19 -0700
X-Gm-Features: AWmQ_bm9flIwjCIEktZFbqFsVLPTvjpFwWRND4pJrUQRYbrA52ouzPHjdJgenhI
Message-ID: <CALzav=cprjK-WutXYKii28e37R=F7jPZfA5_=_Qh4HH5p2Um=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org, jasonmiu@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 5:09=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> KHO memory preservation metadata is preserved in 512 byte chunks which
> requires their allocation from slab allocator. Slabs are not safe to be
> used with KHO because of kfence, and because partial slabs may lead
> leaks to the next kernel. Change the size to be PAGE_SIZE.

> -#define PRESERVE_BITS (512 * 8)
> +#define PRESERVE_BITS (PAGE_SIZE * 8)

nit: A comment somewhere (maybe here?) about the requirement that KHO
metadata are not stored on slabs would be helpful to avoid someone
"optimizing" this back to 512 in the future.

