Return-Path: <linux-kselftest+bounces-34779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F39AD6538
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 03:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B67F47A7901
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 01:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D20614D283;
	Thu, 12 Jun 2025 01:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSaj5qBT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B61487E9;
	Thu, 12 Jun 2025 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749692628; cv=none; b=e9gD/BbEcz4R5loXdasz8p+4MDoiPgPbWBu9KHhxflJX7DfX9m7y7i2CxsqD6Fk1uYS+ZjaCDav9xEF6NezRnfSzbuo08KjQ5kMa3PkenWR+9uHC67qQlEFoOy6tD0P9m/ExVWB1/+a0Y7G09eLfjDlpf9Bk2aXDJ2Ug8InlZNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749692628; c=relaxed/simple;
	bh=LjwFAIBoJN2DFCOZK3YQK/MaS7Ur4DjiuLDzXfrUQhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1eQFkbZc8S13BwFdHDmKVZPwZ50njS4mNY13ZuXMMpuq46/yrHJMz+UQ8sQO4tXFhmMOLfyIDOts9/gvoKNzLKbFkd6ndapssolgwDRB9JU+jf4DJtAoatrmGOjRUcsHwKISx1yuBAefqH8HB4diGHpbCMRO68nd8nudNsqRQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSaj5qBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F823C4CEE3;
	Thu, 12 Jun 2025 01:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749692627;
	bh=LjwFAIBoJN2DFCOZK3YQK/MaS7Ur4DjiuLDzXfrUQhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lSaj5qBTgjvlHyd9hDez5o6TNERrsmupKiHUlCAhlKg4ETATeVKt5W/jmAYbkfOEw
	 3CHzvNrBX5+udhVCa+fZNmW6GQPQ8s7XGYLVBxqUo598mZSUE4zwADcDKP3txgZgMT
	 2zKvnAgkHWpVmKlhNcJ95NhyE/PSNUCWbLV2tjKpqjxwWwmZAPazpmfU6+T8K3whlj
	 4RwgvEi3Rqmb0VuiPl1gcIeZIf+F2/0/sVIhLyPM/pEay/LGrVb0uNCJivCCoZzfPB
	 87UlI+Pudwnx66ZybIKu8CYxC+Bo0raVTtijIOO0susUCCJBT5DwX0NA9g+ekbiSwB
	 DtCzRXJhnIzvw==
Date: Wed, 11 Jun 2025 18:43:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, skalluru@marvell.com, manishc@marvell.com,
 andrew+netdev@lunn.ch, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 tariqt@nvidia.com, saeedm@nvidia.com, louis.peens@corigine.com,
 shshaikh@marvell.com, GR-Linux-NIC-Dev@marvell.com, ecree.xilinx@gmail.com,
 horms@kernel.org, dsahern@kernel.org, shuah@kernel.org,
 ruanjinjie@huawei.com, mheib@redhat.com, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 oss-drivers@corigine.com, linux-net-drivers@amd.com,
 linux-kselftest@vger.kernel.org, leon@kernel.org, Cosmin Ratiu
 <cratiu@nvidia.com>
Subject: Re: [PATCH net-next v3 1/4] udp_tunnel: remove rtnl_lock dependency
Message-ID: <20250611184345.3b403ad0@kernel.org>
In-Reply-To: <20250610171522.2119030-2-stfomichev@gmail.com>
References: <20250610171522.2119030-1-stfomichev@gmail.com>
	<20250610171522.2119030-2-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 10:15:19 -0700 Stanislav Fomichev wrote:
> Drivers that are using ops lock and don't depend on RTNL lock
> still need to manage it because udp_tunnel's RTNL dependency.
> Introduce new udp_tunnel_nic_lock and use it instead of
> rtnl_lock. Drop non-UDP_TUNNEL_NIC_INFO_MAY_SLEEP mode from
> udp_tunnel infra (udp_tunnel_nic_device_sync_work needs to
> grab udp_tunnel_nic_lock mutex and might sleep).

There are multiple entry points to this code, basically each member of
struct udp_tunnel_nic_ops and the netdev notifiers. In this patch only
reset and work are locked. I'm a bit confused as to what is the new
lock protecting :S

