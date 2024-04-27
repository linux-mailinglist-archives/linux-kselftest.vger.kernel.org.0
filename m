Return-Path: <linux-kselftest+bounces-8990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BAF8B4685
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 15:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC112823A3
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Apr 2024 13:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5218C4F20E;
	Sat, 27 Apr 2024 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Se+DKCCL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A848CFC;
	Sat, 27 Apr 2024 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714225865; cv=none; b=XFU9PxzBlsbT67Y9Tfx1c5ABqsoHh6FjfT3pQ7f1RP5CGrzggk4Ervco01ZTkwllThbhzJpFVYB1YBMt2RgmUfV1AN+HevfUmtHH7dzoy7jhl+M1SxIx9pcmTCH1NJVICkCIG1AEuhvwIZw3dAlTkcRe8kX4+OQo6ynuh2l8Hqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714225865; c=relaxed/simple;
	bh=8UCF1j3F233jBZDWWqoK51+23wPhsoyXYKZ/2pFJkUY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tDINyjQm5ZCEisbA+Z1DawO1RkmtIlU6khD+EMdGV0tj97IFS84/OLJ5PuwWBphcFsZKincW1WeBW2bgYzkjTDIIXsdvG4lmC5M80rTG1Ezs90Asqb8CqSMSnd3VePcgIuu0MnwmRWPo4lO+VL+ZsfEsvIPQ8dI/28AIzbcSFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Se+DKCCL; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-69b44071a07so33941886d6.3;
        Sat, 27 Apr 2024 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714225862; x=1714830662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGFud9dBo1jW6BOhBcSRY36qp16qBqYoae3gKVzLmMo=;
        b=Se+DKCCLYB1V9/+klJ10dwD2enCDjSL5iZeduddtKHrObG0bwYBCkYJtCjKiM//Abg
         aLml13Hx286LCEiq3HM2xar5e8r8+X81vmudO99HExrRyKNpZbSZF0UR8ODfhK1BexB2
         PdVSiAtRXrdv6tHC/DvJ60Fp4TybTAk5wcq5oITGUzfqbAjUXN1W/M+ZFLfWNDoDF3IS
         aCeSBzndFNvMsU5huXG6gbKhc//nSpRn9P4W8gyfCPVTVEAvCCLrJc3rz7S8KQIzq0Jx
         01vrkJRCH7scrqSBXehpPBjTtQ938t4NK+XhPi3j3TXKxWH/q97835fT4SYM4NWhNRcB
         FWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714225862; x=1714830662;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cGFud9dBo1jW6BOhBcSRY36qp16qBqYoae3gKVzLmMo=;
        b=scJhtZmyoCisJSuo/ZpEMa+YsUqMWQaloV+7ZV8bq5yspwlssW5lHpkioTIaQxLLjH
         VFoNz+Z3/c2+6ASY6JDoWF//gX7PlryoG5u0XaaDcudb2LjRhxorD8oyS16BZB1xQ9f0
         bNAnky1fnMo8EikBdXfeBUF+mMLaHIcbTKouAWREDUFj0TTOONi6iw4a3evSkdO+gRL1
         28T2hcj5GKYzgHuNkGVWWi6m3Vy+IWAe34JGvu0qwpI2DD4O6JC9IAEfB7P5fqbbrMOj
         GEpG6/pJ7BBNo0SVEvLlIJufhd2+davrWKeKJhhCxRgV9BuapvxJM80lO36ADYTGOmm7
         8+Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXbrnyE+cx51OUlUeNg0Tn+6Auj6xuNrclgKGabMkfjdS3q8UKG47uKOgO4aLNNQ16WD4RpPeQyg1nMFfHjQL7leqK0e4r+/hsXG2oDbcCT
X-Gm-Message-State: AOJu0Yz1cL7oY8CWnDJL29KD5mUTpkL7AMFdkfuUFXc12pNClKvXCadQ
	pEuaMvt4JoN3xQer41fFcoPLJq43JlAR+0Oe8Sxh254zFUA90wbbVogG0g==
X-Google-Smtp-Source: AGHT+IFZ7jPkRuH4ODgvx8p1L1hxnRzFQWMvhbMSu2UvAXq2mIjWKR2qPyNbJgKYI9ZiBbpRLXMF4w==
X-Received: by 2002:a05:6214:27ee:b0:6a0:b3d5:c21a with SMTP id jt14-20020a05621427ee00b006a0b3d5c21amr4866147qvb.59.1714225861651;
        Sat, 27 Apr 2024 06:51:01 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id v9-20020a0cdd89000000b0069b66251944sm8777767qvk.137.2024.04.27.06.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 06:51:01 -0700 (PDT)
Date: Sat, 27 Apr 2024 09:51:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 linux-kselftest@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <662d02c524ef7_28b985294cc@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240426232400.624864-4-kuba@kernel.org>
References: <20240426232400.624864-1-kuba@kernel.org>
 <20240426232400.624864-4-kuba@kernel.org>
Subject: Re: [PATCH net-next 3/6] selftests: net: py: extract tool logic
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
> The main use of the ip() wrapper over cmd() is that it can parse JSON.
> cmd("ip -j link show") will return stdout as a string, and test has
> to call json.loads(). With ip("link show", json=True) the return value
> will be already parsed.
> 
> More tools (ethtool, bpftool etc.) support the --json switch.
> To avoid having to wrap all of them individually create a tool()
> helper.
> 
> Switch from -j to --json (for ethtool).
> While at it consume the netns attribute at the ip() level.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/lib/py/utils.py | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index d3715e6c21f2..11b588a2bb9d 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -56,10 +56,10 @@ import time
>          return self.process(terminate=self.terminate)
>  
>  
> -def ip(args, json=None, ns=None, host=None):
> -    cmd_str = "ip "
> +def tool(name, args, json=None, ns=None, host=None):
> +    cmd_str = name + " "
>      if json:
> -        cmd_str += '-j '
> +        cmd_str += '--json '
>      cmd_str += args
>      cmd_obj = cmd(cmd_str, ns=ns, host=host)
>      if json:
> @@ -67,6 +67,12 @@ import time
>      return cmd_obj
>  
>  
> +def ip(args, json=None, ns=None, host=None):
> +    if ns:
> +        args = '-netns ' + ns + " " + args

Minor: inconsistent use of single and double comma strings. Maybe
there's a reasoning that I'm just missing.

> +    return tool("ip", args, json=json, host=host)
> +
> +
>  def rand_port():
>      """
>      Get unprivileged port, for now just random, one day we may decide to check if used.
> -- 
> 2.44.0
> 



