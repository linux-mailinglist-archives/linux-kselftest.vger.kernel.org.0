Return-Path: <linux-kselftest+bounces-7927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550F28A442F
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 18:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C262811A2
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 16:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F8C134CFC;
	Sun, 14 Apr 2024 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp9b6+9j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37711DDD1;
	Sun, 14 Apr 2024 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713113147; cv=none; b=pJJNl+CE0yr58TOuviMnSQ+IBCm9qRj68NZGFKt62tdsdY7rmEpxqSPbnHua8siezkPTDuQlztLFCtXlDnCmLRKuDxG2gAW9+GgyA1RZbnhKBcBNqE0zhmmQxNejBumqto7fVp19yWa1rPGpaRHbFrgF7TYjxeKCd9sJphPy3Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713113147; c=relaxed/simple;
	bh=V+NfaheAXFpT8Hz329XYHwVF4m9kHPYeaiFTITQCOaQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IDFnDyyVaaQco/6cqJW02J57IJZcHtVlm/A48GoFermRdOYlVeZAK7WjhFJXaWvPVXEmWe2XPShSGr7GVzXqoBqnPqWw1vR26QnqYBU/+wVB5t03T8QdPD0Vrc1wHVKyjz6WANgSHFi4NVGNmyzJWrPts0Dc+S7QxnyoryY1yYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mp9b6+9j; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78d677dca70so195775785a.0;
        Sun, 14 Apr 2024 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713113144; x=1713717944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liWq0GeqWNKiEVgSevwgSiC3SWLA0eT8nzgnglQkx+g=;
        b=Mp9b6+9jy1ATSqpKYtcHsKiW0jyPn0Qch4NFjiYj6cqz/fBdq2ANJ7h/LylmDQtwqX
         O//ylvRtEEoexkIZxHEk+EKphcadmeqQQKi6kUEzNz7kOGjFTjLWYRemXiyGsqf7BA1L
         mvWSmAq8gf5ZFNk4jwPZcn/EoofbL/djXgvFcJnNuOaj17FmA2sOQfHvz4FZtOhqhYLs
         A/qXtADafvtwAYbwV8U8yfztJIkkECCXF7jBPSXN5FVSAyu/C78azto77lac/JTtKJkh
         r6wN3bfGd8oIiU1y2xKrmzAOFjg+V+pyvqFv3NBAOG6lBZKfqjh/OI1alOlymraF5QvT
         tGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713113144; x=1713717944;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=liWq0GeqWNKiEVgSevwgSiC3SWLA0eT8nzgnglQkx+g=;
        b=jReRvoUC5ceAdyI79dh9EAax4Z1izvXJqQnABufAaD4V23oKcFKli+y786BWT6g2oh
         0i/Jia1xwKUNd1UI+Z9fvO+D9PG859rXjsco8yca9xvRCoXmJUC1vcI7EwTvbBXAo0dJ
         HXa8p3O2BoteuIWV+kghE6WOe4q/r6FWA+91LCNFFGcBsuts3O3HZJZwN7tixsNt5Jfz
         W3CW9Bf41v7DwSdH8uSXcclsw5FNm19bRmjVYj93HLuo7Nq4ANDCfrmRq9qaROCcgFWh
         219bdmmk5iWqconJ51AUn7NVWegobOay2ldewNJZ7Cy3H/OLh5Wajz1s22etphxddFoj
         pypg==
X-Forwarded-Encrypted: i=1; AJvYcCVWxfSjijE4zB2/vc2KbsytsrMTJk2zDe3I0nlrP0qiMlMZ3EmQaZXsKwz/to/h34WkIloh9Tz/Dd0jrzuidxqD6ramvCRIhoP1CL3Cy9ok
X-Gm-Message-State: AOJu0YwnPWaxaumDrjgbJWInufNlz73AXKTCV5bjJiIp1pFNssNogIUK
	KdaUZZ87N6ZMbmyZC19kOxdfVJwTnYZa7HZdWBCaJ1VQJKf56I+olc/YOw==
X-Google-Smtp-Source: AGHT+IFm/tcSv3KMbqT8nVMtEtC3uVKbWChxJCZm2YJXHz4HQmivqwyfdN/whjXtZEnYKYYquw+rxw==
X-Received: by 2002:a05:6214:a4d:b0:69b:6124:1ac8 with SMTP id ee13-20020a0562140a4d00b0069b61241ac8mr5107939qvb.43.1713113144617;
        Sun, 14 Apr 2024 09:45:44 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id m10-20020a05621402aa00b0069b5b7774a6sm3340960qvv.34.2024.04.14.09.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 09:45:44 -0700 (PDT)
Date: Sun, 14 Apr 2024 12:45:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 linux-kselftest@vger.kernel.org, 
 willemb@google.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <661c0837eb5a6_3e773229499@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240412233705.1066444-5-kuba@kernel.org>
References: <20240412233705.1066444-1-kuba@kernel.org>
 <20240412233705.1066444-5-kuba@kernel.org>
Subject: Re: [PATCH net-next 4/5] selftests: drv-net: construct environment
 for running tests which require an endpoint
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
> Nothing surprising here, hopefully. Wrap the variables from
> the environment into a class or spawn a netdevsim based env
> and pass it to the tests.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../testing/selftests/drivers/net/README.rst  | 31 +++++++
>  .../selftests/drivers/net/lib/py/env.py       | 93 ++++++++++++++++++-
>  .../testing/selftests/net/lib/py/__init__.py  |  1 +
>  tools/testing/selftests/net/lib/py/netns.py   | 31 +++++++
>  4 files changed, 155 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/net/lib/py/netns.py
> 
> diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
> index 5ef7c417d431..ffc15fe5d555 100644
> --- a/tools/testing/selftests/drivers/net/README.rst
> +++ b/tools/testing/selftests/drivers/net/README.rst
> @@ -23,8 +23,39 @@ Variables can be set in the environment or by creating a net.config
>    # Variable set in a file
>    NETIF=eth0
>  
> +Please note that the config parser is very simple, if there are
> +any non-alphanumeric characters in the value it needs to be in
> +double quotes.
> +
>  NETIF
>  ~~~~~
>  
>  Name of the netdevice against which the test should be executed.
>  When empty or not set software devices will be used.
> +
> +LOCAL_V4, LOCAL_V6, EP_V4, EP_V6
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Local and remote (endpoint) IP addresses.

Overall, this is really cool stuff (obviously)!

REMOTE instead of EP?

Apparently I missed the earlier discussion. Would it also be possible
to have both sides be remote. Where the test runner might run on the
build host, but the kernel under test is run on two test machines.

To a certain extent, same for having two equivalent child network
namespaces isolated from the runner's environment.

> +
> +EP_TYPE
> +~~~~~~~
> +
> +Communication method used to run commands on the endpoint.
> +Test framework supports using ``netns`` and ``ssh`` channels.
> +``netns`` assumes the "remote" interface is part of the same
> +host, just moved to the specified netns.
> +``ssh`` communicates with remote endpoint over ``ssh`` and ``scp``.
> +
> +Communication methods are defined by classes in ``lib/py/ep_{name}.py``.
> +It should be possible to add a new method without modifying any of
> +the framework, by simply adding an appropriately named file to ``lib/py``.
> +
> +EP_ARGS
> +~~~~~~~
> +
> +Arguments used to construct the communication channel.
> +Communication channel dependent::
> +
> +  for netns - name of the "remote" namespace
> +  for ssh - name/address of the remote host
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
> index a081e168f3db..f63be0a72a53 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -4,7 +4,8 @@ import os
>  import shlex
>  from pathlib import Path
>  from lib.py import ip
> -from lib.py import NetdevSimDev
> +from lib.py import NetNS, NetdevSimDev
> +from .endpoint import Endpoint
>  
>  
>  def _load_env_file(src_path):
> @@ -59,3 +60,93 @@ from lib.py import NetdevSimDev
>              self._ns = None
>  
>  
> +class NetDrvEpEnv:
> +    """
> +    Class for an environment with a local device and "remote endpoint"
> +    which can be used to send traffic in.
> +
> +    For local testing it creates two network namespaces and a pair
> +    of netdevsim devices.
> +    """
> +    def __init__(self, src_path):
> +
> +        self.env = _load_env_file(src_path)
> +
> +        # Things we try to destroy
> +        self.endpoint = None
> +        # These are for local testing state
> +        self._netns = None
> +        self._ns = None
> +        self._ns_peer = None
> +
> +        if "NETIF" in self.env:
> +            self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
> +
> +            self.v4 = self.env.get("LOCAL_V4")
> +            self.v6 = self.env.get("LOCAL_V6")
> +            self.ep_v4 = self.env.get("EP_V4")
> +            self.ep_v6 = self.env.get("EP_V6")
> +            ep_type = self.env["EP_TYPE"]
> +            ep_args = self.env["EP_ARGS"]
> +        else:
> +            self.create_local()
> +
> +            self.dev = self._ns.nsims[0].dev
> +
> +            self.v4 = "192.0.2.1"
> +            self.v6 ="0100::1"
> +            self.ep_v4 = "192.0.2.2"
> +            self.ep_v6 = "0100::2"

Use FC00::/7 ULA addresses?

> +            ep_type = "netns"
> +            ep_args = self._netns.name
> +
> +        self.endpoint = Endpoint(ep_type, ep_args)
> +
> +        self.addr = self.v6 if self.v6 else self.v4
> +        self.ep_addr = self.ep_v6 if self.ep_v6 else self.ep_v4
> +
> +        self.ifname = self.dev['ifname']
> +        self.ifindex = self.dev['ifindex']
> +

