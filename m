Return-Path: <linux-kselftest+bounces-48128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC101CF0D11
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 11:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12AB3300DA47
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 10:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641E527FD51;
	Sun,  4 Jan 2026 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSaH8jDt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37024241690
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Jan 2026 10:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767524116; cv=none; b=qpqMPWhvvwygtW5MzgtwpNxF7RnkkR9RFd0rC+5qFQWls+XC9lhhYgMjZaYDI2uDXDWzkwv0lZXr1trF+2Cannrs1LLCxHMKr/5dnEt8uO5OW/JmajJ90DxQAi495ohyZg4yZ3juuq+YRCYKwR3HdIwDtr8lJR8krwnSRAbXpHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767524116; c=relaxed/simple;
	bh=N2NFBJBc+fcjC7P3jRiEoizwCrgAlI+5FVrpTi06HnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqzcBBrSVnEFr/uu7gH/d0HJ4vNffNDy9COIbPb/hjR7w/Z21CgW2GhZHc/v0j2CCSa21u8hWoyp6tIF3gOL+kVm/DdnZ1MwlV0uiSoQP8+4G2MDy6x8xf22RGUUrcKtUHGFOrxdBxw+YInHnWci3KjgIqrEhqWtguKzfLMR/ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSaH8jDt; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4eddfb8c7f5so128629541cf.1
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Jan 2026 02:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767524113; x=1768128913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KbfO1i69mPL+mrubhr+uxnSp4Z/WqGGTqSL3K9pfVA=;
        b=WSaH8jDtyFssphex8IjFN8RUIj3BM7mNc8Z5CzL65SSPLjaK9CanVbnzfNEWflWXRk
         TVW1NcNvAbYluqkysN71FCtjFaqcNq1i2JBZ8apreTnr4r+LBJKhnRv5TNC3WMphy2XM
         9GbwTFi03WEe/mFzbUI5+ntAc07GImvlyPOxpz5mEN7qb/D+fsJuCIuO2eiM+PlumW4Q
         JhKXnQ8tt9KTV8INbYXkWxbmDGcKyZ3UJtv3lVZaewYzSa4w+7Qxkglrl6Um0aeW0wBh
         i39hlqEnwOYQFobnRkjBeAL2v+Qwq+11nCxDHcLskJf4/7gKK1qQ9qM4U8PYMLcYO6YW
         YrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767524113; x=1768128913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KbfO1i69mPL+mrubhr+uxnSp4Z/WqGGTqSL3K9pfVA=;
        b=HsMsDT141yu6kVqjpqMYnopMgwNbPfXhI+BQvNrOJTkbYM1gzJaaOfGVrMMbO6isny
         F7RlhR/kp9HCZ5whcUPqHeuQ3qmBAUFfKa5TA7kVclaD/OHE7fMBOohmPn+7GHeWvp/J
         8OhR3rnU+KE19FgIcHHEp+LA6sC+qTa9RL9m5794V7w4P5ymNqEWaOqB898v03PcvrGX
         IKgeUNMV/Iz4EtzWZGHH3ila8Z0zsL9lDgHz6CnIQdxLcBmYWH1GBqqeQyQh8zVS5kso
         XJ/xrGdLXacoEwLlq+OPI/TI3+/bjXPrMdtNiGm7mnZPzatVWMHRc+1yDbypUsNmGL1C
         P7hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvsWIB4iO+0+R4tEocZ9svsMWlfaWbhpaJ1oz74/A8/4Ux4CWvE8C90o7d5rG1kkh64QGH223v/etvW0vONLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhDqpO1ckvp8Md6iSd+ftKR5FVUuEFk6okgn9lM65Dq1U4/1In
	pE8p08OxLKGXXHho4nZYNzdYwACbV0zbd5Bw4RK7UT7hFvIU9pXeTgXp
X-Gm-Gg: AY/fxX737aqVARgIaiGNfOIC5s/pd7Vd8uuFqtS6AfLBYLQZTGaJwA49PMWmYFOJ3Jm
	1XqTEbBOBo9/P8KmcApuZy/i6iXWMPJYlK0/N9Nm10kzqgZT4Qt5f8GAzYpXxuLsLNYCc6yYGXS
	vdfSXn32oGpPcK8PnAAto734HsEIxlXRKPemTNeAbXkLmdwQ0t0e9EXniNi3gHXIIX5QOFJWOXA
	dgq4tipvPcuF5i4pTLohR7am/WBhhay4LslhO+WPXzJfUSZWKqkIQwQTXobQOBCGexNbqyWUk6k
	q8iZAUEzJAM3jqpNCPY4XDnXdyTdpBR4o9rKkBQYOQyOWIoZJg7qPJDlnDts4+VWWpZLwawkp1q
	zlQFBRnRObZq84oY0djIs/GuA+wltyQLyTAdrcH+l+HRKmPVcsf995KpM6aEG/xVDZBMa8sVcyz
	Fl3pxb9yAbwo4m3T6eGG4h+5KWMnJhaImawSW02tUBesC6ES4HpztXV32LIA1om7tGsbFin99ls
	10/c4g7JY2aYAA=
X-Google-Smtp-Source: AGHT+IE+qwfHcvZu7g88+7aXL9FHzacq6d3LEZhX6euRl5AyR5Pc+4qPOQQsxUfq1v6m7ClnOJ6rtA==
X-Received: by 2002:ac8:6f11:0:b0:4f1:aba0:9329 with SMTP id d75a77b69052e-4f4abd15f01mr790228741cf.33.1767524113133;
        Sun, 04 Jan 2026 02:55:13 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac563f66sm320455761cf.15.2026.01.04.02.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 02:55:12 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id EAF20F40068;
	Sun,  4 Jan 2026 05:55:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sun, 04 Jan 2026 05:55:11 -0500
X-ME-Sender: <xms:D0daaZIERhJn8aaRjBZo5bo1jhie88tt-eaVp3V30TUvnVzBVsSWSQ>
    <xme:D0daaUlC6p1FjltqbYLOoZ1bhNJXQvHt5oU1QU6gmryamk3byUzS-JsBo24KgpkXI
    942nNYgB5PqVXIpW_6ayYCeEwzAGJC55HlnK2PBSIbA7ymTTDfCgg>
X-ME-Received: <xmr:D0daaSzUwrHxYhLG6pjx32HKs4moT8sQujJyilhCpEINflN0il_x4uU8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelgedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    udehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohgvlhgrghhnvghlfhesnh
    hvihguihgrrdgtohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhu
    phgrughhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhoshhhsehjohhshh
    htrhhiphhlvghtthdrohhrghdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtgho
    mhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtoh
    epmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhm
X-ME-Proxy: <xmx:D0daaetRzq7P0MTTgEgo4pY9Jb00LEjevEin4sK22TaQCdzlw9i_Ew>
    <xmx:D0daaUFz-XqgDF1gtdVgCaEm4GMaavgVzPzIB68S98n-hA2BqC_dNg>
    <xmx:D0daaU5IQG4D_BIwQ-AS6fAxxmFpR3CKG8qA-FFgHoFUhgrPY5x8XQ>
    <xmx:D0daadzn5xiHLKo5aozws4kIlEdyPFdOwnUU2s9Th9mOhiQll4cYpw>
    <xmx:D0daaS3AkC-7G6i1pZ4FylF_eeHBH3gkwoN-3vShFve9TB_6IYQ6pl7q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jan 2026 05:55:11 -0500 (EST)
Date: Sun, 4 Jan 2026 18:55:09 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next 0/8] RCU updates from me for next merge window
Message-ID: <aVpHDWWiL1huoSBT@tardis-2.local>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260101163417.1065705-1-joelagnelf@nvidia.com>

On Thu, Jan 01, 2026 at 11:34:09AM -0500, Joel Fernandes wrote:
> This series contains RCU fixes and improvements intended for the next
> merge window. The nocb patches have had one round of review but still
> need review tags.
> 

Queued for more tests and reviews, thanks!

Regards,
Boqun

> - Updated commit messages for clarity based on review feedback
> 
> - Testing:
>  All rcutorture scenarios tested successfully for 2 hours on:
>   144-core ARM64 NVIDIA Grace (aarch64)
>   128-core AMD EPYC (x86_64)
> 
> Link to tag:
> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/tag/?h=rcu-next-v1-20260101
> 
[...]

