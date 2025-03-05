Return-Path: <linux-kselftest+bounces-28257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8114A4F23E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 01:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC74E16EBA9
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 00:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4095FC2C6;
	Wed,  5 Mar 2025 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNSaOR0S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7F64C92;
	Wed,  5 Mar 2025 00:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133825; cv=none; b=cpbzdXJD7nT7Rdu+jxFytA3ybRXy6LCxVgWtw7uSJNgpOyc5uSqqQ0LPlZIOqR1+VNQ9ijSRu3XbMRg/9pelyP1akt5EZ74bXHatszuMd4tIveLjafPHqkWXJpbQtp8sx4G0OaJzpGGwq0k8bwEflVZc/pfh15IDG/prepewtfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133825; c=relaxed/simple;
	bh=nzfoi8KCJS0XwaFYpteVHZl08l6v4x/0xXPQMRqBGgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2y92WOEiJYrzQEp9nJbtIV1TwXQfnjf1R9rP9sERAYujzvhnL4Q4NSdrgL3tmlwaZR942p/jfVK0SNPkQT6JMqpMrHq0rL3Wl6xbz32pfjtSRNxDOYisxWAIi1Qaqf9LrTGA6E73COX9fqBZfTdsk5ZQ+12LRnCOFH31yvQGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNSaOR0S; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f42992f608so9925116a91.0;
        Tue, 04 Mar 2025 16:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741133823; x=1741738623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BWgkE01C4qtm+rX+v5JI6bllUDRhSDGvSWAQ+LOdJDQ=;
        b=hNSaOR0S8lif5dHF0U/mq2OlUMetHf1ZIXnAWXKvKEF8mVTR46X7mWLkAwaKC7xY/o
         MSr2ndYphZBWbLc8pg+X4e0M0e6P3gsGPvCMOsNzCxnHto6duwuxyq9d/eQUiIJ/1z9v
         ch9q7vKVcTZAYzBHsteS1Hk6rJwt6pi9Gmoh9rGYTwnBoaI2aoHRXGeas+RHx1rx0RbK
         8vH+D8aSWG42eXNAqNFGprZq61u1aIiIHOtmOrlrmlgmUjKYFGubT60/5nxaT/wBrwoT
         iAYN0+Tt7J4ks+73Mnf8QyDCLb/b80VUyG8xYSZ7iiUxD1vITNmPb8KqGq3n0HDhvryh
         VMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133823; x=1741738623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWgkE01C4qtm+rX+v5JI6bllUDRhSDGvSWAQ+LOdJDQ=;
        b=tdhhYAVZpZ2N1J/L4dd9O53dPN+MtjSB0vHPw5cA4Hy/MRm5THXNgnIUOxU6uRT4UA
         ExvlSS4cOFfllU5oY+6vrclfYPDmEuNIGifm3aYQQdhxuUkiAgEsWatr0LFKVgzSPlkb
         0csTjXhNpkUuayZTKeyjPWLviIe2LcSIsQdWzjg14vUzCOfZWAtgw2EtbeLzT9IWQaTF
         BSGnr/PLCN4WuwtZAZHeySfiVAQx/4rRgyjlekoK7qKQe30n0nbqIKLZdxuRgZr4zy3C
         ijl7ELGue6XLpyAzUOVtjXy1nFGo3B/uW2nFRaArwdCumGG6RNR0ksyNkCUBHwrk66xX
         wluA==
X-Forwarded-Encrypted: i=1; AJvYcCV8jD1L5lkVXsyfHgq5Gl3c/BrxLJWbkq65H/rBs9dRy6MqDFb9/v20BhPj/Hwej7+R5wMwLuDT@vger.kernel.org, AJvYcCXmHnesIIK3ZNorxkrJzkj3F/SAbLIe4RvynikjME2GF51Iy6JacxDSPJBWV8b4pqyY2vRd5et5471rtk9TT8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwetVr613t0V3jvgc4HRsNNKoJ/wpFVn+WZWiW8MjbgZ79ko6qr
	7ei+jKZXoo5oWanvcpiTBayXQ4SZ19zTB+ycwV2jobX5H4eYXTo=
X-Gm-Gg: ASbGncszxDCM8q6MYO96WTwhKVxTXMfAgNOglOo866Jlxc3MbcoVN0m27R+v3zRdAP2
	bsk5Q7Zzjwg9g6EOIKTx/VvEavsUZsnl1ynxRtIYUV3MlvWAEuXWXVE/ihbVy7sTLnQklsgEj6G
	ThZbcrlCajsUeEp9lJsSwYPBQyZZoGoVHaemqMt0BdWOEQKcUUSoiD9pV5KS3dx4QM/qyszV+md
	7R8SrjDfQkoEsS6OJrxte8pV+54ZYLUMcUDN9FiJY6GM7cGzYOrtCoum7EwwV2wmP6XYh1TdrPd
	oBLdGnLs+w13eBrMi/dkqtOMk6i9B7Nxd1p/rB1NrtHb
X-Google-Smtp-Source: AGHT+IEUOyNyCr8su2Nt0F5cgzWa3vGixyoEyth19IaQBHOpQbm27bVD+2qvNIdEjR8i3fHuv4FXyA==
X-Received: by 2002:a17:90b:5249:b0:2fa:1a23:c01d with SMTP id 98e67ed59e1d1-2ff49753b0fmr1877674a91.21.1741133822967;
        Tue, 04 Mar 2025 16:17:02 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223501d2888sm102339935ad.40.2025.03.04.16.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:17:02 -0800 (PST)
Date: Tue, 4 Mar 2025 16:17:01 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, pshelar@ovn.org, aconole@redhat.com,
	amorenoz@redhat.com, linux-kselftest@vger.kernel.org,
	dev@openvswitch.org
Subject: Re: [PATCH net-next] selftests: openvswitch: don't hardcode the drop
 reason subsys
Message-ID: <Z8eX_WaLGCrM8QhA@mini-arch>
References: <20250304180615.945945-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304180615.945945-1-kuba@kernel.org>

On 03/04, Jakub Kicinski wrote:
> WiFi removed one of their subsys entries from drop reasons, in
> commit 286e69677065 ("wifi: mac80211: Drop cooked monitor support")
> SKB_DROP_REASON_SUBSYS_OPENVSWITCH is now 2 not 3.
> The drop reasons are not uAPI, read the correct value
> from debug info.
> 
> We need to enable vmlinux BTF, otherwise pahole needs
> a few GB of memory to decode the enum name.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Might have resolved OVS_DROP_FLOW_ACTION and the rest as well via
pahole, but assuming these won't be reordered/removed too often..

