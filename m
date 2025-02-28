Return-Path: <linux-kselftest+bounces-27935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F40A49FD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 18:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D951E176D6B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7432777E9;
	Fri, 28 Feb 2025 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nkk3OyNF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200B276033
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762460; cv=none; b=sJZ2V6mzcxJYQFUREBuwNVevJWc3vKB22S9fnGaw0QDek1MZ5X21z2hvx7Ut7lmhSi8YbWpO9R6SgMxE0bbyLtiOGn88f5O8Jv8Z+EdDFEX/iOM7uS2JUXKI5KUR2bZyaoy4Ol8iFOI0XQNpmPjiziXGwr7jqvedtFOEBTQmqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762460; c=relaxed/simple;
	bh=E6bnhzdYglUEbw/3sjQWwWPsFClmseZJbB5AYtU15jM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VWumrBDA8q+VfRTyVMWCPry6fjfS9FB3A2BoLbxk0Gt7EV3gzvUowd2mhHWCwp3NQOvdSDzJ116CCS/eQSTRBlNg7DzFIYoEZXIcwKn950kakMhd0Hv+DiI4smKvk7VKtuTfqd+TyYPBM3GKRaxDIAZ/rnkB4JjLA132o85HPxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nkk3OyNF; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-223477ba158so73673475ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 09:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740762458; x=1741367258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PAnLPa0VRn2NfFWgX/vf88o4ksF29qjxwagnBjCzxlk=;
        b=Nkk3OyNFIQUqzJFL1qlDe6WfYfYSMMYs+C0t5PVmlFtTTYYHGi1ipsDFERkc6wnPo2
         9uJPeLBqlJSaD1CfLmkr0/ilS8j/1QH2eUWngT9zcZb1eqI7oml7/mpgVriG00zSgx3p
         7DntxB7ANNZgrVwXQe0jdgc4PqA4Qlro8VTqKQcr93fkBYwGhsmzzdOHRg+Xuty2ie+5
         qaiStu7HjyHh0abpnItImUn/CCQf0947ABYz1+tSi2YSFwO6ofaKXJKIqHoMqTcJC2wO
         Iw/ILhpxoGa4dKyMljUyQvvlvLrPnColZdXDdVj5kLL0qQCiWbzqxrgjnL9qJ5LKRDyv
         lj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762458; x=1741367258;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PAnLPa0VRn2NfFWgX/vf88o4ksF29qjxwagnBjCzxlk=;
        b=b8+py7pgtHZQCnrvfuYFliPgdqMUPQUkKZI45QI/kE0kuytD55xn0buB1SOqfuf20I
         Ous+iWAmsUXdIRI8y6o/O1lyKkd63MzqpL8syhDM3VqMIuxm69dwk0I00nPF+06FQyJj
         TY4s1IPfDGGg4ksVC7ezFzpCKJS7zwwFyEqeyZMQbQ4FKcfNaLERmcA6J6ob5YlH2Bm7
         maXSFgHZUuBjeZFg+3aEQKjFrjbBseI+rXzgoPUYLsQYaN1pX6rLU3zQdApd2FKxnPeT
         2XsENNPpPwDIjSF+FP2w6A6/1obNtWb6dDoV0Pb1GDQlv8pbmgx4rf51QOj6hFj/Stmw
         +1jQ==
X-Forwarded-Encrypted: i=1; AJvYcCURhlF2JOFP0kU/sApbmeXs9QbNSR+Y09wuIqqCUtICqe4GZQZ93aiUG2gCWQNVg0AvOn1CnWLmNFmxWEPsz44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUM+N7i9u5KkvhLBMuiAKf1KA+IycUVaC3Sg471vbw46YpOBjY
	Go97CNOhFdk5f96iFKz2pQZnmCewdJo4ZXMSrCFumSwjAnDf941YRlKIm4G6WC+H3XlIFdkWyWk
	7HA==
X-Google-Smtp-Source: AGHT+IFH9E/WNEfyobY199bM95DrwqzdXJMQ84WirnxX6jf0Cis+A+w0H4zAFNsKPYsxVMwclKIulMvp+8A=
X-Received: from pfbei32.prod.google.com ([2002:a05:6a00:80e0:b0:730:8d2f:6eb1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21cc:b0:728:e906:e446
 with SMTP id d2e1a72fcca58-734ac4694c5mr8152593b3a.24.1740762458320; Fri, 28
 Feb 2025 09:07:38 -0800 (PST)
Date: Fri, 28 Feb 2025 09:06:32 -0800
In-Reply-To: <20250128124812.7324-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250128124812.7324-1-manali.shukla@amd.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <174052976390.2845556.13408799702754971344.b4-ty@google.com>
Subject: Re: [PATCH v6 0/3] Add support for the Idle HLT intercept feature
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Manali Shukla <manali.shukla@amd.com>
Cc: pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com, 
	thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de, 
	babu.moger@amd.com, neeraj.upadhyay@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jan 2025 12:48:09 +0000, Manali Shukla wrote:
> The upcoming new Idle HLT Intercept feature allows for the HLT
> instruction execution by a vCPU to be intercepted by the hypervisor
> only if there are no pending V_INTR and V_NMI events for the vCPU.
> When the vCPU is expected to service the pending V_INTR and V_NMI
> events, the Idle HLT intercept won=E2=80=99t trigger. The feature allows =
the
> hypervisor to determine if the vCPU is actually idle and reduces
> wasteful VMEXITs.
>=20
> [...]

Applied 1-2 to kvm-x86 svm (with the rewritten changelog).

[1/3] x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
      https://github.com/kvm-x86/linux/commit/70792aed1455
[2/3] KVM: SVM: Add Idle HLT intercept support
      https://github.com/kvm-x86/linux/commit/fa662c908073
[3/3] KVM: selftests: Add self IPI HLT test
      (no commit info)

--
https://github.com/kvm-x86/linux/tree/next

