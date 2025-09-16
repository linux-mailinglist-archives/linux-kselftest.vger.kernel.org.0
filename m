Return-Path: <linux-kselftest+bounces-41552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94B0B58AFC
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 03:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10B677B27DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 01:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A241E98F3;
	Tue, 16 Sep 2025 01:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zeo9TQsI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64451B4247
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757985804; cv=none; b=tkPO57HEuq7nwNEEIQ6SP0h9x32ukl0QpszrDIrmdPgLv/90AuamL43y9IIl2J9QnrDwzO9RDn50L1ngJzDxHwfA7N97gF6+8OLo7k8IQEKhJvLGsdJRu1Sd2D1WIFD531Vv/5gURzGiScGzCYiDxGmKR1ud6yEzfzwjva1zvnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757985804; c=relaxed/simple;
	bh=HsXIpnYMm6eaR3cuQaveE8+FpukoKawmNaEcYM65w8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmAVbs/xc7keSANo5tNawQhJpqY5iXZ21Dze2DVBDdAqh7oZLSOVmy2xhiij6x6Xkka3dyGV5ozRN1qPKBthCaDPS5yVB1L3COb2lrR9DdutkBaY3X2POC9psoQeVr5niM/hXQ6Nv3wEfhuTO3MY/lQNNXJhw3j8DAJH0IRWlvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zeo9TQsI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-265abad93bfso78715ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Sep 2025 18:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757985802; x=1758590602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjrtyNvBONcUNbfRSx61Tjsk25VZay7l9mmVDCH4H9g=;
        b=zeo9TQsI/Wq9czKIQJUP+q9TdoKaYhpsLKbqTofaavaWcQpPm100KwMIq9UU9lPK1e
         YMuuZtLQvNAdTZSwJo+ht5nw12AkZ71wqpd+fTYPBhGiLjkleTfKMPK0ErPjS3Wvv1iF
         dg1H3QkGsa+NhFD5bLbONNg6k09iAC94G16kf2aK8jsOPCN7YwxnEAMeH2X+AXPIcEc1
         hSPwoB81gQJBTLAnK6ttme8wCQw9AswIro3T0byaMKRX/vOO+XhQG5MlTE3uom8Mcuoi
         jAeMd4r61tU5YmRWr36tfmMCmbxRtYNNFYzKSfA4eojdwHLL9czw6vYNFHgQyQQejJHN
         Lc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757985802; x=1758590602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjrtyNvBONcUNbfRSx61Tjsk25VZay7l9mmVDCH4H9g=;
        b=fcb0MtdfaG6lX2duqcOqMlPRXEMGx05uafm8uDIrOUK39DrmchEL/q0XMoDAWvIv+p
         NeRosBgNh0V8bslUASL4YuAjjmei4uRj9nUFcl2OJ5dMaaplSnFS8w6uB7wxMRrGOym0
         hOCX1relsMqz66y1pwb6T8Fe4fTLC98oSAepDVF0atlVQx51kXj4s34IwrKX3FHULP2v
         N726RyB9a7GqfhDOxVC+XJbZNw3kMoGmUzaCaa4wtJMic85aRskCwvW9Kb1mnu7mvtuJ
         rKPxts3Jij5rl6vH1HNb5O8leeIr21IAkiJcCtIFi4foqwLYV1HZkWU8ThB6Y1iaaWSI
         SubQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfkvg9x2KN73mArHZ17YCdc5xLEhuBioT+WEqIxNHIizdFDZxWrO3p56uaRISg0noa5nIg0262y/XLDLxSxKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3KeUANZwtnpa27keFtIohSRqjoR1wIk7mWYMKZYsCudN+p6P
	XPZSCms7N3SWRSBK398t9xbKKxhTV9zaKpeynH37sk0LbR7zPKjcUrTq+R7PBcTNPOXkxIov5vq
	FCHAmsmWD023QYuEmRj2uKO8SlavOEQAY336Z7gho
X-Gm-Gg: ASbGncvePe+CZ863w0gRAqa0/VvVEuIbTeCz1jZYKxLlOEpiQCiqVSL0fVqRBWUu34V
	HCpf3KuQHX734yArZzH1QZCmpwBC0XuLc97pUGgxydCZCEu0xxbqk4Xod1G8H/znUGW2Gh8bBRc
	x+0ns1f5ZsPZY0+NJrIJJwnDFeV2n5qZDN4q57vskYge/rgMrow5EysjUDQ6lydet5op/zyoY2G
	BVIZPOmMGBal/kTBfSzU0meBlV1fuCLcgwrizRwdChS
X-Google-Smtp-Source: AGHT+IF9+835PR8promdp069Tski48d465PNsDSz2RlGOWqnfbXegmXvA9IiYNUJE4/C+ZSOfFmqDmuCCV/FlktNcas=
X-Received: by 2002:a17:902:f547:b0:246:1f3e:4973 with SMTP id
 d9443c01a7336-267c1a5d5dfmr2675725ad.6.1757985801735; Mon, 15 Sep 2025
 18:23:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915153401.61cbd5120871ee7a4e5b9cae@linux-foundation.org>
 <CAC_TJvd=zwhRZcXTvDPfuzdjYV7j_jvZKZ--eKDRTsE+LBmASA@mail.gmail.com> <20250915170550.f24bfb96514835154e8d1633@linux-foundation.org>
In-Reply-To: <20250915170550.f24bfb96514835154e8d1633@linux-foundation.org>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 15 Sep 2025 18:23:09 -0700
X-Gm-Features: Ac12FXwhWVu02OL4G53WutcplFT1I0VgCrjVK0f-v6OHM6tMSRuAEDbNEvAgPPY
Message-ID: <CAC_TJvef-jLQm_H2kd9FX9WprMThZv8MvgxAuJeceG-qpRwryA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] vma count: fixes, test and improvements
To: Andrew Morton <akpm@linux-foundation.org>
Cc: minchan@kernel.org, lorenzo.stoakes@oracle.com, david@redhat.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 5:05=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 15 Sep 2025 16:10:55 -0700 Kalesh Singh <kaleshsingh@google.com> =
wrote:
>
> > > fwiw, there's nothing in the above which is usable in a [0/N] overvie=
w.
> > >
> > > While useful, the "what changed since the previous version" info isn'=
t
> > > a suitable thing to carry in the permanent kernel record - it's
> > > short-term treansient stuff, not helpful to someone who is looking at
> > > the patchset in 2029.
> > >
> > > Similarly, the "how it was tested" material is also useful, but it
> > > becomes irrelevant as soon as the code hits linux-next and mainline.
> >
> > Hi Andrew,
> >
> > Thanks for the feedback. Do you mean the cover letter was not needed
> > in this case or that it lacked enough context?
>
> The latter.  As I've split up the series, please put together some
> words to describe the remaining 6 patches if/when resending.

Hi Andrew,

Thanks for clarifying. I'll make sure to fix that when resending.

--Kalesh

>
> Thanks.

