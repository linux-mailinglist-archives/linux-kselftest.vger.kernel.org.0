Return-Path: <linux-kselftest+bounces-39960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7C0B36FBD
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 18:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26F946071D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 16:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D3930BBB5;
	Tue, 26 Aug 2025 16:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NbbVULl4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA6D2641D8
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224772; cv=none; b=PMjJfG+ZSht1mRGXb0ngvBneS7vHIDOgFI1490Mr4W9ZHw95MBlKN8OKyQJVI82M0m3OtQR8gLJVhgqA4uc9bs6Fvlz8xOZtG9p2neoIQsvuXL9KFioCSYK4RTWoVobnFbNzzo4GiH4z+ThLc0xYL0JQPooWzRzOudzZWVQaQ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224772; c=relaxed/simple;
	bh=lpNJxIxdAxwJxU4ad3K/8xf8SB/3leQSRQ6Ul6aUQa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEsslejr7AkomqDRaBP68GUjOmZ+yltxUwYT37HjSgdybLEA3yWjr6PeMReAzwWUUBNvuaeJbQ9mt9p4o/e7UgeBpWi5Jp3g3QzuzKkwVb+m3Jd1PjVhkO+PzsAt0TWS2l2MKus3XKSNaJXZBDBu+17kgNN03IcPWHG6/oZx5bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NbbVULl4; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b12b123e48so344051cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756224769; x=1756829569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yShLrZrJiMcpakMkFlTcuZUxFmYo1J+gWIqNEy87nw=;
        b=NbbVULl4/+iaIrPor7/AVhOtfejsNPjYsQgEN4j4GermWgplRx9htSXk252RL5/QBE
         PzgvQvNPSkgJeM3jIZziSFRaD6LoVKiq/WCzYk8+0vd58EQ1KocNcfXTd3qxdAt7aOoy
         /kzE+3pWkErAsluyw13CHNV6XwhZCPuE6TsuGTQXFpYvixE/9HJmKlGnYiD2uvCZ4pU3
         eMHY3Zf/+aAuof8rfC3zraOgm9B4WCGBnuWGxV0TyMvHOodWl7eVuNFbk3Gzt/Ym/wsT
         hZEfvmyruvSOHbIPmMa0t9UTFwspWtRFOGtovRb2aHPMEXOjBz9YxWA8LWKMB4LXMZdp
         M1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756224769; x=1756829569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yShLrZrJiMcpakMkFlTcuZUxFmYo1J+gWIqNEy87nw=;
        b=JAoG7yi3Sle5Q4W0vE+rex9/hWcHnQGWSh/RqHUuXpnapAwxIZhKAjM0AtdRWM0rAU
         B/zF1A54aTLQmtsTSgO7RfPKPRIx6Cxp/jwY3PkZ66BmAREFzAKDhc9N7Y8x8fw11oao
         M3W1PrxXomuZ74iLWdAS8gAEEQZStRC0P/3bnQnLZb9LH48GvYNsfdLr2zk3HKcBA+2x
         QrvhIvh2bqNybAxD6w/WtFgbKC4n9wUTJ+BHS5v2N60SJ5+Il/WnqzRjzyCHVkGBwW5c
         cArPdEpGOYJSrPCIoVmrbOLSbsp0OtAhKRUXY0wnDCWBz+Jh0dBGIBkI1eO/HHCW9VBy
         y2dA==
X-Gm-Message-State: AOJu0YyDpClYoxrrOqeSLeIlEBNFyJu0Fn8eqHmm3ph7YFi7jeCf+pJV
	lRck1NnIZk1j1hoTW9WiW74rrv0Iow4cRPt3kLST0Udi5z4zLBxwE/jO1jpOInudq2bZPNM815J
	xz9jvBxDyVLk4LaEF96tdHT+m9ZiztlnIWrYdt6Lh
X-Gm-Gg: ASbGncu5pX01WBXG1adNTx0lfuKsylEivkoq8KXpxHGBIG80sztwXOXEP9uAV13gMEW
	pqcFITgFXxB3Vyi3ecJ3omwsdMkbGlV5cJOKW1Tjton8GIoqY0TarevvESfOs2L5+qf1tp+4v8g
	XUQwTDb06gjBD5N+cwNtaBDyyQxysR/+yxrUoWaSqJxmwlX2mS8JODuzpZtSWrhaP+DNqImbmBo
	0nNW44o0bHtvmg+d1Q/KoJ7QMnb0hpXjfRyaWDzv4F/kTxTAWglezAQ
X-Google-Smtp-Source: AGHT+IFVvO6S+pHDrFpICQlKDSU8oqWS2opzl47Wp6F8/5x5K3WItU0qoTqh+FfZuB0xx7wpKAFANxB1M2Uef/LWkQA=
X-Received: by 2002:ac8:570b:0:b0:4a5:a83d:f50d with SMTP id
 d75a77b69052e-4b2e2c1da97mr5618951cf.11.1756224768436; Tue, 26 Aug 2025
 09:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-16-sagis@google.com>
 <94f1eeb5-35c2-4edf-ace7-6917b06bb4bc@intel.com>
In-Reply-To: <94f1eeb5-35c2-4edf-ace7-6917b06bb4bc@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Tue, 26 Aug 2025 11:12:37 -0500
X-Gm-Features: Ac12FXxRdiH0_Etf0N3MHyniMjmTUDp8DCEiBrUG4BKEG3ue3GXyQJLjbFSxojw
Message-ID: <CAAhR5DGC77bo427gQkvEq_BaJYaYXMgrw9ESq2xp=ER7pQPCLQ@mail.gmail.com>
Subject: Re: [PATCH v9 15/19] KVM: selftests: Hook TDX support to vm and vcpu creation
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 3:28=E2=80=AFAM Chenyi Qiang <chenyi.qiang@intel.co=
m> wrote:
>
>
>
> On 8/21/2025 12:29 PM, Sagi Shahar wrote:
> > TDX require special handling for VM and VCPU initialization for various
>
> s/require/requires
>
> > reasons:
> > - Special ioctlss for creating VM and VCPU.
>
> s/ioctlss/ioctls
>
> > - TDX registers are inaccessible to KVM.
> > - TDX require special boot code trampoline for loading parameters.
>
> s/require/requires
>

ACK

> > - TDX only supports KVM_CAP_SPLIT_IRQCHIP.
> >
> > Hook this special handling into __vm_create() and vm_arch_vcpu_add()
> > using the utility functions added in previous patches.
> >
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >  tools/testing/selftests/kvm/lib/kvm_util.c    | 24 ++++++++-
> >  .../testing/selftests/kvm/lib/x86/processor.c | 49 ++++++++++++++-----
> >  2 files changed, 61 insertions(+), 12 deletions(-)
> >
>

