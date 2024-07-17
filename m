Return-Path: <linux-kselftest+bounces-13840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4BB933FE5
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 17:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CDC1F24CD8
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FC51E533;
	Wed, 17 Jul 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bg94WuGM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888D5181B99
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jul 2024 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231209; cv=none; b=A3uujZu2bnzoA4fvEWWfjV22z2YvhQn0ojoBD2EQ7qKwoaJu3qsNwzwPUA9AryJXsQEyc4gW+bYenMuJLidbIQ2CQSlyMKJlys5JdrTeJrW2Q69jB3lLscI7MAQrGcV/myYUXaUBydFYnRmJxOU4JXWlBWDQ3h6OVGBu9G9fce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231209; c=relaxed/simple;
	bh=kJgkL+2m1Xq6q5a/7T1ZCG+n4LTBHOKoBqX/2MsLU+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oalcuav1ka5LtSGzrcogKyfjFjEy3MMvkj+RcPJSHjJTuwekCRGxx8jU/R82n2DdKOphsvFYsZqPI50zX5PY3jAZwS+VB7fOFnEmJnk16bd4iWI6stzFoXPlZ/KHWk3mvZy6gJBXwwfima8bYOiQ6g7cSJH/A2JE0RY6qQBe4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bg94WuGM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77c1658c68so729837366b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jul 2024 08:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721231206; x=1721836006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=itVRxRQ4fgSvCkmp4ZT/tO0ArO/vcPF2tBOypwTVJTY=;
        b=Bg94WuGM20J0Lde2Xjz9cuG3NCP+KT56+akNY5U1XQHGnz5+XT7Ry40ysRHeGpbQQX
         ixl48g7QXWEOQYcs8yOI9F/b82A33Nc6lA2PvLao/L03lQqUtm1KbRIDVPWCiVHgSAFk
         hxXQ9mgJEZPtUcWs0gPA7xZWfEX7fz2yS97t5oMtMj2tt0A3Lu0VoSk/eYWVrIdBT3BM
         hVZmGd+4+w89TNlPdzb/i7RVPVSFV2cMXsnfGFko1sK9JcEa+mnMfwoOfj6RFdx6HQlo
         05LlUVpajXScvc/M9mIs1E1Q+3f/tna8B3y+G59gqh/M5qDzRSnfaq2WXRif/rU2tKLY
         IhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721231206; x=1721836006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itVRxRQ4fgSvCkmp4ZT/tO0ArO/vcPF2tBOypwTVJTY=;
        b=WEQWbInN70a1knx/OxWPW/wZ1rEo40w7ahRXfAkLoPIRXlsm+Yxq8toNsghUFWQQvK
         Mvk2qPi1/vRnOvvjz8j37Xq2+lKXTKqtHeEduZKsGod31SetwJGZxCNwqM+O1wA5E34Z
         N8VuweTXANYSjU6Hg+I3nqp4xhRReJfwpSiTT0iMpVH+K+qVN7zJjrHLXdl796W0FOjT
         SnnGis1/cLv15bn/6thP1+pIgG+Ts0jB+hVO7H18MUiNwDB33pgQTvrs48Euokntk0Wh
         37/fRiY2pHzG1PxfJCGbS92P1RhNHViUQ9Pd26u8Y68EQ2STXYuYNlfekh/5ekzJKmuv
         7FjA==
X-Forwarded-Encrypted: i=1; AJvYcCW6RXfL5ArfrZLKIb+//6Mg0dJOrMgLXtiPkVrnnBwJbFOzohaBwpSzQfKEO4Fy2MWoCt5n79lpnoSX6P6mlmVIDIRCG7ihTPqKOC5+n0bk
X-Gm-Message-State: AOJu0YzaeToZpgw7BqeCFdTaSJUmpqRMq6OhcGZsA3R6R67JvQHdRtKg
	3vjdP+2ZjV91yeaeDSMvATFtZfsyhKQDHlyNO/xlWsNBCs34jIxLNIrb9Q3PaOQ=
X-Google-Smtp-Source: AGHT+IGS8IY18QSmrzGhSf+9nBg/8OXqPmS/hfbRyHNmZ0PhqQ2RvzORNPd8rwXPBcuIP3heqkOwVg==
X-Received: by 2002:a17:906:79c4:b0:a77:da14:8403 with SMTP id a640c23a62f3a-a7a0111619cmr176072266b.2.1721231205823;
        Wed, 17 Jul 2024 08:46:45 -0700 (PDT)
Received: from localhost (109-81-86-75.rct.o2.cz. [109.81.86.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a3a93sm460671166b.6.2024.07.17.08.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 08:46:45 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:46:44 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Finkel <davidf@vimeo.com>
Cc: Tejun Heo <tj@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <ZpfnZGWuOsIFPUWE@tiehlicka>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka>
 <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <Zpa1VGL5Mz63FZ0Z@tiehlicka>
 <ZpbRSv_dxcNNfc9H@slm.duckdns.org>
 <CAFUnj5MTRsFzd_EHJ7UcyjrWWUicg7wRrs2XdnVnvGiG3KmULQ@mail.gmail.com>
 <Zpdj-DVZ5U5EdvqL@tiehlicka>
 <CAFUnj5OxBSVJjjsSA1E58K4F1GH_P7tYKfpMmtFrNtGgEkngtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFUnj5OxBSVJjjsSA1E58K4F1GH_P7tYKfpMmtFrNtGgEkngtw@mail.gmail.com>

On Wed 17-07-24 10:24:07, David Finkel wrote:
> On Wed, Jul 17, 2024 at 2:26 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 16-07-24 18:06:17, David Finkel wrote:
[...]
> > > I'm thinking of something like "global_reset\n", so if we do something like the
> > > PSI interface later, users can write "fd_local_reset\n", and get that
> > > nicer behavior.
> > >
> > > This also has the benefit of allowing "echo global_reset >
> > > /sys/fs/cgroup/.../memory.peak" to do the right thing.
> > > (better names welcome)
> >
> > This would be a different behavior than in v1 and therefore confusing
> > for those who rely on this in v1 already. So I wouldn't overengineer it
> > and keep the semantic as simple as possible. If we decide to add PSI
> > triggers they are completely independent on peak value because that is
> > reclaim based interface which by definition makes peak value very
> > dubious.
> 
> That's fair.
> 
> My only thought is that "write any non-empty string", is a very wide interface
> to support, and limits other possible behaviors later.

yes, that ship has sailed long time ago.

-- 
Michal Hocko
SUSE Labs

