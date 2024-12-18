Return-Path: <linux-kselftest+bounces-23530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 841E89F6D95
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 19:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45501654CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 18:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8F31F7570;
	Wed, 18 Dec 2024 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GW1RvqA9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C561A23A4
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734547584; cv=none; b=EoMYxptniQVUoDnTq7kSRghZklitwo+BAbbD96qsqP2XFJLqcNGiwYFC0TexOiN/4w0wj/SivYmCJUZpDpAkl+7z9NArULLMtN/vu/F/xTG4BmhHJqES1aLPMqrUlpqhGSRntrehnlK7fCJl/haey2t8xqWIRneu1I+mYHQqPi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734547584; c=relaxed/simple;
	bh=54aEEBZXu5l8G8dSNrScl0HgsJCU88tBZMrBdnnGc+M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HzXwkK+5DPE/Pf+2VVVuc7NEOlb40cDHhC1FJWTkHmNRBDl3LkZuHRweoNq1Ee8pPw6LuzDmoTKSNU/ISnNt3MK33CQp9no8WYav2iNQEorAjDYMTW7IUCO3vUjIPnSnO4Hbo97aefk7Gc2yQADCtRxi95TrzipEf0BLg+glqmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GW1RvqA9; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6d87d6c09baso101792716d6.3
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 10:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734547582; x=1735152382; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ThSbZiShkgu5e03SVywCH9ZkF+kD7172meNNyMCsukQ=;
        b=GW1RvqA9cxFsIXcoTi218BN8O7AmZiHZErTlgeE7U2HJOuxSYW+f6vEDjB4D5WI1R1
         zFL7GiQmBWxwdMd2kRjWFDQdbDXv0cUy7rG7gkhWUUCwZ7mUUErK23Zpl0P4bSjrbnDD
         Q6i7lEiiUQ/3AzEHaDYLoE5aZBERYPAtBjHDhzetqRyw893fIk15UmzBFswkhEIsqQ4A
         Fvau1Xm16cfL1xkFsZYNmPAUo9zbL3ObagMa31OlC7UzqCmuBbQ3BhYmM+GhVb1oYETg
         sjyzHIpyLeupjx7iRTjifncyLAX8un9sKeYtudsLvBD4+8F2PqtIF2xbB8THrMlvQ6lJ
         TD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734547582; x=1735152382;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThSbZiShkgu5e03SVywCH9ZkF+kD7172meNNyMCsukQ=;
        b=QdLyyloJvejpRO/mOn8Trd5crPpnH3lhZkJeNTzyuWKBe4XrdNMOl92PIKIi5R2d1K
         weh6JY2qkmXBq1aaebDhy1dywS0KWpLKwuLKydE33P0J3GuydQk2VZNcxsku67wz4seB
         cCPNqdlsUle17JRbQyn1RsEWN9MfSSBPtEs3fWT7YukXWr+8wrG31XT4jyOtgR1dUtFp
         8bDSeB+uzxLQV5G6DxQqp8GfuP+cGBsb2i8ywsK9OVBLHSLEy0yvvPMgZsRLT6gPsGPt
         KTpK35XzOsHv8QEhAnETbr/95h9BEbnqw6ePHLSLSPXiQ1l1HA0d/gq6gbOmS3KfsSH0
         g2Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVknD8nzPR6iEl1IlXxSIJsChdfsrMGzgKVjdLlEexfaPhmBKg8DF8GOcNUxGGz6C5npEk5OYjbz+bI3qSOMTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQIekTY3zKhYBdWW2yvW6z0pe7P2qdYnH7ktWebH+dfY77DX7
	gckgGIfT4QSmjK65EtqqO20LJPY4+PINV6ny1m3PAHPizvnhjpFzBm+sliSeHQHpNbxKAlyEQuw
	nCA==
X-Google-Smtp-Source: AGHT+IGexWYaZ1SI4kjhNWXK7opgvllRMgRXEQRWmGX9yzNrM6pDTH6/xNiTrW2iL7iCndhz2fxMorhYmOU=
X-Received: from pjuw4.prod.google.com ([2002:a17:90a:d604:b0:2da:5868:311c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:270a:b0:2f2:a664:df33
 with SMTP id 98e67ed59e1d1-2f2e91ad917mr5094136a91.1.1734547152868; Wed, 18
 Dec 2024 10:39:12 -0800 (PST)
Date: Wed, 18 Dec 2024 10:39:11 -0800
In-Reply-To: <20241217181458.68690-5-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241217181458.68690-1-iorlov@amazon.com> <20241217181458.68690-5-iorlov@amazon.com>
Message-ID: <Z2MWzyoq8c2FfJnM@google.com>
Subject: Re: [PATCH v3 4/7] KVM: VMX: Handle vectoring error in check_emulate_instruction
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, dwmw@amazon.co.uk, 
	pdurrant@amazon.co.uk, jalliste@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

On Tue, Dec 17, 2024, Ivan Orlov wrote:
> Move unhandleable vmexit during vectoring error detection
> into check_emulate_instruction. Implement the function which prohibits
> the emulation if EMULTYPE_PF is set when vectoring, otherwise such a
> situation may occur:

I definitely think it's worth explaining that moving the detection covers new
emulation cases, and also calling out that handle_ept_misconfig() consults
vmx_check_emulate_instruction(), i.e. that moving the detection shouldn't
affect KVM's overall handlng of EPT Misconfig.

--

Move handling of emulation during event vectoring, which KVM doesn't
support, into VMX's check_emulate_instruction(), so that KVM detects
all unsupported emulation, not just cached emulated MMIO (EPT misconfig).
E.g. on emulated MMIO that isn't cached (EPT Violation) or occurs with
legacy shadow paging (#PF).

Rejecting emulation on other sources of emulation also fixes a largely
theoretical flaw (thanks to the "unprotect and retry" logic), where KVM
could incorrectly inject a #DF:

  1. CPU executes an instruction and hits a #GP
  2. While vectoring the #GP, a shadow #PF occurs
  3. On the #PF VM-Exit, KVM re-injects #GP
  4. KVM emulates because of the write-protected page
  5. KVM "successfully" emulates and also detects the #GP
  6. KVM synthesizes a #GP, and since #GP has already been injected,
     incorrectly escalates to a #DF.

Fix the comment about EMULTYPE_PF as this flag doesn't necessarily
mean MMIO anymore: it can also be set due to the write protection
violation.

Note, handle_ept_misconfig() checks vmx_check_emulate_instruction() before
attempting emulation of any kind.

