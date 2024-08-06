Return-Path: <linux-kselftest+bounces-14883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E19498F4
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 22:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55D52854F7
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 20:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9A515665E;
	Tue,  6 Aug 2024 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="BFVvcSSO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E8A14B06C
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Aug 2024 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722975692; cv=none; b=Dm33QyY4urJG8pQIK0eLXWMADzKgOdImJknPi+a3l0+GUyy7bYKNF9nP4KUX003ktZynMKcL4iskPuHGH9iSs7fXcJqC6UOvtSdwdHb0LOZeieaNJFk4sAavcbUSSM2Djy35NjG1EtB/TQS2SIhIYt0IuMVmCe3dTm+RI2aWUFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722975692; c=relaxed/simple;
	bh=qWDWtGhMbgLfsMxEb/+40gvdUiavX8iRTFTkmGd967w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwMs56QE4Fjhgbkt4Vz/g53PA7rpt+KShF7gLDucATH5fuz5CgDpV6lIXIX/SPETuXryKsrYZWVNEu1sykVXMV0c7/5sbFToPWt/m7Jr1bJRWa3LSJ/qWq53j9l9VE9ZU46Rv9nEB0vnknyprhyMuG+6GKbtxeT2NAw7kaOnmEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=BFVvcSSO; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d28023accso891844b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Aug 2024 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1722975690; x=1723580490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QlBm+jC7wNlpQF23HO6ozZiIQGXZMXkusHU0sBp0qU=;
        b=BFVvcSSO5yQ1JL6gdovAFkM7WoNSfAC6vg4ZGR1cFbnVlqr8zI4oU8R0KDTGXxPcSP
         DoDDgxxfXFwx8sdwIfj9wumWbcX+PxLK1yzsnnubomoocS+4iCQlGmWaeEj7xsgFoCHB
         CMNlDnAg/uoi3gud+cEDOOLqM0QaxkpUGCUEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722975690; x=1723580490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QlBm+jC7wNlpQF23HO6ozZiIQGXZMXkusHU0sBp0qU=;
        b=qu4y2EM9XNjkLHYOC4S45ds7OBrIuM2JqlXNgS2Srk1F669LbzLybdxvKOoImh1JLe
         dgLgLpqhk+trvO03x8JKmuXhuuotY0wfug+KJ0rwrfD0SYtit+OyNuNHwGamlcRxflsE
         aH9RQ2ehqVfXV4qn7NelSG33UxRclXXLvEl7LH8YXDCTUhSjT4KzZ73Ep07dBWhkr4ua
         4BP2xTC/ud4STf4k98itynz7pXyFhDsqTXbZDRhhVarZ851p16bThwgTvP3MO++3e5PH
         1YnffkOB9eI/myJgmsE2UJI0Tp1JKOT5tbJzRSSq2kUw6CgywtuSftUcWyOEW4k1J+4G
         C0jg==
X-Forwarded-Encrypted: i=1; AJvYcCURHOvSt1Pz41mJjbOCiPqljc2ori/4/SzP6llts3d6D7Ynz9GCdj8lK14w8c9RBr9Il60prmNaFWCJVcLqGpw9lbMVLppIqIRXsszwyBCI
X-Gm-Message-State: AOJu0YyZoK2RNGLegm8suwyEIQkegP+LU5jrK3iLfrh2TOcbMYEaucwj
	b4Az6abf9uE++SYH42euGw86ZsyMubgv5VFTcbL1ogHl8fIv7s7fa+8KJ5SsncxyFm7VnPM+7W9
	NeCtRvXdDHcUZK1OP/9zyjhPyzr1+f1yeCYaUrg==
X-Google-Smtp-Source: AGHT+IG46TNFDF/EMCaO2JQlSmtorbFXbaM5w2I6TBnIgggaM5OBcZpVglvKgHo+KklHseqM7XOXzwn9DwbC+GtGi08=
X-Received: by 2002:a05:6a20:72ab:b0:1c2:8e77:a813 with SMTP id
 adf61e73a8af0-1c699551254mr18895308637.1.1722975690196; Tue, 06 Aug 2024
 13:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730231304.761942-1-davidf@vimeo.com> <CAFUnj5Nq_UwZUy9+i-Mp+TDghQWUX7MHpmh8uDTH790HAH2ZNA@mail.gmail.com>
 <ZrKFJyADBI_cLdX4@slm.duckdns.org>
In-Reply-To: <ZrKFJyADBI_cLdX4@slm.duckdns.org>
From: David Finkel <davidf@vimeo.com>
Date: Tue, 6 Aug 2024 16:21:18 -0400
Message-ID: <CAFUnj5MFqjTGZ0n3JBuD7a+LSEJ16KyrVyJiseTe_e04RuE=nQ@mail.gmail.com>
Subject: Re: [PATCH v7] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Tejun Heo <tj@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com, 
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 4:18=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Aug 06, 2024 at 04:16:30PM -0400, David Finkel wrote:
> > On Tue, Jul 30, 2024 at 7:13=E2=80=AFPM David Finkel <davidf@vimeo.com>=
 wrote:
> > >
> > > This revision only updates the tests from the previous revision[1], a=
nd
> > > integrates an Acked-by[2] and a Reviewed-By[3] into the first commit
> > > message.
> > >
> > >
> > > Documentation/admin-guide/cgroup-v2.rst          |  22 ++-
> > > include/linux/cgroup-defs.h                      |   5 +
> > > include/linux/cgroup.h                           |   3 +
> > > include/linux/memcontrol.h                       |   5 +
> > > include/linux/page_counter.h                     |  11 +-
> > > kernel/cgroup/cgroup-internal.h                  |   2 +
> > > kernel/cgroup/cgroup.c                           |   7 +
> > > mm/memcontrol.c                                  | 116 +++++++++++++-=
-
> > > mm/page_counter.c                                |  30 +++-
> > > tools/testing/selftests/cgroup/cgroup_util.c     |  22 +++
> > > tools/testing/selftests/cgroup/cgroup_util.h     |   2 +
> > > tools/testing/selftests/cgroup/test_memcontrol.c | 264 ++++++++++++++=
++++++++++++++++++-
> > > 12 files changed, 454 insertions(+), 35 deletions(-)
> ...
> > Tejun or Andrew,
> >
> > This change seems to have stalled a bit.
> > Are there any further changes necessary to get this patch merged into
> > a staging branch so it's ready for 6.12?
>
> Oh, it sits between cgroup core and memcg, so I guess it wasn't clear who
> should take it. Given that the crux of the change is in memcg, I think -m=
m
> would be a better fit. Andrew, can you please take these patches? FWIW,
>
>  Acked-by: Tejun Heo <tj@kernel.org>
>
> Thanks.

Thanks
>
> --
> tejun



--=20
David Finkel
Senior Principal Software Engineer, Core Services

