Return-Path: <linux-kselftest+bounces-16853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850D3966A30
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 22:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B695E1C21BF4
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 20:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBD31BF32A;
	Fri, 30 Aug 2024 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoRy7XE1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DBC1B86D6;
	Fri, 30 Aug 2024 20:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725048383; cv=none; b=sA9AGtR0X2stM7xq1Fcd8ZTMHJ1Xg3HtbeiEM878RT0BJfQ5ru0XOG21lBxCSFrPjUGZs9AgJ+5AIHxcVDxBSmhDiFfcl0n9LczMZCPJmvjOaBZo2P4QYKATj0nPEscmNp0gD4W/DYRxm22a3L8XqHqK6Ntm60SLwVoZ2OyhRRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725048383; c=relaxed/simple;
	bh=cWSiC3lXQnjNwNsl8WkPzx8Q6+jpP9g7prZ8FN3pDiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsPadvJ240RaghaSWnBbC5lC+s0fNaZmaYi4ncwMGAh99OHh9SdWmuOFaVsU1v5/Qs8KBOqBX9CMkZalA/mqi7oNfsijdc6UzjLjJd4QfInRWPlly1VYleIlEKOVh2qb3JELHm1263whCkyxq7sGD/4NRQcMteGmaSRgXu5AR6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoRy7XE1; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5353d0b7463so3993512e87.3;
        Fri, 30 Aug 2024 13:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725048380; x=1725653180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cWSiC3lXQnjNwNsl8WkPzx8Q6+jpP9g7prZ8FN3pDiU=;
        b=WoRy7XE1I4/xznFIwggo7Q6yNSmMuRifFJweOCfFGog0ojEK8SxPGZIpEyfSfWpp0O
         CYJKDlDn+/3NNr904lAtGqCJknmookK3cgEMpN8nexptc8uIXBt3f6p1k7T4qrhyRr8k
         cLjIqjQaG19oGbTZ+zQ3nf4BJzROEG5ztWJguSCCnIhTrtpL1/xnIcuEahwkTzNjByxq
         YSjpdpo6DTtIxx9MeLNBs2iiKzAVkKgjL6Gtq1moBqKmr3arqpRDdV+Xid21RdTdMgMl
         sY2WRUEmNgRXMtExBVzWxMUoUl98IKZfRUxICGexOgeX4QH3O8DZ2hkRzA1L2VDd/PUN
         KvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725048380; x=1725653180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWSiC3lXQnjNwNsl8WkPzx8Q6+jpP9g7prZ8FN3pDiU=;
        b=uCxAP9+UaR6qnhkAyngAbpXCvJpIyZCPeu7egrFT+434mfEwzmgX+1K0d59YJygF6K
         ahuijhUl5fbCfraXJ23rzPcqREe83V9L4Ew0yDLp8dzTWv3Ub8SYiyw5Rjv0TFclsbIA
         NaK6Kkrlz+qwkwFfIOEnPfHNOL46doPMd69MVLDsKtdlEqvPilgjQWPT8aMKraYhGt6H
         kISDYTCGmuXm9Oifw6WzP1FiyohTbKOVqnyPyprv8GQ/4sEPsO0mfHaZudl6AQryIDG/
         DQ/55cbo8SdFfKURrE/sLto6y4HqnW91IhsvqXpCVBZiEVnRrl+wwyzyp3a06KIL4fjU
         /29g==
X-Forwarded-Encrypted: i=1; AJvYcCU05Rlrpkss84As7uCELYp+9o4/qomFauKuX1XTW6d3U6jxHQpd8PZLzejYuVN6hFX86kZLCxnN2qON4E0=@vger.kernel.org, AJvYcCWg3sLck6iGnUVp3s2zsbkAhDtB4zP6XQntWCVBxJSoKfw1qvhpyR+gYA82X/Pqn49FZySdhVIxXcY3ATpigjS2@vger.kernel.org
X-Gm-Message-State: AOJu0YwYWOpqEhypdQFn/+5KfBSgIFBimjujsPM+6oXrGlMEyFBmu3Lb
	ou2xHxraYOtjKFHq67S/t49uG4iMaSEQsp0XG2RKWwJjaTSuBPPjvITYIIHKe+uYL6AzvJYKTSA
	/0ndjFOUToScCTZo30HCvmQ2oscY=
X-Google-Smtp-Source: AGHT+IFvRM/OgbBe7Gr0V4rG8sg0ZG+w5OS2fFDBcptAHWkTHk8VHqd2Jhi7uoYeQyRVWNMtCfi/T1jVxes+Fy0z+cU=
X-Received: by 2002:a05:6512:acb:b0:533:4505:5b2a with SMTP id
 2adb3069b0e04-53546b4a8c9mr2832666e87.28.1725048379086; Fri, 30 Aug 2024
 13:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830141939.723729-1-joshua.hahnjy@gmail.com>
 <20240830141939.723729-2-joshua.hahnjy@gmail.com> <ZtIgdEt9RSU4MCIP@slm.duckdns.org>
In-Reply-To: <ZtIgdEt9RSU4MCIP@slm.duckdns.org>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Fri, 30 Aug 2024 16:06:07 -0400
Message-ID: <CAN+CAwP-VnCAH=OpNSG7HbBj3TJsrRQ2Rcs=e6X9DGrTEQLKuA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Tracking cgroup-level niced CPU time
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, lizefan.x@bytedance.com, mkoutny@suse.com, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, thank you for reviewing the v2.

> Patch looks fine to me but can you please do the followings?
>
> - Add subsystem prefix to the patch titles. Look other commits for examples.
> - Add Signed-off-by to both.
> --
> tejun

I will send out a v3 with the signed-off-by, and I will add
cgroup/rstat to the patch title.
Thank you again!

Joshua

