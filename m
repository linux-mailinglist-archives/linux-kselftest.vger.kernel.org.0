Return-Path: <linux-kselftest+bounces-39044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2191B277AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 06:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21C4621443
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 04:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790D223817A;
	Fri, 15 Aug 2025 04:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M15DhATI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC48E221FC3
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Aug 2025 04:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755231298; cv=none; b=GhYXX6FGrs588Mxn1Mo2Ml9dGeFE5RYiQBZqfIfloI0yCfR7bsbor8w1iLRG2OGopYjjUE6nmLvNH+y8OZr2vn5i2npYYm/gQxv74I+MFaHEOhCJIxoXcy/3vTBqJDSvG1eiGk4hf2Ukcav2fjYPkqlISHw4HPmU4/AeEQ4ra/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755231298; c=relaxed/simple;
	bh=MqO7WvtgNbZKWD8uq2q1m3YqKMotdAclfYip+JQ1678=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7niaAvydJ5SUr7rRVnK7SQHjCnaofOGYmFfKWcWELq1OL/SmeLV1eOKDfElD+5VIJ6g11FslkOSLxfqjXGLXQX40Gl18aohC+AUK4Y3m8o57WoMpxBrlDSLgXJPEVcMXVvHfroz1DsuwJYj10onDI/rrqZ3dnOAC6hMEEmB610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M15DhATI; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b0bd871d9aso192891cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Aug 2025 21:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755231294; x=1755836094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/Wbp411RtpskyWq9UJk+ehIJ35XDzwl3pNsoidpEgk=;
        b=M15DhATIg9ZLyITdlZ8kuJAVFEJjNZOgOMXgTCMbKXfw/mXLtLXsreTlkbZQ+ZwzLk
         3ZOzcJcPq+8uFZ9YQM5tnJaA9mMnnekRnwx/lpuCb34JRd7VyvFEjMkGIpd6AHMW9DCT
         itWUewzkFpr4lWdHCSLdZB0ukDw8P12E4hIlisn38BJX2faU+8HWLYM2sJrUhcuhwr7/
         sfEu4iNPq4qA7IwsO3NOIfFBT3sSioqaII0d+M1s8IxoB7rUZ9Lvldf6SrhHy9Kbx7Gn
         b80WtUk3gaNKMytTZ781TsRGiVSSC4ZmywdVdfhsRU2z4oXUKKAuMuDrg+06H5CgoWsU
         U55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755231294; x=1755836094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/Wbp411RtpskyWq9UJk+ehIJ35XDzwl3pNsoidpEgk=;
        b=eH7+AEVvwrVLj42X0G9iUT2GNHvVYU8A8NczGUR3y3iHWikb8+JDsamdZ+lHylwS/H
         Hp09V1HBAJB7AQ4EvBZ+RTJCC6cEV43GOmKZJgM3uxgGHFFTo4Yq7MhIXpS6Yikex6cm
         d5boYS9xvgwag7uC7jTaa8avlwRoZ/Qewy1WW2vHRPma/tP7uqDXtVouwXaVB+nn6CzC
         +PtsJi5Ewsuu6CPHMCkBCdwQKOh+ioinYYX4vCPwm+rN74Rf8027NPB5ln9vCfdbht3/
         o0KVmrb6I84YL05PGOKZXz8kxDXml5hGOt5oAIEJUPaw9KEPDMlqhi/dQqmlsiJ4AhXY
         45OA==
X-Forwarded-Encrypted: i=1; AJvYcCV/DBQg/vhv2jvlFRulLlZLW+BM2PnjFmWLOWmV6NmtSIpFFdULF2pAOlQq3YCqeXGbGsp/YRX5qKPYjlWCYv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQjVV1H2u9NafcTlrT/I9PFpIatQJEYnnPNbOy65OjSDcpu3G
	CT7ApCPufTJSWGpekSzI239KokczLbiDrJUMn/cbnwC9ONv8Hn2DBcra90GS8ctdoUDQvB70cr4
	NtYdzUTzTT99vW9kmyuMcfi67hMSdRFutlrNczfVl
X-Gm-Gg: ASbGnctXXQ/UtNvtUXnrTbAZA3lxKmOUC71TLEzRB5ojR1ndiyZnqtbjeVMGJUOkk31
	WjMh3+UtA/myIblkNcpXGioyWZBdxiYc8Hp4MfGBKS7EhW0m4vlBOBWGNqHuWSKGB0J9LzyGfxh
	peDQOGhw8CtK40GH0FBxOiWB1cKguF9QdELqA+07zdKEaA9QI0+aokuYCDMTM0WNrf3mxySMF8M
	YKbUoEtc9HEA6IFnWP4IvgqlFhmeqck+PjbroZTiYUb7/J7/3GFaNKA
X-Google-Smtp-Source: AGHT+IHdLyoV1GqzsKehbtyyH1BP6XiYh4lDSXbcDsgyxiNyrdnGC60SGOUsn4ECO9SuHxVLTaL7GG8NefWkx5sU9uA=
X-Received: by 2002:ac8:5d88:0:b0:4a7:bed9:5251 with SMTP id
 d75a77b69052e-4b11b74a91fmr1955601cf.9.1755231293609; Thu, 14 Aug 2025
 21:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com> <aJoqqTM9zdcSx1Fi@google.com>
 <0976e0d50b1620c0118b8a5020b90f3959d47b4a.camel@intel.com> <aJpYWVvNXjsewl-b@google.com>
In-Reply-To: <aJpYWVvNXjsewl-b@google.com>
From: Sagi Shahar <sagis@google.com>
Date: Thu, 14 Aug 2025 23:14:42 -0500
X-Gm-Features: Ac12FXx7pDBZJH3JjanZX38nHfaWFcUbiCvl5vzB97rX8vXCUsDbtyyRYTosMH0
Message-ID: <CAAhR5DFFRRV9hH3VOmZqb6TArcZL0=893oi3M2rZgVC5Bu-vJg@mail.gmail.com>
Subject: Re: [PATCH v8 00/30] TDX KVM selftests
To: Sean Christopherson <seanjc@google.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 3:53=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Aug 11, 2025, Rick P Edgecombe wrote:
> > But Sean, if you want to save some time I think we can just accelerate =
this
> > other reviewing. As far as new-fangled features, having this upstream i=
s
> > important even for that, because we are currently having to keep these =
tests
> > plus follow on tests in sync across various development branches. So ye=
a, it's
> > time to get this over the line.
>
> Yes please.  The unspoken threat in my response is that at some point I w=
ill just
> start NAKing KVM TDX patches :-D

I'm making good progress and the massive refactor is mostly complete.
I believe I should have the patches ready to review next week.

I'm also thinking that it would be easier if I split the series in 2
or possibly 3 patchset. The first one including the setup code and the
basic lifecycle test and then the rest of the tests with possibly the
guest_memfd tests in a separate series. What do you think?

