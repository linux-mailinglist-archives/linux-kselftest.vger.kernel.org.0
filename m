Return-Path: <linux-kselftest+bounces-8563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 213368ABDE3
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 03:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671C4B20D83
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Apr 2024 01:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56818205E29;
	Sun, 21 Apr 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFZ1Sva2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF3E645;
	Sun, 21 Apr 2024 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713661235; cv=none; b=HTicmEqYWXXC6kXJYD308LQn1yTEwpQ/z6QlmDhxQ70HLU9YEvtCga7o0kLjF1O3MWTamhsa0E0zEKrF5lHNLavy0kuyEXV091ll+AFFdkEGFn0+ezukzH7CojMIJO1COaxxqG6cGJYfNynOUwtnPPcmxpt7tzR52yO0A01eg3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713661235; c=relaxed/simple;
	bh=CXZ76KQi+vZFND46WET9nmW8tlH1pfeyAeTqKZDqvN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SR87nGbXlZ/EaCfdYg/hDRWDeFWM1HLy3jqqwX5CUX6shqHifK5uZIm92d074As/uGHVgLMjnPWsBqf1tzieU/CclnPV12iY10hrUvhTQm3twZ/6JLQQLhTJW4QpiZp1t7UAKarpU0HTP5+MSJdXvQ43l3G1KjS+1fMkcR0x6F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFZ1Sva2; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36b30909b01so14493995ab.2;
        Sat, 20 Apr 2024 18:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713661233; x=1714266033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKmg+wkO2vHjvlzQqCkZAzwVW3ixvBAxcckkf/8ByLU=;
        b=XFZ1Sva2yEshwp4s0l1aAgLTlhdoBbo8GLFzcqb5H2ZSrz9DfZpxwZqWsex1ILuhwS
         GLkgXLw5fCdthYVpvvK5I9cVsN1Dk4rwskrV4mh1n1P03kSHKl6Sea1eI8N/SMttPbxG
         Znxbj5qeWBpcD2DFcI0hl2P89UDHo91EtyhSp9465sew8VSP0BH/YKlNIbtkZUJ4NX9U
         /ulJNGyqJNv2biiOHS1qgB7aFGeuZ/343zBUeYTaJSzUXBBTnr/8pT2d6bDp+BpBMrod
         MoBEowViItwi8m20eg/b5LOyODkQ5Cd5cZCCzcv7wz5tP+rluQpD4EIFP0rSKUDUP7j1
         BPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713661233; x=1714266033;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKmg+wkO2vHjvlzQqCkZAzwVW3ixvBAxcckkf/8ByLU=;
        b=ZNKOg9NYtDnH4ck/dj4J9lMRmbN+/wafr1TQhMaMD2uyRj8xwFEgwHWj8y4w4aX5sb
         hFx8cA7JSZ29ZTauoORglUwcLV+00AUqV56aClia9CMtNqPAHAJsX7Diyh/Bf7nJ3d9B
         hAYu5oG0yoOCXJoxNHLrSfx1hDbm+Zdk376qllBYk/kmnaQXZQuHH+OVFYrztYJzwJqN
         EJQ8fq4hzEmf9hgAOnmnIWW4xNBPDBBUPiUqFTjyGZyNxJdwR/P1cEJCwFHf8yilf7Fp
         cqzYLNT0AO3B3h1tMMWejUpwv/gnbRdWpwOQgSRR2V/QxJqLyPxIGKyLGUbpHNQSYhJr
         wDzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9N54zUnuF9MPzzgnugzvO7UaPijVBVunJZg9igUGPWfXx88R7dZpSLbfFQgzBGiphjLqeJBL+MpRApvYWVyakD0aPbr2VBydcC9MuSPjd
X-Gm-Message-State: AOJu0YxPSAf3OWdM48deT1LYKhAJXqlt04WnnsilXoVJJaEhSmo+RKKQ
	iBpGPgbjcK2sdzi+pjaXMuJA5z1bLqNd3y43P40U/P7QXHU4x120
X-Google-Smtp-Source: AGHT+IGG+JOk1sdEB+UQRMtH+YK2OAdED+zJPLg+A6paAebaljyc83Gn+e8turevVbnKWf+uqnLdKw==
X-Received: by 2002:a92:cd89:0:b0:36a:fa7a:629f with SMTP id r9-20020a92cd89000000b0036afa7a629fmr8788953ilb.21.1713661233017;
        Sat, 20 Apr 2024 18:00:33 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:1518:4e26:8dc5:c7f9? ([2601:282:1e82:2350:1518:4e26:8dc5:c7f9])
        by smtp.googlemail.com with ESMTPSA id p6-20020a92d286000000b003687fe513f2sm1416458ilp.2.2024.04.20.18.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 18:00:32 -0700 (PDT)
Message-ID: <0a67fff9-c401-40c8-acce-c285698be76a@gmail.com>
Date: Sat, 20 Apr 2024 19:00:31 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] netlink: support all extack types in dumps
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, sdf@google.com, amritha.nambiar@intel.com,
 linux-kselftest@vger.kernel.org
References: <20240420023543.3300306-1-kuba@kernel.org>
 <20240420023543.3300306-4-kuba@kernel.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240420023543.3300306-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/19/24 8:35 PM, Jakub Kicinski wrote:
> Note that when this commit message refers to netlink dump
> it only means the actual dumping part, the parsing / dump
> start is handled by the same code as "doit".
> 
> Commit 4a19edb60d02 ("netlink: Pass extack to dump handlers")
> added support for returning extack messages from dump handlers,
> but left out other extack info, e.g. bad attribute.
> 
> This used to be fine because until YNL we had little practical
> use for the machine readable attributes, and only messages were
> used in practice.
> 
> YNL flips the preference 180 degrees, it's now much more useful
> to point to a bad attr with NL_SET_BAD_ATTR() than type
> an English message saying "attribute XYZ is $reason-why-bad".
> 
> Support all of extack. The fact that extack only gets added if
> it fits remains unaddressed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/netlink/af_netlink.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



