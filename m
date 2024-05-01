Return-Path: <linux-kselftest+bounces-9217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68028B8D40
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 17:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135481C20EAF
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2024 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852B21369B0;
	Wed,  1 May 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjfwGqem"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA9131183
	for <linux-kselftest@vger.kernel.org>; Wed,  1 May 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577545; cv=none; b=WLQJtP4EfI3pIASJoqLEXPyErLw+wXQzSFUSzQYCR/Uo/aque3iULpKcRNdwW3aYfXGsWt4kO8KDskJP04qoCPR17iwBGHzwfWt3wsTV06PfdQjxMftrxoCLM3Ps+YO2ribzfGVTRy8fW/TLjb7b5wUbt7gPo6NceIBYs/oUcuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577545; c=relaxed/simple;
	bh=sS/Ds+TGWZJDuajysIcuxrxMIQz9ITXjbTWV1mvqOhU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ASdhZcTgGUL7Ej9TYMmZxazoTCQ0GKVhFyczMJb1FU2e8CXOkPhDmwEMhRfF0AqZNaLsf6QLk9mfWkXgkQ1BQVgmzHie2HIIpopPxXltNv0MTHlEmQfZjt4EKxeFiv4ALUHsisKhuw3P4IRlAy8Uv0uuiezLO55vA1shNEIEWf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pjfwGqem; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61510f72bb3so141339817b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 01 May 2024 08:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714577543; x=1715182343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QjOVUNbE+n9Mx6ySgekhkLay8zaGJMb1OCzWxZRzbj0=;
        b=pjfwGqem68w8vrGzx24DrbYK9dHTAe1vg/2XKj6de7OhjATd9CdwWve40mFSeTQvjj
         EYUVg3IpnxqNN9CyQftY9dNAEjpvKlVEgMxM4xxk+o9HHZBD1LyCZCuOMR8fxkoRyEIZ
         vpfxIfGkcAc7qfpfaNQWC75HMmoD94YTa/pn2tA85fYEWFNMeQDYlDqqTppeyw1hGOGR
         MpXnmbFTdBmQSBdBOE4KUIxjHlxX2QdIatuNUZw1myxVCKhOIkrjgl18Bvx18jbBisyR
         bbZsl/tZ7/bcr/SMcxw69SXnsI+OAZKz6qDHOgMO9YD+uHP+ZNXSi6bGtp/JyCO6e8tS
         8QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714577543; x=1715182343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjOVUNbE+n9Mx6ySgekhkLay8zaGJMb1OCzWxZRzbj0=;
        b=aDpE1kDk4GhRitO9ToOgLTLOtxAgHZT1eXST/mDjy081Mc8JzTie65lEV8m1p2nSyw
         q1g+Vl+w2kU+uby2d0EakicTPfF90HU2DjcMbkBUr3ex9b02EveSOw6e2VAqBLNh36vP
         dzxvYqAUkFncnnBagtD9FO55DBzZphXJkYba3wVpdOwAxvxbTOSvqw/l2Xt/y6t1gCrA
         mGgVu9AcVwVtg0mcKmJP32CnEZMiAeazqwXC5sAQWtDCJQt7yxKPtIhVqs+VvFc5Vu/7
         tazDtLtzO2KISNn/4yYGCzERqnusFlbRRfgSpaBUT/41oWAhDFc1gPD4t37HG6aOg3T9
         6HFw==
X-Forwarded-Encrypted: i=1; AJvYcCWIgWYU3eQUC2GZN0HykW44+zPi49i2ULKbcjIdzGw/KlKml/yeXIrSkNZ17B/Kz5sD8mYGdXqQNSMnbl0AMwhqpovSwS7zMvD3MbWWCgVp
X-Gm-Message-State: AOJu0YzpfmwMYQpwdJrOxiZ06nbcLXn2+gislpm+qETY8zYuzOz03Ytg
	5gs/EqxnvcBCzCJPJ9En7vN0m8+H58lranRJqceK2Kr+kgSL7wmx6bU9v0wG11wxENC79p3UPtY
	69g==
X-Google-Smtp-Source: AGHT+IEUrK9B5li09/DlBkhyeuldaNGLhx1Nwt6nbq7jyGTAM0EY7bW5sKCWTRRGWyyzfmiGvzpaUOoF2C4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:bb45:0:b0:61b:e6d8:1c01 with SMTP id
 a5-20020a81bb45000000b0061be6d81c01mr733119ywl.10.1714577543025; Wed, 01 May
 2024 08:32:23 -0700 (PDT)
Date: Wed, 1 May 2024 15:32:21 +0000
In-Reply-To: <20240501152451.4458-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240501152451.4458-1-manali.shukla@amd.com>
Message-ID: <ZjJghQ25H-ttaV4b@google.com>
Subject: Re: [PATCH] KVM: selftest: Add family and model check for zen4 in PMU
 filter test
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com
Content-Type: text/plain; charset="us-ascii"

On Wed, May 01, 2024, Manali Shukla wrote:
> PMU event filter test fails on zen4 architecture because of
> unavailability of family and model check for zen4 in use_amd_pmu().
> So, add family and model check for zen4 architecture in use_amd_pmu().

Is there a less ugly way to detect that 0xc2,0 == "branch instructions retired"?
E.g. can we instead check for v2 PMU support, or are there no guarantees going
forward?  Pivoting on FMS is so painful :-(

