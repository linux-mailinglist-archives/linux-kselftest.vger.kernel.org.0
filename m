Return-Path: <linux-kselftest+bounces-38682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13307B20C2C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 16:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896EE4253DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 14:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08926255F2C;
	Mon, 11 Aug 2025 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIbEH2Ox"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A35E253954
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922858; cv=none; b=XPL1YAJ84rOyWlkXIg9B5luPu+eA3WLhSyCo3EsueSDWMAWulIoMkAX49WUxmxGX5B1VmjtaN/D99g2GJeu7PtrQs3wHtDUdHB8hH5NZO3PnR7Z4ZLqVXzPGRAiyAGCDw4m9yAH3bxAENzBbgh+apQ8UXU8bstQoI5AgNZ2n1dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922858; c=relaxed/simple;
	bh=bruREYZz13FVqwhmiTuhvJnq89yjM0qtV4JcUUKirMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sXR2uCP+8CkQ01XmKwIUO7nOGuMG1CQQCJ5hK4JH7CMepjtFsUFDJeabCipDLhPql7yV1hUpbRZhLM9jDiRX9TpIMi6r9MAfXiSh1DE0PMXsdyoJ2NB+wf0WWze9gV5zHKIkFFmHeJKX7YukDk4rjG7aaresTMawGaGXGTPhY9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DIbEH2Ox; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bf30ca667so8488549b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 07:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754922857; x=1755527657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s3QC/DofyyJ1kIbquP7TygGRJBogDIdpEUbLnTdcdHg=;
        b=DIbEH2OxjBvZkBS8teorCGp39U2CsmDZuMeaPxaLBtckmwePYI1C99M65EyxVI7trh
         HMj94pK8tSAk3aLUDeLtAL6D0cSxG/BAIn/jY23E+Z+FueDmK4DbobALuGZ7GOUSpFAV
         pFuN9hANNqRVIBG3ZvvVCSw2QTKDTvKP8zGpnXzSyTfcMqchaQovLADWbt6PftZYq+8u
         MDnxb7e9+ghOdjDXxhD0wKp0209GGbj42znut7BAb3XeN1mYs9dLBE8YTT0TeccuZFNV
         78Z3olcG5TguJmbCuK46mBMg9bII8+GyNCNGPCcxWsmK1r2rbJoaYCZLg7gIdLsEdA9X
         HxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754922857; x=1755527657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s3QC/DofyyJ1kIbquP7TygGRJBogDIdpEUbLnTdcdHg=;
        b=MLXudC/1cVax4hwi2ZLASsWe2CziOfnWZyDVpX+Yvk4brk38H9naX7SjU3anv0fTDG
         nPR9jfMxBvbupHE/hyhKT9puYXd/pbIo2noUARAt340qrjSC2zf50jj+lzuCsYwnLFBo
         JRFLzEFgVU1sWaZX3EL5RmgcxABo2Od94cI7EkTVuIqqUH0ITb5YWCkq+wFxSmchLinq
         61qYZa7bka0AFD0kMgL3obC1O/Ss64JAIlvLxD5hblyoxnrTp0qEHTHLt26AfUZXC7Go
         NzCFTgCkZufI7a1S3lpVvvf9GSGvECNa9cmVyM3CIgJ2onJLCmRDP8zHWfUDDEEfznvR
         oSXw==
X-Forwarded-Encrypted: i=1; AJvYcCVtSFdbX6bQy34v01Wg3+XDjG3VnULxO8mFhOLvmeQX3uq7sGQIPgdtvc4QJKDHu8Gu/sk3HSVDRYekCRMBYgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjn1pW9Y8S7IcZDHscCobWougoCR8hCyOUDqCR+35fbFR9qnYo
	zQxNlK22YdXahWOJYP11JNwofKYM0lj+rfKYtozBFIg+A3JuKSkDIN9Trf6o+93RXCJVcGPqajY
	oDdguEg==
X-Google-Smtp-Source: AGHT+IHDzFt+0zXjA0CUz3si8YkwDTRVPFUsiiRh4VZN4Dkprgq2wlq3CPL9ofZgO6/62HnwUQZt6ujhFVk=
X-Received: from pgos21.prod.google.com ([2002:a63:af55:0:b0:b31:d198:ffb2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d8b:b0:240:6dc:9164
 with SMTP id adf61e73a8af0-2405502ffeamr23223057637.15.1754922855887; Mon, 11
 Aug 2025 07:34:15 -0700 (PDT)
Date: Mon, 11 Aug 2025 07:34:14 -0700
In-Reply-To: <20250811090605.16057-2-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811090605.16057-2-shivankg@amd.com>
Message-ID: <aJn_ZvD2AfZBX4Ox@google.com>
Subject: Re: [PATCH RFC V10 0/7] Add NUMA mempolicy support for KVM guest-memfd
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: david@redhat.com, vbabka@suse.cz, willy@infradead.org, 
	akpm@linux-foundation.org, shuah@kernel.org, pbonzini@redhat.com, 
	brauner@kernel.org, viro@zeniv.linux.org.uk, ackerleytng@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, pvorel@suse.cz, 
	bfoster@redhat.com, tabba@google.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, 
	kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, rppt@kernel.org, 
	hch@infradead.org, cgzones@googlemail.com, ira.weiny@intel.com, 
	rientjes@google.com, roypat@amazon.co.uk, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, kent.overstreet@linux.dev, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, chao.p.peng@intel.com, 
	amit@infradead.org, ddutile@redhat.com, dan.j.williams@intel.com, 
	ashish.kalra@amd.com, gshan@redhat.com, jgowans@amazon.com, 
	pankaj.gupta@amd.com, papaluri@amd.com, yuzhao@google.com, 
	suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	aneeshkumar.kizhakeveetil@arm.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 11, 2025, Shivank Garg wrote:
> This series introduces NUMA-aware memory placement support for KVM guests
> with guest_memfd memory backends. It builds upon Fuad Tabba's work (V17)
> that enabled host-mapping for guest_memfd memory [1].

Is this still actually an RFC?  If so, why?  If not, drop tag on the next version
(if one is needed/sent).

