Return-Path: <linux-kselftest+bounces-27799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C94DFA48944
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 20:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57C73AB331
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 19:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15D226F463;
	Thu, 27 Feb 2025 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHNC4JXL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656DD1E832D;
	Thu, 27 Feb 2025 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686020; cv=none; b=g8mRtNGLqV60N4MYW08BS3rlJ+7pLOxPds6X/tHNN51J2bq6w+310OR2qYyhT4Zk95YaU1/0uu5KPdMtOz+VTST22PkERusOlD93oXK2pxbeW5jIvPHrz+pbe/l1nzgpv8Xu12qmAaPZDpUVB3wjoyG1OKK6+9bmwcgUTQZChEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686020; c=relaxed/simple;
	bh=HIh3SJh9ze7Bx4OYk5eOB1XyiCWTpB1zmI+JgpGBW1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpEKVohQWGn2OmVbiWHpvdRV0Ihy3ym+EFlXXVc8L9wYHEq7oOIKqRWxSc6EQXPs9VWXmCToxUKJfNb9K0/RKy3zscj/YBjYkDJFxY0Y+piIpOzR9jJh9Y2E0mIqe9fc9rJQ/1O4uPO8fZS7KHRbud4MEuvBhDn/UsQKhHtI2kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHNC4JXL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2233622fdffso27529515ad.2;
        Thu, 27 Feb 2025 11:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740686019; x=1741290819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8p4zdATSo6YE56HLrMWWOx12sv8q8KTQRI7WFtnp7kc=;
        b=hHNC4JXLrHc5JPE4J5I+n724Z7sIhcSqmeJgc40GiCkpM9xJk/WtH2OXyceV8E27R0
         gjVPlMKdXT7MUAKneqMXHexNL90zqMCERGNB4/J6iARPK1BCx7M1EgU1PsjUPoeE64oi
         QiYHgUQ9mhOnbtTdmwod66wEzedGra2z1wDFKR2kyqoZFVthvPF/5nQXireD4gwlpOTG
         R5EGjztYJz9S8TkY4GxRI9xtNrWa6zbVtLxVkY0mUfjaiYrp3t8JBuks466wIZX82AQT
         X1EthL0ubIyda9K+4FHK8MJRn/Sw/c+338rIuF8rVt1Fd3rp2EctVD3Xgc1+uXx7vvtn
         lnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740686019; x=1741290819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8p4zdATSo6YE56HLrMWWOx12sv8q8KTQRI7WFtnp7kc=;
        b=l2Rnqb/AVYJm7/z8beXRmaLvt9XVUKheVC+t+4cwM3aHh0OcnNuvjKcOUmhhIyZZYn
         8HdaOTuWsQPgoyOAEmQIP9lgv4DLJhdmW7EL+b7Whk8rHdMReXgskw4Gq4yjPHw+DvBN
         8mO0caBVgh7uzo/yM0BetARVc+YiqjdEcAX0aznkeJHo7Gqib9RLv2RUnMUr1fVCP0mv
         0kHN5jHbcicHTqN30dK5qQNqlmCgSErj44ly1eFPYIJ7RjtYtKkMpvAN8OHmYjKSTasE
         uxFKyQ+wehIgLeGOt/6aPJZuD8ObTqSsEkGCn8D+KrNkjTDuVQQmARp35S4A4CgxK8jL
         Ugnw==
X-Forwarded-Encrypted: i=1; AJvYcCUBM2WBGKca6NGl2/IAUjScqAVGpEuU7zfPRxem0tIZ6CMv6Yr6ik23CCQmtjcTHT/wN9qbeV64XsdyPBPTvZhZ@vger.kernel.org, AJvYcCVBhOS8N0dVutfJZTNQ73+pC3LC2c3K/01YLzown1M1zRzvEt2142BNHdeaJhDGRPo4k6Gn2tdhavy3FtZ8@vger.kernel.org, AJvYcCWiFkABi55Yf1ODKIxG5Cdu11zBFn32QmhqKrtc43y3Uh9Xg60RV71KT3VP7pOmIlWmzx8=@vger.kernel.org, AJvYcCX7t8JBGPhjc/QgkdbYi1iGD8xbJPcCcWAxY+LJ3O5Enh+/OTV0FvXpzE0QmEOYA6kexVecifq0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9IdeLhaV1bEd5THfd8GuLKHghXfpyaxbItQc5PSLiZPtPeOTH
	8ENhH7wsQ87Rkqj/uL8iqK782L4PJ8pZzjt4BwX4TVUiO7rL01Ln
X-Gm-Gg: ASbGncvQwn8Fzj7iB0D30wl1eqRLv480G0pniVVTPMa9IUTY+UuR2/u9JkWzV5IOQxg
	EtlrKHGSfpEif/3c/lCF9E1/DQFQzJRxn2XBbVeTK5lDpwZ7OpjvaPZGgk1jNokv5oH+0IMIW7M
	Dclixc3Ct9vuwBchjIjn+6xIH7J2hsPkS7cKiBrewjjupBOl6gcL7fRcchCjqlgMwVggcwwqjRt
	sIsniphlWARk6sZg8gGBxeCKUaOLDkCT29xkfwSF0z88B57JS5pHhnqFQ/Wl6dF3cQZPk82FdWY
	UnaWcrTgmCxujRsccTN66SPDzQqk5A==
X-Google-Smtp-Source: AGHT+IFoTSorehwp0vDxBGlMEsfxHl5RgKv1Cx/76s4b4eLSazPFfGflRJxd3UKy7vFWVcHqS6juLA==
X-Received: by 2002:a05:6a00:b56:b0:732:2793:6b65 with SMTP id d2e1a72fcca58-734ac3f31d1mr965589b3a.15.1740686018630;
        Thu, 27 Feb 2025 11:53:38 -0800 (PST)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0024df7sm2132126b3a.109.2025.02.27.11.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 11:53:37 -0800 (PST)
Date: Thu, 27 Feb 2025 11:53:36 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: cong.wang@bytedance.com, john.fastabend@gmail.com, jakub@cloudflare.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, andrii@kernel.org,
	eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, mhal@rbox.co,
	sgarzare@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	mrpre@163.com
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: Add edge case tests for
 sockmap
Message-ID: <Z8DCwLpLQ2pYte14@pop-os.localdomain>
References: <20250226132242.52663-1-jiayuan.chen@linux.dev>
 <20250226132242.52663-4-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226132242.52663-4-jiayuan.chen@linux.dev>

On Wed, Feb 26, 2025 at 09:22:42PM +0800, Jiayuan Chen wrote:
> Add edge case tests for sockmap.
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>

I always love to see fixes with test cases.

Thanks!

