Return-Path: <linux-kselftest+bounces-21956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EAA9C79FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 18:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A3A1F24F24
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 17:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B67020125C;
	Wed, 13 Nov 2024 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AczsdmsQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBC87E111;
	Wed, 13 Nov 2024 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519170; cv=none; b=aEx/CG3yUgrJ0XFcKRw+cMVdFslp6MpmP/HYnoF9Nxb+MukaB1mwVFY0/dvthdY54MB0WXGLxU0htoYjKNMa0IE410rvSFid7TrKJFQALdGkfdTRAA6kL5V/NgLKFhkho+TJPU+KgwPyCMTvBvqnHCq+c7VuIAuVn6sl/mHYJTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519170; c=relaxed/simple;
	bh=ImFnpaT3fWX+jbI6AoZKXrHFpBNoXUfag1kP5kmZeG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSBSjNK05MzIkxMHLUDfaluiXM+grN6cwDgITu0p1mZJLHy0uBNHtIsfwzRM2ZMiMiqLV96mYTZFa5RXWLSyR3wGQSkkeBlwMP2SAmY/INKjef74Ik8I584A5ooORc+QGj5i+V1GQ2U0bEEf+wouUNOPTUSaHqkFbIJl2Tc5PD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AczsdmsQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20ca1b6a80aso78635285ad.2;
        Wed, 13 Nov 2024 09:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731519168; x=1732123968; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NyIy0y+LWo1AomMNgNueEzGS37WFUxrwnWKqwan2aiw=;
        b=AczsdmsQeQOb8wqc/avfsQvlh7sTbjvDPEWqkd7dR7JXXX9Jll1aKKnhteu4ehvP9M
         wwgyi/uDDOdwJNwEB3mQhffdqXNCP2lpOU4BS0yeeRRPwTEYdaPxKpjp4mIaGXDHXn2z
         a81HOqP1F12Xu8xeokYsgly7xkX11L/Wkd5HcdQwRWjeOvht2O/nk+HtJP6mBJUr2IlX
         26CiIDTUE8OwptnLjlVl+IKEJlf8pywzwS6h1S77EwS+VKHHngcvYIK56OccdUH/VaPG
         LHj3pAay6qSb1UouZ0M/yeq86larsFa2bT4jd2EAQQHuHMQSGEeJGEYsjDQO58vbiITA
         Uz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519168; x=1732123968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyIy0y+LWo1AomMNgNueEzGS37WFUxrwnWKqwan2aiw=;
        b=j+DJ+EOgnXDVK6BgLyMqjo0inUFfNNIS/GrvHMpQjIQmk1tsJrUnYfTAsFYOm+LkgD
         +zcsK/DNq1Y+ts9121cN2BSxUsZSqYeHGIJfaMTWMgCp0OKhu+C0MVsnmTClmoCXzW+M
         JdgQ6QWPH+Y9fUEythBmcuCLBgBZcXKJE7ph9J+EJ2mGtU4nrTimP/g6om5l8cPAVc6f
         CA3TWyCvj+RmLFUqmvGji9dwSRrhjJXaivhYgohhcl0KbDLBEQ/QYFM+XpayUJnEri9j
         vcAFaVG9Z9OOkmOubz49k4I/fqYFMYekv5nSKPUS5nA5fY1fUYFYTsMBfKSdDzINqrzm
         ME3A==
X-Forwarded-Encrypted: i=1; AJvYcCU2CFs7Quui1HxiF07/3UhTVccbuba2I6AksxidwBOTr8pPLUhb9Z/dvmoLRwcOjD+Q/JPg0AV+X2ZUv4Tp@vger.kernel.org, AJvYcCWNM8ZM0jFzttM6oUViWqMcQ65GIvcT0z5aAAz8y7RHO9+XdPG+MUb0ufHK/Z1ryUBbvrVh1DoaENGyPL/vkft+@vger.kernel.org, AJvYcCXT4eErHGSrKf0+FbJeU67hAfDKDmKig7bttx5fO3uc02zTyIQq+kIrCjcx1hmAAMTl6SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWBhfpWPlAiwVA3x7xtGbssz2zUq3dBtdHWt3eI6DzU0cUf1WM
	kloRe8CRbxp851CwOhEqj1HEA+qOs8F/kURBlCGFcjp0AdjgeJ8=
X-Google-Smtp-Source: AGHT+IGbl3E0Lz/dc2uP2mflsGmCThFPUgYryuGzgVE8RCm2pt4+oWW9BYbK7r3zcep78AzgjxCJcA==
X-Received: by 2002:a17:902:e803:b0:20b:920e:8fd3 with SMTP id d9443c01a7336-21183d5532amr288529055ad.35.1731519167912;
        Wed, 13 Nov 2024 09:32:47 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e83eb4sm111708745ad.269.2024.11.13.09.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:32:47 -0800 (PST)
Date: Wed, 13 Nov 2024 09:32:46 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Alexis =?utf-8?Q?Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 02/10] selftests/bpf: use ASSERT_MEMEQ to
 compare bpf flow keys
Message-ID: <ZzTivljZIKEHwlHG@mini-arch>
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
 <20241113-flow_dissector-v1-2-27c4df0592dc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241113-flow_dissector-v1-2-27c4df0592dc@bootlin.com>

On 11/13, Alexis Lothoré (eBPF Foundation) wrote:
> The flow_dissector program currently compares flow keys returned by bpf
> program with the expected one thanks to a custom macro using memcmp.
> 
> Use the new ASSERT_MEMEQ macro to perform this comparision. This update
> also allows to get rid of the unused bpf_test_run_opts variable in
> run_tests_skb_less (it was only used by the CHECK macro for its duration
> field)
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

