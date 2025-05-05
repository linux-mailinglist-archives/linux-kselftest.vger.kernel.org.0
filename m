Return-Path: <linux-kselftest+bounces-32453-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E85BAAAE9C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 05:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370E83B8F56
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 02:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E898F38B4EC;
	Mon,  5 May 2025 23:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bGsJ3rqe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com [209.85.222.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33ED2D47B6
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485625; cv=none; b=Nvl/73P3dZhNC/J3+SIwcVf2qd/82BWtfXxyyqkOm32GHJMRM2SFWskCpVIsalkik7p5Fudu/EI8E0JGfE2/n01WxuJjch/F7PxuTwpefGR3fPJFaN5Nna1Qi4rOoP+Fe+dQ4t9WMoXHsFnpza954Az4mDVtdru9n/4U1pIQ6VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485625; c=relaxed/simple;
	bh=oWRWu4J3rOlzeZEZE09NG8G8JVW/wVAOK1aQt+vNBTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbP/hf0jCI/5X9P4P+9v82w74PY5yqEv3gXdpGpZGvCzCjyL6jxVZv5OXq02zVB7Ph6nLtM38iN0XRszQQGGLZgZpQ9eylHibKPJPPPwhLAXDIzswlciVl8ARsdZCbJyu5WZEXePJQ0PgTr4jIeSN3qM03/QmLEn1A/Y1Hq4YJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bGsJ3rqe; arc=none smtp.client-ip=209.85.222.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ua1-f97.google.com with SMTP id a1e0cc1a2514c-875b8e006f8so1222546241.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 15:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746485621; x=1747090421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eiXzmkb8vltyH6u1BZ9L/v+dxL0ZMqO2O1cKAYZNXPs=;
        b=bGsJ3rqe20V11uU6uC/iGYzpZKh3HRfig0sea/5RoX8n5OVPtHegjGPFD4xu6w4ph8
         CNqcZh5i/ZG6nnbU74h0d86JJJAmEGTgCmuANFaZEU64iDNBUp7Gi8C84KgQUR9AHgY3
         vp96z2XM4EPNNvQEGC2Mj6wXlWeNlEFvp9OM5TWArIJL/zhen0wOwN2S6VDlEy/XZHRS
         S6FmSFPdFJbPxZVBSH96YZY7z3SJx/dd2BC1lLSVXhXKRBNlXorGLuWxJuo6D1J3C3a9
         F4lYi/djUnNL72zS0b17PZh6RG/2Xj0X3UoG7228wFpagW8Q8kLQW4hAC+p2QB2R4lRP
         XCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746485621; x=1747090421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiXzmkb8vltyH6u1BZ9L/v+dxL0ZMqO2O1cKAYZNXPs=;
        b=tOdc5M61w9vWnhkAAgwGKgrYvroOaQZzPzYdc90oIyiZSqhNYpPWUG2pdE+JAUcAK8
         L/34GJ3Bl24MOEK36DMqMsaQr+jKWEewcu7IGkjd+kSlQQ3qrUv5c0UYHNfW0COK1ZXe
         xiQFLqAeWl/z2xbbiB/FgTxvaY28v5g/KbpRHmDLELBNQMB15lLLgzhB9HxRHETtMpCE
         KQXw4tQkw0X4mspDgWHt6ozmdVvWu4cR0WT4NApLmxaBHTHtagYXxC9mNjUQfwEcMy0a
         bUk9aaMU8So0+QdipYJYUKEM2J0DoBcw/omgE7j1w9bKRMzP4MRf1DsTB1peIhQO4o44
         ma0w==
X-Forwarded-Encrypted: i=1; AJvYcCWrkJiCGDrb0Pm0GZArATVouUGlJLUIW0Ez0FtKrvH0kOWQvCCA2nX2vbbVFTMKvRcLEqMIcJNcjYAlRxvpQmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFBXzS9crICMZVZ8NOyuUdzq3EpZCb171K3SivpTBwDVLgD5O
	AISSySFaRYHZniw2+kJfveeODSM1XNVO6vhUTOJvjsK/c+znMdW+Wto2d9sm0VNJwENbh6m+GGv
	vAji4IJf27MOGlglNLhE8IcoJVw0PzXCM/5+m8dLRRpbJWkCK
X-Gm-Gg: ASbGncuwR7IZRyU12mVVTiWiXS8/mXsKzUe/OLmV81oGFXk/Pcl9pL0yH1eOn6yd0xM
	H+8p+C+o93UDGYz69wzKVVJdevqVXgVn9vYrpznWs+UNKXwInLhV7cOqjyNZWIMBjsrPTV7lV7Z
	wtO8H62aEsasgCdFMb2N5XcOZtYh9L3t6p+2tecUxIcFoBT6B0czlnAVVDcee6APMPN64p+JFvx
	4xq9x+c0bizWvR7RKQRW0Ub/Iz6XLvazaCIPmVccHf7id1+xXey5iJRsQS0lptO9rKk90FLeiWT
	cKFk498mNMXayfIdaWASSO9E8gxtJ1w=
X-Google-Smtp-Source: AGHT+IGuGPu+zNWnKMENBRH1cGq6mvAP2tt0vUVDuY0s1KGIy/+MxU+EJ2xkScan9kLdomgicesqCN/5M43b
X-Received: by 2002:a05:6102:5681:b0:4da:e631:a472 with SMTP id ada2fe7eead31-4dafb690042mr8174826137.20.1746485621498;
        Mon, 05 May 2025 15:53:41 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-8780afe9e7esm785191241.3.2025.05.05.15.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 15:53:41 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id BCD78340278;
	Mon,  5 May 2025 16:53:40 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id B0A55E40643; Mon,  5 May 2025 16:53:40 -0600 (MDT)
Date: Mon, 5 May 2025 16:53:40 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] selftests: ublk: more misc fixes
Message-ID: <aBlBdBl8uKCIVOPG@dev-ushankar.dev.purestorage.com>
References: <20250428-ublk_selftests-v1-0-5795f7b00cda@purestorage.com>
 <aBkgLOxWLp74TShe@dev-ushankar.dev.purestorage.com>
 <aBkg0LW5YO6Osdnw@dev-ushankar.dev.purestorage.com>
 <3a6050b3-03f6-4c22-a2c3-33ab6a453376@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a6050b3-03f6-4c22-a2c3-33ab6a453376@kernel.dk>

On Mon, May 05, 2025 at 04:44:19PM -0600, Jens Axboe wrote:
> On 5/5/25 2:34 PM, Uday Shankar wrote:
> > On Mon, May 05, 2025 at 02:31:40PM -0600, Uday Shankar wrote:
> >> Hi Jens,
> >>
> >> Can you take a look at Ming's comment on the first patch and merge the
> >> set if things look good? I can rebase/repost it as needed.
> > 
> > Bleh, sorry, I meant to send this as a reply to v2:
> > 
> > https://lore.kernel.org/linux-block/20250429-ublk_selftests-v2-0-e970b6d9e4f4@purestorage.com/
> 
> Let's give Ming a chance to review v2, then I can get it queued up.

It looks like he has already reviewed all the patches in the set.


