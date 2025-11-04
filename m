Return-Path: <linux-kselftest+bounces-44699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DEDC304F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 10:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F493AAC75
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 09:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE1A286D4E;
	Tue,  4 Nov 2025 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQHnrjMn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF1F1DED5C
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Nov 2025 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248443; cv=none; b=h48c9/7SCKxVwOaO1KErrcr0PJo6rr80nAlfj32HN5GeykKfgwFH/4OXgS+aeyLBjhHpONfa2LGUstDZrUbTKjzXDs+BYc+kUMTk+PRdChBwLWL3qrVWLSbzt2Sh13Dr3FoEoJsYo7JrNUPwKCjRcMXxi3/CoT4BySOSAKRoVbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248443; c=relaxed/simple;
	bh=Xlh8IX2UxKPjmcYl/o/bcB5iJvFYIskHf31VHQFGkFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ta2BYsCbjzHa3D54PHjxepH8o3rS+mhuQKV5yLYYDq1Kaqlp2zJv6VjZ3OdkPJ3OMtgFxvs96cUmtd3g5HPaQ5j2eN/dZZwTo2dI6cYDCqvSenAW9jFvhLd0JRqX1NxHbo15CBKFEDA19F3orWSzbPAFKP2qq/UZnO7BGa+ZwLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQHnrjMn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2957850c63bso24623435ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Nov 2025 01:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762248441; x=1762853241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UzXrHOeB98INksGwlSTvLp657Fh/P82/6TlCuQQCFz8=;
        b=JQHnrjMnbPh9r+yAkdhB9PYW4QJuzsQwWfatdDJrwdOMw+7bAs3/YA9BOlKdabz79e
         RVJ5eukBhamc1ysxKFO8caE7zOjdcuZYbPwWgo5igXHY9RTc1gTgwkTSZKGhJo1b8GIe
         Mzw1beK5F48rwAPJg7oCy+oQ0fMhLVOEBKAd3OAW0PJRDx9hvhnMbpGhJEjl3rR2Kv0Q
         OOpKVNRevkUBi6AedXZLJDoIb6gDd0T7qa8WeOuV6lTI2MzkNhQ5ExX3fdSAPVmfT3Gj
         Am8YYLf2x9XgGOuR06lfcVDz+FAUeZOpg6c2aRcPfOLGyhqrDkdwjim5OOxqV1mhqMUa
         VSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762248441; x=1762853241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzXrHOeB98INksGwlSTvLp657Fh/P82/6TlCuQQCFz8=;
        b=EwN0qDs++iAHgXR3bYLWoGjXZMgUTQWy2EEszCN3wc7AZn5QeP8dt6nzpY1QgSMG1P
         xO3tlK/FtopOwiTrAJqU2vlsSIpyV7McuxYPO9hJ82PveL1IkdM9UQh1u3m8+vce2CVU
         H1BahaJoIbLlR4wHaqpzM+TuHa3bJSc0nBoeOLRjO/dd0RZ2M52kxTjKr20zFGFoVRds
         jpVIRtL9d9mOArdcApjs5KG47bHKC7iItCYzpCfn/qMudxlc9Q1vNacCnVfYulcAdmqs
         9+Jvhf3COFy/DPyy9aTj3Y776efYp6C8xlVQelLxFv5aeptxwqMUQxUs/q8MUItS4IDx
         rMaA==
X-Forwarded-Encrypted: i=1; AJvYcCVmuKmpIhE1t51DhS1ig5HtdTveWerIpdVpgTHGBfSJXMUnTg1nYxQHYhTewVMTW4JXH3ltDQvkrpW55eCBU4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSG8iaTcs23xUj7xOuOXLpjNkmFbc9QfqmRAUfhY/SkBd2OtPU
	1KvdnXvNhZBgoSht3RzuKhHhtHPS+zDQKLdHMQ2J+nYAAVjysuO7S6N2
X-Gm-Gg: ASbGncs3ROVW1qRBDDGT1TCnrLJ3rc/2HTSKzYb2Pg8AsQQKWwuUOF6ra4mmojFTrVp
	abtS8BI/4rbMUO4lYyF3lvSrc3bdlWUfG88XsofP7vpSBgNECnFyi9LFd4RyORvmloCs6Zs5Mvj
	YYdhi3cBJh14KpcBOb75LWkGlpU/NiegT1qEXYbsIjUWzMElVWiB+EdlzK/BfNpbu+EET52WKuK
	XcYVOlSzrmpbUx6ESqDXst7Gpzi43EzBVUm4AJzO9zveCi+SN/Vkh/q6HwMa5h6P4LAnab9Betd
	k6EDFK2iXJt2MDfPRoGBHXvQYxZnLD9/90v397C3GoXBBjf2zfvAC+hmaszLH8Gxu3UFJv929uF
	NjzYs1uqRGQel2Df0LBiZTUGuUnR1BE6LdfQT/VzYTFLIkdx1uSbNdNvvxBB5p+u9dFBE5EHHBa
	1GvzeC
X-Google-Smtp-Source: AGHT+IELRqgcw/IW+zjDRYns6NqUSqFVZJxSSkN5p809al0q/XTyw0llD+RBmt4pBeBgE9jNvUrD/w==
X-Received: by 2002:a17:902:cece:b0:271:9b0e:54c7 with SMTP id d9443c01a7336-295f93ad584mr40393785ad.11.1762248441090;
        Tue, 04 Nov 2025 01:27:21 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998336sm19459955ad.31.2025.11.04.01.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 01:27:20 -0800 (PST)
Date: Tue, 4 Nov 2025 09:27:12 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] netlink: specs: update rt-rule src/dst
 attribute types to support IPv4 addresses
Message-ID: <aQnG8IYsY3oyYekf@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
 <20251029082245.128675-3-liuhangbin@gmail.com>
 <20251029163742.3d96c18d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029163742.3d96c18d@kernel.org>

On Wed, Oct 29, 2025 at 04:37:42PM -0700, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 08:22:44 +0000 Hangbin Liu wrote:
> >        -
> >          name: dst
> > -        type: u32
> > +        type: binary
> > +        display-hint: ipv4
> >        -
> >          name: src
> > -        type: u32
> > +        type: binary
> > +        display-hint: ipv4
> 
> This will be annoying For C / C++, and you didn't set the max len 
> so I think we'll also have to malloc each time. Do we not support
> display-hint for scalars?

Hi Jakub,

I just realize that most of the address/src/dst in rt-addr/route are
dual stack. The same with FRA_DST. We can't simply change binary to u32.
So can we keep this u32 -> binary change?

Thanks
Hangbin

