Return-Path: <linux-kselftest+bounces-31451-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59303A99974
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 22:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4855462581
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 20:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A49326B972;
	Wed, 23 Apr 2025 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHjT7QE5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422026B96A;
	Wed, 23 Apr 2025 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745440144; cv=none; b=fwkty/9rB2SQuEcG1E60MXLHvJoCiE5adH/yYaX/BQ0wafGnf4MWxhght3VQqREC9WU4e8PxIeV68w9GFQEdd1iFk4QLonOa8btMhQxweV6lmWE+SGnyrxvZCCcOBKwjzhXgfDWFusBGdafszE2aZ0og4u45xhnmvOPdIUTfInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745440144; c=relaxed/simple;
	bh=a6J0YZiJf0wIUXDHn7eG6jDQuIrcZmzDIHYFQUg5hv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCK7/sua6HbFExtI9rJSFCIkJHbZJRPKaOAoqjfPE9owh4ZfKOtK0XjQWdxkDcndQDTAPpzKustPJvk5oWGrekl/e3ZURX12J44DyrRzajSzt3zXp86FJGhtmk6Epkjqk0/mLWgBgLnBgRGnbot0yKx4r6mLtKlBqzr3ZwBq0JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHjT7QE5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2254e0b4b79so4387905ad.2;
        Wed, 23 Apr 2025 13:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745440143; x=1746044943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oyfXWteVf2Uw3jmWN9AEEs2P8ez5YpxAoieteSWvTT0=;
        b=kHjT7QE534L6vbZRX5cmM/cEozAc1eBzFylEYjIW+RhVoMgybrQ22MJouyiq5MaNra
         mXia+soSRdpEfU3WOKOU5r9UXoZox4fAvCovCQmRAkz/AERMAZF5T/YYgmL1a8QR65y+
         gsJiKTo2/w4HatWhCTd1t43+LNgWYbsKVW6sLJ1GTf/vruITguDBRz95jT8dcdEpw49Q
         Y+6V6mS8NV+wrvtseg1WJm2Sm5x5kyV3JXCo+mdkikpX11BI/Mb2kjYQLpP+zq+M0o26
         Xu+bv/Eojnbosqm3N+5oLIVfZVVo6qtUdrHSoIQWqWygoulx1Uppji0CQh/qn2c7J2sd
         el3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745440143; x=1746044943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyfXWteVf2Uw3jmWN9AEEs2P8ez5YpxAoieteSWvTT0=;
        b=GHy0K7ZOhgh/mHShrTuSjBu5MpPUaVE9Xsl7FPdG0Jmab/a6ovS88HJd+mzapYc2Ku
         /azm9A3cZUIyvVQun7TnLsy8M9bw6rOc63v2EqRDjLczB5AH1x0RAKCoIc4pG7eMfJJT
         n4u6AEwFOKdspy/z8M+/AbXghqcZLLmkrxNVzYrEugZgSPsR0+MMJQfP46pILHRJBOtO
         Dz2mMvXUo6ITXW4ZAVDOYM6f8eCQMHjprtTthKIMf5BvwMgJUn/5yp6N5waTLELw5EHT
         fT8uvUVsu6qdPXDYtIS4V7gClSFQA5QJwxBGvTQDXRCrqPrqQ6jaxt3zSwwtSzeeC2jm
         9gow==
X-Forwarded-Encrypted: i=1; AJvYcCUE7ZJxAqofe/a7k/w57BNYG29jwZ7pQESrV/iUodBP29KcI3SEjiULP01KF77wi1WXVF0=@vger.kernel.org, AJvYcCUFOZSX/e1vAGiNankkrZYvAZBVJyMD+nTySpzkIX4tHyKth32uDjKbGblDXnWkaCS68oDGTKzk@vger.kernel.org, AJvYcCUs6jqfHGEPkgVK6L4EQh4STkpf2Vg7v2ABMLcjHu/PFRVg6vhfupk/cKu/ItrszEqmEZfOcyCOcjU/QWwZ07F6@vger.kernel.org
X-Gm-Message-State: AOJu0YwdKXFLJn9BsNCI97gUVtS/CIt9YuT49dPF71O7kcQ9krg2wwNB
	LNeTD3uL+M8JMXui5FvKJ1zn2NDBqHs+4SIj5z69J7jt3T61kRM=
X-Gm-Gg: ASbGncvc/Uf3wtFcMTTQpCMS4uX2RDpLXJrnGP55Hc/teWnpk8nY6ZU5nP4LpLk8NCq
	lkMYKKQtQybVtcLdncITxnpierl22PfJvuOAXNg5u059+V2pUO4uFOOnVJJ23NaC3LnBJfqwKsP
	WfR+Vc11y0zOqKYpqoHnqjoSec/VWlZzQtAYfhGPTjL2UCJPzTpwiTCbq1FfplFe8T08UueXZ/k
	X+VEFXrCvF3+fDVxStIcvcAbwsRaIOsWEgOsPvxJ0MXCEhCQIG5zgW+4dMabn5dflQgE29TupAo
	oevHgEvrktqfHOQ7bDs9I/PZIsANwwuOptKmjfQL
X-Google-Smtp-Source: AGHT+IG+I2gupbmugyEQpRKBsCZt2czrIlRva1wVly9xDSObaN4PrDuHgmHsG2fu7u6rVZ4ynoqgrA==
X-Received: by 2002:a17:902:e54a:b0:223:5ace:eccf with SMTP id d9443c01a7336-22c535acd67mr324263045ad.25.1745440142742;
        Wed, 23 Apr 2025 13:29:02 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50eb4287sm108976045ad.130.2025.04.23.13.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 13:29:02 -0700 (PDT)
Date: Wed, 23 Apr 2025 13:29:01 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: Allow XDP dev-bound programs to perform
 XDP_REDIRECT into maps
Message-ID: <aAlNjRGLbUuohQCN@mini-arch>
References: <20250423-xdp-prog-bound-fix-v2-1-51742a5dfbce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250423-xdp-prog-bound-fix-v2-1-51742a5dfbce@kernel.org>

On 04/23, Lorenzo Bianconi wrote:
> In the current implementation if the program is dev-bound to a specific
> device, it will not be possible to perform XDP_REDIRECT into a DEVMAP
> or CPUMAP even if the program is running in the driver NAPI context and
> it is not attached to any map entry. This seems in contrast with the
> explanation available in bpf_prog_map_compatible routine.
> Fix the issue introducing __bpf_prog_map_compatible utility routine in
> order to avoid bpf_prog_is_dev_bound() check running bpf_check_tail_call()
> at program load time (bpf_prog_select_runtime()).
> Continue forbidding to attach a dev-bound program to XDP maps
> (BPF_MAP_TYPE_PROG_ARRAY, BPF_MAP_TYPE_DEVMAP and BPF_MAP_TYPE_CPUMAP).
> 
> Fixes: 3d76a4d3d4e59 ("bpf: XDP metadata RX kfuncs")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thank you!

