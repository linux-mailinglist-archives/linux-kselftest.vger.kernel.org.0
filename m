Return-Path: <linux-kselftest+bounces-45206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE03C44D1D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 04:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0DD2B342E1D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 03:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BFB25C6F9;
	Mon, 10 Nov 2025 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1BjdBfa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677C25BEE8
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Nov 2025 03:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762744387; cv=none; b=l8+1i5MPUiX9XqUcdIUllaP6SR0gJriEdM4g4HmieMKw9ELpxt2nfLLtr7CIXrbPeEJxEre+koITL309/09qInFnqObfrhE7rtyfWFukBaIvDQvNvvc0y2D4fs2RJChqBL0TW/HsL3DTfSXpqbJjgfkItfWqiAGljESFyCxIEcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762744387; c=relaxed/simple;
	bh=BP0jCbPDg9uzcZUZNTwTyRuejAWZJnGl6xyyvqAKTsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBFZSM+/EDC1wabYZ/aas3dxAnUIW1bLbfiGPJ/DuTKo1gste5R4H1qREaZCkvbCLo5GVN9Ri1qj+mO5U2DbisgUH0VlyMNNkhc06rflw988sh1UhmroE0njw9/CB8AZ7PZGdb/8LzeYsvBMTG6xgKUnfZc6eyK2O+i6JlNx/1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1BjdBfa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297e982506fso15262655ad.2
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Nov 2025 19:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762744385; x=1763349185; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4H/ags/15DhAGP94uFsFxIbfocw9Zht18DeHw4uCbc0=;
        b=I1BjdBfamhqqlDFNchY7rxxYGTBGjQ92nq621p5MUamoyfATU51XH8P5FYb9Mn8ZtX
         qLcV7oQTPAF5XbYMUoHNjG9+uq5shO6OGBhButpCA+tpkBC1kfuB4baYaGhpdLlyygM/
         Gy/fyBiVpPsQaKBSlJPnK+MnVmJ8ikdohM1fwtygHFDOLWF3HCPeJjnx6dr9+YRNAoys
         jFcHqowjKLrCPfhV7h/IOXALi2guxwgvTTEQfvCVZ3MQdos/Ir9NrUcgUyk7jWoAF3KI
         llIH9y3ek0ckW0Xw3ZJg5ahfpkH+A8ILbrfP2kVfnD74OKhUAxrmYk8OCy3uD2oGZ+oi
         nKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762744386; x=1763349186;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4H/ags/15DhAGP94uFsFxIbfocw9Zht18DeHw4uCbc0=;
        b=Y16JzzR8hYX+v7ykzPemxqy2HAfbfZ7gpALdsHJk6ngOPi40zZ4w24bBQEZAyl9ZTf
         PPoehKzexlFFsj4w1kQ5mF3QEoQlRgK6SQZi27f4/b94/UUHKbka9l2t2thu8mz9q4Z+
         23ueIGn5lNQMn12cRxHwiyXV0RdHDpn8lVokU7FQQKWLGW5HqEV39O+fmS2wzd1/0Qtv
         C5GBkvqj4vnmxHEOTuXcmgTEuvpDrRWvClKkOSfn7oEnwwPUR8meRKxa9+WqyMQWFN3o
         gBSXR2XHGkABKyKUQurJSVk4OwHIe22nRxbzn74GrbAITt33g7VaGmOdSV+mo//sWmG0
         wLig==
X-Forwarded-Encrypted: i=1; AJvYcCUs57ri51fo5L5b7imeKfsxnI5+7I7y4E+0A+x9UnRG3Iiixk49rWc5zA43rt381t09nCkgK5C0CdsxvOpY6aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzuNuxuxSfm52wx/IswWVwAqbcxjOE6p8+iuz4lz5WDSbOqXQu
	zgfy+3wqYqXTwJHXFU0/RzcH8cvWk4etePvahhp+CRprVB6VZBR7yR6r
X-Gm-Gg: ASbGncukuztumHGMOrj9jtOrl0itf5PuimdVM2Zr08WaiVfkI9MeGwW2+7kVBmHYi1X
	VOx+3LBxs9ydLBNGO75A9On009j1duYWkhoTFQ04hAEubdVOBRKRZGHYzRLtO3e7M4OEsIBpYTS
	KskBjxtVPs7jIJkHyxmUIgYS91ueZy8TNNFULjK0hX1iYyKYXNKsZcPZ+fTxbnNl83hVi9vE+QM
	TJae6ad9f+pZMHWatx3edE8mNhVAunyijhzWbZ9dXh5gYV8kwOmu5U2oqjX5q8BbSnmXh5Ebwtk
	7LfWtwi9oxhVQy8avRdljROCAKTSjC2D4j78OHPM8If2cjXTGuD+Vego7aVgPy9q0+7zfs4CWVy
	y8cEJweHfgONhJI7a6DuOnn2DvqmVfI3AzgHYOOPhf18vNufd0j3uP1jzAWWDOT78S/7R5QMr4S
	aSSSND
X-Google-Smtp-Source: AGHT+IGFlHDqc7FaMIkEwZOMGjjs12G9s7xHLqJnJV22TAEVkA0t05Yocyi4MZ1SxQ7emQqI/BwsPA==
X-Received: by 2002:a17:903:244a:b0:290:cd9c:1229 with SMTP id d9443c01a7336-297e56223c7mr80661505ad.19.1762744385410;
        Sun, 09 Nov 2025 19:13:05 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297f2d9c971sm46794085ad.55.2025.11.09.19.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 19:13:04 -0800 (PST)
Date: Mon, 10 Nov 2025 03:12:56 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] netlink: specs: update rt-rule src/dst
 attribute types to support IPv4 addresses
Message-ID: <aRFYOGYcEIMezKVP@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
 <20251029082245.128675-3-liuhangbin@gmail.com>
 <20251029163742.3d96c18d@kernel.org>
 <aQnG8IYsY3oyYekf@fedora>
 <20251104164804.540a9b8d@kernel.org>
 <aQsDA7ufLlIwSf1h@fedora>
 <20251105161319.0591f96e@kernel.org>
 <aQwJLKka-_pBGq_g@fedora>
 <20251106064104.135b73de@kernel.org>
 <f420e34d-40ff-43ce-8448-e7947d666dbf@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f420e34d-40ff-43ce-8448-e7947d666dbf@fiberby.net>

On Thu, Nov 06, 2025 at 03:07:24PM +0000, Asbjørn Sloth Tønnesen wrote:
> On 11/6/25 2:41 PM, Jakub Kicinski wrote:
> > On Thu, 6 Nov 2025 02:34:20 +0000 Hangbin Liu wrote:
> > > but genetlink-c.yaml doesn't have "ipv4-or-v6". Do you know why?
> > 
> > Probably just wasn't used until now. It should be in all the schemas.
> I couldn't find any other users, besides wireguard, as other families uses
> the ATTRv4 / ATTRv6 style attributes.
> 
> In commit 1b255e1beabf I wrote:
> > It only implements this display hint for genetlink-legacy, it
> > can be added to other protocol variants if needed, but we don't
> > want to encourage it's use.

Thanks for the comment. I will examine if other parts also need an update.

Regards
Hangbin

