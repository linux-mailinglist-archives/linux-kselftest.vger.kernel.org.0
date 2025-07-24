Return-Path: <linux-kselftest+bounces-37909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDC6B1006B
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 08:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0D21C27BAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 06:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C7719EEC2;
	Thu, 24 Jul 2025 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArEv+4le"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191F1863E;
	Thu, 24 Jul 2025 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753337741; cv=none; b=CnR5NzZQFmqKx7pGHv4A3ckNbLYclJCLG/BS8s/4BVFlK+8RC/xDPj0euHNbM3MBYqL6q2xwSI19ONxrl/pH63j6cwHmD6RHlMvYVnpg0FsF7vTc4LaxYv4JNxVyICAq3N/lYijyTdmq/wkqShi9ihFIABR9LNTbB93cebRePYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753337741; c=relaxed/simple;
	bh=NTW+Rgkxx6wfBOpLL+89g4QkZGnznyXnNU309V9VZmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAALg2tKg8mL2khowIgOusJRJvA32sAkCX2TQ22aJINhlxNtHHHtX+3i23diNEEwRrmca5CC0mE6pSWG/s/zTzAsOU9+sfVJCPifpXr1ZLmunF/j+VLmMOmKGR4YQOO9xl0PZ/V0bRTtZNxUkHsCgN6jyO+jzRixPxrmoyFFJXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArEv+4le; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23c8f179e1bso6532465ad.1;
        Wed, 23 Jul 2025 23:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753337739; x=1753942539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V59asKqFpce7gBskLYl882QJNmx1VE/lKK51NriEFh0=;
        b=ArEv+4leEDbELfX13mEioQchoujptsvbs9iErdyhbQBCgwV/WQpHZ6Hr5qIkY73GDL
         dl6RHmBdHc4rF/fFY0ef0rbaQla2Da9BaFrTgpyhZhVTXGbzg9xO753/iq9uVM7dCXAp
         hqSARWEa4NntkIdZcntaPHlfslmzzWnc/4T7ChVh+aU25fpurIGZkxzyxjzN7BYdeXph
         WU8QsJRynQSRBC9Al4ataICESiE5Tm9OZqZXo2aKH8dP7E0ihUiZJKBgDRt2dvow0cVt
         W6WZBhvKcqhMg4GLRx0ICUwQAqy25ANOhYCJi19qMJKQ5CCMB0RgDocuwL5ZUPi9CLVS
         VYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753337739; x=1753942539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V59asKqFpce7gBskLYl882QJNmx1VE/lKK51NriEFh0=;
        b=LUostw0fEV6BNv9s38kiLch4s1fCqJzhuJ5OntF51Lc1FGrljyVjafvBSpPtUVZgOs
         J7Gc+4mmBvMDYVNfkFc/v5xBN85Tnb1ibAtk9PsOARsMvBemC9Bb0gQHkOdHAG86ZWPk
         j1Vx6itPu7hlkUSpQqzBeNLgZwVUXXzWU8g7+axXXAcLqFYfHRjoEj4UjeXo3UcIaMcB
         aBKn48hUeGPVDAEHYWtJc7LWywbucrVFzuyeI5j4T3VoeBMx3WkWd2kMOjsy8ntVb/5s
         tkhWWg3HOJ1VFykzhhHNxZdprBxdMTnkr9avbGhzyFpALFP0eT8j9bSCwJkidcRFXGmM
         ke6w==
X-Forwarded-Encrypted: i=1; AJvYcCVKR5VSKQw5Pnfcs8fBNetnRJKxzuamhh6H3Owu6bLgb2RjQBiMaKQxKsl0+y/eHI6TIL+j+hm4w9CP7bVh65nq@vger.kernel.org, AJvYcCX7s7sZnanE/2QQec2y0bJSecb0CPCqI2w890gzHGO1tNzk5EWYTdIktq5NJ4JNmh//8TpI1sah0r/GPiuaThoO@vger.kernel.org, AJvYcCXBX4j2STCLc1LCSrnYJmaJN273bQhRp++6MPzlzhUWm68OMfXzHbcA4Y3pK+No2RuCGKc0rY22gSrrLDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrc61xu96xrvxAVqcZWOHKx+zKN8DPetBYrNo/CjadMZ2ULuLv
	MI3k+fVd5Oef/KChhI8oGVjiNjt+R+3LMXZteBRwqzGuax4zHDKEAGmp
X-Gm-Gg: ASbGncs7Qb0BfPBwU/zCeta9E4DShDOVU4+f2s0k0jLxcCMwIOJdr09YeLCEJ+8IlwI
	MtUS0/J/KQ3rzh1W2U0AfkJdo4jvU59t4Pc3qSaDcGd1uYdnTSHNcfUl/ywyjwVAoftb/PgiTyA
	GwWmRR2zghXda1B8Or+Q6OBnEaWkDfl5XgvWQ1U6olnBAw4J480pOc5DnUJWL4n2lXYtwIYUzP3
	yN+DRx9IG+YWnwTPyO9o+uPYeDRuCHrfEcDG1b/az5ZKAGJF518ZKNAOmeTtFNVuDYyWASK3m74
	xRZkK744cURSzfRtZ5y5cRa6sgbgJeLD0z6B3EHwFYbHtPR3kKY0glE3VsWm744qA25drpH80k+
	ie67/wOJh6zxZc7fcdwQyHnTv0Qs=
X-Google-Smtp-Source: AGHT+IEL3uRCh7ghRklP4SkRDgUxiCWuc+kUhergl0tzV70xbLwF4W/W5h5ye9VIUfcFjTZmoHrgxw==
X-Received: by 2002:a17:902:e54e:b0:235:ea29:28e9 with SMTP id d9443c01a7336-23f981b0a15mr93791575ad.38.1753337739253;
        Wed, 23 Jul 2025 23:15:39 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f82esm7185855ad.15.2025.07.23.23.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 23:15:38 -0700 (PDT)
Date: Thu, 24 Jul 2025 06:15:30 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Yi Chen <yiche@redhat.com>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shuah@kernel.org, horms@kernel.org, coreteam@netfilter.org,
	fw@strlen.de
Subject: Re: [PATCH] selftests: netfilter: ipvs.sh: Explicity disable
 rp_filter on interface tunl0
Message-ID: <aIHPggRqH461rzSL@fedora>
References: <20250724024339.11799-1-yiche@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724024339.11799-1-yiche@redhat.com>

Hi Chen Yi,

For the subject, please specify the target repo. e.g.
[PATCH net] or [PATCH netfilter]

On Thu, Jul 24, 2025 at 10:43:39AM +0800, Yi Chen wrote:
> Although setup_ns() set net.ipv4.conf.default.rp_filter=0,
> loading certain module such as ipip will automatically create a tunl0 interface
> in all netns including new created ones, this in script is before than
> default.rp_filter=0 applied, as a result tunl0.rp_filter remains set to 1
> which causes the test report FAIL when ipip module is preloaded.
> 
> Before fix:
> Testing DR mode...
> Testing NAT mode...
> Testing Tunnel mode...
> ipvs.sh: FAIL
> 
> After fix:
> Testing DR mode...
> Testing NAT mode...
> Testing Tunnel mode...
> ipvs.sh: PASS
> 
> Fixes: ("7c8b89ec5 selftests: netfilter: remove rp_filter configuration")

Should be

Fixes: 7c8b89ec506e ("selftests: netfilter: remove rp_filter configuration")

Thanks
Hangbin

