Return-Path: <linux-kselftest+bounces-3178-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98A58310CF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 02:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 868FFB25CBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 01:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E4D4A36;
	Thu, 18 Jan 2024 01:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnZUkPKw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1138B187E;
	Thu, 18 Jan 2024 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540816; cv=none; b=r2RmCMYp0OQoZG04DDREdXN/MLE3CSOgJBmXYNCiC0utzqwMM5MYFUMJK5ujx/jGnOGICDYiRRW4mmECgHFaN2nvPlGp+XwD763QsdvTqlOGEcd3dEapJqKoTYce+OIAUhzbwRrSfs+QzTM8EiLKuhO+JA7A5KUxlZrYy+1Tu7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540816; c=relaxed/simple;
	bh=hQlzO6Nz6nP2U2O4TNYunk0ZVeCOA+y7BnbYKdnn7r0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=enyn9SF72CGHbIh72BOsAyEy4l88JHdgLBA7NIttaA9uZWvGfoXIAAy2wDg4N/Bag6FsUQS4TF+qLKrbg8Hgm4/INq8+YR4BnVVgZUbQcbmwsw0zpMWxqIAsomHclDiBc761amxUWvJNoOTsTo+t4YzhdZPnJJP6zOHZYnXE9qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnZUkPKw; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6db79e11596so216536b3a.0;
        Wed, 17 Jan 2024 17:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705540814; x=1706145614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ysdI4jVmGv6jMMLChdwyA9xpWYrYNxLP2z87qw+R1ZM=;
        b=SnZUkPKwpGcjxXu5NZ8MAOkdb6AVf8tuno98/EtDo8WZkBT/WVYoqDvPtOYUrOB0YU
         9AP05Q9O+o0MlO2s02bLjseBHNxqHu6JTvYV1YnRlTwpn/rZebW4DBhCw+YZJIP+6hGK
         FqF/Ge/JS/2fwjvhjWyFEe8Qev6jQXJv15N+DEmHxEELg18tGjTfzOzOoa/YehSlsdNP
         4ISL4dPyJh+wmZLKALiaGrZ76V/KZAc53RRtxsIsZOsZPJ/Gwhaci0GK6hy6kI3HAYf/
         fiZxN8ASgr7rK0/ilqtk+l2kHpFdX66NDf094J7xbA1TuRzl+9k+f4QXDWNLMyldEaIn
         ZaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705540814; x=1706145614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysdI4jVmGv6jMMLChdwyA9xpWYrYNxLP2z87qw+R1ZM=;
        b=QTa9sFm/XdGYXJNgzI2O0w8jZNJvN7zgUAKpGvjFc/VAqGuBArP/yGfKxgEaAikbyc
         o8PFFVaQeAVA6YeQOXcyQ0s/HjGpICJAJjgojHbCKL2b6C1x/dJlOWZA4aOoB38xenVw
         uuTIPvsc94rc2dGdTIVyUDCDziS7y8vpnbi31GW4Rrd+8FLdNSpK+uMpjYKs6Dwli6CU
         YuyQp2r01lkTKBR0hFTz49PCf/spbKJop92NtcTCLyBNX+lBZeG9TKfrJmi0JXh1zh30
         Rt3sEe9uwCjZrIkm9w83LzV0aZzQmhOJQxRhJqXaG7Wi2+n5KiRetsjp+/Rtemp8TWV1
         I+Pw==
X-Gm-Message-State: AOJu0YwTeGZfvNF51z12RrvIIBEKaHHKoINQvuZmohCB7Sd7Jm6++M8E
	WP1DEagdTl0d+eRFIaalzEHyORqEafMU1LUshStoIkzInEFs831w
X-Google-Smtp-Source: AGHT+IHwu7KcOrtrcuSoiK75C5DVqpoUCAvAcGbY5+FKeB2PVyrUdPC351jnSp4qZNNtSJJKmB/Irg==
X-Received: by 2002:a05:6a00:23d2:b0:6d9:ad3d:7d8 with SMTP id g18-20020a056a0023d200b006d9ad3d07d8mr260031pfc.19.1705540814285;
        Wed, 17 Jan 2024 17:20:14 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h20-20020a056a00231400b006dacfab07b6sm2061177pfh.121.2024.01.17.17.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 17:20:13 -0800 (PST)
Date: Thu, 18 Jan 2024 09:20:09 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>, Shuah Khan <shuah@kernel.org>,
	Liang Li <liali@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: bonding: Increase timeout to 1200s
Message-ID: <Zah8yeTwB6Xcc6nd@Laptop-X1>
References: <20240118001233.304759-1-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118001233.304759-1-bpoirier@nvidia.com>

On Wed, Jan 17, 2024 at 07:12:32PM -0500, Benjamin Poirier wrote:
> When tests are run by runner.sh, bond_options.sh gets killed before
> it can complete:
> 
> make -C tools/testing/selftests run_tests TARGETS="drivers/net/bonding"
> 	[...]
> 	# timeout set to 120
> 	# selftests: drivers/net/bonding: bond_options.sh
> 	# TEST: prio (active-backup miimon primary_reselect 0)                [ OK ]
> 	# TEST: prio (active-backup miimon primary_reselect 1)                [ OK ]
> 	# TEST: prio (active-backup miimon primary_reselect 2)                [ OK ]
> 	# TEST: prio (active-backup arp_ip_target primary_reselect 0)         [ OK ]
> 	# TEST: prio (active-backup arp_ip_target primary_reselect 1)         [ OK ]
> 	# TEST: prio (active-backup arp_ip_target primary_reselect 2)         [ OK ]
> 	#
> 	not ok 7 selftests: drivers/net/bonding: bond_options.sh # TIMEOUT 120 seconds
> 
> This test includes many sleep statements, at least some of which are
> related to timers in the operation of the bonding driver itself. Increase
> the test timeout to allow the test to complete.
> 
> I ran the test in slightly different VMs (including one without HW
> virtualization support) and got runtimes of 13m39.760s, 13m31.238s, and
> 13m2.956s. Use a ~1.5x "safety factor" and set the timeout to 1200s.
> 
> Fixes: 42a8d4aaea84 ("selftests: bonding: add bonding prio option test")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20240116104402.1203850a@kernel.org/#t
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>  tools/testing/selftests/drivers/net/bonding/settings | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/settings b/tools/testing/selftests/drivers/net/bonding/settings
> index 6091b45d226b..79b65bdf05db 100644
> --- a/tools/testing/selftests/drivers/net/bonding/settings
> +++ b/tools/testing/selftests/drivers/net/bonding/settings
> @@ -1 +1 @@
> -timeout=120
> +timeout=1200
> -- 
> 2.43.0
> 

Thanks, I will check how to use busywait in bonding test.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

