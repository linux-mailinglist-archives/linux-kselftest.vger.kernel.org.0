Return-Path: <linux-kselftest+bounces-8809-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2D28B1306
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 20:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449171F2325B
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 18:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E97C1BF2F;
	Wed, 24 Apr 2024 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC2ZqAcw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D69171CC;
	Wed, 24 Apr 2024 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985034; cv=none; b=ZCNw5fEu0LiN/TxKBx/rYn1eFHM/zG5076ZAE/OmWLEmXRyhXDo5OQsoQI/5/1O5hREArlkPuzybbd0DTHLM4UhWPpOhpftj3r2uOGPY2Qi3UT3CF0Ks9WjBC1G9Gk93KGEWPsGZbrEJW4j4PrT6OWwgtCaTNqQAiCElsphZ+os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985034; c=relaxed/simple;
	bh=qIfuaMn3eDiFJI1AZIcNZQmqF4c94CD5LjNrrZcn4Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+TaxBi4VU9OVZEqdFfg+dKAOh6KBUJh0s5676vS1Fl8ZaJFRW3ULeCGTBg6CqWBeuH+zlE/qf6N+eGrVryHFzRQWueG0Ri49d1fFujxtTrl6QIFKHROBHa5A5ykAiqMbLzAsk1BWqLdGAEUl4bbQ47SPLgW1Xujk6BVqbIFQXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC2ZqAcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53CEC113CD;
	Wed, 24 Apr 2024 18:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713985034;
	bh=qIfuaMn3eDiFJI1AZIcNZQmqF4c94CD5LjNrrZcn4Q8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BC2ZqAcwknz0dJCOsvRV1H020NEbzrlX2FtRaDCCi8E3S9Fw4TkZs8W0wwyMGkmT0
	 oHnXBiKczqXzFh8uwip728qXv5DfCYhxY7p7kgxZujRc3pP+fQZPM+lZZlXGQwjqjP
	 YsbMiOeMKqnbZU5LmVgHMayPdt5sCzkSXBfyp9iAyYcwGI9LvxcX3mZuUKLUVE+FT1
	 pioeQQBpG6FSLmMrJJatH1+ah/AIATFLNg2ProuVcLtyHcwBa6f2OWREvvwcLH7D3M
	 L2JyXZ7eeWQEWpK2oX59sxnWHGe2DBT9vKkQ/vr8FqslxtNrUiOY/DzfCDGzAA+RRB
	 v/E+bhPuqFw4w==
Date: Wed, 24 Apr 2024 11:57:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, petrm@nvidia.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/7] selftests: drv-net: support testing
 with a remote system
Message-ID: <20240424115712.37d27b05@kernel.org>
In-Reply-To: <66291395c0468_1a76072943e@willemb.c.googlers.com.notmuch>
References: <20240420025237.3309296-1-kuba@kernel.org>
	<662526f58a70c_1dff9929430@willemb.c.googlers.com.notmuch>
	<6627f699278fe_1759e9294e3@willemb.c.googlers.com.notmuch>
	<20240423185305.15fca2b7@kernel.org>
	<66291395c0468_1a76072943e@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 10:13:41 -0400 Willem de Bruijn wrote:
> > I haven't thought about this part much, TBH. I'm not aware of any
> > scheme used in other tests.
> > IIUC the problem is that we need root locally, and then try to SSH
> > over to remote. But normally the SSH keys belong to the non-root
> > user, so SSH'ing as root is annoying?  
> 
> Yeah. It requires "PermitRootLogin yes" in your sshd_config and
> installing root keys.
> 
> It's not a huge issue, but if we do want to fix it, doing so will be
> easier early rather than when more tests are added with implicit
> dependency on having root.

You know what, we need a diagram. We currently expect:


   ------------                                 -------------   
  |            |                               |             |   
  | Local user |                    ---------->| Remote user |                
  |            |                   /           |             |    
   ------------                   /             -------------                
                                 /                              
                                /
   ------------                /                -------------   
  |  >*exec*<  |              /                |             |   
  | Local root |-------------U---------------->| Remote root |                
  |            |             ?                 |             |    
   ------------                                 -------------                


We run locally as root. Putting sudo on all local commands would be
annoying.

On remote we don't currently explicitly say whether we need root.
The user is basically implicitly controlled by the REMOTE_ARGS
and ssh config.

REMOTE_ARGS="john@machine"

will make us log in as john. But *from* root, so pub key of root needs
to be deployed.

We can support:

   ------------                                 -------------   
  |            |                               |             |   
  | Local user |               ?               | Remote user |                
  |       ,--------------------U-------------->|             |    
   ------/-----`               \                -------------                
        | ?su back to user?     \                               
        |                        \
   ------------                   \             -------------   
  |  >*exec*<  |                   \           |             |   
  | Local root |                    `--------->| Remote root |                
  |            |                               |             |    
   ------------                                 -------------                

but it's unclear whether that's all you're asking for, or also:

   ------------                                 -------------   
  |            |                               |             |   
  | Local user |                               | Remote user |                
  |       ,----------------------------------->->?cond sudo? |    
   ------/-----`                                -----|-------                
        | su back to user                            |          
        |                                            |
   ------------                                 -----v-------   
  |  >*exec*<  |                               |             |   
  | Local root |                               | Remote root |                
  |            |                               |             |    
   ------------                                 -------------    

which would require us to annotate privileged remote commands.

