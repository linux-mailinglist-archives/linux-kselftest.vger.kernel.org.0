Return-Path: <linux-kselftest+bounces-12477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F11912EF5
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 22:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF131F269E8
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 20:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CC017BB12;
	Fri, 21 Jun 2024 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4GUlcQ7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F11416849B
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003192; cv=none; b=QLOhDSG3Ih8M49pvwKv3QkNhIYH+mCwa7t6MiCUu+BJp4AqEMTDRKGwUd44HeYEtpvbNXqyS+smLlD9GIQSe5UrCrHA95BzbGWfnkunLfEk/yujSFUalTXdgWGMVXaNsNbgk/MGg7yIIm0c2q3NgZXIDvuTR+gdFLZX33+xCQzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003192; c=relaxed/simple;
	bh=rNfoq+8POw/2x7ECzvbevoKORYx0tmJ9mHwOajtgDnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOwZk3a13owr11+7xJm9X/dDWzl9VVMNlH9WTtcGYXV4r3N/iZtMeA9tYysk8/trL8N+iP4qifomahOJWVS2Hf+K9oi+NG53Qme1OkJlgfnUB4g12+l5iDWl9+zN6nuAw4rIBi4x4MtEqowcTkvsNEFRwFIvQshfiIPzMvn9gxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4GUlcQ7; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52caebc6137so2680720e87.0
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 13:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719003189; x=1719607989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNfoq+8POw/2x7ECzvbevoKORYx0tmJ9mHwOajtgDnI=;
        b=C4GUlcQ75lx5kRaTLGZzg/7r2AMZMBJmNEdVbgxMgnwbJXZ1ywEc5EKBW9++QIZpPI
         ds57FJgGetyg1aMjBKT6vK3tGDQ5qZA9mIdUl29q03sKWPf8JMDPHU71H/IdEGqfjXEb
         wsAsJA7llawjSiYd+bsaHmEjyyci1bCR2b+ft53c2btvZE83t134BioWHsHomD+Aqbuz
         PiTR64jo8rFVLOFvbWXWF+5/pDMIzmVFG+VlajiLJjdkWTPGlT/Nu87Vee4jZb6KtGFI
         I1FSrvGRIgZk51R09NNqbGRfNsM5mm2zWAD5IUi0mXBT8UEO5MTRak42HGTaR6UfotgB
         TG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003189; x=1719607989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNfoq+8POw/2x7ECzvbevoKORYx0tmJ9mHwOajtgDnI=;
        b=vq6Cncrml0qmIAj08HhXQ3Tt5Rp0lhyRZbLkqimFEeym2dhPDUY0BmMo/shN6qF7dv
         atUDPEU3sRTrbD6gem+XSeUV/GTXYjNFeVdG/IanmOXqf4hxIHxjUb6THq+HMOB9c51X
         5Gv5m87TDgWDLTgwuzptc70WV7HyKH03IAfXiNMKf6xb6AB2jXl7HRD2RP5QD3GtxlTI
         Y1RlDIpkK1eMcT7k94WdAHZjpewIBAhMOel3oeVYRx2Z1s6RWj9bDIncIRMqVl6Zlle8
         Om27sH63NOWGtyXmXroILr/mi3CgqQWA6iff5b5XzD042+fMxt+HtADYDNCLSVLn2c0O
         qw/w==
X-Forwarded-Encrypted: i=1; AJvYcCUpPXAPQGZPq1a4Tki7LO2IVViAv8uDvDsWZsjPGM72hnz0z/1JX6lYN5Jc4FT4l/pMa0RhXdr+X2xqRfHZ4Kt5HX3zR+DGOo/8keqznF9T
X-Gm-Message-State: AOJu0Yz//3l2zDmIDiB+sCBGpAAI3gGpYIgaN3JRypJcoSHgFGHVNj2s
	/VJjfx8BvEZ4vbb82EJxaaVBcdQW2ndKdiV0zUQj2E/KXybGn64iLrfeVpKjogILsdE1LN2UYOy
	LQPUphIc+NUWiacMTD+YVqGK5QsTk9sB8cCcc
X-Google-Smtp-Source: AGHT+IGaInoc2a6ycbS1ZJm33IM2Kb+tF2cowete7+9tAforZRRYHw5ZwB2ARKCHV/65Op/lg+4fyGNVxzBBnnfs/xU=
X-Received: by 2002:ac2:4c92:0:b0:52c:db53:5fe5 with SMTP id
 2adb3069b0e04-52cdb5360e3mr1077440e87.27.1719003189102; Fri, 21 Jun 2024
 13:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212204647.2170650-1-sagis@google.com> <ce967287157e830303fdd3d4a37e7d62a1698747.camel@intel.com>
 <CAAhR5DFmT0n9KWRMtO=FkWbm9_tXy1gP-mpbyF05mmLUph2dPA@mail.gmail.com>
 <59652393edbf94a8ac7bf8d069d15ecb826867e1.camel@intel.com>
 <7c3abac8c28310916651a25c30277fc1efbad56f.camel@intel.com>
 <CAAhR5DH79H2+riwtu_+cw-OpdRm02ELdbVt6T_5TQG3t4qAs2Q@mail.gmail.com>
 <e161c300e9c91237c5585fab084101a8f46768e2.camel@intel.com>
 <CAAhR5DF=wAVsshyX-JqcPhhrVp8rEF11uJkB-OSEUM-B-oEZoQ@mail.gmail.com>
 <262ee73f23445fea7129a784ff3d6bc4294c25c0.camel@intel.com> <271e9f4168175f36f90c91fbe45e6e628e157ca2.camel@intel.com>
In-Reply-To: <271e9f4168175f36f90c91fbe45e6e628e157ca2.camel@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Fri, 21 Jun 2024 15:52:57 -0500
Message-ID: <CAAhR5DEPb3dDa9JgCoqX3hzAHDWCkvsAW-cZ6Mxe+KUZ_vCAXA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 00/29] TDX KVM selftests
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Zhao, Yan Y" <yan.y.zhao@intel.com>, "Aktas, Erdem" <erdemaktas@google.com>, 
	"vipinsh@google.com" <vipinsh@google.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"Xu, Haibo1" <haibo1.xu@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"Afranji, Ryan" <afranji@google.com>, "dmatlack@google.com" <dmatlack@google.com>, 
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "Verma, Vishal L" <vishal.l.verma@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jmattson@google.com" <jmattson@google.com>, 
	"Annapurve, Vishal" <vannapurve@google.com>, "runanwang@google.com" <runanwang@google.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>, "pgonda@google.com" <pgonda@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 9:51=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> +Yan
>
> On Wed, 2024-06-05 at 14:44 -0700, Rick Edgecombe wrote:
> > > I will take a look at rebasing the selftests on top of the Intel
> > > development branch and I can post it on our github branch. We can tal=
k
> > > about co-development offline. We already have some code that was
> > > suggested by Isaku as part of our tests.
> >
> > That would be great, thanks.
>
> Hi,
>
> Any update on this rebase?

I finished rebasing the basic life cycle test and found a bug in
tdx_gmem_post_populate which took me some time to debug and fix.
I'm going to start a separate thread to share and discuss the selftests.

>
> Thanks,
>
> Rick

