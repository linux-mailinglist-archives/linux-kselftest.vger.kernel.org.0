Return-Path: <linux-kselftest+bounces-16717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B04B964EC7
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 21:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F401F2425D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 19:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6412D1BA266;
	Thu, 29 Aug 2024 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIa2JUou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31491B9B55;
	Thu, 29 Aug 2024 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959600; cv=none; b=lKk4J8pZ1bikvUyerqLkbfI+q8Vdu9DnOS6Z5EsKQFNBOsC8XVCn4sqr4PCHuGfJ3F1tQ1o+ZY36RZyVtnLHx2Bl1hyL079Uqvgh2FFH82uhjHxjPzVj3o56EHFJMqi78SLntwYnbFXO9Q/ItHIs8Vaa+yyRw4xLpyGmXScPous=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959600; c=relaxed/simple;
	bh=/jHu2Ms/ZN+wfcxWWxuyLebk2/G39DLenbNwKxKHBow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jb9IV50miHQl2jN0A4mh7w6q40pWqOgSrRn9OircjR3kFx/5+MBmpD00aIV5I1fGFZTuXIoFHX+9LfUlYKTdqk5AkoWuXsXhCFTMd7M4OZUsipYJkLo6xwqZFGeODJt0mxokfxNrCwkm0zMM/fbwio+bJs+OlXRNqiif1GpVxAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIa2JUou; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6b47ff8a59aso9657727b3.2;
        Thu, 29 Aug 2024 12:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724959598; x=1725564398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jHu2Ms/ZN+wfcxWWxuyLebk2/G39DLenbNwKxKHBow=;
        b=XIa2JUoucLnZTwoaivuTSwxD7J4998xwEvYRPFYLPyarnq9mXNnTuZmHDslNjVC+b0
         FuYlWCOoRqsrg0NI1xvTrQKlTnQUqTFg+AWCMtzz7XKXgv/6F23jIZENL9ALFi8sybjq
         KaUWHRruy4hrZBIi7Ghx07ql9nHvFjgEhuFE2xhA5fpYKz7BtrRxRv3xevTDbivzilgD
         SOwkoneJupvwOwkEJehLB4wpJrRfnHAINsHcrAFeSKGnzH1lBLo9rQ7jlonXXQtDjlZY
         cijYjZFAydrz4Zk8xGc1DONgd8Xo+0HbNuUCEN+UHxwnFcCYCPkbtcHTphpdLZO3DLCP
         0Kfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724959598; x=1725564398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jHu2Ms/ZN+wfcxWWxuyLebk2/G39DLenbNwKxKHBow=;
        b=iVgOiSrPwwrvIWHe2f6FscFnSfQV3N1/pjdg7UPNQPyFuzSJx5O8trH7vrUSXdJ3dY
         VF8lFZSNGBvQd6fXHFweLtjvtFtW7+h49m7wPBBIcASnhsmSCvqTcixE5ZT8hIngJv4O
         xt1vOu5stXdqF7x5587ZpIK99Z31TMgWGSzKIKFJAupm54CYR1t/ME5WnyIJumnu0roE
         9RegQ6pn7US/vsO89cp9BUfwGqbWpByJSCaAUm1wIe234ia9k9y4c+yFtBmmXWCvMpOq
         0ejT/Sowu/6PWcS0tl/hyetrojkirHxaYb9bJRyyJm56dr+QKPhjgaYc4KwR1NFKslwN
         Rx1g==
X-Forwarded-Encrypted: i=1; AJvYcCUTIni4X482jitFN7HQjXfCfYYXnusP+JugjXWPrc3qglQp7a0qjN2kUNv7jzpSAwKxf9Np19fLjq/7nrdV@vger.kernel.org, AJvYcCW8shL0zDDziBxwmh30R6W3oSRvin+ZZUgVsREGYZPZmWpTnQT9XiykzRd24BmX9/VX8kBvT3InxQKNF7fe+c60@vger.kernel.org, AJvYcCWoQHI3ms4R0U4vSxnk5ymfMUYjPM3ZLKTtAd9BmWnK4EmGOCTIrzUUqq/of9Wh3f0avIVryR8F@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWZINTMrZjbbsVyzuvYogx4/+VjYoC14CNtYyLlQQMh9o3Tpz
	V3LL9P0ssvMJ6E/VfdfkqflWl/AkQC4nDznOH4pJVw4l/4wMECM+
X-Google-Smtp-Source: AGHT+IF3A4Dg3yywX6rdk0fMPUiWmAhLI3O4uROfvDXt55ZidG1tpRj8xppq84PC2/rnONxsihtsgQ==
X-Received: by 2002:a05:690c:4701:b0:6ae:dab5:a3b5 with SMTP id 00721157ae682-6d276116ec6mr37042947b3.13.1724959597506;
        Thu, 29 Aug 2024 12:26:37 -0700 (PDT)
Received: from localhost (fwdproxy-frc-017.fbsv.net. [2a03:2880:21ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d3ea3080sm3612347b3.44.2024.08.29.12.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:26:37 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: tj@kernel.org
Cc: JoshuaHahnjoshua.hahn6@gmail.com,
	cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	lizefan.x@bytedance.com,
	mkoutny@suse.com,
	shuah@kernel.org
Subject: Re: [PATCH 1/2] Tracking cgroup-level niced CPU time
Date: Thu, 29 Aug 2024 12:26:36 -0700
Message-ID: <20240829192636.1054186-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <ZszHM_UV24aSWTC8@slm.duckdns.org>
References: <ZszHM_UV24aSWTC8@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, thank you for reviewing the patch.

> > Cgroup-level CPU statistics currently include time spent on
> > user/system processes, but do not include niced CPU time (despite
> > already being tracked). This patch exposes niced CPU time to the
> > userspace, allowing users to get a better understanding of their
> > hardware limits and can facilitate better load-balancing.
>
> You aren't talking about the in-kernel scheduler's load balancer, right? If
> so, can you please update the description? This is a bit too confusing for a
> commit message for a kernel commit.

Thank you for pointing this out -- I'll edit the commit message to the
following in a v2:

Cgroup-level CPU statistics currently include time spent on
user/system processes, but do not include niced CPU time (despite
already being tracked). This patch exposes niced CPU time to the
userspace, allowing users to get a better understanding of their
hardware limits and can facilitate more informed workload distribution.

Thanks,
Joshua

