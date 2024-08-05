Return-Path: <linux-kselftest+bounces-14799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FA59483C5
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 22:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89FE81F21C06
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Aug 2024 20:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0343816BE26;
	Mon,  5 Aug 2024 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3PK2FVQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D014AD30;
	Mon,  5 Aug 2024 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722891506; cv=none; b=FPgwsqW60NXEeWGyPj44qlwcrSjy6cmgdWaqSUC3tBWJ50CRqlSl8uBdAxOhagaO9corzCRuYEtgI1D8zn/b5U0CeugKhP0rrzpmGGLLU3QtzHn0bCr6UxHlp/Er3EfQfgjzq73Jd2yswl6FOupoAvk2efcrNVPO1NMCRuXp5t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722891506; c=relaxed/simple;
	bh=bOpswM3jL2JL6Tb3adEvtARdBGij6hauib29LexUvN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F465bu2wxvatZgy0i/wiLPvh5mFOLmW/8diTiqJ4Gc+BaWwcA+tAlC2rzNj8xdDY5cLDet+ZjFwnfk8nw94oZUmm26iqYn4L/v+fjeegfAj/ywNtZJ1/dKYZL3zapGeAWY8fYS11bI3MsMlDNCnv6Z+pOZASk1QbqNeP1cWHGTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3PK2FVQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd6ed7688cso1026775ad.3;
        Mon, 05 Aug 2024 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722891505; x=1723496305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/aHUA7NaygOYxjLndyaWBEQcFONjtMdvXj+fBkS/0A=;
        b=a3PK2FVQx56lZJb77sOw4vmRCCIrPRkS03IUURFNrL+rc2DJ7JDFPzt4RVeqqxYUG0
         1buZuYRqK9hIVgeAvWxJK1Jz5EsnIgSdoCphH1ayT2M4M6Bo1S8C0aa6VStHdegHOcIx
         H2v2/H5NzTu9nLyvGTVI7U7M+jrpU5qpaLLXVxsZVYE87vmmCRcfbrsbuU+qxbsUyEjl
         iczO/Vh1nvklhLGarTJqowK5idwRR3HB0nkpNISelo+9kTJc6ZQPbHePvjcOLtClSbtG
         CQbnrjCPKmZNccqoKbmzMJ47Pi9x7Zn442crVRL1BawEU/dBWoijhXyNveNJyQznIdr8
         OZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722891505; x=1723496305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/aHUA7NaygOYxjLndyaWBEQcFONjtMdvXj+fBkS/0A=;
        b=oyT3ZmnJwNGrIBurK9Ru5eX3MjX+nIaA5B7VFxKTO4RnYzciRANvpdvyHSkVAoiBhi
         Ri5DhHUh3CuRVkIz+7d5Ek980YJ5XlwX3FQ/BLUCncdHMNXWN28YpJWQ6lYTVX2cR5Zf
         gtFF7qgTrKES05zvDuC7zX9hbiegHTLuRZobiz/cJ7/CdLuBnjFcVeo0XeTr5A4PBJIS
         OVly0zuCRu1MuQcsgVGJgk5b++j5DO77lCNufvxINW2IQcJkxv5KdaAixtx5BvpvVj0c
         elM1Qdyc1gFpFC2j94d+EGkP6yG1Ev3kvM64rNfqvze670R6lCVrRNJTMNzrLa3p79MV
         RU+w==
X-Forwarded-Encrypted: i=1; AJvYcCUFOfm7nlN4aVj+BYC3axe4Rr6kePgdf4h3ewyEnLAkLgoHZZH28t5c5rhY8B+pYHMUhWvBmdrWeUMlstqVt5RFZFdVp5U33QTyERSQxtlv29KOkxjcjBM7kYpRG2VvwKbulwXYiz460HwMEdaFIkrNUv5O66WwKgNpxqYc9au5Sjd8d1kyXg==
X-Gm-Message-State: AOJu0YyQRbMu0qfuXkFBFFj+sVUTxnrJETjB1wFGeZwsvhaBvNBhQdMM
	m35lFx1f4NMYod45o+EQ0yz6jS+f3u+tpD0FpYOPL8G//hEm04aJ
X-Google-Smtp-Source: AGHT+IHUrxB8SJcgTptVefh4jkluWfFm8A+YLA74X/mbOtAqFw0/wopz+86nlxb8HD7GI495Muecvg==
X-Received: by 2002:a17:903:228b:b0:1fc:71fb:10d6 with SMTP id d9443c01a7336-1ff5723e5c6mr117747085ad.6.1722891504585;
        Mon, 05 Aug 2024 13:58:24 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592aadd5sm72408645ad.278.2024.08.05.13.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 13:58:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Aug 2024 10:58:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH-cgroup 5/5] selftest/cgroup: Add new test cases to
 test_cpuset_prs.sh
Message-ID: <ZrE87nrqimsCxMzA@slm.duckdns.org>
References: <20240805013019.724300-1-longman@redhat.com>
 <20240805013019.724300-6-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805013019.724300-6-longman@redhat.com>

On Sun, Aug 04, 2024 at 09:30:19PM -0400, Waiman Long wrote:
> Add new test cases to test_cpuset_prs.sh to cover corner cases reported
> in previous fix commits.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied 4-5 to cgroup/for-6.12 after pulling in cgroup/for-6.11-fixes.

Thanks.

-- 
tejun

