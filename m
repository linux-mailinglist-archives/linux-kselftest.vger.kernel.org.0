Return-Path: <linux-kselftest+bounces-21901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064DD9C6431
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 23:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B721F265B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 22:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E41721A6EE;
	Tue, 12 Nov 2024 22:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlW0KoBH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2484521A4DC;
	Tue, 12 Nov 2024 22:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731450156; cv=none; b=S8GfkZI46YMzE1v+ohbev7qFxhndqObm+9u1honpDRPYrC3ZqgWn3FH1a9lL4I4jj0cdSQReOxpgklTYKKRPmgraggZgI2H//WF3SAobZwGPWTxxp17s/o0LVOE3jlrW3ErduUbzWbpD3MAXk8U/XrdAv+AGrHIsG8bxcug+hnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731450156; c=relaxed/simple;
	bh=bpnvZgynbZJWrVPSVnPx2nxPP7J6ZsKWQPKfECy9rNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nq6wLrMwC2j6ZyaiKims4vxAlguWOo6eRpZT2S1XJgebA71L7KmbR1JOeH5F3HAckOXunUHiFFZAasIm0SyyzgjTkuAXAbP+fHnfDJ+LUxbiRcARXCNPlh85AYEjqfV1508OLL+8HX+z6HkB8Jaf/NhoOyMi6ULUUc47THULX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlW0KoBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24395C4CECD;
	Tue, 12 Nov 2024 22:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731450155;
	bh=bpnvZgynbZJWrVPSVnPx2nxPP7J6ZsKWQPKfECy9rNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AlW0KoBHKGA7XXh4lhPlfzBzxMocAhRwvVAGeRrzisMBNkSJ4GIWMrrSitnPIqpKQ
	 g7XNBRafGf1DZFSu2+jbvxS/iy5DJgGESszChKjGCl/u3AVhsy89WSEcMBxvsAvz1B
	 DkKrUGgTzkf46S3FmyLr6hCBWfcndaek0QWGYzrB9jhh8Ohr3D4Pk/N7nkQ2Z9OvCY
	 Vyu7w23ILK7JmXAfvZyOd6Oh4riWC0IvHM/MIfruclKE0u2Cb8MGWv6XvHFvTmj8jq
	 5rIwKYlLX8Ix9iw6xivr3Vx4P+6I9U6DJpzF4jgsd3NoPuWW6+PKMZpanNhZo7smM3
	 L6esAPUeCTXkw==
Date: Tue, 12 Nov 2024 14:22:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Andy Roulin <aroulin@nvidia.com>,
 <mlxsw@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
 <shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
 <liuhangbin@gmail.com>, <linux-kselftest@vger.kernel.org>, Jiri Pirko
 <jiri@resnulli.us>
Subject: Re: [PATCH net-next v3 7/7] selftests: net: fdb_notify: Add a test
 for FDB notifications
Message-ID: <20241112142234.7abf2232@kernel.org>
In-Reply-To: <baf2abd6af2e88f8874d14c97da1554b7e7a710e.1731342342.git.petrm@nvidia.com>
References: <cover.1731342342.git.petrm@nvidia.com>
	<baf2abd6af2e88f8874d14c97da1554b7e7a710e.1731342342.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 18:09:01 +0100 Petr Machata wrote:
> Check that only one notification is produced for various FDB edit
> operations.
> 
> Regarding the ip_link_add() and ip_link_master() helpers. This pattern of
> action plus corresponding defer is bound to come up often, and a dedicated
> vocabulary to capture it will be handy. tunnel_create() and vlan_create()
> from forwarding/lib.sh are somewhat opaque and perhaps too kitchen-sinky,
> so I tried to go in the opposite direction with these ones, and wrapped
> only the bare minimum to schedule a corresponding cleanup.

Looks like it fails about half of the time :(

https://netdev.bots.linux.dev/flakes.html?min-flip=0&tn-needle=fdb-notify&br-cnt=200
-- 
pw-bot: cr

