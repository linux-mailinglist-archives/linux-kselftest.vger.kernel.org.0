Return-Path: <linux-kselftest+bounces-27540-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 896F5A4519C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 01:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C75C19C27FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 00:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C622145FE8;
	Wed, 26 Feb 2025 00:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zlC7O0zx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F0C219FF
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 00:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740530301; cv=none; b=FgFwviM6vuT2BvGZNFsGpit7he8edDHRytnd3y/hsiO32+eoR0iM9eMoCXkgVGw+P6YCkhK5VDu84utzYfbQXeTL+m8qsum5LkwV2gY+7fcpdPBGag2x+OcTAk05GASQsc7ZiEDjHIxJ+ZVb5ajemg18duLf++e2UjaOjoPUIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740530301; c=relaxed/simple;
	bh=98qmeHuxb8kfZLw5go0ikVnX5IuVeWrIvgaBxJXsmBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O6oZ/2eRTo2xiN2TuS0RMY4O8zLv42XOZI0HmXkE2eTY/E5obQrzUejMjc//tJn+MpdI1Mh9jy3am6F2/VNxrb6uaeRht2oxqXg/OGwybNbK+RIkE42yc4BCvEerDoz6QiJpM1zjl3lg3ZTX32NAiVmRJbWLNSgMoLzQJk7QeM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zlC7O0zx; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc43be27f8so20566448a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 16:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740530298; x=1741135098; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yhtOhpsyhbNKeQJImuwdKpcruoCv+uVBV7M0rzTsAqo=;
        b=zlC7O0zx59DAFZPGynsUpEExuW7qIVVVfiQjR2OaA9HOyKY6Ol35giCWuFra7kuHJU
         hkW/6xkgwOFNP+Qwlc1nUxuNbDaEHhZcf6T3zZdJbXS3wTFOA1u8yfDemqXcjgOoginY
         WjGHb3WjTV+Z0J1pyjcDa8PktQLp5ZTIfs1+LdPJSQJDp+bE/zc60WatDGNbbi3vslJh
         vwsKrYD5Fv+QC9h6mhSvrteRR3keUJcKVxHr5cy2qZNk6oGRJMyeeyOMcR3QOBzWasFI
         o87Nih34LxIdOQ6pXw60p15DvE8/DGzrMCz94M8g6Xg5R3lZpgZI2KJjNSE4XjxWm0jA
         p6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740530298; x=1741135098;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yhtOhpsyhbNKeQJImuwdKpcruoCv+uVBV7M0rzTsAqo=;
        b=UItn1jILvn/GE9WTENHRW+S7jYEJ206IzbnXNs65C1/TFNBnjvlx10DG+onimJM8qX
         CRGfgQZNWb/UXagb5hgkd2VLPT9Ogh2Xe1wyRrwWY/nPcF+TRjFMpiGDWW15hRj1Tg+B
         DA90ipiDutOkyD4kHWtN35GnIx9nj951RZWq8ZS9x5VEzX2nsIw08km06lz0nZ3xq/dI
         OUTBdSYGNint2r+1iSWtoqVFgkzBHbKi6VCZJU3caDGXYk13RFuKcscyW83gn6fEkgTs
         jAbpw3MjrfB4bMOHb7vZWtpsGyczqYVUwmsnVsdmYIfhMpCz9t7GpUeRCw1csGEImTDu
         RzXg==
X-Forwarded-Encrypted: i=1; AJvYcCUkZNYaGIbAEmftcy/p3njUUxa7UqMXlNxxUzxvbWDA31zoPkv067qlIXUHw8K+IVfsYgE9pqV29RnywQsuMgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykxW9+afz9IG1oP2X6DFfTqx0J3kFI12oGxkPIz7cFtOV22d3t
	+cIjdq7HHQw1BPz1r1bgiOLrD9EPvglSrAANs3oRhKRDS23UWnryxkAPJG3xIDr6PTSLVlv8oJe
	apA==
X-Google-Smtp-Source: AGHT+IHC1eUdH6w7RjlDG4zAxVr4I3LM4m2Ye/XQ5yW5Z/A6BJVF+fnZnmY1FqR7/bd15OP7K5YZ4bIV1J8=
X-Received: from pjbsw3.prod.google.com ([2002:a17:90b:2c83:b0:2fa:15aa:4d2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:54cd:b0:2f2:8bdd:cd8b
 with SMTP id 98e67ed59e1d1-2fe7e3b1756mr2196568a91.29.1740530297782; Tue, 25
 Feb 2025 16:38:17 -0800 (PST)
Date: Tue, 25 Feb 2025 16:38:16 -0800
In-Reply-To: <20250128124812.7324-4-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250128124812.7324-1-manali.shukla@amd.com> <20250128124812.7324-4-manali.shukla@amd.com>
Message-ID: <Z75iePyU3PK01oG7@google.com>
Subject: Re: [PATCH v6 3/3] KVM: selftests: Add self IPI HLT test
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de, babu.moger@amd.com, 
	neeraj.upadhyay@amd.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Jan 28, 2025, Manali Shukla wrote:
> +	if (kvm_cpu_has(X86_FEATURE_IDLE_HLT))

Well, shoot.  I gave you bad input, and we're stuck.

this_cpu_has() isn't correct, because the part of my previous feedback about
needing to check *KVM* support was 100% correct.  But kvm_cpu_has() isn't right
either, because that checks what KVM supports exposing to the guest, not what
KVM itself supports/uses.  E.g. even if we add full nested support, the test would
fail if nested=0 due to KVM not "supporting" Idle HLT despite using it under the
hood.

The lack of a way for KVM to communicate support to the user has come up in the
past, e.g. in discussion around /proc/cpuinfo.  Sadly, AFAIK there are no (good)
ideas on what that should look like.

For now, I'll just skip this patch, even though doing so makes me quite sad.

