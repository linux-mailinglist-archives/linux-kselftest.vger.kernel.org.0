Return-Path: <linux-kselftest+bounces-29583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA109A6C2EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 20:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3F73B1CDC
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 19:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638BF22CBE8;
	Fri, 21 Mar 2025 19:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="eLv4wdMf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD41EB1A1
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583680; cv=none; b=HnrGZcBQexRGdcDVoRLd2LH/RdtCrMhwGii+zshP4V0wuVfElauH/81gMofQ05s7nKOw4WJa99Wkp/mkCgxCiupygVyUFZMEj4qTWBN04SsieefTKKGlmOuc6M6IwH++EjdnO+XQbBO6b45CxoowtdW83qxY5/YJj+RM+5voa5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583680; c=relaxed/simple;
	bh=Bd3W8zmoA56286TIT/M27tLloKuTGWvB4Py7sj3zCIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsAktpb3j8QKyBGKc+HrDY9SWh2ijph4jPoQQV0GICPl+C+EtzJ6qEo0uQaD9h0cflum+0XogfK98xb4DHt9mQXSVsb3TbggkIhR3Uml5fLXvgg4JrOBHB+HPZknfMsVm4ikR/xyjlWGcR2FxNwoahoz1bvm0jVIsBR9XuKvT9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=eLv4wdMf; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6feb229b716so22292177b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Mar 2025 12:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742583677; x=1743188477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nR4lHmAwKxP9HyGmUTHKde+Eo7V+LJcGUFHENv86AZM=;
        b=eLv4wdMfCHT/qkHUpHNYlTw9jw8y4tRKA50OqcnETlj1Xw8TQg3iHhWwCPGUObTfCW
         r5Q6cglKfIQ72iTFTlc2BVA+AvqPUg8k6lriJTrNxpAtslDQCZyqDSeJP+RrX7xdtSOH
         Ro1oQGndRZX/yrNrJADmrglm2vvjyifldVsYCICkoJ/fRnqg+dKSCIOMoV1U/vPS52rE
         ODrZKcHsTd/Abj05vJn0ZUe7/gzwMRti3hWdSv92WFYeeto84MhcytkbZd43dFEmUGwT
         8ZzcD+bgu2Oa9g4aVYOdt42b/2W5rj/lzHglevYdrsrhCKQU1HUQXrEwIpzObVmrtzQw
         izhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742583677; x=1743188477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nR4lHmAwKxP9HyGmUTHKde+Eo7V+LJcGUFHENv86AZM=;
        b=s6+8eSrcVzaFeeL1rLcsC1XLbQObf59Uu4+7OAF3vm+tCTX9iLfySEN93hkWt+Fh26
         nO1BeTZua3JFkPO3Zkbpu/UFwUXJeWK47dl55i36TzE7v+OGJVqqaG03/3CJfTkMle4F
         cRW97wJURrA6gf0DzfBcuU4BFm5whWwDmOP7zoTJnIjHr/xkNxUnFQXGJd3a1cb/VFS5
         wejsNsOz+4yaVjRNqvu0FiWABwozvI1jUOogrcLCYzCZf5COH+SnT6SE/CuVlg957eUT
         9JAlMvRYl0Y5HDexNFYhHeYcWTI1I4lFE7eK7BWxBmnesHiLK97BtLMr1xoCNeOg/8yn
         fQdA==
X-Forwarded-Encrypted: i=1; AJvYcCVwc4fJgWg8fQdFOQziA2cjD5Uuz7L8drD1tsZbVzZlsqt83jnM6ivJylOoL9y40AAE3zw6vFS/7gF00/eCMTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyR45zn7DkLqFWKHnvfW4Aa3nSsNwIFT7gJqdKwd0OuU+X0ygf
	8nObZkCb1O9+eACbFmwZ++kr77Kh7nk4dmkJH99QJFqGfP3gwAVwZG1hGfniVmZUxb8uOSR4GDd
	9U+o=
X-Gm-Gg: ASbGnct9pN9TDSjTW3wpm7mm7f8W074Z9YFBwFq4tEGNoiYkRhl1bclj7hjgtrCwPBl
	29VNBXU0hJKiSb0xbBIoxgdgQIKj9F3VwhO16APafNULLYnMpuhAvExNfWv8rKEyIl4vHRLbzKx
	16w3UxSr+CQ66ucogHjdqZIHAHBst/TLy4QrbwMoiHafAT84e0k7IzfumjYM1QVchhPgCcJDM9f
	/3ymVygQEN8tqa/uqwEdX5Zl1GDnlBPfBhq70/5XOgS7EMoEKFsp6STu1l5oK9Kk53SLUWlPfg4
	TQ546NknX7gQ8Rmny+kxNw2p+XNWoHTEWwYBDSd9FvSRvmKktA7CrHi5QvICOC/a7RUGGt9DnKg
	RP4a37opEhwGbStzrm2bN5Z6lPVXLHg==
X-Google-Smtp-Source: AGHT+IFCFymzOe+88jvBtqQf3WoNAsE5w0tNrMWd418HpWND6k2Tz7c1vpjL/c8frjfQ1C9HkTGr4Q==
X-Received: by 2002:a05:690c:3391:b0:6ef:7dde:bdef with SMTP id 00721157ae682-700bacd6b69mr56614167b3.23.1742583677457;
        Fri, 21 Mar 2025 12:01:17 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-700ba73b9adsm4773737b3.20.2025.03.21.12.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:01:17 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	brendan.higgins@linux.dev,
	contact@antoniohickey.com,
	contact@byte-forge.io,
	dakr@kernel.org,
	davidgow@google.com,
	gary@garyguo.net,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ojeda@kernel.org,
	rmoar@google.com,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH v4 08/16] rust: kunit: refactor to use `&raw [const|mut]`
Date: Fri, 21 Mar 2025 15:01:03 -0400
Message-ID: <20250321190103.1778248-1-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CANiq72=jXTpoPAHhFC=T2SCyz3195=pG5h+-yohCCxdds-2hHg@mail.gmail.com>
References: <CANiq72=jXTpoPAHhFC=T2SCyz3195=pG5h+-yohCCxdds-2hHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Mar 21, 2025 at 10:06:03AM -0700, Boqun Feng wrote:
> On Fri, Mar 21, 2025 at 10:28:06AM +0800, David Gow wrote:
> [...]
> > > Anyway, KUnit `#[test]`s are in -- I was not planning to merge this
> > > now anyway, it should be reviewed a bit more.
> > 
> 
> I agree this whole series should wait a bit, but do we want to merge
> patch #1 as early as possible (maybe right after v6.15-rc1), so that new
> code can switch to &raw since that's the direction anyway?

This would make the most sense to me, it would keep things clippy clean
while also allowing new patches to use the feature. This would also
potentially help reduce the amount of refactoring my patch series will 
have to do as it's delayed. 

Thanks,
Antonio

> 
> Regards,
> Boqun
> 
> > Excellent! I'll make sure to review the new version of the patch when
> > it's rebased.
> > 
> > Cheers,
> > -- David
> 
>

