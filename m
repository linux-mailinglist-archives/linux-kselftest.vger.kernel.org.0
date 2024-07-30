Return-Path: <linux-kselftest+bounces-14480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6514941D23
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 19:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2FD28B180
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 17:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC72E18A6C5;
	Tue, 30 Jul 2024 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FNZMc9vF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C2C18A6BB
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359603; cv=none; b=gnqeO1O5GCewqzGKuHlVTfrQfIdvvWTihNYcxmkTzBfAUWtxx7vWvZfL5IF7jqSCTjqxi26/wXB6UDOVcNNbr/u3TIapW81d0f6kTVljkn5J4aL3SXTkt/BpBhCjGDFxzOK4v27Jyar/v3FBh41u+1ddUEO4JJyCrGTfecfOq+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359603; c=relaxed/simple;
	bh=GzimSGPp4Pj8GOfT5R+B7eU0TGFkgJ2E+BdZPdWVLYI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i38uo2ZO3yhncFO82ygYHUfqjh7MYwL7MuB+FNv6/O8Sqar5nn6y8oHfaMXbch4ZfUTBaEqj2t9ozlroK1tjqDUz0kXlD45pMk5Tu8KQis0PSNjMHj3e3bmtCj8O6U2KwW15wG7WcJv+ggixL6T3Jc7bzuIA3NIMEjBis4k9mwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FNZMc9vF; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7d638a1f27so189018666b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1722359600; x=1722964400; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8m0nShPnuINbCdjeY7nEN4rJqDqmHY1w1WDR0g7gvAM=;
        b=FNZMc9vFUzMnAm6m02CxzK5fiUopr368ph5r15TjjQcmEh9KQYLiGsl1+Iv4ddulJY
         Yt5kPr4+sedfa9JwHQMkANRMjV1NrP/UGZlYvRyQldkXpyS21xWLFimTY/tssXdn6t65
         W92k8ZDYOc+thywbBRfLXVxBiNUj1Xpn1xAHcSYmdGzi9LuOVBo2XxNWbP0beReVAPRR
         pTeDMqeDMd/r9SIDXF1m4BSapXjnw0wbzqhcDFyPw0Lw0yaSo9cRaWG6at/OW0nmOUp+
         tyT1R+aQ0KSMp2NLsqhPGGNSsU4axNSRxX9XKsEKy6NAVPi9fiBIk5Ba/jfvt53XgNeU
         LMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722359600; x=1722964400;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8m0nShPnuINbCdjeY7nEN4rJqDqmHY1w1WDR0g7gvAM=;
        b=hd6DeHPpzdPpRwERga4NVQXLtkSvM21Y4gXuxIBwVxAs6sbhSB+nDWJQ1+Pxe3qxfg
         POFi9tB+b/3xgVDGlg0vU07ZcsQMOHtzDwmTCuXWb6EQ2O146imH8pCvbYDl1ESrwph9
         I2pJe+lZbpvOn9DUHHZcncRVH/MP8STBB2UnMGX6dwWb8GrZEjC8dY23Swd4ptMrXcjZ
         bJ5ADqMeOyjxJCZUxBrf6nBLFq94K/LPwyOQhysGbzZnEOwFxt4c8aSMsaP2bUiBy3f6
         vQ5YA41omwLeACxznjl5UwWFOLf0Ywu64eEwi7emtTqsc1skBDdoD+7L/zqibiIrwlNn
         Wipw==
X-Forwarded-Encrypted: i=1; AJvYcCUzrtuvSwpMX4HQZ8k4gCAvvoxtji0KIiYpga5dueW1XsPAON9j9MqBY2g99wh4VL2B1oWY4tc8mEL+W22FDhh53+SCYmgcT6KshGltONRz
X-Gm-Message-State: AOJu0Yw8SFUkG/OF3N9Kpk1fuXYi7kSmeJPfwW6Y3jJdbIGZZMtr6uhp
	FUdmeDvbm/d50qJCdtsckpDM6zcZpknxtCJXLUTlhyO/rRzZNfBpd+JDi9y0Bv8=
X-Google-Smtp-Source: AGHT+IGkt1E+D2BdP4URH/gGZVLCq5xWR4UWldftuqBSyxAPfGBZxzjaW//v+4HpwiJK/1dy4xQZgg==
X-Received: by 2002:a05:6402:50c7:b0:5a0:f9f7:6565 with SMTP id 4fb4d7f45d1cf-5b021e1745dmr11214748a12.21.1722359600380;
        Tue, 30 Jul 2024 10:13:20 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:2f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b03ccsm7466835a12.16.2024.07.30.10.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 10:13:19 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 1/6] selftest/bpf: Support more socket types in
 create_pair()
In-Reply-To: <7ae7a77c-c5ce-4a09-8a6c-b3cd014220f3@rbox.co> (Michal Luczaj's
	message of "Fri, 26 Jul 2024 22:29:39 +0200")
References: <20240724-sockmap-selftest-fixes-v1-0-46165d224712@rbox.co>
	<20240724-sockmap-selftest-fixes-v1-1-46165d224712@rbox.co>
	<87cyn0kqxu.fsf@cloudflare.com>
	<7ae7a77c-c5ce-4a09-8a6c-b3cd014220f3@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 30 Jul 2024 19:13:18 +0200
Message-ID: <87mslyztu9.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jul 26, 2024 at 10:29 PM +02, Michal Luczaj wrote:
> On 7/26/24 19:23, Jakub Sitnicki wrote:
>> I was going to suggest that a single return path for success is better
>> than two (diff below), but I see that this is what you ended up with
>> after patch 6.
>> 
>> So I think we can leave it as is.
>> [...]
>
> And speaking of which, would you rather have patch 1 and 6 squashed?

Don't have a straight answer, sorry . Would have to see if the diff is
clear enough after squashing it. Use your best judgement.

It's certainly fine with me to review the steps that were taken to
massage the code.

