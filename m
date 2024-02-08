Return-Path: <linux-kselftest+bounces-4296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB54884D86D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 04:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644961F2353F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 03:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DF228E39;
	Thu,  8 Feb 2024 03:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LZnu8tNa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F032555B
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Feb 2024 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362322; cv=none; b=KVX9I0g8KzSgnLiv1h0+rEDL2InmgPIqkFsIvEJq0HTfC3goiybue77rkGUgVUvXeowmGvrFcMMw3ui1p5bgzGGZwJtWXMQyitdQ4rKVX7KKnDmATlX5NM4FTM4wzAem3bBObYLzfjt3h6Nr5Ja0Ns1+7QJU+22qVIxYEJyvHtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362322; c=relaxed/simple;
	bh=cLWclghEYe/SobXj7ek2TNURXsYLQRe2DX0GBHQN0JE=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=C/XMr6V7P4bikRevMjuZ0HycgCc0ehCDTCjPBlZS315oQa17Nrt7DQSILwUUXvG2isPBJ3NWmOkjIbImL+nC3apUN7dqlFm5whHp0NjEznd1FeP8yI6mr3eQrGEBnhBtuXcCVgoUG3zrSphDePkqlBQ0nWM+5NJHio0r/BZ8K7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LZnu8tNa; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-783d4b3a026so73606885a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Feb 2024 19:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362318; x=1707967118; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iGhBKZfymtW/GJZMXD0cDxEYezGwj2g+N6EhP9MakuU=;
        b=LZnu8tNa4B9QxXmzt23dce3YZcjlfa8u2tgd++ucG8XCxKNZH/ys3krK04p1+ibY9E
         Pz/dD94/aBeNQcTI7AEWFMJP9cNWywy0BxSu/VxfpmPvHO2gXg4pUXAmBkZSjxToMSCx
         oIYE1BNZqzdGM/KOOxHL8thF2HJWG3jgfWkWEO39P+gVHtlS/1ZUdSDy9gXjNzigDPPy
         gUoXsXJMhlQ7ZM/2amVcX5htTNb1irq2sauWEboHSOHPL9gEwN0o210/F9XSqc7QdREP
         hZDZqCiX+IJkH0GvPC3HX8t7QsbmIBZGb0ellcqSFywypc6TStN82IFb2cfcm0dfiPQS
         q4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362318; x=1707967118;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGhBKZfymtW/GJZMXD0cDxEYezGwj2g+N6EhP9MakuU=;
        b=uyLSyVQXCZ/PVu1Ak1O0ziou4/WpTT1JbmpiYwlaW/7iAy5nv0IRBwu2x/SmjtpdR5
         lmebuCG3a2q1WWsaF7AFsbNzoqSUToeCF8Jk+HsAtDSzQdhUaO7cHZ+LzZMnbjx3WAWU
         fAqoLaNmfhr/RipLAnNz7rMfOBX1T80/RfiZkfKkL06Y7CptcjG9q1/8Pxau/AmJ/s2C
         BqN6+jMh1Uf816eCX3CjKpUMpXnLKj+EJgrqwbIEhMqs+yTsARi2ERbniCs3e///2HO3
         BMpL+WxOerO2AZ++qy7bcxEdxrnvba5KnTubWwPXbfFRfI2E1TEDIPQZHrSRRzS1S6wc
         V3wg==
X-Forwarded-Encrypted: i=1; AJvYcCVShSdVMdu+PaLTc/ciu+0Ss8/H8lhY0FTdDZfTk747RD5REjpwEtnThpc1cFReZM46STJCCHQbDsvPj96+bh+Rk/4zBu6nAq8kAVJT/EYI
X-Gm-Message-State: AOJu0Yz1VmUS+nhAmpt4BDPtRWj4bj+Q4v4ez1mx3K8KGqWCaE8F4Fl5
	Hts8vH3/rR0s8fxT8+AbKZzYql1TMq2JiLIMamtjeBPWVnYpyptwxNlJLRwuSQ==
X-Google-Smtp-Source: AGHT+IGVc7X9TG0g4eq+IMY9L5yw86w+Gj4YoO63Nw7ud9AV+DVgQA7Bjc7Nzxt38UNM0zWVNMeakw==
X-Received: by 2002:a05:620a:1787:b0:785:9046:f66c with SMTP id ay7-20020a05620a178700b007859046f66cmr8253337qkb.75.1707362318469;
        Wed, 07 Feb 2024 19:18:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWU/6/SBJRb+VACUYCQK0U1De0vdZ3zw0RRmRKiaVjA8RwkS1x2YP4BzNe6CAqn674YoHHSCiVXIyCNBtKp68Ty2Z4F0B5cGWl4fs++jkEpp0CvDmBpQacpfIDOwDUbrUUhM+xD9XbbeC7Siq4zwJGl1FEvh+cGJxa9uAIhbXnk9SibSavc4WUKVvf/Lrsn5exAYiZOd50Emok5BclC0RaBqp551AmgN0rsa6mJLoHxuPVUn8eBha3htL8jV7ESUBsMTekuxyCifiDEJWDpz0/rbrnxh4I0EMfA4QoVKV89qWL3FnvabaGolulVI1Anq70GR/V/QQPa+Mca8rhQ9mc6RWaZsFJk0Uv8NNnqqOyxMHZ4/GVc+UVHAaI6MoOhTNPMqwWuNrW38P7/r3B0RPBRe2xjU1K44pN0+gwLQxIpmW96GDqkld0GHWxpyO56Q8chQv3vW7JyKIKIAzk9EHVbFx4Jg8npOF1kSWVWgvEdVeCNT50/XMG+GZy8vMxzcN+yQYGIRW16QATvYm4f++AiWz/ZS7suhjhRuQsgeYmKdT9ywU4XkS6S92phILAxNBRKKUfRMoFLiDGeXKc7yfyRA0mdDpq1DhV96Pmok0Tbm6xpwNoE4KTyhxSNyXjYMDLZZOmob5dRU5c6J1wobNNXBUW1VrH96BGIKXwKZ77cLPDUPDTRMZbUSx+i3ddcf9BvMPW/Ri6vLMGmF+05YTPyHBSODVDFL2oni+iCRG7NeFDnk+2jVSOvrC9XmB0+nuw+gZb+ECRZYH6S9zXU3D4IMEB3wF4XC8pmi1tIxxaVdS6AfTgd3f9qRKLBYlnVM59cSozeIclqTTQg+xok9xTZHxWSBA0z+B2KddElQIP0gN5QOtGWMNi8ZNy919b5E/NkiANVZvmfPO9oyhfkMmoIi5wNzp820R28nE7Bu7iXYj1RmvzlVNYfv4Le/gJB8R3vB
 CSi04GOdhdvgc=
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id m16-20020ae9e010000000b00783feb25669sm1067754qkk.116.2024.02.07.19.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:38 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:37 -0500
Message-ID: <c0b607b41771394610d11d48e22ac6ec@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 6/25] evm: Align evm_inode_post_setattr() definition  with LSM infrastructure
References: <20240115181809.885385-7-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-7-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Change evm_inode_post_setattr() definition, so that it can be registered as
> implementation of the inode_post_setattr hook (to be introduced).
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/attr.c                         | 2 +-
>  include/linux/evm.h               | 6 ++++--
>  security/integrity/evm/evm_main.c | 4 +++-
>  3 files changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

