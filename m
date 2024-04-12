Return-Path: <linux-kselftest+bounces-7830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2838A3446
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39955287847
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B0614BFBC;
	Fri, 12 Apr 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPJTI1+V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E8E148FE0;
	Fri, 12 Apr 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941495; cv=none; b=UUoDmsNHHLRgXXuekR0iJh0reBWoF3/OnhaEoA9D/OUjBXKkUL1YpcLl2exSQstcQks2qCRjmKGoa0YngfaaPo3YgLIGbM/clgFEe4PtqjwSCYgps4bq3GL999CtidxgpB7Vs1Q5s3pD9Y5oPVd1Sz4jvIAacPrImNZ6GNUrcKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941495; c=relaxed/simple;
	bh=M7r14FHjZbuhdCAG+sZjShy/l3FXLIbS90iDEYwkv8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZPn7WrrGkc9XfsDYTX2LLBjrBm79ny/JP42768fSDmseyoAt6WWJBZwfkhSlo+5I2eTUiwYlStn6mM8cahfaigA6kqSktgX0azgv9wDDiWrrmCFO2kn3GhSVV5juail4DCcDDiWskqfY1hk9DVxmKCh9VU5yIgLS15O6w0mj1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPJTI1+V; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so1087536b3a.0;
        Fri, 12 Apr 2024 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712941493; x=1713546293; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vRBBp2kQIwax2hPIS89JrnPtpcdPuEq4eh4lk133lk=;
        b=EPJTI1+VGHg9ClFQqGY5WVTuRjounNq177ecsjlxBOXwMJHO9zBu23LK3MiluvePjz
         8LOnziKsqn8KPNNfYRbrv0b5uk8/4fMCV+d1ikbdrTNo65BJmvhsIQZQs6J5QoasFAzH
         6c8mCHZaCjOgU4rFezkk7GxTF103KWFKE74lrJwS3KIu3xW7j80Ye6X2jk6VFfMeUz+e
         k94MGeln4msKHtmsW32apw6HPRLop1/+VR0k6AeEFVzz4/UuRY9+hJht1v3elKI1I7QU
         4YCi2eU+BEEsJKL9U5Xjdth/kfBanZdeCHX0WKccErQy+mNpEThfLmq1m2mQDU7VyeZp
         DhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712941493; x=1713546293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vRBBp2kQIwax2hPIS89JrnPtpcdPuEq4eh4lk133lk=;
        b=e7lPllQtgXA9yM9VMIKbDTbvmFofL+aabo7ekjeN2BBVPY7zYR53xaaSAMUNKQZa85
         txrHXOQz0D1dADy74kj8Fz6bf+Q4fM/IhlSaWvbPXOLXqWq3SPQsJCzUojqcy3+6dTIQ
         Jr0+AoAF/N9UuRm70kC9oQ8SAjRvykSZkXw/SDbBgnMVBtHvGnvU3zG+7EroUVKiJy/H
         6S2Egaxj39Tgsrd1WFa+eDOBzaEUoRbJdafkc/rEpvaGc7Pv8MccHNIswEkYPTCOap4H
         Z82Q4ANoVLWqnnhKOX8WUVkhgWk+iYJE2Zod0lz23D24UvQNjdZBxUv1Nq4wvEgkqQz8
         FvpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq2hxp3jL7ZN6ioqSdeE1EItwap+Nj1CZE60BVUWBena1wujSMdnb5aMwyQZe0WJKqHzJ1bEjdU3+y00/s35XYEljBbk/F5lce3Lpitv76LGhwcFWK+XGjY9+nhpr7ZvTVG3ze0lkS9TZc+TMEMv8xxi/fJuyhHJCFoXJNBYbXxfp6T/FvcI1d
X-Gm-Message-State: AOJu0Yxozg2RRZ6Sdt0KEMJs0TDKGH1PylCQEsPkLRvcu2yqLHwAgkLC
	+YVtwgw+W3rrZVj3KReM2ZURU/7Ua8vpBZTucC5tM5rjXBtbMPC0
X-Google-Smtp-Source: AGHT+IFDP3zAZVc9G1jUxQumgWQfNdz762OArh07eRsQiNx9aUqkQbjDFEDxwIlscgrSQkVXIG0rbA==
X-Received: by 2002:a05:6a21:33a5:b0:1a7:51f1:f778 with SMTP id yy37-20020a056a2133a500b001a751f1f778mr3758604pzb.37.1712941493479;
        Fri, 12 Apr 2024 10:04:53 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a5f4])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a070900b002a63c29d3c8sm3245156pjl.41.2024.04.12.10.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 10:04:53 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 12 Apr 2024 07:04:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Subject: Re: Re: [RFC PATCH v3 2/9] cgroup/pids: Separate semantics of
 pids.events related to pids.max
Message-ID: <Zhlps1a6C6U6_4ed@slm.duckdns.org>
References: <20240405170548.15234-1-mkoutny@suse.com>
 <20240405170548.15234-3-mkoutny@suse.com>
 <ZhQvmnnxhiVo1duU@slm.duckdns.org>
 <w7cenotcuudapq4zsq6mybfvaqyljgy5hez3uc3byqzdn44yi6@76yfnhg4irt6>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <w7cenotcuudapq4zsq6mybfvaqyljgy5hez3uc3byqzdn44yi6@76yfnhg4irt6>

On Fri, Apr 12, 2024 at 04:23:24PM +0200, Michal Koutný wrote:
> On Mon, Apr 08, 2024 at 07:55:38AM -1000, Tejun Heo <tj@kernel.org> wrote:
> > The whole series make sense to me.
> 
> Including the migration charging?
> (Asking whether I should keep it stacked in v4 posting.)

Oh, let's separate that part out. I'm not sure about that. The problem with
can_attach failures is that they're really opaque and the more we do it the
less we'll be able to tell where the failures are coming from, so I'm not
very enthusiastic about them.

Thanks.

-- 
tejun

