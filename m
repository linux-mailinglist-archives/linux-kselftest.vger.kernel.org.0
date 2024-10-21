Return-Path: <linux-kselftest+bounces-20332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DC29A938A
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 00:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31279284236
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 22:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192BC1E3775;
	Mon, 21 Oct 2024 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eQZprm+A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A01C9EBB
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 22:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729551076; cv=none; b=YLoF9ZnEPxrxe2YCoALbi2PArksKPXXOiH+ln3E2MiCNLReubXquA/8ypDmp5no/dvu1m5obf82tHXS2iOhCDcQ3C5rUjZM+FtRhGBAzARJ1xvkTHM6MrZ5ZhnQDLFKKRePK3g6+ArqMhcDeihQwLhBsMyy5tbd/MjU/o6MznBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729551076; c=relaxed/simple;
	bh=lh+egOwPWiT6rlsPd8Qz6EzFrLWfAdtma57sGF21Yeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCMp9zMB7CbHuxiXZwxyIRd3mZzrVexi3Fk9VOlM6cztxTWoF8AP3vPD75llzimBpEikS5HkpmSuF7lrWMU2d2i1lTTR2KoLq6HVdoN+BctED6CY+ifm1qU4wm9RozO/8W2umLfByDPxxmx3Bc0s9quqwJLl54nql2GORJoSBlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eQZprm+A; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a0c40849cso778665966b.3
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 15:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729551072; x=1730155872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AG8PzQqdiYQlkH144tEImcdVURTnmabmXi7XXqqoOAk=;
        b=eQZprm+AA5rZxZIvm8PAjb57LagZbYFCALSNtJ6YkWtEi4CMY4Up0F4CMZO1jWoR86
         tom9LZJuqLp5dmNEa7f/Sz6ZU2cKTav3bGtm/p7kNz0sVDBLkg5XQAb3fbgbfu71GrG6
         ZlfaqatTez1+507TK8zw0D1NKKWBo00isTXuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729551072; x=1730155872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AG8PzQqdiYQlkH144tEImcdVURTnmabmXi7XXqqoOAk=;
        b=wmyvMQX0q85dRlCYs8KcYE7imAiCsSYeNRAxHDrwpX2NUktqScT6N3brBUgi7qUAYo
         A1SCYcGsTpEipebJkSQDkMj7AYi5VzhXOpxbZZ9i4h6yAzcg9ZRn0TTAlZpv0rkU2Z0q
         0QzC1NKBkmQXdnHk7qyyLMNcQAuKuedSr5MuoVB75WvOXSk/paNGzm9bTfcdv9oqiYys
         2fFOADKk13ech4yPHd5YDvKNsKqx8RgEypSPcNz3le6c0gSr5/ixkSTVxOPPPN1s+ORu
         e84vTTkhNrmSmbic6ekJMtIzXFPAZRwfjY1PNo7WTtSyR1txfoAtcjgl677WVXKKdoD8
         gzog==
X-Forwarded-Encrypted: i=1; AJvYcCVeIDqmgkeHIhwTfeATW4oeP2HJYejYMjLzZHyQ57GlQxQ1sELzONXsC+XnpNRalBjFnjnBDDc/Qoctqa1C8r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySuvZyB4ydyx4X3wRSeS5FU8trCXKNerVxjQuBAeipxEgKS8pg
	tYvuz6OEfes4iE6uE263X8CKWZAhV01w7H42s6lP7GMHutT0QqqKlvxPmoBikDq8RqN0UymCkYh
	gp2cJvQ==
X-Google-Smtp-Source: AGHT+IHJ0u/QaKrW8A4tDvLgWipboNz/IxCrR2M77bK5To/znvHiAz/HbiRJe3iHKMKDVW9SGJFdJw==
X-Received: by 2002:a17:907:3182:b0:a9a:3d7f:a8de with SMTP id a640c23a62f3a-a9aa892617dmr156619466b.27.1729551071923;
        Mon, 21 Oct 2024 15:51:11 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912ee157sm259661466b.57.2024.10.21.15.51.11
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 15:51:11 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a0c40849cso778662566b.3
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 15:51:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKGdrBzPG3hfy9aUbcyIbK/5ZipezNCRqpj+qZRkp9pCCAaCkbT4Jkr60YGnW/j6ZrO0AUZh3PTVfRIDuq2OU=@vger.kernel.org
X-Received: by 2002:a17:906:7955:b0:a9a:222f:45bb with SMTP id
 a640c23a62f3a-a9aa892dba8mr141312566b.35.1729551070822; Mon, 21 Oct 2024
 15:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-kvm-build-break-v1-1-625ea60ed7df@kernel.org>
In-Reply-To: <20241021-kvm-build-break-v1-1-625ea60ed7df@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 Oct 2024 15:50:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5OoS9v3h7YOPf2rMFWGfHQUgNrFRJ3NVxJLZDn3qnBQ@mail.gmail.com>
Message-ID: <CAHk-=wi5OoS9v3h7YOPf2rMFWGfHQUgNrFRJ3NVxJLZDn3qnBQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Fix build on on non-x86 architectures
To: Mark Brown <broonie@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 15:16, Mark Brown <broonie@kernel.org> wrote:
>
> Fix this by making the addition of this x86 specific command line flag
> conditional on building for x86.

Applied directly, just to have this silly thing done with.

Thanks,

                Linus

