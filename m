Return-Path: <linux-kselftest+bounces-29751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE6DA7032C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 15:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBB51723D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 14:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05212586E7;
	Tue, 25 Mar 2025 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NDEeWv0u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8927257AFD
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911313; cv=none; b=bcY5M/E1ATc5cNHnqYk2TLvZ0Q4Yj6W9JX4i15cENTFT8kTedHfW75OWFEOZBvUS7UGYb+oXrxs/lXI/mQKjMcwyuXTgTOT4ByZpeYZbuq1vlqdu+GmMPd1lekUVAxk9KhoMLdNGYjpZ2H6pOph+tcCGO3RHXIWAJNxBOeGbG1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911313; c=relaxed/simple;
	bh=psQr5bXaqv0tOjTaqj05BjvMiGbCZhFimnuoyPINOKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRhXScdRURNbb5K2wgHhNH6tAa+9pcG5yXvfP5P7W2r7eY1eIRyvYX6SCcuZSFHPu4qVhCKU119x/h/grDQbXWNSlOr1hCJhlqdRIkyB86i1Y5nwgWJF2P33+TimAkl6BuKVwqeWSNKAxB4m8Z6qB6rlkCcwGx6R5wTZw5L05+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NDEeWv0u; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so45247395e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Mar 2025 07:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742911310; x=1743516110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=46eT+Hy4Lu4vCxbnU4yufuUurX2jV0hosCGpG1W53Qg=;
        b=NDEeWv0uDppFmVZhjEZQhnF4FN245rDC6CGdJd0aLehy4NowqmxV4m6v8aEZPKiWCN
         8g3VHavlcsCZ3sfUaZZoI0WyM2shsLHcIaWyQv+MDsYS3wMFliD7C9QZQwa2JGxFK2Ht
         j4o7NuP4ylJqkm9TAIaBWdT/LhCtheMBELOJXxGU1rsAFcQCiztjcJm+wjEdQQsQN+ZS
         0dkUYGe4hSlxK/zfN3Sup2iPJUbvVEBUPRhMFJq4W4+0zrFBYW5BGaxRo2fPt/EhDIbz
         1rwsyyBr2BfAYkTMo3ezImUSQje6Aolepmytixs45HKTr64ROvE7L50NQ+L5TwemC+5g
         HS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742911310; x=1743516110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46eT+Hy4Lu4vCxbnU4yufuUurX2jV0hosCGpG1W53Qg=;
        b=pHuKUxVIcMqlfR8DRg7iltW46nqc6p3fp0+d8LVLUV+O7MzyVPUnAcQi2KmEPRvrpf
         J26Bp0DbsWQaCwb/A/YzS802Hhb/L7Clmoj6tf8XF73Xd35AoTXj5cKoIUjYmd5PgEVz
         zCG07QwHFhDz6xtPMASud6zxgI5inaBtJ0U31xKnCsfPRHuvDeAM/Z8RtXYLGXLg0TbP
         RIrKk8xGy69FErMgA1mCuJTA/3be9nDzGsZrVVy8A9fTohoNvxXd0rvnMkkaosX8uSyg
         zUY7F3rvqY9opN08dx9N0/FsNzFTCZnRPMhUeDNKfehmd7rou3Z6KDNl1h+Heu346Co2
         OQqg==
X-Forwarded-Encrypted: i=1; AJvYcCWiGPP4qJ3tVqU8vDyd6WF6oORHdxUt7TYBCQoq6xZGTdC3f9GiOBKRjTgfbcSkz1tcNJ4GNvi3V5agjhNGbHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynrMqEvz6GfHGxW2y23byO29gbmHDb6d8FWl/0hlcz1zvALziB
	OJVBBz+jZ+0SWoAOeD1xWHUzKE7bwfGgPwZdsFwU7np4IyS2p/EgAIHlaUK7iLQ=
X-Gm-Gg: ASbGncvOFLQhagxtTdK0Mh5aaufsMXs1vv6hCPkue8mNFK5e+uvcECNcthwXiCwaeGE
	Ne6ULoYegQQ0qJmOq4ZhhYt26VHsRNCNb/h8wrkZpA8yjCSqOlqSXLJhtYaovPcJogpKgyLXPcY
	vRMVZe0RHxyt67Fmt6TtXKoWCDm5XydaeeI3CLf547FKjilc2iG9udUXGJadXogjIAuiIC4q/db
	QTllvCZNTVskNZQl7QL1Yfxggu2/uZtY7boCt/++Bjr+tg+byFx/fooFJiOJYctHJrZRR+zLi6j
	lbAEOYPqZBQcVEeJMBZa4eq7L3rJHTgrZ3JxoJdVf0Tp
X-Google-Smtp-Source: AGHT+IFlf0RRgubk2wvjrK6UsEWwmBIygf5+sWvt5dTqY3ym64zMC9BzC9I2GK0CiClG8ELDEGN4IA==
X-Received: by 2002:a05:600c:1e8d:b0:43d:4e9:27fe with SMTP id 5b1f17b1804b1-43d509e9ea2mr160093245e9.8.1742911309209;
        Tue, 25 Mar 2025 07:01:49 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e65casm14025604f8f.69.2025.03.25.07.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:01:48 -0700 (PDT)
Date: Tue, 25 Mar 2025 15:01:47 +0100
From: Petr Mladek <pmladek@suse.com>
To: Filipe Xavier <felipeaggger@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, felipe_life@live.com
Subject: Re: [PATCH v3 0/2] selftests: livepatch: test if ftrace can trace a
 livepatched function
Message-ID: <Z-K3S4G5BtdP1Q-H@pathway.suse.cz>
References: <20250324-ftrace-sftest-livepatch-v3-0-d9d7cc386c75@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-ftrace-sftest-livepatch-v3-0-d9d7cc386c75@gmail.com>

On Mon 2025-03-24 19:50:17, Filipe Xavier wrote:
> This patchset add ftrace helpers functions and
> add a new test makes sure that ftrace can trace
> a function that was introduced by a livepatch.
> 
> Signed-off-by: Filipe Xavier <felipeaggger@gmail.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>

JFYI, the patchset has been committed into livepatching.git,
branch for-6.15/ftrace-test.

I had a dilemma whether to push it for 6.15 or postpone it.
But it is a selftest and quite trivial. And it has been
reviewed by several people. And it seems to work well
so I think that we could push it for 6.15.

Best Regards,
Petr

