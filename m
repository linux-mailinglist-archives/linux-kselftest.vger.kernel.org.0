Return-Path: <linux-kselftest+bounces-38712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73060B216D1
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 22:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96EA81A20F0A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE582E2DCB;
	Mon, 11 Aug 2025 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6hqc4XA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3412D94AD
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754945628; cv=none; b=KLgccxmHZjGV0T77LE/77p+0xLFzjJ0fLBEJngJQUQDYnTuEF1976jPHw4J23hyqPD8XTAGpN+8nldikW8jwCFXYRNQL3W6RwG/zLQ5mB6FS/I6TZFm53txRbL4r21aP5kMi4v1BZDaB1Cc7vttx/bFc6FDDlxGNxKUCXCjUKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754945628; c=relaxed/simple;
	bh=JAqQRpQuRD1gv5XSPrDmnd2nskW03QCSTIn0+0VPuag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W/DZshurHQsqSrTf4EOQbFr4tjs4e5nHNK/mE+W9cq80u5pV9mInAQrBwLS1rHHJ8pHAQ/vpVVQSwMgSLSj/PG71KxUFdWO4HM3HjcluH3sbNTs1rJ5mfyVxdrXEPhy90Jbfd9IEz5UZJ/MOQ/wAeVZWxHnfFyX+sdhPJnz2yrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f6hqc4XA; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b42a54b7812so2661513a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 13:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754945627; x=1755550427; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OIjVfeNq+ApcEX/TD0b/1d8mPe0JYmLtItfn+lVbGBE=;
        b=f6hqc4XAtmSp4LaqoiFu1kQ0VTvQMysRApUX5E8TFOKP3Np5v/MvJU58j4Lm0Gw/yi
         6tkZM8viSAmLKg7oUBzi6lyZ0QjS2OgbjvYibxvuHlX/bt6IoNNQJXtHMpgHGOoxfcPP
         2JJVvUBdtTM36fYWRfFMsdiKuNhtq+ZKal34tgk7Tnqho6K4WNJ8HLWpR5NhKAd8I7jf
         GRSpsAqF4753xLoJrtEzMk1dDTuY9jzhSbWetXXGxMUozUKxNznrCqwO+USMAK2zRvLL
         NKZx0L5vGwAiaUAdNGtvLyiBE3Pxe03AOKG+IitN+E57sxSNZb+zW2vRPHh53YvesJtT
         6W/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754945627; x=1755550427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OIjVfeNq+ApcEX/TD0b/1d8mPe0JYmLtItfn+lVbGBE=;
        b=H74sLeGDvi19ccDUM0Ttocu8ik9tX2i4EzY/TSmVqKwtGpsdumZS8pRDDD0gccnOAX
         OkmkWK3P8lCKlZVhPLFC4zurr/kYASeoudd8dCMMuK6TeyvNL2S9J3yAL8Lvs9qH7Wbk
         FV1HcaSkt96AN2lL1YV3s5V7CZl8hgj3hS4c7n4oftFVDfT7mEAUn4HOe8DYw/8iUAlO
         u98nJNkoIpYrIgkD+tRklL6/VmoDTLnVEqsiS/SXc+oCBGVCT+WZdN+74tx2Ugoxdj2e
         6qAUQT2qYyxZyqX9Autq8FgiusA0Ex2o3rFQ7Kq5qBjdzCQw7Mj7ScBknjmGuLLULUux
         g8Jg==
X-Forwarded-Encrypted: i=1; AJvYcCU/KsNJmUVG23dA6tNuIgUAUL6gsUiqspxKOBI75mXY+Ov2n2HU1rMJsjn0yfOXoomyAmT+7NjCHBKlyupZMNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz67DyunckrhSkbpSiv9SeFggnGgKDYPOH1/GLjhSPpkvjKT2gN
	6swYGZKQYbMIIbk/UbGZnu04/vQdDm6KegyK8TKueePrTcov1M4SJHapedeRjASVMlV6ywKJj4G
	dvEoQuA==
X-Google-Smtp-Source: AGHT+IFQy54dyug1fwyF7mFE+kG2LTj1gs6Ocg/a2BRYAoLkWItNyzLA1YfJte7cQL0UErIPYnECfSs/jDA=
X-Received: from pjje11.prod.google.com ([2002:a17:90a:630b:b0:31e:998f:7b79])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c7:b0:220:ea90:191e
 with SMTP id d9443c01a7336-242fc1fcf98mr12784565ad.4.1754945626697; Mon, 11
 Aug 2025 13:53:46 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:53:45 -0700
In-Reply-To: <0976e0d50b1620c0118b8a5020b90f3959d47b4a.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <aJoqqTM9zdcSx1Fi@google.com>
 <0976e0d50b1620c0118b8a5020b90f3959d47b4a.camel@intel.com>
Message-ID: <aJpYWVvNXjsewl-b@google.com>
Subject: Re: [PATCH v8 00/30] TDX KVM selftests
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "sagis@google.com" <sagis@google.com>, Erdem Aktas <erdemaktas@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, 
	Ryan Afranji <afranji@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>, Ira Weiny <ira.weiny@intel.com>, 
	Roger Wang <runanwang@google.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>
Content-Type: text/plain; charset="us-ascii"

On Mon, Aug 11, 2025, Rick P Edgecombe wrote:
> But Sean, if you want to save some time I think we can just accelerate this
> other reviewing. As far as new-fangled features, having this upstream is
> important even for that, because we are currently having to keep these tests
> plus follow on tests in sync across various development branches. So yea, it's
> time to get this over the line.

Yes please.  The unspoken threat in my response is that at some point I will just
start NAKing KVM TDX patches :-D

