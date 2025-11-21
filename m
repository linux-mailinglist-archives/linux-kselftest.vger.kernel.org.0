Return-Path: <linux-kselftest+bounces-46283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BB1C7B6A5
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 20:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF413A6B7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 18:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1342FD7A8;
	Fri, 21 Nov 2025 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GhNzOAZC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B656A2FCBF0
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763751406; cv=none; b=nFv5vRRB70tvD9WgX8Rp7UpSEphs+eozzpkF83iRcPiNhgLP/lARuvJxrqWCfWwHAhmpID4A89BBMHy5Iy4F8SzZVSZsagG217xCO8iY2bAKZ6nvmzcpcOH+jccA/y/SWdNFSX9QjseZ1+5If4Ba1+yB0YqDG4kylio8nNGFXYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763751406; c=relaxed/simple;
	bh=NuBF5ENbl+bXo2WYVgT9d/UQPTBU/zQ6Z2Vv6/QMa20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=cLgvPDO5n8DG7yyYSeiDizrZxGr5nq4gHAD7P4tDLCul+ICnMbsv71exRg99jHuVkpZB4ks97dnEDDS78CVwJd6hOthytihfGNvYfoaWMINqCfFaRT92yKwhniyQHSFmgg1JSPLJVjHg9DbbCFU4YaPsSlS7AGyidA3Ikw+cE0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GhNzOAZC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2956f09f382so16928435ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 10:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763751403; x=1764356203; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gf/8Pk7Wi+5ZKHSgJ1cayHET+i6n5m5sIz+x1glR7jY=;
        b=GhNzOAZCp99htaW4CshAHWJ9e99fYU4xCux4WynwdQfmzp0nhnNt2wkAKjWRNS1yA7
         igdHG2sMP47G0TeKVbE99V0drRtFX2ffUzizcH7ITVBvViXbgMqy/GUNpf+OMAdwP9vH
         ux142NPbw9cm34guZN+3jTwMJmZujCytwPng3ft6iU+gi6L1XCwySfvCpzBsJ37rHp2o
         EjiPeEBXfUU2bQLlVY658f5uaJpjLh4JMVBIrUyM6vqfnbhijRtZZ63WAmj8LOyTDsng
         h4NoBs8HGvWOkfMONSbiy7zp3LhmFEPLJ4xi/x0R3DzPGCV9p/BhhPc42QjOkxFX+lKU
         NBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763751403; x=1764356203;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gf/8Pk7Wi+5ZKHSgJ1cayHET+i6n5m5sIz+x1glR7jY=;
        b=GjiTcPW2VucSTsP3djFmDPr5z29Kh0f/LhEEwV46+Yd5f47yjmFiO6xCie+Pu6O/Z5
         N4+9/uIE7Yw8xzZre+ErukPOnmRH9yEO26CsfO3iqEyLUIBy1NBaNV6ufgqsADcgdzpk
         ibb8/yQz2Adl+wS+gSLjI6L1XVJ/8wVuVsVxZUIzOHvGzpOgBTsCT8Vgbz1tXauywZIe
         2YdVx2NOE+++Br8PenVOvLoZj1PgV/pfrtdINzJdNN6A8lan+KYVqhNwjgFOckpRhxFZ
         cTs5kf8dapRu1CH1rsR5cJyCsx+FBouOCa91TEfnIVxvrCk6bz/GhSuyddGzjIKcOSAE
         Yosw==
X-Forwarded-Encrypted: i=1; AJvYcCU4tFr02Nljw7M1xkzpRI1Nx9GKdohE6jxe4jp8mUqwjV9poVbF21Z2CaONAPy7qpnvGWS4HVS3iBCW+uqbxcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxteBkQq4FB10ahXBT+ar1dunZ3vZjNgF2pmQeGrrl6uzTNIWHY
	nsH+KTHEcq7nei9mEdcOeGNG4w6SI6g8rpvgIXeL/DfcOC0B/u3cf1Mlu6h2A7AlsYPKmvw5v0M
	riSKL7A==
X-Google-Smtp-Source: AGHT+IGl6lVP4k6Ffz1FVATVkFbVRdK/+fQjLr4mrrmG1VOjxZCvjJw3L3ZKENAl8ILCy7qu+uQ9S2crdpg=
X-Received: from plhv10.prod.google.com ([2002:a17:903:238a:b0:298:3543:5212])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:11cd:b0:298:639b:a64f
 with SMTP id d9443c01a7336-29b6beee840mr49422585ad.6.1763751403034; Fri, 21
 Nov 2025 10:56:43 -0800 (PST)
Date: Fri, 21 Nov 2025 10:55:37 -0800
In-Reply-To: <20251028225827.2269128-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028225827.2269128-1-jmattson@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <176375118181.288827.8430542805047208308.b4-ty@google.com>
Subject: Re: [PATCH v2 0/4] KVM: selftests: Test SET_NESTED_STATE with 48-bit
 L2 on 57-bit L1
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	"Pratik R. Sampat" <prsampat@amd.com>, James Houghton <jthoughton@google.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 28 Oct 2025 15:30:38 -0700, Jim Mattson wrote:
> Prior to commit 9245fd6b8531 ("KVM: x86: model canonical checks more
> precisely"), KVM_SET_NESTED_STATE would fail if the state was captured
> with L2 active, L1 had CR4.LA57 set, L2 did not, and the
> VMCS12.HOST_GSBASE (or other host-state field checked for canonicality)
> had an address greater than 48 bits wide.
> 
> Add a regression test that reproduces the KVM_SET_NESTED_STATE failure
> conditions. To do so, the first three patches add support for 5-level
> paging in the selftest L1 VM.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/4] KVM: selftests: Use a loop to create guest page tables
      https://github.com/kvm-x86/linux/commit/ae5b498b8da9
[2/4] KVM: selftests: Use a loop to walk guest page tables
      https://github.com/kvm-x86/linux/commit/2103a8baf5cb
[3/4] KVM: selftests: Change VM_MODE_PXXV48_4K to VM_MODE_PXXVYY_4K
      https://github.com/kvm-x86/linux/commit/ec5806639e39
[4/4] KVM: selftests: Add a VMX test for LA57 nested state
      https://github.com/kvm-x86/linux/commit/6a8818de21d2

--
https://github.com/kvm-x86/linux/tree/next

