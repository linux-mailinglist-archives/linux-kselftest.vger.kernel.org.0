Return-Path: <linux-kselftest+bounces-35712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62001AE6FFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 21:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C5137A893E
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 19:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8062F002C;
	Tue, 24 Jun 2025 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JwT4FBKB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4720A2EFDA6
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794139; cv=none; b=Yrqza0mmDiQFHBVUmlstKzxrygQ+PfUCoKLp7W8RRCKGdSBOlQr76EPSTuPHmsZQ6GYQXGUlBsf+DPn6SShWGgUcKDezv3klFlpYf8d2FK32QEJzJ90J9aTR/SzxTJW908C25UCk3TcrRaI/rSPwDcHnB3cHNYD2Ugej6Ya3KbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794139; c=relaxed/simple;
	bh=7WnHnjZ2Inj8vNFPOPMWn5vUT1QywHWs7gt7IcDZPtY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MDSx5idOmmSq2Fi2OI9XnjVGeXuLieAnEoskEdmjEffFXqqDw3BeDoO4n8im1XmXKV5Z4IoCk1vVRR8N5PEV+d6Ey4CdrhwS8PEMjyDkA3ILTlst0ZNm8l3gIe0xTFxILQ1S2umCju+s1I757JRHnJ/OQ8sOEcGMWtLDlrMd3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JwT4FBKB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311ae2b6647so732786a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 12:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750794138; x=1751398938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eiZv+Ux8bnoIxxwKrwVqiL0FOPFJvedVqWOdvOf0LcA=;
        b=JwT4FBKB36u+z9iIrpd2CTptQ40I90Qt+oY7IoccOVgCFZUIQYqi1QMwzVSEH6AbRs
         f4Qe2Dor0nWsqwFOH9EPaiBXrCFW7VcQvWiB8bMMqgF5ycIp49m8SJuoKHmJgPlisBNm
         YsX+LBhAVnxDFgc2dPsSvpCrTCsiLBUK2PMf1OPtYmnQFntHolTK6ylJyr5534JobOA8
         nSmxMdMVqOUIs3GCfxaeyO3DP9jeGK4LBc1ZoAtqMMwHla5xwS9C/ed/w/F4qy1Ybizk
         uq3cfVkj67rIkRbhebAronl0XkAL7AdXSJ9Txyss4Q51iuTOj2CdBm/RnsXXh/tFrs7g
         1ESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750794138; x=1751398938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiZv+Ux8bnoIxxwKrwVqiL0FOPFJvedVqWOdvOf0LcA=;
        b=iUbwzmqRZQWLYryQRpxX/PgIexKDYtzyJJN8osescQx3r3qXF/j3xOdkbsZaRSfdqr
         PJuR150LuH2gNmxwdT7Sh+qSl228sWx0wD2zNkYh6Hh9EspOxR0FpOGQP7tB4NbbaytT
         RjfFVA03G7L6Ckq2xXeUivXQJreVcNpXcp2ykqJRJun5ibohSUEzxfToUqAdu7mjZTtj
         Czg2dlBrcy2dp3IyhPDDoVfpfqoAJO0F9yb0hDW2KR2fSPg8Ydbhr7troiOqtAllywPg
         VRrIJOc+yPGIgye3jjwyEh5nTZNrkBDoZNBa05Vg8KOHbExq9bJu9ztIo67h7kPftKEv
         xlWA==
X-Forwarded-Encrypted: i=1; AJvYcCWOc8YdgkqtfjnGNWrG5TZLu/8Cacqk+rzd4l6CabfVCrQOVCFFGyBylJ0KIUAzLk1Lf7MwGWqYsaSHn1RvD5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27iMa3nzwU/Qmmgc5TCpDL5ew+mgJuLIahgAiZhUBuGaufuoj
	D+V3618GR1NZAQMwIy6IfakJ6CcZ58tvxsLz+yvIELDroRNKrl7FAZeR+nzXK82RvWWlC9sqniJ
	sE/fedQ==
X-Google-Smtp-Source: AGHT+IECMFlbef6lDHwuSpgtWmzJM6Kenqel0iDDnhehUo2TFEdmq9e7oOv+NFpDNFQ4sz1U43MsG6xhPwc=
X-Received: from pjboe18.prod.google.com ([2002:a17:90b:3952:b0:312:f88d:25f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5626:b0:312:1dc9:9f67
 with SMTP id 98e67ed59e1d1-315f26132bcmr173645a91.2.1750794137714; Tue, 24
 Jun 2025 12:42:17 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:38:41 -0700
In-Reply-To: <20250523181606.568320-1-rk0006818@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523181606.568320-1-rk0006818@gmail.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <175079223746.515152.1077822979652127877.b4-ty@google.com>
Subject: Re: [PATCH] selftests: kvm: Fix spelling of 'occurrences' in
 sparsebit.c comments
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, skhan@linuxfoundation.org, 
	Rahul Kumar <rk0006818@gmail.com>
Cc: pbonzini@redhat.com, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Fri, 23 May 2025 23:43:52 +0530, Rahul Kumar wrote:
> Corrected two instances of the misspelled word 'occurences' to
> 'occurrences' in comments explaining node invariants in sparsebit.c.
> These comments describe core behavior of the data structure and
> should be clear.
 

Applied to kvm-x86 selftests, thanks!

[1/1] selftests: kvm: Fix spelling of 'occurrences' in sparsebit.c comments
      https://github.com/kvm-x86/linux/commit/30142a93b164

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next

