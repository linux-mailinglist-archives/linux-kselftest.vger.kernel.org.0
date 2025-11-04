Return-Path: <linux-kselftest+bounces-44755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 855DEC32E3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 21:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 690224E1A83
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 20:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7185323C4FA;
	Tue,  4 Nov 2025 20:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ouz8IaxM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76642367D1
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762287554; cv=none; b=eNDlRb2YojtocGUT0yEob1X0XB2WP8m374KzOaPcL51RJoJjpy75Av5eqe288jq1XGVzy+/Mj5YbUltFYIgdRiXKGNv9oZsWKa1geOV2Z3LEGWOZbQaGyTjVb20JGDiJBp7bv/AkvLJ2TwY1LwwQxHv3+0OiYCFf2z08+BTCc10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762287554; c=relaxed/simple;
	bh=BqhHgAqSkG4l2z1eoyySaP6wFCFo56cQORvWEuGj/N0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qy/BDXEyJ+mZ/V4/ifupgIEBKMG7YimRRNgpc6DSgFuWIgSIIR2/kNy1m7O8eRyvKIx0B0/h7xLM41n9Cb6UKRuSMMCf5MHTCmBVqZh4k1eBnWvjLvwGEfbvJV+WscDJR6kvso9q0Fhu+mtinBEX8C+rWp99gl0k+T7WcgpFsaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ouz8IaxM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3416dc5754fso2125474a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 12:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762287552; x=1762892352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4Bva0w0KbqgCJAJfbsSK/8FEB2ivKz4/LZ5P7kuzw0=;
        b=ouz8IaxMFUS9COMgc5r7O7yMfYfLkzDVhfyQDJw66WRi7aH7pTDM/c+PbIRh3Syj8r
         M5qJ3RaQqbAgvdxb9p8n6K0iwd1SCvK/3pvcRxDBu7Bqrd93vR+EDxSkvNqjCzf69vf1
         7B2cDckKkmb0b+P+07esku1HAidJuD+k0r/2wqfmTV4xFOnIeTUdv+/QYQnxwn9Q/tgz
         /OYtNHC7Mg+0wRCXoZhiFTdwE6C7fuBHrzl74rdgKNBS7b/Up6n8mx9Gc3lB54FsWZTh
         RBEmlHHrDHWnhlqzE+bMnePI5cvs0zprXPS4USc1fR/P2S4IbV8ab2njU8dEaoRp98zz
         2qSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762287552; x=1762892352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4Bva0w0KbqgCJAJfbsSK/8FEB2ivKz4/LZ5P7kuzw0=;
        b=RXO5hA/p/chaAYy37HYmfETvimBTvLzfX2MCXgjAlkIzadjrPSzlfZR/wZEJSKinJe
         84JMZwM+Rp54mdHlrBTEkyGHzNHj131Xtb9j6VUo8YEeBOQqIqAXS2v4S4MV7OO7oY+K
         QyoWAZeODbfcMdT7u0hA6X4mc7of5WOFizmkx8YCXdj8wiSSl57Skc+DTYWb1qmV6341
         JVAbt3Ecvvart1s+T8EHyqgP0TVCI3DcPNp7VaxkLumI+NI2PpiA/0VtvodQyQ/WQrmz
         wxTfWWXsorBNgj5FW3sbr5hVj7vBNSf3RIwx2Kh3xumzAvyX5NAT+hR5+e2DmARw7oUL
         wgoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8CtMx52ZjI1yQ3RySxwWWXU8US3MjydOv6I1SPEsNMXpOBJJfR9RYI2SaPI+dKSEZtaiK6sxPylpGRAydnPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsmcrnn93sVIL2DOV4eUq5gPD0W8DIiuOSxZsP8e6IpaQt6M+X
	uSx6BrNDP7bxNVCbAfh8D/M+tlvZ3GJ0V4AJyE8a4v+l2tHHS6xQQT+3RcwbVXZYv06S9Z1INa1
	Pw/8BBQ==
X-Google-Smtp-Source: AGHT+IGdgZKcyoQ0zGdQrLNOdi7+EjeBGpl2/tWI68ux+7RvDN8zvERNjHKEkloiI0RWSyl4SFGplL1NmQw=
X-Received: from pjvf13.prod.google.com ([2002:a17:90a:da8d:b0:33b:e0b5:6112])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c8b:b0:340:a961:80c5
 with SMTP id 98e67ed59e1d1-341a6defed9mr629130a91.32.1762287552241; Tue, 04
 Nov 2025 12:19:12 -0800 (PST)
Date: Tue, 4 Nov 2025 12:19:10 -0800
In-Reply-To: <0c3db907-7012-43c3-b7fc-36848789da52@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013151502.6679-1-jackabt.amazon@gmail.com>
 <20251013151502.6679-3-jackabt.amazon@gmail.com> <aPpi1c-8EpWuo87B@google.com>
 <c52db7bf-494f-49a8-9829-3805db6dda7c@gmail.com> <aQkZtjLt6lIULffA@google.com>
 <0c3db907-7012-43c3-b7fc-36848789da52@gmail.com>
Message-ID: <aQpfviS-oAmanqpq@google.com>
Subject: Re: [PATCH v2 2/4] KVM: selftests: Fix unaligned mmap allocations
From: Sean Christopherson <seanjc@google.com>
To: Jack Thomson <jackabt.amazon@gmail.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	isaku.yamahata@intel.com, roypat@amazon.co.uk, kalyazin@amazon.co.uk, 
	jackabt@amazon.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Nov 04, 2025, Jack Thomson wrote:
> On 03/11/2025 9:08 pm, Sean Christopherson wrote:
> > On Tue, Oct 28, 2025, Jack Thomson wrote:
> > > 
> > > 
> > > On 23/10/2025 6:16 pm, Sean Christopherson wrote:
> > > > On Mon, Oct 13, 2025, Jack Thomson wrote:
> > > > > From: Jack Thomson <jackabt@amazon.com>
> > > > > 
> > > > > When creating a VM using mmap with huge pages, and the memory amount does
> > > > > not align with the underlying page size. The stored mmap_size value does
> > > > > not account for the fact that mmap will automatically align the length
> > > > > to a multiple of the underlying page size. During the teardown of the
> > > > > test, munmap is used. However, munmap requires the length to be a
> > > > > multiple of the underlying page size.
> > > > 
> > > > What happens when selftests use the wrong map_size?  E.g. is munmap() silently
> > > > failing?  If so, then I should probably take this particular patch through
> > > > kvm-x86/gmem, otherwise it means we'll start getting asserts due to:
> > > > 
> > > >     3223560c93eb ("KVM: selftests: Define wrappers for common syscalls to assert success")
> > > > 
> > > > If munmap() isn't failing, then that begs the question of what this patch is
> > > > actually doing :-)
> > > > 
> > > 
> > > Hi Sean, sorry I completely missed your reply.
> > > 
> > > Yeah currently with a misaligned map_size it causes munmap() to fail, I
> > > noticed when tested with different backings.
> > 
> > Exactly which tests fail?  I ask because I'm not sure we want to fix this by
> > having vm_mem_add() paper over test issues (I vaguely recall looking at this in
> > the past, but I can't find or recall the details).
> 
> The test failures happened with pre_faulting tests after adding the
> option to change the backing page size [1]. If you'd prefer to
> have the test handle with this I'll update there instead.

Ah, yeah, that's a test bug introduced by your patch.  I can't find the thread,
but the issue of hugepage aligntment in vm_mem_add() has come up in the past,
and IIRC the conclusion was that tests need to handle the size+alignment, because
having the library force the alignment risking papering over test bugs/flaws.
And I think there may have even been cases where it introduced failures, as some
tests deliberately wanted to do weird things?

E.g. not updating the pre-faulting test to use the "correct" size+alignment means
the test is missing easy coverage for hugepages, since KVM won't create huge
mappings in stage-2 due to the memslot not being sized+aligned.

