Return-Path: <linux-kselftest+bounces-23535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1F69F7099
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 00:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E966188607A
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 23:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190D51FC7E2;
	Wed, 18 Dec 2024 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="duz3P9po"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4006D17A586
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734563672; cv=none; b=lqIZzkGkfS0I15AsFmsGJPUjrhYbUgWHn7BBf5w3pW/m7cHhxCcU0Cv/8SJ5rjtFzPIVj/O0uPbf7IV2TENelqXlz86dh87OlYN03gfyyJxuozFKkgUtD9/g9VrYk6DFiPLp3lO8KShXAUuocyAyTeItV12Ir2M3YewCXCNSIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734563672; c=relaxed/simple;
	bh=lyAMNMv5eKSuulZNEc/bdNCuyulKLn44+4F3l6KUPRs=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=BQcLackfUlXBNwabV6mmcoIzSHswE/TagCb+fnHQEqYQm7MqrVu5xo3Qtm5L28R3jvnw4ymQ0ZA3CZiq6RhihnqcMmqxLK6/chxtr85FBnpaBd8XRVxwxvNqV8OK483LswPnTJnpa5RQZ72JhEmSZbuKI8jl/6wZI1gCOshnDog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=duz3P9po; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d88cb85987so1937966d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 15:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734563669; x=1735168469; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFXlSpmqndisihDpwgewGal8XJGyYG+RFQb6zfcXijY=;
        b=duz3P9poAea/erOck2V9RvuKIPsuXiWKV6q3VWqs8apR/YYXIY5ukfnVtX7DcZk6rd
         JKsmBdUEWzQFz5W0Ywg6t2uRces73wp3t8Ll7ACoGjyKmywv2M3IrhASqoBM+V+DpZ8P
         /z9YaNOxGeAN9uB3vJtQaeEtuDFU2TSDH2+he+2dprN+40kW7heGDZKvLKZDVLdPt3Nr
         UympnUN+vyJdP1kYH3j7GPexVO4yBX0WPw5d2tvBeg/mOpmB4TY1YkSQuIOFd1KPlGhq
         zW9joLHbUXxdv/xn00Ar3KSlD2iLMxr4lCFnyvBUo01ufOqNrnF0PksEwPlYY0oEfQNb
         cxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734563669; x=1735168469;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fFXlSpmqndisihDpwgewGal8XJGyYG+RFQb6zfcXijY=;
        b=cKQmSf60ab6E8LgjLyMz1KskQOJ/UTI3N1bvUChpyX7PjgzsBc83uq2dRzztDN/58x
         tRepgLax8DKgaHMjnOXJd287DvT8+b/5OU4efd+SvC+7KKsv592k3f/9rlOlhXdeR54C
         GepfrCb0cseMOq+LEp6zZPaJzAFy8/2MDsETpUd0Pl7TDqd2ug/VgkbkWLXp1UZup8ts
         j9Lvkcg4DQ8dHKM9tl8N/gQn7LW5C6K0l5gFZDHIlDfmpqymsHfw1bGj/5eOUofU3+S4
         Bwjsj4KrAWoso6i/xhkBYzfgItmCCVi8OEBauTavcMREwjpFof5vfWqWbS2p/3p2Y03/
         TgZg==
X-Forwarded-Encrypted: i=1; AJvYcCW9sva9D79VfD6W556SrQN1moI/KxOyIwRqdMndI3IulchGJnpcsIFnURGYdI+7EG7cgptCqJKZ06ufII0Tjus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoiboqNyAYRIw+b+I7fDpvbJPZ5RY1rdWemWCP+zoKc93JpjA5
	At1Q1DsAKJ6ShfkrsZASC0DArzVkvcYoyE2Dd3xdbhekBhzwdIBz/mkjrtVnxw==
X-Gm-Gg: ASbGncsiF6u/lg2CKG93LclU6wSq3wegfrFiq7ntmLywb4fDk3KXkO8jYkpbujYrYnJ
	1yGIk7Muyg6s9mLBxNUarw7LdpKUwtofIeV5XFAJCRpA4opYF4+XVY6ujFM08qO/PZcXzm4YGBt
	RQFG4LXnkXPE9R3ZufEThcUdPPO1KxNF/5UMZdb7c5mZC7VfoIPX+BTrMhh2rgCBNbRQcke0Yqj
	fCzvIrLZIPbvDTUY3tsLPeAj9fLbAUhzo5+aI6mKjENYpvnRlM=
X-Google-Smtp-Source: AGHT+IF812hW3SafWF2rQUyIrEzOBwO01YXN1q6BdXWRjDtGlUPqECITyxWs+43CjiDrTg6b9jZQaA==
X-Received: by 2002:a05:6214:3107:b0:6d8:a3f2:4cc with SMTP id 6a1803df08f44-6dd15547264mr22536116d6.5.1734563669239;
        Wed, 18 Dec 2024 15:14:29 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d3d90sm690556d6.106.2024.12.18.15.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 15:14:28 -0800 (PST)
Date: Wed, 18 Dec 2024 18:14:28 -0500
Message-ID: <eb8aefa13af635a5275c3ff446cd54f2@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241218_1749/pstg-lib:20241217_2346/pstg-pwork:20241218_1749
From: Paul Moore <paul@paul-moore.com>
To: Amit Vadhavana <av2082000@gmail.com>, jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, shuah@kernel.org
Cc: ricardo@marliere.net, av2082000@gmail.com, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: lsm: Refactor  `flags_overset_lsm_set_self_attr` test
References: <20241116152136.10635-1-av2082000@gmail.com>
In-Reply-To: <20241116152136.10635-1-av2082000@gmail.com>

On Nov 16, 2024 Amit Vadhavana <av2082000@gmail.com> wrote:
> 
> Remove the temporary context variable `tctx` to simplify the code. use
> the original context `ctx` directly in calls to `lsm_get_self_attr`,
> eliminating redundancy without any functional changes.
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
> ---
> V1:- https://lore.kernel.org/all/20241112182810.24761-1-av2082000@gmail.com/
> V1 -> V2 :
> write complete sentences instead of bullet points in the change log.
> ---
>  tools/testing/selftests/lsm/lsm_set_self_attr_test.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Thank you for working on improving the tests, merged into lsm/dev.

--
paul-moore.com

