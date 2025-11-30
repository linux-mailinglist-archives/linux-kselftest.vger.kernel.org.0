Return-Path: <linux-kselftest+bounces-46762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 647C4C9516A
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 16:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3CB8342F5A
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C386925B663;
	Sun, 30 Nov 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaSMLPse"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971B611CAF;
	Sun, 30 Nov 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764516739; cv=none; b=Kf5Fm0nmi0XVFZYinUI0z4c+gimH/QADbdG/gIietZZFhCDFRAQGtz7Rnf+ENgCAKKEtJs90xm6usFF5hA+9I3IhfO3E7GyXGps8Yp2+8h/INd6BNCuOn10Ch0BzdsIf9vwOiaRHLejTN2YLt/p6z4wGxFWH+9bhUGWeOUq3lZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764516739; c=relaxed/simple;
	bh=p+IcINGkE7o/qpfc5r72r1PikNhVaVliQpN1CO/8oEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCN263TebiC7HPss6J5hOcJoaysFRMV6GsE9v/k6nlg4bNBkK2BMmmZ+Ai5hyuXKwnKHUV18diSrESXxkLXuzYdP0dvrz4bPJxR73OUASpq12uYz8I9AVomsX7WpqdDXE1fJd+HMMWaNvHKhOP8IZT6sTfTq/RrGMM8S36W1KQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaSMLPse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3709BC4CEF8;
	Sun, 30 Nov 2025 15:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764516739;
	bh=p+IcINGkE7o/qpfc5r72r1PikNhVaVliQpN1CO/8oEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BaSMLPseGT3J33btq796EuvuCZgP9yg0WMweqfguvCKkuVtyU+lBpa/d1633xoTJH
	 /jwMFNoHCZj7RQ/QNb+gHBvxUs90p9Mu0KS5c9YStPbA8O4xTzDTofh0RWRJ9vfrF1
	 ecJ4E2sFuNsE9OoFK0KeUmga/8wscFmj1ts+QeuOUDCQDQwS6Er/MU51ETd0qcNXZJ
	 oTOXe7VF/T7XoDUntiyjRu9nxkbl3709e2m9jsJB8e/X0odVlQTS3jLqmC8p2RFEL+
	 cab96NiVPYgvRnC2ll1C2jNiIDPLTWcm0DPxeHu8w6Jx/+E2hSb/ewxGbgFdb79mm5
	 wsciKpW544WNQ==
Date: Sun, 30 Nov 2025 15:32:14 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org,
	kernel-team@meta.com
Subject: Re: [PATCH net-next 2/4] netconsole: Add configfs attribute for
 direct message sending
Message-ID: <aSxjfmcOPjHn1qWG@horms.kernel.org>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
 <20251128-netconsole_send_msg-v1-2-8cca4bbce9bc@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-netconsole_send_msg-v1-2-8cca4bbce9bc@debian.org>

On Fri, Nov 28, 2025 at 06:20:47AM -0800, Breno Leitao wrote:
> Add a new write-only configfs attribute "send_msg" to netconsole targets
> that allows sending arbitrary messages directly through netconsole.
> 
> This feature enables users to send custom messages through netconsole
> without having to go through the kernel logging infrastructure. Messages
> can be sent by simply writing to:
> /sys/kernel/config/netconsole/<target>/send_msg
> 
> The implementation:
> - Checks if the target is enabled before sending
> - Verifies the network interface is running
> - Handles both basic and extended message formats
> - Fragments large messages when needed for basic targets
> - Reuses existing send_msg_udp() and send_ext_msg_udp() functions
> 
> Unfortunately this patch has two forward declaration, which is not
> ideal, but, moving send_msg_udp() functions earlier would cause too many
> changes, and this could be done in an idependent patch.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


