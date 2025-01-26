Return-Path: <linux-kselftest+bounces-25197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E196A1C856
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 15:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34ED1886C3F
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 14:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9B114B95A;
	Sun, 26 Jan 2025 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="G6SkSJPM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4AC13C3F2
	for <linux-kselftest@vger.kernel.org>; Sun, 26 Jan 2025 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900914; cv=none; b=WylDhfpUQaNAphlmBUFURfT2MQtwPEurq3riQyYCmYkERuYi/Fbc8lPa1wOhQxz9mNp7E5Bk+BE2f4qH2TwkYPGL50wPBI+lD10askEsCnUUdvh1VK+q+MhsQkm3dKHeCwdpshHUsF4/EQO0U81axpQDQYn6jR0tYm52Glw3aRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900914; c=relaxed/simple;
	bh=peHLr2meKF1TvUq/MZxe+1FIKfK53RpQEdIuer2wMfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pZMdJVofZQbeBkl7mFuciElZMbFvcaaal9On4aUPZWu5jM3xtBDN/+2wMW2RPJo6OsD0BaN/4mtpN7GJ/r8Cucd16hk5WUGOunbMWJpa4adZG0BI34VRChdvxcfqLC3sKEO4E/i79FGPm0GQeJ5i577bsqRX8TQYiftI4BbZ2B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=G6SkSJPM; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d982de9547so6865589a12.2
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Jan 2025 06:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737900911; x=1738505711; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=peHLr2meKF1TvUq/MZxe+1FIKfK53RpQEdIuer2wMfI=;
        b=G6SkSJPM3dLFlFbSNdfUSmAxcvEE1CXMA1Ejv5vXdvyJ6uuN33bKOAPFs/3NgbXn/w
         cQx6IGOxnsdgEJ0lE0xllJN7+TKBA7gVxNOyi6EaI6DXGbtnuyv8OmdMKvT5zfkulg96
         UyPg2BHKZxQMO6UTnHD0h9yJHkJRysHtB/pyGkeHuvHFr63NjAiwUHPFTIEI+Nvw0e15
         OWY37BLu6H50/Xm4IBNFwIdXhSKR73ttlyOXfrFuBm76o6hpU2J738JGtL5N1X7MyG8S
         KwrEvcb5FxT9fvLL1DumG97wI0A6wO39zZNcJVUdJHyJp6IKqMxEy9GwSmMiCcEblrHE
         Z4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737900911; x=1738505711;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=peHLr2meKF1TvUq/MZxe+1FIKfK53RpQEdIuer2wMfI=;
        b=HV4pSJ0IBvrubf/dzq9Jb4KQB8KKMd6mjUAWVSTzY39Ju1XNf5VOqg1a0RJLdp6wYS
         5BaT0Is4RCRKrdX58KXdH7Qdmpk0i1kHh/52L6J6NnBnYhz44Ruod9Rhb09faARozQ77
         m67SGUgjMRDTxA+XESRa4sc+6bJKsPusatC4LjUMgrAESPyOFM/Bw8eEadM+SjqMaz4R
         RVTc3F4Ck9agyyeilF+kfn4w3GV2vJQSavObNYUI3Ji6uP5DnwzP89miLvt0K2L36gcu
         7SVxOwuje4xNbZrXy++L5GS6szvZg5LvEe3BXIATGgRAJJLY7ehiTS2c/Pu+Z2X4o9OP
         YOFg==
X-Forwarded-Encrypted: i=1; AJvYcCX/PEPRpsVoGPTwN3wzyIa/rxClqK0esgxfYr+I6q4C/TUfLdoxLOG6k8KewXzOFgbLW4PREQMT2K/viFAKu+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+h9y7L/zG37kD54ejPN0APtWxpBo1+Bw5AiB9HUFYui9fo3CX
	PPptpw0JXK78MRTrscmCBzbadReYmFdo4gr1OfTlSj4r0QX0AKJi+gf9XqkDJlM=
X-Gm-Gg: ASbGnctrhErYt9j8Xsx+YGCZ9+Hua3G6a3u/XBevlvTwCtbhma31qb3sEWZx2vEVMvS
	s9vHgC/x5x4BWckFxYp5nTUeOnR6R1C6xC9tqAjEzeunDccESaI51IUCW1euJI1rnbDH+5WMUbG
	VvtGKYe5cWjc0p2K8iAArk05By5iyrW+wPm1wC1dmcZBpnXeb3UAZYjuHpx+3EJ+l7gPB6hp1sF
	8A6Xnta+q/cP4EBvsBHUiUYT2r1C1AzDRJGsx22QojP2xqSf4XTfrNrGFEhriAZCZ8xz6AEIQ==
X-Google-Smtp-Source: AGHT+IHS+j/maW0HT7SPUukqXe3x6mcjCFkojnW+QLc+olCNf5e5LR+PCAIyPwV03Bd6SZmxxKy1SQ==
X-Received: by 2002:a05:6402:274c:b0:5d9:a85:1a59 with SMTP id 4fb4d7f45d1cf-5db7db2a0f0mr35080417a12.27.1737900911439;
        Sun, 26 Jan 2025 06:15:11 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc186191f6sm4028191a12.13.2025.01.26.06.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 06:15:09 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v9 5/5] selftests/bpf: add strparser test for bpf
In-Reply-To: <20250122100917.49845-6-mrpre@163.com> (Jiayuan Chen's message of
	"Wed, 22 Jan 2025 18:09:17 +0800")
References: <20250122100917.49845-1-mrpre@163.com>
	<20250122100917.49845-6-mrpre@163.com>
Date: Sun, 26 Jan 2025 15:15:06 +0100
Message-ID: <87bjvtd5lh.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 22, 2025 at 06:09 PM +08, Jiayuan Chen wrote:
> Add test cases for bpf + strparser and separated them from
> sockmap_basic, as strparser has more encapsulation and parsing
> capabilities compared to standard sockmap.
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>

