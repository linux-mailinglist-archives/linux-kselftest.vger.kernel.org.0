Return-Path: <linux-kselftest+bounces-16580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DB3963022
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 20:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278061C209C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 18:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C401A4B9F;
	Wed, 28 Aug 2024 18:36:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEFF14D71E;
	Wed, 28 Aug 2024 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870209; cv=none; b=kNXJrDaS3qDsCBpc0mooMl0ib1Lpwz5h5ZaAiA54CwngOgJV8E1s+0jIda0NqSUk3Jfy9nZ546uLxaLAKoDAUAml32qSpdj+ULSuSaMybtJIuPmLLjch0zQemS2uvtwnef9EE+Js1DGkXdmAbPBX6k3zDub8hTtSeyqZSIkK0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870209; c=relaxed/simple;
	bh=r01mRCvMHL3+6WrE5AohNk9gKxfi7QlgXqqdm3jMlCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEiDoCmHTOdNbPCfSRTBMx4LTk+GPXo6vMpmI5BU5dYwYhk7MQkjanhVDlo/Nb29/oGZfv8AMdhdUAcRIA7GKbtns1T5kyKUkeuN7dSVrKPDJJpIGBLb4y2/wS8jWlVJRXb8HE/31pyV1ztiWvGcbwoG3hA3grknJu0y/IPBttQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71433096e89so6010736b3a.3;
        Wed, 28 Aug 2024 11:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724870207; x=1725475007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUBySL71VfjyAkGRea7r3djrcF3K6HNslRPa36gZp+c=;
        b=dJfBVwQ8+4045q4fuyzRbY2SU/0+JvGmVoZb1AGa1UFSmxdugrOdwJqKBH420anCPy
         iZXKZsJMMsrgUaB2JSN3zP0pBVyGhO2espiXgVRqXVyHNMlotPgcZrqIGpSFOeTlXAY3
         DhuX8JZMH8URQUfBtajPYS7kHAkmVYZddwDpD6nySl0vfT3CXRnVIDpyEoafUMwhoghx
         gswaFDbsFYvaXxzsZk/0GhOMfercWY7Hi6D+JNifakSmSPqdF/6did3EDSV9M+aEnP/U
         GXzi1Yq/IJq5BVirmGFn11pSMqSDQXfb4AUQ/ua4+pqGoPFyM2VVkmerhPg42vILRMwa
         ITZg==
X-Forwarded-Encrypted: i=1; AJvYcCVxVTeaXNa7ex6e97hfPSTBbZIBKyWjdlmuHmHf26lFjIG1XhtOpt6sTobvQP6xPiEo3tyQeJjMiA4LwR7zw9A=@vger.kernel.org, AJvYcCXgEMomAa72oXBSBoiRm/znTJjADGXePsJKfwx7PX44MJW8Ht2SQ9/l37dfGOZJ7evT+J5Kl48F@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzhk/1uwxknWvGhU5Tdjtsd2kFAlmLs8iRCK8xjeLCAOwnrC78
	jW3lS53y9vgnL5N1c0/w/KDqy3FwpbdcLDw149Zu75jm6y+XBk8=
X-Google-Smtp-Source: AGHT+IHv6SuvOzCB1wuZt1VrFvOsvKbTBpj/FLRzO1RCnHQDvpqYaURkrKAr3XQJH96bVoHKu6BEFw==
X-Received: by 2002:a05:6a20:d70f:b0:1c4:bbb8:4d02 with SMTP id adf61e73a8af0-1cce10c4d57mr193410637.37.1724870206979;
        Wed, 28 Aug 2024 11:36:46 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714343388e0sm10465216b3a.195.2024.08.28.11.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 11:36:46 -0700 (PDT)
Date: Wed, 28 Aug 2024 11:36:45 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, ncardwell@google.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, fw@strlen.de,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
Message-ID: <Zs9uPZyyeJM7VNAF@mini-arch>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
 <Zs87rhH9e_Lw-icJ@mini-arch>
 <66cf45bbd6a6f_34a7b1294ac@willemb.c.googlers.com.notmuch>
 <Zs9cb1j88Y2glBdJ@mini-arch>
 <20240828112350.7b4ba8d1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828112350.7b4ba8d1@kernel.org>

On 08/28, Jakub Kicinski wrote:
> On Wed, 28 Aug 2024 10:20:47 -0700 Stanislav Fomichev wrote:
> > > As Jakub responded.
> > > 
> > > Indeed importing the whole application into the kernel sources is what
> > > stopped me from attempting this before. Florian's nf_conntrack charted
> > > the path here.  
> > 
> > Thanks both. I was expecting to find some build rules :-) But as long
> > as we have this story sorted out, we're good.
> 
> FWIW I lied to you, the "script" for buildings things wasn't committed
> in the repo, I pushed it now:
> https://github.com/linux-netdev/nipa/commit/dde0f093774a4a4c85e595b5cf44bd3e4bd434d1

Perfect, thanks!

