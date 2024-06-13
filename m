Return-Path: <linux-kselftest+bounces-11882-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 053A4907A89
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 20:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E74285BA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC6114B091;
	Thu, 13 Jun 2024 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b4Uve9c7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE914A62F
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301642; cv=none; b=bs02cpz8rJLDFWdiVzUqObhZJkkUHIkXuByMEpWrJKLQPK289PCHTtYYgGcXf4tFVFO4mlF7tAtkiXj7IyNCHzKd8z+sDCVZN63jpaNpgKG7lBKYdfEtcgzi885x5nlfChp27qlmzRzZjZyrwONw4LJezqcLyfSkQ+koKkRudqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301642; c=relaxed/simple;
	bh=bMYdPDIxNJ3qhBrWqIO3ZN/KF1PRoqTufoa5UZq514c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pBya3fVV1335YI7aQ4EovbF8fMDNczUDcgP6c5K03cCJj0E4BQIG/FzPw8nKMXYbXsh9TRaEq6v4DrLKPckh6GyiFFYfKdGudwV3ABZ7h/ALUdrgKoIG2sNG65U5thAPeigDANY88VVt4qONK2oUigNiXYFOyA45Pjy54Nf5se0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b4Uve9c7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6300aeb93dcso23408067b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718301640; x=1718906440; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pwOI9B4Rf0kKuFHv5dDa3w4fwvMaD7f4mQqGVSuxMFM=;
        b=b4Uve9c7SxcAoumtv3KhzyhydbfRxh3VGo819luUN5NK/V4hQOJcQrzVzjar8PnTfh
         rbK8wV8xRC62QPI48kIifXA/rRMefNZEeW6PfiR+5MaaNVuqChFBSp0oWjUUB7uGvgre
         ZcDFMyi8CdU5vKBGk6q4bQAyYpnNzoimPhbkf+z0mc4H1Ag05mUWWJWejkXoylbecUJK
         p3Ib5AseD7pl3gKQf5G1OAl+chq55pB2ZofyGXnUiH2Kh+3owIYKGuhAPoXwAdef0HHH
         pKh/rbV7efLz7sAnxrzoTDtmxYrz43sx5czMQdtfkz7UYObC37sRufin6n4uX92qyGEU
         maHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718301640; x=1718906440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwOI9B4Rf0kKuFHv5dDa3w4fwvMaD7f4mQqGVSuxMFM=;
        b=Q2AdbOpsyUZOto4nR7pldCG9kJy6b+ldnH263gB9dbZ0IKluhydvaHd2f8so8TMdzP
         WKKv95qLxatUnoKyWX6YB2EBGQuFyo0NZkO1iDFZxxb/Zj+ePGIjLKOLqbFo9coolL31
         LA34aZ0kZvxsKKfVwcGJzZnO2D3yIyWK/xN2Q6QwhZlg/uHE9i0IkEU59AnmiNAzp0eN
         TXDyz6UvQEc68fZNIBh/domN/8czELnm+h7AJm8eR8wj+mhkOeZA7E+PY1WPxi1GYujm
         5j05LSozgxY4N4CrMySQX5Pt+TaGEWIXmrI4oZcqH/mFe4iHkJgpr/06RXEvTbm0n/b/
         3tHg==
X-Forwarded-Encrypted: i=1; AJvYcCUCdIG4IGe5LfuHRQNEWuZo0fvxyB18+yvryC+HpxyAXiHGbdpRtaxxhCfisd9OBhluh0nbJKpEMCHsAhRm9RwtNESFfdop+zjkOih7ySLB
X-Gm-Message-State: AOJu0Ywzsd0IABqvACQyfNJDd/D7WMK8WwYInkeNy6dutec/eoAnFP9Z
	HlA81UMHtVEDLliThdb5+FTPGk03mOpzbpSOhc/DLr9qx2mFZUT3Nj8v44+Wog1wik3vC4WxFC6
	4DA==
X-Google-Smtp-Source: AGHT+IFN8tKIBayasU8DW3XdJWf7PW+lLe7/UIpaOmjMaWPIDA643Amk6HTZzKGnrNvuJ9kWeEpi3On2/s4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1202:b0:df7:d322:97c6 with SMTP id
 3f1490d57ef6-dff154744b2mr21904276.9.1718301640506; Thu, 13 Jun 2024 11:00:40
 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:00:38 -0700
In-Reply-To: <ZjCqFxA+e8g43pCm@chao-email>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-15-xin3.li@intel.com>
 <ZjCqFxA+e8g43pCm@chao-email>
Message-ID: <ZmszxgbIbYSaXyjW@google.com>
Subject: Re: [PATCH v2 14/25] KVM: VMX: Disable FRED if FRED consistency
 checks fail
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Xin Li <xin3.li@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	Ravi V Shankar <ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 30, 2024, Chao Gao wrote:
> On Thu, Feb 08, 2024 at 01:26:34AM +0800, Xin Li wrote:
> >Refuse to virtualize FRED if FRED consistency checks fail.
> 
> After reading this, I realize some consistency checks are missing in
> setup_vmcs_config(). Actually Sean requested some infrastructure for
> vmcs_entry_exit_pairs to deal with secondary_vmexit_ctrl.

Yeah, this belongs in setup_vmcs_config(), e.g. to guarantee that discrepancies
between CPUs are detected.  I would also strongly prefer this be squashed with
the patch(es) that introduce recognition of the FRED fields, if only so that we
can avoid "consistency checks" in the shortlog (I thought this patch was going
to disable FRED if a VM-Enter consistency check failed, which would be... interesting).

