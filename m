Return-Path: <linux-kselftest+bounces-40366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A354B3CF31
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 21:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FAB8560E91
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 19:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEDD2DF706;
	Sat, 30 Aug 2025 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFgr4St/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF801531F9;
	Sat, 30 Aug 2025 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756583896; cv=none; b=e7/8hU2PRUCIhOCn4bypwN2bw+w+1tamarGHRFJ4afhzw7piMBcUmWthj4fFtp3FC6v8WcNi3QTrpS7KjPM4TUPvsRYDmKM1utELykBshJU8tFS+DueLSDe1DYt5OQ0bz1rxhuRzfrSU4cW00eE+GyEjP5fm51CrIeS5etXzy3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756583896; c=relaxed/simple;
	bh=cy+cMy4+V1RZ3Vu6sBAb3KExdlMUcbMF6Odud+rh0vc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SFT0u2cGxbALdkN6k0Pn6yYWqv+xhtpw1zHhpgr/WZddcpz4emApakgTNOWTlhYEbb4XibeFzG34Ucf4XpKr6StbnIGeZULFBzRfb+TGS+FJuPffFqhf6tFFWj8yTWMFvNO3gavE96MM6s+V1rnZiFCVCBuhn64QoVuHihjZcpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFgr4St/; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b2f0660a7bso30695231cf.1;
        Sat, 30 Aug 2025 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756583894; x=1757188694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmbVWYQAikYUcSmksG/9wMzMH6i0gW0SnhOEIlnn07Y=;
        b=FFgr4St/LfWxuqOahLYBMm/oPka5YnSATvzLLnVm4Yk9RFIeCBD/QgxxnQZMnve6yN
         tFfny6/J3OlRARrqXYHG/zmRaiXNXUsFNnTh4Di8bmi9c8EWCsFxr8tATxpsC0q3MFyR
         duA7d5B7r7H0KZdHHIWAWHxS+aD/BalbgVmG+VeZ2HTUKw4XRDPqfRNEov3KVvNVTt4+
         hTQjGx0RyzS11n7UepkPjymLXqaRfUAgJubMJq8b+3gYO+YlOrUbTYwhU4ENpZ16Mlkr
         n5JqCEHCAIOsM2PmbpGKeoHrJ5N84HYZlzVjfDiB91phDv5amzk8WXEey5tWWxKPVdze
         gU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756583894; x=1757188694;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nmbVWYQAikYUcSmksG/9wMzMH6i0gW0SnhOEIlnn07Y=;
        b=rE38fWJw1FFPRPfQDEITR8tHStwwT2wN24S+8+Gm+1AFhnTEoabpwJdHBBjNNFvIvI
         VrXlIlm5XJ6zWfSVQzeQryGk0wciQ3Ih4zpTO627nYn60WmV2KXBuHuLix3YzlAeT5YN
         J82RuC+q+Xi0nOt4uPgRFDxSFR4+LAJ6/+S0W8ZkwrWfFMkV3kC9YanmM/jTnLKVfbsK
         c3mIqnElvzxSGGk7xYbI28xeP+zZAPALxaIFs9uLMptZhJPZF9to9VD90JNnFZSFm1LM
         qTt904Kqtv/cDboMsbGO6V1VxYLSlwZVhdzhbYi+d/CFKuo7smFMp7LlhFDc9fwLzbzs
         miXA==
X-Forwarded-Encrypted: i=1; AJvYcCVneghl9QGUn9PzU94OGgg5bxC1XzOjDihSLl6nn9IJ334Iw5ZYa43GV1JDMbkcCT3qXvHy3pYYvsV3nyC2sGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0AXkNXqfO9jn97aO6A0/YW0kvtRzwNFyWrCXJVofA3aQ0le7P
	Zu4nowqaLiZyWR57Wktsb79brlu3/xOKmllPEs/ReJ7WXT2RQpgvApSi
X-Gm-Gg: ASbGnctR/jjjAog0VDuCXBr+hlUxECf4kEFgyzA8QxoiDR+ut/eT35Uo7ZB/3z+td3H
	boDiUjL3ewA7Z36VLhj8pPfleN85H0nlC7FmTPuKNzjB6glusNG5YpQx44JXr5P0oQXIOqnkmmx
	WcRhJij2Up3uW8jOhIkt10F1wDTW19KCH5086fL3A6B816nQd6hn4GSROQOfv3xfMLNZr3cH7hX
	Xl5cjmvQL+m/cgFiabmxwN2KNq7+g7AiSp50yrVeLYTve3Z6wJbnRa4N2rixNfgfj6VBJLPFkYv
	hBH/UFqe4AALX+acM76KFFeI9fIFuMNqfWcuOnfdVNuBhThDjjpo+qivweA3kfqmyp6js1fh5B3
	lNuPFi3epvH9hQTFbQep1A1+2/FFkxvv0hLr2LId2hM+pcuPGwqbF732zb4/Mvh+sTEsWBL40jY
	wM1Q==
X-Google-Smtp-Source: AGHT+IHjxbJVnBPslWiZCZrDMB4ZrV5z+Q1oLaha3Q8DUPg9Uvh64nWIqJ6oHcVxpx6tdb8z95aaBA==
X-Received: by 2002:a05:622a:4c0e:b0:4b3:19b1:99d4 with SMTP id d75a77b69052e-4b31dd773bdmr41974511cf.80.1756583893990;
        Sat, 30 Aug 2025 12:58:13 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7fc153de18asm383916785a.54.2025.08.30.12.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 12:58:12 -0700 (PDT)
Date: Sat, 30 Aug 2025 15:58:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 petrm@nvidia.com
Message-ID: <willemdebruijn.kernel.287d82b2988fe@gmail.com>
In-Reply-To: <20250830183842.688935-1-kuba@kernel.org>
References: <20250830183842.688935-1-kuba@kernel.org>
Subject: Re: [PATCH net] selftests: drv-net: csum: fix interface name for
 remote host
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Use cfg.remote_ifname for arguments of remote command.
> Without this UDP tests fail in NIPA where local interface
> is called enp1s0 and remote enp0s4.
> 
> Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

