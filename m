Return-Path: <linux-kselftest+bounces-39187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F752B297A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 06:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57743B647A
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 04:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80C724676A;
	Mon, 18 Aug 2025 04:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeElftOw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D05D2066DE;
	Mon, 18 Aug 2025 04:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490038; cv=none; b=LFFMZcJvv9/DlfD+nxNNIcIld1TqyNMoyp84Ls8D9R989UtOxGCiUlkj/yW0cjoi1MIw6jDeD3ZBDUrTUa4BHIzUfeReu/hgusRvYWDTZ81ydIevpFj81lyd/orQDhkGSJAAjlOa4JW2boAlADMxf4twwifTdCPk4mEjE/0nIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490038; c=relaxed/simple;
	bh=LOjGr0k6lPWAispc913v37U+CI3AYwRBBOjnvBxj2bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0IdwGEulvrGhUwkQZQgTw6tseicIZsAtASuIB9/6Fi2iQNDJhZGitFEULxOBOjQK8ZGQOixCuc1wDMDOpUkPUb37/NNJOlfxuXe8DRg5C3F9KtO5P8+YlyJGN8stY4TkAMBXlpj5DntwSL6T7jZkUpppbR5PVePZ6hvvoczEJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeElftOw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4716f46a2eso2586498a12.0;
        Sun, 17 Aug 2025 21:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755490035; x=1756094835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ucfQ81oUXPxEN6AJzwDksw5cG3XZNnlJdQFbAGkVa/4=;
        b=DeElftOwvBZFqfM9+Ef1U6MwKOnzi3Xwf4CJVUuras8XcTDwn1nEp6WSCwOO035irK
         efYQDElHXWJ7fPeMFf7/fpBCYZkjlwrLcR5IgA54p+rUxYZfuKXL9fPR/YLwnYmxh8rw
         fmnHIIKEONbfD10HxJLhZOu566nip9/o+MImq/iI5Ca5turN86w07VwzguQGM2oYj0UP
         KzNViY9umDO0+auCDVvhu8cwo2isFgneUsTLjXMr9/QJPHebXbkeSIWxYHIq/JlSt1JB
         RIvOAl1XZ5lmPW+AyrC5yZsTvqN96Y5Ok22XfnLfkVGdkZXo696bvM1LY7MnHVGeBFux
         g+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490035; x=1756094835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucfQ81oUXPxEN6AJzwDksw5cG3XZNnlJdQFbAGkVa/4=;
        b=hKIWOFnVzMbLbmIJZw8aAo0j2iXlOiwm8cz6/PqGlmXC9+WkO3N7bmV+ejp3kOp0xe
         PDAKd8JIir3xCp6LkCtpqHGwdosJve6hKhhvh0RUT5G0FYAi1IZZwb2HUDwHfe48WYND
         QUzE7t7yeXlthx/3KxVGYnOxzvt5WQB9/6jmmzK0l3lXW/zZYvk3gz7TjvIzHhzQeGXn
         GCXCCMCymrXTGS8ByJs6+Huleb1g6tNWWUN/I7WaIdbGBpehiuCz4qdIed98mSS3LP1Q
         dL8Q/I2DDCU2Kqwh3aQ0wIDVDh6cCX/b41XhrivxqFNCzCykZ2SOuprt7MrP1gwyfVS9
         /Udw==
X-Forwarded-Encrypted: i=1; AJvYcCW4KFFjkfdykxtnjjC9OXuPf2pRVmNehOKlMxBV9CHpiLlhVi/cKzAOK9aTv6fBrVM+xqEMYOsGxj5mnhAb9h8S@vger.kernel.org, AJvYcCWZkxRhxf9kopsunLfz17f+HSVcJBDUxdn3jGXhflceDa2RqxX6RoBYvDLFlx2AibgbLfS4UpxZmXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9OxYuuNV+epfHvonqXpPq8n5mGe1AsI+3hPpXiCTzk1T8XysU
	jvuoNtTGpRQ8o7MxZZMCZJhIBi1pTRJBJ/dLIfjmcfMdiiPeaWlz0nDc
X-Gm-Gg: ASbGncsN2ziUiZiKBj827HPXPsDTxlltOFwCXHRUM18crUsAXVUmxWqK+icvKEMzYQb
	j3Qo+4x4Pfan1a9cX4qyzAvTTErUVQNSh7r8uwsTz3ByRQ4NHwA8b9U9GTl7AuKRMTFTCo77NFv
	2NgKNJegdrdiil6PUCu5liaSOnEwz2xaDUrK1C3QCiTdaoADp9grOhYF/Th8V2kUjjcA3g+SicD
	ohmliCJ0CtoaMAlIlJvR8F9r1/wEbLSmLK/2s8amDwv0mxzn3iyCAny/LbLN34Xgi/Jj7uIQUCy
	cB8aQTZur5OnJYepnxfJOgy/TrrUbdbXr7vh4jK8FQVftEUT0AYBI6wrodFBaxfeEhEtCLgUrdr
	owCtEoUn69fa6FL9HVfZfW8vFX6Q=
X-Google-Smtp-Source: AGHT+IEKls5ZdCIHhgHQ3RswM5+V7giYpMPlNAwmSuqeK09rDBQ2PncT5vbWcyW970yU0rKxTWKt6w==
X-Received: by 2002:a17:903:3d06:b0:243:e324:a36d with SMTP id d9443c01a7336-2446d749c0bmr127503975ad.23.1755490035252;
        Sun, 17 Aug 2025 21:07:15 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330fc3684sm9864596a91.11.2025.08.17.21.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:07:14 -0700 (PDT)
Date: Mon, 18 Aug 2025 04:07:06 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCHv2 net-next 2/3] bonding: support aggregator selection
 based on port priority
Message-ID: <aKKm6mgrmmFzoVlU@fedora>
References: <20250814104256.18372-1-liuhangbin@gmail.com>
 <20250814104256.18372-3-liuhangbin@gmail.com>
 <1109153.1755380673@famine>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1109153.1755380673@famine>

On Sat, Aug 16, 2025 at 02:44:33PM -0700, Jay Vosburgh wrote:
> >diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
> >index 874d8a4681ec..151c964562db 100644
> >--- a/Documentation/networking/bonding.rst
> >+++ b/Documentation/networking/bonding.rst
> >@@ -250,7 +250,14 @@ ad_select
> > 		ports (slaves).  Reselection occurs as described under the
> > 		"bandwidth" setting, above.
> > 
> >-	The bandwidth and count selection policies permit failover of
> >+	prio or 3
> >+
> >+		The active aggregator is chosen by the highest total sum of
> >+		actor port priorities across its active ports. Note this
> >+		priority is ad_actor_port_prio, not per port prio, which is
> >+		used for primary reselect.
> >+
> >+	The bandwidth, count and prio selection policies permit failover of
> 
> 	Needing to have a caveat here makes me think we should instead
> change the nomenclature.  Perhaps "lacp_port_prio"?  The standard hasn't
> had "ad" in its name for 20-ish years, so I don't think we should use
> "ad" in user facing options, and common usage these days is to just call
> it "lacp."
> 
> 	Simiarly, I don't think we need "ad" in the option name, either;
> the standard just calls it "actor_port_priority", is there a good reason

Sure, no problem on my side. I will update the option name.

Regards
Hangbin

