Return-Path: <linux-kselftest+bounces-30727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E2EA884CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 16:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7441902046
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 14:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A422957B7;
	Mon, 14 Apr 2025 13:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GDIRMpZv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365C2957A2
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638945; cv=none; b=ripltnpKkTEflUQ1Z+IqRza/pu3B2a3mBvKeIZgr91IVM5kOyD6MlhrFNVMcrNe7yyuLC1XDSrmSejkmKSpL9RUOnpHFktf8XEBReQuO+qgKe3ZX2Mzdt4lCUMhlZza0aoqPu7KQYUx0/CQGJFtM8TMs/v22I5/qsEX1LVETXuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638945; c=relaxed/simple;
	bh=Bp2rSa7YgUjksfq92C6U0dpNu6ZFkat6qi1m4BsAbjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvt0cyrKVuQ+tOZHUEyAQJ59BclA9Of7Q2TRgNo2wquawCdORDn9axQqta6N2QvGePQI2dCPkymzszESmOIdW4sRqkgH7H+O+Z0xERbrDV4yoGGi4Ujy2ec09BhOTz0fohfcHzP9EZHGmdB2PvYzGyo5OLl2I+YtjwLijiax4Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GDIRMpZv; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso2596619f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744638941; x=1745243741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bp2rSa7YgUjksfq92C6U0dpNu6ZFkat6qi1m4BsAbjA=;
        b=GDIRMpZvl+/8VO44OTGbpWiu5+9aCofVCpYp1w18TrO4wRmTD5ZQsoD/iBsCUghKzk
         7k71qk4s8cGduamOve6y4LH5RQRhtKF4WzcYsDelh9VRjxHqo/eUSFIHhMC8w81A+LAf
         AkvktK/LZXQr58cEmMdODb4WiCsxS8ULVO+dYDlCBXJii0lTuKx+bL9+XGXTuVMUvtg7
         0UNyryap99iKXj5f4Dunmuo1C8fGxsS3EFdlRiDzAGlWi5cNaSeCrYMeFl4sqcKqu608
         wRjyMR0d2kdneAYYEHG8d42cSM4VlrcoGM9DF8JpNtuH2Kuug3oEXcoRzcWSo8z63gzC
         nLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744638941; x=1745243741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bp2rSa7YgUjksfq92C6U0dpNu6ZFkat6qi1m4BsAbjA=;
        b=esXf6wjMIqKFTIN4YC5m3/lZAABvm1AgwelmaL2Cf3Tj5oAGtluybGsKtYJ2KUNP71
         rOi9r9EhIre31oh+76kLymp9HsLmnzdM+DWDGj01Xbk1Nl1ihAe6O0E71NEfr3HdNRXB
         WnHKUUpJp2QmqakXhjtZxTZD8B0RPih1Q1+lB7m/WZq6OyiOdzqzc2QCfffynn9SsfFy
         05GJd49sr6lm+LT56s1WSlfIEaK5V757DokkYFEyZhtNi2EwzW4PF1phKbvsv/fxP/SE
         BhNw+H7sQMP0/V55X/yNXICLFTPnzSBk4zgI95YLYTfAcEPSbji5JJQDkIh0qtoFIj0/
         4zNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOo6rRyAMsGzW26QNlbkkMd7ouLzeZMnrjDb/ayYSddnlmVG/MlgHyVNXtl0AkB28UIMWMISdUXERW32w5acI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2bNyOHi2ufDmy+YLd7TLWABx2gV31lSAsM1jOVM8sNXiVI16o
	e/BDPccepDscYWYzEUrrHM0d9M6rpahRV7IUtHbN7KHcrPqIMacHvfEajBuwHrE=
X-Gm-Gg: ASbGnctCuIJiVUeZQOSe6yW1Z+xdONgLEZo/AE+1XhRohl/fCCqVzs0ee48n185EASK
	Mu2aeqwE9dhxw7i1VtJFEBMgMvFPLGKYLDnpPeaBA/ieqf/uTrA+xP1NPS824UMdav0d/WUWhE6
	rYMFQRgHOClAst5TQNbYmaiCxFBEOuQrPvlr97ghhQvn2t6ZGb2FUXgWDcFSM0vqU8NggtNqZBg
	P2rS3bLeaHYq4zCJ7jMXV86ylSCXuJSaX3bJpSmOdeZXzPY0yx1fKyfDB9Kpgpmpv1G1uZyvW9n
	GMdzSXhZu3lSeObsFvSu23KzUxme1UlcunZLX2ACAl4=
X-Google-Smtp-Source: AGHT+IH7XfnEongCTvrfF5mvPiNUytCuC/Zcaba7Gv1vTVVOnakln7HNMXeyFjeGknI7uqcmE+o1wA==
X-Received: by 2002:a05:6000:4205:b0:39b:ede7:8906 with SMTP id ffacd0b85a97d-39ea5200a2dmr8697154f8f.19.1744638941281;
        Mon, 14 Apr 2025 06:55:41 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf445772sm11160518f8f.91.2025.04.14.06.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 06:55:40 -0700 (PDT)
Date: Mon, 14 Apr 2025 15:55:39 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <llong@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
Message-ID: <uaxa3qttqmaqxsphwukrxdbfrx6px7t4iytjdksuroqiu6w7in@75o4bigysttw>
References: <20250414021249.3232315-1-longman@redhat.com>
 <20250414021249.3232315-2-longman@redhat.com>
 <kwvo4y6xjojvjf47pzv3uk545c2xewkl36ddpgwznctunoqvkx@lpqzxszmmkmj>
 <6572da04-d6d6-4f5e-9f17-b22d5a94b9fa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bldxszh4zmrjgwhd"
Content-Disposition: inline
In-Reply-To: <6572da04-d6d6-4f5e-9f17-b22d5a94b9fa@redhat.com>


--bldxszh4zmrjgwhd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v6 1/2] mm/vmscan: Skip memcg with !usage in
 shrink_node_memcgs()
MIME-Version: 1.0

On Mon, Apr 14, 2025 at 09:15:57AM -0400, Waiman Long <llong@redhat.com> wrote:
> I did see some low event in the no usage case because of the ">=" comparison
> used in mem_cgroup_below_min().

Do you refer to A/B/E or A/B/F from the test?
It's OK to see some events if there was non-zero usage initially.

Nevertheless, which situation this patch changes that is not handled by
mem_cgroup_below_min() already?

> Yes, low event count for E is 0 in the !memory_recursiveprot case, but C/D
> still have low events and setting no_low_events_index to -1 will fail the
> test and it is not the same as not checking low event counts at all.

I added yet another ignore_low_events_index variable (in my original
proposal) not to fail the test. But feel free to come up with another
implementation, I wanted to point out the "not specified" expectation
for E with memory_recursiveprot.

Michal

--bldxszh4zmrjgwhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ/0T2QAKCRAt3Wney77B
SbJPAP0dXFDJG2wSX/yIyDLlLnQPzAglEx7DlhFbKKZN1ujpywD/cWz5HMwZq6XA
v7d3QWoUA0RmWL0qHKFogwG/fe+bNQQ=
=9Pga
-----END PGP SIGNATURE-----

--bldxszh4zmrjgwhd--

