Return-Path: <linux-kselftest+bounces-8832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A418B188E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 03:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA05B252EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 01:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EDEF9F0;
	Thu, 25 Apr 2024 01:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOEInZgl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D34C98;
	Thu, 25 Apr 2024 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714009552; cv=none; b=BfPnOr/QpdByI7ldDqgk92Uo2+OBBTz7IYHYntAIx6pq81kbOEFsnxVr51Rc/89fhLzqcG1QRTNxtXPJflv3YEsVFopmsTGdjie3JxG7P9yqMo4mtzPsgydxcB9jHvGkG/UxdqHIiYAiuDVnRAPqEF4F44+ZIuMZP+dvVk9B45k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714009552; c=relaxed/simple;
	bh=wZmXqdF06F4w89pQW3RDjmWWbre6ejkYQ0UzXrBPjnw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=W1nfCz6M/jGg0GNe+W+fTygUH+8rFYlZIU5vTI1qOvP1Ala7jJ/GtQf9pBx3Xm+ftQdZOgjfJMB5TGZdxnOdg8XODke33KbzzRD8rIJ91L4xvi4ihQjNvCYRF2OTZZ1nU+HoIa1Cm419aMj7Avq1wdxfMIV9ix3du5rSeMrnSsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOEInZgl; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78f05afc8d6so26649585a.3;
        Wed, 24 Apr 2024 18:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714009550; x=1714614350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQ1otly94i8s7jVVrT0AA5dzr9SaiKjGX93Y5d8edog=;
        b=mOEInZglqf6tR1arHIAXbsUx7H6I/cPyjzYg7gxFaNgOaLjRC8GpCKhGkX9aDgCByL
         ApnZ3puIzzuOJZBdySkw1U/zFyOSCh1NkTzYDSae3ZtryATRqZIrUR9v4uY4p9T9ftg1
         3bSO3vFQhzQ/maMCynoGl/+m5yM0gjE0zPO5g9aD8cgniR8pbKjJoEG2GeejTBWjQHTU
         tSVMcn/Z9+UKpyxiOsJlH8osy8PzMNx+/BVyTNGIxF6SwdSnOTsDqEjdNdxxWps6pGCA
         CHIr94sXDX7rRa5q9iv4LMZAv1RzslLVXeL/6xzLMLIqMrEO44ew2cAu7BlyIyB66NRh
         Zz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714009550; x=1714614350;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LQ1otly94i8s7jVVrT0AA5dzr9SaiKjGX93Y5d8edog=;
        b=KwjK/nn85/CrP5U1DNf8Wi4ogATwZGHLI9yKWEdFZnthH3KR17l3in6wOp/vjAXw1X
         9HcxQYr5WWLiK2KWEKajy1t47Gc2ntfH5XgmS+yWR0OOlRDScFTQKWSViBH/x0As5iMk
         WBpw3C2dhD1jbrPeZ87LDUCz4aJITsB40AyBjCw/hKpmtDfi2HLN2219t0s2QZEoAHd6
         LJVSFGdtl4feVxDQl4rZMlODq/SM3SjK9xpcwe5BYjjW6s59f7UwTPCW1sOoLRJOCMfI
         iZACHkMqElMUObY3AYxRLBNBdXqvufUksHG4ORpCEis/bQVl9zNpW32urmHGCmo0WhN4
         TUFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzUdWJ5GTjtEeOsjfMrXNpk0xizezelJHccVoDwBq3uoo54Q3XG4adxtR43h9VeHrMimMTor5tCRXc3s8efbSKOrdaeaad3oFMPigLOxvG
X-Gm-Message-State: AOJu0Yzu0G+0yfhuaAvX+ppPxcyOqrh3bCZl4u3/XsyrhvzvnZM4Q06n
	yp5Gl5GfNg/7rqdxEy6U67H68A1rKogj3SdjlP0wzPM6v1tYeNhH
X-Google-Smtp-Source: AGHT+IHAwfXexlMAL5kAWAy/KEUwRjA5We/wLpzu4+WBsIf9LxRXxXkKdL/iIEFSQWa/9cDVM2fj+Q==
X-Received: by 2002:a05:620a:4455:b0:790:9975:d06 with SMTP id w21-20020a05620a445500b0079099750d06mr1088077qkp.16.1714009550237;
        Wed, 24 Apr 2024 18:45:50 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id w5-20020ae9e505000000b0078ee852d769sm6560922qkf.52.2024.04.24.18.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 18:45:49 -0700 (PDT)
Date: Wed, 24 Apr 2024 21:45:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 linux-kselftest@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <6629b5cdb68c6_1bd6b0294c3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240424221444.4194069-1-kuba@kernel.org>
References: <20240424221444.4194069-1-kuba@kernel.org>
Subject: Re: [PATCH net-next 0/4] selftests: drv-net: round some sharp edges
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> I had to explain how to run the driver tests twice already.
> Improve the README so we can just point to it.
> Also fix a potential problem with the SSH remote sessions.
> 
> Jakub Kicinski (4):
>   selftests: drv-net: force pseudo-terminal allocation in ssh
>   selftests: drv-net: extend the README with more info and example
>   selftests: drv-net: reimplement the config parser
>   selftests: drv-net: validate the environment
> 
>  .../testing/selftests/drivers/net/README.rst  | 95 ++++++++++++++++---
>  .../selftests/drivers/net/lib/py/env.py       | 46 ++++++---
>  .../drivers/net/lib/py/remote_ssh.py          |  2 +-
>  3 files changed, 118 insertions(+), 25 deletions(-)

Left two minor points comments inline, but nothing important.
The clear documentation is really helpful, thanks.

Reviewed-by: Willem de Bruijn <willemb@google.com>

