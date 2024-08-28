Return-Path: <linux-kselftest+bounces-16587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C719630FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 21:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773A71F23B38
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 19:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF661A76A6;
	Wed, 28 Aug 2024 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmRxYNeA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634EF20B22;
	Wed, 28 Aug 2024 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724873617; cv=none; b=BQ7VKQDbfepaW71NCqljLcW+D+W/iy6R8Yobw0WyppEMqnpOKrmuknrZTMt10pxaCEtXmxX1vLozNOyo3Wg+CeUBOwaBecEd5p9iO527P71XjtzI1RBuLEwdwqZFAqjUqqSEznaFc8L/FbmWMdZnl5zaKsRCk2Xnvi3wvpqqXBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724873617; c=relaxed/simple;
	bh=U8BIWiS8hHcFq3yHSF/Vs9beTWUZmzVz9vZM20MEGeo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ADuV7U4S/+4Ob7jAeyLKcwdxzmZzoRJb+F5iLhc5ggcg17krVMcMOiVLll9e2ZURgGyLWFvPxeJ7mWs4jvzrt8Ja5JYqRXCBFR1mD8cA7NfrBjojYrjjZh/LYq217Yj5mECyTfhFUAzsNeIWeeegBnGvek4ipXnoS9WP63pMheA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmRxYNeA; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-70df4b5cdd8so5199225a34.1;
        Wed, 28 Aug 2024 12:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724873614; x=1725478414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=To0ai7PZ9nRETZyZcKswl8MwHRLVlUwg6wbmZ08m7KE=;
        b=SmRxYNeAcH66qDXLKFXS2GTxCKqLaSCwi8L5hBf7LF9ECcfv0KDJjZrPRONkBcwe9F
         n1a6zZVPjV1XRqT4bfYYdj/1zWvihHM4lpcL9JIRolG6FqacuxXjovYuNPZiKYbeq4Av
         Fqqh0o5PBnfTx0JHTyGkbevNsXK1T6rhikqECNvKd8dHNNKOLunvsBm/XevHgAKq1bXY
         fC+5MMBmvAn2KRP32Ln/fTR1B6+g0hAfUsEHIrCcSSSmqdK859IvsBG/p/nR0xjeKgLH
         O1H+Do1HCXNQ+UuriLaBKhZPNr1i9wm13EvGXidSkuQ5TJrF0IUl8YF2xtLquIxcVRSu
         DUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724873614; x=1725478414;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=To0ai7PZ9nRETZyZcKswl8MwHRLVlUwg6wbmZ08m7KE=;
        b=fAfW+GcOhr+MRlkJZhjmJmJlD5Ff1HULpRnwm+8oXT7LYBIGJoVkgOOX5DzIVvLx4q
         k/1KIX/4A/liS7UHAQs87lNFokvIF0EU+PyisUZLMkD6zPQh2HD1JpP/9Pjg1kAWRO0M
         PUcXqJoTRSg05zt9qzY0lV0uKbjWTfYbsfLON1c4DAriD03Q8FJsgaKTiEIjYtcfcs9b
         030MilIIdv9ExHYg6VXV9h44PnZZyizv+aEkaidEUojRy0poHABNrh0fxU7tctUKPbQS
         zfhfLcMjsE44a5p8H5Xvzkh0V0nSg3n/JTNfqd7TH1ujl7U84fgk713AXYvew0oEbEeV
         6ueg==
X-Forwarded-Encrypted: i=1; AJvYcCWMpFUEiaPUv1I/7X7KaTsUl5QBOk2lqnbdUSD3bISv8sEwR5a1MJRrWCW7/r9PDALBWPnfvZUT@vger.kernel.org, AJvYcCXL1XymzVJJJBIuI/3Gi6Cnwfv21k05u8Jt4LnuWvNiCr/k2smj3xJhqc0Ytx7hnO6SeM4NhED0vcTascC6fhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCGcsyd6Fa2VdEf7emkRSVv0VRjfJweT2qgjsEHZBmpQX8k5YB
	X0XPOs3iHJbeqoQLDoZBil9IE4wD3A/3IUaayycfrx8lgT21jEvK
X-Google-Smtp-Source: AGHT+IEVpe9tDkDc1vZZ7HFLoUta5rz1pB7tC6rSPbMNRzm6L84KT8m1JHtPEN/BA0FoZQhQ714EkA==
X-Received: by 2002:a05:6830:3982:b0:703:6076:a47 with SMTP id 46e09a7af769-70f5c465688mr760725a34.23.1724873614252;
        Wed, 28 Aug 2024 12:33:34 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d1cf61sm67773056d6.28.2024.08.28.12.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 12:33:33 -0700 (PDT)
Date: Wed, 28 Aug 2024 15:33:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 ncardwell@google.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 fw@strlen.de, 
 Willem de Bruijn <willemb@google.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 martineau@kernel.org
Message-ID: <66cf7b8d1c480_36509229439@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240828090120.71be0b20@kernel.org>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
 <401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
 <66cf2e4bd8e89_33815c294b2@willemb.c.googlers.com.notmuch>
 <20240828090120.71be0b20@kernel.org>
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
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
> On Wed, 28 Aug 2024 10:03:55 -0400 Willem de Bruijn wrote:
> > > > A single script is much
> > > > simpler, optionally with nested KTAP (not supported yet by ksft). But,
> > > > I'm afraid that running time without intermediate output will be very
> > > > long when we integrate all packetdrill scripts.  
> > > 
> > > If I read correctly, this runs the scripts in the given directory 
> > > sequentially (as opposed to the default pktdrill run_all.py behavior 
> > > that uses many concurrent threads).
> > > 
> > > I guess/fear that running all the pktdrill tests in a single batch would 
> > > take quite a long time, which in turn could be not so good for CI 
> > > integration. Currently there are a couple of CI test-cases with runtime   
> > >  > 1h, but that is bad ;)  
> > 
> > Very good point, thanks! This is the third packetdrill runner that I'm
> > writing. I should know this by now.. Let me see whether I can use
> > run_all.py rather than reinvent the wheel here.
> 
> Do we have to worry about this now? If you're planning to add a runner
> specifically for packetdrill... IDK if we should. We already have a few
> runners, not to mention that run_kselftest.sh itself can run all the
> test cases in parallel in separate network namespaces!
> 
> What I was wondering is whether we can use shebang to direct the .pkt
> files to be "executed" by the python script. Alternatively we can add
> support to specifying "interpreter" for a given test in ksft infra
> (kinda like we can pass cmd line arguments to a test). Completely
> untested but it should give better idea what I mean than a description:
> 
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index 74954f6a8f94..429c279e9c6e 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -56,6 +56,7 @@ run_one()
>  	export kselftest_timeout="$kselftest_default_timeout"
>  
>  	# Safe default if tr not available
> +	kselftest_interp_ref="KSELFTEST_INTERP"
>  	kselftest_cmd_args_ref="KSELFTEST_ARGS"
>  
>  	# Optional arguments for this command, possibly defined as an
> @@ -78,6 +79,14 @@ run_one()
>  					$TR_CMD [:lower:] [:upper:])
>  		kselftest_cmd_args_ref="KSELFTEST_${BASENAME_SANITIZED}_ARGS"
>  	fi
> +	# Optional interpreter to run the test case
> +	if [ -n "$TR_CMD" ]; then
> +		SUFFIX_SANITIZED=$(echo "${BASENAME_TEST#*.}" | \
> +				       $TR_CMD -d "[:blank:][:cntrl:]" | \
> +				       $TR_CMD -c "[:alnum:]_" "_" | \
> +				       $TR_CMD [:lower:] [:upper:])
> +		kselftest_interp_ref="KSELFTEST_${SUFFIX_SANITIZED}_INTERP"
> +	fi
>  
>  	# Load per-test-directory kselftest "settings" file.
>  	settings="$BASE_DIR/$DIR/settings"
> @@ -110,8 +119,12 @@ run_one()
>  		if [ -x /usr/bin/stdbuf ]; then
>  			stdbuf="/usr/bin/stdbuf --output=L "
>  		fi
> +		eval kselftest_interp="\$${kselftest_interp_ref:-}"
> +		# Add a space at the end if interpreter is set to work in $cmd
> +		[ -n "$kselftest_interp" ] && \
> +		    kselftest_interp="$kselftest_interp "
>  		eval kselftest_cmd_args="\$${kselftest_cmd_args_ref:-}"
> -		cmd="$stdbuf ./$BASENAME_TEST $kselftest_cmd_args"
> +		cmd="$stdbuf ./$kselftest_interp$BASENAME_TEST $kselftest_cmd_args"
>  		if [ ! -x "$TEST" ]; then
>  			echo "# Warning: file $TEST is not executable"

That could work.

Is reporting one KTAP and exitcode per directory vs per packetdrill
invocation good/bad/neither?

Three other issues if this is calling packetdrill directly is
- passing the non-trivial IP specific flags
- running twice, for IPv4 and IPv6
- chdir into the directory of the pkt file

That can be addressed by instead calling a small wrapper shell script.

That would do the test_func_builder part of packetdrill_ksft.py.
But without the need to handle netns, popen/cmd, etc, and thus the
ksft dependencies.

