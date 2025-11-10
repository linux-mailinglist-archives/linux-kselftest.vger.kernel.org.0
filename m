Return-Path: <linux-kselftest+bounces-45239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA90CC48648
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 18:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68586188DA1E
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 17:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCFB2DEA94;
	Mon, 10 Nov 2025 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBHP9s28"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5362DE70E
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796509; cv=none; b=BYSycg3eAmiS5m2KI3mkdRhhxt0ScMLk6O6FK2Bnyy2X1taNDnBsLICsrBu2of3TcYELmfvg5jKbfXWNWClcclTpyczWON0RtRvuea2Ejk5bVk4bCAkooHcApfCbJ4Fc9ZDfurxLFrK5Pt0/IunKquOtj2vD2duyLUqpd+72jM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796509; c=relaxed/simple;
	bh=01dlGr5yNF89ID01yy7JEyF1mqdeq7pHF47t5S9oyvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JE9kz//5PdI7P9EHH4o1yQKEip1z/6BsyC9xCOd5gEonN95wNJA96Q7kf//V8AvGGYKXL8A29HI4OwYn+Mkytb7yapqUTCxSynEz913SUQUx59QMVtTFZlesqdwlLd0e7lvxNA25LCChcTORVbX4YYJkgX6/8yxDqgc2eLv7fNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lBHP9s28; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-431d824c8cbso439545ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 09:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762796507; x=1763401307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCN02yrRrm29VoLhm6qdIaJ6qOTD6tpswHT/4wW9b3I=;
        b=lBHP9s28n16XembK1gV4YMm+SZbiXI04phc1VG8pEUyk2A80vO/VkQvGMdwG7dLeWH
         zvL2tg01J4pD0CJLsEYXhSy4IlhnwsHTPWmI3Sk8hacLDJ+GC+c69MkWoxsLbQJgDP7F
         ltoVdrpQDEW/KgbDKI1WPZVg1/Xl2PiY7beX0cPPNuljaUGY+vidyL4J4ewIfzIbyHpC
         RfZ4cHmL9dJCUJpcfmJezx56A0g7cDv/dJD3ziGklmyoogOetXIhK3xAYybbat//unCh
         RgL59AgDEhvQH1ovtOEgpyTUlA1SsF0c39p2/BS7Vjx4rvbhflvgUoWChxUS4N+m+uJ/
         12QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762796507; x=1763401307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uCN02yrRrm29VoLhm6qdIaJ6qOTD6tpswHT/4wW9b3I=;
        b=vJiYGzjlzu3yeS3ZTQxAlTWIuas+V2OEEG2Yszj4pAE9xmhrO3dXacNGThfc9IVpYD
         nbRsTDXlwF6JawUYc1nU8xFnxAO6Hq2SX29sXU27dJsUbCiUaB3EvqjKiGVP2J2uXCyY
         FCIpEvO8lbNEwA5SwC3MQsNTeRnFCWPJ4ffZydhoxs0DP2rWMfft8+QS+VRQrGbasuse
         lZCexrv/DvhuLDJADojYGglU9M8ew5814lhMaMDs2aKkMH3UPGX70Y7qLsUpMN5qQb2O
         xN//hhORt6+CFzOavksvmRP3fsjmKMwq6Y0cFoFisOxwOcsoyq4hJU4HC8zhhjL3isN9
         xGoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkR1u7PBIPBok7P5+5W5oveM9olrWvXlhcOOY75rUzzlM6hkCGBrcLaDzzY1dOigS0O5MXDno6YOeXc3e48pI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc5Z2Wo9w5Oy4U5BOdTwXUK+eib86ikWwCP7kNLIn7uU72pbPp
	/q2O5L1EVB26bcvFh6crwXosQNWasghbm76znUbbUyBa53n3JUh82SHZTu6WWFa5Y1g99ePRhWa
	tsq3YAHH1qNf8GM1tl8jTEMwDjjtdwZ/+LXly7HaQ
X-Gm-Gg: ASbGncs3IhusDn6et/yI1oWX9ch4OfieSXdp8bspUQW1dDPDDn7D3AzHTqqdyMFnCI7
	J2F1cfRzXqRGqZqp8CbVuQitU4TlekEmGSKcA01bCWS63Z6TuZdiqUSFCSun0RZsLCPLYIARXii
	LSuar3cgSkExgbIbj3GX4qs9LeGbzzO95gtewWAAJ8LJK48n6+zbiYwJNoIekMi+eHFClbs3ge7
	UEq8Cy6tTbhqYYFkxHIe6unwHVW9+MNbFo2wpszCRhLFhzFwZNPawH5hae98GC0uHY/wRB7L1J2
	FqzNBfYoqL47tOsK4UbSwrP7LDc=
X-Google-Smtp-Source: AGHT+IHBszWXqdmegF9jDz3JdqQDbm8MYTV0aj0bqa37sU1cyBKp/p7V6BTPvfRkJX2omWXmFuxPpOdX1NkrpUUy3u8=
X-Received: by 2002:a05:622a:1981:b0:4b7:9b06:ca9f with SMTP id
 d75a77b69052e-4edc9d77fa9mr1301871cf.2.1762796506738; Mon, 10 Nov 2025
 09:41:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013185903.1372553-1-jiaqiyan@google.com> <20251020144646.GT316284@nvidia.com>
In-Reply-To: <20251020144646.GT316284@nvidia.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Mon, 10 Nov 2025 09:41:33 -0800
X-Gm-Features: AWmQ_bn8laNbI6x-97h0sYyX9fmwMMmvt4fgKNBEt3tvZG9iGI46wWrBFKgKfqM
Message-ID: <CACw3F528D6odL3MJWb28Y4HVOLo56tMQXBpvti5nhczdpMxOdQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] VMM can handle guest SEA via KVM_EXIT_ARM_SEA
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, duenwen@google.com, 
	rananta@google.com, jthoughton@google.com, vsethi@nvidia.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	shuah@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 7:46=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Mon, Oct 13, 2025 at 06:59:00PM +0000, Jiaqi Yan wrote:
> > Problem
> > =3D=3D=3D=3D=3D=3D=3D
> >
> > When host APEI is unable to claim a synchronous external abort (SEA)
> > during guest abort, today KVM directly injects an asynchronous SError
> > into the VCPU then resumes it. The injected SError usually results in
> > unpleasant guest kernel panic.
> >
> > One of the major situation of guest SEA is when VCPU consumes recoverab=
le
> > uncorrected memory error (UER), which is not uncommon at all in modern
> > datacenter servers with large amounts of physical memory. Although SErr=
or
> > and guest panic is sufficient to stop the propagation of corrupted memo=
ry,
> > there is room to recover from an UER in a more graceful manner.
> >
> > Proposed Solution
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > The idea is, we can replay the SEA to the faulting VCPU. If the memory
> > error consumption or the fault that cause SEA is not from guest kernel,
> > the blast radius can be limited to the poison-consuming guest process,
> > while the VM can keep running.
> >
> > In addition, instead of doing under the hood without involving userspac=
e,
> > there are benefits to redirect the SEA to VMM:
> >
> > - VM customers care about the disruptions caused by memory errors, and
> >   VMM usually has the responsibility to start the process of notifying
> >   the customers of memory error events in their VMs. For example some
> >   cloud provider emits a critical log in their observability UI [1], an=
d
> >   provides a playbook for customers on how to mitigate disruptions to
> >   their workloads.
> >
> > - VMM can protect future memory error consumption by unmapping the pois=
oned
> >   pages from stage-2 page table with KVM userfault [2], or by splitting=
 the
> >   memslot that contains the poisoned pages.
> >
> > - VMM can keep track of SEA events in the VM. When VMM thinks the statu=
s
> >   on the host or the VM is bad enough, e.g. number of distinct SEAs
> >   exceeds a threshold, it can restart the VM on another healthy host.
> >
> > - Behavior parity with x86 architecture. When machine check exception
> >   (MCE) is caused by VCPU, kernel or KVM signals userspace SIGBUS to
> >   let VMM either recover from the MCE, or terminate itself with VM.
> >   The prior RFC proposes to implement SIGBUS on arm64 as well, but
> >   Marc preferred KVM exit over signal [3]. However, implementation
> >   aside, returning SEA to VMM is on par with returning MCE to VMM.
> >
> > Once SEA is redirected to VMM, among other actions, VMM is encouraged
> > to inject external aborts into the faulting VCPU.
>
> I don't know much about the KVM details but this explanation makes
> sense to me and we also have use cases for all of what is written
> here.
>
> Thanks,
> Jason

Thanks for your feedback Jason. And thanks for the comments from Jose,
Randy, and Marc.

Just wondering if there are any concerns or comments on the API and
implementation? If no, I will fix the typos in 1/3 and 3/3 then send
out v5.

Thanks,
Jiaqi

