Return-Path: <linux-kselftest+bounces-16407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4DA960D63
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 16:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEF86B218B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8737F1C3F2A;
	Tue, 27 Aug 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK4QCSQE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62833E8;
	Tue, 27 Aug 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768225; cv=none; b=jbax1e7Frpvtp807U4Ij88trVlU486qGnQd7E5aw4yijSDvDCUqXdvnr9BCwR3WqTO+j8n8+BioF0ii++h/ln43PFM3yjIGNW7XbjvysukTXuqW7v09qw1Q+9Me0fMwCzMz74Hxls3MtM5JZnaXshxEaNpBNtZ/PYAZv4ZoOO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768225; c=relaxed/simple;
	bh=97PoKtJnQqBKNmAFP5vJX4vqaKaugMDk8RUxSJ3MqhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjqUzV1Ohm4ZFvnaK+VOMVGu4B6Bj9IvkA7VsKOwi4znJ4v/fJAAgm4ooIaCndYWhiu+IgeT5wG1dtVkIVd4W/J7SXIsgYUhHdxsfLQhG5Bfn9zkn9fMIxVXX5wp9DadAC5xpaOwk9uVNEG6385OCy4Vx3br4MWyYqUP0aXIygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK4QCSQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC5AC581AA;
	Tue, 27 Aug 2024 14:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724768224;
	bh=97PoKtJnQqBKNmAFP5vJX4vqaKaugMDk8RUxSJ3MqhA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TK4QCSQElL6rxKQhCgfsfbQ87MQWuN/pmpFAa4hH2jPiXcZttzOB4yua2RW1OvOn3
	 V+GZWhNvCuNky4SyJMRVrEsyRj4V1YG52QFBfhjoButxa9DbJIHUwZyDfRVWcMfRW+
	 22RYeN+CFGo8RJaQQxkMHrCWEvYMPvzMlDPDX5vmtC65Xk2TeOT3sVXUQxv58uTQ/9
	 dhiS3rvtTrD3iyUw9U9MsbqiJoPofimMwpX/EN+CuH/q8xMI67RMNynmJ0OKZU71eU
	 wTLFOJUQEBup6NdvwqC2C83GigAiO1TN9tmk1EU5wB8UU7bGpuS4rAfZ37T4PEepN3
	 l1TCp/AIeNXWg==
Date: Tue, 27 Aug 2024 07:17:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Shuah Khan
 <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Amit Cohen
 <amcohen@nvidia.com>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 <mlxsw@nvidia.com>
Subject: Re: [RFC PATCH net-next 1/5] selftests: forwarding: Introduce
 deferred commands
Message-ID: <20240827071703.59401ed7@kernel.org>
In-Reply-To: <87jzg288sd.fsf@nvidia.com>
References: <cover.1724324945.git.petrm@nvidia.com>
	<d5f8364b42f277daa9e235d23398e3dce5549e92.1724324945.git.petrm@nvidia.com>
	<05b9caf6-ecf5-48a2-ab65-509b0d5b5fb0@intel.com>
	<87o75f8e0l.fsf@nvidia.com>
	<3312a4a6-97f5-4ae2-9527-c7b1b73da6d2@intel.com>
	<87jzg288sd.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 10:53:53 +0200 Petr Machata wrote:
> >> I can do it, but it's gonna be more pain in setting up those
> >> TEST_INCLUDES. People will forget. It will be a nuisance.
> >> I'm thinking of just moving it to net/lib.sh, from forwarding.  
> >
> > what about separate file, but included from net/lib.sh?  
> 
> Unfortunately that would be even worse. Then you need to remember to put
> the file into TEST_INCLUDES despite seemingly not using it.
> 
> Like ideally we'd have automation for this. But I don't know how to do that
> without actually parsing the bash files, and that's just asking for
> trouble. Maybe after the defer stuff we also need a module system :-/

FWIW we could throw it into net/lib, which has a fake target, see:

b86761ff6374 ("selftests: net: add scaffolding for Netlink tests in Python")

