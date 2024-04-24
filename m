Return-Path: <linux-kselftest+bounces-8811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB2C8B1444
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 22:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7177D1C2222E
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 20:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2983F142916;
	Wed, 24 Apr 2024 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LiBseNzM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57481428EA
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989633; cv=none; b=OepdrB6UWONYKagFksw07c9XogiDjlQhJhj1/pz65v0OWm4ut0CfYskuHPL82FjfAqkg39+D+pIG3+e5HIWRXW/wisdgyli+PSXI5v/lVvnGTBPRITU9Z+z2j3rfCZNy7befZX16x45O1T1xn/+LtSmKER1ex9ygKnmShpe1Z6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989633; c=relaxed/simple;
	bh=ASuoZZgHctVFrA5qjzXFbczbyWL4m9fk3dUFVVw8qdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vFXA9jnWcg2j1biK5N0uzEYs3eMSwmP/or3ya3jJU/DIhYOH3Pi+Afnbgknyba0SrXI5PDQQ46OsOc7mYz4bY7feKrOry6F40340+RSjsCIkc591FTytWDPeHTzD/V/kgVCtij8x4JhZXYoqI7wSRCHCPo9XUVSkVzc80J8kES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LiBseNzM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-618596c23b4so4013867b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 13:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713989631; x=1714594431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kE8OuYsfUCESTgdrzuGuZRqCT/StXQ3hLmK/0rboegc=;
        b=LiBseNzMnYZprAfGgh/SUE+C/5LhGzxNCzrJhcu2uBhwRAzUmTOPPaLvKrXolDqHPl
         Xg+ZcooNxX5DCvSxbDN2KfU/Kexemagf7P2ni5GXJeLDav5NSa85dv7YYu/0pQ1j4dOG
         FuToY+slSObJ/MYzBzVNOubcCsFyPKSDcc9fN+tNHhaqCRuGtauAhp0oTVzZwAs16dyV
         lL2bofnk+7B+Ih/7FNFUVpIroxErw9wAJhFBe0UPa5+rPcVx6hRTuKeUlju7qtQV8Jnq
         rAdQGAxY6MwbWYDyQaA2FYIlIoEpT6zps5kIxlSXXpEjzq3GiOIFCEw0Xwqem8Q8xSLd
         eqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713989631; x=1714594431;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kE8OuYsfUCESTgdrzuGuZRqCT/StXQ3hLmK/0rboegc=;
        b=B40i4IJWUoBX8leQ7vGYVuUB+XStRZGLOXnH1m5RRxb6FFGmD98VDtKayQ13v+u+l3
         Pkln3iv6oH90gQ5u2a4Gy4yHFP8ncCgqX9iBFeviCxcpmDH+mCI5suyWAzAxOfP3WR9X
         WDHKoBtnoAbZzoWdI2/xs7NT8kzNX3Nu4EhFvQJXw568IOC4bAIdqcY7/afj4Akxa84G
         1M5qAlT4Krgc/BtMOOwqNUPPW5FufRxguyhYJJYWro0xKkVmmNuR+7qnt1o9YyrvJMi4
         anhqqL9hRcn330QwA+aPGdmOCtNzHiUe9T1LsdbHzdbJYAFs0wJQURfHPT+QEJu4nHco
         P35Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7NxFYOOHdNfofFnOo9IIzWljQJpyjIHABUNf9vySXWDAhTxx2A038k6xrEsr/DDkc5MIlNsRCR5njU8XY732wULL9cRjINAaOixDqM/3s
X-Gm-Message-State: AOJu0YxEUIBesUlW0qls74fn1k9IVyMD4F9xu5VrvTO5HKJ41tF5dk8p
	ZAqaGZDIAwN1QxvKpD12Fiss5gtAo+QBvednCSCln6r6whL/vduolQvPZuVdlVlOmhn41zFFejD
	mkA==
X-Google-Smtp-Source: AGHT+IFwb/d+5gTCSXFtCzoG+k7UNeHOqkw9jquiZ+7SlUexVJagTvBBymY8FJeyqRdGUC/cduQZwjBHeyE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d48c:0:b0:61a:d0d2:b31 with SMTP id
 w134-20020a0dd48c000000b0061ad0d20b31mr692742ywd.3.1713989630884; Wed, 24 Apr
 2024 13:13:50 -0700 (PDT)
Date: Wed, 24 Apr 2024 13:13:49 -0700
In-Reply-To: <ZihZOygvuDs1wIrh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409133959.2888018-1-pgonda@google.com> <20240409133959.2888018-5-pgonda@google.com>
 <ZihZOygvuDs1wIrh@google.com>
Message-ID: <Ziln_Spd6KtgVqkr@google.com>
Subject: Re: [PATCH 4/6] Add GHCB allocations and helpers
From: Sean Christopherson <seanjc@google.com>
To: Peter Gonda <pgonda@google.com>
Cc: linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 23, 2024, Sean Christopherson wrote:
> Oof, and doesn't SNP support effectively *require* version 2?  I.e. shouldn't
> the KVM patch[*] that adds support for the AP reset MSR protocol bump the version?
> The GHCB spec very cleary states that that's v2+.

Ah, the SNP series does bump the max version one patch later, presumably after all
mandatory features for v2 are implemented.

