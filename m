Return-Path: <linux-kselftest+bounces-34528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA96AAD2A63
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 01:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA31E3B1CE4
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 23:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF95D22A4F3;
	Mon,  9 Jun 2025 23:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmat6F0E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6531522A4D2;
	Mon,  9 Jun 2025 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749511179; cv=none; b=fA46qJrAF63shap1rR52vNfb6QUfN593EZWeEPdjapLznH8eO6PSadu7+Uz96aaUjiwmO/tbjDLnrZBxtzsCSiALw/x//KyjhVcJuXZeNW0iGZJqRjNKmpFfVFLjTC4a/KOR1TaX0OF96zOqx7ufXEGtl4ihLvculz1XAqfzfZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749511179; c=relaxed/simple;
	bh=6CFXk/D4tnr1yc6KzyuxGLm3bBJFXFB4G4mdk5f9TfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JC6B33+5euKs8yTy1BBg8iL6PcLdY4HEKBX1H3fZa8X+eTeWs3EDpSidR7O8vQRSLr3+fmW+oFvcids2IapOSPETMvIWw/aHfL1k9wocBgOTKu72D4RDdk8o+VOm7pZxNhRDWUooBkhMtQfpjafuA7boXhp64dqocqkF4qxka7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmat6F0E; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-234b9dfb842so42696175ad.1;
        Mon, 09 Jun 2025 16:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749511175; x=1750115975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WuMn2eerhCidgiefO3mm6DZg/epTXqNO4m++hNzNzoE=;
        b=jmat6F0ET7VBh1CUDPK1OH4r6FDErpWnfHzDvUYnFO1aL3WN8bCRXT9Varbwm0DiXq
         PL5PohCCjMODuqU8dhRFtIjVEwnU7p3nSfflSeDPGyU0XmskBVugQwaqEOtUzF4q2IPs
         PBhTtmIcjrLxa2jbDgxv4slFarBoRQvxfFVonkZuJb9PxsZ6f+EBOd5/UmchVrI7//Sq
         oaqDERNmcpLpxtgU/EekK6v5+93CwQ7KEmnKX3/7lYPEBXfCSiGGn/6OodyiubuP7QQs
         Juu4EZJM5TWPTd3fy0pFTccCG4cLPoXeEQjqOBEPsPW2qrV1vSoVQfs2eD1JWdZBw6hu
         Fiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749511175; x=1750115975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuMn2eerhCidgiefO3mm6DZg/epTXqNO4m++hNzNzoE=;
        b=J/ABf1ZkJDtR448AoaaIs4K6vU9FdK4WBP2roUDFIoykq0GK+zMiG/yjdZz7CR+XfX
         dAjNSvkSV85tL2bBybi7zE0T5vKSJabysS3Xs8b2/ZbqEAN54NjmC12reswGOgGsCv+m
         /RfloduwuzHPUUQt6IOD5XNtjY4ajUWS26TSjw6gPH90DGcJFrzdw05HMCMh15ImadAU
         2GI024WnjRM2j5aUH1rLqXswQ8S6R3bW2xttbiPqNcQnQCgu7gnY1TC44jcUq0FSsseb
         fZRgVk9JGLLznzJgY2eSMViZlSxJ2nUS9UFpkQy5pALQoUKTjGACnzAluQBmIKlEAw79
         E/EA==
X-Forwarded-Encrypted: i=1; AJvYcCUWH6edEfPG7tuJUghErMo01lRG05SgacgDlHDen2Xq7m1FRekrSRPHwqbKeJVI8Wv/pdEC/c1/Ezc8KVzBnbBU@vger.kernel.org, AJvYcCV4oZxdb0ABCJFMFoJ6DUNLz0KTMuvRl03XnhCSfHwC7QYrv6sdcJxCZuS7EaNkdImsI7cvqSGZcvCMWA==@vger.kernel.org, AJvYcCVaXnzSCq1NWY9V3jASoimySse9BOnElS9nDDO+Wssq2qYdCZ/N9yH/Kbx3fUSyHlRhJu5qg3m68ltUOCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw815ZonRIPF774nIDkft7BGRqrUcFnYYxXiafd3Fz9BkhUpPBp
	5hQhtH5Lmv2e7qvgToCke9xVrqumXr5H6qBnSf+SzwBoqekSKDcOk2I=
X-Gm-Gg: ASbGncuci/ak43ecATG/m4cXA0m5fsBEXP1q7DOLglmJqbgdWA1UUn6L6XaW8BDAOJB
	eZF/dI1Byjaa7DMU+J5xrS87O5s5c4ApxDZUuxZ7f3TQLznl2efHhmwNZpy7plWrt/p/p00GoCM
	9sW1U0cq9xYIuKgVS3kC0UbFhIc9c/StkLKBpiFutEJekeSmViOLKeCwqTbv+u1vTZBA7N2VX/e
	BU1TNnEaQVC4t8Pkz64vDmgnrXes/JRSZXX7O3iIo5feRmd0M1IUWolsdWVbipjMMukB5MtQQlB
	G/fKoa0soYGuC8l0PyFxbKdbz1QA/dB8XHTOYcujjlP9rPeek/PItQM29mVMytvAEJe+Zj9QmfT
	hvQkwGNIcq8RslwIgNT0A90MgpEC7mLiUgQ==
X-Google-Smtp-Source: AGHT+IEV8CpYnlOB2YnfAeL9gQJAXPfboUO10GUHaeUTiTj5LkmkPPvpLnBpPyH1TV/VU7MOCFUvRA==
X-Received: by 2002:a17:902:d2c6:b0:235:efbb:9539 with SMTP id d9443c01a7336-23601cfebb3mr204848925ad.17.1749511175460;
        Mon, 09 Jun 2025 16:19:35 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23603405fcdsm59911355ad.159.2025.06.09.16.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 16:19:35 -0700 (PDT)
Date: Mon, 9 Jun 2025 16:19:34 -0700
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
	shuah@kernel.org, mheib@redhat.com, ruanjinjie@huawei.com,
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org, oss-drivers@corigine.com,
	linux-net-drivers@amd.com, linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: Re: [PATCH net-next v2 0/4] udp_tunnel: remove rtnl_lock dependency
Message-ID: <aEdsBhZ4C--0ohYj@mini-arch>
References: <20250609162541.1230022-1-stfomichev@gmail.com>
 <20250609153817.14d7e762@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250609153817.14d7e762@kernel.org>

On 06/09, Jakub Kicinski wrote:
> On Mon,  9 Jun 2025 09:25:37 -0700 Stanislav Fomichev wrote:
> > Recently bnxt had to grow back a bunch of rtnl dependencies because
> > of udp_tunnel's infra. Add separate (global) mutext to protect
> > udp_tunnel state.
> 
> Appears to break the selftest, unfortunately:
> https://netdev.bots.linux.dev/contest.html?test=udp-tunnel-nic-sh&branch=net-next-2025-06-09--21-00

Argh, should have run it locally first :-(
Looks like there is a test that sets up pretty high sleep time (1 sec)
and expects entry to not appear during next 'ethtool --show-tunnels' run.

Gonna double check and remove the case if my understanding is correct.
Don't think there is much value in keeping the debugfs knob just for the
sake of this test? LMK if you disagree; otherwise gonna repost tomorrow.

