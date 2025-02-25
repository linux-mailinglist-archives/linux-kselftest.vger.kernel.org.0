Return-Path: <linux-kselftest+bounces-27448-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D090A43F89
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 13:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FE3188873F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 12:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3605E267B8A;
	Tue, 25 Feb 2025 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKKJckXA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07025487C;
	Tue, 25 Feb 2025 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740487029; cv=none; b=lm9EIyjfll0SEyaTp4yWo0S486F2Pf0C35v2+Ol3OD7kZUtXI1X6/5sb5pTrCLxLwX9YLpjVz1A27GnEO43DLQ6Asi/bFRe09OaVdmEPDaIN8WcowNbavM5DPTjnQ7+sCZd5a2b0GMwPCRGkTNPzDjwzYCTiqC5MuGh+6P7T14g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740487029; c=relaxed/simple;
	bh=W5InabegADnboM8GpEhi3zVlkCTOZ31FZiTmuk1cFaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/IPnD2Bq4gkot9o0GByy1+fnr8FWgsrQwyHVU15tDmFo6TTkxVafi+3YC3wOu7wfN/63G7efQyCKPdHWhu2sWMeH4Vk/rxz/HYQxMJwpuytZMuZeofikgr1YS9jXZKMlGRNjNJl5MyOZbjJ/5v2ROFaJyX2W7oFdSNySbD0kUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKKJckXA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220c92c857aso92872665ad.0;
        Tue, 25 Feb 2025 04:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740487027; x=1741091827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zmzilI70g+hJ2t2NvDXbcqT58xMGphKxl1+puSjOTVQ=;
        b=iKKJckXAtPvql4xzEJQxZqsu2Q/HftEyW8YsBtOc+6jw0/dBVQ8SNaV9h9DSMaZZeb
         wuvV5W7odDXFSYMjTcOvpvI6rWn0HGJSWyD0fQWA9NAx85Htc571SDd2Aw4WctdHcJge
         lkfmA8Ls53CUVCQIDwc3jwVUflEYngIODt8b0BgQvYqeH0CwQcnh5CBL1sTtWLN+it1D
         QUTTIqXlGnnd8k+fnnY7gVd4BOJjRVxPN7a+3FrHAAI4TREE9yUxUaIb8mv5WBGb+CRt
         OhTRzORzeNsYrZ6BRC54QbpKwZAvVerRDYBh/z7WzdAogfeNrImDxgQmIABGr4112cY/
         PMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740487027; x=1741091827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmzilI70g+hJ2t2NvDXbcqT58xMGphKxl1+puSjOTVQ=;
        b=LkSD1350ubwPKFLOryfELM/1sIO/Npe/uWe6XMOk0tQpfy6e4SlAfF5I4s3Yrd/UPV
         dN2ZUwSazBAjRyt6WNWBfJkTTlAmEKEMzUnvl7AvYECgXMFk0EwInFCLa0he7p6kWYU3
         2UHjbERZo31HMajkkmBWwPOC+Xv6ok6iwVahHex9HAmPvvCNx0Zv/JMKaL/MlfjUgPjT
         6IVJiCoAv0Vzc0y3oaOcaLqesig7a8nxo5FOb0YmEGuuzTTNGe81VI+VfMtWOTcz67rZ
         L0rviVRBGYQb330cmjsF4rf1EQFzKWCfsT3bSlskY/Q613imbvue0lEqxCHcA/m3yq13
         ZF1g==
X-Forwarded-Encrypted: i=1; AJvYcCUHDjTi9ZGRQo6H4bwzirkFF+SJZ3KTuv1FvoTVvx5sziKEhulCR8P4htcfgRx1fPeKLYlyy1kun96/54A=@vger.kernel.org, AJvYcCUNhOp21qC2IVPwS7QDgO1PYGHOcBh2OaOS0VThBCruxPELJCwSZbaBGk4vwDxAaD6GTaHTgoEIDSfa00AmQM64@vger.kernel.org, AJvYcCUSRRlaDHTCNJiqrNA+vTnnlvM0AWqtLuwg6uuB1RzhzQJcgJgR92I55HnBR6uN9QlNUk82yf+F@vger.kernel.org
X-Gm-Message-State: AOJu0YzDEEQ1nDceeSNL7EwFOtWDuDOcFb3TOr1CRiByiSSOnqq/J/jK
	doxHn2MxV2cbyakycq/UT05ZGiMURVtLW8cUIigHTX64WSiwpBFK
X-Gm-Gg: ASbGncvEh/3CNgLmfyYX86Uszny2OrGc9aqtPB8VnV9gKKAL7SeICMyfNmLakGeBhol
	vfNnetGgx5Z4Uvq06nr0YfNQnXEO+p2/bxHf9qRuuGiT+lASUzxGWaBX/ZcWpB7A0o+Yh8cnQvQ
	klq3bStqygWHOF7g139oFuhiwd3/vYlin4dGeI6XnisIAVbwcBlBQ2ulQJx2fqmkNDXw94o2cLj
	lm7Z3fyxPchr8lnbu9hNNv/LfqSN91sWlimOK5t8J4FZfAxaY7qodlssH2AMkUNJA9DveOiOG0F
	aOjCeTVy+l+wh5DhcogajFN7CIgyc5U=
X-Google-Smtp-Source: AGHT+IHmiqmSEz1C/XUho9yYXkMQSiCuDmaZZMTBM0LAyu+f0CCLeXaJHbngax8Bvyp10xXZQUSpxg==
X-Received: by 2002:a17:902:cec1:b0:215:58be:3349 with SMTP id d9443c01a7336-2219ffa04dcmr320989835ad.14.1740487026762;
        Tue, 25 Feb 2025 04:37:06 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a000520sm12949155ad.52.2025.02.25.04.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 04:37:06 -0800 (PST)
Date: Tue, 25 Feb 2025 12:37:00 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Davide Caratti <dcaratti@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] selftests/net: ensure mptcp is enabled in netns
Message-ID: <Z725bDY9YJX8ydEu@fedora>
References: <20250224094013.13159-1-liuhangbin@gmail.com>
 <b7bbe504-d6f3-4262-af19-1edad4129fa9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7bbe504-d6f3-4262-af19-1edad4129fa9@kernel.org>

On Mon, Feb 24, 2025 at 02:53:13PM +0100, Matthieu Baerts wrote:
> Hi Hangbin, Davide,
> 
> On 24/02/2025 10:40, Hangbin Liu wrote:
> > Some distributions may not enable MPTCP by default. All other MPTCP tests
> > source mptcp_lib.sh to ensure MPTCP is enabled before testing. However,
> > the ip_local_port_range test is the only one that does not include this
> > step.
> 
> This modification is OK for me, but would it not be time to stop
> patching the kernel of these distributions to disable MPTCP by default?
> 
> As far as I know, only one Linux distribution is doing that, and that's
> the one supporting MPTCP the best :)

> It was making sense when MPTCP was backported to older kernels, but now
> that v6.12 is used as a new base, it probably no longer makes sense, no?

Hi Matthieu,

Thanks for your review. I can't control the decisions. I also hope
we don't need to do this in future :)

Regards
Hangbin
> 
> > Let's also ensure MPTCP is enabled in netns for ip_local_port_range so
> > that it passes on all distributions.
> 
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 

