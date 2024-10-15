Return-Path: <linux-kselftest+bounces-19773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755A699F4F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 20:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1254B22CAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 18:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C1D1FAF13;
	Tue, 15 Oct 2024 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bPon/+CV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA68614E
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016143; cv=none; b=EZG9Wx3dpj8+cchkiOmOycHZj0b/MAgoHnNhBXiCc559jROI429gGBbdldMYnCxdjzGEi/+Z4qFKIOt1jycf4rLYsSZ6ebr4MRWIAqxiEJsjmgthuYnYYN6jBPZVH0mrQ6O3Ys2aVbFGTOIJCXmBJeEIBFxH1EM8wkoQCLbqzoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016143; c=relaxed/simple;
	bh=7jVXhg8Ithut01ABxZLBy1RgXQK7zqrguPx+HcH5s8w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hFGJYNrKC5O4hGmDCklEh9nypIoEI14TSZsUVAoTu/OR3fqTkv1dQKoC8xlEw0xzsnkpmD4imBBxV+ZSzMpxe+TMeuL72V7h1htsb6Qzv/KLDRj4pK7t2i+B83Ievr/JDuXClDLg3oLcPD7GKQiJEMASUQUgddO/M6TBSlKqSRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bPon/+CV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e63889587so2284210b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729016141; x=1729620941; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RGeLe7MyJKjs850UnRKPsFVzj5zQMWba4z4Ru+mUwTg=;
        b=bPon/+CVzg09dm4S5ysv8N2zx9PqJlIa8uyPJvdBYnnqWXhhK4cD6GRq8qfDMNpswP
         UK3TjgzUHzkxT5xZHJ3lOOTw9OjSZHZwIL+UwWPMt+tSPPIWydbtOljYBUOKxErs9P9J
         uQg3fk/VUW52t/9uaZVQ67YnHu+aSev7w4LoFK4oSJLLe3TmxjXJFvxwcpELC09eF40m
         ey3t6mTtwjKeUKsG3kHNMMf4xtX7ftTlvlctRWvweA9ZOzwzDMSaflCeYd7n9DQynhQU
         cpEZ2IoMEcTP7U+N/rXk35oB0hNNppPTEWBMRJ3Qu8Lw7qRYuEcnkus5w+27YuZrCNap
         22VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729016141; x=1729620941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGeLe7MyJKjs850UnRKPsFVzj5zQMWba4z4Ru+mUwTg=;
        b=FMACItTC81KOO50gv7WUzDbYEnw4/GFWGCl+qRwJXVwkV8Pl0/9XUfy3lSX32cDjMK
         97X15GMfmrXPu3Q6+uwL2p6RQTx3EIZRYBtUImocjjQVl2zU5PNMreQ5vPJPT3OQcvER
         ot3BaugMNGYTyD3T4dHKR447If2RIxREYh2oYyO7Ew8PHW2zEpXZOhAcHRbUrzP8DYq3
         P01IMZW0dvGmaAmzvl3XJvCrl84GG3DfQTrw1h5WLql+PA+TUo0swGx5Cw1L2TApa0Ac
         UoujMQ3EU00wMDDnjEAKCIMjYvvuXN95MlAGiOSwGbeRoDYU/KpJUB/dSe3vQpy3HqXf
         vXQg==
X-Forwarded-Encrypted: i=1; AJvYcCXlqZLj36pcQ1Y8hJoUilGdRS0GsZOqZ/qqUNyc5nC6N33Bt7QAuNrxEEDPNRa02VW9vgm49ROd5oicOS53LYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+CDZcSx42h43g27I6Lt/9P7Yz75m3XF09NeNBT7PH9md85Vm
	NEjPeGM7qsjbDf9ZEFGOeM8kz4BX7U+Lto41QoLQxsTzNYQ66V+qjVxi3n3OJbqbrHRKsASTUDx
	wJQ==
X-Google-Smtp-Source: AGHT+IGKWdCo7eV9V+mILI4gW6qP8gu4ORKxCsa2y1RAcUSW/0uFZooXe4JyMpgc4Spi9EDGjRDxTUoJmCg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:aa7:8c10:0:b0:71e:5a62:862 with SMTP id
 d2e1a72fcca58-71e7db4d6e9mr3778b3a.3.1729016140224; Tue, 15 Oct 2024 11:15:40
 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:15:38 -0700
In-Reply-To: <20241004053341.5726-4-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004053341.5726-1-manali.shukla@amd.com> <20241004053341.5726-4-manali.shukla@amd.com>
Message-ID: <Zw6xSi3Om2H41fRa@google.com>
Subject: Re: [PATCH v3 3/4] KVM: X86: Add documentation about behavioral
 difference for KVM_EXIT_BUS_LOCK
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de, babu.moger@amd.com
Content-Type: text/plain; charset="us-ascii"

x86 (lowercase 'x')

On Fri, Oct 04, 2024, Manali Shukla wrote:
> Add a note about behavioral difference for KVM_EXIT_X86_BUS_LOCK
> between AMD CPUs and Intel CPUs in KVM_CAP_X86_BUS_LOCK_EXIT
> capability documentation.

This belongs in the previous patch, especially if patch 2 is split into arch
collateral and KVM implementation.  The KVM changes are small enough that I don't
see a reason to separate the documentation from the code.  And there will likely
be enough subtleties to the code that we'll want a bit more documentation.

