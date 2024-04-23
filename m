Return-Path: <linux-kselftest+bounces-8736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063298AFC68
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 01:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992C41F2457D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 23:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45B436AF8;
	Tue, 23 Apr 2024 23:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYav0RG9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584D41C6BE
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 23:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713913671; cv=none; b=IDZQAMwLu7y8SKESlbb8NNvLx7s/I0Mcvaxm4Iqy/J1bKKBszJY6Jfp+0ux4r7tmsOXwu7n39kx/VJNrActMpjDUctC27Pq1uczsH6td7opdRb9uj8aCl4KlxpkwGP2n+0/4keAPDo8pkN7Sl9Dxca2tMmjBrvrs+IL8UeFRZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713913671; c=relaxed/simple;
	bh=MSNOE7gPgC9Ud0f301TpFHsZv/rQ4tE4+iv+cPiWSf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NmoY1zba7t7f94SSZ1zQz3NwV49uXzAljbi0DUV2Cvqx7QE0hJ89DV4xGrwaqk3FrMwlZoBW/ZtlK0Z0ZHfQvCcSBCWY0r2Jw4oHG1TurIzR+AZH0cRwcmNpkcbQcU1Nc9L9wAfRvgeRGj/oq6ZNOc6LZkrs/eU6khljoC9SdkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYav0RG9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de465caa098so10654019276.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 16:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713913669; x=1714518469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5GByxvwHzR1ChJVzqHhXcXNtT/rzjAkoACUPb7chQc=;
        b=oYav0RG9af/+LyP59JH2Se8lWyi0ph/PE0gJoi+WdlA9CPZj3l0Iejv6V7JZMOv4T7
         OKFClmm+pPsHUu/RcAq6naq8hGpUz5KPWZqN8ZWBCQ7TYHzqT5DVwiaLBREc7QFi/Up5
         jlhIct9HQfIOblL4qESYOm65lhkKyO6gcujbENw+KxtTFfBFX5pJ5N0XjduHnThD46m0
         OKi+ZlV4tZ/3sIKLkD1GQwqE48BOKOCaCCzI2o7lUG5RlULGJd3ZC2x7erm8A9nu6qfO
         m/oPp6AB9Nc2nYvaleChMW7uLGcUNzKJiyuYsXnEDDBgsm3D8P1NcQCC4pXoZi41OGXl
         QfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713913669; x=1714518469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5GByxvwHzR1ChJVzqHhXcXNtT/rzjAkoACUPb7chQc=;
        b=h+1yTITjLZfj4iVZEgVw+7VnjuIOkeRUTIF7gnY79w1n/kxkO4WMOg9U+wk3CP7V2P
         arJ2mX7OypWuK2SBak1lYr+hVpT1bDzs0Na0zUHxYAdugNCdrKgaLQcWDXi+2FhJvjjU
         NBujnmW5++yNGuLs3LDpGP6lZaGEAou2sDdqFH1jwCd6Fdi0WRtm1vV1/lM//baWX1KL
         eEVSlGEa9yolAofntfdhwOfkYiM2O9LHLVIml/hw3Rnc8c4yUugHCOCmmPsI8aRi3x7l
         ZqHvcrHuDIsUcW/mmw0c9AOtWTIPjvcGT72geCW2dUwx9/RUy99VqK+FvqzMoRU8dvZB
         eWNA==
X-Forwarded-Encrypted: i=1; AJvYcCVCltqV52OLuUrQigStmbeJM3jtMBDpNwXfQykLAK1almYbxhk7UGAgF3jc8fdr/k0xuDAosCQuz/GiU2PShJuB6WFaYKY1bY1+Li6y/9nx
X-Gm-Message-State: AOJu0YydCeULkJ18HDy+7Puy0SQu9OjffU6MX3s7IC72qzcjawAw+yG4
	PHaJcvPsbYdx1F6FWDigw5I48DduDZUGaH4+C6XA/dbqjx9iIiSGGjmiRY1tGlYcSt58AM0rtrM
	dvQ==
X-Google-Smtp-Source: AGHT+IEMzQ5NpZ9F7fh5S/dQMiJZwtjwYDCo8RyHNY9ZyHZEScorWkQY/Nqb5hbhSVQqm/AUDrQqxaYh3/w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:706:b0:dbe:30cd:8fcb with SMTP id
 k6-20020a056902070600b00dbe30cd8fcbmr134539ybt.0.1713913669469; Tue, 23 Apr
 2024 16:07:49 -0700 (PDT)
Date: Tue, 23 Apr 2024 16:07:47 -0700
In-Reply-To: <20240409133959.2888018-2-pgonda@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409133959.2888018-1-pgonda@google.com> <20240409133959.2888018-2-pgonda@google.com>
Message-ID: <Zig_QyOeB3I70E2Q@google.com>
Subject: Re: [PATCH 1/6] Add GHCB with setters and getters
From: Sean Christopherson <seanjc@google.com>
To: Peter Gonda <pgonda@google.com>
Cc: linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 09, 2024, Peter Gonda wrote:
> Move the GHCB definitions from svm.h to the tools/ copy. This allows the
> SEV-ES selftest to use GHCBs which are required for non-trival VMs to
> paravirtualize NonAutomaticExits (NAEs) when SEV-ES is enabled. GHCB
> getters/setters have a warning with address-of-packed-member, so removed
> this using the CFLAGS.

Just for paranoia, I would put the -Wno-address-of-packed-member in a separate
patch.  And to make life easier for us paranoid folks, call out that the kernel
builds with -Wno-address-of-packed-member by default for *all* architectures,
thanks to this line in scripts/Makefile.extrawarn:

  KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)

And for good reason, that's a darn stupid warning for the kernel.

