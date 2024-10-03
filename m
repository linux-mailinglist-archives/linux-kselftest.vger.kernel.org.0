Return-Path: <linux-kselftest+bounces-18983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7688998F8F9
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 23:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997231C213B7
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 21:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72071B85FA;
	Thu,  3 Oct 2024 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z/GZgLpW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEE41AAE39
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991131; cv=none; b=GYSWAsHC2IEpl9FbiZ4Ad9kNZxQMenebLjrNBwmq466CLDgjDFJOevkH5ZXwKChFJh23yhJiJ6kP+hqf7QiOKFUO/fLFdpF4DSknM0M2hk8d39PO2hlMxWgfTt4ysomsNdkXi5izfjap4UpKm+6mRkgSREk17h4ix/YiBeOIhkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991131; c=relaxed/simple;
	bh=eQXUqrNCEye315PqzJwXqT6qlA4ApAuo0hxzHNcwQfU=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=WiybJe0zjjpS/AKkNMlvV/9ns3dEvHXNFlpA/WMeFIdaSoW7s5jzALzho1ClfwjZyhachEyYi6yoswoEtSVzs4aTBqv2+ni5uYUu3PROJDKhOxFlL1dpFcwR4Pl0VyeSvVTHHv+Y7UXCPdjLKkWgISUmwJyZQhVyl0RAA7G/e14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z/GZgLpW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e28d223794so26802767b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Oct 2024 14:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727991129; x=1728595929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YeyMi5GuWsR2a8eIHUSkiPOJlEPgvDo2Zk7QC+dIJyo=;
        b=Z/GZgLpWstxxeI4TILFHS5i99x6wmVhndQd/JYX0o4MeE0CgKKFFQDD4NO6vjGkGvj
         Pb/RpS2P2Rp1fBquDS6sQxyhBdVDxbkoWeVGpltPttTqdrvMAUNC+I0r7DtiQv4IaJwA
         ecLEt73wL7uGtp7hWN7SwMTfKactqJGjh0Qr3GQejFfw7jP0vP0yW00WG4ldO1r4H6aW
         0ptfXbB3FopUuXd+qph8a2JQOW7e/hhuPKq5u8aAOYcrAh8hFoxZbgYZmTYQ5lk3lEXt
         k1IApmQCGbS8JRZur9B/vGp8N+KHTPYQofNdHHwtlrcD3VKr8As9dvOL6KGMMsCe3Z4s
         9hxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727991129; x=1728595929;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YeyMi5GuWsR2a8eIHUSkiPOJlEPgvDo2Zk7QC+dIJyo=;
        b=ikcEVP7m/FihYAdN11ZWu4/f0mhvfKgZHtUJaX6SbotNxOwU+kae/LFYJkYsccY5Ya
         4S5dTzbZGoYAmix+alRggtm4r0j3aslK+iS+9S465TtuCOGWgNNd2HWTz0qnoDQHLpvw
         67uTQCFd7ogk4MkXxwvXtGE0yufrP1Ut7M7ljJgmaK1Xu5iTdgGRGCPw1/OZMDgou1/4
         ans9Z6k+R3kTmFe64hBZnFR79We2YrHAvID50D33TW8aBa3I5Dj+Jh5fviY/YWGW5xwI
         p0mYB0IveDXi7cXafXnfL3A5McvW/l/TRnGyJhj1OUUNdTALZtgBUQXCosviPDRzeN6M
         0qqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUztvoPP/P/U4swzOCXtmTWAEJRc+01L79udlR9/FZ9cXAbdJtwZ478sNyqhUExJjXwhSB1C9mjdBpoixphWKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZyZ90Tho8kY2JIsoQssMdfN7PGTnPMk1YWArXO0M9hUiFGI/h
	aBtMbOKPBVlkyhbVS1LUcVd7AwFhPyp1VByPvnBP3L22Mg1fCafC5Xh48L5qKa8gauKWQpb6dLW
	mTFesJpkfOdVeve3YtIXrUQ==
X-Google-Smtp-Source: AGHT+IHj9Mj3fGF2AKNp7UT4NwW0tAXGu9bw92gmr83lf/HTz4fdabYcJ+qNb/yseg69AGP4G9z54pF5GWqqQEUBBQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:146:b875:ac13:a9fc])
 (user=ackerleytng job=sendgmr) by 2002:a05:690c:2f83:b0:61c:89a4:dd5f with
 SMTP id 00721157ae682-6e2c6e8b3a8mr32317b3.0.1727991129318; Thu, 03 Oct 2024
 14:32:09 -0700 (PDT)
Date: Thu, 03 Oct 2024 21:32:08 +0000
In-Reply-To: <20240916120939512-0700.eberman@hu-eberman-lv.qualcomm.com>
 (message from Elliot Berman on Mon, 16 Sep 2024 13:00:56 -0700)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzzfnkswiv.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH 30/39] KVM: guest_memfd: Handle folio preparation for
 guest_memfd mmap
From: Ackerley Tng <ackerleytng@google.com>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: tabba@google.com, roypat@amazon.co.uk, jgg@nvidia.com, peterx@redhat.com, 
	david@redhat.com, rientjes@google.com, fvdl@google.com, jthoughton@google.com, 
	seanjc@google.com, pbonzini@redhat.com, zhiquan1.li@intel.com, 
	fan.du@intel.com, jun.miao@intel.com, isaku.yamahata@intel.com, 
	muchun.song@linux.dev, mike.kravetz@oracle.com, erdemaktas@google.com, 
	vannapurve@google.com, qperret@google.com, jhubbard@nvidia.com, 
	willy@infradead.org, shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

Elliot Berman <quic_eberman@quicinc.com> writes:

> On Tue, Sep 10, 2024 at 11:44:01PM +0000, Ackerley Tng wrote:
>> Since guest_memfd now supports mmap(), folios have to be prepared
>> before they are faulted into userspace.
>>
>> When memory attributes are switched between shared and private, the
>> up-to-date flags will be cleared.
>>
>> Use the folio's up-to-date flag to indicate being ready for the guest
>> usage and can be used to mark whether the folio is ready for shared OR
>> private use.
>
> Clearing the up-to-date flag also means that the page gets zero'd out
> whenever it transitions between shared and private (either direction).
> pKVM (Android) hypervisor policy can allow in-place conversion between
> shared/private.
>
> I believe the important thing is that sev_gmem_prepare() needs to be
> called prior to giving page to guest. In my series, I had made a
> ->prepare_inaccessible() callback where KVM would only do this part.
> When transitioning to inaccessible, only that callback would be made,
> besides the bookkeeping. The folio zeroing happens once when allocating
> the folio if the folio is initially accessible (faultable).
>
> From x86 CoCo perspective, I think it also makes sense to not zero
> the folio when changing faultiblity from private to shared:
>  - If guest is sharing some data with host, you've wiped the data and
>    guest has to copy again.
>  - Or, if SEV/TDX enforces that page is zero'd between transitions,
>    Linux has duplicated the work that trusted entity has already done.
>
> Fuad and I can help add some details for the conversion. Hopefully we
> can figure out some of the plan at plumbers this week.

Zeroing the page prevents leaking host data (see function docstring for
kvm_gmem_prepare_folio() introduced in [1]), so we definitely don't want
to introduce a kernel data leak bug here.

In-place conversion does require preservation of data, so for
conversions, shall we zero depending on VM type?

+ Gunyah: don't zero since ->prepare_inaccessible() is a no-op
+ pKVM: don't zero
+ TDX: don't zero
+ SEV: AMD Architecture Programmers Manual 7.10.6 says there is no
  automatic encryption and implies no zeroing, hence perform zeroing
+ KVM_X86_SW_PROTECTED_VM: Doesn't have a formal definition so I guess
  we could require zeroing on transition?

This way, the uptodate flag means that it has been prepared (as in
sev_gmem_prepare()), and zeroed if required by VM type.

Regarding flushing the dcache/tlb in your other question [2], if we
don't use folio_zero_user(), can we relying on unmapping within core-mm
to flush after shared use, and unmapping within KVM To flush after
private use?

Or should flush_dcache_folio() be explicitly called on kvm_gmem_fault()?

clear_highpage(), used in the non-hugetlb (original) path, doesn't flush
the dcache. Was that intended?

> Thanks,
> Elliot
>
>>
>> <snip>

[1] https://lore.kernel.org/all/20240726185157.72821-8-pbonzini@redhat.com/
[2] https://lore.kernel.org/all/diqz34ldszp3.fsf@ackerleytng-ctop.c.googlers.com/

