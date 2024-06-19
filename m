Return-Path: <linux-kselftest+bounces-12214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DA090E42A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 09:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C45EB2235B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 07:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F5C73455;
	Wed, 19 Jun 2024 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OnlsMUc7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4C35588F;
	Wed, 19 Jun 2024 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781316; cv=none; b=S6Ve4I2CR7IDHAaSyKApLZAhvHp4y3G+kogyeDu4559ZXdpWuSiGuNyTmhN/PgHIQ8liMqe/rRS3zMe/+h+qKkzq9EfrM63pjPZWBenVY+vkCDEr471tm2OtcqN2l3oHnso/cejRvzequ79PpldbH+buJi1WOEJ/H6eTmGCkHmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781316; c=relaxed/simple;
	bh=3lVfdIS/PDZk4mM0tQcF8ACe6odg3yGiJ3kP1q2n/9o=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=tIF/3Dd0ELTvMLnIl4M7BXChKnKX8UZ3fKwb/Y4lVi/e/KTz9IQGCUFjbIAT/ThW56aTwXd5n6bNaKJIniK87QATJl/FwT07jWOhLaRYGdQZEuqIjurTXS5v+8Obz2AN4cHfwf5rBFcCWsrpxXFz6CERP/nwe8CRu5jT/myu8s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OnlsMUc7; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718781303; h=Message-ID:Subject:Date:From:To;
	bh=NuQqSmn0tn1acQ3nlTazL+ODV+eVWhc4qW4UMPGUEx0=;
	b=OnlsMUc7zsrHzyUxGXfI7wMfCBTnj6g/scu59K53eZfXms5FZkzdPD4uDgKk10+xQBL5hKV1i0lJAER46mYC5NoWWtcKMesMk1hGHufsHt218K/vx6XB9WbKveYNs5G0fiWMjHdKMiD7abdw7ixO8XXXf75m0aDMsa+9pRDODDI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W8n8W-S_1718781301;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8n8W-S_1718781301)
          by smtp.aliyun-inc.com;
          Wed, 19 Jun 2024 15:15:02 +0800
Message-ID: <1718781295.6323366-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] selftests: virtio_net: add forgotten config options
Date: Wed, 19 Jun 2024 15:14:55 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: kuba@kernel.org,
 matttbe@kernel.org,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com,
 shuah@kernel.org,
 petrm@nvidia.com,
 pabeni@redhat.com,
 linux-kselftest@vger.kernel.org,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org
References: <20240619061748.1869404-1-jiri@resnulli.us>
In-Reply-To: <20240619061748.1869404-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>

On Wed, 19 Jun 2024 08:17:48 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>
> One may use tools/testing/selftests/drivers/net/virtio_net/config
> for example for vng build command like this one:
> $ vng -v -b -f tools/testing/selftests/drivers/net/virtio_net/config
>
> In that case, the needed kernel config options are not turned on.
> Add the missed kernel config options.
>
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20240617072614.75fe79e7@kernel.org/
> Reported-by: Matthieu Baerts <matttbe@kernel.org>
> Closes: https://lore.kernel.org/netdev/1a63f209-b1d4-4809-bc30-295a5cafa296@kernel.org/
> Fixes: ccfaed04db5e ("selftests: virtio_net: add initial tests")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  tools/testing/selftests/drivers/net/virtio_net/config | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/drivers/net/virtio_net/config b/tools/testing/selftests/drivers/net/virtio_net/config
> index f35de0542b60..040b600d52f1 100644
> --- a/tools/testing/selftests/drivers/net/virtio_net/config
> +++ b/tools/testing/selftests/drivers/net/virtio_net/config
> @@ -1,2 +1,8 @@
>  CONFIG_VIRTIO_NET=y
>  CONFIG_VIRTIO_DEBUG=y
> +CONFIG_NET_L3_MASTER_DEV=y
> +CONFIG_IPV6_MULTIPLE_TABLES=y
> +CONFIG_NET_VRF=m
> +CONFIG_BPF_SYSCALL=y
> +CONFIG_CGROUP_BPF=y
> +CONFIG_IPV6=y
> --
> 2.45.1
>

