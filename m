Return-Path: <linux-kselftest+bounces-12997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E88A891DB63
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 11:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB3F283918
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 09:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18A284D13;
	Mon,  1 Jul 2024 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAkJXbnm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF17D1F937;
	Mon,  1 Jul 2024 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826044; cv=none; b=m1y1D4OeVPl/KcUt8tdoBKpsFTQewOh5AUcyzxYohkXtmDdjpvf1IEvH6AECZq0o3VC2EPMP2pNZfqVLfkXBZB+4JFP5tni8tl7tywEq6Rn1AMsQAekpdchz9G9NMzdvTrkQw15iLIyOuKbM5J9x8+uh01xt92jeivAqFYG24nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826044; c=relaxed/simple;
	bh=vq47BmXino7PCs8eUW0j5xRD1VaPNvwK1N3aeR9Gwa8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGEWdk5dKU89vp+euSrJ/HEaNTh47SC5pyVoR+n1LspD0PVhZ8jB5Qmg+msWuzJKmiND2CndqSk/PjIhUCzXH1iOXSZLFrf7yF3DcYnUp43n3aYdZkE+fxLNakrzUcRaWFva+VRcsJaeyXfB4/9LE22v6oWENTgCsPX81TkKY8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAkJXbnm; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a75131ce948so190706266b.2;
        Mon, 01 Jul 2024 02:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719826041; x=1720430841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GNSWr+FyKGhJ2OQXJoCbpScKnqu6shkEuuJVrDaTSdY=;
        b=nAkJXbnmcSjwAboazljc/vWijkp6S9VZWYVis7Q9rgubEMhvZ3s12iK2CaxGfFzZCc
         weOjB1NBLedDtMZIRqqZqlLFYMrKEFsRvxgv38IyX9iTzz2JmsBx3IA7PUq3WN2fIs98
         pfQc/y1K7un9EIYz6qW4w0vrEDq6WuUGeZ8tI6g1eK2x15DN+5P9xDvHvUSlUMwr6hO3
         MGNzhVP5J5xMiqpqBIzaq0MI4eDVqJUV5nopK4Sb6Kl69O+pF4bU++c/DxyG2Yy5FRc5
         dglddErIFPw9Fa2EpX5IRuXGDf9DpsL7fS2o7NqewFTv7MbiQFIhZgPcXJ4QctreaNmn
         e4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719826041; x=1720430841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNSWr+FyKGhJ2OQXJoCbpScKnqu6shkEuuJVrDaTSdY=;
        b=LlmRjTmO+LrG4tVHQulPsRP25OkgzwXhFlMs8fqipjT44PNj49yyyR7o3yOE4ojr/L
         pSqI222B4So9DiDhQbVRZd1tHc7IgJ275p24yAFZHOVOexe3rh3FyZOLBL71gIIeL7a4
         m9c7e/uglNj9j6pFDQ+C2IhrJf/tHrxCKvReFvDhpSsfMGvX8nt/VoED4/f/41s2KKuK
         caxYtRNCKINa10HeTVdUKzC6JSt9+o+zc2UdcFdEAHYJa8IS2KFk09LKH4kHL+1sJ8cf
         0pEKZtd1/W/x1Td2TEUtg050qAolL9o1RSUi+ECC5Qyi572dZckVvS9dVkiTZRF8SQlJ
         hW6A==
X-Forwarded-Encrypted: i=1; AJvYcCVXK4V3dUaLVH0Hct173UYzYr6v571hUEg53prUj4uXnGVrqUfHqy78ZzJLOcSDNaRl1fTco7i3LlQ326tII6oI5kIqdM2AJKeaa+Rcs8QoXHqzMAffYJFT4vPNnzsxUQ3SdoxgeRs9MVmfOSU3ZG13l6kWI1cAf1wQIaEfQC34gbu+
X-Gm-Message-State: AOJu0YzKx0Cb0DQ2Dkn648XFRL5MJ2/wrVWD4RQTQZcytJqAZyCqN0M/
	KmQPwIpAkLOxH6m+pcbuNmxd96p0aJP1ykMrfPXOTgQhy+AhsH6T
X-Google-Smtp-Source: AGHT+IHHAQ1CgfLrMvgretmQ6tRPHEg59qG3CngcvMyD0jZ/QYYIXkhwNMGqQeDhggogVEhSWuh2Tw==
X-Received: by 2002:a17:906:db01:b0:a6f:5fa8:1b7 with SMTP id a640c23a62f3a-a751441a658mr436498966b.15.1719826040583;
        Mon, 01 Jul 2024 02:27:20 -0700 (PDT)
Received: from krava (37-188-135-196.red.o2.cz. [37.188.135.196])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf63981sm309030866b.82.2024.07.01.02.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 02:27:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 1 Jul 2024 11:27:13 +0200
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev, mykolal@fb.com, sdf@fomichev.me,
	shuah@kernel.org, song@kernel.org, yonghong.song@linux.dev
Subject: Re: [PATCH] selftests/bpf:fix a resource leak
Message-ID: <ZoJ2cTg8-BgJ2KNg@krava>
References: <847bcc7c-e54e-648a-be47-59e0a6d0853e@iogearbox.net>
 <20240701021331.3057-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701021331.3057-1-zhujun2@cmss.chinamobile.com>

On Sun, Jun 30, 2024 at 07:13:31PM -0700, Zhu Jun wrote:
> The requested resources should be closed before return
> in main(), otherwise resource leak will occur
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

could you please send this not as reply but as a separate patch with v2

> ---
>  tools/testing/selftests/bpf/test_sockmap.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index a34e95040994..d51af986d9d8 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -2075,8 +2075,10 @@ int main(int argc, char **argv)
>  
>  	if (!cg_fd) {
>  		cg_fd = cgroup_setup_and_join(CG_PATH);
> -		if (cg_fd < 0)
> -			return cg_fd;
> +		if (cg_fd < 0) {
> +			err = cg_fd;
> +			goto out1;
> +		}
>  		cg_created = 1;
>  	}
>  
> @@ -2092,7 +2094,7 @@ int main(int argc, char **argv)
>  	if (err) {
>  		fprintf(stderr, "populate program: (%s) %s\n",
>  			bpf_file, strerror(errno));
> -		return 1;
> +		goto out;
>  	}
>  	running = 1;
>  
> @@ -2105,13 +2107,14 @@ int main(int argc, char **argv)
>  
>  	err = run_options(&options, cg_fd, test);
>  out:

could we check for cg_fd >= 0 and have just one out label? like:

out:
	if (cg_fd >= 0)
		close(cf_fd);
	if (cg_created)
		...

thanks,
jirka

> +	close(cg_fd);
> +	if (cg_created)
> +		cleanup_cgroup_environment();
> +out1:
>  	if (options.whitelist)
>  		free(options.whitelist);
>  	if (options.blacklist)
>  		free(options.blacklist);
> -	close(cg_fd);
> -	if (cg_created)
> -		cleanup_cgroup_environment();
>  	return err;
>  }
>  
> -- 
> 2.17.1
> 
> 
> 

