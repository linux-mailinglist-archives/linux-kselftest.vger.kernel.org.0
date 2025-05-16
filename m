Return-Path: <linux-kselftest+bounces-33207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 853EBABA357
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 21:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7382C3ACE43
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 19:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7361825A626;
	Fri, 16 May 2025 19:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z3mQEZHe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBAE1C84BB
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747422068; cv=none; b=cFHKzlGYQOigJ54qBgTm975YHQIom1txXgF3EDVg8QnJ6kUPcaIWuebG4zkT/ce+5vOyfkCwz2tYQt9F4lAEujDZGZ2aJnDlE38r3uOnh7GLr2EzLdZSvSEMkujAj4cOz7sTBKDpkwwZJfoY7oel1VPv+xs48t/uiXbEx7sYxyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747422068; c=relaxed/simple;
	bh=qC3DySGavYdM1gp51COEAUevGFvFYkWB6dkpAsvo4fs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Of1BaBTlQ2Z4JCnf6yp10xPYrhXP3GGowC1lEMylomme+K6v15B4qM28lE1VYNfxZPJTubuFgMEPlWKEkXJ+o+YzsfhebLbq0+FfaoIWSuP0qSvb5HORTPMBBfeoayJDnIFEhGTiM62U2ZpSRWmG0ihUgvNv1RPaH16QU/V6X9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z3mQEZHe; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b26e120e300so1886867a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747422066; x=1748026866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l03l6WAXX/LhIyJPAqbC3aJadb1oC5rN29Okat377Fk=;
        b=z3mQEZHeWchA/mPSrjYyMI0ZXTIwyS00ejlFhfzqmS+2Kqd4MSV4f7XEpOFjoDG4BE
         zMqc4zDZHyWAOZwGXK5FLa+DeJqGvEeAm1yweQQp9FAXMIfTBZ+GCxYsW/RzwpE36IpY
         g/MqG5dQuSvzo7ppn8thWnpoeQt5LYUBcwCHCd7gU5kby/h4VixfAqQQ+ZfmBD9nBgs2
         45xYiaiAwY5yoswEBlEjfbtWIdYt853j3h4joowYXRgL3BadbJ5jgQ+8XpWzyZRk+8YD
         QK/Miw11RcOf/9nstbjeUWs0tlMKxMBMCEiaa4DlhFKmNVhcjLCUEP1BnyQqmZRkL124
         SkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747422066; x=1748026866;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l03l6WAXX/LhIyJPAqbC3aJadb1oC5rN29Okat377Fk=;
        b=v2MC1M2tj0H/eDKHJ1zijNBpkYMoj3ehWZGoRpAN+7Q0w7menE3VTgDmTOacfUmIo3
         yWDDEOm6z0QWpazpkn+CESx7NbostC4Ndh8LHkJE0ur+BQfOKtx36f7gLGrv9ZtHIS14
         7rIYp4swpwad38AXTpzjlLnK23GuDJ6VwXElt7wKKvdBh3Mq7/B2wDEYlq9r318wBUCm
         ch8rAwxhXOdrjtRqy2BjoavsDnekXj94o70X8aVEQVstuO4mlj2u2ui1hAORdq2R4BWB
         TtnLqDFaGwGOQDWLBHVJlIdndtbzg/TgBU6A+E9pqkIUzHGIhkZCF5TO2BBnfU8OJa5x
         SROw==
X-Forwarded-Encrypted: i=1; AJvYcCV8lxnZR5VtsAaAK1qHJz5ej15NzLdrKxZ4FsPd3JPnS3pkmcuJiMhKjdm4DT3shxoWlmQTnO2QnQ4TN0/GGhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAEE05S7OaKkmuKUthFU3oxYfHvgIhrqSNdR84ak49gi4+MmPa
	GWfuvH9Fl4mkymdbMw1PE3Ug14P8GxleDhYIetZlQhIFcne67242zPUlSxLquJKnYag01P6gcs6
	0pLCLfg==
X-Google-Smtp-Source: AGHT+IGuyh+gje9Nj5ODCvBHqouM1rSCaTnxSIxRivi0pPmXrRCdJfKPooGeMeoUoVXCg76LqXmgGy6xhes=
X-Received: from pgki5.prod.google.com ([2002:a63:e445:0:b0:b1f:f1ba:8ab0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d1f:b0:215:e1cc:6350
 with SMTP id adf61e73a8af0-216218a2de9mr6333388637.16.1747422066251; Fri, 16
 May 2025 12:01:06 -0700 (PDT)
Date: Fri, 16 May 2025 12:01:04 -0700
In-Reply-To: <ff1f0e75-a13c-4f6f-82db-94dc600d6367@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250502050346.14274-1-manali.shukla@amd.com> <ff1f0e75-a13c-4f6f-82db-94dc600d6367@amd.com>
Message-ID: <aCeLcLiioNJYXhRh@google.com>
Subject: Re: [PATCH v5 0/5] Add support for the Bus Lock Threshold
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	nikunj@amd.com, bp@alien8.de
Content-Type: text/plain; charset="us-ascii"

On Mon, May 12, 2025, Manali Shukla wrote:
> A gentle reminder to review patches

(a) Trim your replies.

(b) Don't do whatever you did that generated 8 bajillion "prerequisite-patch-id"
    lines, which causes b4 to barf.

