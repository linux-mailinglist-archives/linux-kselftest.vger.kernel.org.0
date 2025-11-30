Return-Path: <linux-kselftest+bounces-46761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71519C95158
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 16:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5F88342DC2
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7478238D54;
	Sun, 30 Nov 2025 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qv6+antv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873F211CAF;
	Sun, 30 Nov 2025 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764516726; cv=none; b=MS+YjmV7pEmWdyJXGv6JpiOEfXdWzB6tV5ewZNYzz7hmWGjdtJB1y+sN7chlkWrdj6aKUsFnuQ6Y/BauxK9cv6R6dzOaisGKIPlFE4Dy2gzX3PvtsUNmGmxdkhETYJIsBCWCJgEPNPt3fSHIzbTA2xvaJlRphb6uW+9aj5ecmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764516726; c=relaxed/simple;
	bh=+v37ZFnRpI26gmGtAldWuMLy9WzXy+R8dLfJjjhXMAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmvYsgCe6GbxoAL+ErYicXm3KcPVh/mGZDXljbhUXmQ1Oa4d44dXMzatlGk1rx02RfcCKO18x+3qSGmlWnMnpYh6r4OAe2nHe2GpIrPsQJRjFNUq5zKnsVlR/ietdwxU+pAnjXYOrBoa6x6Z9HUJztoLbz1/ToWxdUo/wZzeR8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qv6+antv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92184C4CEF8;
	Sun, 30 Nov 2025 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764516725;
	bh=+v37ZFnRpI26gmGtAldWuMLy9WzXy+R8dLfJjjhXMAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qv6+antvD92eu/NA1gKOYWat7Wa/wVj54+qy4n7YRjyOrma9W4QIRMgphwojK8A99
	 25tBdjJgAzzDimycgAXSUrBovY58tTwcuM6+YduRGFqhVlXsOf1MjZ+IqsRxWGZK3R
	 ukmOSd0nv4eCiyhgYPCwrJm6lmTohxamZO6YqA8DYdwrWduYNB6+YR2Al5xcT/OxS/
	 kAdS0QDIPkFLwbb205MPqzDb3FnD+O6Y83ZSytDHjragovSxqpsgklX58Vlgz7Ib15
	 ThEvifv/Pvryy8MQsvjxb03Z3Glw0g/NrBUL9+kXQG3ZTOlrMXzyGrxT77+GZTddtc
	 JKKF7UZ6Oe4dA==
Date: Sun, 30 Nov 2025 15:32:00 +0000
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
	kernel-team@meta.com, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH net-next 1/4] netconsole: extract message fragmentation
 into send_msg_udp()
Message-ID: <aSxjcAJCzlhLi4oN@horms.kernel.org>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
 <20251128-netconsole_send_msg-v1-1-8cca4bbce9bc@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-netconsole_send_msg-v1-1-8cca4bbce9bc@debian.org>

On Fri, Nov 28, 2025 at 06:20:46AM -0800, Breno Leitao wrote:
> Extract the message fragmentation logic from write_msg() into a
> dedicated send_msg_udp() function. This improves code readability
> and prepares for future enhancements.
> 
> The new send_msg_udp() function handles splitting messages that
> exceed MAX_PRINT_CHUNK into smaller fragments and sending them
> sequentially. This function is placed before send_ext_msg_udp()
> to maintain a logical ordering of related functions.
> 
> No functional changes - this is purely a refactoring commit.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Simon Horman <horms@kernel.org>


