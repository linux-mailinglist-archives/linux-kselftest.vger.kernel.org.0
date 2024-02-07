Return-Path: <linux-kselftest+bounces-4245-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB6F84CDCC
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 16:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2531F21389
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 15:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947D97F471;
	Wed,  7 Feb 2024 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kE//yfoY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA6A7F7C6
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Feb 2024 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318938; cv=none; b=fBbXMsgtLftTL3l10iBLrHzGS4QVUtQ/Ak6bWMhlJIkp1upZrXYsZ+MScxFCGvq8QBNC6LDlEX6vaDvoieWonS1VjQKHbEhcB/ap16WdcStYz6D19S3NWA+C1nXQHLNRMHTiZhcByeSVZfhWaZXYA91qXJttRBHAA7rvkxU+cjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318938; c=relaxed/simple;
	bh=+5gAsmpd9QdKp7xCjs/9IKm5TooA5w/PXHdwwf0C/zM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WzU6g/v/yy10G2blUKmI/nYi6p5rW/ptYPy3OZwquI0XjMtpG1tfKIiJl22Dv/YRA+zYJeSXc2UBVXM+abzGgOljLQgQC9CdWe8O/O+6PXApvH176diOXkywQs26/u4/he1Rr0oMAOnrRZrAF+wl5e/Um+BYNAgsaPsb4xiaYVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kE//yfoY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6049f6b7406so2872807b3.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Feb 2024 07:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707318936; x=1707923736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEn4KucfVwWnA6ONVB1s2d+K8L0IxI86qXgAYuZM0Tk=;
        b=kE//yfoYcQrXOncvzHqq8pth1y6c4fU/MHZhza5U1FfNM7YjOiJLiY/oMY+3e0enFD
         Ympu34lvB73M6/0deGhppliXcKsv90XMjuUoppB+KC5GenPAJ82yUQpTZJBY9ze5vqJJ
         bfqdxKvdxs79w3pnkAopoP7b6Uetq2u3sOj4Yrlit1lUmu5smKQJlq1PXMhv0pgibvxW
         AI2e37JUEi8VPF0G6t6v3NagBsgDHwmusdQfYZJTREZ0wybL5gJ4dSIfJ+zcVXcVScXr
         0UuLuqZJiLvl0nH8Z+QmOBqtrhCo7q1x27y1aYwD9/0tFSooLonp8x0I3loKkCQ/hDdb
         yPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707318936; x=1707923736;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SEn4KucfVwWnA6ONVB1s2d+K8L0IxI86qXgAYuZM0Tk=;
        b=uCdrAgWZKzwMm/Uj1HWkY+mxs5X85nyR3EyttgI8GEFZ5TH8d89Q+3TU7uwZB3Kgex
         pIukXEyQghlHH5k2KAh6yue7SIVMl1vlB/7lXnEApiWy57+z54GbQnmRyqvM2WGPdiaU
         GTuofJ+G5guahpkAn3xOrrn1p1rprdG+I35tTX1X8l9zXBMVhLwFE+Y8sPAI5a2IxGWV
         fchFrH+bEDViD6Xdw7rqJIvYDglJmmVoECXbSs8jpqUw1LY+AOkN5Ja5LPJAQbOAmJGh
         ZcmwQogLZ7KMJNvSLcuc3SBrL+iwWNeUa62vufpA9chws6fdD/YBN/BtTG5InmC9GRO6
         O6sQ==
X-Gm-Message-State: AOJu0YzgnOmHmyZNUk7Dq6PoqqaIvuT0ymMAIoWh8VqeDWOwqAryWqeI
	e6Ak8uczXYaqk/bEa5U2/fteGRGh9YHG5uXVCCm/db4VOg70NELE6wKE9zxJspMgb9Nz+Gela0T
	BSw==
X-Google-Smtp-Source: AGHT+IEFZ+SP4R0EEFAHlwFzyVCVMNE8xnvlYJ09UyF9xPMQ49VRACOjvraPRowOTS/BI6HZPeFFmoALbiM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:39c:b0:5d3:5a95:2338 with SMTP id
 bh28-20020a05690c039c00b005d35a952338mr1120972ywb.9.1707318935989; Wed, 07
 Feb 2024 07:15:35 -0800 (PST)
Date: Wed, 7 Feb 2024 07:15:34 -0800
In-Reply-To: <a7f375a2e60eae85ffa69f6e60ac6a8cf18521dd.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240115125707.1183-1-paul@xen.org> <20240115125707.1183-4-paul@xen.org>
 <ZcL2Y1gpRG8C1_8f@google.com> <a7f375a2e60eae85ffa69f6e60ac6a8cf18521dd.camel@infradead.org>
Message-ID: <ZcOelockFh47Xu3s@google.com>
Subject: Re: [PATCH v12 03/20] KVM: xen: mark guest pages dirty with the
 pfncache lock held
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024, David Woodhouse wrote:
> On Tue, 2024-02-06 at 19:17 -0800, Sean Christopherson wrote:
> > KVM: x86/xen: for the scope please.=C2=A0 A few commits have "KVM: xen:=
", but "x86/xen"
> > is the overwhelming favorite.
>=20
> Paul's been using "KVM: xen:" in this patch series since first posting
> it in September of last year. If there aren't more substantial changes
> you need, would you perhaps be able to make that minor fixup as you
> apply the series?

Yes, I can fixup scopes when applying, though I think in this case there's =
just
enough small changes that another version would be helpful.  Tweaks to the =
scope
are rarely grounds for needing a new version.  I'd say "never", but then so=
meone
would inevitably prove me wrong :-)

