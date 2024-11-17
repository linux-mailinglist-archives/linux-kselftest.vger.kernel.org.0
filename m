Return-Path: <linux-kselftest+bounces-22154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990849D04A7
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Nov 2024 17:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB7A281E88
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Nov 2024 16:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1BA1D9A6E;
	Sun, 17 Nov 2024 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bD4ZbrRq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE4CA64;
	Sun, 17 Nov 2024 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731860320; cv=none; b=u5/6llm+Mzj8ubZwTnM2jfiEBnP7Eewq+OaVp82wSK2rVX1/TVUvRs61HLb6sLmIjqs/tANllxJ2SUI9W5IN7GJ1ne3Wjrj5zE3jaGBOlmE38DJyOOgs/OdVTM8fdGpPHjeCFuA/VfoznWIVj1jDf9LXTPEYOwWWfFpZAsb2Rtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731860320; c=relaxed/simple;
	bh=cj2WMLa6n2bzXl/93dVVlxdM9318gqW6/etyu7hE4MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQxkZtk9C9+rmLQBRhWPFL5Z+LRogjC5DvLVN1apBZGSYfiKMwz5hwgNsYUTft2/Tedf2r7QWryJ9BpDWSLZUjJfMvK+r5/gOCbyqTRWTOtWKTDLx2rXhFpoSgWxbq+Bmz3/28p8DQ3LJ9W9OmanN3vCeJvWfIRi/wR3xkLE3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bD4ZbrRq; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ee8e894deeso1576997b3.0;
        Sun, 17 Nov 2024 08:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731860318; x=1732465118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cj2WMLa6n2bzXl/93dVVlxdM9318gqW6/etyu7hE4MU=;
        b=bD4ZbrRqQrkCld8UuTbtvGgvgPOe5TNlojRWHcdqu5ThbjwXNCSoGrMqOcAHM0yvnZ
         wgSUidFIsQXm1qX5G+vv7PYQ99wM/2jIzLDrEDZSC0kUMUBQ6a/XsTIO2+C4UgI0CC/I
         ABSjuU1/q3JpV2Zh5yb1McFthaWTskyqMI9Hr4ZxbZZh91NzVOrMwcCr0L7yEsPafg7x
         /y2BBlmnK582DqtJKIRzxC6x11IHH/MBMfbPPSpa8pmKU00+IErEKH9/Y05UV4iaY50V
         ewNqgb8YbcJRpoQry2rTbhBJDs45ibORyGUuJowNN5+9BecV9Sip+anLvXQMZ5mVXhpi
         hFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731860318; x=1732465118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cj2WMLa6n2bzXl/93dVVlxdM9318gqW6/etyu7hE4MU=;
        b=iIXwYjXaKDKD9c2USIi+eu+GtfVUdmeQesqDYJe2riFYkbrUlbRmLxYV9mzMje2NkC
         a8rlwi7MvbPPQDVttxCyJ3guwV9ZczMywTZHr6E95g2vXju/6ia28hGhMeMG/2ssC/yO
         EW9m61vFRw3tBqtu1s23UOQBzFQoi8O23b+5Hu4OBgCB8HCcFlfxmhbyIhZy7I2hBxya
         Mwg6dc8iUCpk07VNxAYqGejKqzMH+Ust5s6OFy6bCGUtM7ERxMBVz5bETglnh5390XmK
         B7c0ZDv0fmEOQb8h7jSzZ3H7dxDZSoIYc3HtS4ObzdqjdhKLH0/MMyhUlHcTpKcHPcRA
         m2Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUJMh851C6aCjC2mVqMwkXwbleL+rzmowUc9iJ/tzg6K2SQ67gwoJA5GXGMuzrnqa9qnv5jN5IHq892Fkasv9Y=@vger.kernel.org, AJvYcCW/ZBHaPx87Y0UzdeDb3RtZ733smNuX8ReWy2bFiliBX87rBWEA4lxeUwZTEk7zJKvuxvjMKWoFBG2r7WeGIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXFtSbuCX+MiwFcHxKn4GAEzEr7+152Y22pkptIDD8x4Pv51DN
	gEYE7hiNFa0wvMY8hI7bwxksiva4W5kEwK4FVahGfO2FPitsHfOJ+LTxMezKpcaJfAOstQASjEY
	mxzF8oOTGaR2f+z0eDLk1gUx3B1X9GtTTdwI=
X-Google-Smtp-Source: AGHT+IEw0CrHba5JlFuIZxH22Gmts5ZBHlZ0sz/1ixGFM49N2+675+G0gr94cmdo4W/eRnYNjtVFV7hzDV5XJMtySGc=
X-Received: by 2002:a05:690c:6206:b0:6e5:9d3c:f9d3 with SMTP id
 00721157ae682-6ee55c888a2mr99088157b3.41.1731860317913; Sun, 17 Nov 2024
 08:18:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106174120.5602-1-simeddon@gmail.com> <ZzeBXRjWq4vBdaCE@pathway.suse.cz>
In-Reply-To: <ZzeBXRjWq4vBdaCE@pathway.suse.cz>
From: Sid <simeddon@gmail.com>
Date: Sun, 17 Nov 2024 21:48:01 +0530
Message-ID: <CAGd6pzNWF189+yFCi6qEON=WD4akwpdr41-UQ26tB=z888EXpg@mail.gmail.com>
Subject: Re: [PATCH] selftests/livepatch: Check if CONFIG_LIVEPATCH is enabled
To: Petr Mladek <pmladek@suse.com>
Cc: shuah@kernel.org, jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, 
	Shuah Khan <skhan@linuxfoundation.org>, live-patching@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Nov 2024 at 22:44, Petr Mladek <pmladek@suse.com> wrote:
>
> I like idea mentioned in Miroslav's reply. I wonder if the check
> could take into account all CONFIG_* variables mentioned
> in tools/testing/selftests/livepatch/config.

Thanks for the feedback, I will create a new patch as suggested by Miroslav

> And if it could be generic so that it works for all
> tools/testing/selftests/<project> directories.
>
> And for both build and run_tests.

I will look into it

Sincerely,
Siddharth Menon

