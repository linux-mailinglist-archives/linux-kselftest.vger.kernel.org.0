Return-Path: <linux-kselftest+bounces-43690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF421BF910C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 00:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81F8E4E72CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 22:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A81A2BD031;
	Tue, 21 Oct 2025 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YhTJyNZ0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB427FD51
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 22:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761086246; cv=none; b=H8SUn4hlXW8nnit+I8oNGGz7Kigh1I5vjluBXB2JzSbtlj+yvtcE9zdfOnSYPoVl83q88FEB03n2vY9T6lZq9Z6ln3Sx1S+w+ifc+JoohzrBQ+guI6KCm9p9xZAlXwSAJ0K2CA3bQsiYV0yqEn8b3xrQm2T1gzO7gUEYgVT7nds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761086246; c=relaxed/simple;
	bh=HCABZ0fSb2gwncRmR9GNGsqNXHTK6LESdR3hiZ/zCTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRqMwF9EHsZ0kVkpWMkc4oKYc6y+lw7ycof9VRXftbuRFg4+He6ND5Ngocz1ScKRttjRXCf5AzIkSjz5BnnLS9KU0F0OZQaMT7UqQS/rNTCq/FJmZrgUe+oJOdr4H26DRkdV+H/ZkPhmZMSoyEio9BA4fx9y1QfuV3SgrspQAwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YhTJyNZ0; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c2b48c201so2193a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 15:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761086243; x=1761691043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wd0nSui/IVY+78Jp/2L3ftVcgcNhuYZhu3p7Z3L7toc=;
        b=YhTJyNZ0jovG+khcIo5bCGupsDXJARvqx0MWiRDEy8WlEyFEt5F/lToIjHMxyPZmMw
         YgcfuX5k6p7/o3ey0qhV7YVn2dzRhuHFFCZYyzAn7UTYOJr598yDc3BVJPJp/qqKQ8D+
         zNLJZSWZsJ/f2D0igwLVNd4m+FihnK+AHuC8qkTBmsiW4f4rRvmDr+d3YuQv5tyPe1Xq
         ls1MKrChNyPDf2uxWEqWQeBvG9ifgVAkHU0dPEEsFZmzrYLuQgerxwFHtHSaU6SgoRB6
         ae4QiPHVWQGMSYVuyTiZtHd982v2gejckLhW9YVyGD5zvw8VI6+kklt4iwDEmjl3//Sn
         eP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761086243; x=1761691043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wd0nSui/IVY+78Jp/2L3ftVcgcNhuYZhu3p7Z3L7toc=;
        b=vMJB8lRaR2qWyP7rp3eLb3OkdlzQw36Pm3qBRYPD0I/yuj3pCcSt7LZ7i5LF62i/6e
         zcy0uzlNCgmiJ9MUJQteywDFurepinV/YWQgRfImbZZu7++qdelKu4PeHVzaSWqWT1xf
         MSxLwYYwo3Id6Mf092HwhDYIwfT9UdnP6uLabk1JrJVrsyDAxsp917dE3zItufqoObVV
         +iTfOLZpGVuoosiSXz6YO8j9sezCASlU0FPTINWE+tReb6uqJ/TCyCB7btPYDyzpDR1a
         O+ANV+Vo5RiS9vM866lVjW5XvI5ObfwPYosW6RlzJ7Tk6KLgk8ONV1HEVMC1K61cPzE9
         Tc7A==
X-Forwarded-Encrypted: i=1; AJvYcCVODWT5eleZTruhQXCex5l0Vu9CMSBk2kzQgXOWsbXIvwvEzSfJLF0tM8T0OccR+qJzA4It1jOR0CjiehNNmO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpUW7MQWGOc22klCRUKtnevhfbznNbl/cMSQo5j5hT0mZ73Utj
	gkEIaE+YllewnnQkQM7DAyNs/K+DgVlumju/8fDbhrBXy5v6UF9fLPYfwG4XzsDC1n2mMGWMOpI
	WVwaHwku4YfqpeyjaNc6xVXZ+BWczdyCcImLCdBZP
X-Gm-Gg: ASbGncsot3js3ySCuQGZ0Bag7WKj2+HfKpwuzyEjWt6FhVaOwxQf7e7d7ImvCXaGUiw
	Adqn6ZGjLZ1MzqEmhelNu1Dwa37bKQ0wsn8CXrJ1rCoab4YjtFUFgWA1OK4CmOTvKReavPXQ+dT
	eT5wBeWJR/jihpXXSZt0Ju1Ku41fj264VOGFeU2T45aQKIJp9dz/glVgYbnh2Buh5CYuvrr8cwA
	dhshOK+7031fefY/ghcqUIfKlhTwWIuHCBLFzj0d0kemde4RH3hjwoV/KXzobuiN/aYf+0=
X-Google-Smtp-Source: AGHT+IEInvFD+rNulexjDzzfxJhwDPmWVBfA30UjD5rmIsAKo7gUu1vHuokzwbQl+cd4r3IddtU+c3F0TtmyKxvdsVM=
X-Received: by 2002:aa7:da47:0:b0:62f:c78f:d0d4 with SMTP id
 4fb4d7f45d1cf-63e1970aba1mr33610a12.6.1761086242750; Tue, 21 Oct 2025
 15:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917215031.2567566-1-jmattson@google.com> <20250917215031.2567566-4-jmattson@google.com>
 <aPAnWWmo555uB0-H@google.com> <aPA-60vV0WQUCmc2@google.com>
In-Reply-To: <aPA-60vV0WQUCmc2@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 21 Oct 2025 15:37:10 -0700
X-Gm-Features: AS18NWBZoStzmHUAyoYpMbkWywDCeuQ7pVI5QsF3xxQE_nerMPa41G1gJLfsWo0
Message-ID: <CALMp9eQ3VdsNVb73BfaL5=2z=W+8-3O5Nv=ucmK2D+_zKWbyxw@mail.gmail.com>
Subject: Re: [PATCH 3/4] KVM: selftests: Add VM_MODE_PXXV57_4K VM mode
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	"Pratik R. Sampat" <prsampat@amd.com>, Kai Huang <kai.huang@intel.com>, 
	Eric Auger <eric.auger@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 5:40=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Oct 15, 2025, Sean Christopherson wrote:
> > On Wed, Sep 17, 2025, Jim Mattson wrote:
> > > Add a new VM mode, VM_MODE_PXXV57_4K, to support tests that require
> > > 5-level paging on x86. This mode sets up a 57-bit virtual address
> > > space and sets CR4.LA57 in the guest.
>
> Thinking about this more, unless it's _really_ painful, e.g. because test=
s assume
> 4-level paging or 48-bit non-canonical address, I would rather turn VM_MO=
DE_PXXV48_4K
> into VM_MODE_PXXVXX_4K and have ____vm_create() create the "maximal" VM. =
 That
> way tests don't need to go out of their way just to use 5-level paging, e=
.g. a
> "TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_LA57))" is all that is needed.  It =
will also
> gives quite a bit of coverage for free, e.g. that save/restore works with=
 and
> without 5-level paging (contrived example, but you get the point).
>
> The NONCANONICAL #define works for LA57, so hopefully making tests play n=
ice with
> LA57 is straightforward?

I will see what I can do. :)

