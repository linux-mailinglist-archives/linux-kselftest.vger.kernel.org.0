Return-Path: <linux-kselftest+bounces-7432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E49689CB46
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 19:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BBB1F2600E
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CFA1448E0;
	Mon,  8 Apr 2024 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/24QSYh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8925144303;
	Mon,  8 Apr 2024 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598942; cv=none; b=rTkNGbcLkTzHonTVyP+BK+YWVAY8qh8G4zMtpYp2B6/+C/BSDZFD4ZC5I2kgWdqYgO9sfz6cwrjf2XSelLHaGpkQPMbKKU99f4xKFGwW28KDd/Befmslbh/QklIicOF9fWbKKQatOE4kzya4pNCGQj1P6hdCS/L2BYYLQWJ4mQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598942; c=relaxed/simple;
	bh=8o1mOS1XIlA9jzTwvElpDAox4TOpdLwQg7jJRWx8YmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7XOswMPq2CxNWrmg25zL+FO8KUgWAjKGYSAREFhj+Jn2bmlEDI16xyxYHGpKmOOpDYB50awJ6QzCv1XK2TkMeX0LGLhOmLA/MYg9d+hXtaTHvnUXP3nONlzUXH1q0OR+dlGm4j9E5vLNaeXAZ+f6nbTgrc/0TDYBrod5wEPkHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/24QSYh; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e220e40998so29364615ad.1;
        Mon, 08 Apr 2024 10:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712598940; x=1713203740; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iq0qU2bZPir6gYsxyeW59rYYX4au+1VCIp1QdQ1bnwE=;
        b=O/24QSYhGEAtjqI7y9BApjljBDz+DpusOUKCFa1e1VXLJ24OcsAArpKR+q7S/ZU2Qu
         F5g6mphyWPzCmnjc9MEUV55GFBGwognIEcwesqfzjgyuMefCsmfBYUGE8KuGrgy/8hcj
         35mr70ZXzG065LbEI1vX3S1bQK+ZKcl0myGGUCvRU2a7P5eq58ZPQhFuD98fwz+Q2/uF
         iQgjoWAijheRKWDhvGrTJF3b9aIKZRaMSyCw1YlOBcTw9nR0btZY1UeaQ+jXXfVWHQfx
         SlQz5qvnpgaMVKS+fE7iNEJkpBGa55RuGe6h+YdUnmAGgN/HyAF1fyb3wqQ5h5fKMJqW
         qPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712598940; x=1713203740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iq0qU2bZPir6gYsxyeW59rYYX4au+1VCIp1QdQ1bnwE=;
        b=BdGOygKWVqHy4jbMSUUcKgUcUoJe3BNGSmIUcAhguwpi+ZpIG7jjHs8TbiQRSIjJQn
         b5w/eeSoGzDoof561Bmua3lMgQLWMAqeRHj733/UjByEcpL31MrVW6IBsZ00GhCZMGSB
         lv2Sr+Kd7LBcKHMShFDyBsSolQzaMeu80xOAU7NW1rZXU9RR6BhogshhLL59UWUgi+ZF
         IhlliL4NrNwrVqJ0T3kXVycOKcVCg2wN0VIEBrBTg7CyafZcPx+EeqAGlrOXIrumH1UV
         y8ixpn4JnVMNjw+PpDYucQOUCQrtwhh234eInq6ZtjljHe7UxXGXSWGzClB93PyzzGxX
         wbWA==
X-Forwarded-Encrypted: i=1; AJvYcCWzENFNL1Rn4pzEb3YANqMtchI3oVdS5/Ay8Yp8+b9jJJU85dAoTgBJGYQ438dXLZcsy8lgeyu5/dRmwvZOvwwlx/FffTPGZqnz1GGXTy2l9dC//SUEWTl/JsEs51v7qyvo8DyJNqbs+gmbYWONpK9vkJIsmijSAQnL0Yq0xYaiFdXzW0naKnNy
X-Gm-Message-State: AOJu0YwA5b1p92FUOT+DbCJwvyFriSHeoXnP1I+8PFpB365XO6OdGtUK
	8XeU3+YScOAWZ70urpKkzJXMV5ToK4ewWsQUb4Y47LAsQqUnKDXJ
X-Google-Smtp-Source: AGHT+IFJGtNYyymZPXsyDm9MF/SQWgWu68YpokN3y3suegvMNfUwxpWPd+OvRDJCZymijr68+zcnCw==
X-Received: by 2002:a17:903:249:b0:1e0:b6d5:bed with SMTP id j9-20020a170903024900b001e0b6d50bedmr11319522plh.5.1712598940188;
        Mon, 08 Apr 2024 10:55:40 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a5f4])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b001dda608484asm7463360plk.57.2024.04.08.10.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:55:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Apr 2024 07:55:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Subject: Re: [RFC PATCH v3 2/9] cgroup/pids: Separate semantics of
 pids.events related to pids.max
Message-ID: <ZhQvmnnxhiVo1duU@slm.duckdns.org>
References: <20240405170548.15234-1-mkoutny@suse.com>
 <20240405170548.15234-3-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240405170548.15234-3-mkoutny@suse.com>

Hello,

On Fri, Apr 05, 2024 at 07:05:41PM +0200, Michal Koutný wrote:
> Currently, when pids.max limit is breached in the hierarchy, the event
> is counted and reported in the cgroup where the forking task resides.
> 
> This decouples the limit and the notification caused by the limit making
> it hard to detect when the actual limit was effected.
> 
> Let's introduce new events:
> 	  max
> 		The number of times the limit of the cgroup was hit.
> 
> 	  max.imposed
> 		The number of times fork failed in the cgroup because of self
> 		or ancestor limit.

The whole series make sense to me. I'm not sure about max.imposed field
name. Maybe a name which clearly signfies rejection of forks would be
clearer? Johannes, what do you think?

Thanks.

-- 
tejun

