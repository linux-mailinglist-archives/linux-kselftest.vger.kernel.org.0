Return-Path: <linux-kselftest+bounces-35946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 108C0AEAC1E
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 03:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62E781C4611A
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 01:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306DD208AD;
	Fri, 27 Jun 2025 01:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGshnAdb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62892F1FC7;
	Fri, 27 Jun 2025 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750986065; cv=none; b=dFRuVECNmhEE+92BnhyAwo94L+7/ZMO8Su5l8e6BpEArqKZZRxAvxgpgVNE4N/f7WSrs4DGpoNqK2epwfa4oHR4mgGNEgkTucTOhG7IE5H+d4kD2cFZ6aDKz5HI/rX9UFDL8lkn2K36/fttnFSwXP1tHuvBy4M3WXkEWyD8GuZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750986065; c=relaxed/simple;
	bh=EzNtq1CBfE6D5XU7fFWpxazdWNZ6B3o/QCCjb21UIF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=prVb+e5cyprr8Hj/KFhrToqd6ywhWcK1ZZhKVRgceu1rYts55RPRDWPij4FBMq+S+rZkIcb/o395rl3/wCm1sxa0mBgrtYQwXYh2HngNZEVhuNgR1Kw/YRR2tgYelCIi2gPGOP1QMFVDGayXqzmBLLWIOjX5XIjRlWNyPk0JXHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGshnAdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A67C4CEEB;
	Fri, 27 Jun 2025 01:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750986064;
	bh=EzNtq1CBfE6D5XU7fFWpxazdWNZ6B3o/QCCjb21UIF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VGshnAdbpQtUmshrVAsTLVnHviXXGbAWSKHEzbkgWJqG5biezICvDrDoDp6ivq7nR
	 Kt7oKW6t5CDMUCN0P5RwRyO6ldbabAwELZs/8EuBQIHKxcTiv3+1wR9N2JtpH/XK+P
	 b5m1cMJmrXk3L4Rj+lpW7FN51RkEid/PnmNyvIwOeup20TQdCsh6gfKeqc10xgR31z
	 Sjzjx+Od8Vt14TIcly1w50TSqOa7LlhMcOvhMH50RjHIR/h98VjWvj0mCX8CkwVnDS
	 jkoGRYT7UxP77oRu4fxEo1zB1qcTqgiJgmc83qdmbqDU8/0GlaDn7tFiuwAd+TeNfn
	 VRFMmfg3WQHaA==
Date: Thu, 26 Jun 2025 18:01:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
 <tariqt@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky
 <leon@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v11 2/8] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <20250626180102.497e35a2@kernel.org>
In-Reply-To: <20250625183018.87065-3-mbloch@nvidia.com>
References: <20250625183018.87065-1-mbloch@nvidia.com>
	<20250625183018.87065-3-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 21:30:12 +0300 Mark Bloch wrote:
> Introduce support for specifying relative bandwidth shares between
> traffic classes (TC) in the devlink-rate API. This new option allows
> users to allocate bandwidth across multiple traffic classes in a
> single command.

net/devlink/rate.c:390:33: warning: variable 'total' set but not used [-Wunused-but-set-variable]
  390 |         int rem, err = -EOPNOTSUPP, i, total = 0;
      |                                        ^


Documentation/netlink/specs/devlink.yaml
  1277:8    error    wrong indentation: expected 8 but found 7  (indentation)
  1279:8    error    wrong indentation: expected 8 but found 7  (indentation)
-- 
pw-bot: cr

