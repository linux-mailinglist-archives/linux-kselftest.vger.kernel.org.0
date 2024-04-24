Return-Path: <linux-kselftest+bounces-8813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAE48B14F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 23:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6673285832
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 20:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72B7156C66;
	Wed, 24 Apr 2024 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1954W+7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248E15698E;
	Wed, 24 Apr 2024 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992384; cv=none; b=G13iodJWHgaAohNjbeKY6/JivKJSzIp886Yw6u8DhKswIdA5249yswppY/BeI7t9II1RhnU7/ubPODYgXHNR2BqdmRxDOlkJWFGRweEFHQWOBUdEE6nlm3ht46BSafJMRdNE5LnCLm/xmqvZSHdFjT6qGME8l/k48BjPo694tO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992384; c=relaxed/simple;
	bh=2znSrrUO2rDKZ8pJmFtYYBINsy/4DvaAAZ/w57y0Rl0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=V8F819MDoHDQeBAWawEbMsTp+aUtQ5QG45QzsM4Sp0Y3iQLAmSPiQkQ/xmGxi5S61+H2LFcQKsbgAMxBwYiDbyZ7XjxckGIYpiwINPWV2lTr4loRi+Z+NUNjtboOBhB3XCuHUppFsUx608MaxqgrZim3Z5NaIE9YxALjT3WlZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1954W+7; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ac90ad396dso198290eaf.3;
        Wed, 24 Apr 2024 13:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713992382; x=1714597182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9S6B/NusbKqGsvOw0vBRqVFVGqOxO1Sm6XZdQfXO3c=;
        b=S1954W+7/EdHJqUib2KAXW3MVjpWET6KvUmNTYipzz41hFX+SWyZ6EFVmb83xwxnF/
         ifTa214Ad0lZay8TiqlUav/4xWKfKgHEJ40gUYPcNqELpIxTErqWBg0B8GE8Xhkfzrxu
         3wjRIZuWLTdXbwM+QB6awwM1CY0OQwOuBNHOU8XftFXubiORu/pq3Qfk23YTpUHH4l/u
         zPZlmCS+c7FkbNSztpWz1wVfZWT0N/BVzvMuZiI8o2noKfTax2fI5xh+lY3DRxguL9bM
         18IBv+WMeXjxjewzHWZojlB+PqaOYj07a9saL9HmHZlNJ8QZVIrhZeAu1RdtUBO46Zpr
         /heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713992382; x=1714597182;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e9S6B/NusbKqGsvOw0vBRqVFVGqOxO1Sm6XZdQfXO3c=;
        b=w14NYfaOIz7MbSlc7t/xzTAQgCoE5pvlcae/t632poLdxWS6Ovoz5WT1MBb8jv5V5J
         1KptF3NP9AbNypjEadihcH2Snea3F1hOpWKK3nzW6pENrv59fOEx72sONqeP3PofF2PA
         0/VHzHnK/rE8STYEBbskK9Hroo+yHzb2189uXohgYObTVX8Ebi4wgHRaFyD+JtBV6BWp
         MnCOeLyyr1JvSvSENjML2gc1Ob3rYQ92yfeI8gajl6lIrMAa2eWnILEJ0kuBObjcTwyi
         cO72NVkEP4MT47SXLwJxEBHh0lcqfAyJ8/YkfYpx0bW9QdWyUamYNs2rbsK8WF+4Aali
         QLxA==
X-Forwarded-Encrypted: i=1; AJvYcCU+fVTNH6iK+V7EQM5nxJtobaCnGum0/4l84JvD0VQeKf8//qtkxyvj684KSAeXb/pJqGA+eqja9o+qyNPBmFfvMO2jICzwe+Xe1FwnoZ0O1R+1R/RmOQc6BJAxmeBVUCY/PGotV8Oc
X-Gm-Message-State: AOJu0Yzx3IkJ7Rhz8Y0r2IaIhNyYmRbZnwXR/1uvJhtI1TJt0ha7lXXb
	suBOF980un5jRheQa1uP0l2w4vmUisLvM9VBp79e2WMZidSJxzh4
X-Google-Smtp-Source: AGHT+IFbVpiUu3yWRCJjExJcFEMOgDDJ4u1sDOEgOo3uJsFNvcbj3Zo6OWDQevKnl39JLihmAxFJhQ==
X-Received: by 2002:a05:6358:9291:b0:183:7d27:c07b with SMTP id m17-20020a056358929100b001837d27c07bmr3293157rwa.32.1713992382245;
        Wed, 24 Apr 2024 13:59:42 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id x9-20020a0ce0c9000000b0069b192e63bfsm6364112qvk.91.2024.04.24.13.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 13:59:41 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:59:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <662972bd69700_1b61b92949@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240424115712.37d27b05@kernel.org>
References: <20240420025237.3309296-1-kuba@kernel.org>
 <662526f58a70c_1dff9929430@willemb.c.googlers.com.notmuch>
 <6627f699278fe_1759e9294e3@willemb.c.googlers.com.notmuch>
 <20240423185305.15fca2b7@kernel.org>
 <66291395c0468_1a76072943e@willemb.c.googlers.com.notmuch>
 <20240424115712.37d27b05@kernel.org>
Subject: Re: [PATCH net-next v5 0/7] selftests: drv-net: support testing with
 a remote system
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
> On Wed, 24 Apr 2024 10:13:41 -0400 Willem de Bruijn wrote:
> > > I haven't thought about this part much, TBH. I'm not aware of any
> > > scheme used in other tests.
> > > IIUC the problem is that we need root locally, and then try to SSH
> > > over to remote. But normally the SSH keys belong to the non-root
> > > user, so SSH'ing as root is annoying?  
> > 
> > Yeah. It requires "PermitRootLogin yes" in your sshd_config and
> > installing root keys.
> > 
> > It's not a huge issue, but if we do want to fix it, doing so will be
> > easier early rather than when more tests are added with implicit
> > dependency on having root.
> 
> You know what, we need a diagram. We currently expect:
> 
> 
>    ------------                                 -------------   
>   |            |                               |             |   
>   | Local user |                    ---------->| Remote user |                
>   |            |                   /           |             |    
>    ------------                   /             -------------                
>                                  /                              
>                                 /
>    ------------                /                -------------   
>   |  >*exec*<  |              /                |             |   
>   | Local root |-------------U---------------->| Remote root |                
>   |            |             ?                 |             |    
>    ------------                                 -------------                
> 
> 
> We run locally as root. Putting sudo on all local commands would be
> annoying.
> 
> On remote we don't currently explicitly say whether we need root.
> The user is basically implicitly controlled by the REMOTE_ARGS
> and ssh config.
> 
> REMOTE_ARGS="john@machine"
> 
> will make us log in as john. But *from* root, so pub key of root needs
> to be deployed.
> 
> We can support:
> 
>    ------------                                 -------------   
>   |            |                               |             |   
>   | Local user |               ?               | Remote user |                
>   |       ,--------------------U-------------->|             |    
>    ------/-----`               \                -------------                
>         | ?su back to user?     \                               
>         |                        \
>    ------------                   \             -------------   
>   |  >*exec*<  |                   \           |             |   
>   | Local root |                    `--------->| Remote root |                
>   |            |                               |             |    
>    ------------                                 -------------                
> 
> but it's unclear whether that's all you're asking for, or also:
> 
>    ------------                                 -------------   
>   |            |                               |             |   
>   | Local user |                               | Remote user |                
>   |       ,----------------------------------->->?cond sudo? |    
>    ------/-----`                                -----|-------                
>         | su back to user                            |          
>         |                                            |
>    ------------                                 -----v-------   
>   |  >*exec*<  |                               |             |   
>   | Local root |                               | Remote root |                
>   |            |                               |             |    
>    ------------                                 -------------    
> 
> which would require us to annotate privileged remote commands.

For many tests the peer traffic generator/sink will not need to be
root.

But I already see some counter-examples, such as the PF_PACKET
packet generation on the transmitter for checksum receive tests.

