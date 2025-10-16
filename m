Return-Path: <linux-kselftest+bounces-43318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7C8BE2AF2
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 12:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60F91506D56
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 10:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48C3328628;
	Thu, 16 Oct 2025 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="W0MCR+wf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E3C328615
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609311; cv=none; b=a6kZmyY6/ipWUrgtk6iZuEuHJfqf0+U+FNGrqP+NhOdic+7unxIutOUCpPhc5qw1ea7IXqcHCiueMWaOgnbgxJW1gAWbaJkq1FYnNJ9maGW8hn1+fTcEBAVy1Bxc6vfL1yZjC1NnHyMbatpm6sk4usGpmIt/keCXImGrfUvBDco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609311; c=relaxed/simple;
	bh=iAG+Qsr3wjzsEn7xPqBjjdvU8mNrEK01RZVMASCmXJQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k+KqVJFq3yXR38YD+QNwsn03pXkYW2ewCl8826bGPnZRpGh47RUifNR27042BmqDB7AmXcL6aWs7mEXwbAEdM8JlV6wS6Ml+r2JwvEoiBa4679mcZEZs3TEr3qVXLIYhaiLlF+J6MLyoSQjrn7aGuMPm84UcxbtCaeRY3Ik7dZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=W0MCR+wf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso105817666b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Oct 2025 03:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760609308; x=1761214108; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iAG+Qsr3wjzsEn7xPqBjjdvU8mNrEK01RZVMASCmXJQ=;
        b=W0MCR+wfDbMXdyyRrMKTp1cyLb/OBvi58u0nN3mGGm3x1GsjgovaaeHohmH2fe674L
         suOJEuM/oEB9t/cakVEC66cRGxVwJ+ewZ2Ccoch5BiQUXe1xXdPXGmDTfJZaK1VvFsDX
         tFyXidXglcCFOS3M85JwbUzAeb8MOdm6c3bFauV76tVsI3yhD3mHVIX6GiaFyxaYja37
         6b8ig5ZP2iNRYRhZjArjhMTq6hADzsGnLUx2k+mZrC43gFhj2AklD3w3nd1s7bvjivda
         9ZJP+fYDylEwa7dDYLnGtGNJx7mLO4hBdpMicRjzD3ClnGFwQDfr0vngUg5z5PgMaDAp
         0Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760609308; x=1761214108;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAG+Qsr3wjzsEn7xPqBjjdvU8mNrEK01RZVMASCmXJQ=;
        b=xAtssYinmhYKxF4UoWe0YDo6xCbaiDHLosjJPe3JeOyrpoFg5xJasJqyoe8RW34O26
         VGFDuyMIVWXMHI7AV1i5aFUwDHwT+VeHfxllZVuxLlxJ60l2WnY7h88X84cHH+k1M4zq
         tlSQ9H5KMjAjF51HSG8m2WBTHrOC63NENVgrxe2EzksmiQ2ueBjTP6qhojtTL6Djqcsq
         36K5Tnu/LEOHsCTjfzR7HOOFMPUor+mt5tcIUHEeMA0cfAIyLyc0nXjEgCfgUr5BQ2f6
         xgMS2tSZm3fUcOwu0j1bgegpHBZphqS+YAVYp0klB6ur/LF7UgEY1PArI3Xj8o4kGllk
         5EiA==
X-Forwarded-Encrypted: i=1; AJvYcCV0IJmJwF/oiSNL7kjj1tETFrvk3qw5vLhPeuUPCDGyd3G7HY27z7eOgxGEtlbNHLMtgjIHLHkfj7iq7gSBuOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEknwfcn/AY7f5/qav6G5zDT2tQ2cITJRzytcYyLAe5ln7brah
	lM8ABdk947iOrMmvMd19l+R87eYXNBZT5fr8vblwp5YJbTBsG0rHJWQpyN7GtJL0A5E=
X-Gm-Gg: ASbGncv5/6s0VGjGo9976vTvKB5mf3LIzObN/jostF1QT0roYwDQ9f9G28mEC+zjl2k
	QQRVpguldtVjkGoToi3fzvQ0PnfxtaTLwWCqalBWXB4/tIg7ClUOH0xh4HQzNv1NNr1R9NqdVhJ
	a314B18K3JhNo/WgEJ8OBnk+buaF8Go30JtvVqyloRpc7avO/LCVsZzFSTctCyFUC0aHOiw+dJU
	zHQt5S+1n8eV2WEKohtbnR55MPEBSOsEVuCCJQjRZwee8RvAK5G8ky1pLsFGEtSqT/TiKgn0noK
	Vg5cpnzxWlufj96i3c9ghWvxYMnr6eI3Dy/Ci4xYNfIQZJx8Xqyq96eChxdQjJLR8cX7INVcEHm
	8Tw5Z2F/Jd1NQysSm6qaLMLn1lGVw5zM8m5xxyZNb10qGusv7iUk+ET6Gxtc7oDzY79R8rVWuqF
	KgiCg=
X-Google-Smtp-Source: AGHT+IGVd98H8dpafuklugEXTVi3BFcPl1nZR56txXlgYEVW9BZqLRUhorikH3U8n7kBYnhkg7YyKw==
X-Received: by 2002:a17:907:7b99:b0:b3e:c7d5:4cb5 with SMTP id a640c23a62f3a-b50ac2cf67cmr3476075966b.31.1760609308113;
        Thu, 16 Oct 2025 03:08:28 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:295f::41f:32])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ca4ec65f9sm471635366b.0.2025.10.16.03.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 03:08:27 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com,  edumazet@google.com,  linux-doc@vger.kernel.org,
  corbet@lwn.net,  horms@kernel.org,  dsahern@kernel.org,
  kuniyu@amazon.com,  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  dave.taht@gmail.com,  jhs@mojatatu.com,  kuba@kernel.org,
  stephen@networkplumber.org,  xiyou.wangcong@gmail.com,  jiri@resnulli.us,
  davem@davemloft.net,  andrew+netdev@lunn.ch,  donald.hunter@gmail.com,
  ast@fiberby.net,  liuhangbin@gmail.com,  shuah@kernel.org,
  linux-kselftest@vger.kernel.org,  ij@kernel.org,  ncardwell@google.com,
  koen.de_schepper@nokia-bell-labs.com,  g.white@cablelabs.com,
  ingemar.s.johansson@ericsson.com,  mirja.kuehlewind@ericsson.com,
  cheshire@apple.com,  rs.ietf@gmx.at,  Jason_Livingood@comcast.com,
  vidhi_goel@apple.com
Subject: Re: [PATCH v4 net-next 00/13] AccECN protocol case handling series
In-Reply-To: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
	(chia-yu chang's message of "Mon, 13 Oct 2025 19:03:18 +0200")
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
Date: Thu, 16 Oct 2025 12:08:26 +0200
Message-ID: <87ldlbw44l.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 13, 2025 at 07:03 PM +02, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Plesae find the v4 AccECN case handling patch series, which covers
> several excpetional case handling of Accurate ECN spec (RFC9768),
> adds new identifiers to be used by CC modules, adds ecn_delta into
> rate_sample, and keeps the ACE counter for computation, etc.

The latest draft is here, if anyone else is looking for it:

https://datatracker.ietf.org/doc/draft-ietf-tcpm-accurate-ecn/

