Return-Path: <linux-kselftest+bounces-24611-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84667A12FAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 01:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163053A5C9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 00:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E7AA957;
	Thu, 16 Jan 2025 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNEY7fQ+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D579EA;
	Thu, 16 Jan 2025 00:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987237; cv=none; b=HH1fYw7PueiHqhjNpKJko593IdPP8jrpjszzc45J4eAmCNmrGFDhCyFQzQuH3rXTRsKmNQ0JNifHwKuhIYRKwN7gKRP/YPJtWDmdjybtOcouI+LoY2Spb4bR5Gb73K26IUXjPpbmg4tkgRpUH061nfErIf7Onfa9XT0JqSVz+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987237; c=relaxed/simple;
	bh=tKeqNuMGTG4Lh6rs8y3af9XwcDjP/sCrRVJ4yf6zZUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZB7wDFIP9/weXjD5cCvrK49tY8pFaXShdAt2x2BTOBceMIsIRvI+iDP8XJgeWk+h4q6Cjq5/Fho0K+J8yjYIAkIxzNcppi6SQs84UoCL9tCa+aqoN3Z3GpI79NWY6b3fnGTE/NmecDi9Gv0WUGDq7Fv6SGGujUzJ+owm8SXWaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNEY7fQ+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2163dc5155fso5100115ad.0;
        Wed, 15 Jan 2025 16:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736987235; x=1737592035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bEcOoHqZCQz992D1472+Bd71qizVhWfxyGjZ+LGLdMs=;
        b=GNEY7fQ+jrqCd8Gwrx3XrPmMFocpaXQodpQqVvwNyqAGAu0vZq1H3M38TaSmepyFmL
         hLuH7t7vEFl7S9VIyWRel3wupyVEbg+YqNpNdRWSbEIe4SYIJKYhHqyfazX+qJuAi4H7
         H7wn0c2vogT/i4hjcmlZdzDsr8wb9Fz8HDZCEX5qml9xN+s46dHQaR9TEzQiBSZ4iYLh
         2Uzrb/O1c3W7jdk+FJZBErZwoCf4T3lgj7cBjhKq9s94iWsUn99KVMcGShOWj+LZB+vi
         WgpSD4xQE1AW4R0nKEXkpoQwmB1lMsv+BhusPvHK694kE2smVZV14QKmZ+cmNj1Iz17s
         jMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736987235; x=1737592035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEcOoHqZCQz992D1472+Bd71qizVhWfxyGjZ+LGLdMs=;
        b=BMcQIDP9yMNXVd7rOB+VZhZC/S5T/GkC6p383zO5wFNOhA4x0zd43/p0gnIMdfGxUr
         xzpl847FqXzcU2JbhHB0qvNAdmJIIhBs/XKLSqmrtbD0XgEJ9gRTz+OIAHIkAllqefLI
         59fFmHXNW42ITY4UozlaRoHhe8Y4g7yfOzu1gPP/U2j3OxHxiWW8tDbT2rSNKLgoCbhA
         iABYOsopj7z88GKefCmbV3apwv4Lbf47DHBu5W6oDO5gF4eS9dxgIujfvf81q77ICpcP
         1jP8oP/wITPPy/Zc6V/WvM45fTdIefVM3dq/yYu+79e+uCVtj3dB5BSL9wBfWUhiVPtk
         tbaA==
X-Forwarded-Encrypted: i=1; AJvYcCUc20n49mz7JgUoaYpLsKHG9BhvnsD4gpfmmudjMp9V0H4i9BXEsx8D/5vYAEERKYUvT/Dg6txp@vger.kernel.org, AJvYcCVlFJjY0BlwxzIg/lOS1NHDmMhNDjcJvuKZ+cGw/DrMIxqBvsKaA0Ujdy0j1wQvRA0hRJF+27ua9Lpj@vger.kernel.org, AJvYcCWCu5TUxUToDGwE85cAtZgkrv2VEKg8a8CAjG5LCDNJk/wgDe3tMnmAyxEfWcXKKLP0xwo=@vger.kernel.org, AJvYcCX9pZ1NWi9/7Js+IWDetQVBWlGBAjrp+QdGlOZ4V0+BzoASDOV3itt/gJAxOpGNPk4RaTwfj1DvNA3VEyqB@vger.kernel.org, AJvYcCXpebtyBU+kQOIAPTtIpwiTHxUw9MS0DmD5AvkHLKWJc+vb9lY1SlzWb3z2ZKPrtyv6Qve/fvshyK/7oXjvtq3C@vger.kernel.org
X-Gm-Message-State: AOJu0YzIfMgkpDj/Nhi9y2lwmjXxelh1/qCgyYafepec13KWXxDDmRlv
	e1aRVT/VTJCka0iX0ZGhgza8pHweZnFGQjL6WAm6RaSfmYVZNx0=
X-Gm-Gg: ASbGncsyepf5lR9DHrV8IqzUrbnREvokK6JjTrLHOEA345FqXVblXgaajrmvXbMTMlM
	Kef0OvMa1XLL3YvAsK2nB6aqzQvQ6nA+k1FqOo3l/fcykAFBcCrhK1QEUqiNDT2OUKo6e26oRsW
	su6USgr1BYfTlb222WDHUpqIckzLwQAx+iqyJtlykKJzJGl7+VEIvXZmJEAFacOs6LfEvwanY5h
	dei2/iFZBQ9gmUeokbrQaVEPBAMYSbxfJfSQO5CRzNdQmM7jtz2oTkD
X-Google-Smtp-Source: AGHT+IF42kOgX+PydEftgfBZixafBXfUCJHxwxxwV4uV0EJebudeO3qjsr2vtf7hdNZFfdVhP9a6Vw==
X-Received: by 2002:a17:902:ce06:b0:216:5561:70d7 with SMTP id d9443c01a7336-21a83fe48c0mr475141105ad.52.1736987235115;
        Wed, 15 Jan 2025 16:27:15 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253a98sm87014465ad.224.2025.01.15.16.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 16:27:14 -0800 (PST)
Date: Wed, 15 Jan 2025 16:27:13 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Bjorn Topel <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	intel-wired-lan@lists.osuosl.org, xdp-hints@xdp-project.net
Subject: Re: [PATCH bpf-next v5 1/4] xsk: Add launch time hardware offload
 support to XDP Tx metadata
Message-ID: <Z4hSYdzvbggntSr0@mini-arch>
References: <20250114152718.120588-1-yoong.siang.song@intel.com>
 <20250114152718.120588-2-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250114152718.120588-2-yoong.siang.song@intel.com>

On 01/14, Song Yoong Siang wrote:
> Extend the XDP Tx metadata framework so that user can requests launch time
> hardware offload, where the Ethernet device will schedule the packet for
> transmission at a pre-determined time called launch time. The value of
> launch time is communicated from user space to Ethernet driver via
> launch_time field of struct xsk_tx_metadata.
> 
> Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

