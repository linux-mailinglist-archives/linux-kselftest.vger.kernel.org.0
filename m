Return-Path: <linux-kselftest+bounces-41037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B50B4A64F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 11:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930F73A62DE
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 09:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BF32773F4;
	Tue,  9 Sep 2025 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/WezDBF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3BE246335;
	Tue,  9 Sep 2025 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408408; cv=none; b=i6v1ZdxDPKDwJVCwO2ZfFK85R59xX7t2NGViyqtR22w7Iv0wamPaDI6uXLuIqfy/cuRSsEgxI/h7EXPU+WLDcYXRxpyS50XjwGfnUpUq5qKwI6+RAmsojfrI2CSs32WsQcpg5kn/xeOjRgXU64l9UxFWOveuW2lJu0BlsFBg3kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408408; c=relaxed/simple;
	bh=aFSUmCti6MLTcqlgBbhF05M3cBauzcyYGq99VlvOS14=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=PsHfGZ1Ldy7ppZ3DP94OHY5WF84Xwa2r7qiSq1CIctW5YOhvFO3246xQCws6EhTyeslb3QqEaayVxFBoBvCFAVPToh9ZS1n2dCCCm26vueaNv+TFYi1+A6m8bEPjk0cuuvrSUPMkgQpCrA5qWOJNzMCOLlnznfo1/ycJDvg7vuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/WezDBF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso2109395e9.3;
        Tue, 09 Sep 2025 02:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757408404; x=1758013204; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2iATGGckum8OfAaFEr19Bj8rW51tZDxYm72q6WM1MEA=;
        b=U/WezDBFrg3etBTmZiSynRRgOiqCSS2cJD9DhdII6LTeT2IBu8xCS3aaUj65ZBMXlI
         Z26jOCdPmUmq8fv0HrVr/uOjkGe5ruB4ouDV+MgRFUQdIOrGTB4/q6QyOWz9H4nORCp8
         rGK6t31Wt8k+HGC3Z778CI2KkWMnPaHxXIYLQd1dQI6+iwSWoR9yGOlkKCm+qZ6gpvH5
         jgaWMShYKGMqzSmfr2YGoc4kksFMSgAcC8xObFNGBAh1dToiI1c/VwY7psEM31fEcVQN
         gYL1w55mbfqacGZRjXjMvptPY4wQTY50shLqskmYwXWyydt/1lBLPnMvVcaTHMwZIg6F
         UUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408404; x=1758013204;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iATGGckum8OfAaFEr19Bj8rW51tZDxYm72q6WM1MEA=;
        b=kICHzJ4iSsgkdJzaXI6p5CM3FgpVfRvIPoK8nOmXisZWup4eDU/ZTi4OzHS6uRo+Li
         m3095Ah0FRbD0d+IxjpDVxqwnLRfKnDMsQv43Qc0bqeV5dsXsO+EqxhSg5mqSlmR8U7V
         dKCRUau1muF14xsykaWwl1035RWsTW7IRv4V/jh5Umvnt4QPyWt+bGNjU1xsp97rxlh3
         fj1QvY2xGhmXaMXXdsDCMGJJc8xXTawbu4Iozizm+Dl6NTSZUbx/TtvZ6HnQufq3u6p1
         6wgQ9j6UtiDXKQ91ZKyL6Y4mKmaZNmuuSGGJIVd00+ZGPw0w9cOtSPaze+RoliebR/8m
         Ba4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUtUFaDP5+MZ9VgUxw4hiPym1HYGCsvzXwvX0TkftC9WOLGrb2XgJ2EI6QCk+EY123hEurqu+q@vger.kernel.org, AJvYcCV+S6KKug1uXm0SZVz06pbdR1I3vzTTPtb7sP7aLyZqxHYL15ebj47K8iR1A2zMasDhCUtN+R8/JZI=@vger.kernel.org, AJvYcCVx1kxi6KRV3xfBigFFzuTC56J+JO3gjBF8lSHHpDbAVq6HghcHW4CtDg9NEldMOodfaV3bK5CyR66mAEGU@vger.kernel.org, AJvYcCWqnf6WP9jbH2sTij8XAEa/6/x/aAysro/F15vs+K+MTGqwFrU+FzBgVvVwvDT0bOIUDDY3AZ4LpyVqV6pGbnfc@vger.kernel.org, AJvYcCXRyU2tT+sKQyJy2b6Z5IzzDnSVHUjyb5O5oh31tHb05HNJ7FdIbeSzWEp8gZyg/v5RE32x8yWN@vger.kernel.org
X-Gm-Message-State: AOJu0YxUmn8NxYBnC1iU5r6vCKeadQmkxPmuDi/o4rFZ40ADBVMjZPMz
	/7mIhtvP2PZas2f+gbQAcgVbElw+boLvMCKh0WmHTuJO08xQa8rjW+ja8oZ3DRB/8LA=
X-Gm-Gg: ASbGncvTh80qvvRpZ/eMbkcu1MrI7WiJoCJd1IwFGoFAI7hMSj5KjYqcJ2QqKC1aP9z
	t7wJ8xF0BVrR4h3QDnj1701Ev2j8GlVX5mdjCOG0n9DSsS/eQldjk5vOnbVYhQmNNBVmxrrmJI0
	8r5mbIH73CHvU0npR9PXNVUikG8UwviPzvDQLRqwvVAA6t8dC2OibnxcXjvsvfO4CjYvKwglOxR
	C43A5GyMb0F9sverrol4vxans2cTlU5pmscH0W8lyYe9pYdsbJ7H7pM0OY+JZXrE7HKBzmdJDG7
	Zc973sEXAw9IlAicASdziKNBPCl9td+kfgd2GJuTMSNVRJEAWyKV9euKi/jy4A1tCQKmNtfq1UH
	WhgVi8ZfU8Ra48oySlYuV256HZoUhn/5KZA==
X-Google-Smtp-Source: AGHT+IHi9nXrfKJGYALDvRRmSRzYypfCt5Kl/21MQbCCiY/bILW7ZiySngyv35dAVzFjI0zhrcNddA==
X-Received: by 2002:a05:600c:1389:b0:45c:b580:f795 with SMTP id 5b1f17b1804b1-45dddedf80fmr83035805e9.34.1757408403794;
        Tue, 09 Sep 2025 02:00:03 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:837:bf58:2f3c:aa2c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e92a42asm477565115e9.20.2025.09.09.02.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:00:03 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>,  Geliang Tang
 <geliang@kernel.org>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Davide
 Caratti <dcaratti@redhat.com>,  Jonathan Corbet <corbet@lwn.net>,  Shuah
 Khan <shuah@kernel.org>,  netdev@vger.kernel.org,  mptcp@lists.linux.dev,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH net 1/3] netlink: specs: mptcp: fix if-idx attribute type
In-Reply-To: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-1-5f2168a66079@kernel.org>
Date: Tue, 09 Sep 2025 09:44:40 +0100
Message-ID: <m2plc0ui9z.fsf@gmail.com>
References: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-0-5f2168a66079@kernel.org>
	<20250908-net-mptcp-misc-fixes-6-17-rc5-v1-1-5f2168a66079@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matthieu Baerts (NGI0)" <matttbe@kernel.org> writes:

> This attribute is used as a signed number in the code in pm_netlink.c:
>
>   nla_put_s32(skb, MPTCP_ATTR_IF_IDX, ssk->sk_bound_dev_if))
>
> The specs should then reflect that. Note that other 'if-idx' attributes
> from the same .yaml file use a signed number as well.

Note that mptcp_pm_parse_entry has this, which should maybe be fixed at
the same time:

	u32 val = nla_get_s32(tb[MPTCP_PM_ADDR_ATTR_IF_IDX]);


https://elixir.bootlin.com/linux/v6.16.5/source/net/mptcp/pm_netlink.c#L116

>
> Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for mptcp")
> Cc: stable@vger.kernel.org
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  Documentation/netlink/specs/mptcp_pm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
> index 02f1ddcfbf1cfd81a398dd03c52bb9f281c1aa08..d15335684ec3d6256505f2b3887ce5818eb57462 100644
> --- a/Documentation/netlink/specs/mptcp_pm.yaml
> +++ b/Documentation/netlink/specs/mptcp_pm.yaml
> @@ -256,7 +256,7 @@ attribute-sets:
>          type: u32
>        -
>          name: if-idx
> -        type: u32
> +        type: s32
>        -
>          name: reset-reason
>          type: u32

