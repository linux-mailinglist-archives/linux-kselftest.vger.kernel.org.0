Return-Path: <linux-kselftest+bounces-41608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44769B59FB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 19:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0A91C00F5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 17:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5775826B77D;
	Tue, 16 Sep 2025 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yn4UqOCD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B918223817E
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044864; cv=none; b=f6HVNJ29DKu1liKOM7hyAZR9lxJ6xeEoWMWfXF8Ty9HItN8eEBJlAqtQCoJg8zWY6HS5sZEvSDe9p4+OwIo2nCnDxllZH88jdUrkQOp5cG1AmBEt0pGUgG2IXVv8EucAZi7j3/dzpgYeeYNJ3mPYBUwSLmtlkZSn3Pn/qXXcCUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044864; c=relaxed/simple;
	bh=ytYn1xpYuNF6QYhgFt/snGrQld+uXtsG0hvu+3ooxIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlE0JmXUTrLCpbhL4vXOXcMv+8bOT0R6QJVFq5t3tS7bEGebgcVY7XFGKN9X8vfyhzqsA7jxth4ooXEqSIw2yDDLhxDiRUaq/XJ8IfFMR/O87/nZYMTm2bWOhUVsXjAQhpBFfXxdzBaipZ2v5otiOHrfMmCsQCqm4gBVFs9kFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yn4UqOCD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-267c90c426dso18395ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Sep 2025 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758044862; x=1758649662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV8PZeNRScOuv4YluUBiR/tynYHUDyQLkirKhaJTO4E=;
        b=yn4UqOCDODnVitMhzAl57ZXsqmfdq8kJeuYTM4TJSvaRPMTvIvO6vSdvogM+lYPZFc
         gzFt03tFDWVO3K9mvVicpVqc+MweUd1VRzVMK5FH03r8tU3On2XkiaO+7ac6H3bmfFHb
         oGWOzg04z4Asw4fzBd1XmaOSZROVpHrN4mHK7dRROQ6J044RzJbGphbUgb5GWxr/Kuko
         aYAZUOKyPbABm2ysH+obm2PriBneK3iEoc3akRmM7RvmTQNQk43O4B8sH1cX7y9OutGi
         YMr2etzRTga0d/m0BDs6QkNlvP+riVwnZbE6QXISwmUHsQtvJeEOXIOuL749Kgi/Mt8g
         xhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758044862; x=1758649662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WV8PZeNRScOuv4YluUBiR/tynYHUDyQLkirKhaJTO4E=;
        b=TrQgbrs+gIi6f78b8nk1l7CLk2UPk5Z5Pzz7E0UHdgAAgLyY0aXR+EAhy2ZadLA7Rt
         RWkf7Tgi/hTdEQ7t/58KcBlzA5fPv2sCNQmJ9WzDOLfoczZ21b8wb3/qrS0E/Ous9f5k
         p14FljBmu56Q3QKQzF/VqH6gq3fhJMQqu7HLQHbQe72i2hfujkvubwH376oIVr98F75y
         AzJR86Z1P1Pt5eq0toDAg60DSBBQAIl90o40HaD38Kdn2dOs6LpeXwRKcw6tifO9LyIp
         r+xmoo46hrTVVpdqzgQMKvxErpSpfbH6glEiBqETTKLV4l4CdFD/KwUCjK8zmO4sbRVk
         8hvw==
X-Forwarded-Encrypted: i=1; AJvYcCWbZRYCxiTziS/25GhD6S2CrsAelVLmv0tzj6daI2bXQjYOVhAZL2m4IB0oZZ82V+OjckwqcK/FhgPzyshiWYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUxHtDuV/lnTDwD/ztJNFvqaNQzi1UrsEb52UD7yZPldYNQ1Dv
	Id2kFvSO4BdHm0YQOjBOVHYU0D+hmWcGvkkCc+/MdMioffdcdSfwPj7vDS+GHYc6dQXbECGNOaS
	+Od45V4VlN4iMBFOL91obIqOwo8fZKwumTlKjbjoc
X-Gm-Gg: ASbGnct7mQFoaxKnFo2/BwBVKFYLVaUVO4Xm2CkC02yp5/uTkXYB8zp4F+gegflB9+i
	yXu9holx3DNDsXRn+rEaKDmXxGuPP2eLH6pk9JTKbq93USSyKdouxuX58DOEC3YqLiRA6JEN0y2
	q40sZXkbvkD137J0EAUHbeLU9ygFIE/o3+DoHUw8hcBadBLsJhTx1o+awePpeUeQ5fuWXSoA60Z
	sk9WpAt7eIS6eAwij0ipj4ohlrhCnNIGx43q96CxGHC8bEIGKbnnsM=
X-Google-Smtp-Source: AGHT+IH481Ptt6TGK3gOl1kWB0jZ6sD/yNX/MW49IQWxuVmUns01xHRPJ06rIkyHQhotda3n4zze0byfKtMf1L55b6o=
X-Received: by 2002:a17:902:ea06:b0:267:912b:2b4d with SMTP id
 d9443c01a7336-26801263c77mr123545ad.7.1758044861731; Tue, 16 Sep 2025
 10:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915153401.61cbd5120871ee7a4e5b9cae@linux-foundation.org> <aa95777a-8012-4d08-abcf-7175f9e2691c@lucifer.local>
In-Reply-To: <aa95777a-8012-4d08-abcf-7175f9e2691c@lucifer.local>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 16 Sep 2025 10:47:30 -0700
X-Gm-Features: AS18NWAFaSQqFXRnUy8iH8cngSLpkM9xdFvTXyHLo_pUfxdfSq_22GyY9mLtXWo
Message-ID: <CAC_TJvdwt_66v_A3RnuUBS_XJ7xMwWhEwHEEeLpu2_M5aVQ=Fg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] vma count: fixes, test and improvements
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, minchan@kernel.org, david@redhat.com, 
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

On Tue, Sep 16, 2025 at 3:12=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Sep 15, 2025 at 03:34:01PM -0700, Andrew Morton wrote:
> > Anyhow, this -rc cycle has been quite the firehose in MM and I'm
> > feeling a need to slow things down for additional stabilization and so
> > people hopefully get additional bandwidth to digest the material we've
> > added this far.  So I think I'll just cherrypick [1/7] for now.  A
> > great flood of positive review activity would probably make me revisit
> > that ;)
> >
>
> Kalesh - I do intend to look at this series when I have a chance. My revi=
ew
> workload has been insane so it's hard to keep up at the moment.
>
> Andrew - This cycle has been crazy, speaking from point of view of somebo=
dy
> doing a lot of review, it's been very very exhausting from this side too,
> and this kind of work can feel a little... thankless... sometimes :)
>
> I feel like we maybe need a way to ask people to slow down, sometimes at
> least.
>
> Perhaps being less accepting of patches during merge window is one aspect=
,
> as the merge window leading up to this cycle was almost the same review
> load as when the cycle started.
>
> Anyway, TL;DR: I think we need to be mindful of reviewer sanity as a fact=
or
> in all this too :)
>
> (I am spekaing at Kernel Recipes then going on a very-badly-needed 2.5 we=
ek
> vacataion afterwards over the merge window so I hope to stave off burnout
> that way. Be good if I could keep mails upon return to 3 digits, but I ha=
ve
> my doubts :P)

Hi Lorenzo,

Absolutely, take care of yourself. We all appreciate the  amount of
work you put into reviewing :)

Have a good talk and enjoy your vacation. Don't worry about the backlog.

-- Kalesh

>
> Cheers, Lorenzo

