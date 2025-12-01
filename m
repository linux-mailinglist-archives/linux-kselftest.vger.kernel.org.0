Return-Path: <linux-kselftest+bounces-46856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B20AC99428
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 22:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E383A19E3
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 21:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A15A27AC57;
	Mon,  1 Dec 2025 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epKXQEpb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614372749C9
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 21:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625863; cv=none; b=t8wDv0LjtgxhpJMPvgEdZvabMDURwhSXeuENevlWQtONS9a2u1R/CWkHWk8YqGZnZxStvpOK5OuqiGqzYKgTQwdHaFYXmRfNThfsTsk1QCcuebWY1cA/8Ud4lN8ShPabv+JlB+pv6vew4eEPXypMXuaHVPrERTzccwGNBEqgRGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625863; c=relaxed/simple;
	bh=lBhsm34b8HRtF0qiK5+BYRFUpoqzlRFpLa0qPZI45N4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=aL7hrCzj0QrC7EHlMae/ExAivw37FeLgDMMjkv4eiyPb2/sAtFCw7It//yuwn+4N7d8LvmjF+8Tz6RZL0Gs4vrb7LAEbKNA8UBnmSyx0OHc1WXq5Dx4TDgXQvB72j7vY+cKfoq8rbJTb5WNDZfTvnHlYG9VeMFD5YzHbpeF3Ov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epKXQEpb; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-786a822e73aso47648307b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 13:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764625860; x=1765230660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/Ft14pK70CD4rBElRNDZPQO4FwJE1Kwzd6HfV1lFTo=;
        b=epKXQEpbQKe5Pr8+6xHHxOOUl5Df/RkGjelbvsAKw4TxRWcpjyZukJtNKgljHifIrS
         +akmnUa9m4qq/pQTslTRaxp+nT2HIatfU8ExTAFJydhch2HvwIvANk5WyxxFGcqXs/Ay
         PQpZC23QuOs/Uk3el/+POPoMqYZa1voGIVqL0NC1ejEAh/Ziw7Np3VZFkTuLGSShBjwj
         gPXgG8dIEhKy47OCh+BCafNH0ipPz1LjeTDVitwLsLtEggjlqfosz5TOwiCStXSw0OC2
         721Tncf5KruokxKDUZolTyM/Z/r4boNO6aJWwLg6z/t1IonSpskaAL7WOzl4vx4V26Zk
         LLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764625860; x=1765230660;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/Ft14pK70CD4rBElRNDZPQO4FwJE1Kwzd6HfV1lFTo=;
        b=pyzM41B4Dl9hnLztfLcRzjLoYBl4wS0wqOsh7MmYT52LBTqjYkRcj01a7p8urWdP7p
         KyT0jeYtLYJMnx8agOGuKYtovjrOWwHvGOawfLIvBTjslS5Kk1geAXNzUsGj8Q4MZguf
         6imbq+qXNa+AAbPNCjdyWC1O8FDfzaxYQlMQWla06Lb9duT9xQ9ZHT/O//FpNge8jZX5
         1focCGSACWtoxCp0qaXgFpJ1Obmqm2g1yKQ3sIiV1gFrbpioFQGV82Mh3JxtGvcEB5YS
         J0C4z9gGXHoxhYh3U9vEgq49rJtugg5yUfKN7YFXiDb87/yVtHSaQqeGzaxuqS224Rop
         sUtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDWr9T1+GbZyViDdowRA8Fnhh4b7Z7KHeLyge4NqCr8l1pAdWtsB6lmj4jnOz8thAL9jGZ+txYrUzAvazmnOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTUHscfiNBWymZ7nisoDL4zOLj1PaK6TX2DizepYbSYLM9WOW/
	tFQL8y67q5rqkiuxnxYaUGWPw7tKQ8i/1lbNI4mpTGXaPxFyYyRhvhPpWFKO8g==
X-Gm-Gg: ASbGncsUcFOMCQARAueJvIxs77RhySACUdyh7CeVmKTQrDLMMyGKPEGfvKy9zSnsLwM
	ob4lbMhQiyFGVL9EuNrDN/huw6J0TbTIex6z/Gp+RVpgcl+6MFaaNWR5e7IfOBHwqlkBd0nD8qZ
	vogU5YdG9RfI3UuL4KRvDy66cYOa1+RPElyojsDsT8lGmKp6dfMMOwgg2aNgNOWOstncbNPD+w3
	xluoUUutX4Q4L7qUufaocShnWOm2ALB4QmIcdfdRK5SFy05YfixhoK3ud/o+Hrc7wHa1hQWQSO2
	JM8Z9/jgYOIXzFfw8K6vPgwYHzGmnG6waI0SAfL9ypJAkG+SfBMAoTgs4DkGNtc/P6/gBlkXqO8
	N7GPgqJjXDqWYkUINd5K8/yePSzt4e5y+E4rnERYxG2Wn0DiNogR+DrX9AtrUarZ1xBbMehRIty
	OtVHDiGEzHtK5/2dCMvFCEiWmPAT6hMJMdF3+JvVTF1dm2LdMAHxXZLMlWOwDIcrhbYgk=
X-Google-Smtp-Source: AGHT+IFEirLemOCPBYW5SY+npyALCUTmcHk0zsceyQ+TZxHYOB6eir6q3oSUr2MGTHxgxQ7INoy8Fg==
X-Received: by 2002:a05:690c:74c7:b0:786:5499:634f with SMTP id 00721157ae682-78a8b525dcemr320353247b3.41.1764625860331;
        Mon, 01 Dec 2025 13:51:00 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78ad100e94fsm55276807b3.32.2025.12.01.13.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 13:50:59 -0800 (PST)
Date: Mon, 01 Dec 2025 16:50:59 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 sdf@fomichev.me, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.18907bed3c8c6@gmail.com>
In-Reply-To: <20251201115041.5aa4c986@kernel.org>
References: <20251128005242.2604732-1-kuba@kernel.org>
 <20251128005242.2604732-2-kuba@kernel.org>
 <willemdebruijn.kernel.468ae2cb7a74@gmail.com>
 <20251129173851.56cf3b18@kernel.org>
 <willemdebruijn.kernel.3877052beef72@gmail.com>
 <20251201115041.5aa4c986@kernel.org>
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: gro: run the test
 against HW GRO and LRO
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
> On Sun, 30 Nov 2025 09:56:24 -0500 Willem de Bruijn wrote:
> > Jakub Kicinski wrote:
> > > On Fri, 28 Nov 2025 15:42:40 -0500 Willem de Bruijn wrote:  
> > > > So GRO off disables HW_GRO, but not LRO? That difference is behavior
> > > > is confusing. Could we still see this as a regression and make the
> > > > ethtool HW_GRO feature equally independent from SW_GRO?  
> > > 
> > > I couldn't convince myself that it's justified. Of course it would have
> > > made testing a lot easier. But apart from that - what's your reading of
> > > the status quo? Working backwards from were we ended up (and I
> > > haven't dug into the git history) I'm guessing that LRO disable is used
> > > to prevent changing geometry of the packets. GRO would presumably be
> > > disabled when user knows that it will be ineffective, to save the cost.
> > > Or when some portion of the stack (XDP?) can't deal with super frames.
> > > 
> > > If those are the reasons, practically, I don't see why user would want
> > > HW GRO without SW. Ever since we allowed SW GRO to re-GRO HW GRO'ed
> > > frames it's always better to leave SW enabled. HW leaves a lot of
> > > aggregation opportunities on the table.
> > > 
> > > I concluded that changing the current behavior would not help any real
> > > life scenario, just testing. LMK if you see one or the inconsistency
> > > is a big enough reason.  
> > 
> > I think that's fair.
> > 
> > But from reading the code I don't see how disabling NETIF_F_GRO also
> > disables NETIF_F_GRO_HW. And indeed I just tested on one (admittedly
> > not latest upstream) IDPF driver and it does not.
> 
> Looks like you're right. Broadcom drivers where GRO_HW originates do it
> locally, so does qede. I guess somewhere along the way drives started
> treating GRO_HW as a separate feature rather than a GRO offload. 
> 
> I don't think it changes the reasoning in any major way? 

Agreed. If respinning, maybe change the wording a bit:

+        # a dummy XDP generic program. Disabling SW GRO as a feature
-+        # would also disable HW GRO.
++	  # may also disable HW GRO on some devices.

