Return-Path: <linux-kselftest+bounces-34782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A41AD65D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 04:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836D8178066
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 02:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B55D1C1F13;
	Thu, 12 Jun 2025 02:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI1QDunI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B82028F1;
	Thu, 12 Jun 2025 02:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749696478; cv=none; b=aPrMTo8NJjqPuw5/JuQ+rWYUv/9XNpQEQ8vydzWTYgxqDQthxU36Lq3f/RERxqbAAXC1L5yeGJD5w8frRYiyopvEGENF7+eDyJ51cpgLWimf0n/8BxrtXkkduBQx4NhZsvlvmA4K3Csx2WGoL1Aptyn2vYDZiHP2wd9+7HdMdL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749696478; c=relaxed/simple;
	bh=V10y+YnoaiOhK9zGqmOgoWpQxvptlZXDaCPhJRexvHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPn1oVjQLj4Ryfg5rmKzeVhktGU0h6SWuxHSteWijD7dX2tRkASD0+kETaMVObZyK3vimMuTCOyyUfrSyUB1TMG6XJ1YExE4IVRcnNZgdh8IBvdt1ckqbC460i8AR92WUQNDlqlemZu2bSpDO+TUxd127YojH/CfWVxMADET9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI1QDunI; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-747ef5996edso564771b3a.0;
        Wed, 11 Jun 2025 19:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749696476; x=1750301276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=70dF3f186VX/2MCLOuJcDzIuL4GikkKOnVgxPnn7hR4=;
        b=KI1QDunIs8T6YzA8WQofRAXa96/I/4u1ape+ryA2pWF7AYrgC5PVkCd7f9zo9E/s4N
         Vo5ajw9kfIg9ggAEq+bL/6ask/Cbu0IrhLJWcEHZ3sjT6m7xffg6etAYEJEyUwSW+7Mo
         7wex3t+qzFSeQrEs57cStJoD8e2Or6IoQDCXhimn/ZG+4EFNwVbGUifg7WCpJDaleAAu
         bk7CXLRptA1yWeePuond9l33lGhD46JPjkHfErFt/lWEAvQBgsje3HRWaV5CLAGPloFs
         5AiHDFS7L/jV+AJ9gXpm/fRvLZrnTRry/SCd7mTBN4pGAzIUYVC2DeVH15s5F0qE+FWa
         DH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749696476; x=1750301276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70dF3f186VX/2MCLOuJcDzIuL4GikkKOnVgxPnn7hR4=;
        b=hpJsgYxVStfY0fmlgKMsDg4dBpgTI0uI5VaP1h3+8ys5KFYnrW/HvXnVseL3btts5Z
         JEd52lJC54pr1KNODeCAaKU15HLadCFiD3uGRu1EmRIyQhgyZX0gy3fXLYu9mUAaUs7W
         xQhrHRHJ4hbtDBXGokssq2CMyY3wOcd+97Mhtx0T60odTxxcjm6wntizjTQdnYT+UcUO
         Q79ReqCPSEstdbPgmy0KkUlN2VhynPJdPbWhMMquxlVeHsNjJH3I4UewT+6kbqExabqG
         0iOlJUC/7dvjgrlqUzce4bjbTj3WACd/hnvP4NE/oNHTYG2EO9t/8m41ROFxTpuLQrSZ
         XI1A==
X-Forwarded-Encrypted: i=1; AJvYcCVGEJY6/edg/sOWUUeLSD7N97rxGBlq48VN2rr5QS2OtRZ5SpDy0rYsyBa+eotwvs/PkFrWdCSxsaQL7vfpEqB0@vger.kernel.org, AJvYcCVlV+IBawa294HhqfkfNspirkIFDFXiOTr7pTBeyUE/WWr/j27e6dfxrCfsraZf7sAE4R89MuVbd+UmekA=@vger.kernel.org, AJvYcCVspWBRHWu2TCwbiODdUskYUQNg8hBbauPb/+tC83pqNCdTBKpkWBXAkoq4OtuD32ymhrh+rD86PcUjUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+mJDlc1aXeJzv2G0QCKI2wMGncdawjQv7F8ivlmgLj4qejom
	y5RuOqkoR9hz89XftVm+F7049ZrImSp1C5WEB+tj3QWtofaIKuwyT3D9ECWL
X-Gm-Gg: ASbGnctlrEicTsTcC/10yu3jJxARy2BZaKGylRGVZ4apOUJkenI7ukYz+zivjz9n5XO
	q9hXNkHfuRd2l3srLbWpJFhrWSWcaLFLA5XWZrwtAcEpr75AcrTRSBcETNOMiazGNZwr6750OZ3
	n0qxefNnCjgvWCBaDPXq3IYzpw9OBgjAI26p8pJom4ewM0o6YyQR7ZUvru47wd6WGJLQsiMAOfQ
	q8ie4N3W1CpuRUp9wteGfXLQtV4J8jF6HIBuXvt/f0V3fPlIwfBPXVyYxJYyeRCrijQz9m+N3sf
	nmhFjWrrUgC/dgGMKBiORalmrN9K7qAf1PX+OOvagE9qcjSddOHg9k6Xaf0tJheFm8SHOfJKGBS
	USA+xSxX5GBeUunQmPk9HRwQ=
X-Google-Smtp-Source: AGHT+IFRKiugap2uRP5iwvzv3ykxNxJY6sSKFAqSQYORKgyM6ljZEvpw3F28685FefjxRCqFHH0xZg==
X-Received: by 2002:a05:6a21:48d:b0:206:aa42:8e7c with SMTP id adf61e73a8af0-21f97800f84mr3290374637.18.1749696475840;
        Wed, 11 Jun 2025 19:47:55 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-748809d3066sm312312b3a.102.2025.06.11.19.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 19:47:55 -0700 (PDT)
Date: Wed, 11 Jun 2025 19:47:54 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, skalluru@marvell.com, manishc@marvell.com,
	andrew+netdev@lunn.ch, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	tariqt@nvidia.com, saeedm@nvidia.com, louis.peens@corigine.com,
	shshaikh@marvell.com, GR-Linux-NIC-Dev@marvell.com,
	ecree.xilinx@gmail.com, horms@kernel.org, dsahern@kernel.org,
	shuah@kernel.org, ruanjinjie@huawei.com, mheib@redhat.com,
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org, oss-drivers@corigine.com,
	linux-net-drivers@amd.com, linux-kselftest@vger.kernel.org,
	leon@kernel.org, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net-next v3 1/4] udp_tunnel: remove rtnl_lock dependency
Message-ID: <aEo_2hOn5kh6kBpk@mini-arch>
References: <20250610171522.2119030-1-stfomichev@gmail.com>
 <20250610171522.2119030-2-stfomichev@gmail.com>
 <20250611184345.3b403ad0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250611184345.3b403ad0@kernel.org>

On 06/11, Jakub Kicinski wrote:
> On Tue, 10 Jun 2025 10:15:19 -0700 Stanislav Fomichev wrote:
> > Drivers that are using ops lock and don't depend on RTNL lock
> > still need to manage it because udp_tunnel's RTNL dependency.
> > Introduce new udp_tunnel_nic_lock and use it instead of
> > rtnl_lock. Drop non-UDP_TUNNEL_NIC_INFO_MAY_SLEEP mode from
> > udp_tunnel infra (udp_tunnel_nic_device_sync_work needs to
> > grab udp_tunnel_nic_lock mutex and might sleep).
> 
> There are multiple entry points to this code, basically each member of
> struct udp_tunnel_nic_ops and the netdev notifiers. In this patch only
> reset and work are locked. I'm a bit confused as to what is the new
> lock protecting :S

I though that most of the callers are from do_setlink and there we have
rtnl and we grab rtnl+lock during the sync. But that doesn't
address the suspend/resume vs do_setlink race, that's true :-(

Did not look deep into the notifiers, assuming they are a way to push
the info down to the devices (under rtnl) plus trigger the sync work,
will take a closer look.

