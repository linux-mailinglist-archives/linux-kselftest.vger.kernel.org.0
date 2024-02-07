Return-Path: <linux-kselftest+bounces-4216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5056784C36A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 05:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8801F259D4
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 04:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0509610957;
	Wed,  7 Feb 2024 04:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BvFTjn0y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571131BC22
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Feb 2024 04:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707279249; cv=none; b=iqndDkDYi2LNVUfvOPFMNe0gP8Bp0J2/Fxfcr6JGriZ4ubWgt/DknGEaLNQkHtXLMTcOMvNFzAaCsn1af3vHeFpY1ExS9T9MLX/sjFuZTU5F1OVmLD9v63EaguipMspAr5uT988Bt2lt1bPvEFt3x6kwaH1BQcCU56vLJx3MDSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707279249; c=relaxed/simple;
	bh=rfUNLTlGw19FsUppZijU0qVdUB0SA34XOGdj75UFOxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dg10CXeffNKLTEtSzH9ROvweDLhvEYnQv7jVVP/wxcuWwR9oprqOBfmGJ9LnPs6bkT7A25SZsPDzx4u8Y4FwEnyiyKXijcyhjQqGN0Cyfvz0akcPRqZblpPUCM5yZ68Cos7ZpFeJfRpKFay+oqdXy5q26o0D8LhF8/RQLsytjH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BvFTjn0y; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6047f0741e2so3505517b3.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Feb 2024 20:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707279247; x=1707884047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=749WbrUv1FQoFjL/H/9KkDdXSpncARgezg9SxCgFfJo=;
        b=BvFTjn0yEtZk1B/Fz4xk6uKt5bam4c9/9dg0dXo2QRGIInZrDeS9tkDCQ2uwyox16+
         O2XZ4ZM8Kyxfydml6jjqo/b4pJfJL3ICxOcO3xLxD0rn5vCAPNHsZFc2B2OEi2reaO6K
         czoYTykCDCUgBHVcC6KAqYSTo8sq40F9qWxFzTvZHsBhTUTYQcJg5hLF1MUNKppC1nXC
         WQ5Jqz7fpn9V0WwGcpQjIwHO0W5Boo6z54q+gRplJ5I+U3FsNZcZK/lK3ZR/MoJnO88L
         xGALxF+gT4rFr38JT40Zy669nn/jylG/TD8xE0IWHjKSz+/yz1Srq7rABfw2oW/wqIvX
         fjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707279247; x=1707884047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=749WbrUv1FQoFjL/H/9KkDdXSpncARgezg9SxCgFfJo=;
        b=q7/jJIColgbdlaAqT9wnZuPHB88wLXBp60R7Sfjec302urU65pOdVfz7acpU6sykb5
         csI2O1UHZao2haOOTyVZX5QO01RTBskN3AkuIwjQhLxp6Lt2A+DQaYnXT2AwGnR6fbPV
         nvsPUthwyF8kgS2BcEYgbpfHk6w56595qHbKk0YhcuzbGG95V7eFhcHLeaTQCY24kzzx
         2rCic5kVKGGYEnRfabwAD1othLil2JWerrD54lxTdl3Yy3Ts8/Z2fbh0IurTh9cpu2j5
         GmJMsg0VwgpmkwpMTy+nz6EVEUflVkzYo6bQjiLni8qzhT2g4fIpP8auiltxNcQkrfZV
         yqjg==
X-Gm-Message-State: AOJu0YxErgsFnnNYYIkc6X+WYW6eGlm/EEQloLvlNlhokwhPoGK+lAZ2
	Nhn5SB+vUihUl4EYWkqR+ztStTOSN/51e8SKoaykzN8UJyyx0ochYbIkz4NzEWoLX3LLTdDdmEx
	zXw==
X-Google-Smtp-Source: AGHT+IH+pbET44xcyl9LmoSjIUBSr1gsMyHHpDv3qKym8rEGE3UrAt3fQcAm+ZmYH/Szy3eNuYEcQRazUVM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2186:b0:dc6:ece2:634c with SMTP id
 dl6-20020a056902218600b00dc6ece2634cmr151759ybb.11.1707279247353; Tue, 06 Feb
 2024 20:14:07 -0800 (PST)
Date: Tue, 6 Feb 2024 20:14:05 -0800
In-Reply-To: <20240115125707.1183-14-paul@xen.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240115125707.1183-1-paul@xen.org> <20240115125707.1183-14-paul@xen.org>
Message-ID: <ZcMDjZ2t8XflbIpD@google.com>
Subject: Re: [PATCH v12 13/20] KVM: selftests / xen: map shared_info using HVA
 rather than GFN
From: Sean Christopherson <seanjc@google.com>
To: Paul Durrant <paul@xen.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>, Shuah Khan <shuah@kernel.org>, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

Please stop making up random scopes.  Yes, I know "KVM: selftests:" is too coarse,
bt everyone doing their own thing is worse.

