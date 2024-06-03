Return-Path: <linux-kselftest+bounces-11134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABF08FA56E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 00:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A7E1F25F18
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 22:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E9513C67C;
	Mon,  3 Jun 2024 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3clAKt+c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A17D84D3F
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Jun 2024 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717453040; cv=none; b=uuCH8TjGlQMPgraq4YQY719usPVNd4WDVTJaa9kuh2NgHN5pduA2XAFg4Zqhw7+FUKtWMqYiL0mRwBplv2BnTTBv72HdsUQrvQTUSpeXmPsVC8v1antiJVVkutrwbDLDdFGVQ1nIDnzZqendXxBS7Jdt+DAoL+oEEIvcWBk5ZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717453040; c=relaxed/simple;
	bh=/UlXxhes5QRLTrr9SDQzAvFobSCW8cEFBwgADTpNo10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EADeAkcUSVYA+Z+zYrlHLFetF7wxDig2/froU8cd2QWjoTEQ/Yh4FgJ8G87aWhIIwvw4GRJQwDNW1/kVjYAOdUTNTlX1cCJgJEIoUG14ttSzXzbwAVtPtgncdrQJegnJ3KF533YzFtbnPMSqivmtU0xd6GKtzepuwHTWWrgyAA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3clAKt+c; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dee902341c0so491313276.3
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2024 15:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717453038; x=1718057838; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lTWK+TvN0EB0WUHYF/GtEEl064LANQ6E3omFwaKMPyc=;
        b=3clAKt+ckM56PvpGVHHtjKfxgSSl1l1pzd2jnq3Yp4wz/dGy9xyEVhM+BNFYJhZXtl
         n3LpOgR8eiKtiS/llpV2dLwj/8PEZVdYI9vv6YavRvIPFBe+cK+HS3+Giflw6qRcagAB
         L/1+WwBVq/+4tmRBK43swfWO1OkeSFzvP40LVTKROZc5MpQ6azKc6Z4nGUrilwd3uuVb
         aXN1AVttS7yk6Nw/pG7LLDGHoHE5vnkU5UO6QEIucOGXJApJl0zTye9dfDOC1Tt5mcpb
         C+WsbGYYzaQql/4n6cqSOzg1mVHM/Ni/eiVlYrU2ggty8n0D9bzXrJ+uvOLGVReA9puU
         lPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717453038; x=1718057838;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTWK+TvN0EB0WUHYF/GtEEl064LANQ6E3omFwaKMPyc=;
        b=JsRg6O+mSfIDwiEk8MVgF6uFNWijpSZ7XBuzm3cjueVbEu6x+j5Pim0curE75Xm+ZC
         XlxHLA8n3hX1T+kVe6rjccgZb3Xu5zX7+G66LgtJGCSUa3UOVJ06o034aQyiE46sbOTU
         sfkEvwsgj/D8BmgonzIFqTBZLuB9d+V6qVdEwpzZ2Wz563nz+wuPuAq+w05fuWcFN9pM
         +jcHjvAGTbOEZQV1H0xaMkUi7Xh7WmYJa9XQHFNetIm6hkPPB9+r99rAXFJtJwHE9dZy
         MtFrze52BxbGYoqxATUIdA+dad6KO7MZj7xRU+uK8qf2oESZjALdypFj1N2hX0HsZ3x5
         nmCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRjpvLj4NanIUDcpOwkWQZqdo8C/POjd1zue06FuwV4+wzoNmQ+gnfSMW7fS4xnQMGPddNKx0rKFCIlo9BC+0MM07kXsQm386OTN+7NGF3
X-Gm-Message-State: AOJu0Ywc4QSaz+QCl6bAw9rvQmoSjZ8WzXEJ++bKUKuIZckJ6L4wKiYd
	Vv7E0EED4U4rSpgk5ul5CE94rzSDxenjeihc5K8h/QB0qTwioYpruJjUTXHUrdNyegZkVrwbbgA
	m1Q==
X-Google-Smtp-Source: AGHT+IEXTdV0kJQaVce5PqLrH3fwi9yEgelcuoXat9IeKBfWoeQ96uS74NPqg5c88j/27hSzy0tzc6U5sPc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2b09:b0:dfa:6ea5:c8dd with SMTP id
 3f1490d57ef6-dfa73bc1496mr1061571276.3.1717453038191; Mon, 03 Jun 2024
 15:17:18 -0700 (PDT)
Date: Mon, 3 Jun 2024 15:17:16 -0700
In-Reply-To: <7a5ffaa2-9b18-4700-b4b6-da414333d894@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240501152451.4458-1-manali.shukla@amd.com> <ZjJghQ25H-ttaV4b@google.com>
 <7a5ffaa2-9b18-4700-b4b6-da414333d894@amd.com>
Message-ID: <Zl5A7GuqAKCZ7I5M@google.com>
Subject: Re: [PATCH] KVM: selftest: Add family and model check for zen4 in PMU
 filter test
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com
Content-Type: text/plain; charset="us-ascii"

On Tue, May 28, 2024, Manali Shukla wrote:
> On 5/1/2024 9:02 PM, Sean Christopherson wrote:
> > On Wed, May 01, 2024, Manali Shukla wrote:
> >> PMU event filter test fails on zen4 architecture because of
> >> unavailability of family and model check for zen4 in use_amd_pmu().
> >> So, add family and model check for zen4 architecture in use_amd_pmu().
> > 
> > Is there a less ugly way to detect that 0xc2,0 == "branch instructions retired"?
> > E.g. can we instead check for v2 PMU support, or are there no guarantees going
> > forward?  Pivoting on FMS is so painful :-(
> 
> We have confirmed with the hardware team that 0xc2,0 == "branch instructions retired"
> is always true going forward, we intend to maintain backward compatibility for branch
> instruction retired. Since event 0xc2 is supported on all currently released F17h+ 
> processors as branch instructions retired, we can check for "family >= 0x17" for all
> Zen and its successors instead of checking them individually in pmu_event_filter_test.c.

Can you send a patch for this?  Please :-)

