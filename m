Return-Path: <linux-kselftest+bounces-6436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC8588066A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 22:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8B0282F83
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 21:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933B43BBFE;
	Tue, 19 Mar 2024 21:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B0tVCjgz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156B83CF6E
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Mar 2024 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882076; cv=none; b=FVdPdONmCkEqpc3KumFO/6/9N5zZEm9TQmFYl5zmSn0Ae5iozone91Z6p0kwD/FAUpecPdlpXzG9R2ShZ5hPZ3+35PI+lDpJjrZYWuYbsF4yv+8eaU7HtemWYSWo8jn8xS6tF0jMTifgAa+D2JMfvJh4k+3CFkU07EDDq7OnRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882076; c=relaxed/simple;
	bh=ZvhANbuYYdzjDlSNCOObZlNwSVeG5SJGde/R3AYV+0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMUyaCCMgJu26+srJvAwGp3ewfz/XwmxiJ+ewQE+edc2+LAy3GwYG/a33nrHBjcisQLfFy0KcM3Sj+TIGshm0U7GAK7hxILAzci92XSm1kT4w/F90U7mwDYRnzQj/Ru39UeLeCmakNpQbIjt+oOrgSXzWmOlOgkMJp3NvXp7shs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B0tVCjgz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dddd7d64cdso14815ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Mar 2024 14:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710882074; x=1711486874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvhANbuYYdzjDlSNCOObZlNwSVeG5SJGde/R3AYV+0Q=;
        b=B0tVCjgzesu+Fy0pe+9lnGHc+9MpO1bIAYLHtiLhgQEjOhqSyFJ63xHnA71lAtsUJU
         lcDFZA0OPjujHEqtDthZWfnUenNKIXey63yb2LrmAWAxEZ42trqOV3XOTrmHaIQR97dU
         kD5BYU1M800qXa0sCDeoHlANuvEN5Y5WMGtU++qULXxyh4By8Vq+OjXySutJNhRNYROE
         hM1OWenE88vokESm56sxMj9XsqwLX0HHqPUIgkyui3J7lka3QHPk9SfVPVO5LhPwqdKG
         nC87780IAeFpO0XwCB38jAqQheOb0ojFrjAcYh9ePEtWhlDb3QN+c1P5XABUdU7xl1i1
         SDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710882074; x=1711486874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvhANbuYYdzjDlSNCOObZlNwSVeG5SJGde/R3AYV+0Q=;
        b=ABwV3/SHmN5fpEOV2gmLkuZutyDKd4Mvi9aobUYGPnUkQh7X3KBWEyUK1APkc96IfY
         2oNg1a89S8O0/tZzDYOmYRAdnmZ/EP1ds6M4WMTdd55vsC/wT3f5828OgghiHdtJHOs1
         HKHAWMKfioI0KloeU+k3LYJW7KBUUphETMTssm5cJHX8UuCfB7ZUGYR32dbDtmFarlKc
         4dR03qHDoTV3+P4alo7DAzNJT750J49kNG8bkadQ9AJz+qeU/Mdf1BfpB0yoNs+OGhjA
         7SI8otpZdEnNI2Eml4vO3bhA08UTF0mTtX8x2+WbTuUGLiJpN+1yF3EBmiByvCdAg2pS
         Atag==
X-Forwarded-Encrypted: i=1; AJvYcCXCwCAWVo8MwMpxWJDU7HGkoACzNcMV76FePGTHbhLzYkPkkg/jJKPRdpx3+MaGunnh6OZAxKBhaZ08yAk8eIfqqnCD+Se2EvE+O46mepob
X-Gm-Message-State: AOJu0YxhwR22xIGxclJGZjmJJn9Vc19MbNdPUvNHs3DyBzE/x3ifvKip
	VPyZk/wjuPaJycrgLl7PlNGu1+u8h1pwUDiUM/6Z730A/wPROlkJDtdkuSQ1zptYoLa3AZurV4Z
	S8GRjw7+HEEYVYZZKHPGX0wa6ZDiAASom+nTz
X-Google-Smtp-Source: AGHT+IHTts9WTZeXfm7QG5MBLfM47UzPfKpIRbymYy8+sSS02gQyuQ17Sh9LpPAbl2m9576EbW8jaYR2DD3FniSwitc=
X-Received: by 2002:a17:903:2292:b0:1df:f726:8b50 with SMTP id
 b18-20020a170903229200b001dff7268b50mr85063plh.10.1710882073295; Tue, 19 Mar
 2024 14:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SJ1PR11MB608310C72D7189C139EA6302FC212@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <o6va7b7rc3q46olsbscav7pla4hxot2g6xhctflhmf64pj5hpx@56vtbg3yyquy>
 <SJ1PR11MB60830E546B3D575B01D37104FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <159474e6-ef11-4769-a182-86483efcf2a6@intel.com> <SJ1PR11MB60832DAD58E864F99A16FCC4FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0393c4ce-7e41-4dcc-940a-a6bea9437970@intel.com> <SJ1PR11MB6083AACB10645E41DD3F9639FC202@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <55a55960-8bb1-4ce2-a2c7-68e167da8bcc@intel.com> <ZepK4mtoV_J8-UbE@agluck-desk3>
 <eacdc287-24bd-4137-85c8-df055cfd78b1@arm.com> <ZetcM9GO2PH6SC0j@agluck-desk3>
 <88430722-67b3-4f7d-8db2-95ee52b6f0b0@arm.com> <47c28b3d-3b90-4b33-ba71-1e359d43238e@intel.com>
 <SJ1PR11MB60832422CBDCCDA580010769FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <6948784d-6a20-435a-8781-30f324bed472@intel.com> <SJ1PR11MB608303C5E0BEB42CAC5B02BAFC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <fe4a54cf-7103-49c7-add4-ee4bcf76c7b3@intel.com> <SJ1PR11MB6083CF09A97C13C0859D5A67FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083CF09A97C13C0859D5A67FC2D2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Peter Newman <peternewman@google.com>
Date: Tue, 19 Mar 2024 14:01:02 -0700
Message-ID: <CALPaoCiTe+50Ymve5kcjaasQe4AhvayMbTM9yCp2F5PtwHyAcQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] selftests/resctrl: Adjust SNC support messages
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Chatre, Reinette" <reinette.chatre@intel.com>, James Morse <james.morse@arm.com>, 
	"Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, 
	Shuah Khan <shuah@kernel.org>, 
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Mon, Mar 18, 2024 at 3:05=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> > Could you please help me understand the details by answering my first
> > question: What is the use case for needing to expose the individual clu=
ster
> > counts?
> >
> > This is a model specific feature so if this is something needed for jus=
t a
> > couple of systems I think we should be less inclined to make changes to
> > resctrl interface. I am starting to be concerned about something simila=
r
> > becoming architectural later and then we need to wrangle this model spe=
cific
> > resctrl support (which has then become ABI) again to support whatever t=
hat
> > may look like.
>
> Reinette,
>
> Model specific. But present in multiple consecutive generations (Sapphire=
 Rapids,
> Emerald Rapids, Granite Rapids, Sierra Forest).
>
> Adding Peter Newman for a resctrl user perspective on SNC, rather than me
> continue to speculate on possible ways this might be used.
>
> Peter: You will need to dig back a few messages on lore.kernel.org to
> get context.

Our main concern with supporting SNC in resctrl is all of the
monitoring groups successfully recording memory bandwidth from all
CPUs, regardless of the RMIDs they're assigned.

I would prefer that we don't complicate the model of resctrl
monitoring domains for this feature. On ARM SoCs there will be a
plethora of technologies influencing the layout of resources, so we
shouldn't start cluttering the model with special cases for each.

I think it's valid for the number of domains in the L3 resource to
increase or stay the same when the system is configured for SNC. I
don't think the details of how the domains came about is relevant at
the resctrl interface level so long as the user has enough information
to deduce what the domain is referring to based on knowledge of their
system configuration.

I would prefer per-cluster as more information could prove useful in
some future investigation, but if you feel the data is misleading,
providing the clusters combined is also fine. I would prefer that the
choice remains consistent from this point forward on any particular
implementation to avoid breaking existing controller software
developed for that implementation.

In our main use case, we sum mon_data/*/mbm_total_bytes to determine a
group's total bandwidth, so please don't cause this logic to produce
the wrong answer.

Thanks!
-Peter

