Return-Path: <linux-kselftest+bounces-39126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3299B28891
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 00:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684053ADE15
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 22:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FD5280A2C;
	Fri, 15 Aug 2025 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0JMnMesD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6947015855E
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755298346; cv=none; b=aferhU5vW2MWd2CIS9wn3IEce4E7keXKKBKODoQfNa5GVMcN9X/EbpGXTvU/2TjoZVoMwkj/KBsuQgiD0N2UNHIzF4zk3Pbcx6RTA4IgoNNrOvPPHVLzav7YHHVrTtr056Cej/fwt9bhhTMUJ8GxddUU0IbGDJwZ8zH+2aGLXMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755298346; c=relaxed/simple;
	bh=K/wYqwonycmklyJ5/DgqlS1Uy+2TdihuiWzWz12ccbw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H5Q5+prkFZ2m3nVYfBN3Aewqd2Kq+dVaJwircxDcMy3wTrfKXo2TQWAWT0K/Thb5ncuBse1rYNg/xiBOkySBiUmd2l1wcRNebNi6wGBnW9YwF9s1RAFj8Ag30toOhsiUeZXPoDN1WlkEQKBIl7NTRGsfQQyrsWSUgz6Swbc7Ezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0JMnMesD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326bf571bso4176665a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 15:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755298345; x=1755903145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+Te5pIYiAmG0oRIPBD1Z6ejvqQFlWYw672ZGrfsn94=;
        b=0JMnMesDMC6V4mt3HJ7A427nO7IlUZ4ukfDoG5M6Y+g6pliALlS59Es1cTZ+pWe6cp
         FLynaHEbH/Z5onZGJwpmt/xODXIrtBQmjvGbxiGC2lRNSPLDOfuODRfk11jKfK3nmx4r
         ZGkK55QLGguH9g0haF6BIIz/mr+NXzlg+9gYNIGdj5xfK4dGFSysI3ApRU/2JdkutZSu
         hKHjnRphxfFB0DzyPQW1wewVI29rfa/3Caz54dgZm2dxzEu+oZ2ew/lxw6M5s+tc9/Lg
         WdhDw1+X2d3rk1libTSOm/aLEhGPOPrdqbHCd/qs2XagM6ndPifxdipbm+uhZFnurJlS
         XT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755298345; x=1755903145;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N+Te5pIYiAmG0oRIPBD1Z6ejvqQFlWYw672ZGrfsn94=;
        b=p1+FVt0spIWK7F3n+l2U3hmSfJRJic10rVnbECY8dBrwbH3xhCSOpSnjjS+xadsWXQ
         iCxTDnGrW3Iton6LxZmDoYJe3SjEFcGj/yM0Gh8PtcIIiW1yIyPYZhinE5IhVrmCybh9
         B41c2wacOrNATvQvfhi0Qyllmcxdt3BA51WGE1/n8dXwQ+ldy+7jChxfa66T4EmIsv0v
         Uht0O7GI9Wiu1USRsyFHQQY77V+7eacIXuFVUOgfCT1MENOqbjmgwceEO5Z4EuF9KgAL
         oRnaO/zSLJhfM42gL/9lq62z11uwMijy4/zc10nXWA3Vi7fGwwsP1HespKTezyogjYw3
         Y3cw==
X-Forwarded-Encrypted: i=1; AJvYcCXJymHqw5XBQRXLeOzFilfPGNtCi9XdgLeIH1Xp9r2Ux1bqeRGyUl2BwKCW5tJQO7PaQkBiB61e37kzvtkz+Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUM6mfpI71nNsEE0XSRG8y+Ci9Q/UJbm/U4byEHngYCuJPLPuv
	zpf2layEuYRuQlfFmesQU91Tu6lMPGRPoIeP030BYpIfvGBN4I+DvpxaXADpLP6Z4fy+7ncYi06
	CdcIMww==
X-Google-Smtp-Source: AGHT+IEv+UJAB/6+TZfmF8Xh+vBJ3l/eBNjM0pOlbutUgEhFPbzx0x5t1mtIyCzUBXElTaWSG/PR3FTxuRM=
X-Received: from pjbqx15.prod.google.com ([2002:a17:90b:3e4f:b0:31f:d4f:b20d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55d0:b0:31e:94d2:c36f
 with SMTP id 98e67ed59e1d1-32341e0e6efmr6091256a91.8.1755298344805; Fri, 15
 Aug 2025 15:52:24 -0700 (PDT)
Date: Fri, 15 Aug 2025 15:52:22 -0700
In-Reply-To: <CAAhR5DFFRRV9hH3VOmZqb6TArcZL0=893oi3M2rZgVC5Bu-vJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <aJoqqTM9zdcSx1Fi@google.com>
 <0976e0d50b1620c0118b8a5020b90f3959d47b4a.camel@intel.com>
 <aJpYWVvNXjsewl-b@google.com> <CAAhR5DFFRRV9hH3VOmZqb6TArcZL0=893oi3M2rZgVC5Bu-vJg@mail.gmail.com>
Message-ID: <aJ-6JpHD6xhAvZPy@google.com>
Subject: Re: [PATCH v8 00/30] TDX KVM selftests
From: Sean Christopherson <seanjc@google.com>
To: Sagi Shahar <sagis@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, 
	Ryan Afranji <afranji@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	"pratikrajesh.sampat@amd.com" <pratikrajesh.sampat@amd.com>, Ira Weiny <ira.weiny@intel.com>, 
	Roger Wang <runanwang@google.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025, Sagi Shahar wrote:
> On Mon, Aug 11, 2025 at 3:53=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Mon, Aug 11, 2025, Rick P Edgecombe wrote:
> > > But Sean, if you want to save some time I think we can just accelerat=
e this
> > > other reviewing. As far as new-fangled features, having this upstream=
 is
> > > important even for that, because we are currently having to keep thes=
e tests
> > > plus follow on tests in sync across various development branches. So =
yea, it's
> > > time to get this over the line.
> >
> > Yes please.  The unspoken threat in my response is that at some point I=
 will just
> > start NAKing KVM TDX patches :-D
>=20
> I'm making good progress and the massive refactor is mostly complete.
> I believe I should have the patches ready to review next week.
>=20
> I'm also thinking that it would be easier if I split the series in 2
> or possibly 3 patchset. The first one including the setup code and the
> basic lifecycle test and then the rest of the tests with possibly the
> guest_memfd tests in a separate series. What do you think?

Yes, please.  Even if we end up having to tweak a few APIs when the fancier=
 tests
come along, I think it'll be easier and faster overall to hammer out the co=
re
support first.

